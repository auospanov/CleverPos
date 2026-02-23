unit frmUpdZakupkaTovara;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, AppEvnts, unCommonFunc,
  frmMyCurrencyFrame, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCurrencyEdit, System.UITypes, System.Actions, cxClasses,
  cxButtons;

type
  TUpdZakupkaTovaraForm = class(TDBEditForm)
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    Label1: TLabel;
    Shape1: TShape;
    Label3: TLabel;
    Shape5: TShape;
    Label4: TLabel;
    Shape7: TShape;
    GroupBox1: TGroupBox;
    Shape10: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape15: TShape;
    Label6: TLabel;
    Shape11: TShape;
    Shape8: TShape;
    Shape6: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    edTovar: TcxTextEdit;
    edPrice: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    edNDS: TcxCurrencyEdit;
    edNDSSumm: TcxCurrencyEdit;
    lbPriceCurrency: TLabel;
    shpPriceCurrency: TShape;
    shpPriceCurrency1: TShape;
    edPriceCurrency: TcxCurrencyEdit;
    lbCurrency: TLabel;
    shpCurrency: TShape;
    shpCurrency1: TShape;
    edSummCurrency: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure edNDSChange(Sender: TObject);
    procedure MyCurrencyFrameForm1edAmountChange(Sender: TObject);
    procedure edPricePropertiesChange(Sender: TObject);
    procedure cxCurrencyEdit1PropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FG_product: Integer;
    FPName: String;
    FIsVozvratUpd : Integer;
  public
    property G_product: Integer read FG_product write FG_product;
    property PName: String read FPName write FPName;
    property IsVozvratUpd : Integer read FIsVozvratUpd write FIsVozvratUpd;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  UpdZakupkaTovaraForm: TUpdZakupkaTovaraForm;

implementation

uses frmZakupkaTovara;

{$R *.dfm}

function TUpdZakupkaTovaraForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  Result := True;
end;

procedure TUpdZakupkaTovaraForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'sklad_';
end;

procedure TUpdZakupkaTovaraForm.FormShow(Sender: TObject);
begin
  inherited;
  if (FIsVozvratUpd <> 0) or (UseCurrency = False) then begin
    lbCurrency.visible := False;
    shpCurrency.Visible := False;
    shpCurrency1.visible := False;
    edSummCurrency.visible := False;
    lbPriceCurrency.visible := False;
    shpPriceCurrency.visible := False;
    shpPriceCurrency1.visible := False;
    edPriceCurrency.visible := False;
  end;
end;

procedure TUpdZakupkaTovaraForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('AMOUNT_').AsFloat := MyCurrencyFrameForm.Value;
    ParamByName('SUMM_').AsFloat := edSumm.Value;
    ParamByName('PRICE_CURRENCY_').AsFloat := edPriceCurrency.Value;
    ParamByName('SUMM_CURRENCY_').AsFloat := edSummCurrency.Value;
    ParamByName('NDS_').AsFloat := edNDS.Value;
    ParamByName('NDS_SUMM_').AsFloat := edNDSSumm.Value;
    ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
  end;
end;

procedure TUpdZakupkaTovaraForm.GetData;
begin
  inherited;

  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edTovar.Text := ParamByName('G_PROD_NAME_').AsString;
      edPrice.Value := ParamByName('PRICE_').AsFloat;
      MyCurrencyFrameForm.edAmount.Text := ParamByName('AMOUNT_').AsString;
      edSumm.Value := ParamByName('SUMM_').AsFloat;
      edPriceCurrency.Value := ParamByName('PRICE_currency_').AsFloat;
      edSummCurrency.Value := ParamByName('SUMM_currency_').AsFloat;
      edNDS.Value := ParamByName('NDS_').AsFloat;
      edNDSSumm.Value := ParamByName('NDS_SUMM_').AsFloat;
    end;
  end;
end;

procedure TUpdZakupkaTovaraForm.cxCurrencyEdit1PropertiesChange(
  Sender: TObject);
begin
  edSummCurrency.Value := MyCurrencyFrameForm.Value * edPriceCurrency.Value;
end;

procedure TUpdZakupkaTovaraForm.edNDSChange(Sender: TObject);
begin
  edNDSSumm.Value := edSumm.Value * edNDS.Value / 100;
end;

procedure TUpdZakupkaTovaraForm.edPricePropertiesChange(Sender: TObject);
begin
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
end;

procedure TUpdZakupkaTovaraForm.MyCurrencyFrameForm1edAmountChange(
  Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
  edSummCurrency.Value := MyCurrencyFrameForm.Value * edPriceCurrency.Value;
  edPrice.ModifiedAfterEnter := True;
end;

end.
