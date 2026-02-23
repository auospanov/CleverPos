unit unExportOperDataThread;

interface

uses
  Classes, unCommonFunc, unDBSupport, dmMain, dmReportsThread, SyncObjs, pFIBDatabase,
  DateUtils, SysUtils, Dialogs, Windows, dmReports;

type
  TExportDataThread = class(TThread)
  private
    FSleepEvent: TSimpleEvent;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation


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
  Connected : Boolean;
  db: TpFIBDatabase;
  fs: TFileStream;
  SL:TStringList;
begin
  while not Terminated do begin
    if not DirectoryExists(ExportPath) then begin
      MessageBox(GetDesktopWindow, PChar('Включен сервис "Выгрузка оперативных данных", но ресурса "' + ExportPath + '" для сохранения '+
      'данных не существует!' + #10#13 + 'Переопределите папку для сохранения '+
      'в меню "Сервис - Выгрузка опер. данных"!' + #10#13 + 'Сервис будет временно ОТКЛЮЧЕН!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
      Terminate;
      Exit;
    end;

    try
      db := MainDM.dbMainThread;
      Connected := unDBSupport.ConnectToFB(db, '');

      if not Connected then
        Exit;

      if Copy(ExportDataType, 1, 1) = '1' then begin
        ReportsThreadDM.PrepareReport(7);
        ReportsThreadDM.spReport.ParamByName('date_begin_').AsDate := Now;
        ReportsThreadDM.spReport.ParamByName('date_end_').AsDate := Now;
        ReportsThreadDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
        ReportsThreadDM.ShowReport(ExportPath + 'Продажи '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
      end;

      if Copy(ExportDataType, 2, 1) = '1' then begin
        ReportsThreadDM.PrepareReport(12);
        ReportsThreadDM.spReport.ParamByName('INCLUDE_NOL_').AsInteger := 0;
        ReportsThreadDM.spReport.ParamByName('INCLUDE_FEW_').AsInteger := 0;
        ReportsThreadDM.spReport.ParamByName('SORT_BY_NAME_').AsInteger := 0;
        ReportsThreadDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
        ReportsThreadDM.ShowReport(ExportPath + 'Остатки товаров '+ CurSkladName +' на ' + DateToStr(Date) + '.xls');
      end;

      if Copy(ExportDataType, 3, 1) = '1' then begin
        try
          SL:= TStringList.Create;
          SL.Add('<?xml version="1.0" encoding="windows-1251"?>');
          SL.ADD('<PRODUCTS>');
          ReportsThreadDM.spGetProductList.ParamByName('g_tochka_').AsInteger := CurSklad;
          OpenSP(ReportsThreadDM.spGetProductList, False);
          with ReportsThreadDM.spGetProductList do begin
            First;
            while not Eof do begin
              SL.Add('  <PRODUCT>');
              SL.Add('    <BARCODE>' + FieldByName('barcode').AsString + '</BARCODE>');
              SL.Add('    <ARTICUL>' + FieldByName('ARTICUL').AsString + '</ARTICUL>');
              SL.Add('    <NAME>' + FieldByName('NAME').AsString + '</NAME>');
              SL.Add('    <AMOUNT>' + FieldByName('AMOUNT').AsString + '</AMOUNT>');
              SL.Add('    <PRICE>' + FieldByName('PRICE').AsString + '</PRICE>');
              SL.Add('    <CATEGORY>' + FieldByName('CAT_NAME').AsString + '</CATEGORY>');
              SL.Add('  </PRODUCT>');
              Next;
            end;
            SL.Add('</PRODUCTS>');
          end;

          fs:=TFileStream.Create(ExportPath + GetDateTime2 + '.xml', fmCreate);
          SL.SaveToStream(fs);
        finally
          fs.Free;
          SL.Free;
        end;
      end;

      if Copy(ExportDataType, 4, 1) = '1' then begin
        ReportsThreadDM.PrepareReport(46);
        ReportsThreadDM.spReport.ParamByName('date_begin_').AsDate := Now;
        ReportsThreadDM.spReport.ParamByName('date_end_').AsDate := Now;
        ReportsThreadDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
        ReportsThreadDM.ShowReport(ExportPath + 'Прибыль '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
      end;

      FSleepEvent.WaitFor(ExportInterval); // Ждем N минут
    finally
      DisconnectFromFB(db);
    end;
  end;
end;

end.
