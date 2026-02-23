unit unExportOperDataThread;

interface

uses
  Classes, unCommonFunc, unDBSupport, dmMain, dmReportsThread, SyncObjs, pFIBDatabase,
  DateUtils, SysUtils, Dialogs, Windows, dmReports, FIB, IdFTP, Xml.VerySimple,
  System.JSON, REST.Client, REST.Types, pFIBDataSet, pFIBScripter,
  pFIBStoredProc, pFIBQuery, VCL.Forms;

type
  TExportDataThread = class(TThread)
  private
    FSleepEvent: TSimpleEvent;
    FilesArr : array of String;
    db : TpFIBDatabase;
    tranMain: TpFIBTransaction;
    spRead: TpFIBDataSet;
    spCity: TpFIBDataSet;
    spScriptWrite : TpFIBScripter;
    spProc: TpFIBStoredProc;

    procedure DoUploadToFtp;
  protected
    procedure Execute; override;
    procedure PushToArr(filename : string);
    procedure DoUploadToMobile;
    function DoLoadFromMobile(token : String) : string;
  public
    TerminateImmediate : boolean;   // это значит поток был запущен перед закрытием программы
    DoNotProcessFirst : boolean;    // не отрабатывать поток сразу после запуска программы
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  unMobileUploadRoutine, UnECWID;


constructor TExportDataThread.Create;
begin
  FSleepEvent := TSimpleEvent.Create;
  inherited Create( False );
  ExportThreadExists := True;
  Priority := tpLower;
end;

destructor TExportDataThread.Destroy;
begin
  Terminate;
  FSleepEvent.SetEvent;
  inherited;
  FSleepEvent.Free;
  ExportThreadExists := False;
end;

procedure TExportDataThread.Execute;
var
  Connected, uploadSales, uploadArrivals : Boolean;
  fs: TFileStream;
  SL: TStringList;
  zakaz_old, sklad_old : Int64;
  head_filled : Boolean;
  tovarId, tovarIdOld, priceOld, catNameOld, totalOld, filename, PNT, resp : string;
  Xml: TXmlVerySimple;
  SalesNode, SaleNode, ItemNode, EntityNode: TXmlNode;
  ProductsNode, ProductNode, AmountNode : TXmlNode;
  YmlCatalogNode, OffersNode, ShopNode : TXmlNode;

  ECWID: TECWID;

  Kaspi_catalog, company, merchantid1, Offers: TXmlNode;
  Offer, model, brand, availabilities, cityprices: TXmlNode;
  availability, cityprice: TXmlNode;
  i, j, k: Integer;
  ID_Product: string;
  s: string;
  Amount: Double;

  procedure FTPExportKaspi(_File: string);
  var idFTP1 : TIdFTP;
  begin
    try
      try
        idFTP1 := TIdFTP.Create;

        idFTP1.Host := 'kaspi.shopuchet.kz';   //FTP-сервер
        idFTP1.Port := 21;                  //порт ФТП сервера
        idFTP1.Username := 'ftp_kaspi';
        idFTP1.Password := '%im8Jb23';
        IdFTP1.Passive := True;
        idFTP1.Connect;

        try
          idFTP1.MakeDir(merchantid);
          idFTP1.ChangeDir(merchantid);
        except
          idFTP1.ChangeDir(merchantid);
        end;

        IdFTP1.Put(_File, extractfilename(_File), false);
      finally
        idFTP1.Disconnect;
        idFTP1.Free;
      end;
    except
      on E: Exception do
        Log('Ошибка выгрузки файла для Kaspi магазина на ftp сервер. Детали: ' + E.message);
    end;
  end;
begin
  while not Terminated do begin
    if DoNotProcessFirst = False then begin
      if not (DirectoryExists(ExportPath)) and (UploadToMobile = false) then begin
        MessageBox(GetDesktopWindow, PChar('Включен сервис "Выгрузка оперативных данных", но ресурса "' + ExportPath + '" для сохранения '+
        'данных не существует!' + #10#13 + 'Переопределите папку для сохранения '+
        'в меню "Сервис - Выгрузка опер. данных"!' + #10#13 + 'Сервис будет временно ОТКЛЮЧЕН!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
        Terminate;
        Exit;
      end;

      Log('Начало выгрузки данных.');

      //=========================================
      // Создаю компоненты
      db := TpFIBDatabase.Create(nil);
      db.LibraryName := 'fbclient.dll';
      db.SQLDialect := 3;
      db.ConnectParams.CharSet := 'win1251';
      db.DefaultTransaction := tranMain;

      tranMain := TpFIBTransaction.Create(nil);
      tranMain.DefaultDatabase := db;

      spRead := TpFIBDataSet.Create(nil);
      spRead.Database := db;
      spRead.Transaction := tranMain;
      spRead.UpdateTransaction := tranMain;

      spCity := TpFIBDataSet.Create(nil);
      spCity.Database := db;
      spCity.Transaction := tranMain;
      spCity.UpdateTransaction := tranMain;

      spScriptWrite := TpFIBScripter.Create(nil);
      spScriptWrite.Database := db;
      spScriptWrite.Transaction := tranMain;

      spProc := TpFIBStoredProc.Create(nil);
      spProc.Database := db;
      spProc.Transaction := tranMain;

      ReportsThreadDM.spReport.Database := db;
      ReportsThreadDM.spReport.Transaction := tranMain;
      ReportsThreadDM.spReport.UpdateTransaction := tranMain;
      ReportsThreadDM.qLoadReport.Database := db;
      ReportsThreadDM.qLoadReport.Transaction := tranMain;
      ReportsThreadDM.qLoadReport.UpdateTransaction := tranMain;

      ReportsThreadDM.spGetProductList.Database := db;
      ReportsThreadDM.spGetProductList.Transaction := tranMain;
      // конец создания компонентов
      //=========================================

      uploadSales := (Copy(ExportDataType, 5, 1) = '1') or (Copy(ExportDataTypeFtp, 5, 1) = '1');
      uploadArrivals := (Copy(ExportDataType, 6, 1) = '1') or (Copy(ExportDataTypeFtp, 6, 1) = '1');

      try
        Connected := unDBSupport.ConnectToFB(db, '');

        if not Connected then
          Exit;

        if uploadSales or uploadArrivals or UploadToMobile then begin
          try
            spScriptWrite.Script.Text := 'UPDATE SYNC_EXT_APP SET IS_LOADING = 1';
            resp := ExecScript(spScriptWrite, true);
            if resp <> '' then begin
              Log('Ошибка подготовки данных. PNT: 01. ' + resp);
              exit;
            end;

            // в общем при изменении/удалении данных бывают коллизии и возникают дубли записей с одинаковым ID.
            // буду тут зачищать перед отправкой
            // а возникает потому что на момент вставки новой записи с новой операцией, например редактирование, запись с таким  ID
            // есть, но с признаком IS_LOADING = 1, потом в момент выгрузки происходит ошибка и запись опять становится с IS_LOADING = 0
            // и получаются две записи с одинаковым ID, но разным типом операции, потом на сервере из-за этого ошибка
            { СТАРЫЙ ВАРИАНТ НЕ УЧИТЫВАЛ, ЕСЛИ ДВЕ ЗАПИСИ С ОДИНАКОВЫМ ID И ОДИНАКОВЫМ ТИПОМ ОПЕРАЦИИ
            spScriptWrite.Script.Text := 'DELETE FROM SYNC_EXT_APP '+
                                         'WHERE SYNC_EXT_APP IN (SELECT AP.SYNC_EXT_APP '+
                                                                 'FROM SYNC_EXT_APP AP '+
                                                                'WHERE AP.IS_LOADING = 1 '+
                                                                  'AND AP.OPER = 1 '+
                                                                  'AND EXISTS (SELECT 1 FROM SYNC_EXT_APP APP WHERE APP.IS_LOADING = 1 AND APP.OPER IN (2,3) AND APP.ID = AP.ID) '+
                                                               'UNION ALL '+
                                                               'SELECT AP.SYNC_EXT_APP '+
                                                                 'FROM SYNC_EXT_APP AP '+
                                                                'WHERE AP.IS_LOADING = 1 '+
                                                                  'AND AP.OPER = 2 '+
                                                                  'AND EXISTS (SELECT 1 FROM SYNC_EXT_APP APP WHERE APP.IS_LOADING = 1 AND APP.OPER = 3 AND APP.ID = AP.ID) '+
                                                              ')'; }
            spScriptWrite.Script.Text := 'DELETE FROM SYNC_EXT_APP '+
                                         'WHERE SYNC_EXT_APP IN ( '+
                                                                  'SELECT AP.SYNC_EXT_APP '+
                                                                    'FROM SYNC_EXT_APP AP '+
                                                                  'WHERE AP.IS_LOADING = 1 '+
                                                                    'AND EXISTS (SELECT AP1.ID '+
                                                                                  'FROM SYNC_EXT_APP AP1 '+
                                                                                 'WHERE AP1.IS_LOADING = 1 '+
                                                                                   'AND AP1.ID = AP.ID '+
                                                                                 'GROUP BY AP1.ID '+
                                                                                 'HAVING COUNT(AP1.ID) > 1) '+
                                                                    'AND AP.SYNC_EXT_APP <> ( '+
                                                                                              'SELECT MAX(APP.SYNC_EXT_APP) '+
                                                                                                'FROM SYNC_EXT_APP APP '+
                                                                                               'WHERE APP.IS_LOADING = 1 '+
                                                                                                 'AND APP.ID = AP.ID '+
                                                                                           ') '+
                                                                ')';

            resp := ExecScript(spScriptWrite, true);
            if resp <> '' then begin
              Log('Ошибка подготовки данных. PNT: 01a. ' + resp);
              exit;
            end;
          except
            on E: Exception do begin
              Log('Ошибка подготовки данных. PNT: 01. ' + resp);
              Exit;
            end;
          end;
        end;

        if (Copy(ExportDataType, 1, 1) = '1') or (Copy(ExportDataTypeFtp, 1, 1) = '1') then begin
          ReportsThreadDM.PrepareReport(7);
          ReportsThreadDM.spReport.ParamByName('date_begin_').AsDate := Now;
          ReportsThreadDM.spReport.ParamByName('date_end_').AsDate := Now;
          ReportsThreadDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
          ReportsThreadDM.ShowReport(ExportPath + 'Продажи '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');

          if Copy(ExportDataTypeFtp, 1, 1) = '1' then
            PushToArr(ExportPath + 'Продажи '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
        end;

        if (Copy(ExportDataType, 2, 1) = '1') or (Copy(ExportDataTypeFtp, 2, 1) = '1') then begin
          ReportsThreadDM.PrepareReport(12);
          ReportsThreadDM.spReport.ParamByName('INCLUDE_NOL_').AsInteger := 0;
          ReportsThreadDM.spReport.ParamByName('INCLUDE_FEW_').AsInteger := 0;
          ReportsThreadDM.spReport.ParamByName('SORT_BY_NAME_').AsInteger := 0;
          ReportsThreadDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
          ReportsThreadDM.ShowReport(ExportPath + 'Остатки товаров '+ CurSkladName +' на ' + DateToStr(Date) + '.xls');

          if Copy(ExportDataTypeFtp, 2, 1) = '1' then
            PushToArr(ExportPath + 'Остатки товаров '+ CurSkladName +' на ' + DateToStr(Date) + '.xls');
        end;

        if (Copy(ExportDataType, 3, 1) = '1') or (Copy(ExportDataTypeFtp, 3, 1) = '1') then begin
          try
            tovarIdOld := '';
            priceOld   := '';
            catNameOld := '';
            totalOld   := '';

            Xml := TXmlVerySimple.Create;
            ProductsNode := Xml.AddChild('PRODUCTS');
            ReportsThreadDM.spGetProductList.ParamByName('ITEKA_').AsInteger := 0;

            ReadSP(ReportsThreadDM.spGetProductList);
            with ReportsThreadDM.spGetProductList do begin
              First;
              while not Eof do begin
                if (ReportsThreadDM.spGetProductList.FieldByName('g_product').AsString <> tovarIdOld) or (tovarIdOld = '') then begin
                  if tovarIdOld <> '' then begin
                    EntityNode := AmountNode.AddChild('TOTAL');
                    EntityNode.Text := totalOld;

                    EntityNode := ProductNode.AddChild('PRICE');
                    EntityNode.Text := priceOld;
                    EntityNode := ProductNode.AddChild('CATEGORY');
                    EntityNode.Text := catNameOld;
                  end;

                  ProductNode := ProductsNode.AddChild('PRODUCT');
                  EntityNode := ProductNode.AddChild('BARCODE');
                  EntityNode.Text := FieldByName('barcode').AsString;
                  EntityNode := ProductNode.AddChild('ARTICUL');
                  EntityNode.Text := FieldByName('ARTICUL').AsString;
                  EntityNode := ProductNode.AddChild('NAME');
                  EntityNode.Text := FieldByName('NAME').AsString;

                  AmountNode := ProductNode.AddChild('AMOUNT');
                  EntityNode := AmountNode.AddChild('SKLAD');
                  EntityNode.Text := FieldByName('TOCHKA_NAME').AsString;
                  EntityNode := AmountNode.AddChild('AMOUNT_CUR');
                  EntityNode.Text := FieldByName('AMOUNT').AsString;
                end else begin
                  EntityNode := AmountNode.AddChild('SKLAD');
                  EntityNode.Text := FieldByName('TOCHKA_NAME').AsString;
                  EntityNode := AmountNode.AddChild('AMOUNT_CUR');
                  EntityNode.Text := FieldByName('AMOUNT').AsString;
                end;

                tovarIdOld := FieldByName('G_PRODUCT').AsString;
                totalOld   := FieldByName('TOTAL').AsString;
                priceOld   := FieldByName('PRICE').AsString;
                catNameOld := FieldByName('CAT_NAME').AsString;
                Next;
              end;
            end;

            filename := ExportPath + GetDateTime2 + '.xml';
            Xml.SaveToFile(filename);

            if Copy(ExportDataTypeFtp, 3, 1) = '1' then
              PushToArr(filename);
          finally
            Xml.Free;
            ReportsThreadDM.spGetProductList.Close;
          end;
        end;

        if (Copy(ExportDataType, 4, 1) = '1') or (Copy(ExportDataTypeFtp, 4, 1) = '1') then begin
          ReportsThreadDM.PrepareReport(46);
          ReportsThreadDM.spReport.ParamByName('date_begin_').AsDate := Now;
          ReportsThreadDM.spReport.ParamByName('date_end_').AsDate := Now;
          ReportsThreadDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
          ReportsThreadDM.ShowReport(ExportPath + 'Прибыль '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
          if Copy(ExportDataTypeFtp, 4, 1) = '1' then
            PushToArr(ExportPath + 'Прибыль '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
        end;

        // ================================================================================
        // ВЫГРУЗКА ПРОДАЖИ И ПРИХОДОВ
        // надо сначала смотреть - есть ли что выгружать, но пока не буду этого делать
        IF (uploadSales) OR (uploadArrivals) THEN BEGIN

          // продажи в формате XML
          if uploadSales then begin
            spRead.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_)';
            spRead.ParamByName('OBJECT_TYPE_').AsInteger := 1;
            resp := ReadSP(spRead);
            if resp <> '' then begin
              Log('Ошибка чтения списка продаж для выгрузки в XML. ' + resp);
              Exit;
            end;

            if spRead.RecordCount > 0 then begin
              // 04.11.2020 теперь удаление будет в самом конце, после выгрузки в мобильное приложение
              //ReportsThreadDM.spUniversalWrite.SelectSQL.Text := 'DELETE FROM SYNC_EXT_APP WHERE SYNC_EXT_APP = :SYNC_EXT_APP_';
              Xml := TXmlVerySimple.Create;
              try
                try
                  PNT := '01';

                  SalesNode := Xml.AddChild('Sales');
                  with spRead do begin
                    First;
                    zakaz_old := FieldByName('ZAKAZ').AsLargeInt;
                    head_filled := false;

                    while not Eof do begin
                      if zakaz_old <> FieldByName('ZAKAZ').AsLargeInt then
                        head_filled := false;

                      if not head_filled then begin
                        PNT := '02';
                        head_filled := True;
                        SaleNode := SalesNode.AddChild('Sale');
                        EntityNode := SaleNode.AddChild('Oper');
                        EntityNode.Text := FieldByName('OPER').AsString;
                        EntityNode := SaleNode.AddChild('Code');
                        EntityNode.Text := FieldByName('ZAKAZ').AsString;
                        EntityNode := SaleNode.AddChild('Date');
                        EntityNode.Text := FieldByName('Z_DATE').AsString;
                        EntityNode := SaleNode.AddChild('ClientId');
                        EntityNode.Text := FieldByName('CLIENT_ID').AsString;
                        EntityNode := SaleNode.AddChild('Client');
                        EntityNode.Text := FieldByName('CLIENT_NAME').AsString;
                        EntityNode := SaleNode.AddChild('ClientIDN');
                        EntityNode.Text := FieldByName('IDN').AsString;
                        EntityNode := SaleNode.AddChild('Sklad');
                        EntityNode.Text := FieldByName('SKLAD_NAME').AsString;
                        EntityNode := SaleNode.AddChild('SummCash');
                        EntityNode.Text := FieldByName('SUMM_CASH').AsString;
                        EntityNode := SaleNode.AddChild('SummNonCash');
                        EntityNode.Text := FieldByName('SUMM_NONCASH').AsString;
                        EntityNode := SaleNode.AddChild('SummSert');
                        EntityNode.Text := FieldByName('SUMM_SERT').AsString;
                      end;

                      PNT := '03';
                      EntityNode := SaleNode.AddChild('Items');
                      ItemNode := EntityNode.AddChild('Item');
                      EntityNode := ItemNode.AddChild('Articul');
                      EntityNode.Text := FieldByName('ARTICUL').AsString;
                      EntityNode := ItemNode.AddChild('Barcode');
                      EntityNode.Text := FieldByName('BARCODE').AsString;
                      EntityNode := ItemNode.AddChild('Nomenclatur');
                      EntityNode.Text := FieldByName('NOMENCLATUR_NUM').AsString;
                      EntityNode := ItemNode.AddChild('Name');
                      EntityNode.Text := FieldByName('TOVAR_NAME').AsString;
                      EntityNode := ItemNode.AddChild('Quantity');
                      EntityNode.Text := FieldByName('AMOUNT').AsString;
                      EntityNode := ItemNode.AddChild('Price');
                      EntityNode.Text := FieldByName('PRICE').AsString;
                      EntityNode := ItemNode.AddChild('Summ');
                      EntityNode.Text := FieldByName('SUMM').AsString;

                      zakaz_old := FieldByName('ZAKAZ').AsLargeInt;
                      Next;
                    end;
                  end;

                  PNT := '04';
                  filename := ExportPath + 'sales' + GetDateTime2 + '.xml';
                  Xml.SaveToFile(filename);

                  if Copy(ExportDataTypeFtp, 5, 1) = '1' then
                    PushToArr(filename);

                  PNT := '05';
                  spScriptWrite.Script.Text := 'UPDATE SYNC_EXT_APP SET IS_LOADED = 1 WHERE IS_LOADING = 1 ' +
                    'AND IS_LOADED = 0 AND OBJECT_TYPE = 1';
                  resp := ExecScript(spScriptWrite, true);
                  if resp <> '' then begin
                    Log('Ошибка выгрузки продаж в XML. PNT: ' + PNT + '. Детали: ' + resp);
                    exit;
                  end;

                except
                  on E: Exception do
                    Log('Ошибка выгрузки продаж в XML. PNT: ' + PNT + '. Детали: ' + E.message);
                end;
              finally
                Xml.Free;
              end;
            end;
            spRead.Close;
          end;

          // приходы в формате XML
          if uploadArrivals then begin
            spRead.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_)';
            spRead.ParamByName('OBJECT_TYPE_').AsInteger := 2;
            resp := ReadSP(spRead);
            if resp <> '' then begin
              Log('Ошибка чтения списка приходов для выгрузки в XML. ' + resp);
              Exit;
            end;

            if spRead.RecordCount > 0 then begin
              Xml := TXmlVerySimple.Create;
              try
                try
                  PNT := '01';

                  SalesNode := Xml.AddChild('Arrivals');
                  with spRead do begin
                    First;
                    zakaz_old := FieldByName('ZAKAZ').AsLargeInt;
                    head_filled := false;

                    while not Eof do begin
                      if zakaz_old <> FieldByName('ZAKAZ').AsLargeInt then
                        head_filled := false;

                      if not head_filled then begin
                        PNT := '02';
                        head_filled := True;
                        SaleNode := SalesNode.AddChild('Arrival');
                        EntityNode := SaleNode.AddChild('Oper');
                        EntityNode.Text := FieldByName('OPER').AsString;
                        EntityNode := SaleNode.AddChild('Code');
                        EntityNode.Text := FieldByName('ZAKAZ').AsString;
                        EntityNode := SaleNode.AddChild('Date');
                        EntityNode.Text := FieldByName('Z_DATE').AsString;
                        EntityNode := SaleNode.AddChild('ProviderId');
                        EntityNode.Text := FieldByName('CLIENT_ID').AsString;
                        EntityNode := SaleNode.AddChild('Provider');
                        EntityNode.Text := FieldByName('CLIENT_NAME').AsString;
                        EntityNode := SaleNode.AddChild('ProviderIDN');
                        EntityNode.Text := FieldByName('IDN').AsString;
                        EntityNode := SaleNode.AddChild('Sklad');
                        EntityNode.Text := FieldByName('SKLAD_NAME').AsString;
                        EntityNode := SaleNode.AddChild('SummCash');
                        EntityNode.Text := FieldByName('SUMM_CASH').AsString;
                        EntityNode := SaleNode.AddChild('SummNonCash');
                        EntityNode.Text := FieldByName('SUMM_NONCASH').AsString;
                        EntityNode := SaleNode.AddChild('SummSert');
                        EntityNode.Text := FieldByName('SUMM_SERT').AsString;
                        EntityNode := SaleNode.AddChild('Type');
                        EntityNode.Text := FieldByName('RTYPE').AsString;
                      end;

                      PNT := '03';
                      EntityNode := SaleNode.AddChild('Items');
                      ItemNode := EntityNode.AddChild('Item');
                      EntityNode := ItemNode.AddChild('Articul');
                      EntityNode.Text := FieldByName('ARTICUL').AsString;
                      EntityNode := ItemNode.AddChild('Barcode');
                      EntityNode.Text := FieldByName('BARCODE').AsString;
                      EntityNode := ItemNode.AddChild('Nomenclatur');
                      EntityNode.Text := FieldByName('NOMENCLATUR_NUM').AsString;
                      EntityNode := ItemNode.AddChild('Name');
                      EntityNode.Text := FieldByName('TOVAR_NAME').AsString;
                      EntityNode := ItemNode.AddChild('Quantity');
                      EntityNode.Text := FieldByName('AMOUNT').AsString;
                      EntityNode := ItemNode.AddChild('Price');
                      EntityNode.Text := FieldByName('PRICE').AsString;
                      EntityNode := ItemNode.AddChild('Summ');
                      EntityNode.Text := FieldByName('SUMM').AsString;

                      zakaz_old := FieldByName('ZAKAZ').AsLargeInt;

                      Next;
                    end;
                  end;

                  PNT := '04';
                  filename := ExportPath + 'arrival' + GetDateTime2 + '.xml';
                  Xml.SaveToFile(filename);

                  if Copy(ExportDataTypeFtp, 5, 1) = '1' then
                    PushToArr(filename);

                  PNT := '05';
                  spScriptWrite.Script.Text := 'UPDATE SYNC_EXT_APP SET IS_LOADED = 1 WHERE IS_LOADING = 1 ' +
                    'AND IS_LOADED = 0 AND OBJECT_TYPE = 2';
                  resp := ExecScript(spScriptWrite, true);
                  if resp <> '' then begin
                    Log('Ошибка выгрузки приходов в XML. PNT: ' + PNT + '. ' + resp);
                    exit;
                  end;

                except
                  on E: Exception do
                    Log('Ошибка выгрузки приходов в XML. PNT: ' + PNT + '. Детали: ' + E.message);
                end;
              finally
                Xml.Free;
              end;
            end;
            spRead.Close;
          end;
        END;
        // КОНЕЦ ВЫГРУЗКА ПРОДАЖИ И ПРИХОДОВ
        // ================================================================================

        // ФАЙЛ ДЛЯ I-TEKA
        if (Copy(ExportDataTypeFtp, 7, 1) = '1') then begin
          try
            Xml := TXmlVerySimple.Create;
            YmlCatalogNode := Xml.AddChild('yml_catalog');
            YmlCatalogNode.Attributes['date'] := GetDateTime3;
            YmlCatalogNode.Attributes['price_list_type'] := '1';
            ShopNode := YmlCatalogNode.AddChild('shop');
            ItemNode := ShopNode.AddChild('company');
            ItemNode.Text := 'Test';
            EntityNode := ItemNode.AddChild('currencies');
            ItemNode := EntityNode.AddChild('currency');
            ItemNode.Attributes['id'] := 'KZT';
            ItemNode.Attributes['rate'] := '1';
            OffersNode := YmlCatalogNode.AddChild('offers');

            ReportsThreadDM.spGetProductList.ParamByName('ITEKA_').AsInteger := 1;
            ReportsThreadDM.spGetProductList.ParamByName('G_TOCHKA_').AsInt64 := ItekaTochka;
            ReadSp(ReportsThreadDM.spGetProductList);

            with ReportsThreadDM.spGetProductList do
            begin
              First;
              while not Eof do
              begin
                ProductNode := OffersNode.AddChild('offer');
                ProductNode.Attributes['id'] := FieldByName('g_product').AsString;
                ProductNode.Attributes['type'] := 'medicine';
                EntityNode := ProductNode.AddChild('name');
                EntityNode.Text := FieldByName('NAME').AsString;
                EntityNode := ProductNode.AddChild('price');
                EntityNode.Text := FieldByName('PRICE').AsString;
                EntityNode := ProductNode.AddChild('country_of_origin');
                EntityNode.Text := FieldByName('MF_COUNTRY').AsString;
                EntityNode := ProductNode.AddChild('vendor');
                EntityNode := ProductNode.AddChild('count');
                EntityNode.Text := FieldByName('AMOUNT').AsString;
                EntityNode := ProductNode.AddChild('offer_id');
                EntityNode.Text := FieldByName('ARTICUL').AsString;
                Next;
              end;
            end;
            // перед сохранением надо удалить файлы которые там есть, чтобы просто так
            // не скапливалась лишняя куча файлов, ведь нужны только остатки последние
            DeleteFilesFromFolder(ExportPath, ExportFtpLogin + '_0_');

            filename := ExportPath + ExportFtpLogin + '_0_' + GetDateTime2 + '.xml';
            Xml.SaveToFile(filename);

            PushToArr(filename);
          finally
            //fs.Free;
            //SL.Free;
            Xml.Free;
            ReportsThreadDM.spGetProductList.Close;
          end;
        end;

        //делаю выгрузку на сервер FTP
        try
          if (UploadToFtp = True) and (High(FilesArr) > -1) then begin
            Log('Начало выгрузки файлов по FTP.');

            DoUploadToFtp;
          end;
        except
          on E: Exception do
            Log('Ошибка выгрузки файлов по FTP. Детали: ' + E.Message);
        end;

        //Kaspi_Shop
        //Выбор точек продаж
        try
          if (ExportKaspi) and (isProKey) then //Если настроена выгрузка в каспий магазин
          begin
            case IDSKU of
              0: ID_Product := 'T.G_PRODUCT';
              1: ID_Product := 'T.ARTICUL';
              2: ID_Product := 'T.BARCODE';
              else
                ID_Product := 'T.G_PRODUCT';
            end;

            spRead.Close;
            {spRead.SelectSQL.Text := 'SELECT '+ID_Product+' IDProd, t.brand, T.NAME, t.g_product '+
              'FROM G_PRODUCT T '+
              'LEFT OUTER JOIN (SELECT G_PRODUCT, AMOUNT, NAME, L.g_tochka '+
              'FROM LT_SKLAD_PRODUCT L,G_TOCHKA GT WHERE L.G_TOCHKA = GT.G_TOCHKA) LT ON T.G_PRODUCT = LT.G_PRODUCT '+
              'WHERE T.IS_ACTIVE = 1 AND T.IS_CATEGORY = 0 and LT.AMOUNT>0 AND T.IS_KASPI_SHOP = 1' +
              'group by '+ID_Product+', t.brand, T.NAME, t.g_product '+
              'ORDER BY 2, 3';}
            spRead.SelectSQL.Text := 'SELECT '+ID_Product+' IDProd, t.brand, T.NAME, t.g_product '+
                  'FROM G_PRODUCT T '+
                  'LEFT OUTER JOIN (SELECT G_PRODUCT, AMOUNT, AMOUNT_RESERVE, NAME, L.g_tochka '+
                  'FROM LT_SKLAD_PRODUCT L,G_TOCHKA GT WHERE L.G_TOCHKA = GT.G_TOCHKA) LT ON T.G_PRODUCT = LT.G_PRODUCT '+
                  'INNER JOIN (SELECT c.name as City, t.name as Tochka, p.adress, '+
                  'p.idpoint, p.idcity, p.g_tochka '+
                  'from kaspi_city c inner join kaspi_point P on c.id=p.idcity inner join g_tochka '+
                  'T on p.g_tochka=t.g_tochka) KS on lt.g_tochka = KS.g_tochka '+
                  'WHERE T.IS_ACTIVE = 1 AND T.IS_CATEGORY = 0 and (LT.AMOUNT - LT.AMOUNT_RESERVE) > 0 AND T.IS_KASPI_SHOP = 1' +
                  'group by '+ID_Product+', t.brand, T.NAME, t.g_product '+
                  'ORDER BY 2, 3';

            resp := ReadSP(spRead);
            if resp <> '' then begin
              Log('Ошибка чтения списка товаров для выгрузки в XML для Каспий магазина. ' + resp);
              Exit;
            end;

            if spRead.RecordCount > 0 then
            begin
              try
                Xml := TXmlVerySimple.Create;
                Kaspi_catalog := Xml.AddChild('kaspi_catalog');
                Kaspi_catalog.Attributes['date'] := 'string';
                Kaspi_catalog.Attributes['xmlns'] := 'kaspiShopping';
                Kaspi_catalog.Attributes['xmlns:xsi'] := 'http://www.w3.org/2001/XMLSchema-instance';
                Kaspi_catalog.Attributes['xsi:schemaLocation'] := 'kaspiShopping http://kaspi.kz/kaspishopping.xsd';

                company := Kaspi_catalog.AddChild('company');
                ReportsDM.spRekvizit.Open;
                company.Text := ReportsDM.spRekvizit.FieldByName('NAME').AsWideString;
                ReportsDM.spRekvizit.Close;
                merchantid1 := Kaspi_catalog.AddChild('merchantid');
                merchantid1.Text := merchantid;


                Offers := Kaspi_catalog.AddChild('offers');

                spCity.Close;
                spCity.SelectSQL.Text := 'SELECT  T.PRICE,ks.idcity,ks.adress '+
                  'FROM G_PRODUCT T '+
                  'LEFT OUTER JOIN (SELECT G_PRODUCT, AMOUNT, NAME, L.g_tochka '+
                  'FROM LT_SKLAD_PRODUCT L,G_TOCHKA GT WHERE L.G_TOCHKA = GT.G_TOCHKA) LT ON T.G_PRODUCT = LT.G_PRODUCT '+
                  'INNER JOIN (SELECT c.name as City, t.name as Tochka, p.adress, '+
                  'p.idpoint, p.idcity, p.g_tochka '+
                  'from kaspi_city c inner join kaspi_point P on c.id=p.idcity inner join g_tochka '+
                  'T on p.g_tochka=t.g_tochka) KS on lt.g_tochka = KS.g_tochka '+
                  'WHERE T.G_PRODUCT= :G_Product AND T.IS_ACTIVE = 1 AND T.IS_CATEGORY = 0 and LT.AMOUNT>0';
                spRead.First;
                while not spRead.Eof do
                begin
                  Offer := Offers.AddChild('offer');
                  Offer.Attributes['sku'] := spRead.FieldByName('IDProd').AsWideString;
                  model := Offer.AddChild('model');
                  model.Text := spRead.FieldByName('NAME').AsWideString;
                  if Trim(spRead.FieldByName('brand').AsWideString) <> EmptyStr then
                  begin
                    brand := Offer.AddChild('brand');
                    brand.Text := spRead.FieldByName('brand').AsWideString;
                  end;

                  spCity.Close;
                  spCity.ParamByName('G_Product').AsInt64 := spRead.FieldByName('G_PRODUCT').AsLargeInt;
                  spCity.Open;
                  if spCity.RecordCount>0 then
                  begin
                    spCity.First;
                    while not spCity.Eof do
                    begin
                      availabilities := Offer.AddChild('availabilities');
                      availability := availabilities.AddChild('availability');
                      availability.Attributes['available'] := 'yes';
                      availability.Attributes['storeId'] := spCity.FieldByName('adress').AsWideString;
                      cityprices := Offer.AddChild('cityprices');
                      cityprice := cityprices.AddChild('cityprice');
                      cityprice.Text := IntToStr(Round(spCity.FieldByName('PRICE').AsInteger));
                      cityprice.Attributes['cityId'] := spCity.FieldByName('idcity').AsWideString;
                      spCity.Next;
                    end;
                  end;
                  spRead.Next;
                end;

                if FileExists(ExportPath + 'Kaspi_Shop.xml') then
                  DeleteFile(PWideChar(ExportPath + 'Kaspi_Shop.xml'));

                xml.SaveToFile(ExportPath + 'Kaspi_Shop.xml');
                FTPExportKaspi(ExportPath + 'Kaspi_Shop.xml');
              finally
                Xml.Free;
              end;
            end;
          spRead.Close;
          end;
        except
          on E: Exception do
            Log('Ошибка выгрузки данных в Kaspi магазин. Детали: ' + E.Message);
        end;

        //Выгрузка в ECWID
        {if ExportEcwid then
        begin
          try
            spRead.Close;

            spRead.SelectSQL.Text := 'SELECT trim(T.NAME) NAME, t.g_product, t.price, '+
              'SUM(lt.AMOUNT) AMOUNT, t.nomenclatur_num '+
              'FROM G_PRODUCT T '+
              'LEFT OUTER JOIN (SELECT G_PRODUCT, AMOUNT, NAME, L.g_tochka '+
              'FROM LT_SKLAD_PRODUCT L,G_TOCHKA GT WHERE L.G_TOCHKA = GT.G_TOCHKA) LT ON T.G_PRODUCT = LT.G_PRODUCT '+
              'WHERE T.IS_ACTIVE = 1 AND T.IS_CATEGORY = 0 and LT.AMOUNT>0 '+
              'group by T.NAME, t.g_product, t.price, t.nomenclatur_num';

            resp := ReadSP(spRead);
            if resp <> '' then begin
              Log('Ошибка чтения списка товаров для выгрузки в Интернет магазин ECWID. ' + resp);
              Exit;
            end;
            try
              //NOMENCLATUR_NUM
              spRead.First;
              ID_PRODUCT := '';
              i := 0;
              if ECWID <> nil then
                ECWID.Destroy;
              ECWID := TECWID.Create(EcwidStoreID, EcwidSecretToken);
              ECWID.BodyBatch := '';
              while not spRead.Eof do
              begin
                if Trim(spRead.FieldByName('NOMENCLATUR_NUM').AsWideString) = '' then //Новый товар
                begin
                  ID_PRODUCT := ECWID.addProducts(spRead.FieldByName('NAME').AsWideString,
                                spRead.FieldByName('AMOUNT').AsWideString,
                                spRead.FieldByName('price').AsWideString);
                  sleep(1000);
                  if Trim(ID_PRODUCT) <> EmptyStr then
                  begin
                    with TpFIBQuery.Create(nil) do
                    begin
                      try
                        Database := db;
                        Transaction := MainDM.tranMainWrite;
                        SQL.Clear;
                        SQL.Add('UPDATE G_PRODUCT SET NOMENCLATUR_NUM = ?NOMENCLATUR_NUM WHERE G_PRODUCT = ?G_PRODUCT');
                        ParamByName('NOMENCLATUR_NUM').AsWideString := ID_PRODUCT;
                        ParamByName('G_PRODUCT').AsInt64 := spRead.FieldByName('g_product').AsInteger;
                        if not Transaction.InTransaction then
                          Transaction.StartTransaction;
                        ExecQuery;
                        if Transaction.InTransaction then
                          Transaction.Commit;
                      finally
                        Free;
                      end;
                    end;
                  end;
                end
                else
                begin
                  {sleep(1000);
                  s := ECWID.FindProduct(spRead.FieldByName('NOMENCLATUR_NUM').AsWideString);
                  if not TryStrToFloat(s, Amount) then
                    Amount := spRead.FieldByName('AMOUNT').AsFloat;
                  if spRead.FieldByName('AMOUNT').AsFloat - Amount <> 0 then
                  begin
                    sleep(500);
                    s := ECWID.UpdProduct(spRead.FieldByName('NOMENCLATUR_NUM').AsWideString, FloatToStr(spRead.FieldByName('AMOUNT').AsFloat - Amount));
                  end;}
                  {inc(i);
                  if i < 499 then
                    ECWID.AddBatch(spRead.FieldByName('NOMENCLATUR_NUM').AsWideString, i, spRead.FieldByName('AMOUNT').AsFloat)
                  else
                  begin
                    s := ECWID.SendBatch;
                    if s <> '' then
                    begin
                      Log(s);
                      ECWID.BodyBatch := '';
                    end;
                    i := 0;
                    ECWID.AddBatch(spRead.FieldByName('NOMENCLATUR_NUM').AsWideString, i, spRead.FieldByName('AMOUNT').AsFloat);
                  end;
                end;
                spRead.Next;
              end;
              s := ECWID.SendBatch;
              if s <> '' then
                Log(s);
              i := 0;
              ECWID.BodyBatch := '';
            finally
              if ECWID <> nil then
                ECWID.Destroy;
            end;
          except
            on E: Exception do
              Log('Ошибка выгрузки данных в интернет магазин Ecwid. Детали: ' + E.Message);
          end;
        end;}
        //выгрузка в мобильное приложение
        try
          if (UploadToMobile) and (isProKey)  then begin
            Log('Начало работы с мобильным приложением.');

            DoUploadToMobile;

            Log('Конец работы с мобильным приложением.');
          end;
        except
          on E: Exception do
            Log('Ошибка работы с мобильным приложением. Детали: ' + E.Message);
        end;

        // в самом конце удаляю все строки из SYNC_EXT_APP
        try
          if (uploadSales or uploadArrivals) and UploadToMobile then
            spScriptWrite.Script.Text := 'DELETE FROM SYNC_EXT_APP WHERE IS_LOADED = 1 AND IS_LOADED_MOB = 1 AND IS_LOADING = 1;'
          else if (uploadSales or uploadArrivals) then
            spScriptWrite.Script.Text := 'DELETE FROM SYNC_EXT_APP WHERE IS_LOADED = 1 AND IS_LOADING = 1;'
          else
            spScriptWrite.Script.Text := 'DELETE FROM SYNC_EXT_APP WHERE IS_LOADED_MOB = 1 AND IS_LOADING = 1;';

          spScriptWrite.Script.Text := spScriptWrite.Script.Text + ' UPDATE SYNC_EXT_APP SET IS_LOADING = 0 WHERE IS_LOADING = 1;';
          resp := ExecScript(spScriptWrite, true);
          if resp <> '' then begin
            Log('Ошибка удаления выгруженных данных. PNT: DELETE 13A. ' + resp);
            exit;
          end;
        except
          on E: Exception do begin
            Log('Ошибка удаления выгруженных данных. PNT: DELETE. Детали: ' + E.Message);

            Exit;
          end;
        end;

      finally
        DisconnectFromFB(db);
        if tranMain.InTransaction then
          tranMain.Rollback;

        FreeAndNil(tranMain);
        FreeAndNil(spScriptWrite);
        FreeAndNil(spProc);
        FreeAndNil(db);

        Log('Конец выгрузки данных.');
      end;
    end;

    DoNotProcessFirst := False;

    if TerminateImmediate = true then
      Break;

    // перенес в начало потока, чтобы не запускать его сразу после запуска программы
    FSleepEvent.WaitFor(ExportInterval); // Ждем N минут
  end;
end;


procedure TExportDataThread.PushToArr(filename: string);
begin
  SetLength(FilesArr, High(FilesArr) + 2);
  FilesArr[High(FilesArr)] := filename;
end;

procedure TExportDataThread.DoUploadToFtp;
var idFTP1 : TIdFTP;
  i : Integer;
begin
  if (ExportFtpServer <> '') and (ExportFtpPort <> '') and (ExportFtpLogin <> '') then begin
    try
      idFTP1 := TIdFTP.Create;

      idFTP1.Host := ExportFtpServer;   //FTP-сервер
      idFTP1.Port := StrToInt(ExportFtpPort);                  //порт ФТП сервера
      idFTP1.Username := ExportFtpLogin;
      idFTP1.Password := ExportFtpPassword;
      IdFTP1.Passive := True;
      idFTP1.Connect;
      //idFTP1.ChangeDir('/testftp');

      for i := 0 to High(FilesArr) do
        IdFTP1.Put(FilesArr[i], extractfilename(FilesArr[i]), false);
    finally
      idFTP1.Disconnect;
      idFTP1.Free;
    end;
  end;
end;

procedure TExportDataThread.DoUploadToMobile;
var
  o, data, delete: TJSONObject;
  json_array, json_array_child: TJSONArray;
  json_item, json_item_child: TJSONObject;
  b : integer;
  data_is_added, delete_is_added, head_filled : boolean;
  parent_id_old, rec_id : Int64;
  str, errStr, S, resp, pnt, res : string;
  D : array [1..3] of integer;
begin

  // ПОЛУЧАЮ ТОКЕН
  res := GetToken(ExportMobileToken, ExportMobileServer, ExportMobileLogin, ExportMobilePassword);
  if Pos('Ошибка', res) > 0 then begin
    Log(res);
    Exit;
  end
  else
    ExportMobileToken := res;

  //=============================================================
  // ЗАГРУЗКА С СЕРВЕРА НАЧАЛО
  //=============================================================
  pnt := '01';
  res := DoLoadFromMobile(ExportMobileToken);
  if Pos('Ошибка', res) > 0 then begin
    if Pos('token is not valid', res) > 0 then begin
      res := GetToken('', ExportMobileServer, ExportMobileLogin, ExportMobilePassword);
      if Pos('Ошибка', res) > 0 then begin
        Log(res);
        Exit;
      end
      else begin
        ExportMobileToken := res;
        res := DoLoadFromMobile(ExportMobileToken);
        if Pos('Ошибка', res) > 0 then begin
          Log(res);
          Exit;
        end;
      end;
    end
    else begin
      Log(res);
      Exit;
    end;
  end;

  //=============================================================
  // ЗАГРУЗКА С СЕРВЕРА КОНЕЦ
  //=============================================================

  //=============================================================
  // ЗАГРУЗКА НА СЕРВЕР НАЧАЛО
  //=============================================================
  // ПРОВЕРЮ ВНАЧАЛЕ ЕСТЬ ЛИ ВООБЩЕ ЗАПИСИ ДЛЯ ВЫГРУЗКИ
  pnt := '02';
  try
    try
      spRead.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP WHERE IS_LOADING = 1 AND IS_LOADED_MOB = 0';
      ReadSP(spRead);
      if spRead.RecordCount = 0 then begin
        spRead.Close;

        spRead.SelectSQL.Text := 'SELECT * FROM LT_SKLAD_PRODUCT WHERE NEED_TO_EXPORT = 1';
        ReadSP(spRead);
        if spRead.RecordCount = 0 then
          Exit;
      end;
    except
      on E: Exception do begin
        Log('Ошибка поиска записей для выгрузки. Детали: ' + E.Message);
        Exit;
      end;
    end;
  finally
    spRead.Close;
  end;

  pnt := '03';
  data_is_added := false;

  o := TJSONObject.Create;

  try
    data := TJSONObject.Create;
    spRead.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_, 1, :OPER_)';

    //========================================================================
    // ОБЪЕКТ G_PRODUCT
    //========================================================================
    pnt := '04';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 4;
      spRead.ParamByName('OPER_').AsInteger := 1;

      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка товаров для выгрузки. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        data_is_added := true;
        o.AddPair('data', data);
        json_array := BuildGprodJson(spRead, errStr);
        if json_array = nil then begin
          Log(errStr);
          Exit;
        end;

        data.AddPair('g_product', json_array);
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки товаров в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ G_PRODUCT КОНЕЦ
    //========================================================================

    //========================================================================
    // ОБЪЕКТ G_TOCHKA
    //========================================================================
    pnt := '05';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 3;
      spRead.ParamByName('OPER_').AsInteger := 1;
      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка торговых точек для выгрузки. Point ' + pnt + '. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        //spUniversalWrite.SelectSQL.Text := 'DELETE FROM SYNC_EXT_APP WHERE SYNC_EXT_APP = :SYNC_EXT_APP_';
        if data_is_added = false then begin
          data_is_added := true;
          o.AddPair('data', data);
        end;

        pnt := '06';
        try
          json_array := TJSONArray.Create();
          data.AddPair('g_tochka', json_array);

          with spRead do begin
            First;
            //MessageBox(GetDesktopWindow, PChar('Загрузка точек'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
            while not Eof do begin
              try
                json_item := TJSONObject.Create;
                json_item.AddPair( TJSONPair.Create('rec_id', FieldByName('ZAKAZ').AsString));
                json_item.AddPair( TJSONPair.Create('name', FieldByName('TOVAR_NAME').AsString));
                json_array.AddElement(json_item);

                Next;
              finally
                //g_product_item.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
              end;
            end;
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки складов в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ G_TOCHKA КОНЕЦ
    //========================================================================
    //========================================================================
    // ОБЪЕКТ SKLAD
    //========================================================================
    pnt := '07';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 2;
      spRead.ParamByName('OPER_').AsInteger := 1;
      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка приходов для выгрузки. Point ' + pnt + '. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        if data_is_added = false then begin
          data_is_added := true;
          o.AddPair('data', data);
        end;

        pnt := '08';
        try
          json_array := TJSONArray.Create();
          data.AddPair('sklad', json_array);

          with spRead do begin
            First;
            parent_id_old := FieldByName('ZAKAZ').AsLargeInt;
            head_filled := false;
            //MessageBox(GetDesktopWindow, PChar('Загрузка складов'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
            while not Eof do begin
              if parent_id_old <> FieldByName('ZAKAZ').AsLargeInt then begin
                head_filled := false;
                json_item.AddPair('sklad_details', json_array_child);
                json_array.AddElement(json_item);
              end;

              pnt := '09';
              try
                if not head_filled then begin
                  head_filled := True;

                  json_item := TJSONObject.Create;
                  json_item.AddPair( TJSONPair.Create('rec_id', FieldByName('ZAKAZ').AsString));
                  json_item.AddPair( TJSONPair.Create('g_tochka_id', FieldByName('G_TOCHKA').AsString));
                  json_item.AddPair( TJSONPair.Create('date', FieldByName('Z_DATE').AsString));
                  json_item.AddPair( TJSONPair.Create('summ', floattostrf(FieldByName('SUMM_ALL').AsFloat, ffFixed, 15, 2)));
                  json_item.AddPair( TJSONPair.Create('summ_cash', floattostrf(FieldByName('SUMM_CASH').AsFloat, ffFixed, 15, 2)));
                  json_item.AddPair( TJSONPair.Create('summ_noncash', floattostrf(FieldByName('SUMM_NONCASH').AsFloat, ffFixed, 15, 2)));
                  json_item.AddPair( TJSONPair.Create('type', FieldByName('RTYPE').AsString));
                  json_array_child := TJSONArray.Create();
                end;

                pnt := '010';
                json_item_child := TJSONObject.Create;
                json_item_child.AddPair( TJSONPair.Create('rec_id', FieldByName('item_id').AsString));
                json_item_child.AddPair( TJSONPair.Create('sklad_id', FieldByName('ZAKAZ').AsString)); // IntTostr(parent_id_old)));
                json_item_child.AddPair( TJSONPair.Create('g_product_id', FieldByName('g_product').AsString));
                json_item_child.AddPair( TJSONPair.Create('amount', floattostrf(FieldByName('AMOUNT').AsFloat, ffFixed, 15, 2)));
                json_item_child.AddPair( TJSONPair.Create('price', floattostrf(FieldByName('PRICE').AsFloat, ffFixed, 15, 2)));
                json_array_child.AddElement(json_item_child);

                parent_id_old := FieldByName('ZAKAZ').AsLargeInt;
                Next;
              finally
                //g_product_item.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
              end;
            end;

            head_filled := false;
            json_item.AddPair('sklad_details', json_array_child);
            json_array.AddElement(json_item);
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки приходов в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ SKLAD КОНЕЦ
    //========================================================================
    //========================================================================
    // ОБЪЕКТ ZAKAZ
    //========================================================================
    pnt := '011';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 1;
      spRead.ParamByName('OPER_').AsInteger := 1;
      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка продаж для выгрузки. Point ' + pnt + '. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        if data_is_added = false then begin
          data_is_added := true;
          o.AddPair('data', data);
        end;

        pnt := '012';
        try
          json_array := TJSONArray.Create();
          data.AddPair('zakaz', json_array);

          with spRead do begin
            First;
            parent_id_old := FieldByName('ZAKAZ').AsLargeInt;
            head_filled := false;
            while not Eof do begin
              if parent_id_old <> FieldByName('ZAKAZ').AsLargeInt then begin
                head_filled := false;
                json_item.AddPair('zakaz_details', json_array_child);
                json_array.AddElement(json_item);
              end;

              pnt := '013';
              try
                if not head_filled then begin
                  head_filled := True;

                  json_item := TJSONObject.Create;
                  json_item.AddPair( TJSONPair.Create('rec_id', FieldByName('ZAKAZ').AsString));
                  json_item.AddPair( TJSONPair.Create('g_tochka_id', FieldByName('G_TOCHKA').AsString));
                  json_item.AddPair( TJSONPair.Create('date', FieldByName('Z_DATE').AsString));
                  json_item.AddPair( TJSONPair.Create('summ', floattostrf(FieldByName('SUMM_ALL').AsFloat, ffFixed, 15, 2)));
                  json_item.AddPair( TJSONPair.Create('summ_cash', floattostrf(FieldByName('SUMM_CASH').AsFloat, ffFixed, 15, 2)));
                  json_item.AddPair( TJSONPair.Create('summ_noncash', floattostrf(FieldByName('SUMM_NONCASH').AsFloat, ffFixed, 15, 2)));
                  json_item.AddPair( TJSONPair.Create('summ_bonus', floattostrf(FieldByName('SUMM_BONUS').AsFloat, ffFixed, 15, 2)));
                  json_array_child := TJSONArray.Create();
                end;

                pnt := '014';
                json_item_child := TJSONObject.Create;
                json_item_child.AddPair( TJSONPair.Create('rec_id', FieldByName('item_id').AsString));
                json_item_child.AddPair( TJSONPair.Create('zakaz_id', FieldByName('ZAKAZ').AsString)); //IntTostr(parent_id_old)));
                json_item_child.AddPair( TJSONPair.Create('g_product_id', FieldByName('g_product').AsString));
                json_item_child.AddPair( TJSONPair.Create('amount', floattostrf(FieldByName('AMOUNT').AsFloat, ffFixed, 15, 2)));
                json_item_child.AddPair( TJSONPair.Create('price', floattostrf(FieldByName('PRICE').AsFloat, ffFixed, 15, 2)));
                json_item_child.AddPair( TJSONPair.Create('cost_price', floattostrf(FieldByName('COST_PRICE').AsFloat, ffFixed, 15, 2)));
                json_array_child.AddElement(json_item_child);

                parent_id_old := FieldByName('ZAKAZ').AsLargeInt;
                Next;
              finally
                //g_product_item.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
              end;
            end;

            head_filled := false;
            json_item.AddPair('zakaz_details', json_array_child);
            json_array.AddElement(json_item);
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки продаж в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ ZAKAZ КОНЕЦ
    //========================================================================

    // ДАЛЕЕ БЛОК ПО КАССЕ БУДУ ВЫСЫЛАТЬ, ТОЛЬКО ЕСЛИ БЫЛИ ОБНОВЫ ПО ДРУГИМ ДАННЫМ
    // 17.08.2021 - решил всегда передавать
    //========================================================================
    // ОБЪЕКТ KASSA_STATE
    //========================================================================
    pnt := '015';
    try
      // стартую транзакцию
      tranMain.StartTransaction;

      // записи по кассе буду брать только те, что изменены через екзешник
      // при зазгрузке через мобилку так и так записи в KASSA_STATE создаются с NEED_TO_EXPORT = 0
      spScriptWrite.Script.Text := 'UPDATE KASSA_STATE ' +
                                      'SET NEED_TO_EXPORT = 3 '+
                                    'WHERE NEED_TO_EXPORT = 1';
      resp := ExecScript(spScriptWrite);
      if resp <> '' then begin
        Log('Ошибка подготовки кассы для выгрузки. Point = ' + pnt + '. ' + resp);
        exit;
      end;

      spRead.SelectSQL.Text := 'SELECT ST.KASSA_STATE, ' +
                                '       ST.G_TOCHKA, ' +
                                '       ST."INPUT", ST.DEBET, ST.CREDIT,' +
                                '       ST."OUTPUT", ' +
                                '       ST.K_DATE ' +
                                'FROM KASSA_STATE ST ' +
                                'WHERE ST.NEED_TO_EXPORT = 3';
      pnt := '017';
      ReadSp(spRead);
      if spRead.RecordCount > 0 then begin
        if data_is_added = false then begin
          data_is_added := true;
          o.AddPair('data', data);
        end;

        try
          json_array := TJSONArray.Create();
          data.AddPair('kassa_state', json_array);

          with spRead do begin
            First;
            //MessageBox(GetDesktopWindow, PChar('Загрузка касса'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
            while not Eof do begin
              pnt := '018';
              try
                json_item := TJSONObject.Create;
                json_item.AddPair( TJSONPair.Create('rec_id', FieldByName('kassa_state').AsString));
                json_item.AddPair( TJSONPair.Create('g_tochka_id', FieldByName('G_TOCHKA').AsString));
                json_item.AddPair( TJSONPair.Create('date', FieldByName('k_date').AsString));
                json_item.AddPair( TJSONPair.Create('in_summ', floattostrf(FieldByName('input').AsFloat, ffFixed, 15, 2)));
                json_item.AddPair( TJSONPair.Create('debet', floattostrf(FieldByName('debet').AsFloat, ffFixed, 15, 2)));
                json_item.AddPair( TJSONPair.Create('credit', floattostrf(FieldByName('credit').AsFloat, ffFixed, 15, 2)));
                json_item.AddPair( TJSONPair.Create('out_summ', floattostrf(FieldByName('output').AsFloat, ffFixed, 15, 2)));
                json_array.AddElement(json_item);

                Next;
              finally
                //g_product_item.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
              end;
            end;
          end;

        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end
      else begin

        // если записей не было, то зачем держать транзакцию открытой, закрываю
        tranMain.Rollback;
      end;

      spRead.Close;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки кассы в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
        // здесь и далее не делаю Rollback открытой транзы, потому что в Finally она стоит
      end;
    end;
    //========================================================================
    // ОБЪЕКТ KASSA_STATE КОНЕЦ
    //========================================================================
    spRead.Close;

    //========================================================================
    // ОБЪЕКТ REMAINDERS, ВЫГРУЖАЮТСЯ ОСТАТКИ ПО ТОВАРАМ
    //========================================================================
    pnt := '020';
    try
      // стартую транзакцию
      if not tranMain.InTransaction then
        tranMain.StartTransaction;

      spScriptWrite.Script.Text := 'SELECT RDB$SET_CONTEXT (''USER_SESSION'', ''EXT_APP'', ''1'') '+
        ' TT FROM RDB$DATABASE;'+
        ' UPDATE LT_SKLAD_PRODUCT SET NEED_TO_EXPORT = 3 WHERE NEED_TO_EXPORT = 1;'; // ТИМА  у себя при создании прихода/продаж сразу меняет остатки, поэтому необязательно ему высылать измененные им же остатки обратно

      resp := ExecScript(spScriptWrite);
      if resp <> '' then begin
        Log('Ошибка подготовки остатков для выгрузки. Point = ' + pnt + '. ' + resp);
        exit;
      end;

      pnt := '021';
      spRead.SelectSQL.Text := 'SELECT LT.LT_SKLAD_PRODUCT, ' +
                                       'LT.G_PRODUCT, '+
                                       '(LT.AMOUNT - LT.AMOUNT_RESERVE) AMOUNT, '+
                                       'LT.G_TOCHKA, '+
                                       '(SELECT * FROM GET_LAST_SELF_PRICE(LT.G_PRODUCT, LT.G_TOCHKA, 1)) COST_PRICE '+
                                'FROM LT_SKLAD_PRODUCT LT, G_PRODUCT GP, G_TOCHKA GT '+
                                'WHERE LT.G_PRODUCT = GP.G_PRODUCT '+
                                'AND LT.NEED_TO_EXPORT = 3 ' +
                                'AND GP.IS_ACTIVE = 1 ' +
                                'AND LT.G_TOCHKA = GT.G_TOCHKA';
      ReadSp(spRead);
      if spRead.RecordCount > 0 then begin
        if data_is_added = false then begin
          data_is_added := true;
          o.AddPair('data', data);
        end;

        pnt := '022';
        try
          json_array := TJSONArray.Create();
          data.AddPair('remainders', json_array);

          with spRead do begin
            First;
            //MessageBox(GetDesktopWindow, PChar('Загрузка остатков'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
            while not Eof do begin
              try
                json_item := TJSONObject.Create;
                json_item.AddPair( TJSONPair.Create('rec_id', FieldByName('lt_sklad_product').AsString));
                json_item.AddPair( TJSONPair.Create('g_tochka_id', FieldByName('G_TOCHKA').AsString));
                json_item.AddPair( TJSONPair.Create('g_product_id', FieldByName('g_product').AsString));
                json_item.AddPair( TJSONPair.Create('amount', floattostrf(FieldByName('amount').AsFloat, ffFixed, 15, 2)));
                json_item.AddPair( TJSONPair.Create('cost_price', floattostrf(FieldByName('cost_price').AsFloat, ffFixed, 15, 2)));
                json_array.AddElement(json_item);

                Next;
              finally
                //g_product_item.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
              end;
            end;
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end
      else begin

        // если записей не было, то зачем держать транзакцию открытой, закрываю
        tranMain.Rollback;
      end;

    except
      on E: Exception do begin
        Log('Ошибка выгрузки остатков в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ REMAINDERS КОНЕЦ
    //========================================================================

    //========================================================================
    //========================================================================
    // ТЕПЕРЬ УДАЛЕНИЕ
    pnt := '024';
    delete := TJSONObject.Create;
    spRead.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_, 1, :OPER_)';

    //========================================================================
    // ОБЪЕКТ G_PRODUCT
    //========================================================================
    pnt := '025';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 4;
      spRead.ParamByName('OPER_').AsInteger := 3;
      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка товаров на удаление. Point ' + pnt + '. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        delete_is_added := true;
        o.AddPair('delete', delete);

        try
          json_array := TJSONArray.Create();
          delete.AddPair('g_product', json_array);

         with spRead do begin
            First;
            while not eof do begin
              json_array.Add(FieldByName('G_PRODUCT').AsString);
              Next;
            end;
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки удаленных товаров в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;

    //========================================================================
    // ОБЪЕКТ G_TOCHKA
    //========================================================================
    pnt := '026';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 3;
      spRead.ParamByName('OPER_').AsInteger := 3;
      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка точек на удаление. Point ' + pnt + '. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        if delete_is_added = false then begin
          delete_is_added := true;
          o.AddPair('delete', delete);
        end;

        try
          json_array := TJSONArray.Create();
          delete.AddPair('g_tochka', json_array);

         with spRead do begin
            First;
            while not eof do begin
              json_array.Add(FieldByName('ZAKAZ').AsString);
              Next;
            end;
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки удаленных складов в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ G_TOCHKA КОНЕЦ
    //========================================================================
    //========================================================================
    // ОБЪЕКТ SKLAD
    //========================================================================
    pnt := '027';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 2;
      spRead.ParamByName('OPER_').AsInteger := 3;
      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка приходов на удаление. Point ' + pnt + '. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        if delete_is_added = false then begin
          delete_is_added := true;
          o.AddPair('delete', delete);
        end;

        try
          json_array := TJSONArray.Create();
          delete.AddPair('sklad', json_array);

          with spRead do begin
            First;
            while not eof do begin
              json_array.Add(FieldByName('ZAKAZ').AsString);
              Next;
            end;
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки удаленных приходов в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ SKLAD КОНЕЦ
    //========================================================================
    //========================================================================
    // ОБЪЕКТ ZAKAZ
    //========================================================================
    pnt := '028';
    try
      spRead.ParamByName('OBJECT_TYPE_').AsInteger := 1;
      spRead.ParamByName('OPER_').AsInteger := 3;
      resp := ReadSP(spRead);
      if resp <> '' then begin
        Log('Ошибка чтения списка продаж на удаление. Point ' + pnt + '. ' + resp);
        Exit;
      end;

      if spRead.RecordCount > 0 then begin
        if delete_is_added = false then begin
          delete_is_added := true;
          o.AddPair('delete', delete);
        end;

        try
          json_array := TJSONArray.Create();
          delete.AddPair('zakaz', json_array);

          with spRead do begin
            First;
            while not eof do begin
              json_array.Add(FieldByName('ZAKAZ').AsString);
              Next;
            end;
          end;
        finally
          //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
        end;
      end;
    except
      on E: Exception do begin
        Log('Ошибка выгрузки удаленных продаж в моб. приложение. Point ' + pnt + '. Детали: ' + E.Message);
        Exit;
      end;
    end;
    spRead.Close;
    //========================================================================
    // ОБЪЕКТ ZAKAZ КОНЕЦ
    //========================================================================

    //========================================================================
    // НЕПОСРЕДСТВЕННО ОТПРАВКА ДАННЫХ
    //========================================================================
    pnt := '029';
    if data_is_added or delete_is_added then
    begin
      Log(o.ToString);

      errStr := SendToMobile(MainDm.RESTClient, MainDm.RESTRequest, MainDm.RESTResponse,
        ExportMobileServer, ExportMobileToken, o);

      if errStr <> '' then
      begin
        //Если есть такая ошибка необходимо отправить недостающие товары
        //или если токен стал невалидный
        if (Pos('refers to not existing row in g_product', errStr) > 0) or
        (Pos('token is not valid', res) > 0) then
        begin
          Log(errStr);

          if (Pos('refers to not existing row in g_product', errStr) > 0) then begin
            Log('Отправка недостающих товаров.');
            errStr := ReSendAfterError(db, tranMain, Trim(StringReplace(errStr, ', table remainders refers to not existing row in g_product', '', [rfReplaceAll])), ExportMobileToken);

            if errStr <> '' then
            begin
              Log(errStr);
              Exit;
            end;
          end

          else begin
            errStr := GetToken('', ExportMobileServer, ExportMobileLogin, ExportMobilePassword);
            if Pos('Ошибка', errStr) > 0 then begin
              Log(errStr);
              Exit;
            end
            else
              ExportMobileToken := errStr;
          end;

          // повторно отправляю данные
          Log('Повторная отправка данных.');
          errStr := SendToMobile(MainDm.RESTClient, MainDm.RESTRequest, MainDm.RESTResponse,
          ExportMobileServer, ExportMobileToken, o);
        end;

        if errStr <> '' then
        begin
          Log(errStr);
          Exit;
        end;
      end;

      try
        pnt := '030';
        spScriptWrite.Script.Text := 'UPDATE KASSA_STATE SET NEED_TO_EXPORT = 0 WHERE NEED_TO_EXPORT IN (2,3);' +
        ' UPDATE LT_SKLAD_PRODUCT SET NEED_TO_EXPORT = 0 WHERE NEED_TO_EXPORT IN (2,3);' +
        ' UPDATE SYNC_EXT_APP SET IS_LOADED_MOB = 1 WHERE IS_LOADED_MOB = 0 AND IS_LOADING = 1';

        resp := ExecScript(spScriptWrite);
        if resp <> '' then begin
          Log('Ошибка смены статуса выгруженных записей. Point = ' + pnt + '. ' + resp);
          exit;
        end;

        tranMain.Commit;
      except
        on E: Exception do begin
          Log('Ошибка обновления данных. Point ' + pnt + '. Детали: ' + E.Message);
          Exit;
        end;
      end;
    end;
    //========================================================================
    // НЕПОСРЕДСТВЕННО ОТПРАВКА ДАННЫХ КОНЕЦ
    //========================================================================
    //=============================================================
    // ЗАГРУЗКА НА СЕРВЕР КОНЕЦ
    //=============================================================
  finally
    spRead.Close;

    if tranMain.InTransaction then
      tranMain.Rollback;

    o.Free;
  end;
end;

function TExportDataThread.DoLoadFromMobile(token : String) : string;
var resp, s, ss, err_str, pnt : String;
  LJsonResponse, LItem, LItemDetails : TJSONObject;
  LResult, LResultDetails : TJSONArray;
  i, k : integer;
  d : TDateTime;
  summCash, summNonCash, summBonus, summTovar : Double;
  res, paymentsArr : string;
  wasLoad : boolean;
begin
  Log('Начало загрузки с мобильного приложения.');
  Result := '';

  TRY
    wasLoad := false;
    resp := GetFromMobile(MainDm.RESTClient, MainDm.RESTRequest, MainDm.RESTResponse, Token);

    if Pos('Ошибка отправки запроса на сервер. Детали', resp) <> 0 then begin
      Log(resp);
      Result := resp;
      Exit;
    end;

    if resp <> '' then begin
      try
        LJsonResponse := TJSONObject.ParseJSONValue(resp) as TJSONObject;

        //--------------------------------------------------------
        // ЗАГРУЗКА ПРИХОДА
        pnt := '01';
        LResult := LJsonResponse.GetValue('sklad') as TJSONArray;

        for i := 0 to LResult.Count-1 do begin
          wasLoad := true;
          spScriptWrite.Script.Text := 'SELECT RDB$SET_CONTEXT (''USER_SESSION'', ''EXT_APP'', ''1'') '+
          'FROM RDB$DATABASE;';

          tranMain.StartTransaction;  // стартую транзакцию

          pnt := '02';
          LItem := LResult.Items[i] as TJSONObject;

          // формирую скрипт
          LResultDetails := LItem.GetValue('sklad_details') as TJSONArray;
          for k := 0 to LResultDetails.Count-1 do begin
            LItemDetails := LResultDetails.Items[k] as TJSONObject;

            pnt := '03';
            spScriptWrite.Script.tEXT := spScriptWrite.Script.tEXT + CRLF +
            'INSERT INTO SKLAD_TMP (SKLAD, G_PRODUCT, AMOUNT, PRICE, SUMM) ' +
              ' VALUES (GEN_ID(GEN_DETAILS_TMP, 1),' +
              LItemDetails.GetValue('g_product_id').Value + ',' +
              LItemDetails.GetValue('amount').Value + ',' +
              LItemDetails.GetValue('price').Value + ',' +
              FloatToStr(StrToFloat(LItemDetails.GetValue('amount').Value) * StrToFloat(LItemDetails.GetValue('price').Value)) +
              ');';
          end;

          // выполняю скрипт
          pnt := '04';
          resp := ExecScript(spScriptWrite);
          if resp <> '' then begin
            Log('Ошибка загрузки деталей прихода (EFIBError). Point = ' + pnt + '. ' + resp);
            exit;
          end;

          pnt := '05';
          with spProc do begin
            spProc.SQL.Text := 'EXECUTE PROCEDURE UPSERT_SKLAD_EXT_LOAD (?G_TOCHKA_, ?DATE_RECEIPT_, ?TIME_RECEIPT_, ' +
              '?G_CLIENT_, ?G_PAYMENT_TYPE_, ?OSNOVANIE_, ?NOTE_, ?IS_VOZVRAT_, ?SUMM_, ?SUMM_FACT_, ?PAYMENTS_, ' +
              '?SUMM_CURRENCY_, ?IS_EXPECTED_, ?UPLOAD_TO_EXT_APP_, ?USER_ID_, ?LOG_BODY_, ?G_OFFICIAL_, ?REC_ID_)';
            spProc.StoredProcName := 'UPSERT_SKLAD_EXT_LOAD';

            d := StrToDateTime(LItem.GetValue('date').Value);
            summCash := StrToFloat(LItem.GetValue('summ_cash').Value);
            summNonCash := StrToFloat(LItem.GetValue('summ_noncash').Value);

            ParamByName('G_TOCHKA_').AsInt64 := StrToInt(LItem.GetValue('g_tochka_id').Value);
            ParamByName('DATE_RECEIPT_').AsDate := d;
            ParamByName('TIME_RECEIPT_').AsTime := TimeOf(d);

            pnt := '06';
            if summCash > 0 then
              ParamByName('G_PAYMENT_TYPE_').AsInteger := 1
            else
              ParamByName('G_PAYMENT_TYPE_').AsInteger := 2;

            ParamByName('NOTE_').AsString := 'Мобильное приложение';
            ParamByName('Is_VOZVRAT_').AsInteger := StrToInt(LItem.GetValue('type').Value);
            ParamByName('summ_').AsFloat := StrToFloat(LItem.GetValue('summ').Value);
            ParamByName('summ_fact_').AsFloat := summCash + summNonCash;

            pnt := '07';
            if summCash > 0 then
              paymentsArr := '0-' + DateToStr(d) + '-' + FloatToStr(summCash) + '-1~';

            if summNonCash > 0 then
              paymentsArr := paymentsArr + '0-' + DateToStr(d) + '-' + FloatToStr(summNonCash) + '-2~';

            ParamByName('PAYMENTS_').AsString := paymentsArr;
            ParamByName('summ_currency_').AsFloat := 0;
            ParamByName('IS_EXPECTED_').AsInteger := 0;

            // надо ли заносить продажу в отдельную таблицу для выгрузки в XML, выгрузку в мобилку тут во внимание не беру, т.к. с нее и идет загрузка
            ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;
            if (StrToInt(LItem.GetValue('type').Value) in [0, 1]) and ((Copy(ExportDataType, 6, 1) = '1') or
            (Copy(ExportDataTypeFtp, 6, 1) = '1') {or (UploadToMobile)}) then
              ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 2;  // 2 - значит, что для мобилы не надо выгружать

            pnt := '08';
            ParamByName('USER_ID_').AsInt64 := -1;
            ParamByName('G_OFFICIAL_').AsInt64 := -1;
            ParamByName('REC_ID_').AsInt64 := StrToInt(LItem.GetValue('rec_id').Value);

            //ParamByName('LOG_BODY_').AsString := FillLog;

            pnt := '09';
            try
              ExecProc;

              if FieldIndex['ERR_CODE'] >= 0 then begin
                if (ParamByName('ERR_CODE').AsInteger <> 0) AND (ParamByName('ERR_CODE').AsInteger <> -900) then begin
                  if FieldIndex['ERR_MSG'] >= 0 then begin
                    err_str := ParamByName('ERR_MSG').AsString;
                  end
                  else
                    err_str := 'Error code: ' + ParamByName('ERR_CODE').AsString;

                  Log('Ошибка загрузки прихода. ID = ' + LItem.GetValue('rec_id').Value + '. ' + err_str);

                  tranMain.Rollback;
                  Exit;
                end;
              end;
            except
              on E: EFIBError do begin
                if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
                  if Database.Connected then begin
                    err_str := GetServerConnectError(e.Message);
                    Database.Connected := False;
                  end;
                end
                else begin
                  tranMain.Rollback;
                  err_str := 'Error code: ' + IntToStr(E.SQLCode) + '. ' + E.Message;
                end;

                Log('Ошибка загрузки прихода. ID = ' + LItem.GetValue('rec_id').Value + '. Point = ' + pnt + '. ' + err_str);
                Exit;
              end;
            end;

          end;
        end;
        // КОНЕЦ ЗАГРУЗКА ПРИХОДА
        //--------------------------------------------------------

        //--------------------------------------------------------
        // ЗАГРУЗКА ПРОДАЖ
        pnt := '011';
        LResult := LJsonResponse.GetValue('zakaz') as TJSONArray;

        for i := 0 to LResult.Count-1 do begin
          wasLoad := true;
          spScriptWrite.Script.Text := 'SELECT RDB$SET_CONTEXT (''USER_SESSION'', ''EXT_APP'', ''1'') '+
          'FROM RDB$DATABASE;';

          if not tranMain.InTransaction then
            tranMain.StartTransaction;

          pnt := '012';
          LItem := LResult.Items[i] as TJSONObject;

          // формирую скрипт
          LResultDetails := LItem.GetValue('zakaz_details') as TJSONArray;
          for k := 0 to LResultDetails.Count-1 do begin
            LItemDetails := LResultDetails.Items[k] as TJSONObject;

            pnt := '013';
            summTovar := StrToFloat(LItemDetails.GetValue('amount').Value) * StrToFloat(LItemDetails.GetValue('price').Value);

            spScriptWrite.Script.tEXT := spScriptWrite.Script.tEXT + CRLF +
              'INSERT INTO ZAKAZ_DETAILS_TMP (ZAKAZ_DETAILS, G_PRODUCT, AMOUNT, PRICE, SUMM, DISCOUNT_PERC, DISCOUNT_TENGE, DISCOUNT_SUMM, NDS, NDS_SUMM, COST_PRICE) ' +
                ' VALUES (GEN_ID(GEN_DETAILS_TMP, 1),' +
                LItemDetails.GetValue('g_product_id').Value + ',' +
                LItemDetails.GetValue('amount').Value + ',' +
                LItemDetails.GetValue('price').Value + ',' +
                FloatToStr(summTovar) + ',0, 0, 0,' +
                FloatToStr(NdsValue) + ',' +
                FloatToStr(summTovar * NdsValue / (100 + NdsValue)) + ',' +
                LItemDetails.GetValue('cost_price').Value +
                ');';
          end;

          // выолняю скрипт
          pnt := '014';
          resp := ExecScript(spScriptWrite);
          if resp <> '' then begin
            Log('Ошибка загрузки деталей продажи (EFIBError). Point = ' + pnt + '. ' + resp);
            exit;
          end;

          pnt := '015';
          with spProc do begin
            SQL.Text := 'EXECUTE PROCEDURE UPSERT_ZAKAZ_EXT_LOAD (?G_TOCHKA_, ?Z_DATE_, ?Z_TIME_, ?G_CLIENT_, ' +
              '?G_PAYMENT_TYPE_, ?OSNOVANIE_, ?IS_SPISANIE_, ?NOTE_, ?SUMM_, ?SUMM_FACT_, ?SUMM_CASH_, ?SUMM_NONCASH_, ' +
              '?SUMM_BONUS_, ?SUMM_BONUS_GOT_, ?G_PRIHOD_, ?SUMM_PRIHOD_, ?BY_RECIPE_, ?IS_RESERVE_, ?PAYMENTS_, ?IS_MEBEL_, ' +
              '?DOSTAVSHIK_, ?DELIVERY_DATE_, ?ADDRESS_, ?PRICE_, ?UPLOAD_TO_EXT_APP_, ?G_OFFICIAL_, ?NOT_MINUS_OSTATOK_, ' +
              '?USER_ID_, ?LOG_BODY_, ?REC_ID_)';
            StoredProcName := 'UPSERT_ZAKAZ_EXT_LOAD';

            ParamByName('G_TOCHKA_').AsInt64 := StrToInt(LItem.GetValue('g_tochka_id').Value);

            d := StrToDateTime(LItem.GetValue('date').Value);
            summCash := StrToFloat(LItem.GetValue('summ_cash').Value);
            summNonCash := StrToFloat(LItem.GetValue('summ_noncash').Value);
            summBonus   := StrToFloat(LItem.GetValue('summ_bonus').Value);

            ParamByName('Z_DATE_').AsDate := d;
            ParamByName('Z_TIME_').AsTime := TimeOf(d);
            ParamByName('G_CLIENT_').AsInt64 := 10;

            pnt := '016';
            if summCash > 0 then
              ParamByName('G_PAYMENT_TYPE_').AsInteger := 1
            else
              ParamByName('G_PAYMENT_TYPE_').AsInteger := 2;

            ParamByName('NOTE_').AsString := 'Мобильное приложение';
            ParamByName('IS_SPISANIE_').AsInteger := 0;
            ParamByName('summ_').AsFloat := StrToFloat(LItem.GetValue('summ').Value);
            ParamByName('summ_fact_').AsFloat := summCash + summNonCash;
            ParamByName('summ_cash_').AsFloat := summCash;
            ParamByName('summ_noncash_').AsFloat := summNonCash;
            ParamByName('SUMM_BONUS_').AsFloat := summBonus;
            ParamByName('SUMM_BONUS_GOT_').AsFloat := 0;
            ParamByName('BY_RECIPE_').AsInteger := 0;
            ParamByName('IS_RESERVE_').AsInteger := 0;

            pnt := '017';
            if summCash > 0 then
              paymentsArr := '0-' + DateToStr(d) + '-' + FloatToStr(summCash) + '-1~';

            if summNonCash > 0 then
              paymentsArr := paymentsArr + '0-' + DateToStr(d) + '-' + FloatToStr(summNonCash) + '-2~';

            ParamByName('PAYMENTS_').AsString := paymentsArr;
            ParamByName('IS_MEBEL_').AsInteger := 0;
            ParamByName('NOT_MINUS_OSTATOK_').AsInteger := 0;

            // надо ли заносить продажу в отдельную таблицу для выгрузки в XML, выгрузку в мобилку тут во внимание не беру, т.к. с нее и идет загрузка
            ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;
            if (Copy(ExportDataType, 5, 1) = '1') or (Copy(ExportDataTypeFtp, 5, 1) = '1') {or (UploadToMobile)} then
              ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 2;  // 2 - значит, что для мобилы не надо выгружать

            pnt := '018';
            ParamByName('USER_ID_').AsInt64 := -1;
            ParamByName('G_OFFICIAL_').AsInt64 := -1;
            ParamByName('REC_ID_').AsInt64 := StrToInt(LItem.GetValue('rec_id').Value);
            //ParamByName('LOG_BODY_').AsString := FillLog;

            pnt := '019';
            try
              ExecProc;

              if FieldIndex['ERR_CODE'] >= 0 then begin
                if (ParamByName('ERR_CODE').AsInteger <> 0) AND (ParamByName('ERR_CODE').AsInteger <> -900) then begin
                  if FieldIndex['ERR_MSG'] >= 0 then begin
                    err_str := ParamByName('ERR_MSG').AsString;
                  end
                  else
                    err_str := 'Error code: ' + ParamByName('ERR_CODE').AsString;

                  Log('Ошибка загрузки продажи. ID = ' + LItem.GetValue('rec_id').Value + '. ' + err_str);

                  tranMain.Rollback;
                  Exit;
                end;
              end;
            except
              on E: EFIBError do begin
                if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
                  if Database.Connected then begin
                    err_str := GetServerConnectError(e.Message);
                    Database.Connected := False;
                  end;
                end
                else begin
                  tranMain.Rollback;
                  err_str := 'Error code: ' + IntToStr(E.SQLCode) + '. ' + E.Message;
                end;

                Log('Ошибка загрузки продажи. ID = ' + LItem.GetValue('rec_id').Value + '. Point = ' + pnt + '. ' + err_str);
                Exit;
              end;
            end;

          end;
        end;
        // КОНЕЦ ЗАГРУЗКА ПРОДАЖ
        //--------------------------------------------------------

        if wasLoad then begin
          resp := ConfirmLoadFromMobile(MainDm.RESTClient, MainDm.RESTRequest, MainDm.RESTResponse, Token);

          if Pos('Ошибка', resp) <> 0 then begin
            Log(resp);

            tranMain.Rollback;
            Exit;
          end;
        end;

        if tranMain.InTransaction then
          tranMain.Commit; // коммичу транзакцию

      except
        on E: EFIBError do begin
          if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
            err_str := GetServerConnectError(e.Message);
            if db.Connected then
              db.Connected := False;
          end
          else begin
            tranMain.Rollback;
            err_str := IntToStr(E.SQLCode) + '. ' + E.Message;
          end;

          Log('Ошибка загрузки данных с мобильного приложения (FIBError). ' + err_str);
        end;
        on E: Exception do begin
          tranMain.Rollback;
          Log('Ошибка загрузки данных с мобильного приложения (Exception). ' + E.Message);
        end;
      end;
    end;

  FINALLY
    Log('Конец загрузки с мобильного приложения.');
  END;

end;

end.
