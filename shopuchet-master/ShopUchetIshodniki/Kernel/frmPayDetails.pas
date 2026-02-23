unit frmPayDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, cxDropDownEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar,
  StdCtrls, AppEvnts, ExtCtrls, Buttons, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCurrencyEdit, System.UITypes, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxClasses, Vcl.Menus, cxButtons, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Data.DB, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, cxCheckBox, cxEditRepositoryItems;

type
  TPayDetailsForm = class(TDlgForm)
    deDate: TcxDateEdit;
    shPayment: TShape;
    shPayment1: TShape;
    lbPayment: TLabel;
    lb1: TLabel;
    sh1: TShape;
    sh2: TShape;
    lb2: TLabel;
    sh3: TShape;
    sh4: TShape;
    sbEqualSumm: TSpeedButton;
    edSumm: TcxCurrencyEdit;
    lbSert: TLabel;
    shpSert: TShape;
    shpSert1: TShape;
    dsPaymentType: TDataSource;
    spPaymentType: TpFIBDataSet;
    lePAYMENT_TYPE: TcxLookupComboBox;
    leSertificate: TcxLookupComboBox;
    spSertificates: TpFIBDataSet;
    dsSertificates: TDataSource;
    tranRead: TpFIBTransaction;
    lb3: TLabel;
    sh5: TShape;
    sh6: TShape;
    edDolg: TcxCurrencyEdit;
    cbShowAllSerts: TcxCheckBox;
    function CheckParams : Boolean;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure sbEqualSummClick(Sender: TObject);
    procedure edSummPropertiesChange(Sender: TObject);
    procedure lePAYMENT_TYPEPropertiesChange(Sender: TObject);
    procedure cbShowAllSertsPropertiesChange(Sender: TObject);
  private
    FOpenMod : Integer;  // 0 - добавить, 1 - изменить
    FGClient : Integer;
    FPaymentType : Integer;
    FSummZakaz : Currency;
    FSummPayments : Currency;
    FSummBonusPayed : Currency;
    FSertificate : Integer;
    FIsZakaz : Integer;  //0 - приход, 1 - продажа
    procedure SetSertificateVisible;
  public
    property PaymentType : Integer read FPaymentType write FPaymentType;
    property SummZakaz : Currency read FSummZakaz write FSummZakaz;
    property SummPayments : Currency read FSummPayments write FSummPayments;
    property SummBonusPayed: Currency read FSummBonusPayed write FSummBonusPayed;
    property Sertificate: Integer read FSertificate write FSertificate;
    property OpenMod: Integer read FOpenMod write FOpenMod;
    property GClient: Integer read FGClient write FGClient;
    property IsZakaz: Integer read FIsZakaz write FIsZakaz;
  end;

var
  PayDetailsForm: TPayDetailsForm;

implementation

uses
  unCommonFunc, Math;

{$R *.dfm}

procedure TPayDetailsForm.cbShowAllSertsPropertiesChange(Sender: TObject);
var ID : integer;
begin
  spSertificates.Filtered := not cbShowAllSerts.Checked;
  if spSertificates.Active then begin
    ID := leSertificate.EditValue;
    OpenSP(spSertificates, True);
    leSertificate.EditValue := ID;
  end;
end;

function TPayDetailsForm.CheckParams : Boolean;
begin
  Result := false;

  if CheckDate(deDate.Date, '01.01.1905', '31.12.2091') = False then begin
    MessageDlg('Введите корректную дату!', mtWarning, [mbYes], 0);
    deDate.SetFocus;
    Exit;
  end;

  if edSumm.Value = 0 then begin
    MessageDlg('Введите сумму платежа!', mtWarning, [mbYes], 0);
    edSumm.SetFocus;
    Exit;
  end;

  IF (lePAYMENT_TYPE.EditValue = 3) AND ((leSertificate.EditValue = 0) or (VarToStr(leSertificate.EditValue) = '')) then begin
    MessageDlg('Номер сертификата не указан!', mtError, [mbOK], 0);
    leSertificate.SetFocus;
    Exit;
  end;

  Result := true;
end;

procedure TPayDetailsForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  if ModalResult = mrOk then
    CanClose := CheckParams;
end;

procedure TPayDetailsForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSP(spPaymentType, False);

  // при приходе товара сертификат не нужне
  if FIsZakaz = 0 then begin
    spPaymentType.Filter := 'g_payment_type in (1,2)';
    spPaymentType.Filtered := True;
  end else begin
    // нельзя изменить способ расчета с наличный/безналичный на сертификат и обратно тоже
    if FOpenMod = 1 then begin
      if FPaymentType in [1,2] then
        spPaymentType.Filter := 'g_payment_type in (1,2)'
      else
        spPaymentType.Filter := 'g_payment_type = 3';
      spPaymentType.Filtered := True;
    end;
  end;

  if FPaymentType > 0 then
    lePAYMENT_TYPE.EditValue := FPaymentType;

  SetSertificateVisible;
  edSummPropertiesChange(Self);

  spSertificates.Filter := 'client = ' + IntToStr(FGClient);
  spSertificates.Filtered := True;
end;

procedure TPayDetailsForm.edSummPropertiesChange(Sender: TObject);
begin
  edDolg.Value := MAX(FSummZakaz - (FSummPayments + edSumm.Value + FSummBonusPayed), 0);
end;

procedure TPayDetailsForm.sbEqualSummClick(Sender: TObject);
begin
  edSumm.Value := FSummZakaz - FSummPayments - FSummBonusPayed;
end;

procedure TPayDetailsForm.SetSertificateVisible;
begin
  if lePAYMENT_TYPE.EditValue = 3 then begin
    lbSert.Visible := True;
    shpSert.Visible := True;
    shpSert1.Visible := True;
    cbShowAllSerts.Visible := True;
    leSertificate.Visible := True;
    leSertificate.SetFocus;
    if spSertificates.Active = False then
      OpenSP(spSertificates, false);
  end else begin
    lbSert.Visible := False;
    shpSert.Visible := False;
    shpSert1.Visible := False;
    leSertificate.Visible := False;
    cbShowAllSerts.Visible := False;
  end;
end;

procedure TPayDetailsForm.lePAYMENT_TYPEPropertiesChange(Sender: TObject);
begin
  SetSertificateVisible;
end;

end.
