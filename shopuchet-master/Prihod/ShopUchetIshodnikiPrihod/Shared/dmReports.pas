unit dmReports;

interface

uses
  SysUtils, Classes, DB, FIBDataSet, pFIBDataSet, FIBDatabase,
  pFIBDatabase, Dialogs, UExcelAdapter, XLSAdapter, UFlxMemTable,
  UCustomFlexCelReport, UFlexCelReport, Forms, Windows, Controls, FIB, ShellApi, FileCtrl,
  frxExportImage, frxExportRTF, frxClass, frxBarcode,
  frxDBSet, frxExportPDF, System.UITypes;

type
  TReportsDM = class(TDataModule)
    ReportParams: TFlxMemTable;
    SaveDialog: TSaveDialog;
    dsReport: TDataSource;
    tranRead: TpFIBTransaction;
    spReport: TpFIBDataSet;
    qLoadReport: TpFIBDataSet;
    qLoadReportREPORT: TFIBIntegerField;
    qLoadReportBODY: TFIBBlobField;
    qLoadReportDESCRIPTION: TFIBStringField;
    Report: TfrxReport;
    BarCode: TfrxBarCodeObject;
    RtfAdvExport: TfrxRTFExport;
    JPEGExport: TfrxJPEGExport;
    qLoadReportSQL: TFIBStringField;
    FlexCelReport: TFlexCelReport;
    XLSAdapter: TXLSAdapter;
    spReportThread: TpFIBDataSet;
    spLoadReportThread: TpFIBDataSet;
    sp2: TFIBIntegerField;
    FIBBlobField1: TFIBBlobField;
    FIBStringField1: TFIBStringField;
    FIBStringField2: TFIBStringField;
    frxDBDataset1: TfrxDBDataset;
    spGetProductList: TpFIBDataSet;
    frxPDFExport1: TfrxPDFExport;
    frxPrintA4: TfrxDBDataset;
    spPrintA4: TpFIBDataSet;
    fbstrngfldLoadReportFILENAME: TFIBStringField;
    procedure ReportBeforePrint(Sender: TfrxReportComponent);
  private
    Template : String;
    FParam1G : variant;
    FReportNameG : variant;
    FDatePeriodG : variant;

    procedure FillMemTable;
    {Загружает отчет FastReport из таблицы Report}
    function LoadFastReport(Report: TfrxReport; ReportID: Integer): Boolean;
    function Get_CreateDateTimeStr  : variant;
  public
    property ReportNameG : variant read FReportNameG write FReportNameG;
    property DatePeriodG : variant read FDatePeriodG write FDatePeriodG;
    property Param1G : variant read FParam1G write FParam1G;

    procedure PrepareReport(const ReportCode: Integer);

    // сохранить сразу в файл, 1 - да, 0 - нет
    procedure ShowReport(Save : Integer = 0; Filename : String = '');

    //массив товаров - наименование и цена и штрихкод, куда экспортировать
    procedure PrintLabel(PrinterName : String; PrinterEtiketok : Integer; Sql_str : string; LabeWidth : Integer; PrintPrice: Integer; PriceBold: Integer; PriceSize: Integer;
                         PrintSlogan: Integer; SloganBold: Integer; SloganSize: Integer; Slogan : String; Amount : Integer;
                         SloganOrPrice : Integer; Barcode : String; NameT : String; Price : String;
                         NameBold : Integer; NameSize : Integer);

    //Печать чека
    procedure PrintBill(Zakaz : Integer; SummPoluch : Real; Sdacha : Real; MODE : INTEGER);

    //procedure DIMPLSQL(Variable : String; Size : Integer);
    {Закрыть и уничтожить датасеты (вызывать извне только если не вызвана ShowReport,
     например, в случае ошибки, произошедшей до ShowReport)}
    procedure CloseDataSets(const DeleteReportFile: Boolean);
  published
    property CreateDateTimeStr  : variant read Get_CreateDateTimeStr;
    property DatePeriod  : variant read FDatePeriodG;
    property ReportName  : variant read FReportNameG;
    property Param1      : variant read FParam1G;
  end;

var
  ReportsDM: TReportsDM;

implementation

uses unErrorHandlers, frmMain, dmMain, unCommonFunc, unInitApp;

{$R *.dfm}

procedure TReportsDM.PrepareReport(const ReportCode: Integer);
var i : integer;
  s, templatePath : string;
begin
  if not MainDM.dbMain.Connected then
    {Не подключены к БД}
    Exit;

  IF spReport.Active THEN
    spReport.CLOSE;

  if IsDebugHook = 0 then
    templatePath := ExtractFilePath(Application.exename) + 'Templates\'
  else begin
    if AppName = 'SalonUchet' then
      templatePath := 'C:\CVSWork\Work\RSalonUchetFB\MAIN_SALON\RSalonuchet32\Templates\'
    else
      templatePath := 'C:\CVSWork\Work\ShopUchetFB\MAIN_SHOP\Shopuchet32\Templates\'
  end;

  {Временный файл для шаблона}
  Template := GetUniqTempFile('xls');

  {Читаем отчет из БД}
  try
    if not qLoadReport.Transaction.InTransaction then
      qLoadReport.Transaction.StartTransaction;

    with qLoadReport do begin
      ParamByName('REPORT').AsInteger := ReportCode;
      Open;
      try
        try
          //Сохраняем отчет в потоке и загружаем его в Report
          // 19.03.2018 теперь шаблоны гружу не из базы, а беру из папки
          //(FieldByName('BODY') as TBlobField).SaveToFile(Template);
          //если есть файл вида file_personal.xls, то гружу его, это будет измененный шаблон юзера
          s := Copy(FieldByName('FILENAME').AsString, 1, Pos('.', FieldByName('FILENAME').AsString) - 1) +
            '_personal' + Copy(FieldByName('FILENAME').AsString, Pos('.', FieldByName('FILENAME').AsString));
          if FileExists(templatePath + s) then
            CopyFile(PChar(templatePath + s), PChar(Template), True)
          else
            CopyFile(PChar(templatePath + FieldByName('FILENAME').AsString), PChar(Template), True);

          spReport.SQLs.SelectSQL.Text := TRIM(FieldByName('SQL').AsString);
        finally
        end;
      finally
        Close;
      end;
    end;

    if qLoadReport.Transaction.InTransaction then
      qLoadReport.Transaction.Commit;

    for i := 0 to spReport.ParamCount - 1 do
      spReport.ParamByName(spReport.ParamName(I)).Clear;
  except
    on E: EFIBError do begin
      if qLoadReport.Transaction.InTransaction then
        qLoadReport.Transaction.Rollback;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TReportsDM.PrepareReport)');
    end;
    on E: Exception do begin
      if qLoadReport.Transaction.InTransaction then
        qLoadReport.Transaction.Rollback;
      MessageDlg(E.Message + #13#10'(occured in TReportsDM.PrepareReport)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TReportsDM.FillMemTable;
var
  i, j, z : Integer;
  Arr     : Array of Variant;
  VarName, str, str1 : String;
  DS  : TpFIBDataSet;
  ft : TFieldType;
begin
  ReportParams.Columns.Clear;

  for i := 0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TpFIBDataSet then begin
      DS := Self.Components[i] as TpFIBDataSet;
      if DS.Name <> 'spReport' then
        Continue;

      with DS do begin
        for j := 0 to ParamCount - 1 do begin
          VarName := ParamName(j);
          VarName := copy(VarName, 1, Length(VarName));
          if (VarName <> 'ERR_CODE') and (VarName <> 'ERR_MSG') then begin
            ReportParams.Columns.Add;
            ReportParams.Columns.Items[j].DisplayName := DS.Name + '_' + VarName;

            SetLength(Arr, Length(Arr) + 1);
            Arr[High(Arr)] := DS.ParamByName(VarName).AsString;
          end;
        end;

        for z := 0 to FieldsCount - 1 do begin
          str := FieldName(z);   // вытащил сюда для теста
          str1 := Copy(str, Length(FieldName(z)), 1);
          if str1 = '_' then begin
            ReportParams.Columns.Add;
            ReportParams.Columns.Items[j].DisplayName := Name + '_' + str;

            SetLength(Arr, Length(Arr) + 1);
            ft := FieldByName(str).DataType;
            if ft = ftBCD then
              Arr[High(Arr)] := FieldByName(str).AsFloat
            else
              Arr[High(Arr)] := FieldByName(str).AsString;
            j := j + 1;
          end;
        end;
      end;  //with DS
    end; //if Self.Components[i] is TOracleDataSet
  ReportParams.AddRecord(Arr);
  Arr := nil;
end;

procedure TReportsDM.CloseDataSets(const DeleteReportFile: Boolean);
var
  i   : Integer;
begin
  for i := Self.ComponentCount - 1 downto 0 do
    if (Self.Components[i] is TpFIBDataSet) then begin
      if (Self.Components[i] as TpFIBDataSet).Active then
        (Self.Components[i] as TpFIBDataSet).Close;
      if (AnsiUpperCase(Self.Components[i].Name) <> 'SPREPORTSQL') then
        Self.Components[i].Free;
    end;

  {Удаляем временные файлы}
  if FileExists(FlexCelReport.Template) then
    DeleteFile(PChar(FlexCelReport.Template));

  if DeleteReportFile then
    if FileExists(FlexCelReport.FileName) then
      DeleteFile(PChar(FlexCelReport.Template));
end;

//Save = 0 обычная печать, 1 - сохранить в файл, 2 - для синхронизации, 3 - для экспорта оперативных данных
procedure TReportsDM.ShowReport(Save : Integer = 0; Filename : String = '');
var
  TemplateTempFileName : string;
  TempFilePath         : string;
  ShellRes: HINST;
  ResStr: String;
  ErrCode: Integer;
  ErrMsg : String;
begin
  //FlexCelReport.Template := ExtractFilePath(Application.ExeName) + Template;
  FlexCelReport.Template := Template;

  {Временный файл для шаблона}
  SetLength(TemplateTempFileName, MAX_PATH + 10);
  {Путь к папке TEMP}
  SetLength(TempFilePath, MAX_PATH + 10);

  {Получить путь к папке TEMP}
  GetTempPath(MAX_PATH + 10, @TempFilePath[1]);
  TempFilePath := PChar(TempFilePath);

  {Получить временный файл для шаблона}
  GetTempFileName(PChar(TempFilePath), PChar(Filename){'TPL'} {'OPD_Template'}, 0, @TemplateTempFileName[1]);
  TemplateTempFileName := PChar(TemplateTempFileName);

  TemplateTempFileName := ChangeFileExt(TemplateTempFileName, '.xls');

  FlexCelReport.Filename := TemplateTempFileName;

  if Save = 1 then begin
    if MessageDlg('Сохранить в файл?', mtInformation, [mbYes, mbNo], 0) = mrYes then begin
      SaveDialog.FileName := Filename;
      if SaveDialog.Execute then
        FlexCelReport.Filename := SaveDialog.FileName + '.xls';
    end
  end else if Save in [2, 3] then       // для режима синхронизации и экспорта оперативных данных
    FlexCelReport.Filename := Filename;

  if FileExists(FlexCelReport.FileName) then DeleteFile(PCHAR(FlexCelReport.FileName));

  try
    with spReport do begin
      Close;
      Open;
      if Fields.FindField('ERR_CODE') <> Nil then BEGIN
        ErrCode := FieldByName('ERR_CODE').AsInteger;
        if ErrCode <> 0 then begin
          if Fields.FindField('ERR_MSG').Index >= 0 then begin
            ErrMsg := FieldByName('ERR_MSG').AsString;
            DBErrorHandler(ErrCode, ErrMsg);
          end
          else
            MessageDlg('Error code: ' + IntToStr(ErrCode)
               + #13#10'(occured in TDBListROForm.OpenSP)', mtInformation, [mbOK], 0);
          CloseDataSets(True);
          Exit;
        end;
      END;
    end;
  except
    on E: EFIBError do begin
      if spReport.Transaction.InTransaction then
        spReport.Transaction.CommitRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDlgForm.OpenSP)');
    end;
    on E: Exception do begin
      if spReport.Transaction.InTransaction then
        spReport.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDlgForm.OpenSP)', mtInformation, [mbOk], 0);
    end;
  end;

  FillMemTable;

  FlexCelReport.Run;

  // запускаю Ексель только если это не выгрузка оперативных данных в ексель
  if Save <> 3 then begin
    ShellRes := ShellExecute(MainForm.Handle, 'open', PChar(FlexCelReport.Filename), nil, nil, SW_SHOWNORMAL);
    if ShellRes <= 32 then begin
      case ShellRes of
        0: ResStr := 'The operating system is out of memory or resources';
  //      ERROR_FILE_NOT_FOUND: ResStr := 'The specified file was not found';
  //      ERROR_PATH_NOT_FOUND: ResStr := 'The specified path was not found';
        ERROR_BAD_FORMAT: ResStr := 'The .EXE file is invalid (non-Win32 .EXE or error in .EXE image)';
        SE_ERR_ACCESSDENIED: ResStr := 'The operating system denied access to the specified file';
        SE_ERR_ASSOCINCOMPLETE: ResStr := 'The filename association is incomplete or invalid';
        SE_ERR_DDEBUSY: ResStr := 'The DDE transaction could not be completed because other DDE transactions were being processed';
        SE_ERR_DDEFAIL: ResStr := 'The DDE transaction failed';
        SE_ERR_DDETIMEOUT: ResStr := 'The DDE transaction could not be completed because the request timed out';
        SE_ERR_DLLNOTFOUND: ResStr := 'The specified dynamic-link library was not found';
        SE_ERR_FNF: ResStr := 'The specified file was not found';
        SE_ERR_NOASSOC: ResStr := 'There is no application associated with the given filename extension';
        SE_ERR_OOM: ResStr := 'There was not enough memory to complete the operation';
        SE_ERR_PNF: ResStr := 'The specified path was not found';
        SE_ERR_SHARE: ResStr := 'A sharing violation occurred';
      end;

      MessageDlg('Ошибка запуска Excel: '#13#10 + ResStr, mtInformation, [mbOk], 0);
    end;
  end;

  {
  Построение диаграммы в файле Ексель
const
  xlColumnStacked = 52;
var
  E, Chart: Variant;
  ChartName: string;
  ASheet : TExcelWorksheet;
begin
  E := CreateOleObject('Excel.Application');
  E.Visible := false;
  E.WorkBooks.Open('C:\1\sales_on_date_category.xls');
  E.Workbooks.Application.DisplayAlerts := False;
  Chart := E.Charts.Add;
  Chart.ChartType := xlColumnStacked;
  Chart.SeriesCollection.Add(Source := E.WorkBooks[1].Sheets.Item[2].Range['A8:B20']);
  Chart.HasTitle:= true;
  Chart.ChartTitle.Shadow := False;
  Chart.ChartTitle.font.size := 15;
  Chart.ChartTitle.font.Color := clGreen;
  Chart.ChartTitle.font.italic := true;
  Chart.ChartTitle.Text := ChartName;
  Chart.PlotArea.Border.Weight := 2;
  Chart.PlotArea.Border.LineStyle := XlDot;

  Chart := Chart.Location(xlLocationAsObject, 'Лист1');
  E.ActiveSheet.Shapes.Item(1).Left := E.ActiveSheet.Range['A8:C8', EmptyParam].Width + 40;
  E.ActiveSheet.Shapes.Item(1).Top := 80;
  E.ActiveSheet.Shapes.Item(1).Width := 400;
  E.ActiveSheet.Shapes.Item(1).Height := 250;

  E.WorkBooks[1].saveas('C:\1\done.xls');
  E.WorkBooks[1].Close;
  E.Quit;
  E := UnAssigned;
  ShowMessage('okai');
  }
end;

procedure TReportsDM.PrintLabel(PrinterName : String; PrinterEtiketok : Integer; Sql_str : string; LabeWidth : Integer; PrintPrice: Integer; PriceBold: Integer; PriceSize: Integer;
                                PrintSlogan: Integer; SloganBold: Integer; SloganSize: Integer; Slogan : String; Amount : Integer;
  SloganOrPrice : Integer; Barcode : String; NameT : String; Price : String;
  NameBold : Integer; NameSize : Integer);
const
  SymbArr : array [1..10] of string = ('\', '/', ':', '*', '.', '?', '"', '<', '>', '|'); // запрещенные символы в имени файла
var FCur : string;
    onBeforePrint : TfrxBeforePrintEvent;
begin
  try
    onBeforePrint := Report.OnBeforePrint;
    Report.OnBeforePrint := nil;

    if CurrencyVal = 0 then
      FCur := 'тг'
    else if CurrencyVal = 1 then
      FCur := 'руб'
    else if CurrencyVal = 2 then
      FCur := 'грн';

    if PrinterEtiketok = 1 then begin
      if LabeWidth = 0 then begin      //29х20
        LoadFastReport(Report, 1);
        NameT := Copy(NameT, 1, 30);   // обрежу слишком длинное наименование
      end else if LabeWidth = 1 then begin   // 30х15
        // размер 30х15 проблема в том, что китайский принтер Rongta, который скорее всего юзают большинство,
        // не воспринимает размеры меньше 19 мм, и начинает печатать все копии на одной этикетке, накладывая их друг на друга
        // не знал как вылечить и потому просто сделал фактический размер 30х19, и на ней разместил все снизу, при печати получается, что все
        // элементы размещаются аккуратно на 30х15 этикетке. Но при експорте в файл выдается реальный размер, пришлось для этого сделать
        // второй шаблон этикетки с фактическим размером 30х15
        LoadFastReport(Report, 33);
        NameT := Copy(NameT, 1, 30);
      end else if LabeWidth = 2 then begin   // 43х25
        LoadFastReport(Report, 16);
        NameT := Copy(NameT, 1, 45);
      end else if LabeWidth = 3 then begin   // 47х25
        LoadFastReport(Report, 17);
        NameT := Copy(NameT, 1, 50);
      end else if LabeWidth = 4 then begin   // 57х45
        LoadFastReport(Report, 18);
        NameT := Copy(NameT, 1, 50);
      end else if LabeWidth = 5 then begin   // 58х30
        LoadFastReport(Report, 19);
        NameT := Copy(NameT, 1, 45);
      end else if LabeWidth = 6 then begin   // 58х40
        LoadFastReport(Report, 2);
        NameT := Copy(NameT, 1, 45);
      end else if LabeWidth = 7 then begin   // 58х60
        LoadFastReport(Report, 20);
        NameT := Copy(NameT, 1, 100);
      end else if LabeWidth = 8 then begin   // 58х100
        LoadFastReport(Report, 21);
        NameT := Copy(NameT, 1, 100);
      end else if LabeWidth = 9 then begin   // 100х70
        LoadFastReport(Report, 22);
        NameT := Copy(NameT, 1, 80);
      end;

      if Length(Barcode) = 8 then
        Report.Variables['barcode8'] := '''' + Barcode + '''';
      Report.Variables['name_t'] := '''' + NameT + '''';
      if PrintPrice = 1 then
        Report.Variables['price'] := '''' + 'Цена ' + Price + ' ' + '''';
    end else begin
      if LabeWidth = 0 then
        LoadFastReport(Report, 48)
      else
        LoadFastReport(Report, 49);
    end;

    if Length(Barcode) = 13 then
      Report.Variables['barcode13'] := '''' + Barcode + '''';

    Report.Variables['print_price'] := '''' + IntToStr(PrintPrice) + '''';
    Report.Variables['print_slogan'] := '''' + IntToStr(PrintSlogan) + '''';

    Report.Variables['name_bold'] := '''' + IntToStr(NameBold) + '''';
    Report.Variables['name_size'] := '''' + IntToStr(NameSize) + '''';

    Report.Variables['price_bold'] := '''' + IntToStr(PriceBold) + '''';
    Report.Variables['price_size'] := '''' + IntToStr(PriceSize) + '''';

    if PrintSlogan = 1 then
      Report.Variables['slogan'] := '''' + Slogan + '''';
    Report.Variables['slogan_bold'] := '''' + IntToStr(SloganBold) + '''';
    Report.Variables['slogan_size'] := '''' + IntToStr(SloganSize) + '''';

    if PrinterEtiketok = 1 then begin
      Report.PrepareReport;

      Report.printOptions.copies := Amount;
      Report.PrintOptions.ShowDialog := False;
      Report.PrintOptions.Printer := PrinterName;
      Report.SelectPrinter();
      Report.Print;

    end else begin
      try
        Report.PreviewOptions.ThumbnailVisible := True;
        spPrintA4.SelectSQL.Text := Sql_str;
        OpenSP(spPrintA4, False);
        Report.ShowReport;
      finally
        spPrintA4.Close;
      end;
    end;
  finally
    Report.OnBeforePrint := onBeforePrint;
  end;
end;

procedure TReportsDM.PrintBill(Zakaz : Integer; SummPoluch : Real; Sdacha : Real; MODE : INTEGER);
begin
  if BillWidth = 0 then begin
    LoadFastReport(Report, 24);
    PrepareReport(24);
  end else if BillWidth = 1 then begin
    LoadFastReport(Report, 25);
    PrepareReport(25);
  end else begin
    LoadFastReport(Report, 29);
    PrepareReport(29);
  end;

  spReport.ParamByName('zakaz_').AsInteger := Zakaz;
  spReport.ParamByName('SUMM_DANO_').AsFloat := SummPoluch;
  spReport.ParamByName('SUMM_SDACHA_').AsFloat := Sdacha;
  spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
  spReport.ParamByName('MODE_').AsInteger := Mode;
  spReport.ParamByName('SLOGAN_').AsString := BillSlogan;

  Report.PrepareReport;
  Report.printOptions.copies := 1;
  Report.PrintOptions.ShowDialog := False;
  Report.PrintOptions.Printer := BillPrinter;
  Report.SelectPrinter();
  Report.Print;
end;

function TReportsDM.LoadFastReport(Report: TfrxReport; ReportID: Integer): Boolean;
{Загружает отчет FastReport из таблицы Report}
var
  MStream : TMemoryStream;
  s : string;
  templatePath : string;
begin
  Result := False;

  if not MainDM.dbMain.Connected then
    {Не подключены к БД}
    Exit;

  if IsDebugHook = 0 then
    templatePath := ExtractFilePath(Application.exename) + 'Templates\'
  else
    templatePath := 'C:\CVSWork\Work\ShopUchetFB\MAIN_SHOP\Shopuchet32\Templates\';

  {Читаем отчет из БД}
  try
    if not qLoadReport.Transaction.InTransaction then
      qLoadReport.Transaction.StartTransaction;

    with qLoadReport do begin
      ParamByName('REPORT').AsInteger := ReportID;
      Open;
      try
        MStream := TMemoryStream.Create;
        try
          {Сохраняем отчет в потоке и загружаем его в Report}
          //(FieldByName('BODY') as TBlobField).SaveToStream(MStream);
          //MStream.Seek(0, soFromBeginning);
                    //если есть файл вида file_personal.xls, то гружу его, это будет измененный шаблон юзера
          s := Copy(FieldByName('FILENAME').AsString, 1, Pos('.', FieldByName('FILENAME').AsString) - 1) +
            '_personal' + Copy(FieldByName('FILENAME').AsString, Pos('.', FieldByName('FILENAME').AsString));
          if FileExists(templatePath + s) then
            MStream.LoadFromFile(templatePath + S)
          else
            MStream.LoadFromFile(templatePath + FieldByName('FILENAME').AsString);

          Report.LoadFromStream(MStream);
        finally
          MStream.Free;
        end;
      finally
        Close;
      end;
    end;
    Result := True;

    if qLoadReport.Transaction.InTransaction then
      qLoadReport.Transaction.Commit;
  except
    on E: EFIBError do begin
      if qLoadReport.Transaction.InTransaction then
        qLoadReport.Transaction.Rollback;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in unDBSupport.LoadReport)');
    end;
    on E: Exception do begin
      if qLoadReport.Transaction.InTransaction then
        qLoadReport.Transaction.Rollback;
      MessageDlg(E.Message + #13#10'(occured in ReportDM.LoadReport)', mtError, [mbOk], 0);
    end;
  end;
end;

// сдвиг чека влево, у всех принтеры разные, пусть сами сдвигают
procedure TReportsDM.ReportBeforePrint(Sender: TfrxReportComponent);
begin
  if Sender is TfrxBand then
    Report.Engine.Curx := BillSdvig;
end;

function TReportsDM.Get_CreateDateTimeStr: variant;
var
  TmpStr : String;
begin
  DateTimeToString(TmpStr, 'dd.mm.yyyy hh:nn', Date);
  Result := 'Дата формирования ' + TmpStr;
end;

end.
