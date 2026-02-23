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
  unInitApp, System.UITypes, dxBarBuiltInMenu, Vcl.ComCtrls,
  dxCore, cxDateUtils, System.Actions, cxClasses, Vcl.Menus, cxButtons,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, System.Types, smsc_api, frmPopupClientMultList,
  frmPromotionPopup, cxEditRepositoryItems, unLog;

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
    lbClientType: TLabel;
    Label9: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Label11: TLabel;
    Shape21: TShape;
    Shape22: TShape;
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
    lbPromotion: TLabel;
    shpPromotion: TShape;
    shpPromotion1: TShape;
    Label7: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    edBarcode: TcxTextEdit;
    pePromotionList: TcxPopupEdit;
    lb6: TLabel;
    cxButton1: TcxButton;
    spAddBonusClientPromo: TpFIBStoredProc;
    lbClientPromo: TLabel;
    shpClientPromo: TShape;
    shpClientPromo1: TShape;
    peClientPromo: TcxPopupEdit;
    Label10: TLabel;
    Shape19: TShape;
    Shape20: TShape;
    edMaxBonusPaySumm: TcxCurrencyEdit;
    lbBonus: TLabel;
    shpBonus: TShape;
    shpBonus1: TShape;
    edSummBonusAll: TcxCurrencyEdit;
    lbLastPurchaseDate: TLabel;
    lb7: TLabel;
    shp11: TShape;
    shp12: TShape;
    edDogovorNum: TcxTextEdit;
    lb8: TLabel;
    shp13: TShape;
    shp14: TShape;
    edDogovorDate: TcxDateEdit;
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
    procedure edIDNKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure peClientPropertiesInitPopup(Sender: TObject);
    procedure peClientPropertiesCloseUp(Sender: TObject);
    procedure pePromotionListPropertiesChange(Sender: TObject);
    procedure edDogovorNumKeyPress(Sender: TObject; var Key: Char);
  private
    FId_Category: Int64;
    FIs_supplier: Integer; // 0 - Клиент, 1 - Поставщик
    FChangeSkidka  : boolean;
    FChangeSkidka1 : Boolean;
    FPromotionPopupForm: TPromotionPopupForm;
    FPopupClientForm : TPopupClientMultListForm;
    FSms : SMSC;
    pePromotionListTag, peClientPromoTag : Int64;
    FOldRec : TClientRec;
    FNewRec : TClientRec;
    function FillLog : string;
  public
    property Id_Category: Int64 read FId_Category write FId_Category;
    property Is_supplier: Integer read FIs_supplier write FIs_supplier;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ClientForm: TClientForm;

implementation

uses frmContrAgentType, unCommonFunc;

{$R *.dfm}

procedure TClientForm.FormShow(Sender: TObject);
begin
  pcClient.ActivePage := tsClient;

  inherited;
  IF FIs_supplier = 0 THEN begin
    CAPTION := 'Реквизиты клиента';
    Helpc := 6;
  end ELSE begin
    if FIs_supplier = 1 then
      CAPTION := 'Реквизиты поставщика'
    else
      CAPTION := 'Реквизиты доставщика';
    Helpc := 7;
    seSkidka.Enabled := False;
    tsDCard.TabVisible := False;
    tsSms.TabVisible := False;

    if FIs_supplier = 2 then
      ceByDefault.Visible := False;

    lbPromotion.Visible := False;
    shpPromotion.Visible := False;
    shpPromotion1.Visible := False;
    pePromotionList.Visible := False;
    pePromotionList.Enabled := False;
    lbClientType.Caption := 'Группа поставщиков';
  end;

  spClientCategory.ParamByName('IS_SUPPLIER_').AsInteger := FIs_supplier;
  OpenSp(spClientCategory, False);
  OpenSp(spReadContrAgent, False);
  leContrAgent.EditValue := 2;
  edName.SetFocus;

  //Казахстан, Россия
  if CurrencyVal in [0, 1] then
    edPhone.Properties.EditMask := '+7(999)0000000;1;_'
  //Украина
  else if CurrencyVal = 2 then
    edPhone.Properties.EditMask := '!\+380000000000;1;_'
  //Узбекистан
  else if CurrencyVal = 3 then
    edPhone.Properties.EditMask := '!\+\9\99990000000;1;_'
  //Кыргызстан
  else if CurrencyVal = 4 then
    edPhone.Properties.EditMask := '!\+\9\960000000000;1;_'
  //Армения
  else if CurrencyVal = 5 then
    edPhone.Properties.EditMask := '!\+\39990000000;1;_';

  edSummBonusAll.Enabled := HaveRightUpdBonusClient;
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

  if (edMaxBonusPaySumm.Value < 0) or (edMaxBonusPaySumm.Value > 100) then begin
    ErrControl := edMaxBonusPaySumm;
    MessageDlg('Введите значение от 0 до 100 в поле "Макс. сумма оплаты бонусами (%)"!', mtError, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TClientForm.edDogovorNumKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if (Key in ['''', '"', '`', #9, ';', ',']) Then
    Key := #0;
end;

procedure TClientForm.edIDNKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
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
  shpClientPromo.Visible := False;
  shpClientPromo1.Visible := False;

  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leCategory.EditValue := ParamByName('G_CLIENT_PARENT_').AsInt64;
      leContrAgent.EditValue := ParamByName('G_CONTRAGENT_').AsInt64;
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
      edSummBonusAll.Value := ParamByName('SUMM_').AsFloat;
      lbLastPurchaseDate.Caption := 'Последняя покупка: ' + ParamByName('LAST_PURCHASE_DATE_').AsString;
      lbAllSumm.Caption := 'Общая сумма покупок: ' + Format('%n', [ParamByName('SUMM_All_').AsFloat]);
      edNote.Text := ParamByName('note_').AsString;
      pePromotionListTag := ParamByName('g_promotion_').AsInt64;
      pePromotionList.Text := ParamByName('g_promotion_str_').AsString;
      cbNotifySkidka.Checked := ParamByName('notify_skidka_').AsInteger = 1;
      cbNotifyDR.Checked := ParamByName('notify_dr_').AsInteger = 1;
      peClientPromoTag  := ParamByName('G_CLIENT_PROMO_').AsInt64;
      peClientPromo.Text := ParamByName('FM_PROMO_').AsString;
      edMaxBonusPaySumm.Value := ParamByName('Max_Bonus_Pay_Summ_').AsDouble;
      edDogovorNum.Text       := ParamByName('DOGOVOR_').AsString;
      if DateToStr(ParamByName('DOGOVOR_DATE_').AsDate) <> '30.12.1899' then
        edDogovorDate.Date  := ParamByName('DOGOVOR_DATE_').AsDate;

      FOldRec.Category     := ParamByName('G_CLIENT_PARENT_').AsInt64;
      FOldRec.CategoryName := leCategory.Text;
      FOldRec.Name         := ParamByName('NAME_').AsString;
      FOldrec.ContrAgentType := ParamByName('G_CONTRAGENT_').AsInt64;
      FOldrec.ContrAgentTypeName := leContrAgent.Text;
      FOldrec.FullName     := ParamByName('NAME_full_').AsString;
      FoldRec.IDN          := ParamByName('IDN_').AsString;
      IF ParamByName('DT_').AsDate <> 0 THEN
        FOldRec.BDate        := ParamByName('DT_').AsDate;
      FOldRec.Kbe          := ParamByName('KBE_').AsString;
      FOldrec.Phone        := ParamByName('PHONE_').AsString;
      FOldrec.Beznal       := ParamByName('is_beznal_').AsInteger;
      FOldrec.ByDefault    := ParamByName('by_default_').AsInteger;
      FOldrec.CardNum      := ParamByName('BARCODE_').AsString;
      FOldrec.Discount     := ParamByName('Skidka_').AsFloat;
      FOldrec.Note         := ParamByName('note_').AsString;
      FOldrec.CameFrom     := ParamByName('g_promotion_').AsInt64;
      FOldrec.CameFromName := ParamByName('g_promotion_str_').AsString;
      FOldrec.SmsNotify    := ParamByName('notify_skidka_').AsInteger;
      FOldrec.SmsHBNotify  := ParamByName('notify_dr_').AsInteger;
      FOldrec.BonusVal     := ParamByName('N_PERCENT_').AsFloat;
      FOldrec.BonusSumm    := ParamByName('SUMM_').AsFloat;
      FOldrec.MaxPayBonus  := ParamByName('Max_Bonus_Pay_Summ_').AsDouble;
      FOldrec.DogovorNum := ParamByName('DOGOVOR_').AsString;
      IF ParamByName('DOGOVOR_DATE_').AsDate <> 0 THEN
        FOldRec.DogovorDate        := ParamByName('DOGOVOR_DATE_').AsDate;
    end;
  end;
  if OpenMode = omInsert then
    leCategory.EditValue := FId_Category;

  if (OpenMode in [omInsert, omInsertLike]) then
    sePercent.Value := StrToFloat(IntToStr(BonusOnCreateClient));
end;

procedure TClientForm.peClientPropertiesCloseUp(Sender: TObject);
begin
  if FPopupCLIENTForm.AcceptRes then begin
    peClientPromoTag := FPopupCLIENTForm.spRead.FieldByName('ID').AsLargeInt;
    (Sender as TcxPopupEdit).Text := FPopupCLIENTForm.spRead.FieldByName('name').AsString;
    edNote.ModifiedAfterEnter := true;
  end;
end;

procedure TClientForm.peClientPropertiesInitPopup(Sender: TObject);
begin
  peClientPromo.DroppedDown := True;
  FPopupCLIENTForm.IsPostavshik := 0;
  if OpenMode = omUpdate then begin
    FPopupCLIENTForm.spRead.Filter := 'id <> ' + IntToStr(RecID);
    FPopupCLIENTForm.spRead.Filtered := true;
  end;

  FPopupCLIENTForm.arefresh.Execute;
end;

procedure TClientForm.pePromotionListKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TClientForm.pePromotionListPropertiesChange(Sender: TObject);
begin
  if pePromotionListTag = 9999 then begin
    lbClientPromo.Visible := True;
    shpClientPromo.Visible := True;
    shpClientPromo1.Visible := True;
    peClientPromo.Visible := True;
  end else begin
    lbClientPromo.Visible := False;
    shpClientPromo.Visible := False;
    shpClientPromo1.Visible := False;
    peClientPromo.Visible := False;
    peClientPromoTag := 0;
  end;
end;

procedure TClientForm.pePromotionListPropertiesCloseUp(Sender: TObject);
begin
  inherited;
  if FPromotionPopupForm.AcceptRes then begin
    pePromotionListTag := FPromotionPopupForm.spRead.FieldByName('ID').AsLargeInt;
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
    ParamByName('G_CLIENT_PARENT_').AsInt64 := leCategory.EditValue;
    FNewRec.Category     := leCategory.EditValue;
    FNewRec.CategoryName := leCategory.Text;

    ParamByName('G_CONTRAGENT_').AsInt64 := leContrAgent.EditValue;
    FNewRec.ContrAgentType := leContrAgent.EditValue;
    FNewRec.ContrAgentTypeName := leContrAgent.Text;

    ParamByName('NAME_').AsString := edName.Text;
    FNewRec.Name         := edName.Text;
    ParamByName('NAME_full_').AsString := edNameFull.Text;
    FNewRec.FullName     := edNameFull.Text;

    ParamByName('IDN_').AsString := edIdn.Text;
    FNewRec.IDN          := edIDN.Text;

    IF edDT.CurrentDate > 0 THEN BEGIN
      ParamByName('DT_').AsDate := edDT.CurrentDate;
      FNewRec.BDate        := edDT.Date;
    END
    ELSE
      ParamByName('DT_').Clear;

    ParamByName('KBE_').AsString := edKbe.Text;
    FNewRec.Kbe          := edKbe.Text;

    if (edPhone.Text <> '+7(   )   -    ') AND (edPhone.Text <> '+7          ') then begin
      ParamByName('PHONE_').AsString := edPhone.Text;
      FNewRec.Phone        := edPhone.Text;
    end;

    ParamByName('DOGOVOR_').AsString := edDogovorNum.Text;
    FNewRec.DogovorNum          := edDogovorNum.Text;

    if (edDogovorDate.Text <> '  .  .    ') and (edDogovorDate.Text <> '00.00.0000') then begin
      ParamByName('DOGOVOR_DATE_').AsDate := edDogovorDate.Date;
      FNewRec.DogovorDate                 := edDogovorDate.Date;
    end;

    ParamByName('IS_SUPPLIER_').AsInteger := FIs_supplier;

    ParamByName('by_default_').AsInteger := Integer(ceByDefault.Checked);
    FNewRec.ByDefault    := Integer(ceByDefault.Checked);

    ParamByName('Skidka_').AsFloat := seSkidka.Value;
    FNewRec.Discount     := seSkidka.Value;

    ParamByName('IS_category_').AsInteger := 0;

    ParamByName('IS_beznal_').AsInteger := Integer(ceIsBeznal.Checked);
    FNewRec.Beznal       := Integer(ceIsBeznal.Checked);

    ParamByName('BARCODE_').AsString := edBarcode.Text;
    FNewRec.CardNum      := edBarcode.Text;

    ParamByName('N_PERCENT_').AsFloat := sePercent.Value;
    FNewRec.BonusVal                  := sePercent.Value;

    ParamByName('SUMM_BONUS_ALL_').AsFloat := edSummBonusAll.Value;
    FNewRec.BonusSumm                 := edSummBonusAll.Value;

    ParamByName('note_').AsString := edNote.Text;
    FNewRec.Note                  := edNote.Text;

    if pePromotionListTag <> 0 then begin
      ParamByName('g_promotion_').AsInt64 := pePromotionListTag;
      FNewRec.CameFrom     := pePromotionListTag;
      FNewRec.CameFromName := pePromotionList.Text;
    end;

    ParamByName('notify_skidka_').AsInteger := Integer(cbNotifySkidka.Checked);
    FNewRec.SmsNotify    := Integer(cbNotifySkidka.Checked);
    ParamByName('notify_dr_').AsInteger := Integer(cbNotifyDR.Checked);
    FNewRec.SmsHBNotify  := Integer(cbNotifyDR.Checked);

    if peClientPromoTag <> 0 then
      ParamByName('G_CLIENT_PROMO_').AsInt64 := peClientPromoTag
    else
      ParamByName('G_CLIENT_PROMO_').Clear;

    ParamByName('Max_Bonus_Pay_Summ_').AsDouble := edMaxBonusPaySumm.Value;
    FNewRec.MaxPayBonus  := edMaxBonusPaySumm.Value;

    ParamByName('USER_ID_').AsInt64 := CurrentOfficial;
    ParamByName('LOG_BODY_').AsString := FillLog;
  end;
end;

procedure TClientForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var ret: TStringDynArray;
  phone : string;
  balance, fm, ErrMsg : string;
  SmsId, ErrorCode: integer;
begin
  inherited;

  if (ModalResult = mrOk) and (CanClose) then begin
    if (pePromotionListTag = 9999) and (AddBonusForPromo) then begin
      spAddBonusClientPromo.ParamByName('g_client_').AsInt64 := peClientPromoTag;
      spAddBonusClientPromo.ParamByName('AMOUNT_').AsFloat := AmountBonusForPromo;
      if ExecSPTR(spAddBonusClientPromo) then begin
        phone := spAddBonusClientPromo.ParamByName('phone_').AsString;
        fm    := spAddBonusClientPromo.ParamByName('NAME_').AsString;

        if (SendSmsWhenBonusAdd) and (phone <> '') and
        ((Trim(SmsLogin) <> '') OR (Trim(SmsPassword) <> '')) then begin
          TextSmsWhenBonusAdd := StringReplace(TextSmsWhenBonusAdd, '@name@', fm, [rfIgnoreCase]);
          TextSmsWhenBonusAdd := StringReplace(TextSmsWhenBonusAdd, '@bonus@', FloatToStr(AmountBonusForPromo), [rfIgnoreCase]);
          Send_sms_one(phone, TextSmsWhenBonusAdd, 0, '', balance, ErrorCode, ErrMsg);
        end;
      end;
    end;
  end;
end;

procedure TClientForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_client_';
  FPromotionPopupForm := TPromotionPopupForm.Create(Self);
  FPopupClientForm    := TPopupClientMultListForm.Create(Self);
end;

procedure TClientForm.aInsContrAgentTypeExecute(Sender: TObject);
var ContrAgentTypeForm : TContrAgentTypeForm;
begin
  inherited;
  ContrAgentTypeForm := TContrAgentTypeForm.Create(Self);
  try
    ContrAgentTypeForm.OpenMode := omInsert;
    if ContrAgentTypeForm.ShowModal = mrOk then begin
      OpenSp(spReadContrAgent, False);
      leContrAgent.EditValue := ContrAgentTypeForm.RecID;
    end;
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

function TClientForm.FillLog: string;
var mode : integer;
begin
  Result := '';

  if OpenMode = omInsert then
    mode := 1
  else
    mode := 2;

  Result := FillLogClient(mode, FOldRec, FNewRec);
end;

end.
