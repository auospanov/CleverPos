unit frmSaleCommonDilg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue,
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
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  cxEditRepositoryItems, cxEdit, cxClasses, cxContainer, Vcl.AppEvnts,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxControls, cxTextEdit;

type
  TSaleCommonDilgForm = class(TDlgForm)
    edStrField: TcxTextEdit;
    lb4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edStrFieldKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaleCommonDilgForm: TSaleCommonDilgForm;

implementation

{$R *.dfm}

procedure TSaleCommonDilgForm.edStrFieldKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TSaleCommonDilgForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  if ModalResult = mrOk then
    if Length(edStrField.Text) < 12 then begin
      MessageDlg('ИИН/БИН клиента не может быть меньше 12 символов!', mtError, [mbOk], 0);
      CanClose := False;
      edStrField.SetFocus;
      Exit;
    end;
end;

procedure TSaleCommonDilgForm.FormShow(Sender: TObject);
begin
  //inherited;

end;

end.
