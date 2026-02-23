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
  cxButtons, cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TUpdZakupkaTovaraForm = class(TDBEditForm)
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    GroupBox1: TGroupBox;
    Shape10: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape15: TShape;
    Label6: TLabel;
    Shape11: TShape;
    edNDS: TcxCurrencyEdit;
    edNDSSumm: TcxCurrencyEdit;
    pnl1: TPanel;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    edTovar: TcxTextEdit;
    lb2: TLabel;
    shp3: TShape;
    shp4: TShape;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    pnlVesGramm: TPanel;
    lbVesGramm: TLabel;
    shpVesGramm: TShape;
    shpVesGramm1: TShape;
    edVesGramm: TcxCurrencyEdit;
    lbVesGrammPrice: TLabel;
    shpVesGrammPrice: TShape;
    shpVesGrammPrice1: TShape;
    edVesGrammPrice: TcxCurrencyEdit;
    lbPrice: TLabel;
    shp5: TShape;
    lb4: TLabel;
    shp6: TShape;
    lbPriceCurrency: TLabel;
    shpPriceCurrency: TShape;
    lbCurrency: TLabel;
    shpCurrency: TShape;
    shp7: TShape;
    edPrice: TcxCurrencyEdit;
    shp8: TShape;
    edSumm: TcxCurrencyEdit;
    shpPriceCurrency1: TShape;
    edPriceCurrency: TcxCurrencyEdit;
    shpCurrency1: TShape;
    edSummCurrency: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure edNDSChange(Sender: TObject);
    procedure edPricePropertiesChange(Sender: TObject);
    procedure cxCurrencyEdit1PropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edVesGrammPricePropertiesChange(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
  private
    FG_product: Int64;
    FPName: String;
    FIsVozvratUpd : Integer;
  public
    property G_product: Int64 read FG_product write FG_product;
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

  if MyCurrencyFrameForm.Value = 0 then begin
    MyCurrencyFrameForm.edAmount.SetFocus;
    MessageDlg('Количество не указано', mtError, [mbOK], 0);
    Exit;
  end;

  IF MyCurrencyFrameForm.Value > 999999999 THEN BEGIN
    MyCurrencyFrameForm.edAmount.SetFocus;
    MessageDlg('Слишком большой значение!', mtError, [mbOK], 0);
    Exit;
  END;

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

  if not ((FIsVozvratUpd = 0) and (Config = 4)) then begin
    pnlVesGramm.Visible := False;
    edVesGrammPrice.Enabled := False;
  end
  else begin
    lbPrice.Caption := 'Цена закупа за шт.';
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
      if ParamByName('VES_GRAMM_').AsFloat > 0 then begin
        edVesGramm.Value := ParamByName('VES_GRAMM_').AsFloat;
        edVesGrammPrice.Value := edSumm.Value / (edVesGramm.Value * ParamByName('AMOUNT_').AsFloat);
      end;
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

procedure TUpdZakupkaTovaraForm.edVesGrammPricePropertiesChange(
  Sender: TObject);
begin
  edPrice.Value := edVesGrammPrice.Value * edVesGramm.Value;
end;

procedure TUpdZakupkaTovaraForm.MyCurrencyFrameFormedAmountChange(
  Sender: TObject);
begin
  MyCurrencyFrameForm.edAmountChange(Sender);
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
  edSummCurrency.Value := MyCurrencyFrameForm.Value * edPriceCurrency.Value;
  edPrice.ModifiedAfterEnter := True;
end;

end.
