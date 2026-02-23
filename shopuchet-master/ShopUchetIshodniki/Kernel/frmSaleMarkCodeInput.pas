unit frmSaleMarkCodeInput;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxTextEdit,
  Vcl.StdCtrls, cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons,
  Vcl.ExtCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  TSaleMarkCodeInputForm = class(TDlgForm)
    Label1: TLabel;
    edMarkCode: TcxTextEdit;
    procedure edMarkCodePropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaleMarkCodeInputForm: TSaleMarkCodeInputForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TSaleMarkCodeInputForm.edMarkCodePropertiesChange(Sender: TObject);
begin
  inherited;

  btnOk.Enabled := length(edMarkCode.Text) > 0;
end;

procedure TSaleMarkCodeInputForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  if ModalResult = mrOk then
    if HaveCrSymbol(edMarkCode.text) then begin
      MessageDlg('В коде присутствуют русские буквы!' + CRLF +
        'Возможно код был отсканирован при включенной русской раскладке клавиатуры.' + CRLF +
        'Пожалуйста переключите раскладку на латинскую и попробуйте снова.', mtWarning, [mbOk], 0);
      Canclose := False;

      exit;
    end;
end;

procedure TSaleMarkCodeInputForm.FormShow(Sender: TObject);
begin
  //inherited;

end;

end.
