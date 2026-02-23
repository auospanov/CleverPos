unit frmClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ActnList, ExtCtrls, StdCtrls,
  Buttons, cxEdit, cxCheckBox, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, DB, FIBDataSet, pFIBDataSet, pFIBErrorHandler, AppEvnts,
  cxPC, cxControls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxCurrencyEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalendar,
  unInitApp, frmPromotionPopup, System.UITypes, dxBarBuiltInMenu, Vcl.ComCtrls,
  dxCore, cxDateUtils, System.Actions, cxClasses, Vcl.Menus, cxButtons,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TClientForm = class(TDBEditForm)
    aInsContrAgentType: TAction;
    spClientCategory: TpFIBDataSet;
    dsClientCategory: TDataSource;
    spReadContrAgent: TpFIBDataSet;
    dsReadContrAgent: TDataSource;
    pcClient: TcxPageControl;
    tsClient: TcxTabSheet;
    tsDCard: TcxTabSheet;
    Shape9: TShape;
    Shape4: TShape;
    Shape26: TShape;
    Shape25: TShape;
    Shape2: TShape;
    Shape10: TShape;
    Label5: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    Label9: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Label11: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    lbBonusSumm: TLabel;
    lbAllSumm: TLabel;
    leCategory: TcxLookupComboBox;
    edName: TcxTextEdit;
    seSkidka: TcxCurrencyEdit;
    ceByDefault: TcxCheckBox;
    seSkidka1: TcxCurrencyEdit;
    sePercent: TcxCurrencyEdit;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    lb2: TLabel;
    shp3: TShape;
    shp4: TShape;
    edNote: TcxTextEdit;
    lb3: TLabel;
    shp5: TShape;
    shp6: TShape;
    edDT: TcxDateEdit;
    edPhone: TcxMaskEdit;
    tsSms: TcxTabSheet;
    lb4: TLabel;
    shp7: TShape;
    shp8: TShape;
    cbNotifySkidka: TcxCheckBox;
    shp9: TShape;
    lb5: TLabel;
    cbNotifyDR: TcxCheckBox;
    shp10: TShape;
    tsMisc: TcxTabSheet;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    edIDN: TcxTextEdit;
    lbNameFull: TLabel;
    shpNameFull: TShape;
    shpNameFull1: TShape;
    edNameFull: TcxTextEdit;
    Label4: TLabel;
    edKBE: TcxTextEdit;
    Shape7: TShape;
    Shape8: TShape;
    Label8: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    leContrAgent: TcxLookupComboBox;
    Label6: TLabel;
    Shape11: TShape;
    ceIsBeznal: TcxCheckBox;
    Shape12: TShape;
    Label14: TLabel;
    Shape27: TShape;
    Shape28: TShape;
    Label7: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    edBarcode: TcxTextEdit;
    pePromotionList: TcxPopupEdit;
    lb6: TLabel;
    cxButton1: TcxButton;
    cbPayOnlyMaster: TcxCheckBox;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aInsContrAgentTypeExecute(Sender: TObject);
    procedure seSkidkaPropertiesChange(Sender: TObject);
    procedure seSkidka1PropertiesChange(Sender: TObject);
    procedure edNameKeyPress(Sender: TObject; var Key: Char);
    procedure edPhonePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edNameFullEnter(Sender: TObject);
    procedure pePromotionListPropertiesCloseUp(Sender: TObject);
    procedure pePromotionListPropertiesInitPopup(Sender: TObject);
    procedure pePromotionListKeyPress(Sender: TObject; var Key: Char);
    procedure cbPayOnlyMasterPropertiesChange(Sender: TObject);
  private
    FId_Category: Integer;
    FIs_supplier: Integer; // 0 - Клиент, 1 - Поставщик
    FChangeSkidka  : boolean;
    FChangeSkidka1 : Boolean;
    FPromotionPopupForm: TPromotionPopupForm;
  public
    property Id_Category: Integer read FId_Category write FId_Category;
    property Is_supplier: Integer read FIs_supplier write FIs_supplier;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ClientForm: TClientForm;

implementation

uses frmContrAgentType;

{$R *.dfm}

procedure TClientForm.FormShow(Sender: TObject);
begin
  pcClient.ActivePage := tsClient;

  inherited;
  IF FIs_supplier = 0 THEN begin
    CAPTION := 'Реквизиты клиента';
    Helpc := 6;
  end ELSE begin
    CAPTION := 'Реквизиты поставщика';
    Helpc := 7;
    seSkidka.Enabled := False;
    tsDCard.TabVisible := False;
    tsSms.TabVisible := False;
  end;

  OpenSp(spClientCategory, False);
  OpenSp(spReadContrAgent, False);
  leContrAgent.EditValue := 2;
  edName.SetFocus;

  if AppName = 'SalonUchet' then begin
    lbNameFull.Visible := False;
    shpNameFull.Visible := False;
    shpNameFull1.Visible := False;
    edNameFull.Visible := False;
  end
end;

procedure TClientForm.cbPayOnlyMasterPropertiesChange(Sender: TObject);
begin
  inherited;
  seSkidka.Value := 0;
end;

function TClientForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  {if Trim(leCategory.Text) = EmptyStr then begin
    ErrControl := leCategory;
    MessageDlg('Категория не выбрана', mtInformation, [mbOK], 0);
    Exit;
  end;}

  if Trim(leContrAgent.Text) = EmptyStr then begin
    ErrControl := leContrAgent;
    MessageDlg('Тип контрагента не выбран', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(edName.Text) = EmptyStr then begin
    ErrControl := edName;
    MessageDlg('Наименование не введено', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TClientForm.edNameFullEnter(Sender: TObject);
begin
  if Trim(edNameFull.Text) = '' then
    edNameFull.Text := edName.Text;
end;

procedure TClientForm.edNameKeyPress(Sender: TObject; var Key: Char);
Var S : String;
begin
  if (edName.SelStart = 0) then begin
    S := AnsiUpperCase(Key);
    Key := S[1];
  end;
end;

procedure TClientForm.edPhonePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  //inherited;
  if Error then begin
    MessageDlg('Некорректное значение номера телефона. Исправьте, либо очистите поле!', mtWarning, [mbOk], 0);
    edPhone.SetFocus;
    Error := False;
  end;
end;

procedure TClientForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leCategory.EditValue := ParamByName('G_CLIENT_PARENT_').AsInteger;
      leContrAgent.EditValue := ParamByName('G_CONTRAGENT_').AsInteger;
      edName.TEXT := ParamByName('NAME_').AsString;
      edNameFull.TEXT := ParamByName('NAME_full_').AsString;
      edIDN.TEXT := ParamByName('IDN_').AsString;
      IF ParamByName('DT_').AsDate <> 0 THEN
        edDT.Date := ParamByName('DT_').AsDate;
      edKBE.TEXT := ParamByName('KBE_').AsString;
      edPhone.Text := ParamByName('PHONE_').AsString;
      seSkidka.Value := ParamByName('Skidka_').AsFloat;
      ceIsBeznal.CHECKED := ParamByName('is_beznal_').AsInteger = 1;
      ceByDefault.CHECKED := ParamByName('by_default_').AsInteger = 1;
      edBarcode.Text := ParamByName('BARCODE_').AsString;
      sePercent.Value := ParamByName('N_PERCENT_').AsFloat;
      lbBonusSumm.Caption := 'Сумма накоплений ' + ParamByName('SUMM_').AsString;
      lbAllSumm.Caption := 'Общая сумма покупок ' + ParamByName('SUMM_All_').AsString;
      edNote.Text := ParamByName('note_').AsString;
      pePromotionList.Tag := ParamByName('g_promotion_').AsInteger;
      pePromotionList.Text := ParamByName('g_promotion_str_').AsString;
      if AppName = 'SalonUchet' then begin
        cbNotifySkidka.Checked := ParamByName('notify_skidka_').AsInteger = 1;
        cbNotifyDR.Checked := ParamByName('notify_dr_').AsInteger = 1;
      end;
      cbPayOnlyMaster.Checked := ParamByName('is_paying_only_master_').AsInteger = 1;
    end;
  end;
  if OpenMode = omInsert then
    leCategory.EditValue := FId_Category;
end;

procedure TClientForm.pePromotionListKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TClientForm.pePromotionListPropertiesCloseUp(Sender: TObject);
begin
  inherited;
  if FPromotionPopupForm.AcceptRes then begin
    (Sender as TcxPopupEdit).Tag := FPromotionPopupForm.spRead.FieldByName('ID').AsInteger;
    (Sender as TcxPopupEdit).Text := FPromotionPopupForm.spRead.FieldByName('name').AsString;
    edName.ModifiedAfterEnter := True;
  end;
end;

procedure TClientForm.pePromotionListPropertiesInitPopup(Sender: TObject);
begin
  pePromotionList.DroppedDown := True;
  FPromotionPopupForm.arefresh.Execute;
end;

procedure TClientForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('G_CLIENT_PARENT_').AsInteger := leCategory.EditValue;
    ParamByName('G_CONTRAGENT_').AsInteger := leContrAgent.EditValue;
    ParamByName('NAME_').AsString := edName.Text;
    ParamByName('NAME_full_').AsString := edNameFull.Text;
    ParamByName('IDN_').AsString := edIdn.Text;
    IF edDT.CurrentDate > 0 THEN
      ParamByName('DT_').AsDate := edDT.CurrentDate;
    ParamByName('KBE_').AsString := edKbe.Text;
    if (edPhone.Text <> '+7(   )   -    ') AND (edPhone.Text <> '+7          ') then
      ParamByName('PHONE_').AsString := edPhone.Text;
    ParamByName('IS_SUPPLIER_').AsInteger := FIs_supplier;
    ParamByName('by_default_').AsInteger := Integer(ceByDefault.Checked);
    ParamByName('Skidka_').AsFloat := seSkidka.Value;
    ParamByName('IS_category_').AsInteger := 0;
    ParamByName('IS_beznal_').AsInteger := Integer(ceIsBeznal.Checked);
    ParamByName('BARCODE_').AsString := edBarcode.Text;
    ParamByName('N_PERCENT_').AsFloat := sePercent.Value;
    ParamByName('note_').AsString := edNote.Text;
    if pePromotionList.Tag <> 0 then
      ParamByName('g_promotion_').AsInteger := pePromotionList.Tag;
    ParamByName('notify_skidka_').AsInteger := Integer(cbNotifySkidka.Checked);
    ParamByName('notify_dr_').AsInteger := Integer(cbNotifyDR.Checked);
    ParamByName('is_paying_only_master_').AsInteger := Integer(cbPayOnlyMaster.Checked);
  end;
end;

procedure TClientForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_client_';
  FPromotionPopupForm := TPromotionPopupForm.Create(Self);
end;

procedure TClientForm.aInsContrAgentTypeExecute(Sender: TObject);
begin
  inherited;
  ContrAgentTypeForm := TContrAgentTypeForm.Create(Self);
  try
    ContrAgentTypeForm.OpenMode := omInsert;
    if ContrAgentTypeForm.ShowModal = mrOk then
      OpenSp(spReadContrAgent, False);
  finally
    ContrAgentTypeForm.Free;
  end;
end;

procedure TClientForm.seSkidka1PropertiesChange(Sender: TObject);
begin
  FChangeSkidka1 := True;

  if FChangeSkidka = False then
    seSkidka.Value := seSkidka1.Value;

  FChangeSkidka1 := False;
end;

procedure TClientForm.seSkidkaPropertiesChange(Sender: TObject);
begin
  FChangeSkidka := True;
  if FChangeSkidka1 = False then
    seSkidka1.Value := seSkidka.Value;
  FChangeSkidka := False;
end;

end.
