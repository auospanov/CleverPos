unit dmReports;

interface

uses
  SysUtils, Classes, DB, FIBDataSet, pFIBDataSet, FIBDatabase, VCL.ExtCtrls,
  pFIBDatabase, Dialogs, UExcelAdapter, XLSAdapter, UFlxMemTable,
  UCustomFlexCelReport, UFlexCelReport, Vcl.Forms, Windows, Controls, FIB, ShellApi, FileCtrl,
  frxExportImage, frxExportRTF, frxClass, frxBarcode, System.Math,
  frxDBSet, frxExportPDF, System.UITypes, UFlexCelImport, UFlxFormats, Vcl.Graphics,
  dxmdaset, DelphiZXingQRCode;

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
    FlexCelImport: TFlexCelImport;
    qLoadReportCOORD: TStringField;
    spUniversal: TpFIBDataSet;
    spUniversalWrite: TpFIBDataSet;
    tranWrite: TpFIBTransaction;
    mdReportX: TdxMemData;
    strngfldmd1Names: TStringField;
    frxDBDataset2: TfrxDBDataset;
    strngfldReportXValues: TStringField;
    spRekvizit: TpFIBDataSet;
    spReadDiscount: TpFIBDataSet;
    procedure ReportBeforePrint(Sender: TfrxReportComponent);
    procedure ReportGetValue(const VarName: string; var Value: Variant);
  private
    Template : String;
    FParam1G : variant;
    FReportNameG : variant;
    FDatePeriodG : variant;
    FDateTimeG : variant;
    FDecimalCountG : variant;
    procedure FillMemTable;
    function Get_CreateDateTimeStr  : variant;


  public
    FBillSdvig : Integer;
    //Переменные для QRCode
    NDS_SUM: Double;
    FQRCODE: TDelphiZXingQRCode;
    TmpPaint: TPaintBox;
    //Создание объекта для работы с QR
    procedure CreateQR;
    procedure QRRemake(txt: string);
    procedure Paint(Sender: TObject);
    procedure DestroyQR;
    function SaveQR(txt: string): boolean;
    procedure SaveQRToFile(FQRCODE: TDelphiZXingQRCode);
    {Загружает отчет FastReport из таблицы Report}
    function LoadFastReport(Report: TfrxReport; ReportID: Integer): Boolean;
    property ReportNameG : variant read FReportNameG write FReportNameG;
    property DatePeriodG : variant read FDatePeriodG write FDatePeriodG;
    property DecimalCountG : variant read FDecimalCountG write FDecimalCountG;
    property DateTimeG : variant read FDateTimeG write FDateTimeG;
    property Param1G : variant read FParam1G write FParam1G;

    procedure PrepareReport(const ReportCode: Integer);

    // сохранить сразу в файл, 1 - да, 0 - нет
    procedure ShowReport(Save : Integer = 0; Filename : String = '');

    //массив товаров - наименование и цена и штрихкод, куда экспортировать
    procedure PrintLabel(PrinterName : String; PrinterEtiketok : Integer; Sql_str : string; LabeWidth : Integer;
                         PrintPrice: Integer; PriceBold: Integer; PriceSize: Integer;
                         PrintArticul: Integer; ArticulBold: Integer; ArticulSize: Integer;
                         PrintSlogan: Integer; SloganBold: Integer; SloganSize: Integer; Slogan : String; Amount : Integer;
                         SloganOrPrice : Integer; Barcode, Articul, NNomer, Brand : String; NameT : String; Price : String;
                         G_PRODUCT: Int64; NameBold : Integer; NameSize : Integer; Sdvig : Integer;
                         Mode : Integer = 0);

    //Печать чека на принтере чеков/ФР
    procedure PrintBill(Zakaz : Int64; SummZakaz, SummCash, SummNonCash: Double;
    Sdacha : Real; MODE : INTEGER; Decimal : integer; Bonus : Real; Address : String;
    FromSales : Boolean; PrintOnPrintersLoc : Boolean; PrintOnFrLoc : Boolean; TotalBonus: Double; TypeTis: Integer);

    //Печать отчета через ФастРепорт
    procedure PrintFastReport(ReportId : integer; arrParams, arrPics : array of String);


    //procedure DIMPLSQL(Variable : String; Size : Integer);
    {Закрыть и уничтожить датасеты (вызывать извне только если не вызвана ShowReport,
     например, в случае ошибки, произошедшей до ShowReport)}
    procedure CloseDataSets(const DeleteReportFile: Boolean);

  published
    property CreateDateTimeStr  : variant read Get_CreateDateTimeStr;
    property DatePeriod  : variant read FDatePeriodG;
    property ReportName  : variant read FReportNameG;
    property DecimalCount : variant read FDecimalCountG;
    property DateTime    : variant read FDateTimeG;
    property Param1      : variant read FParam1G;
  end;

var
  ReportsDM: TReportsDM;

implementation

uses unErrorHandlers, frmMain, dmMain, unCommonFunc, unInitApp, QRGraphics, QR_URL, QR_Win1251;

{$R *.dfm}



procedure TReportsDM.PrepareReport(const ReportCode: Integer);
var i, p, posCoord, posSemi : integer;
  s, templatePath, str, str1, row, strCoord, strCoord1 : string;
  fmt : TFlxFormat;
begin
  if not MainDM.dbMain.Connected then
    {Не подключены к БД}
    Exit;

  IF spReport.Active THEN
    spReport.CLOSE;

  if IsDebugHook = 0 then
    templatePath := ExtractFilePath(Application.exename) + 'Templates\'
  else begin
    if AppName = 'salonuchet' then
      templatePath := 'C:\CVSWork\Work\RSalonUchetFB\MAIN_SALON\RSalonuchet32\Templates\'
    else if AppName = 'serviceuchet' then
      templatePath := 'C:\CVSWork\Work\TServiceUchetFb\MAIN_SERVICE\TServiceuchet32\Templates\'
    else
      templatePath := 'C:\CVSWork\Work\ShopUchetFB\MAIN_SHOP\Shopuchet32\Templates\'
  end;

  {Временный файл для шаблона}
  Template := GetUniqTempFile('xls');

  {Читаем отчет из БД}
  try
    if not qLoadReport.Transaction.InTransaction then
      qLoadReport.Transaction.StartTransaction;

    qLoadReport.ParamByName('REPORT').AsInteger := ReportCode;
    qLoadReport.Open;
    try
      //Сохраняем отчет в потоке и загружаем его в Report
      // 19.03.2018 теперь шаблоны гружу не из базы, а беру из папки
      //(FieldByName('BODY') as TBlobField).SaveToFile(Template);
      //если есть файл вида file_personal.xls, то гружу его, это будет измененный шаблон юзера
      s := Copy(qLoadReport.FieldByName('FILENAME').AsString, 1, Pos('.', qLoadReport.FieldByName('FILENAME').AsString) - 1) +
        '_personal' + Copy(qLoadReport.FieldByName('FILENAME').AsString, Pos('.', qLoadReport.FieldByName('FILENAME').AsString));
      if FileExists(templatePath + s) then
        CopyFile(PChar(templatePath + s), PChar(Template), True)
      else
        CopyFile(PChar(templatePath + qLoadReport.FieldByName('FILENAME').AsString), PChar(Template), True);

      spReport.SQLs.SelectSQL.Text := TRIM(qLoadReport.FieldByName('SQL').AsString);

      // если DecimalCount <> 2 и колонка COORD не пустая, значит надо переделывать колонку со значением запятых
      // и персональные шаблоны не трогаю
      if (FormatSettings.CurrencyDecimals <> 2) and (qLoadReport.FieldByName('COORD').AsString <> '') and
      not (FileExists(templatePath + s)) then begin
        strCoord := qLoadReport.FieldByName('COORD').AsString;
        //внешний цикл по "строка-колонка ; строка-колонка"
        while Length(strCoord) > 0 do begin
          posCoord := pos(';', strCoord);

          if posCoord > 0 then
            strCoord1 := Copy(strCoord, 1, posCoord-1)
          else
            strCoord1 := strCoord;

          //внутренний цикл по "строка-колонка"
          posSemi := pos(':', strCoord1);
          row := Copy(strCoord1, 1, posSemi-1);
          FlexCelImport.OpenFile(Template);
          Str := Copy(strCoord1, posSemi + 1);
          p := pos('-', Str);

          if p > 0 then begin
            str1 := Copy(Str, 1, p-1);
            FlexCelImport.GetCellFormatDef(StrToInt(row), StrToInt(str1), fmt);
          end else
            FlexCelImport.GetCellFormatDef(StrToInt(row), StrToInt(str), fmt);

          if FormatSettings.CurrencyDecimals = 0 then
            fmt.Format := '#0'
          else
            fmt.Format := '#,##0.'.PadRight(6 + FormatSettings.CurrencyDecimals, '0');
          i := FlexCelImport.AddFormat(fmt);

          if p > 0 then
            FlexCelImport.CellFormat[StrToInt(row), StrToInt(str1)] := i
          else
            FlexCelImport.CellFormat[StrToInt(row), StrToInt(str)] := i;

          if p > 0 then begin
            Delete(str, 1, p);    // удаляю первую ячейку, т.к. по ней уже все сделал
            while Length(Str) > 0 do begin
              p := pos('-', Str);

              if p > 0 then begin
                str1 := Copy(Str, 1, p-1);
                if str1 <> '' then
                  FlexCelImport.CellFormat[StrToInt(row), StrToInt(str1)] := i;
                Delete(str, 1, p);
              end else begin
                FlexCelImport.CellFormat[StrToInt(row), StrToInt(str)] := i;
                str := '';
              end;
            end;
          end;
          //конец внутренний цикл

          FlexCelImport.Save(Template);

          if posCoord > 0 then
            Delete(strCoord, 1, posCoord)
          else
            strCoord := '';
        end;

        FlexCelImport.CloseFile;
      end;
    finally
      qLoadReport.Close;
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

  //ShowMessage(TempFilePath);
  {Получить временный файл для шаблона}
  GetTempFileName(PChar(TempFilePath), PChar(Filename){'TPL'} {'OPD_Template'}, 0, @TemplateTempFileName[1]);
  TemplateTempFileName := PChar(TemplateTempFileName);

  TemplateTempFileName := ChangeFileExt(TemplateTempFileName, '.xls');

  //ShowMessage(TemplateTempFileName);

  FlexCelReport.Filename := TemplateTempFileName;

  {if Save = 1 then begin
    if MessageDlg('Сохранить в файл?', mtInformation, [mbYes, mbNo], 0) = mrYes then begin
      SaveDialog.FileName := Filename;
      if SaveDialog.Execute then
        FlexCelReport.Filename := SaveDialog.FileName + '.xls';
    end
  end else} if Save in [2, 3] then       // для режима синхронизации и экспорта оперативных данных
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
  //ShowMessage(FlexCelReport.Filename);
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

procedure TReportsDM.PrintLabel(PrinterName : String; PrinterEtiketok : Integer; Sql_str : string;
  LabeWidth : Integer; PrintPrice: Integer; PriceBold: Integer; PriceSize: Integer;
  PrintArticul: Integer; ArticulBold: Integer; ArticulSize: Integer;
  PrintSlogan: Integer; SloganBold: Integer; SloganSize: Integer; Slogan : String; Amount : Integer;
  SloganOrPrice : Integer; Barcode, Articul, NNomer, Brand : String; NameT : String; Price : String;
  G_PRODUCT: int64; NameBold : Integer; NameSize : Integer; Sdvig : Integer;
  Mode : Integer      // 0 - Этикетки, 1 - Ценники
);
const
  SymbArr : array [1..10] of string = ('\', '/', ':', '*', '.', '?', '"', '<', '>', '|'); // запрещенные символы в имени файла
var FCur : string;
    onBeforePrint : TfrxBeforePrintEvent;
    PriceDiscount: string;
begin
  try
    //FBillSdvig := Sdvig;
    onBeforePrint := Report.OnBeforePrint;
    Report.OnBeforePrint := nil;
    if G_PRODUCT<>0 then
    begin
      spReadDiscount.Close;
      spReadDiscount.Open;
      if spReadDiscount.Locate('G_PRODUCT', G_PRODUCT, [loCaseInsensitive]) then
      begin
        PriceDiscount := FloatToStr(Round(StrToFloat(Price) - spReadDiscount.FieldByName('SKIDKA_SUM').AsFloat));//FloatToStr(Round(StrToFloat(Price)-(StrToFloat(Price) / 100 * spReadDiscount.FieldByName('SKIDKA_PROC').AsFloat)));
      end
      else
        PriceDiscount := '';
    end;
    if CurrencyVal = 0 then
      FCur := 'тг'
    else if CurrencyVal = 1 then
      FCur := 'руб'
    else if CurrencyVal = 2 then
      FCur := 'грн';

    if PrinterEtiketok = 1 then
    begin
      if LabeWidth = 0 then
      begin      //29х20
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
        NameT := Copy(NameT, 1, 65);
      end else if LabeWidth = 6 then begin   // 58х40
        LoadFastReport(Report, 2);
        NameT := Copy(NameT, 1, 65);
      end else if LabeWidth = 7 then begin   // 58х60
        LoadFastReport(Report, 20);
        NameT := Copy(NameT, 1, 100);
      end else if LabeWidth = 8 then begin   // 58х100
        LoadFastReport(Report, 21);
        NameT := Copy(NameT, 1, 100);
      end else if LabeWidth = 9 then begin   // 100х70
        LoadFastReport(Report, 22);
        NameT := Copy(NameT, 1, 80);
      end else if LabeWidth = 10 then begin   // 66x15
        LoadFastReport(Report, 68);
        NameT := Copy(NameT, 1, 80);
      end;

      {if Length(Barcode) = 8 then
        Report.Variables['barcode8'] := '''' + Barcode + ''''; }
      case Length(Barcode) of
        8:  Report.Variables['bar_type'] := 1;
        12: Report.Variables['bar_type'] := 2;
        else
          Report.Variables['bar_type'] := 3;
      end;
      Report.Variables['barcode'] := Barcode;
      Report.Variables['name_t'] := '''' + NameT + '''';
      if PrintPrice = 1 then
      begin
        //Report.Variables['price'] := '''' + 'Цена ' + Price + ' ' + '''';
        Report.Variables['price'] := '''' + Price + ' ' + '''';
        Report.Variables['PriceDiscount'] := '''' + PriceDiscount + '''';
      end;
      if PrintArticul = 1 then begin
        Report.Variables['articul'] := '''' + 'арт. ' + Articul + ' ' + '''';
      end;
      // пока эти 2 переменные я сделал только для одного клиента
      Report.Variables['nnomer'] := '''' + 'Н/н ' + NNomer + ' ' + '''';
      Report.Variables['brand'] := '''' + 'Бренд ' + Brand + ' ' + '''';
    end else begin

      if Mode = 0 then begin
        if LabeWidth = 0 then
          LoadFastReport(Report, 48)
        else if LabeWidth = 1 then
          LoadFastReport(Report, 49)
        else if LabeWidth = 2 then
          LoadFastReport(Report, 105)
        else if LabeWidth = 3 then
          LoadFastReport(Report, 62)
        else if LabeWidth = 4 then
          LoadFastReport(Report, 88);
      end
      else begin
        if LabeWidth = 0 then            //35х60
          LoadFastReport(Report, 63)
        else if LabeWidth = 1 then            //40х60
          LoadFastReport(Report, 65)
        else if LabeWidth = 2 then       //70 x 24.5
          LoadFastReport(Report, 106)
        else if LabeWidth = 3 then       //70 x 35
          LoadFastReport(Report, 89)
        else if LabeWidth = 4 then       //A5
          LoadFastReport(Report, 64);
      end;
    end;

    {if Length(Barcode) = 13 then
      Report.Variables['barcode13'] := '''' + Barcode + ''''; }

    Report.Variables['print_price'] := '''' + IntToStr(PrintPrice) + '''';
    Report.Variables['print_articul'] := '''' + IntToStr(PrintArticul) + '''';
    Report.Variables['print_slogan'] := '''' + IntToStr(PrintSlogan) + '''';

    Report.Variables['name_bold'] := '''' + IntToStr(NameBold) + '''';
    Report.Variables['name_size'] := '''' + IntToStr(NameSize) + '''';

    Report.Variables['price_bold'] := '''' + IntToStr(PriceBold) + '''';
    Report.Variables['price_size'] := '''' + IntToStr(PriceSize) + '''';

    Report.Variables['articul_bold'] := '''' + IntToStr(ArticulBold) + '''';
    Report.Variables['articul_size'] := '''' + IntToStr(ArticulSize) + '''';

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

procedure TReportsDM.PrintBill(Zakaz : Int64; SummZakaz, SummCash, SummNonCash: Double;
Sdacha : Real; MODE : INTEGER; Decimal : integer; Bonus : Real; Address : String;
FromSales : Boolean; PrintOnPrintersLoc : Boolean; PrintOnFrLoc : Boolean; TotalBonus: Double; TypeTis: Integer);
var
  i, BillWidth : integer;
  terminals: Integer;
begin
  //IF PrintOnPrintersLoc THEN
  //BEGIN
  IF (PrintOnFrLoc = True) and (CheckPrintDeviceFr IN [1,2,3,4,5,6]) THEN
  BEGIN
    case CheckPrintDeviceFr of
        5:
        begin
          if ReportsDM.SaveQR(KKMReKassa.qrCode) then
          begin
            if PrinterRekassa.Name = '' then
            begin
              Showmessage('Чековый принтер не настроен! Укажите его в настройках программы! Печать чеков невоможна!');
              Exit;
            end;

              if PrinterRekassa.BillWidth = '80 мм' then
                BillWidth := 0
              else if PrinterRekassa.BillWidth = '58 мм' then
                BillWidth := 1
              else
                BillWidth := 2;

              case BillWidth of
                0:
                begin
                  ReportsDM.LoadFastReport(ReportsDM.Report, 73);
                  ReportsDM.PrepareReport(73);
                end;
                1:
                begin
                  ReportsDM.LoadFastReport(ReportsDM.Report, 78);
                  ReportsDM.PrepareReport(78);
                end;
                else
                begin
                  ReportsDM.LoadFastReport(ReportsDM.Report, 79);
                  ReportsDM.PrepareReport(79);
                end;
              end;

              ReportsDM.FBillSdvig := PrinterRekassa.BillSdvig;
              {ReportsDM.spUniversal.ParamByName('zakaz_').AsInt64 := LastCheck;
              if not OpenSp(ReportsDM.spUniversal, False) then
                Exit;}
              ReportsDM.spReport.ParamByName('zakaz_').AsInt64 := Zakaz;
              ReportsDM.spReport.ParamByName('SUMM_DANO_').AsFloat := SummCash;// + SummNonCash;
              ReportsDM.spReport.ParamByName('SUMM_SDACHA_').AsFloat := Sdacha;  //MIN(SummCash + SummNonCash - SummZakaz, SummZakaz - SummCash - SummNonCash);
              ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
              ReportsDM.spReport.ParamByName('MODE_').AsInteger := 0;
              ReportsDM.spReport.ParamByName('PRINT_SLOGAN_').AsString := BillSlogan;
              ReportsDM.spReport.ParamByName('DECIMAL_').AsInteger := FormatSettings.CurrencyDecimals;

              if BillPrintChargedBonus = 1 then
              begin
                ReportsDM.spReport.ParamByName('BONUS_').AsFloat := Bonus;
                ReportsDM.spReport.ParamByName('BONUS_ALL_').AsFloat := TotalBonus;
              end;

              if DeliveryService = 1 then
                ReportsDM.spReport.ParamByName('ADDRESS_').AsString := Address;

              ReportsDM.Report.Variables['is_kafe'] := '''' + IntToStr(KafeTovarView) + '''';
              ReportsDM.Report.PrepareReport;
              ReportsDM.Report.printOptions.copies := PrinterRekassa.BillQuantity;
              ReportsDM.Report.PrintOptions.ShowDialog := False;
              ReportsDM.Report.PrintOptions.Printer := PrinterRekassa.Name;
              ReportsDM.Report.SelectPrinter();
              ReportsDM.Report.Print;
          end;
        end;
        6:
        begin
          case TypeTis of
            0: Terminals := 0;
            else
              Terminals := Terminal;
          end;
          if Terminals>0 then
          begin
            try
              ReportsDM.spUniversalWrite.Close;
              with ReportsDM.spUniversalWrite do
              begin
                SQLs.SelectSQL.Clear;
                SQLs.SelectSQL.Add('UPDATE ZAKAZ SET POS_PAY_TRANSACTION_ID = ?POS_PAY_TRANSACTION_ID, POS_PAY_METHOD = ?POS_PAY_METHOD,'+
                'POS_TERMINAL = ?POS_TERMINAL WHERE ZAKAZ = ?ZAKAZ_');
                ParamByName('ZAKAZ_').AsInt64 := Zakaz;
                ParamByName('POS_PAY_TRANSACTION_ID').AsWideString := KKMTIS.IDTransatction_;
                ParamByName('POS_TERMINAL').AsInteger := Terminals;
                ParamByName('POS_PAY_METHOD').AsInteger := TypeTis;
                OpenSP(ReportsDM.spUniversalWrite, False);
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
            except
              on E: EFIBError do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
              on E: Exception do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
            end;
          end;


          if ReportsDM.SaveQR(KKMTIS.qrCode) then
          begin
            if PrinterRekassa.Name = '' then
            begin
              ShowMessage('Чековый принтер не настроен! Укажите его в настройках программы! Печать чеков невоможна!');
              Exit;
            end;

            if PrinterRekassa.BillWidth = '80 мм' then
              BillWidth := 0
            else if PrinterRekassa.BillWidth = '58 мм' then
              BillWidth := 1
            else
              BillWidth := 2;

            case BillWidth of
              0:
              begin
                ReportsDM.LoadFastReport(ReportsDM.Report, 90);
                ReportsDM.PrepareReport(90);
              end;
              1:
              begin
                ReportsDM.LoadFastReport(ReportsDM.Report, 95);
                ReportsDM.PrepareReport(95);
              end;
              else
              begin
                ReportsDM.LoadFastReport(ReportsDM.Report, 96);
                ReportsDM.PrepareReport(96);
              end;
            end;

            ReportsDM.FBillSdvig := PrinterRekassa.BillSdvig;

            ReportsDM.spReport.ParamByName('zakaz_').AsInt64 := Zakaz;
            ReportsDM.spReport.ParamByName('SUMM_DANO_').AsFloat := SummCash;// + SummNonCash;
            ReportsDM.spReport.ParamByName('SUMM_SDACHA_').AsFloat := Sdacha;  //MIN(SummCash + SummNonCash - SummZakaz, SummZakaz - SummCash - SummNonCash);
            ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
            ReportsDM.spReport.ParamByName('MODE_').AsInteger := 0;
            ReportsDM.spReport.ParamByName('PRINT_SLOGAN_').AsString := BillSlogan;
            ReportsDM.spReport.ParamByName('DECIMAL_').AsInteger := FormatSettings.CurrencyDecimals;
            if BillPrintChargedBonus = 1 then
            begin
              ReportsDM.spReport.ParamByName('BONUS_').AsFloat := Bonus;
              ReportsDM.spReport.ParamByName('BONUS_ALL_').AsFloat := TotalBonus;
            end;

            if DeliveryService = 1 then
              ReportsDM.spReport.ParamByName('ADDRESS_').AsString := Address;

            ReportsDM.Report.Variables['is_kafe'] := '''' + IntToStr(KafeTovarView) + '''';

            ReportsDM.Report.PrepareReport;
            ReportsDM.Report.printOptions.copies := PrinterRekassa.BillQuantity;
            ReportsDM.Report.PrintOptions.ShowDialog := False;
            ReportsDM.Report.PrintOptions.Printer := PrinterRekassa.Name;
            ReportsDM.Report.SelectPrinter();
            ReportsDM.Report.Print;
          end;
        end;
      end;
  END
  ELSE
  BEGIN
    if High(PrintersArr) = -1 then
    begin
      MessageDlg('Чековый принтер не настроен! Укажите его в настройках программы! Печать чеков невоможна!', mtWarning, [mbOk], 0);
      Exit;
    end;

    for I := 0 to High(PrintersArr) do
    begin
      if PrintersArr[i].Name = '' then begin
        MessageDlg('Чековый принтер не настроен! Укажите его в настройках программы! Печать чеков невоможна!', mtWarning, [mbOk], 0);
        Exit;
      end;

      if PrintersArr[i].BillWidth = '80 мм' then
        BillWidth := 0
      else if PrintersArr[i].BillWidth = '58 мм' then
        BillWidth := 1
      else
        BillWidth := 2;

      case BillWidth of
        0:
        begin
          LoadFastReport(Report, 24);
          PrepareReport(24);
        end;
        1:
        begin
          LoadFastReport(Report, 25);
          PrepareReport(25);
        end;
        else
        begin
          LoadFastReport(Report, 29);
          PrepareReport(29);
        end;
      end;

      FBillSdvig := PrintersArr[i].BillSdvig;

      spReport.ParamByName('zakaz_').AsInt64 := Zakaz;
      spReport.ParamByName('SUMM_DANO_').AsFloat := SummCash;// + SummNonCash;
      spReport.ParamByName('SUMM_SDACHA_').AsFloat := Sdacha;  //MIN(SummCash + SummNonCash - SummZakaz, SummZakaz - SummCash - SummNonCash);
      spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
      spReport.ParamByName('MODE_').AsInteger := Mode;
      spReport.ParamByName('PRINT_SLOGAN_').AsString := BillSlogan;
      spReport.ParamByName('DECIMAL_').AsInteger := Decimal;
      if BillPrintChargedBonus = 1 then
      begin
        spReport.ParamByName('BONUS_').AsFloat := Bonus;
        spReport.ParamByName('BONUS_ALL_').AsFloat := TotalBonus;
      end;
      if DeliveryService = 1 then
        spReport.ParamByName('ADDRESS_').AsString := Address;

      Report.Variables['is_kafe'] := '''' + IntToStr(KafeTovarView) + '''';
      Report.Variables['print_barcode'] := '''' + IntToStr(BillPrintBarcode) + '''';
      Report.PrepareReport;
      Report.printOptions.copies := PrintersArr[i].BillQuantity;
      Report.PrintOptions.ShowDialog := False;
      Report.PrintOptions.Printer := PrintersArr[i].Name;
      Report.SelectPrinter();
      Report.Print;
    end;
  END;
end;

// Печать отчета через FastReport
procedure TReportsDM.PrintFastReport(ReportId : integer; arrParams, arrPics: array of String);
var
  Picture1: TfrxPictureView;
  FormImage: TBitmap;
  TempStream : TMemoryStream;
  onBeforePrint : TfrxBeforePrintEvent;
  i : integer;
begin
  try
    onBeforePrint := Report.OnBeforePrint;
    Report.OnBeforePrint := nil;

    LoadFastReport(Report, ReportId);

    if High(arrPics) > 0 then begin

        for I := 0 to High(arrPics) do begin
          FormImage := TBitmap.Create;
          TempStream := TMemoryStream.Create;

          try
            FormImage.LoadFromFile(arrPics[i]);
            Picture1 := Report.FindObject('pic' + IntToStr(i+1)) as TfrxPictureView;
            FormImage.SaveToStream(TempStream);
            TempStream.position := 0;
            Picture1.Picture.Bitmap.LoadFromStream(TempStream);
          finally
            FormImage.Free;
            TempStream.Free;
          end;
        end;
    end;

    if High(arrParams) > 0 then
      for I := 0 to High(arrParams) do
        Report.Variables['param' + IntToStr(i+1)] := '''' + arrParams[i] + '''';

    Report.PrepareReport;
    Report.PrintOptions.ShowDialog := True;
    Report.Print;
  finally
    Report.OnBeforePrint := onBeforePrint;
  end;
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
  else begin
    if (LowerCase(AppName) = 'shopuchet') or (LowerCase(AppName) = 'starshop') then
      templatePath := 'C:\CVSWork\Work\ShopUchetFB\MAIN_SHOP\Shopuchet32\Templates\'
    else if LowerCase(AppName) = 'salonuchet' then
      templatePath := 'C:\CVSWork\Work\RSalonUchetFB\MAIN_SALON\RSalonuchet32\Templates\'
    else
      templatePath := 'C:\CVSWork\Work\TServiceUchetFb\MAIN_SERVICE\TServicechet32\Templates\';
  end;

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
    Report.Engine.Curx := FBillSdvig;
end;

procedure TReportsDM.ReportGetValue(const VarName: string; var Value: Variant);
begin
  //Общее
  if VarName = 'QRLink' then
    Value := ExtractFilePath(Application.ExeName)+ 'QR.bmp';
  if VarName = 'NDSUM' then
  begin
    if (NdsValue>0) and (NDS_SUM>0) then
      Value := #13#10 + FloatToStr(NDS_SUM)
    else
      Value := '';
  end;
  if VarName = 'NDSTR' then
  begin
    if (NdsValue>0) and (NDS_SUM>0) then
      Value := #13#10 + 'в т.ч. НДС:'
    else
      Value := '';
  end;

  //Внесение\Изъятие общее
  if VarName = 'NAMEORG' then
  begin
    spRekvizit.Open;
    Value := spRekvizit.FieldByName('NAME').AsWideString;
    spRekvizit.Close;
  end;
  if VarName = 'BIN' then
  begin
    spRekvizit.Open;
    Value := spRekvizit.FieldByName('IDN').AsWideString;
    spRekvizit.Close;
  end;
  if VarName = 'Adress' then
  begin
    spRekvizit.Open;
    Value := spRekvizit.FieldByName('Adr').AsWideString;
    spRekvizit.Close;
  end;

  //Чек ReKassa
  if VarName = 'IIN' then
    Value := #13#10 + KKMReKassa.IIN;
  if VarName = 'IINSTR' then
  begin
    if Trim(KKMReKassa.IIN)='' then
      Value := ''
    else
      Value := #13#10 + 'ПОКУПАТЕЛЬ'
  end;
  if VarName = 'SKIDKAStr' then
  begin
    if Trim(KKMReKassa.SKIDKA) = '' then
      Value := ''
    else
      Value := #13#10 + 'Оплата бонусами:';
  end;
  if VarName = 'SKIDKA' then
  begin
    if Trim(KKMReKassa.SKIDKA) = '' then
      Value := ''
    else
      Value := #13#10 + KKMReKassa.SKIDKA;
  end;
  if VarName = 'NumDoc' then
    Value := KKMReKassa.NumDoc;
  if VarName = 'TimeDoc' then
    Value := KKMReKassa.TimeDoc;
  if VarName = 'DateDoc' then
    Value := KKMReKassa.DateDoc;
  if VarName = 'RHM' then
    Value := KKMReKassa.RHM;
  if VarName = 'FNum' then
    Value := KKMReKassa.FNum;

  //Внесение/изъятие ReKassa
  if VarName = 'OFDID' then
    Value := KKMReKassa.OFDID;
  if VarName = 'NUM' then
    Value := Login;
  //X\Z отчет ReKassa
  if VarName = 'Shift' then
    Value := KKMReKassa.SMENA;
  if VarName = 'DateShift' then
    Value := KKMReKassa.StartDate;
  if VarName = 'TimeShift' then
    Value := KKMReKassa.StartTime;
  if VarName = 'A_SELL' then
    Value := KKMReKassa.A_SELL;
  if VarName = 'A_SELL_RETURN' then
    Value := KKMReKassa.A_SELL_RETURN;
  if VarName = 'A_BUY' then
    Value := KKMReKassa.A_BUY;
  if VarName = 'A_BUY_RETURN' then
    Value := KKMReKassa.A_BUY_RETURN;
  if VarName = 'N_SELL' then
    Value := KKMReKassa.N_SELL;
  if VarName = 'N_SELL_RETURN' then
    Value := KKMReKassa.N_SELL_RETURN;
  if VarName = 'N_BUY' then
    Value := KKMReKassa.N_BUY;
  if VarName = 'N_BUY_RETURN' then
    Value := KKMReKassa.N_BUY_RETURN;
  if VarName = 'SUM_KASSA' then
    Value := KKMReKassa.SUM_KASSA;

  //для чека ТИС
  if VarName = 'TimeTicket' then
    Value := KKMTIS.TimeTicket;
  if VarName = 'DateTicket' then
    Value := KKMTIS.DateTicket;
  if VarName = 'NumTicket' then
    Value := KKMTIS.NumTicket;
  if VarName = 'SKIDKAStrTis' then
  begin
    if Trim(KKMTIS.SKIDKA) = '' then
      Value := ''
    else
      Value := #13#10 + 'Оплата бонусами:';
  end;
  if VarName = 'SKIDKATis' then
  begin
    if Trim(KKMTIS.SKIDKA) = '' then
      Value := ''
    else
      Value := #13#10 + KKMTIS.SKIDKA;
  end;

  if VarName = 'IINTis' then
    Value := #13#10 + KKMTIS.IIN;
  if VarName = 'IINSTRTis' then
  begin
    if Trim(KKMTIS.IIN)='' then
      Value := ''
    else
      Value := #13#10 + 'ПОКУПАТЕЛЬ'
  end;

  if VarName = 'RHMTIS' then
    Value := KKMTIS.RHM;
  if VarName = 'FNumTis' then
    Value := KKMTIS.FNum;
  if VarName = 'Operator' then
    Value := KKMTIS.Operators;
  if VarName = 'site' then
    Value := KKMTIS.Site;
  //Внесение/изъятие ТИС
  if VarName = 'OFDIDTIS' then
    Value := KKMTIS.OFDID;
  if VarName = 'NUMTIS' then
    Value := KKMTIS.Num;

  //X\Z отчет TIS
  if VarName = 'ShiftTis' then
    Value := KKMTIS.SMENA;
  if VarName = 'DateShiftTis' then
    Value := KKMTIS.StartDate;
  if VarName = 'TimeShiftTis' then
    Value := KKMTIS.StartTime;
  if VarName = 'EndDateShiftTis' then
    Value := KKMTIS.EndDate;
  if VarName = 'EndTimeShiftTis' then
    Value := KKMTIS.EndTime;
  if VarName = 'A_SELLTis' then
    Value := KKMTIS.A_SELL;
  if VarName = 'A_SELL_RETURNTis' then
    Value := KKMTIS.A_SELL_RETURN;
  if VarName = 'A_BUYTis' then
    Value := KKMTIS.A_BUY;
  if VarName = 'A_BUY_RETURNTis' then
    Value := KKMTIS.A_BUY_RETURN;
  if VarName = 'N_SELLTis' then
    Value := KKMTIS.N_SELL;
  if VarName = 'N_SELL_RETURNTis' then
    Value := KKMTIS.N_SELL_RETURN;
  if VarName = 'N_BUYTis' then
    Value := KKMTIS.N_BUY;
  if VarName = 'N_BUY_RETURNTis' then
    Value := KKMTIS.N_BUY_RETURN;
  if VarName = 'SUM_KASSATis' then
    Value := KKMTIS.SUM_KASSA;
end;

function TReportsDM.Get_CreateDateTimeStr: variant;
var
  TmpStr : String;
begin
  DateTimeToString(TmpStr, 'dd.mm.yyyy hh:nn', Date);
  Result := 'Дата формирования ' + TmpStr;
end;

procedure TReportsDM.SaveQRToFile(FQRCODE: TDelphiZXingQRCode);
var
  s: string;
  bmp: TBitmap;
begin
  try
    bmp := TBitmap.Create();
    MakeBmp(Bmp, 10, FQRCODE, clWhite, clBlack, 0);
    s := ExtractFilePath(Application.ExeName)+ 'QR.bmp';
    bmp.SaveToFile(ExtractFilePath(Application.ExeName)+ 'QR.bmp');
  except
    bmp.Free;
    raise;
  end;
end;

procedure TReportsDM.Paint(sender: TObject);
begin
  with TmpPaint.Canvas do
  begin
    Pen.Color := clWhite;
    Brush.Color := clBlack;
  end;
  DrawQR(TmpPaint.Canvas, TmpPaint.ClientRect, FQRCODE, 0, drwBitmap, False);
end;

function TReportsDM.SaveQR(txt: string): boolean;
begin
  Result := false;
  try
    CreateQR;
    QRRemake(txt);
    ReportsDM.SaveQRToFile(FQRCODE);
    Result := true;
  finally
    DestroyQR;
  end;
end;

procedure TReportsDM.DestroyQR;
begin
  TmpPaint.Free;
  FQRCODE.Free;
  TmpPaint := nil;
  FQRCODE := nil;
end;

procedure TReportsDM.CreateQR;
begin
  FQRCODE := TDelphiZXingQRCode.Create;
  FQRCODE.RegisterEncoder(ENCODING_WIN1251, TWin1251Encoder);
  FQRCODE.RegisterEncoder(ENCODING_URL, TURLEncoder);

  TmpPaint := TPaintBox.Create(ReportsDM);
  TmpPaint.OnPaint := Paint;
end;

procedure TReportsDM.QRRemake(txt: string);
begin
  if Assigned(FQRCODE) then
  begin
    try
      with FQRCODE do
      begin
        BeginUpdate;
        Data := txt;
        Encoding := 0;
        ErrorCorrectionOrdinal := TErrorCorrectionOrdinal(1);
        QuietZone := 4;
        EndUpdate(True);
      end;
    finally
      TmpPaint.Repaint;
    end;
  end;
end;

end.
