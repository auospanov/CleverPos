unit frmTovarNaklForRevis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, DB,
  FIBDataSet, pFIBDataSet, ExtCtrls, StdCtrls, AppEvnts, Buttons, frmDBDlg,
  ActnList, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, system.UITypes, Vcl.Menus, System.Actions,
  cxClasses, cxButtons, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TTovarNaklForRevisForm = class(TDBDlgForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape6: TShape;
    spPrihod: TpFIBDataSet;
    dsPrihod: TDataSource;
    leNakladnaya: TcxLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    Sklad : Int64;
  end;

var
  TovarNaklForRevisForm: TTovarNaklForRevisForm;

implementation

{$R *.dfm}

procedure TTovarNaklForRevisForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSp(spPrihod, False);
  spPrihod.First;
end;

procedure TTovarNaklForRevisForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if ModalResult = mrOK then begin
    if leNakladnaya.EditValue > 0 then
      Sklad := leNakladnaya.EditValue
    else begin
      MessageDlg('Товарная накладная не выбрана!', mtWarning, [mbOK], 0);
      CanClose := False;
    end;
  end
end;

end.
