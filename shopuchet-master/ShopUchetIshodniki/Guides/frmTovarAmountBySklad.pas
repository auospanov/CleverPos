unit frmTovarAmountBySklad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxTextEdit, FIBDatabase, pFIBDatabase, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, FIBDataSet,
  pFIBDataSet, cxEditRepositoryItems, cxClasses, cxContainer, Vcl.AppEvnts,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxCurrencyEdit, dxSkinsCore,
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
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TTovarAmountBySkladForm = class(TDlgForm)
    spRead: TpFIBDataSet;
    dsRead: TDataSource;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    lv1: TcxGridLevel;
    tranRead: TpFIBTransaction;
    tvProductNAME: TcxGridDBColumn;
    tvProductAMOUNT: TcxGridDBColumn;
    tvProductAMOUNT_RESERVE: TcxGridDBColumn;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    GProduct : Int64;
    Sklad    : Int64;
  end;

var
  TovarAmountBySkladForm: TTovarAmountBySkladForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TTovarAmountBySkladForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  tvProduct.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvProduct.name);
end;

procedure TTovarAmountBySkladForm.FormShow(Sender: TObject);
begin
  inherited;
  tvProduct.Styles.Header.Font.Size := 11;
  grProduct.Font.Size := 11;
  spRead.ParamByName('g_product_').AsInt64 := GProduct;
  spRead.ParamByName('g_tochka_').AsInt64 := Sklad;
  OpenSP(spRead, False);
end;

end.
