unit frmSalePinCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit,
  Vcl.StdCtrls, cxTextEdit, cxEditRepositoryItems, cxClasses, Vcl.AppEvnts,
  cxButtons, Vcl.ExtCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TSalePinCodeForm = class(TDlgForm)
    Panel2: TPanel;
    edPinCode: TcxTextEdit;
    pnlButton: TPanel;
    btn7: TcxButton;
    btn8: TcxButton;
    btn9: TcxButton;
    btn4: TcxButton;
    btn5: TcxButton;
    btn6: TcxButton;
    btn1: TcxButton;
    btn2: TcxButton;
    btn3: TcxButton;
    btn0: TcxButton;
    btnBcksp: TcxButton;
    lbName: TLabel;
    procedure btnBckspClick(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure PrintButtonNum(Num : string);
  public
    { Public declarations }
  end;

var
  SalePinCodeForm: TSalePinCodeForm;

implementation

{$R *.dfm}

{ TSalePinCodeForm }

procedure TSalePinCodeForm.btn0Click(Sender: TObject);
begin
  if (Sender as TcxButton).Name = 'btn0' then
    PrintButtonNum('0')

  else if (Sender as TcxButton).Name = 'btn1' then
    PrintButtonNum('1')

  else if (Sender as TcxButton).Name = 'btn2' then
    PrintButtonNum('2')

  else if (Sender as TcxButton).Name = 'btn3' then
    PrintButtonNum('3')

  else if (Sender as TcxButton).Name = 'btn4' then
    PrintButtonNum('4')

  else if (Sender as TcxButton).Name = 'btn5' then
    PrintButtonNum('5')

  else if (Sender as TcxButton).Name = 'btn6' then
    PrintButtonNum('6')

  else if (Sender as TcxButton).Name = 'btn7' then
    PrintButtonNum('7')

  else if (Sender as TcxButton).Name = 'btn8' then
    PrintButtonNum('8')

  else if (Sender as TcxButton).Name = 'btn9' then
    PrintButtonNum('9')

  else if (Sender as TcxButton).Name = 'btnPnt' then
    PrintButtonNum('.');
end;

procedure TSalePinCodeForm.btnBckspClick(Sender: TObject);
  procedure delSymb(editSum : TcxTextEdit);
    var s : integer;
  begin
    try
      editSum.SelText := '';
      s := editSum.SelStart;

      if (s = 0) and (editSum.SelText <> '') then
        Exit;

      if editSum.Text <> '' then
        editSum.Text := Copy(editSum.Text, 1, s-1) + Copy(editSum.Text, s+1, Length(editSum.Text));
    finally
      editSum.SetFocus;
      editSum.SelStart := s-1;
    end;
  end;
begin
  delSymb(edPinCode);
end;

procedure TSalePinCodeForm.FormShow(Sender: TObject);
begin
  inherited;

  edPinCode.SetFocus;
end;

procedure TSalePinCodeForm.PrintButtonNum(Num: string);
var s : integer;
begin

  if Length(edPinCode.Text) = edPinCode.Properties.MaxLength then
    Exit;

  try
    s := edPinCode.SelStart;
    edPinCode.Text := Copy(edPinCode.Text, 1, s) + Num + Copy(edPinCode.Text, s + 1, Length(edPinCode.Text));
  finally
    // снова выдел€ю editSum, иначе фокус убегает, т.к. юзер нажимает кнопку
    edPinCode.SetFocus;
    edPinCode.SelStart := s + 1;
  end;
end;

end.
