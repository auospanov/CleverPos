unit frmImportB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ExtCtrls,
  StdCtrls, ActnList, AppEvnts, Buttons, Grids, ComCtrls,
  DB, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, Menus, OleServer, ExcelXP, ActiveX,
  ComObj, Math, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCurrencyEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, ZColorStringGrid, System.UITypes,
  System.Actions, cxButtons;

type
  TImportBForm = class(TDBDlgForm)
    pSecond: TPanel;
    pFirst: TPanel;
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    lbPackAmount: TLabel;
    lbMFCountry: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    aLoad: TAction;
    tranWrite: TpFIBTransaction;
    spLoad: TpFIBStoredProc;
    tranRead: TpFIBTransaction;
    spProductCategory: TpFIBDataSet;
    dsProductCategory: TDataSource;
    spPostavshik: TpFIBDataSet;
    dsPostavshik: TDataSource;
    Shape25: TShape;
    Shape26: TShape;
    Label13: TLabel;
    Label6: TLabel;
    Shape5: TShape;
    cbUpdate: TCheckBox;
    Shape6: TShape;
    Label9: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Memo1: TMemo;
    ProgressBar: TProgressBar;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    odlg: TOpenDialog;
    pnlRowCnt: TPanel;
    bedtFileName: TcxButtonEdit;
    edNum: TcxCurrencyEdit;
    leCategory: TcxLookupComboBox;
    lePostavshik: TcxLookupComboBox;
    StringGrid: TZColorStringGrid;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    btBack: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StringGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    function Connect: boolean;
    procedure Disconnect;
    function OpenDocument(const aFileUrl:string): boolean;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure aLoadExecute(Sender: TObject);
    procedure bedtFileNameKeyPress(Sender: TObject; var Key: Char);
    procedure btBack1Click(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure bedtFileNameClick(Sender: TObject);
  private
    FGlyph : TBitMap;
    Fcol, Frow : integer;
    FCanClose : Boolean;
    FData     : OLEVariant;
    Document: Variant;
    Sheet : Variant;
    Sheets : Variant;
    StarOffice: OleVariant;
    ColArt : Integer;
    ColNom : Integer;
    ColBar : Integer;
    ColName : Integer;
    ColUnit : Integer;
    ColOpt : Integer;
    ColRozn : Integer;
    ColZakup : Integer;
    ColOstatok : Integer;
    ColNote : Integer;
    ColPack : Integer;
    ColCountry : Integer;
    ColPlace : Integer;
    ExcelInstalled : Boolean;
    OpenOffInstalled : Boolean;
    function ooCreateValue(ooName: string; ooData: variant): variant;
  public
    { Public declarations }
  end;

var
  ImportBForm: TImportBForm;

implementation

uses unCommonFunc;

{$R *.dfm}

procedure SelectCol(StringGrid: TStringGrid; ColNumber: integer );
var
  NewSel: TGridRect;
begin
   with StringGrid do
   begin
      if ( ColNumber > FixedCols-1 ) and ( ColNumber < ColCount ) then
      begin
         NewSel.Left := ColNumber;
         NewSel.Top := FixedRows;
         NewSel.Right := ColNumber;
         NewSel.Bottom := RowCount - 1;
         Selection := NewSel;
      end;
   end;
end;

function IsOLEObjectInstalled(Name: String): boolean;
var
  ClassID: TCLSID;
begin
  Result := CLSIDFromProgID(PWideChar(WideString(Name)), ClassID) = S_OK;
end;

function TImportBForm.Connect: boolean;
begin
   if VarIsEmpty(StarOffice) or VarIsNull(StarOffice) then
      StarOffice := CreateOleObject('com.sun.star.ServiceManager');
   Result := not (VarIsEmpty(StarOffice) or VarIsNull(StarOffice));
end;

procedure TImportBForm.Disconnect;
begin
   Document.Close(True);
   Document := Null;
   Sheet := Unassigned;
   StarOffice := Unassigned;
   StarOffice := Null;
   winexec('taskkill /F /IM soffice.bin', SW_HIDE);
end;

function TImportBForm.ooCreateValue(ooName: string; ooData: variant): variant;
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

function TImportBForm.OpenDocument(const aFileUrl:string): boolean;
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

procedure TImportBForm.FormShow(Sender: TObject);
begin
  inherited;
  FCanClose := False;
  OpenSp(spProductCategory, False);
  OpenSp(spPostavshik, False);
  pFirst.Visible   := True;
  pSecond.Visible  := False;
  FGlyph := btnOk.Glyph;
  btnOk.Glyph := nil;

  // если конфигурация аптека, то отражаю специфичную кнопку
  {if Config = 1 then begin
    lbPackAmount.Visible := True;
    lbMFCountry.Visible := True;
  end else begin
    lbPackAmount.Visible := False;
    lbMFCountry.Visible := False;
    PopupMenu.Items[11].Destroy;
    PopupMenu.Items[10].Destroy;
  end; }
end;

procedure TImportBForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := FCanClose;
end;

procedure TImportBForm.StringGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StringGrid.MouseToCell(X,Y, FCol, FRow);
  if FRow = 0 then begin
    try
      StringGrid.CellStyle[FCol, FRow].BorderCellStyle := sgLowered;
      SelectCol(StringGrid, FCol);
      PopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    finally
      StringGrid.CellStyle[FCol, FRow].BorderCellStyle := sgRaised;
    end;
  end;
end;

procedure TImportBForm.N1Click(Sender: TObject);
var Str : string;
  i : integer;
begin
  // проверка - не должно быть двух одинаковых колонок
  Str := (sender as tmenuitem).Caption;

  if Str = 'Оптовая цена (продажа)' then
    Str := 'Оптовая цена';
  if Str = 'Розничная цена (продажа)' then
    Str := 'Розничная цена';

  for i := 0 to StringGrid.ColCount - 1 do
    if StringGrid.Cells[i, 0] = Str then begin
      MessageDlg('Колонка "' + Str + '" уже назначена! Не может быть двух одинаковых колонок!', mtWarning, [mbOk], 0);
      Exit;
    end;

  StringGrid.Cells[FCol, FRow] := Str;
end;

procedure TImportBForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  FCanClose := True;
end;

procedure TImportBForm.btBack1Click(Sender: TObject);
begin
  IF pSecond.Visible THEN BEGIN
    btBack.Enabled := False;
    pSecond.Visible := False;
    pFirst.Visible  := True;
    aLoad.Enabled := True;
    btnOk.Glyph     := nil;
    btnOk.Caption   := 'Далее';
  END
end;

procedure TImportBForm.aLoadExecute(Sender: TObject);
var
  AFileName: String;
  WorkSheet: OLEVariant;
  V : Variant;
  I, X, Y, R, C: Integer;
  Row_begin : Integer;
  Pnt : String;
begin
  if FileExists(odlg.FileName) then begin
    Screen.Cursor := crHourGlass;
    StringGrid.Enabled := True;
    AFileName := odlg.FileName;
    ExcelInstalled := IsOLEObjectInstalled('Excel.Application');
    OpenOffInstalled := IsOLEObjectInstalled('com.sun.star.ServiceManager');

    IF ExcelInstalled THEN BEGIN
      Pnt := '02';
      Row_begin := MAX(trunc(edNum.Value) - 1, 0);   // начальная строка с которой будет импорт идти, в дальнейшем будет как входной параметр, вдруг если поставят 0, то не буду делать минус 1
      Excel := CreateOleObject('Excel.Application');
      Excel.Workbooks.Open(AFileName);
      WorkSheet := Excel.ActiveWorkbook.ActiveSheet;
      FData := WorkSheet.UsedRange.Value;
      X := WorkSheet.UsedRange.Rows.Count;
      Y := WorkSheet.UsedRange.Columns.Count;
      ProgressBar.Max := X - Row_begin;
      Excel.Quit;
      Excel := Null;
      StringGrid.RowCount := X - Row_begin+1;
      StringGrid.ColCount := Y;
      for R := 0 to StringGrid.RowCount-1 do begin
        for C := 0 to StringGrid.ColCount - 1 do begin
          if R = 0 then
            StringGrid.Cells[C, R] := 'Не грузить'
          else
            StringGrid.Cells[C, R] := FData[Row_begin,C+1];
        end;
        Row_begin := Row_begin + 1;
      end;
    END ELSE BEGIN
      Pnt := '03';
      try
        if not Connect then begin
          MessageDlg('Приложение "Excel" не установлено. Приложение "OpenOffice Calc" не установлено, либо не запускается. Нет возможности для импорта из файла.', mtInformation, [mbOk], 0);
          Screen.Cursor := crDefault;
          Exit;
        end;
      except
        MessageDlg('Приложение "Excel" не установлено. Приложение "OpenOffice Calc" не установлено, либо не запускается. Нет возможности для импорта из файла.', mtInformation, [mbOk], 0);
        Screen.Cursor := crDefault;
        Exit;
      end;
      Row_begin := trunc(edNum.Value) - 1;   // начальная строка с которой будет импорт идти, -1 потому что в Опеноффис строки начинаются с 0
      OpenDocument(AFileName);
      Sheets := Document.GetSheets;
      Sheet := Sheets.getByName('Лист1');
      V := Sheet.createCursor;
      v.GotoEndOfUsedArea(false);
      X := v.RangeAddress.EndRow;
      Y := v.RangeAddress.EndColumn;
      ProgressBar.Max := X - Row_begin;
      FData := Sheet.getCellRangeByPosition(0, Row_begin, v.RangeAddress.EndColumn, v.RangeAddress.EndRow).getDataArray;
      V := Unassigned;
      Pnt := '04';
      Disconnect;
      StringGrid.RowCount := X - Row_begin + 1;
      StringGrid.ColCount := Y;
      for R := 0 to StringGrid.RowCount-1 do
        for C := 0 to StringGrid.ColCount - 1 do begin
          if R = 0 then
            StringGrid.Cells[C, R] := 'Не грузить'
          else
            StringGrid.Cells[C, R] := FData[R][C+1];
        end;
    END;
    pnlRowCnt.Caption := IntToStr(StringGrid.RowCount - 1);
    Screen.Cursor := crDefault;
  end else begin
    MessageDlg('Указанный файл не существует!', mtError, [mbOk], 0);
    bedtFileName.SetFocus;
  end;
end;

procedure TImportBForm.btnOkClick(Sender: TObject);
type
  TLog = array of string;
var
  Row_begin, I : Integer;
  RowForOff : Integer;
  VarArt, VarNom, VarBar, VarName, VarUnit, VarOpt, VarRozn, VarZakup,
  VarOstatok, VarNote, VarPack, VarCountry, VarPlace: Variant;
  Pnt : String;
begin
  inherited;
  FCanClose := False;

  IF pFirst.Visible THEN BEGIN
    if StringGrid.Enabled = False then begin
      MessageDlg('Вы не загрузили файл в таблицу!', mtWarning, [mbOK], 0);
      btBack.Click;
      Exit;
    end;

    //проставляю соответствия колонок, попутно проверяю - не должно быть дублирующихся колонок
    ColArt := -1;
    ColNom := -1;
    ColBar := -1;
    ColName := -1;
    ColUnit := -1;
    ColOpt := -1;
    ColRozn := -1;
    ColZakup := -1;
    ColOstatok := -1;
    ColNote := -1;
    ColPack := -1;
    ColCountry := -1;
    ColPlace := -1;
    for i := 0 to StringGrid.ColCount - 1 do begin
      if StringGrid.Cells[i, 0] = 'Артикул' then
        ColArt := i
      else if StringGrid.Cells[i, 0] = 'Номенкл. номер' then
        ColNom := i
      else if StringGrid.Cells[i, 0] = 'Штрихкод' then
        ColBar := i
      else if StringGrid.Cells[i, 0] = 'Наименование' then
        ColName := i
      else if StringGrid.Cells[i, 0] = 'Ед. измерения' then
        ColUnit := i
      else if StringGrid.Cells[i, 0] = 'Оптовая цена' then
        ColOpt := i
      else if StringGrid.Cells[i, 0] = 'Розничная цена' then
        ColRozn := i
      else if StringGrid.Cells[i, 0] = 'Остаток' then
        ColOstatok := i
      else if StringGrid.Cells[i, 0] = 'Цена последней закупки' then
        ColZakup := i
      else if StringGrid.Cells[i, 0] = 'Примечание' then
        ColNote := i
      else if StringGrid.Cells[i, 0] = 'Количество в упаковке' then
        ColPack := i
      else if StringGrid.Cells[i, 0] = 'Страна-производитель' then
        ColCountry := i
      else if StringGrid.Cells[i, 0] = 'Место на складе' then
        ColPlace := i
    end;

    if ColName = -1 then begin
      MessageDlg('Колонка "Наименование" не выбрана!', mtWarning, [mbOK], 0);
      btBack.Click;
      StringGrid.SetFocus;
      Exit;
    end;

    pSecond.Visible := True;
    btnOk.Glyph     := FGlyph;
    btnOk.Caption   := 'Загрузить';
    pFirst.Visible  := False;
    aLoad.Enabled := False;
    btBack.Enabled  := True;
  END

  // ЗАГРУЗКА ФАЙЛА
  ELSE BEGIN
      if (leCategory.EditValue = 0) or (leCategory.EditValue = null) then begin
        leCategory.SetFocus;
        MessageDlg('Категория товара не выбрана', mtInformation, [mbOK], 0);
        Exit;
      end;

      try
        Screen.Cursor := crHourGlass;
        Memo1.Lines.Add('-------- ЗАГРУЗКА ЗАПИСЕЙ В БАЗУ ---------');
        Row_begin := trunc(edNum.Value) - 1;
        if ExcelInstalled then
          RowForOff := 0
        else
          RowForOff := 1;

        Pnt := '05';
        if not spLoad.Transaction.InTransaction then
          spLoad.Transaction.StartTransaction;
        for I := 1 to StringGrid.RowCount - 1 do begin    // отнимаю 1 - это хедер Стринггрида
          try
            VarArt := '';
            VarNom := '';
            VarBar := '';
            VarName := '';
            VarUnit := '';
            VarOpt := '';
            VarRozn := '';
            VarZakup := '';
            VarOstatok := '';
            VarNote := '';
            VarPack := '';
            VarCountry := '';
            VarPlace := '';

            spLoad.ParamByName('g_product_par_').AsInteger := leCategory.EditValue;
            if ExcelInstalled then begin
              if ColArt > -1 then
                VarArt := FData[I+Row_begin, ColArt + 1]; //находим значение ячейки "Артикул"
              if ColNom > -1 then
                VarNom := FData[I+Row_begin, ColNom+1]; //находим значение ячейки "Номенклатурный номер"
              if ColBar > -1 then
                VarBar := FData[I+Row_begin, ColBar+1]; //находим значение ячейки "штрихкод"
              if ColName > -1 then
                VarName := FData[I+Row_begin, ColName+1]; //находим значение ячейки "Наименование"
              if ColUnit > -1 then
                VarUnit := FData[I+Row_begin, ColUnit+1]; //находим значение ячейки "Ед. измерения"
              if ColOpt > -1 then
                VarOpt := FData[I+Row_begin, ColOpt+1]; //находим значение ячейки "Оптовая цена"
              if ColRozn > -1 then
                VarRozn := FData[I+Row_begin, ColRozn+1]; //находим значение ячейки "Розничная цена"
              if ColZakup > -1 then
                VarZakup := FData[I+Row_begin, ColZakup+1]; //находим значение ячейки "Цена прихода"
              if ColOstatok > -1 then
                VarOstatok := FData[I+Row_begin, ColOstatok+1]; //находим значение ячейки "Остаток"
              if ColNote > -1 then
                VarNote := FData[I+Row_begin, ColNote+1]; //находим значение ячейки "Примечание"
              if ColPack > -1 then
                VarPack := FData[I+Row_begin, ColPack+1]; //находим значение ячейки "Количество в упаковке"
              if ColCountry > -1 then
                VarCountry := FData[I+Row_begin, ColCountry+1]; //находим значение ячейки "Страна-производитель"
              if ColPlace > -1 then
                VarPlace := FData[I+Row_begin, ColPlace+1]; //находим значение ячейки "Место на складе"
            end else begin
              if ColArt > -1 then
                VarArt     := FData[I][ColArt]; //находим значение ячейки "Артикул"
              if ColNom > -1 then
                VarNom     := FData[I][ColNom]; //находим значение ячейки "Номенклатурный номер"
              if ColBar > -1 then
                VarBar     := FData[I][ColBar]; //находим значение ячейки "штрихкод"
              if ColName > -1 then
                VarName    := FData[I][ColName]; //находим значение ячейки "Наименование"
              if ColUnit > -1 then
                VarUnit    := FData[I][ColUnit]; //находим значение ячейки "Ед. измерения"
              if ColOpt > -1 then
                VarOpt     := FData[I][ColOpt]; //находим значение ячейки "Оптовая цена"
              if ColRozn > -1 then
                VarRozn    := FData[I][ColRozn]; //находим значение ячейки "Розничная цена"
              if ColZakup > -1 then
                VarZakup   := FData[I][ColZakup]; //находим значение ячейки "Цена прихода"
              if ColOstatok > -1 then
                VarOstatok := FData[I][ColOstatok]; //находим значение ячейки "Остаток"
              if ColNote > -1 then
                VarNote    := FData[I][ColNote]; //находим значение ячейки "Примечание"
              if ColPack > -1 then
                VarPack    := FData[I][ColPack]; //находим значение ячейки "Количество в упаковке"
              if ColCountry > -1 then
                VarCountry := FData[I][ColCountry]; //находим значение ячейки "Страна-производитель"
              if ColPlace > -1 then
                VarPlace := FData[I][ColPlace]; //находим значение ячейки "Место на складе"
            end;

            //находим значение ячейки "Артикул"
            spLoad.ParamByName('ARTICUL_').AsString := Trim(VarArt);
            //находим значение ячейки "Номенклатурный номер
            spLoad.ParamByName('NOMENCLATUR_NUM_').AsString := Trim(VarNom);
            //находим значение ячейки "штрихкод"
            spLoad.ParamByName('BARCODE_').AsString := Trim(VarBar);
            //находим значение ячейки "Наименование"
            spLoad.ParamByName('NAME_').AsString := Trim(VarName);
            //находим значение ячейки "Ед. измерения"
            spLoad.ParamByName('NAME_G_UNIT_').AsString := VarUnit;
            //находим значение ячейки "Примечание"
            spLoad.ParamByName('NOTE_').AsString := VarNote;

            spLoad.ParamByName('UPDATE_IF_EXIST_').AsInteger := Integer(cbUpdate.Checked);

            //находим значение ячейки "Оптовая цена"
            IF Trim(VarToStr(VarOpt)) <> '' THEN BEGIN
              try
                spLoad.ParamByName('VOLUME_PRICE_').AsDouble := StrToFloat(VarOpt);
              except
                on E: Exception do begin
                  Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Оптовая цена" = ' + Trim(VarToStr(VarOpt)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
                  Screen.Cursor := crDefault;
                  Exit;
                end;
              end
            END ELSE
              spLoad.ParamByName('VOLUME_PRICE_').AsDouble := 0;

            //находим значение ячейки "Розничная цена"
            IF Trim(VarToStr(VarRozn)) <> '' THEN BEGIN
              try
                spLoad.ParamByName('PRICE_').AsDouble := StrToFloat(VarRozn);
              except
                on E: Exception do begin
                  Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Розничная цена" = ' + Trim(VarToStr(VarRozn)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
                  Screen.Cursor := crDefault;
                  Exit;
                end;
              end
            END ELSE
              spLoad.ParamByName('PRICE_').AsDouble := 0;

            //находим значение ячейки "Цена прихода"
            IF Trim(VarToStr(VarZakup)) <> '' THEN BEGIN
              try
                spLoad.ParamByName('SELF_PRICE_').AsDouble := StrToFloat(VarZakup);
              except
                on E: Exception do begin
                  Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Цена прихода" = ' + Trim(VarToStr(VarZakup)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
                  Screen.Cursor := crDefault;
                  Exit;
                end;
              end
            END ELSE
              spLoad.ParamByName('SELF_PRICE_').AsDouble := 0;

            //находим значение ячейки "Количество для прихода"
            IF Trim(VarToStr(VarOstatok)) <> '' THEN BEGIN
            try
                spLoad.ParamByName('Amount_').AsDouble := StrToFloat(VarOstatok);
              except
                on E: Exception do begin
                  Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Остаток" = ' + Trim(VarToStr(VarOstatok)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
                  Screen.Cursor := crDefault;
                  Exit;
                end;
              end
            END ELSE
              spLoad.ParamByName('Amount_').AsDouble := 0;

            //ПОЛЯ НУЖНЫ ТОЛЬКО ДЛЯ АПТЕКИ
            //IF CONFIG = 1 THEN BEGIN
              spLoad.ParamByName('MF_COUNTRY_').AsString := VarCountry;
              spLoad.ParamByName('PLACE_').AsString := VarPlace;

              IF Trim(VarToStr(VarPack)) <> '' THEN BEGIN
              try
                  spLoad.ParamByName('PACK_AMOUNT_').AsDouble := StrToFloat(VarPack);
                except
                  on E: Exception do begin
                    Memo1.Lines.Add('ОШИБКА. Некорректное число в колонке "Количество в упаковке" = ' + Trim(VarToStr(VarPack)) + '. Строка  ' + INTTOSTR(I+Row_begin + RowForOff) +'. ');
                    Screen.Cursor := crDefault;
                    Exit;
                  end;
                end
              END ELSE
                spLoad.ParamByName('PACK_AMOUNT_').AsDouble := 0;
            //END;

            IF (lePostavshik.EditValue <> 0) and (lePostavshik.EditValue <> null) THEN
              spLoad.ParamByName('G_client_').AsInteger := lePostavshik.EditValue;

            IF I = StringGrid.RowCount - 1 THEN
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
      Memo1.Lines.Add(INTTOSTR(I-1) + ' ТОВАРОВ ОБРАБОТАНО.');
      Screen.Cursor := crDefault;

      if spLoad.Transaction.InTransaction then
        spLoad.Transaction.Commit;

      FCanClose := False;
      btnOk.Enabled := False;
  END;
end;

procedure TImportBForm.bedtFileNameClick(Sender: TObject);
begin
  inherited;
  if odlg.Execute then begin
    bedtFileName.Text := odlg.FileName;
    edNum.SetFocus;
  end
end;

procedure TImportBForm.bedtFileNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TImportBForm.btHelpClick(Sender: TObject);
begin
  Helpc := 41;
  inherited;
end;

end.
