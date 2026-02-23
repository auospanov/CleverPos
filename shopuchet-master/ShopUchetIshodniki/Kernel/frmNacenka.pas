unit frmNacenka;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit,
  Vcl.StdCtrls, cxTextEdit, cxCurrencyEdit, Vcl.ExtCtrls, cxEditRepositoryItems,
  cxClasses, Vcl.AppEvnts, cxButtons, dxSkinsCore, dxSkinBlack, dxSkinBlue,
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
  TNacenkaForm = class(TDlgForm)
    Shape10: TShape;
    edNacenka: TcxCurrencyEdit;
    Label5: TLabel;
    Shape9: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NacenkaForm: TNacenkaForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TNacenkaForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  if ModalResult = mrOk THEN
    SaveSettingsIni('PrihodTovara', 'Nacenka', edNacenka.Value ,'');
end;

procedure TNacenkaForm.FormShow(Sender: TObject);
begin
  inherited;
  edNacenka.Value := ReadDoubleSettingsIni('PrihodTovara', 'Nacenka', 0);
end;

end.
