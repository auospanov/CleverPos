unit frmSaleDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, frmMyCurrencyFrame,
  StdCtrls, ExtCtrls, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, ActnList, AppEvnts, Buttons,
  cxLookAndFeelPainters, cxButtons, Math, FIB, Registry,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxCurrencyEdit, cxCheckBox, System.UITypes,
  System.Actions, cxClasses, Vcl.Menus, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TSaleDlgForm = class(TDBEditForm)
    aBreakTovar: TAction;
    Panel2: TPanel;
    pn1: TPanel;
    lb5: TLabel;
    lb7: TLabel;
    btnBreakTovar: TButton;
    cbSkidka: TcxComboBox;
    cbPrice: TcxComboBox;
    pnName: TPanel;
    lbName: TLabel;
    lb4: TLabel;
    lb1: TLabel;
    lbSkidka: TLabel;
    lb2: TLabel;
    lb6: TLabel;
    edPrice: TcxCurrencyEdit;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    edSkidka: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    edSkidkaSumm: TcxCurrencyEdit;
    pnlButton: TPanel;
    btn7: TcxButton;
    btn8: TcxButton;
    btn9: TcxButton;
    btn4: TcxButton;
    btn5: TcxButton;
    btn6: TcxButton;
    btn1: TcxButton;
    btn2: TcxButton;
    btn3: TcxButton;
    btn0: TcxButton;
    btnBcksp: TcxButton;
    btnPnt: TcxButton;
    cbShowSaleDlgKeys: TcxCheckBox;
    lbVesGrammPrice: TLabel;
    edVesGrammPrice: TcxCurrencyEdit;
    lbVesGramm: TLabel;
    edVesGramm: TcxCurrencyEdit;
    cbShowForm: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
    procedure aBreakTovarExecute(Sender: TObject);
    procedure cbPriceChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbSkidkaPropertiesChange(Sender: TObject);
    procedure cbPricePropertiesChange(Sender: TObject);
    procedure edSkidkaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edSkidkaPropertiesChange(Sender: TObject);
    procedure edPricePropertiesChange(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure btnBckspClick(Sender: TObject);
    procedure edPriceEnter(Sender: TObject);
    procedure edSkidkaEnter(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountEnter(Sender: TObject);
    procedure edVesGrammPricePropertiesChange(Sender: TObject);
  private
    FProduct : Int64;
    FProductName : String;
    FSkidka      : Double;       // скидка клиента при покупке
    FPrice       : Double;       // цена товара (при инсерте), цена продажи (при апдейте)
    FRoznPrice   : Double;       // розн. цена товара в справочнике
    FAmount      : Double;       // количество, если вдруг юзаются весы
    FOptPrice    : Double;
    FPackAmount  : Double;
    FNotShowAmountWarning : Integer;  //показывать сообщение об отсутствии остатков товаров или нет. Если панель товаров на frmSaleMode отражается, то смс там выходит, тут не нужно
    NdsSumm : Double;        // нужны при редактировании, какое значение там было - его считаю и его же поставлю в Setparams
    FVolumePrice : integer;
    FEdSkidkaFocused  : Boolean;
    FEdPriceFocused   : Boolean;
    FEdAmountFocused   : Boolean;
    FIsMarked : Integer;
    FVesGrammPrice : Double;
    procedure ItogRecalc(Val : Double = 0);
    procedure PrintButtonNum(Num : string);
  public
    property Product : Int64 read FProduct write FProduct;
    property Amount  : Double read FAmount write FAmount;
    property Price : Double read FPrice write FPrice;
    property OptPrice : Double read FOptPrice write FOptPrice;
    property PackAmount : Double read FPackAmount write FPackAmount;
    property ProductName : String read FProductName write FProductName;
    property Skidka : Double read FSkidka write FSkidka;
    property NotShowAmountWarning : Integer read FNotShowAmountWarning write FNotShowAmountWarning;
    property VolumePrice : Integer read FVolumePrice write FVolumePrice;
    property IsMarked : Integer read FIsMarked write FIsMarked;
    property VesGrammPrice : Double read FVesGrammPrice write FVesGrammPrice;
    function CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  SaleDlgForm: TSaleDlgForm;

implementation

uses
  unErrorHandlers, unInitApp, unCommonFunc;

{$R *.dfm}

procedure TSaleDlgForm.ItogRecalc(Val : Double = 0);
var valLocal, valueLocal : Double;
begin
  if Val = 0 then
    valLocal := MyCurrencyFrameForm.Value
  else
    valLocal := Val;

  if (edPrice.Value > 0) then begin
    if edSkidka.Value = 0 then begin
      valueLocal := valLocal * edPrice.Value;
      edSkidkaSumm.Value := 0
    end else begin
      if cbSkidka.ItemIndex = 0 then begin
        valueLocal := valLocal * (edPrice.Value * (1 - edSkidka.Value/100));
        edSkidkaSumm.Value := (valLocal * edPrice.Value) - (valLocal * edPrice.Value * (1 - edSkidka.Value/100))
      end else begin
        if valLocal > 1 then begin
          valueLocal := valLocal * (edPrice.Value - edSkidka.Value);
          edSkidkaSumm.Value := valLocal * edSkidka.Value;
        end else begin
          valueLocal := valLocal * edPrice.Value - edSkidka.Value;
          edSkidkaSumm.Value := edSkidka.Value;
        end;
      end;
    end;
  end else begin
    valueLocal := 0;
    edSkidkaSumm.Value := 0;
  end;

  edSumm.Value := MathRound(valueLocal, 2); // делаю округление, чтобы потом не было проблем при передаче в ФР

  NDSSumm := edSumm.Value * NDSValue / (100 + NDSValue);
end;

procedure TSaleDlgForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('AMOUNT_').AsFloat := MyCurrencyFrameForm.Value;
    ParamByName('SUMM_').AsFloat := edSumm.Value;
    ParamByName('NDS_').AsFloat := NDSValue;
    ParamByName('NDS_SUMM_').AsFloat := NDSSumm;
    if (edSkidka.Value <> 0) and (edPrice.Value > 0) then begin
      if cbSkidka.ItemIndex = 0 then begin
        ParamByName('DISCOUNT_PERC_').AsFloat := edSkidka.Value;
        ParamByName('DISCOUNT_TENGE_').AsFloat := edPrice.Value * edSkidka.Value/100;
      end else begin
        ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((edSkidka.Value/MyCurrencyFrameForm.Value * 100 / edPrice.Value), -2);
        ParamByName('DISCOUNT_TENGE_').AsFloat := RoundTo(edSkidka.Value/MyCurrencyFrameForm.Value, -2);
        //ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((edSkidka.Value * 100 / edPrice.Value), -2);
        //ParamByName('DISCOUNT_TENGE_').AsFloat := edSkidka.Value;
      end;
    end else begin
      ParamByName('DISCOUNT_PERC_').AsFloat := 0;
      ParamByName('DISCOUNT_TENGE_').AsFloat := 0;
    end;
    ParamByName('DISCOUNT_SUMM_').AsFloat := edSkidkaSumm.Value;
    ParamByName('VES_GRAMM_PRICE_').AsFloat := edVesGrammPrice.Value;
    ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
    ParamByName('DO_PRODUCT_IN_SALE_').AsInteger := DoProductInSale;
  end;
end;

function TSaleDlgForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if MyCurrencyFrameForm.Value = 0 then begin
    MyCurrencyFrameForm.edAmount.SetFocus;
    MessageDlg('Количество не указано', mtInformation, [mbOK], 0);
    Exit;
  end;

  if (NotifyNol = 1) and (FNotShowAmountWarning = 0) then      // если панель товаров отражается, то предупреждение выходит там
    if edPrice.Value = 0 then begin
      if MessageDlg('Цена товара указана 0, Вы уверены, что хотите продолжить?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
        edPrice.SetFocus;
        Exit;
      end;
    end;

  Result := True;
end;

procedure TSaleDlgForm.FormShow(Sender: TObject);
begin
// ДЕЛАЮ ЧЕКБОКСЫ КНОПКАМИ
{  SetWindowLong(cbRoznica.Handle, GWL_STYLE, GetWindowLong(cbRoznica.Handle, GWL_STYLE) or BS_PUSHLIKE);
  SetWindowLong(cbOpt.Handle, GWL_STYLE, GetWindowLong(cbOpt.Handle, GWL_STYLE) or BS_PUSHLIKE);
  SetWindowLong(cbSkidkaProc.Handle, GWL_STYLE, GetWindowLong(cbSkidkaProc.Handle, GWL_STYLE) or BS_PUSHLIKE);
  SetWindowLong(cbSkidkaVal.Handle, GWL_STYLE, GetWindowLong(cbSkidkaVal.Handle, GWL_STYLE) or BS_PUSHLIKE);
  SetWindowLong(cbShowForm.Handle, GWL_STYLE, GetWindowLong(cbShowForm.Handle, GWL_STYLE) or BS_PUSHLIKE);  }

  // если конфигурация аптека, то отражаю специфичную кнопку
  if Config = 1 then begin
    aBreakTovar.Visible := True;
    aBreakTovar.Enabled := True;
  end
  else if Config = 4 then begin
    lbVesGrammPrice.Visible := True;
    edVesGrammPrice.Visible := True;
    lbVesGramm.Visible := True;
    edVesGramm.Visible := True;
    lbVesGrammPrice.Enabled := True;
    edVesGrammPrice.Enabled := True;
    lbVesGramm.Enabled := True;
  end;

  GetData;

  if FIsMarked = 0 then
    MyCurrencyFrameForm.edAmount.SetFocus
  else begin
    MyCurrencyFrameForm.edAmount.Enabled := False;
    MyCurrencyFrameForm.Enabled := False;
    aBreakTovar.Enabled := False;
  end;

  if OpenMode = omUpdate then
    cbShowForm.Visible := False;

  if HaveRightToSeeOpt then begin
    if FVolumePrice = 1 then
      cbPrice.ItemIndex := 1;
  end else begin
    cbPrice.ItemIndex := 0;
    cbPrice.Enabled := False;
  end;

  edPrice.Enabled := HaveRightUpdPriceSale;
  edVesGrammPrice.Enabled := HaveRightUpdPriceSale;
  cbPrice.Enabled := (HaveRightUpdPriceSale or HaveRightUpdPriceRoznToOpt) and HaveRightToSeeOpt;
  edSkidka.Enabled := HaveRightUpdDiscSale;
  cbSkidka.Enabled := HaveRightUpdDiscSale;

  cbShowSaleDlgKeys.Checked := ShowSaleDlgKeys = 1;

  if ShowSaleDlgKeys = 0 then begin
    pnlButton.Visible := False;
    Self.Width := ScaleDimension(420);
  end;
end;

procedure TSaleDlgForm.edSkidkaEnter(Sender: TObject);
begin
  FEdSkidkaFocused := True;
  FEdPriceFocused := False;
  FEdAmountFocused := False;
end;

procedure TSaleDlgForm.edSkidkaPropertiesChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TSaleDlgForm.edSkidkaPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  s : string;
begin
  inherited;

  S := GetOffValidation(DisplayValue, Error);
  DisplayValue := S;
end;

procedure TSaleDlgForm.edVesGrammPricePropertiesChange(Sender: TObject);
begin
  edSkidka.Value := 0;
  edPrice.Value := edVesGrammPrice.Value * edVesGramm.Value;
end;

procedure TSaleDlgForm.edPriceEnter(Sender: TObject);
begin
  FEdPriceFocused := True;
  FEdSkidkaFocused := False;
  FEdAmountFocused := False;
end;

procedure TSaleDlgForm.edPricePropertiesChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TSaleDlgForm.MyCurrencyFrameFormedAmountChange(Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  edPrice.ModifiedAfterEnter := True;
  ItogRecalc;
end;

procedure TSaleDlgForm.MyCurrencyFrameFormedAmountEnter(Sender: TObject);
begin
  FEdAmountFocused := True;
  FEdPriceFocused  := False;
  FEdSkidkaFocused := False;
end;

procedure TSaleDlgForm.aBreakTovarExecute(Sender: TObject);
var s : string; f,g : double;
onChange : TNotifyEvent;
begin
  try
    onChange := MyCurrencyFrameForm.edAmount.OnChange;
    MyCurrencyFrameForm.edAmount.OnChange := nil;

    if FPackAmount > 0 then BEGIN
      if InputQuery('Количество поштучно', 'Введите какое количество вы хотите продать из упаковки', s) then begin
        try
          f := StrToFloat(S);
        except
          on E: Exception do begin
            if POS('invalid floating point', LowerCase(E.Message)) > 0 then
              ShowMessage('Введите корректное число!')
            else
              ShowMessage(E.message);
            Exit;
          end;
        end;

        g := roundto(F/FPackAmount, -FormatSettings.CurrencyDecimals);
        MyCurrencyFrameForm.edAmount.Text := FloatToStr(g);
        MyCurrencyFrameForm.Value := g;
        ItogRecalc(F/FPackAmount);
        // как ниже так по идее правильно, но тогда неверно считает сумму проданного
        // например пачка подгузов 4500, в ней 30 штук. Если продают 1 штучук из пачки, то это 150 тг,
        // а по коду ниже считается примерно 148,99
        //ItogRecalc(g);
      end

    END else
      ShowMessage('У товара не указано значение "Количество в упаковке"!');
  finally
    MyCurrencyFrameForm.edAmount.OnChange := onChange;
  end;
end;

procedure TSaleDlgForm.GetData;
var OnChange : TNotifyEvent;
begin
  if OpenMode = omInsert then begin
    spGetData.ParamByName('g_product_').AsInt64 := FProduct;
    spGetData.ParamByName('g_tochka_').AsInt64 := CurSklad;
  end else begin
    spGetData.SQL.Text := 'EXECUTE PROCEDURE GET_ZAKAZ_DETAILS_TMP (?ZAKAZ_DETAILS_)';
    spGetData.ParamByName('ZAKAZ_DETAILS_').AsInt64 := RecID;
  end;

  try
    if not spGetData.Transaction.InTransaction then
      spGetData.Transaction.StartTransaction;

    Screen.Cursor := crSQLWait;
    try
      ExecSP(spGetData);
    finally
      Screen.Cursor := crDefault;
    end;

    if spGetData.Transaction.InTransaction then
      spGetData.Transaction.CommitRetaining;
  except
    on E: EFIBError do begin
      if spGetData.Transaction.InTransaction then
        spGetData.Transaction.RollbackRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBEditForm.GetData)');
    end;
    on E: Exception do begin
      if spGetData.Transaction.InTransaction then
        spGetData.Transaction.RollbackRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBEditForm.GetData)', mtError, [mbOk], 0);
    end;
  end;

  with spGetData do begin
    FPrice := ParamByName('price_').AsFloat;
    FRoznPrice := ParamByName('ROZN_PRICE_').AsFloat;
    FOptPrice  := ParamByName('VOLUME_PRICE_').AsFloat;
    FPackAmount := ParamByName('PACK_AMOUNT_').AsFloat;

    OnChange := edVesGrammPrice.Properties.OnChange;
    edVesGrammPrice.Properties.OnChange := nil;
    edVesGramm.Value := ParamByName('VES_GRAMM_').AsFloat;
    edVesGrammPrice.Value := ParamByName('VES_GRAMM_PRICE_').AsFloat;
    edVesGrammPrice.Properties.OnChange := OnChange;

    if OpenMode = omInsert then begin
      lbName.Caption := ParamByName('name_').AsString;
      edPrice.Value := FPrice;

      // у товара может быть скидка и у клиента может быть скидка, ставлю ту, которая больше
      if FSkidka > ParamByName('skidka_proc_').AsFloat then
        edSkidka.Value := FSkidka
      else begin
        if ParamByName('skidka_summ_').AsFloat > 0 then begin
          cbSkidka.ItemIndex := 1;
          edSkidka.Value := FieldByName('SKIDKA_SUMM_').AsFloat;
        end;  
      end;

      // если товара на складе 0, то блокирую кнопки
      //if (ParamByName('amount_').AsFloat = 0) and (AllowSellAbsGoods = 0) {and (FNotShowAmountWarning = False)} then begin
      //  MessageDlg('Остаток товара на складе 0 и после операции он станет отрицательным. Продолжение невозможно!', mtWarning, [mbYes], 0);
      //  btnOk.Enabled := False;
      //  Exit;
      // end;

      if {(UseScales = 1) and} (FAmount > 0) then
        MyCurrencyFrameForm.edAmount.Text := FloatToStr(FAmount);
    end else begin
      lbName.Caption := ParamByName('TOVAR_NAME_').AsString;
      edPrice.Value := FPrice;
      if FPrice = FOptPrice then
        cbPrice.ItemIndex := 1;
      MyCurrencyFrameForm.edAmount.Text := spGetData.ParamByName('AMOUNT_').AsString;
      if ParamByName('DISCOUNT_TENGE_').AsFloat > 0 then begin
        cbSkidka.ItemIndex := 1;
        edSkidka.Value := ParamByName('DISCOUNT_TENGE_').AsFloat*spGetData.ParamByName('AMOUNT_').AsFloat;
      end else if ParamByName('DISCOUNT_PERC_').AsFloat > 0 then begin
        cbSkidka.ItemIndex := 0;
        edSkidka.Value := ParamByName('DISCOUNT_PERC_').AsFloat;
      end;
      edSumm.Value := ParamByName('SUMM_').AsFloat;
      edSkidkaSumm.Value := ParamByName('DISCOUNT_SUMM_').AsFloat;
      NDSValue := ParamByName('NDS_').AsFloat;
      NdsSumm  := ParamByName('NDS_SUMM_').AsFloat;
    end;
  end;
end;

procedure TSaleDlgForm.btn0Click(Sender: TObject);
begin
  if (Sender as TcxButton).Name = 'btn0' then
    PrintButtonNum('0')

  else if (Sender as TcxButton).Name = 'btn1' then
    PrintButtonNum('1')

  else if (Sender as TcxButton).Name = 'btn2' then
    PrintButtonNum('2')

  else if (Sender as TcxButton).Name = 'btn3' then
    PrintButtonNum('3')

  else if (Sender as TcxButton).Name = 'btn4' then
    PrintButtonNum('4')

  else if (Sender as TcxButton).Name = 'btn5' then
    PrintButtonNum('5')

  else if (Sender as TcxButton).Name = 'btn6' then
    PrintButtonNum('6')

  else if (Sender as TcxButton).Name = 'btn7' then
    PrintButtonNum('7')

  else if (Sender as TcxButton).Name = 'btn8' then
    PrintButtonNum('8')

  else if (Sender as TcxButton).Name = 'btn9' then
    PrintButtonNum('9')

  else if (Sender as TcxButton).Name = 'btnPnt' then
    PrintButtonNum('.');
end;

procedure TSaleDlgForm.btnBckspClick(Sender: TObject);
  procedure delSymb(editSum : TcxCurrencyEdit);
    var s : integer;
  begin
    try
      editSum.SelText := '';
      s := editSum.SelStart;

      if (s = 0) and (editSum.SelText <> '') then
        Exit;

      if (Copy(editSum.Text, s, 1) = '.') or (Copy(editSum.Text, s, 1) = ',') then
        Exit;

      if editSum.Text <> '' then
        editSum.Value := StrToFloat(Copy(editSum.Text, 1, s-1) +
        Copy(editSum.Text, s+1, Length(editSum.Text)));

    finally
      editSum.SetFocus;
      editSum.SelStart := s-1;
    end;
  end;
  procedure delSymb2(editSum : TEdit);
    var s : integer;
  begin
    try
      editSum.SelText := '';
      s := editSum.SelStart;

      if (s = 0) and (editSum.SelText <> '') then
        Exit;

      if (Copy(editSum.Text, s, 1) = '.') or (Copy(editSum.Text, s, 1) = ',') then
        Exit;

      if editSum.Text <> '' then
        editSum.Text := Copy(editSum.Text, 1, s-1) +
        Copy(editSum.Text, s+1, Length(editSum.Text));

    finally
      editSum.SetFocus;
      editSum.SelStart := s-1;
    end;
  end;
begin
  if FEdPriceFocused then
    delSymb(edPrice)
  else if FEdAmountFocused then
    delSymb2(MyCurrencyFrameForm.edAmount)
  else if FEdSkidkaFocused then
    delSymb(edSkidka);
end;

procedure TSaleDlgForm.PrintButtonNum(Num : string);
  procedure setVal(editSum : TcxCurrencyEdit);
    var s : integer;
  begin
    try
      s := editSum.SelStart;
      if s = Length(editSum.Text) then  // если курсор стоит в самом конце, то ничего не делаю и выхожу
        Exit;

      editSum.SelText := '';

      if editSum.Value = 0 then begin
        if Num = '0' then
          editSum.Value := 0
        else
          editSum.Value := StrToFloat(Num);

        Exit;
      end;

      if Num = '.' then begin
        // если след. символ и так точка, то просто перешагиваю через него
        // или если символ точки уже позади курсора
        if (Copy(editSum.Text, s+1, 1) = '.') or (Copy(editSum.Text, s+1, 1) = ',') or
        (Pos('.', editSum.Text) <= s) then
          Exit
        // если же нет, то сначала вырезаю точку, а затем вставляю свою
        else
          editSum.Text := Copy(editSum.Text, 1, Pos('.', editSum.Text)-1) +
            Copy(editSum.Text, Pos('.', editSum.Text)+1, Length(editSum.Text));
      end;

      editSum.Value := StrToFloat(Copy(editSum.Text, 1, s) + Num + Copy(editSum.Text, s + 1, Length(editSum.Text)));
    finally
      // снова выделяю editSum, иначе фокус убегает, т.к. юзер нажимает кнопку
      editSum.SetFocus;
      if ((Copy(editSum.Text, s+1, 1) = '.') or (Copy(editSum.Text, s+1, 1) = ',')) and
      (Num <> '.') then
        editSum.SelStart := s
      else
        editSum.SelStart := s + 1;
    end;
  end;
  procedure setVal2(editSum : TEdit);
    var s : integer;
  begin
    try
      s := editSum.SelStart;
      if s = Length(editSum.Text) then  // если курсор стоит в самом конце, то ничего не делаю и выхожу
        Exit;

      editSum.SelText := '';

      if editSum.Text = '0' then begin
        if Num = '0' then
          editSum.Text := '0'
        else
          editSum.Text := Num;

        Exit;
      end;

      if Num = '.' then begin
        // если след. символ и так точка, то просто перешагиваю через него
        // или если символ точки уже позади курсора
        if (Copy(editSum.Text, s+1, 1) = '.') or (Copy(editSum.Text, s+1, 1) = ',') or
        (Pos('.', editSum.Text) <= s) then
          Exit
        // если же нет, то сначала вырезаю точку, а затем вставляю свою
        else
          editSum.Text := Copy(editSum.Text, 1, Pos('.', editSum.Text)-1) +
            Copy(editSum.Text, Pos('.', editSum.Text)+1, Length(editSum.Text));
      end;

      editSum.Text := Copy(editSum.Text, 1, s) + Num + Copy(editSum.Text, s + 1, Length(editSum.Text));
    finally
      // снова выделяю editSum, иначе фокус убегает, т.к. юзер нажимает кнопку
      editSum.SetFocus;
      if ((Copy(editSum.Text, s+1, 1) = '.') or (Copy(editSum.Text, s+1, 1) = ',')) and
      (Num <> '.') then
        editSum.SelStart := s
      else
        editSum.SelStart := s + 1;
    end;
  end;
begin
  if FEdPriceFocused then
    setVal(edPrice)
  else if FEdAmountFocused then
    setVal2(MyCurrencyFrameForm.edAmount)
  else if FEdSkidkaFocused then
    setVal(edSkidka);
end;

procedure TSaleDlgForm.cbPriceChange(Sender: TObject);
begin
  if cbPrice.ItemIndex = 0 then
    edPrice.Value := FPrice
  else
    edPrice.Value := FOptPrice;
end;

procedure TSaleDlgForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Reg: TRegistry;
begin
  inherited;

  if OpenMode = omInsert then begin
      try
        Reg := TRegistry.Create;
        try
          with Reg do begin
            RootKey := RegSetupRoot;
            LazyWrite := False;  {Сохраняем ключи до закрытия}
            if OpenKey(RegSetupKey, True) then
              try
                {показывать предварительное окно с количеством товара в режиме 0 - нет, 1 - да}
                WriteInteger('ShowSaleDlg', Integer(cbShowForm.Checked));
                ShowSaleDlg := Integer(cbShowForm.Checked);

                ShowSaleDlgKeys := Integer(cbShowSaleDlgKeys.Checked);
                WriteInteger('ShowSaleDlgKeys', ShowSaleDlgKeys);
              finally
                CloseKey;
              end;
          end;
        finally
          Reg.Free;
        end;
      except
        on E: Exception do
          MessageDlg(E.Message + #13#10'(occured in TSaleDlgForm.FormCloseQuery)', mtError, [mbOk], 0);
      end;
  end;    
end;

procedure TSaleDlgForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var ErrControl : TWinControl;
begin
  if (OpenMode = omInsert) and (ModalResult = mrOk) then begin  // вставка происходит в родительской форме
    if not CheckParams(ErrControl) then begin
      if ErrControl <> Nil then
        ErrControl.SetFocus;
        CanClose := False;
    end;
    Exit;
  end;

  inherited;
end;

procedure TSaleDlgForm.cbSkidkaPropertiesChange(Sender: TObject);
begin
  if cbSkidka.ItemIndex = 0 then begin
    lbSkidka.Caption := 'Скидка (%)';
    //if edSkidka.Value > 0 then
    //  edSkidka.Value := RoundTo(edSkidka.Value / MyCurrencyFrameForm.Value * 100 / edPrice.Value, -2);  // делим на количество, может быть там несколько

  end else begin
    lbSkidka.Caption := 'Скидка (ден. ед.)';
    //if edSkidka.Value > 0 then
    //  edSkidka.Value := RoundTo(edSkidka.Value*edPrice.Value /100 , -2) * MyCurrencyFrameForm.Value;    // умножаем на количество, вдруг там несклолько
  end;
  ItogRecalc;
end;

procedure TSaleDlgForm.cbPricePropertiesChange(Sender: TObject);
begin
  if cbPrice.ItemIndex = 0 then
    edPrice.Value := FRoznPrice
  else
    edPrice.Value := FOptPrice
end;

end.
