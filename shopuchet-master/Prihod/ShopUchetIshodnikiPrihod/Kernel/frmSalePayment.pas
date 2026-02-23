unit frmSalePayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ActnList, AppEvnts, ExtCtrls,
  StdCtrls, Buttons, DB, FIBDataSet,
  pFIBDataSet, Math, FIBDatabase, pFIBDatabase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxMemo,
  cxCheckBox, cxTextEdit, cxCurrencyEdit, Vcl.Menus, System.Actions, cxClasses,
  cxButtons;

type
  TSalePaymentForm = class(TDBDlgForm)
    lb1: TLabel;
    lb2: TLabel;
    lbBonus: TLabel;
    lb3: TLabel;
    lbSummSelf: TLabel;
    lb4: TLabel;
    tranRead: TpFIBTransaction;
    btnEqualCash: TBitBtn;
    edSummCash: TcxCurrencyEdit;
    edSdacha: TcxCurrencyEdit;
    edBonus: TcxCurrencyEdit;
    edBonusAll: TcxCurrencyEdit;
    cbPayBonus: TcxCheckBox;
    mNote: TcxMemo;
    ceDoNotCreditBonus: TcxCheckBox;
    edSummNoncash: TcxCurrencyEdit;
    btnOstatokCash: TBitBtn;
    btnOstatokNonCash: TBitBtn;
    btnEqualNonCash: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure cbPayBonusClick(Sender: TObject);
    procedure btnEqualCashClick(Sender: TObject);
    procedure edSummFactPropertiesChange(Sender: TObject);
    procedure ce1PropertiesChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure btnEqualNonCashClick(Sender: TObject);
    procedure btnOstatokCashClick(Sender: TObject);
    procedure btnOstatokNonCashClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FPaymentType : Integer;
    FSummBonus : Double;
    FSummZakaz : Double;
    FBonusPercent : Double;
    FSdacha : Double;
  public
    property PaymentType : Integer read FPaymentType write FPaymentType;
    property SummBonus : Double read FSummBonus write FSummBonus;
    property SummZakaz : Double read FSummZakaz write FSummZakaz;
    property BonusPercent : Double read FBonusPercent write FBonusPercent;
    property Sdacha : Double read FSdacha write FSdacha;
  end;

var
  SalePaymentForm: TSalePaymentForm;

implementation

{$R *.dfm}

procedure TSalePaymentForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  FSdacha := Max((edSummCash.Value + edSummNonCash.Value) - FSummZakaz, 0);
  edSummCash.Value := MAX(edSummCash.Value - Max(edSummCash.Value + edSummNonCash.Value - FSummZakaz, 0), 0);
  edSummNonCash.Value := Min(edSummNonCash.Value, FSummZakaz);
end;

procedure TSalePaymentForm.FormShow(Sender: TObject);
begin
  if FPaymentType = 1 then     // С ГЛАВНОЙ ФОРМЫ 1 - ЭТО БЕЗНАЛИЧНЫЙ РАСЧЕТ
    edSummNonCash.Value := FSummZakaz
  else
    edSummCash.Value := FSummZakaz;

  edBonus.Value := FSummZakaz * FBonusPercent;
  edBonusAll.Value := FSummBonus;
  cbPayBonus.Enabled := edBonusAll.Value > 0;
  ceDoNotCreditBonus.Enabled := edBonus.Value > 0;
end;

procedure TSalePaymentForm.edSummFactPropertiesChange(Sender: TObject);
begin
  if edSummNonCash.Value >= FSummZakaz then
    edSdacha.Value := edSummCash.Value
  else
    edSdacha.Value := (edSummCash.Value + edSummNonCash.Value) - FSummZakaz;

  if cbPayBonus.Checked then
    edSdacha.Value := edSdacha.Value + MIN(FSummZakaz, FSummBonus)
end;

procedure TSalePaymentForm.cbPayBonusClick(Sender: TObject);
begin
  IF cbPayBonus.Checked THEN BEGIN
    edBonusAll.Value := MAX(FSummBonus - FSummZakaz, 0);

    // решил сделать так - если заполнено только "Безналичные", то редактирую "Безналичные",
    // во всех остальных случаях редактирую поле "Наличные", а поле "Безнал" - обнуляю
    if (edSummNonCash.Value > 0) and (edSummCash.Value = 0) then
      edSummNonCash.Value := Max(FSummZakaz - FSummBonus, 0)

    else begin
      edSummCash.Value := Max(FSummZakaz - FSummBonus, 0);
      edSummNonCash.Value := 0;
    end;

  END ELSE BEGIN
    edBonusAll.Value := FSummBonus;

    // решил сделать так - если заполнено только "Безналичные", то редактирую "Безналичные",
    // во всех остальных случаях редактирую поле "Наличные", а поле "Безнал" - обнуляю
    if (edSummNonCash.Value > 0) and (edSummCash.Value = 0) then
      edSummNoncash.Value := FSummZakaz

    else begin
      edSummCash.Value := FSummZakaz;
      edSummNonCash.Value := 0;
    end;

  END;
end;

procedure TSalePaymentForm.ce1PropertiesChange(Sender: TObject);
begin
  if ceDoNotCreditBonus.Checked then
    edBonus.Value := 0
  else
    edBonus.Value := FSummZakaz * FBonusPercent;
end;

procedure TSalePaymentForm.btHelpClick(Sender: TObject);
begin
  Helpc := 16;
  inherited;
end;

procedure TSalePaymentForm.btnOstatokCashClick(Sender: TObject);
begin
  if cbPayBonus.Checked then
    edSummCash.Value := Max(FSummZakaz - FSummBonus - edSummNonCash.Value, 0)
  else
    edSummCash.Value := Max(FSummZakaz - edSummNonCash.Value, 0)
end;

procedure TSalePaymentForm.btnOstatokNonCashClick(Sender: TObject);
begin
  if cbPayBonus.Checked then
    edSummNonCash.Value := Max(FSummZakaz - FSummBonus - edSummCash.Value, 0)
  else
    edSummNonCash.Value := Max(FSummZakaz - edSummCash.Value, 0);
end;

procedure TSalePaymentForm.btnEqualCashClick(Sender: TObject);
begin
  if cbPayBonus.Checked then
    edSummCash.Value := Max(FSummZakaz - FSummBonus, 0)
  else
    edSummCash.Value := FSummZakaz;

  edSummNonCash.Value := 0;
end;

procedure TSalePaymentForm.btnEqualNonCashClick(Sender: TObject);
begin
  if cbPayBonus.Checked then
    edSummNonCash.Value := Max(FSummZakaz - FSummBonus, 0)
  else
    edSummNonCash.Value := FSummZakaz;

  edSummCash.Value := 0;
end;

end.
