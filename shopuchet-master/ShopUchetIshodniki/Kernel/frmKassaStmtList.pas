unit frmKassaStmtList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDBListRO, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxEditRepositoryItems, cxContainer, FIBDataSet, pFIBDataSet, Vcl.ExtCtrls,
  Vcl.Menus, FIBDatabase, pFIBDatabase, cxClasses, System.Actions, Vcl.ActnList,
  dxBar, dxBarExtItems, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinscxPCPainter, dxSkinsdxBarPainter;

type
  TKassaStmtListForm = class(TDBListROForm)
    cbPaymentType: TdxBarCombo;
    dcDateBegin: TdxBarDateCombo;
    dcDateEnd: TdxBarDateCombo;
    clmMainKASSA_STATE: TcxGridDBColumn;
    clmMainK_DATE: TcxGridDBColumn;
    clmMainINPUT: TcxGridDBColumn;
    clmMainDEBET: TcxGridDBColumn;
    clmMainCREDIT: TcxGridDBColumn;
    clmMainOUTPUT: TcxGridDBColumn;
    procedure cbPaymentTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ReadList; override;
  end;

var
  KassaStmtListForm: TKassaStmtListForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

{ TKassaStmtListForm }

procedure TKassaStmtListForm.cbPaymentTypeChange(Sender: TObject);
begin
  Readlist;
end;

procedure TKassaStmtListForm.ReadList;
begin
  spRead.ParamByName('DATE_BEGIN_').AsDate := dcDateBegin.Date;
  spRead.ParamByName('DATE_END_').AsDate := dcDateEnd.Date;
  spRead.ParamByName('G_PAYMENT_TYPE_').AsInteger := cbPaymentType.ItemIndex + 1;
  spRead.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;

  inherited;
end;

end.
