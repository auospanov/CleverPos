unit frmUpdProdazhaTovara;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, unCommonFunc, Math,
  AppEvnts, frmMyCurrencyFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCurrencyEdit, System.UITypes, System.Actions, cxClasses,
  cxButtons, cxEditRepositoryItems, RegularExpressions, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TUpdProdazhaTovaraForm = class(TDBEditForm)
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    Label1: TLabel;
    Shape1: TShape;
    lbPrice: TLabel;
    shPrice: TShape;
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
    shPrice1: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    lbSkidka: TLabel;
    shSkidka: TShape;
    shSkidka1: TShape;
    lbSummSkidka: TLabel;
    shSummSkidka: TShape;
    shSummSkidka1: TShape;
    rbOpt: TRadioButton;
    rbRoznica: TRadioButton;
    pnSkidka: TPanel;
    rbSkidkaInProcent: TRadioButton;
    rbSkidkaInTenge: TRadioButton;
    spIsHaveDiscount: TpFIBStoredProc;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    edTovar: TcxTextEdit;
    edPrice: TcxCurrencyEdit;
    seSkidka: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    seSkidkaSumm: TcxCurrencyEdit;
    edNDS: TcxCurrencyEdit;
    edNDSSumm: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure rbRoznicaClick(Sender: TObject);
    procedure rbOptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbSkidkaInTengeClick(Sender: TObject);
    procedure rbSkidkaInProcentClick(Sender: TObject);
    procedure MyCurrencyFrameForm1edAmountChange(Sender: TObject);
    procedure edPricePropertiesChange(Sender: TObject);
    procedure seSkidkaPropertiesChange(Sender: TObject);
    procedure edNDSPropertiesChange(Sender: TObject);
    procedure seSkidkaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    FG_product: Int64;
    FPName: String;
    FPrice : Real;
    FVolumePrice : Real;
    FOSTATOK : Double;
    FIs_spisanie : Integer; // 0 - обычный заказ, 1 - списание товара
    FNotMinusOstatok : Integer; // не вычетать товар со склада 0- нет, 1 - да
  public
    property G_product: Int64 read FG_product write FG_product;
    property PName: String read FPName write FPName;
    property Is_spisanie: Integer read FIs_spisanie write FIs_spisanie default 0;
    property Price: Real read FPrice write FPrice;
    property VolumePrice: Real read FVolumePrice write FVolumePrice;
    property OSTATOK: Double read FOSTATOK write FOSTATOK;
    property NotMinusOstatok: Integer read FNotMinusOstatok write FNotMinusOstatok default 0;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure ItogRecalc;
  end;

var
  UpdProdazhaTovaraForm: TUpdProdazhaTovaraForm;

implementation

{$R *.dfm}

function TUpdProdazhaTovaraForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if MyCurrencyFrameForm.Value = 0 then begin
    MyCurrencyFrameForm.edAmount.SetFocus;
    MessageDlg('Количество не указано', mtInformation, [mbOK], 0);
    Exit;
  end;

  {ХЗ зачем изначально ограничение поставил
  if FIs_spisanie = 0 then
    if edPrice.Value = 0 then begin
      ErrControl := edPrice;
      MessageDlg('Цена не указана', mtInformation, [mbOK], 0);
      Exit;
    end;}

  Result := True;
end;

procedure TUpdProdazhaTovaraForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'ZAKAZ_DETAILS_';
end;

procedure TUpdProdazhaTovaraForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    if OpenMode = omInsert then
      ParamByName('G_PRODUCT_').AsInt64 := FG_product;

    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('AMOUNT_').AsFloat := MyCurrencyFrameForm.Value;
    ParamByName('SUMM_').AsFloat := edSumm.Value;
    ParamByName('NDS_').AsFloat := edNDS.Value;
    ParamByName('NDS_SUMM_').AsFloat := edNDSSumm.Value;
    if (seSkidka.Value <> 0) and (edPrice.Value > 0) then begin
      if rbSkidkaInProcent.Checked then begin
        ParamByName('DISCOUNT_PERC_').AsFloat := seSkidka.Value;
        ParamByName('DISCOUNT_TENGE_').AsFloat := edPrice.Value * seSkidka.Value/100;
      end else begin
        //ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((seSkidka.Value * 100 / edPrice.Value), -2);
        //ParamByName('DISCOUNT_TENGE_').AsFloat :=seSkidka.Value;

        ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((seSkidka.Value/MyCurrencyFrameForm.Value * 100 / edPrice.Value), -2);
        ParamByName('DISCOUNT_TENGE_').AsFloat := RoundTo(seSkidka.Value/MyCurrencyFrameForm.Value, -2);
      end;
    end else begin
      ParamByName('DISCOUNT_PERC_').AsFloat := 0;
      ParamByName('DISCOUNT_TENGE_').AsFloat := 0;
    end;
    ParamByName('DISCOUNT_SUMM_').AsFloat := seSkidkaSumm.Value;
    ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
    ParamByName('NOT_MINUS_OSTATOK_').AsInteger := FNotMinusOstatok;
  end;
end;

procedure TUpdProdazhaTovaraForm.GetData;
begin
  inherited;

  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edTovar.Text := ParamByName('TOVAR_NAME_').AsString;
      edPrice.Value := ParamByName('PRICE_').AsFloat;
      MyCurrencyFrameForm.edAmount.Text := ParamByName('AMOUNT_').AsString;
      if ParamByName('DISCOUNT_PERC_').AsFloat > 0 then begin
        rbSkidkaInProcent.Checked := True;
        seSkidka.Value := ParamByName('DISCOUNT_PERC_').AsFloat;
      end else if ParamByName('DISCOUNT_TENGE_').AsFloat > 0 then begin
        rbSkidkaInTenge.Checked := True;
        seSkidka.Value := ParamByName('DISCOUNT_TENGE_').AsFloat;
      end;
      edSumm.Value := ParamByName('SUMM_').AsFloat;
      seSkidkaSumm.Value := ParamByName('DISCOUNT_SUMM_').AsFloat;
      edNDS.Value := ParamByName('NDS_').AsFloat;
      edNDSSumm.Value := ParamByName('NDS_SUMM_').AsFloat;
      FPrice := ParamByName('PRICE_').AsFloat;
      FVolumePrice := ParamByName('VOLUME_PRICE_').AsFloat;
      FOSTATOK     := ParamByName('OSTATOK_').AsInteger;
    end;
  end;

  if OpenMode in [omInsert] then begin
    IF (IsActivated = 0) THEN BEGIN
      MessageDlg('Программа не зарегистрирована.' + #10#13 + 'Включены ограничения на количество продаж!', mtWarning, [mbOk], 0);
      aIns.Enabled := False;
      aUpd.Enabled := False;
      btnOk.Enabled := FALSE;
      EXIT;
    END;

    if not spIsHaveDiscount.Transaction.InTransaction then
        spIsHaveDiscount.Transaction.StartTransaction;

    spIsHaveDiscount.ParamByName('g_product_').AsInt64 := FG_product;
    ExecSP(spIsHaveDiscount);
    with spIsHaveDiscount do begin
      IF ParamByName('IS_HAVE_SKIDKA_').AsString = 'ЕСТЬ' THEN BEGIN
        if ParamByName('SKIDKA_PROC_').AsFloat > 0 then begin
          rbSkidkaInProcent.Checked := True;
          seSkidka.Value := ParamByName('SKIDKA_PROC_').AsFloat
        end else begin
          rbSkidkaInTenge.Checked := True;
          seSkidka.Value := ParamByName('SKIDKA_SUM_').AsFloat;
        end;
      END;
    end;

    edPrice.Value := FPrice;
  end;
end;

procedure TUpdProdazhaTovaraForm.edNDSPropertiesChange(Sender: TObject);
begin
  edNDSSumm.Value := edSumm.Value * edNDS.Value / (100 + edNDS.Value);  //так считается по бухгалтерской формуле
end;

procedure TUpdProdazhaTovaraForm.edPricePropertiesChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TUpdProdazhaTovaraForm.rbRoznicaClick(Sender: TObject);
begin
  edPrice.Value := FPrice;
end;

procedure TUpdProdazhaTovaraForm.rbOptClick(Sender: TObject);
begin
  edPrice.Value := FVolumePrice;
end;

procedure TUpdProdazhaTovaraForm.FormShow(Sender: TObject);
begin
  inherited;
  if FIs_spisanie <> 0 then begin
    lbSkidka.Visible := False;
    shSkidka.Visible := False;
    shSkidka1.Visible := False;
    seSkidka.Visible := False;
    pnSkidka.Visible := False;
    lbSummSkidka.Visible := False;
    shSummSkidka.Visible := False;
    shSummSkidka1.Visible := False;
    seSkidkaSumm.Visible := False;
    GroupBox1.Visible := False;
    rbRoznica.Visible := False;
    rbOpt.Visible     := False;
    //edPrice.Enabled   := False;
    seSkidka.Enabled  := False;
    edNDS.Enabled     := False;
    edPrice.Width := ScaleDimension(373);
    Height := ScaleDimension(220);
  end;

  // менять цену или скидку можно только по отдельному праву
  edPrice.Enabled := HaveRightUpdPriceSale;
  rbRoznica.Enabled := HaveRightUpdPriceSale or HaveRightUpdPriceRoznToOpt;
  rbOpt.Enabled := HaveRightUpdPriceSale or HaveRightUpdPriceRoznToOpt;
  seSkidka.Enabled := HaveRightUpdDiscSale;
  rbSkidkaInProcent.Enabled := HaveRightUpdDiscSale;
  rbSkidkaInTenge.Enabled := HaveRightUpdDiscSale;
end;

procedure TUpdProdazhaTovaraForm.ItogRecalc;
begin
  if (edPrice.Value > 0) then begin
    if rbSkidkaInProcent.Checked then begin
      edSumm.Value := MyCurrencyFrameForm.Value * (edPrice.Value * (1 - seSkidka.Value/100));
      seSkidkaSumm.Value := (MyCurrencyFrameForm.Value * edPrice.Value) - (MyCurrencyFrameForm.Value * edPrice.Value * (1 - seSkidka.Value/100));
    end else begin
      edSumm.Value := MyCurrencyFrameForm.Value * (edPrice.Value - seSkidka.Value);
      seSkidkaSumm.Value := (MyCurrencyFrameForm.Value * edPrice.Value) - (MyCurrencyFrameForm.Value * (edPrice.Value - seSkidka.Value));
    end;
  end else begin
    edSumm.Value := 0;
    seSkidkaSumm.Value := 0;
  end;
  edNDSPropertiesChange(Self);
end;

procedure TUpdProdazhaTovaraForm.rbSkidkaInTengeClick(Sender: TObject);
begin
  inherited;
  ItogRecalc;
end;

procedure TUpdProdazhaTovaraForm.rbSkidkaInProcentClick(Sender: TObject);
begin
  inherited;
  ItogRecalc;
end;

procedure TUpdProdazhaTovaraForm.seSkidkaPropertiesChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TUpdProdazhaTovaraForm.seSkidkaPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if TRegEx.IsMatch(StringReplace(seSkidka.Text, ' ', '', [rfReplaceAll]), '^[0-9.]*$') = False then begin
    ErrorText := 'В поле "Скидка" содержатся нецифровые символы!';
    Error := True;
    Exit;
  end;

  inherited;
end;

procedure TUpdProdazhaTovaraForm.MyCurrencyFrameForm1edAmountChange(
  Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  ItogRecalc;
  edPrice.ModifiedAfterEnter := True;
end;

end.
