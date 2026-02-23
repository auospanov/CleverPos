unit frmTerminalSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxSpinEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, Vcl.ExtCtrls, Vcl.StdCtrls,
  cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TTerminalSetupForm = class(TDlgForm)
    lb5: TLabel;
    shp11: TShape;
    shp12: TShape;
    shp10: TShape;
    shp13: TShape;
    lb1: TLabel;
    edIp: TcxTextEdit;
    cbTerminal: TcxComboBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
  end;

var
  TerminalSetupForm: TTerminalSetupForm;

implementation

{$R *.dfm}

procedure TTerminalSetupForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
  function OccurrencesOfChar(const S: string): integer;
  var
    i: Integer;
  begin
    result := 0;
    for i := 1 to Length(S) do
      if S[i] = '.' then
        inc(result);
  end;
begin
  inherited;

  if (OccurrencesOfChar(edIp.Text) <> 3) or (edIp.Text = '0.0.0.0') then
  begin
    MessageDlg('Вы не верно указали IP адрес!', mtError, [mbOk], 0);
    edIp.SetFocus;
    Exit;
  end;

  if (cbTerminal.ItemIndex < 0) then
  begin
    MessageDlg('Вы не выбрали терминал!', mtError, [mbOk], 0);
    cbTerminal.SetFocus;
    Exit;
  end;
end;

end.
