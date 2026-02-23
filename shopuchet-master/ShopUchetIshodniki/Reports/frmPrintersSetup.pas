unit frmPrintersSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxSpinEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, Vcl.ExtCtrls, Vcl.StdCtrls,
  cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons, Printers,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
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
  TPrintersSetupForm = class(TDlgForm)
    lb5: TLabel;
    shp11: TShape;
    shp12: TShape;
    cbPrinters: TcxComboBox;
    lb6: TLabel;
    shp10: TShape;
    shp13: TShape;
    cbBillWidth: TcxComboBox;
    lb7: TLabel;
    shp9: TShape;
    shp14: TShape;
    seSdvig: TcxSpinEdit;
    Label14: TLabel;
    Shape18: TShape;
    edBillQuantity: TcxTextEdit;
    Shape19: TShape;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    FrPrnt: string;
    { Public declarations }
  end;

var
  PrintersSetupForm: TPrintersSetupForm;

implementation

{$R *.dfm}

uses frmSetup;


procedure TPrintersSetupForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  // заполняем принтеры
  try
    cbPrinters.Properties.Items.Assign(Printer.Printers);
    if Trim(FrPrnt) = EmptyStr then
      cbPrinters.ItemIndex := Printer.PrinterIndex
    else
    begin
      for i := 0 to cbPrinters.Properties.Items.Count -1 do
      begin
        if cbPrinters.Properties.Items[i] = FrPrnt then
        begin
          cbPrinters.ItemIndex := i;
          break;
        end;
      end;
    end;
  except
  end;
end;

end.
