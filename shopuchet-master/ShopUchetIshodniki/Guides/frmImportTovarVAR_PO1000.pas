unit frmImportTovar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDbDlg, dxExEdtr, dxCntner, ExtCtrls, StdCtrls, Buttons,
  dxEditor, dxEdLib, Oracle,ComOBJ, DB, OracleData, Menus, ActnList,
  dxDBEdtr, dxDBELib, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, FIBDataSet, pFIBDataSet, FIB, frmDlg, AppEvnts;

type
  TImpRec = record
    Articul: array of string;
    Nomenclatur: array of string;
    Barcode: array of string;
    Name: array of string;
    GUnit: array of string;
    Vol_Price: array of string;
    Price: array of string;
    Prihod_Price: array of string;
    Amount: array of string;
  end;

  TImportTovarForm = class(TDBDlgForm)
    bedtFileName: TdxButtonEdit;
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
    procedure bedtFileNameButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cbUppRowNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure rbWithPrihodClick(Sender: TObject);
  private
    { Private declarations }
    FColumnNo : Integer;
    FUpp_Row : Integer; //номер верхней строки
    FLow_Row : Integer; //номер нижней строки
    FCanClose : Boolean;
    FImpRec: TImpRec;
  private
    function GetFloat(const Value: string): Double;
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

procedure TImportTovarForm.btnOkClick(Sender: TObject);
type
  TLog = array of string;
var
  AFileName : String;
  Body      : WideString;
  Excel: Variant;
  I, J: Integer;
  Log : TLog;
  sl: TStrings; // blob IS NOT string!
  ms: TMemoryStream;
  Stream : TStringStream;
  ErrCode: Integer;
  ErrMsg : String;
begin
  if leCategory.LookupKeyValue = 0 then begin
    leCategory.SetFocus;
    MessageDlg('Категория товара не выбрана', mtInformation, [mbOK], 0);
    Exit;
  end;

  if rbWithPrihod.Checked and (lePostavshik.Text = '') then begin
    lePostavshik.SetFocus;
    MessageDlg('Выберите поставщика!', mtWarning, [mbOk], 0);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  FUpp_Row := 4;  // НАЧИНАЕМ С 4-О1 СТРОКИ
  AFileName := bedtFileName.TEXT;
  Excel := CreateOleObject('Excel.Application');
  SetLength(FImpRec.Articul, 1); // артикул
  SetLength(FImpRec.Barcode, 1); // штрихкод
  SetLength(FImpRec.GUnit, 1);   // ед. измерения
  SetLength(FImpRec.Name, 1);    // наименование
  SetLength(FImpRec.Nomenclatur, 1); // номенклатурный номер
  SetLength(FImpRec.Price, 1);      // цена
  SetLength(FImpRec.Vol_Price, 1);  // оптовая цена
  SetLength(FImpRec.Prihod_Price, 1);   // цена прихода
  SetLength(FImpRec.Amount, 1);  // количество, если есть приход
  TRY
    Excel.Visible := False;
    Memo1.Lines.Add('---- ПАРСИНГ ФАЙЛА ----');
    Excel.Workbooks.Open(AFileName);
    Excel.Cells[FUpp_Row, 1].Select;
    Excel.Cells[FUpp_Row, 1].Activate;
    Memo1.Lines.Add('---- ЗАГРУЗКА В БАЗУ ----');
    I := 0;
    J := 0;       // СКОЛЬКО ЗАПИСЕЙ ЗАГРУЗИЛОСЬ В ОБЩЕМ
    WHILE 2 > 1 DO BEGIN
      while I <= 1000 do begin         //БУДУ ГРУЗИТЬ ПО 1000 ЗАПИСЕЙ
        try
          //находим значение ячейки "Артикул"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 1].Activate;
          FImpRec.Articul[I] := Excel.ActiveCell.Value;
         //находим значение ячейки "Номенклатурный номер
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 2].Activate;
          FImpRec.Nomenclatur[I] := Excel.ActiveCell.Value;
          //находим значение ячейки "штрихкод"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 3].Activate;
          FImpRec.Barcode[i] := Excel.ActiveCell.Value;
          //находим значение ячейки "Наименование"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 4].Activate;
          FImpRec.Name[i]:= Excel.ActiveCell.Value;
          //находим значение ячейки "Ед. измерения"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 5].Activate;
          FImpRec.GUnit[i]:= Excel.ActiveCell.Value;
          //находим значение ячейки "Оптовая цена"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 6].Activate;
          FImpRec.Vol_Price[i]:= Excel.ActiveCell.Value;
          //находим значение ячейки "Розничная цена"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 7].Activate;
          FImpRec.Price[i]:= Excel.ActiveCell.Value;
          //находим значение ячейки "Цена прихода"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 8].Activate;
          FImpRec.Prihod_Price[i]:= Excel.ActiveCell.Value;
          //находим значение ячейки "Количество для прихода"
          Excel.Cells[Copy(Excel.ActiveCell.Address, 4, Length(Excel.ActiveCell.Address) - 3), 9].Activate;
          FImpRec.Amount[i]:= Excel.ActiveCell.Value;

          //конец списка
          IF (FImpRec.Articul[I] = '') and (FImpRec.Nomenclatur[I] = '') and (FImpRec.Barcode[I] = '') and (FImpRec.Name[I] = '') and (FImpRec.Price[I] = '') THEN BEGIN
            SetLength(FImpRec.Articul, I); // артикул
            SetLength(FImpRec.Barcode, I); // штрихкод
            SetLength(FImpRec.GUnit, I);   // ед. измерения
            SetLength(FImpRec.Name, I);    // наименование
            SetLength(FImpRec.Nomenclatur, I); // номенклатурный номер
            SetLength(FImpRec.Price, I);      // цена
            SetLength(FImpRec.Vol_Price, I);  // оптовая цена
            SetLength(FImpRec.Prihod_Price, I);   // цена прихода
            SetLength(FImpRec.Amount, I);  // количество, если есть приход
            break;
          End;
        except
          on E: Exception do begin
            MessageDlg(E.Message + #13#10'(occured in TfrmGuideCurrencyCourse.CourseLoad)', mtError, [mbOk], 0);
            Screen.Cursor := crDefault;
            Exit;
          end;
        end;
        FUpp_Row := FUpp_Row + 1; // следующая строка
        Excel.Cells[FUpp_Row, 1].Select; //делаем активной следующую строку
        I:= I + 1;
        J:= J + 1;

        SetLength(FImpRec.Articul, I + 1); // артикул
        SetLength(FImpRec.Barcode, I + 1); // штрихкод
        SetLength(FImpRec.GUnit, I + 1);   // ед. измерения
        SetLength(FImpRec.Name, I + 1);    // наименование
        SetLength(FImpRec.Nomenclatur, I + 1); // номенклатурный номер
        SetLength(FImpRec.Price, I + 1);      // цена
        SetLength(FImpRec.Vol_Price, I + 1);  // оптовая цена
        SetLength(FImpRec.Prihod_Price, I + 1);   // цена прихода
        SetLength(FImpRec.Amount, I + 1);  // количество, если есть приход
      end;  // while

      for i := 0 to Length(FImpRec.Articul)-1 do
        Body := Body + FImpRec.Articul[i] + '|' + FImpRec.Nomenclatur[i] + '|' + FImpRec.Barcode[i] + '|' + FImpRec.Name[i] + '|' + FImpRec.GUnit[i] + '|' + FImpRec.Vol_Price[i] + '|' +
                FImpRec.Price[i] + '|' + FImpRec.Prihod_Price[i] + '|' + FImpRec.Amount[i] + '|';

      spLoad.paramByName('g_product_par_').AsInteger := leCategory.LookupKeyValue;
      if lePostavshik.LookupKeyValue > 0 then
        spLoad.paramByName('g_client_').AsInteger := lePostavshik.LookupKeyValue;

     try
        Stream := TStringStream.Create(Body);
        spLoad.ParamByName('body_').LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
      //spLoad.paramByName('body_').AsWideString  := Body;

      if not spLoad.Transaction.InTransaction then
        spLoad.Transaction.StartTransaction;

      with spLoad do begin
        ExecProc;

        // поставлю сюда вывод лог-файла, иначе потом после Transaction.Rollback или Transaction.Commit переменные уже не вызываются
        sl := TStringList.Create;
        ms := TMemoryStream.Create;
        try
          spLoad.FieldByName('log_').SaveToStream(ms);
          ms.Position := 0;
          sl.LoadFromStream(ms);

          Memo1.Text := SL.Text;
        finally
          sl.Free;
          ms.Free;
        end; // try..finally
        //---------------

        if FieldIndex['ERR_CODE'] >= 0 then begin
          ErrCode := ParamByName('ERR_CODE').AsInteger;
          if ErrCode = -900 then
            if spLoad.Transaction.InTransaction then
              spLoad.Transaction.Rollback;
          if (ErrCode <> 0) AND (ErrCode <> -900) then begin
            if spLoad.Transaction.InTransaction then
              spLoad.Transaction.Rollback;
            if FieldIndex['ERR_MSG'] >= 0 then begin
              ErrMsg := ParamByName('ERR_MSG').AsString;
              DBErrorHandler(ErrCode, ErrMsg);
            end
            else
              MessageDlg('Error code: ' + IntToStr(ErrCode)
                 + #13#10'(occured in TDlgForm.CallSP)', mtInformation, [mbOK], 0);

            Screen.Cursor := crDefault;
            Exit;
          end;
        end;
      end;

      Memo1.Lines.Add('---- ЗАГРУЖЕНО ' + IntToStr(J) + ' ЗАПИСЕЙ ----');

      //конец списка
      IF (FImpRec.Articul[I] = '') and (FImpRec.Nomenclatur[I] = '') and (FImpRec.Barcode[I] = '') and (FImpRec.Name[I] = '') and (FImpRec.Price[I] = '') THEN
        BREAK;
    END;
  FINALLY
    Excel.Quit;
    Excel := NULL;
  END;  // try

  if spLoad.Transaction.InTransaction then
    spLoad.Transaction.Commit;

  Memo1.Lines.Add('---- ЗАГРУЗКА ПРОШЛА УСПЕШНО ----');

  FCanClose := False;
  Screen.Cursor := crDefault;
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

end.
