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
  cxDateUtils, cxClasses, Vcl.Menus, cxButtons;

type
  TPayDetailsForm = class(TDlgForm)
    deDate: TcxDateEdit;
    cbPayment: TcxComboBox;
    shPayment: TShape;
    shPayment1: TShape;
    lbPayment: TLabel;
    lb1: TLabel;
    sh1: TShape;
    sh2: TShape;
    lb2: TLabel;
    sh3: TShape;
    sh4: TShape;
    lb3: TLabel;
    sh5: TShape;
    sh6: TShape;
    sbEqualSumm: TSpeedButton;
    edDolg: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    function CheckParams : Boolean;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure sbEqualSummClick(Sender: TObject);
    procedure edSummPropertiesChange(Sender: TObject);
  private
    FPaymentType : Integer;
    FSummZakaz : Currency;
    FSummPayments : Currency;
    FSummBonusPayed : Currency;
  public
    property PaymentType : Integer read FPaymentType write FPaymentType;
    property SummZakaz : Currency read FSummZakaz write FSummZakaz;
    property SummPayments : Currency read FSummPayments write FSummPayments;
    property SummBonusPayed: Currency read FSummBonusPayed write FSummBonusPayed;
  end;

var
  PayDetailsForm: TPayDetailsForm;

implementation

uses
  unCommonFunc, Math;

{$R *.dfm}

function TPayDetailsForm.CheckParams : Boolean;
begin
  Result := false;

  if CheckDate(deDate.Date, '01.01.1905', '31.12.2091') = False then begin
    MessageDlg('¬ведите корректную дату!', mtWarning, [mbYes], 0);
    deDate.SetFocus;
    Exit;
  end;

  if edSumm.Value = 0 then begin
    MessageDlg('¬ведите сумму платежа!', mtWarning, [mbYes], 0);
    edSumm.SetFocus;
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
  if FPaymentType > 0 then
    cbPayment.ItemIndex := FPaymentType - 1;

  edSummPropertiesChange(Self);
end;

procedure TPayDetailsForm.edSummPropertiesChange(Sender: TObject);
begin
  edDolg.Value := MAX(FSummZakaz - (FSummPayments + edSumm.Value + FSummBonusPayed), 0);
end;

procedure TPayDetailsForm.sbEqualSummClick(Sender: TObject);
begin
  edSumm.Value := FSummZakaz - FSummPayments - FSummBonusPayed;
end;

end.
