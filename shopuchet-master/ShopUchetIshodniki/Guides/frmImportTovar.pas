unit frmImportTovar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDbDlg, dxExEdtr, dxCntner, ExtCtrls, StdCtrls, Buttons,
  dxEditor, dxEdLib, Oracle,ComOBJ, DB, OracleData, Menus, ActnList,
  dxDBEdtr, dxDBELib, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, FIBDataSet, pFIBDataSet, FIB, frmDlg, OleServer, ExcelXP,
  AppEvnts, ComCtrls, unCommonFunc, ActiveX;

type
  TImportTovarForm = class(TDBDlgForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    odlg: TOpenDialog;
    Memo1: TMemo;
    Label13: TLabel;
    Shape25: TShape;
    leCategory: TdxLookupEdit;
    Shape26: TShape;
    dsProductCategory: TDataSource;
    Label1: TLabel;
    Shape1: TShape;
    lePostavshik: TdxLookupEdit;
    Shape3: TShape;
    rbPriceListOnly: TRadioButton;
    rbWithPrihod: TRadioButton;
    dsPostavshik: TDataSource;
    spLoad: TpFIBStoredProc;
    spProductCategory: TpFIBDataSet;
    tranRead: TpFIBTransaction;
    spPostavshik: TpFIBDataSet;
    tranWrite: TpFIBTransaction;
    ProgressBar: TProgressBar;
    bedtFileName: TdxButtonEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label8: TLabel;
    cbUpdate: TCheckBox;
    procedure bedtFileNameButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cbUppRowNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure rbWithPrihodClick(Sender: TObject);
    procedure rbPriceListOnlyClick(Sender: TObject);
    function Connect: boolean;
    procedure Disconnect;
    function OpenDocument(const aFileUrl:string): boolean;
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
    FCanClose : Boolean;
    StarOffice: OleVariant;
    Sheet : Variant;
    Sheets : Variant;
    Cell : Variant;
    Document: Variant;
  private
    function GetFloat(const Value: string): Double;
    function ooCreateValue(ooName: string; ooData: variant): variant;
  public
    { Public declarations }
  end;

var
  ImportTovarForm: TImportTovarForm;

implementation

uses unErrorHandlers, unDBSupport;

{$R *.dfm}
procedure TImportTovarForm.bedtFileNameButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
  inherited;
  if odlg.Execute then
    bedtFileName.Text := odlg.FileName;
end;

procedure TImportTovarForm.FormShow(Sender: TObject);
begin
  inherited;
  FCanClose := False;
  OpenSp(spProductCategory, False);
end;

function IsOLEObjectInstalled(Name: String): boolean;
var
  ClassID: TCLSID;
begin
  Result := CLSIDFromProgID(PWideChar(WideString(Name)), ClassID) = S_OK;
end;

function TImportTovarForm.Connect: boolean;
begin
   if VarIsEmpty(StarOffice) then
      StarOffice := CreateOleObject('com.sun.star.ServiceManager');
   Result := not (VarIsEmpty(StarOffice) or VarIsNull(StarOffice));
end;

procedure TImportTovarForm.Disconnect;
begin
   Document.Close(True);
   Document := Null;
   Sheet := Unassigned;
   StarOffice := Unassigned;
   StarOffice := Null;
   winexec('taskkill /F /IM soffice.bin', SW_HIDE);
end;

function TImportTovarForm.ooCreateValue(ooName: string; ooData: variant): variant;
var
  ooReflection: variant;
begin
  ooReflection:= StarOffice.createInstance('com.sun.star.reflection.CoreReflection');
  ooReflection.forName('com.sun.star.beans.PropertyValue').createObject(result);
  result.Name := ooName;
  result.Value:= ooData;
end;

function ConvertToURL(FileName:string):string;
var
  i:integer;
  ch:char;
begin
  Result:= '';
  for i:=1 to Length(FileName) do
    begin
      ch:=FileName[i];
      case ch of
        ' ':Result:=Result + '%20';
        '\':Result:=Result + '/';
      else
        Result:=Result + ch;
      end;
    end;
  Result:= 'file:///' + Result;
end;

function TImportTovarForm.OpenDocument(const aFileUrl:string): boolean;
var
   StarDesktop: Variant;
   VariantArr: variant;
   FilePath : String;
begin
   FilePath := ConvertToURL(aFileUrl);
   StarDesktop := StarOffice.CreateInstance('com.sun.star.frame.Desktop');
   VariantArr := VarArrayCreate([0, 1], varVariant);
   VariantArr[0]:= ooCreateValue('Hidden', Visible);
   Document := StarDesktop.LoadComponentFromURL(
                  FilePath, '_blank', 0,
                  VariantArr);
   Result := not (VarIsEmpty(Document) or VarIsNull(Document));
end;

procedure TImportTovarForm.btnOkClick(Sender: TObject);
type
  TLog = array of string;
var
  AFileName: String;
  FData    : OLEVariant;
  WorkSheet: OLEVariant;
  I, X: Integer;
  Row_begin, RowForOff : Integer;  // начальная строка с которой будет импорт идти, в дальнейшем будет как входной параметр
  ExcelInstalled, OpenOffInstalled : Boolean;
  Var1, Var2, Var3, Var4, Var5, Var6, Var7, Var8, Var9, V : Variant;
  Pnt : String;
begin
  if (leCategory.LookupKeyValue = 0) or (leCategory.LookupKeyValue = null) then begin
    leCategory.SetFocus;
    MessageDlg('Категория товара не выбрана', mtInformation, [mbOK], 0);
    Exit;
  end;

  if rbWithPrihod.Checked and (lePostavshik.Text = '') then begin
    lePostavshik.SetFocus;
    MessageDlg('Выберите поставщика!', mtWarning, [mbOk], 0);
    Exit;
  end;

  Pnt := '01';
  AFileName := bedtFileName.TEXT;
  I := 0;
  try
    Screen.Cursor := crHourGlass;
    Memo1.Lines.Add('-------- ПАРСИНГ ФАЙЛА EXCEL ---------');
    ExcelInstalled := IsOLEObjectInstalled('Excel.Application');
    OpenOffInstalled := IsOLEObjectInstalled('com.sun.star.ServiceManager');

    IF ExcelInstalled THEN BEGIN
      Pnt := '02';
      Row_begin := 2;   // начальная строка с которой будет импорт идти, в дальнейшем будет как входной параметр
      RowForOff := 0;
      Excel := CreateOleObject('Excel.Application');
      Excel.Workbooks.Open(AFileName);
      WorkSheet := Excel.ActiveWorkbook.ActiveSheet;
      FData := WorkSheet.UsedRange.Value;
      //НАЙДУ ПОСЛЕДНЮЮ ЯЧЕЙКУ И ЗАКРОЮ EXCEL ОТ ГРЕХА ПОДАЛЬШЕ
      Excel.Cells.SpecialCells(xlCellTypeLastCell).Activate;
      X := Excel.ActiveCell.Row;
      ProgressBar.Max := X - Row_begin;
      Excel.Quit;
      Excel := Null;
    END ELSE BEGIN
      Pnt := '03';
      try
        if not Connect then begin
          Memo1.Lines.Add('Приложение "Excel" не установлено. Приложение "OpenOffice Calc" не установлено, либо не запускается. Нет возможности для импорта из файла.');
          Exit;
        end;
      except
        Memo1.Lines.Add('Приложение "Excel" не установлено. Приложение "OpenOffice Calc" не установлено, либо не запускается. Нет возможности для импорта из файла.');
        Exit;
      end;
      Row_begin := 0;   // начальная строка с которой будет импорт идти, в дальнейшем будет как входной параметр
      RowForOff := 1;
      OpenDocument(bedtFileName.Text);
      Sheets := Document.GetSheets;
      Sheet := Sheets.getByName('Лист1');
      V := Sheet.createCursor;
      v.GotoEndOfUsedArea(false);
      X := v.RangeAddress.EndRow-1;
      ProgressBar.Max := X - Row_begin;
      FData := Sheet.getCellRangeByPosition(0, 1, v.RangeAddress.EndColumn, v.RangeAddress.EndRow).getDataArray;
      V := Unassigned;
      Pnt := '04';
      Disconnect;
    END;

    Memo1.Lines.Add('-------- ЗАГРУЗКА ЗАПИСЕЙ В БАЗУ ---------');
    Pnt := '05';
    if not spLoad.Transaction.InTransaction then
      spLoad.Transaction.StartTransaction;
    for I := 0 to X-Row_begin do begin
      try
        spLoad.ParamByName('g_product_par_').AsInteger := leCategory.LookupKeyValue;
        if ExcelInstalled then begin
          Var1 := FData[I+Row_begin, 1]; //находим значение ячейки "Артикул"
          Var2 := FData[I+Row_begin, 2]; //находим значение ячейки "Номенклатурный номер"
          Var3 := FData[I+Row_begin, 3]; //находим значение ячейки "штрихкод"
          Var4 := FData[I+Row_begin, 4]; //находим значение ячейки "Наименование"
          Var5 := FData[I+Row_begin, 5]; //находим значение ячейки "Ед. измерения"
          Var6 := FData[I+Row_begin, 6]; //находим значение ячейки "Оптовая цена"
          Var7 := FData[I+Row_begin, 7]; //находим значение ячейки "Розничная цена"
          Var8 := FData[I+Row_begin, 8]; //находим значение ячейки "Цена прихода"
          Var9 := FData[I+Row_begin, 9]; //находим значение ячейки "Остаток"
        end else begin
          Var1 := FData[I][0]; //находим значение ячейки "Артикул"
          Var2 := FData[I][1]; //находим значение ячейки "Номенклатурный номер"
          Var3 := FData[I][2]; //находим значение ячейки "штрихкод"
          Var4 := FData[I][3]; //находим значение ячейки "Наименование"
          Var5 := FData[I][4]; //находим значение ячейки "Ед. измерения"
          Var6 := FData[I][5]; //находим значение ячейки "Оптовая цена"
          Var7 := FData[I][6]; //находим значение ячейки "Розничная цена"
          Var8 := FData[I][7]; //находим значение ячейки "Цена прихода"
          Var9 := FData[I][8]; //находим значение ячейки "Остаток"
        end;

        //находим значение ячейки "Артикул"
        spLoad.ParamByName('ARTICUL_').AsString := Var1;
        //находим значение ячейки "Номенклатурный номер
        spLoad.ParamByName('NOMENCLATUR_NUM_').AsString := Var2;
        //находим значение ячейки "штрихкод"
        spLoad.ParamByName('BARCODE_').AsString := Var3;
        //находим значение ячейки "Наименование"
        spLoad.ParamByName('NAME_').AsString := Var4;
        //находим значение ячейки "Ед. измерения"
        spLoad.ParamByName('NAME_G_UNIT_').AsString := Var5;

        spLoad.ParamByName('UPDATE_IF_EXIST_').AsInteger := Integer(cbUpdate.Checked);

        //находим значение ячейки "Оптовая цена"
        IF Trim(VarToStr(Var6)) <> '' THEN BEGIN
          try
            spLoad.ParamByName('VOLUME_PRICE_').AsDouble := StrToFloat(Var6);
          except
            on E: Exception do begin
              Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Оптовая цена" = ' + Trim(VarToStr(Var6)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
              Screen.Cursor := crDefault;
              Exit;
            end;
          end
        END ELSE
          spLoad.ParamByName('VOLUME_PRICE_').AsDouble := 0;

        //находим значение ячейки "Розничная цена"
        IF Trim(VarToStr(Var7)) <> '' THEN BEGIN
          try
            spLoad.ParamByName('PRICE_').AsDouble := StrToFloat(Var7);
          except
            on E: Exception do begin
              Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Розничная цена" = ' + Trim(VarToStr(Var7)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
              Screen.Cursor := crDefault;
              Exit;
            end;
          end
        END ELSE
          spLoad.ParamByName('PRICE_').AsDouble := 0;

        //находим значение ячейки "Цена прихода"
        IF Trim(VarToStr(Var8)) <> '' THEN BEGIN
          try
            spLoad.ParamByName('SELF_PRICE_').AsDouble := StrToFloat(Var8);
          except
            on E: Exception do begin
              Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Цена прихода" = ' + Trim(VarToStr(Var8)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
              Screen.Cursor := crDefault;
              Exit;
            end;
          end
        END ELSE
          spLoad.ParamByName('SELF_PRICE_').AsDouble := 0;

        //находим значение ячейки "Количество для прихода"
        IF Trim(VarToStr(Var9)) <> '' THEN BEGIN
        try
            spLoad.ParamByName('Amount_').AsDouble := StrToFloat(Var9);
          except
            on E: Exception do begin
              Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Остаток" = ' + Trim(VarToStr(Var9)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
              Screen.Cursor := crDefault;
              Exit;
            end;
          end
        END ELSE
          spLoad.ParamByName('Amount_').AsDouble := 0;

        IF rbWithPrihod.Checked THEN
          spLoad.ParamByName('G_client_').AsInteger := lePostavshik.LookupKeyValue;

        IF I = (X-Row_begin) THEN
          spLoad.ParamByName('IS_THIS_LAST_').AsInteger := 1;  // СТАВЛЮ ПРИЗНАК ЧТО ЭТО ПОСЛЕДНЯЯ ЗАПИСЬ В ЦИКЛЕ

        try
          spLoad.ExecQuery;
          if spLoad.ParamByname('ERR_CODE').AsInteger <> 0 then begin
            Memo1.Lines.Add(spLoad.ParamByname('Err_msg').AsString + ' Строка в файле Excel ' + INTTOSTR(I+Row_begin + RowForOff));
            if spLoad.Transaction.InTransaction then
              spLoad.Transaction.Rollback;
            Screen.Cursor := crDefault;
            Exit;
          end;
          if spLoad.ParamByname('Err_msg').AsString <> '' then
            Memo1.Lines.Add(spLoad.ParamByname('Err_msg').AsString);
        except
          on E: Exception do
            Memo1.Lines.Add('ПРОИЗОШЛА ОШИБКА В ХОДЕ ЗАГРУЗКИ - ' + E.Message);
        end;

        ProgressBar.Position := ProgressBar.Position + 1;
      except
        on E: Exception do begin
          Memo1.Lines.Add('ОШИБКА. СТРОКА ' + INTTOSTR(I+Row_begin + RowForOff) +'. ' + E.Message);
          Screen.Cursor := crDefault;
          Exit;
        end;
      end;
    end;  // for .. do
  except
    on E: Exception do BEGIN
      Memo1.Lines.Add('ОШИБКА. СТРОКА ' + INTTOSTR(I+Row_begin + RowForOff) +'. ' + E.Message);
      Screen.Cursor := crDefault;
      Exit;
    END
  end;  // try

  Memo1.Lines.Add('----------------------------------');
  Memo1.Lines.Add(INTTOSTR(I) + ' ТОВАРОВ ОБРАБОТАНО.');
  Screen.Cursor := crDefault;
  
  if spLoad.Transaction.InTransaction then
    spLoad.Transaction.Commit;

  FCanClose := False;
  btnOk.Enabled := False;
end;

function TImportTovarForm.GetFloat(
  const Value: string): Double;
var
  Str: string;
begin
  Str := StringReplace(Value, ' ', EmptyStr, [rfReplaceAll]);
  Str := StringReplace(Str, #160, EmptyStr, [rfReplaceAll]);
  Str := StringReplace(Str, ',', DecimalSeparator, [rfReplaceAll]);
  Str := StringReplace(Str, '.', DecimalSeparator, [rfReplaceAll]);
  if Trim(Str) = EmptyStr then
    Result := 0
  else
    Result := StrToFloat(Str);
end;

procedure TImportTovarForm.cbUppRowNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TImportTovarForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := FCanClose;
end;

procedure TImportTovarForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  FCanClose := True;
end;

procedure TImportTovarForm.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TImportTovarForm.rbWithPrihodClick(Sender: TObject);
begin
  inherited;
  OpenSp(spPostavshik, False);
  lePostavshik.Enabled := True;
end;

procedure TImportTovarForm.rbPriceListOnlyClick(Sender: TObject);
begin
  inherited;
  lePostavshik.Clear;
  lePostavshik.Enabled := False;
end;

procedure TImportTovarForm.btHelpClick(Sender: TObject);
begin
  Helpc := 41;
  inherited;
end;

end.
