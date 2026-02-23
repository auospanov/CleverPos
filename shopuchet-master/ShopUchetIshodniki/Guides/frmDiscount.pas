unit frmDiscount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  AppEvnts, Math, frmPopupTovList, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCurrencyEdit, cxCheckBox, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, System.UITypes, Vcl.ComCtrls, dxCore, cxDateUtils,
  System.Actions, cxClasses, cxButtons, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxCheckComboBox, cxRadioGroup, dxBarBuiltInMenu, frmGridFrame, cxPC,
  frmGridFrameDupl;

type
  TArrOne = record
    Id : Int64;
    IdTov : Int64;
    Price : Double;
  end;

  TArrId = array of TArrOne;

  TDiscountForm = class(TDBEditForm)
    dsRead: TDataSource;
    spRead: TpFIBDataSet;
    pcMain: TcxPageControl;
    tsCommon: TcxTabSheet;
    ceConst: TcxCheckBox;
    ceProcOrTenge: TcxCheckBox;
    deBegin: TcxDateEdit;
    deEnd: TcxDateEdit;
    edName: TcxTextEdit;
    edPrice: TcxCurrencyEdit;
    edSkidkaSum: TcxCurrencyEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    leTovarCategory: TcxLookupComboBox;
    peTovar: TcxPopupEdit;
    sbClear: TSpeedButton;
    seSkidka: TcxCurrencyEdit;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape16: TShape;
    Shape19: TShape;
    Shape2: TShape;
    Shape20: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    tsSklad: TcxTabSheet;
    Panel2: TPanel;
    Label9: TLabel;
    frmSklad: TGridFrameDupl;
    spTochka: TpFIBDataSet;
    dsTochka: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure ceConstChange(Sender: TObject);
    procedure leTovarCategoryChange(Sender: TObject);
    procedure ceProcOrTengeChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure peTovarKeyPress(Sender: TObject; var Key: Char);
    procedure peTovarPropertiesCloseUp(Sender: TObject);
    procedure peTovarPropertiesInitPopup(Sender: TObject);
    procedure seSkidkaPropertiesChange(Sender: TObject);
    procedure edSkidkaSumPropertiesChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSkladtvMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FTovarName : string;
    FPopupTovarForm : TPopupTovListForm;
    FOldTovar : Int64;
    FArrId : TArrId;
    peTovarTag : Int64;
    procedure ChangeFields;
  public
    property TovarName : String read FTovarName write FTovarName;
    property ArrId : TArrId read FArrId write FArrId;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  DiscountForm: TDiscountForm;

implementation

uses frmAppointment, unCommonFunc;

{$R *.dfm}

function TDiscountForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if (leTovarCategory.EditValue = 0) and (High(FArrId) <= 0) then begin
    ErrControl := edName;
    MessageDlg('Категория товара не выбрана!', mtInformation, [mbOK], 0);
    Exit;
  end;

  if ceConst.Checked = False then BEGIN
    if (DateToStr(deBegin.Date) = '00.00.0000') then begin
      ErrControl := deBegin;
      MessageDlg('Период действия акции не введен', mtInformation, [mbOK], 0);
      Exit;
    end;

    if (DateToStr(deEnd.Date) = '00.00.0000') then begin
      ErrControl := deBegin;
      MessageDlg('Период действия акции не введен', mtInformation, [mbOK], 0);
      Exit;
    end;
  END;

  if (edSkidkaSum.Value = 0) AND (seSkidka.Value = 0) then begin
    MessageDlg('Размер скидки не указан', mtInformation, [mbOK], 0);
    pcMain.ActivePage := tsCommon;
    Exit;
  end;

  if (edSkidkaSum.Value = 0) AND (peTovarTag <> 0) and (High(FArrId) = 0) then begin
    MessageDlg('Размер скидки не может быть равен 0! Скорее всего Вы не указали цену товара в справочнике товаров!', mtInformation, [mbOK], 0);
    pcMain.ActivePage := tsCommon;
    Exit;
  end;

  if (FOldTovar <> 0) AND (peTovarTag = 0) then begin
    MessageDlg('Нельзя изменить скидку на единичный товар в скидку на группу товаров! Заведите скидку на группу товаров отдельно.', mtError, [mbOK], 0);
    Exit;
  end;

  if (frmSklad.FillArr = '') and (High(SkladArr) > 0) then begin
    MessageDlg('Вы не указали ни одной торговой точки, где будет действовать акция!', mtError, [mbOK], 0);
    pcMain.ActivePage := tsSklad;
    Exit;
  end;  

  Result := True;
end;

procedure TDiscountForm.GetData;
var onChange : TNotifyEvent;
  i : integer;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    if High(FArrId) > 0 then begin
      Caption := 'Групповое изменение акций/скидок';
      leTovarCategory.Enabled := False;
      leTovarCategory.Text := '';
      peTovar.Text := '';
      peTovar.Enabled := False;
      edPrice.Value := 0;
    end
    else begin
      with spGetData do begin
        edName.Text := ParamByName('NAME_').AsString;
        leTovarCategory.EditValue := ParamByName('G_PRODUCT_PAR_').AsInt64;
        peTovarTag := ParamByName('G_PRODUCT_').AsInt64;
        FOldTovar := peTovarTag;
        peTovar.Text := FTovarName;
        if DateToStr(ParamByName('DATE_BEGIN_').AsDate) <> '30.12.1899' then
          deBegin.Date  := ParamByName('DATE_BEGIN_').AsDate;
        if DateToStr(ParamByName('DATE_END_').AsDate) <> '30.12.1899' then
          deEnd.Date  := ParamByName('DATE_END_').AsDate;
        edPrice.Value := ParamByName('PRICE_').AsFloat;

        seSkidka.Value := ParamByName('SKIDKA_PROC_').AsFloat;

        if seSkidka.Value = 0 then
          ceProcOrTenge.Checked := True;

        onChange := edSkidkaSum.Properties.OnChange;
        edSkidkaSum.Properties.OnChange := nil;
        edSkidkaSum.Value := ParamByName('SKIDKA_SUM_').AsFloat;
        edSkidkaSum.Properties.OnChange := onChange;

        if (DateToStr(ParamByName('DATE_BEGIN_').AsDate) <> '30.12.1899') or (DateToStr(ParamByName('DATE_END_').AsDate) <> '30.12.1899') then
          ceConst.checked := False;

        if ParamByName('g_tochka_').AsString = '' then begin
          for I := 0 to High(SkladArr) do begin
            frmSklad.spReadFrame.Locate('g_tochka', SkladArr[i].ID, []);
            frmSklad.SetCheckOne(frmSklad.tvMain.ViewData.Records[frmSklad.tvMain.DataController.FocusedRecordIndex]);
          end;
        end else begin
          frmSklad.spReadFrame.Locate('g_tochka', ParamByName('g_tochka_').AsInt64, []);
          frmSklad.SetCheckOne(frmSklad.tvMain.ViewData.Records[frmSklad.tvMain.DataController.FocusedRecordIndex]);
        end;        
      end;
    end;
  end;
end;

procedure TDiscountForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('NAME_').AsString := edName.Text;
    if not VarIsNull(leTovarCategory.EditValue) then
      ParamByName('G_PRODUCT_par_').AsInt64 := leTovarCategory.EditValue;
    if peTovarTag <> 0 then
      ParamByName('G_PRODUCT_').AsInt64 := peTovarTag;
    if ceConst.Checked = False then begin
      if DateToStr(deBegin.Date) <> '00.00.0000' then
        ParamByName('DATE_BEGIN_').AsDate := deBegin.Date;
      if DateToStr(deEnd.Date) <> '00.00.0000' then
        ParamByName('DATE_END_').AsDate := deEnd.Date;
    end;
    IF seSkidka.Value > 0 THEN
      ParamByName('SKIDKA_PROC_').AsFloat := seSkidka.Value;
    IF edSkidkaSum.Value > 0 THEN
      ParamByName('SKIDKA_SUM_').AsFloat := edSkidkaSum.Value;
    IF OpenMode = omUpdate then
      ParamByName('price_').AsFloat := edPrice.Value;

    if tsSklad.TabVisible then begin
        // если отмечены все склады, то передаю NULL
        if frmSklad.GetCheckedCount = frmSklad.spReadFrame.RecordCount then
          ParamByName('g_tochka_').Clear
        else
          SP.ParamByName('g_tochka_').AsString := '~' + frmSklad.FillArr;
    end;
  end;
end;

procedure TDiscountForm.FormShow(Sender: TObject);
var i : Integer;
begin
  pcMain.ActivePage := tsCommon;

  inherited;
  OpenSP(spRead, False);
  leTovarCategory.EditValue := 0;

  tsSklad.TabVisible := False;

  // открываю склады, и если больше 1, то делаю вкладку видимой и ставлю галочку на текущий склад
  IF High(SkladArr) > 0 THEN BEGIN
    tsSklad.TabVisible := True;
    OpenSP(frmSklad.spReadFrame, False);
    if OpenMode in [omInsert, omInsertLike] then begin
      frmSklad.spReadFrame.Locate('g_tochka', CurSklad, []);
      frmSklad.SetCheckOne(frmSklad.tvMain.ViewData.Records[frmSklad.tvMain.DataController.FocusedRecordIndex]);
    end;
  END
end;

procedure TDiscountForm.frmSkladtvMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  frmSklad.tvMainMouseDown(Sender, Button, Shift, X, Y);
  edName.ModifiedAfterEnter := True;
end;

procedure TDiscountForm.ceConstChange(Sender: TObject);
begin
  inherited;
  if OpenMode <> omView then begin
    deBegin.Enabled := ceConst.Checked = False;
    deEnd.Enabled := ceConst.Checked = False;

    if ceConst.Checked then begin
      deBegin.Text := '';
      deEnd.Text := '';
    end;
  end;
end;

procedure TDiscountForm.leTovarCategoryChange(Sender: TObject);
begin
  peTovarTag := 0;
  peTovar.Text :=  '';
end;

procedure TDiscountForm.seSkidkaPropertiesChange(Sender: TObject);
begin
  seSkidka.Text := StringReplace(seSkidka.Text, ',', '.', [rfReplaceAll]);

  inherited;

  ChangeFields;
end;

procedure TDiscountForm.ceProcOrTengeChange(Sender: TObject);
begin
  inherited;
  //seSkidka.Value := 0;
  //edSkidkaSum.Value := 0;
  edSkidkaSum.Enabled := ceProcOrTenge.Checked;
  seSkidka.Enabled := ceProcOrTenge.Checked = False;
end;

procedure TDiscountForm.edSkidkaSumPropertiesChange(Sender: TObject);
begin
  edSkidkaSum.Text := StringReplace(edSkidkaSum.Text, ',', '.', [rfReplaceAll]);
  ChangeFields;
end;

procedure TDiscountForm.btHelpClick(Sender: TObject);
begin
  Helpc := 10;
  inherited;
end;

procedure TDiscountForm.sbClearClick(Sender: TObject);
begin
  peTovarTag := 0;
  peTovar.Text :=  '';
end;

procedure TDiscountForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmSklad.FreeList;
end;

procedure TDiscountForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i : integer;
begin
  if (High(FArrId) > 0) and (ModalResult = mrOk) then begin
    for I := 0 to High(FArrId) do begin
      peTovarTag := FArrId[i].IdTov;
      RecID := FArrId[i].Id;
      edPrice.Value := FArrId[i].Price; 
      inherited;
    end;
  end else
    inherited;
end;

procedure TDiscountForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPopupTovarForm := TPopupTovListForm.Create(Self);
  frmSklad.CreateList;
end;

procedure TDiscountForm.peTovarKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TDiscountForm.peTovarPropertiesCloseUp(Sender: TObject);
begin
  if FPopupTovarForm.AcceptRes then begin
    if FPopupTovarForm.spRead.FieldByName('price').AsFloat = 0 then begin
      MessageDlg('Цена товара указана 0. Невозможно создать скидку на подобный товар!', mtError, [mbOk], 0);
      Exit;
    end;

    peTovarTag := FPopupTovarForm.spRead.FieldByName('ID').AsLargeInt;
    (Sender as TcxPopupEdit).Text := FPopupTovarForm.spRead.FieldByName('name').AsString;
    edPrice.Value := FPopupTovarForm.spRead.FieldByName('price').AsFloat;

    ChangeFields;
  end;
end;

procedure TDiscountForm.peTovarPropertiesInitPopup(Sender: TObject);
begin
  peTovar.DroppedDown := True;

  if (leTovarCategory.EditValue <> 0) and (leTovarCategory.EditValue <> null) then
    FPopupTovarForm.spRead.ParamByName('g_product_par_').AsInt64 := leTovarCategory.EditValue;
  FPopupTovarForm.arefresh.Execute;
end;

procedure TDiscountForm.ChangeFields;
begin
  if (peTovarTag <> 0) AND (ceProcOrTenge.Checked = FALSE) AND (High(FArrId) <= 0) then
    edSkidkaSum.Value := edPrice.Value - edPrice.Value * (1 - seSkidka.Value/100)

  else if (peTovarTag > 0) AND (ceProcOrTenge.Checked) AND (High(FArrId) <= 0) then
    seSkidka.Value := RoundTo((edSkidkaSum.Value * 100 / edPrice.Value), -2);
end;

end.

