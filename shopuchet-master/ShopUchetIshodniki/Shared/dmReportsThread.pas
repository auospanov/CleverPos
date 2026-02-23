unit dmReportsThread;

interface

uses
  SysUtils, Classes, DB, FIBDataSet, pFIBDataSet, FIBDatabase,
  pFIBDatabase, Dialogs, UExcelAdapter, XLSAdapter, UFlxMemTable,
  UCustomFlexCelReport, UFlexCelReport, Forms, Windows, Controls, FIB, ShellApi, FileCtrl,
  frxExportImage, frxExportRTF, frxClass, frxBarcode,
  frxDBSet, UFlexCelImport, UFlxFormats;

type
  TReportsThreadDM = class(TDataModule)
    ReportParams: TFlxMemTable;
    tranRead: TpFIBTransaction;
    spReport: TpFIBDataSet;
    qLoadReport: TpFIBDataSet;
    qLoadReportREPORT: TFIBIntegerField;
    qLoadReportBODY: TFIBBlobField;
    qLoadReportDESCRIPTION: TFIBStringField;
    qLoadReportSQL: TFIBStringField;
    FlexCelReport: TFlexCelReport;
    XLSAdapter: TXLSAdapter;
    spGetProductList: TpFIBDataSet;
    fbstrngfldLoadReportFILENAME: TFIBStringField;
    FlexCelImport: TFlexCelImport;
    qLoadReportCOORD: TStringField;
    spUniversalRead: TpFIBDataSet;
    tranWrite: TpFIBTransaction;
    spUniversalWrite: TpFIBDataSet;
  private
    Template : String;
    FParam1G : variant;
    FReportNameG : variant;
    FDatePeriodG : variant;

    procedure FillMemTable;
    {Загружает отчет FastReport из таблицы Report}
    function Get_CreateDateTimeStr  : variant;
  public
    property ReportNameG : variant read FReportNameG write FReportNameG;
    property DatePeriodG : variant read FDatePeriodG write FDatePeriodG;
    property Param1G : variant read FParam1G write FParam1G;

    procedure PrepareReport(const ReportCode: Integer);

    // сохранить сразу в файл, 1 - да, 0 - нет
    procedure ShowReport(Filename : String = '');

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
  ReportsThreadDM: TReportsThreadDM;

implementation

uses unErrorHandlers, frmMain, dmMain, unCommonFunc, unInitApp;

{$R *.dfm}

procedure TReportsThreadDM.PrepareReport(const ReportCode: Integer);
var i, p, j, posCoord, posSemi : integer;
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
      templatePath := 'C:\CVSWork\Work\TServiceUchetFb\MAIN_SERVICE\TServicechet32\Templates\'
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
      {Сохраняем отчет в потоке и загружаем его в Report}
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
      (Pos('_personal', Template) = 0) then begin
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TReportsThreadDM.PrepareReport)');
    end;
    on E: Exception do begin
      if qLoadReport.Transaction.InTransaction then
        qLoadReport.Transaction.Rollback;
      MessageBox(GetDesktopWindow, PChar(E.Message + #13#10'(occured in TReportsThreadDM.PrepareReport)'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
    end;
  end;
end;

procedure TReportsThreadDM.FillMemTable;
var
  i, j, z : Integer;
  Arr     : Array of Variant;
  VarName, str, str1 : String;
  DS  : TpFIBDataSet;
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
            Arr[High(Arr)] := FieldByName(str).AsString;
            j := j + 1;
          end;
        end;
      end;  //with DS
    end; //if Self.Components[i] is TOracleDataSet
  ReportParams.AddRecord(Arr);
  Arr := nil;
end;

procedure TReportsThreadDM.CloseDataSets(const DeleteReportFile: Boolean);
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

procedure TReportsThreadDM.ShowReport(Filename : String = '');
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  FlexCelReport.Template := Template;
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
            MessageBox(GetDesktopWindow, PChar('Error code: ' + IntToStr(ErrCode)
               + #13#10'(occured in TDBListROForm.OpenSP)'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
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
      MessageBox(GetDesktopWindow, PChar(E.Message + #13#10'(occured in TDlgForm.OpenSP)'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
    end;
  end;

  FillMemTable;

  FlexCelReport.Run;
end;

function TReportsThreadDM.Get_CreateDateTimeStr: variant;
var
  TmpStr : String;
begin
  DateTimeToString(TmpStr, 'dd.mm.yyyy hh:nn', Date);
  Result := 'Дата формирования ' + TmpStr;
end;

end.
