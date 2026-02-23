unit frmKassaOstatok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, Menus, ActnList, ExtCtrls, StdCtrls, Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, AppEvnts, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, Vcl.ComCtrls, dxCore, cxDateUtils,
  System.Actions, cxClasses, cxButtons, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxEditRepositoryItems;

type
  TKassaOstatokForm = class(TDBEditForm)
    Label7: TLabel;
    Shape12: TShape;
    edDate: TcxDateEdit;
    Shape13: TShape;
    lbOstatok: TLabel;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    cbNalBeznal: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure edDatePropertiesCloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure GetData; override;
  end;

var
  KassaOstatokForm: TKassaOstatokForm;

implementation

{$R *.dfm}

procedure TKassaOstatokForm.GetData;
begin
  if not spGetData.Transaction.InTransaction then
    spGetData.Transaction.StartTransaction;

  spGetData.ParamByName('g_payment_type_').AsInteger := cbNalBeznal.ItemIndex + 1;
  ExecSP(spGetData);

  if spGetData.Transaction.InTransaction then
    spGetData.Transaction.CommitRetaining;
end;

procedure TKassaOstatokForm.FormShow(Sender: TObject);
begin
  //inherited;
  edDate.Date := Date;
  btnOk.Click;
end;

procedure TKassaOstatokForm.btnOkClick(Sender: TObject);
begin
  spGetData.ParamByName('date_').AsDate := edDate.Date;
  GetData;
  lbOstatok.Caption := 'Остаток: ' + Format('%n', [spGetData.ParamByName('summ_').AsFloat]);
end;

procedure TKassaOstatokForm.edDatePropertiesCloseUp(Sender: TObject);
begin
  inherited;
  btnOk.Click;
end;

procedure TKassaOstatokForm.btHelpClick(Sender: TObject);
begin
  HelpC := 14;
  inherited;
end;

end.
