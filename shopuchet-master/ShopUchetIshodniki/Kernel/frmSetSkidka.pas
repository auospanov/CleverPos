unit frmSetSkidka;

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
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxControls, cxCurrencyEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit;

type
  TSetSkidkaForm = class(TDlgForm)
    lb7: TLabel;
    cbSkidka: TcxComboBox;
    lb6: TLabel;
    edSkidkaSumm: TcxCurrencyEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbSkidkaPropertiesChange(Sender: TObject);
    procedure edSkidkaSummPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetSkidkaForm: TSetSkidkaForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TSetSkidkaForm.cbSkidkaPropertiesChange(Sender: TObject);
begin
  if cbSkidka.ItemIndex = 0 then
    edSkidkaSumm.Properties.MaxValue := 100
  else
    edSkidkaSumm.Properties.MaxValue := 10000000;  //торопился, если ставить 0, то ошибка Index of Bounds
end;

procedure TSetSkidkaForm.edSkidkaSummPropertiesChange(Sender: TObject);
begin
  if edSkidkaSumm.Value < 0 then
    edSkidkaSumm.Value := 0;
end;

procedure TSetSkidkaForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  if ModalResult = mrOk then
    SaveSettingsIni('Salemode', 'SetSkidkaState', cbSkidka.ItemIndex, '');
end;

procedure TSetSkidkaForm.FormShow(Sender: TObject);
begin
  //inherited;

  cbSkidka.ItemIndex := ReadIntSettingsIni('Salemode', 'SetSkidkaState', 0);
end;

end.
