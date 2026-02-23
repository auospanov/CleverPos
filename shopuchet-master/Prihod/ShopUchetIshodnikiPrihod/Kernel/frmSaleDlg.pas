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
  System.Actions, cxClasses, Vcl.Menus;

type
  TSaleDlgForm = class(TDBEditForm)
    lb4: TLabel;
    lb1: TLabel;
    lbSkidka: TLabel;
    lb2: TLabel;
    lb6: TLabel;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    pnName: TPanel;
    aBreakTovar: TAction;
    lbName: TLabel;
    pn1: TPanel;
    lb5: TLabel;
    lb7: TLabel;
    btnBreakTovar: TButton;
    pnShowDlg: TPanel;
    cbSkidka: TcxComboBox;
    cbPrice: TcxComboBox;
    edPrice: TcxCurrencyEdit;
    edSkidka: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    edSkidkaSumm: TcxCurrencyEdit;
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
  private
    FProduct : Integer;
    FProductName : String;
    FSkidka      : Double;       // скидка клиента при покупке
    FPrice       : Double;       // цена товара (при инсерте), цена продажи (при апдейте)
    FRoznPrice   : Double;       // розн. цена товара в справочнике
    FAmount      : Double;       // количество, если вдруг юзаются весы
    FOptPrice    : Double;
    FPackAmount  : Double;
    FNotShowAmountWarning : Boolean;  //показывать сообщение об отсутствии остатков товаров или нет. Если панель товаров на frmSaleMode отражается, то смс там выходит, тут не нужно
    NdsSumm : Double;        // нужны при редактировании, какое значение там было - его считаю и его же поставлю в Setparams
    FVolumePrice : boolean;
    procedure ItogRecalc;
  public
    property Product : Integer read FProduct write FProduct;
    property Amount  : Double read FAmount write FAmount;
    property Price : Double read FPrice write FPrice;
    property OptPrice : Double read FOptPrice write FOptPrice;
    property PackAmount : Double read FPackAmount write FPackAmount;
    property ProductName : String read FProductName write FProductName;
    property Skidka : Double read FSkidka write FSkidka;
    property NotShowAmountWarning : Boolean read FNotShowAmountWarning write FNotShowAmountWarning;
    property VolumePrice : Boolean read FVolumePrice write FVolumePrice;
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

procedure TSaleDlgForm.ItogRecalc;
begin
  if (edPrice.Value > 0) then begin
    if edSkidka.Value = 0 then begin
      edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
      edSkidkaSumm.Value := 0
    end else begin
      if cbSkidka.ItemIndex = 0 then begin
        edSumm.Value := MyCurrencyFrameForm.Value * (edPrice.Value * (1 - edSkidka.Value/100));
        edSkidkaSumm.Value := (MyCurrencyFrameForm.Value * edPrice.Value) - (MyCurrencyFrameForm.Value * edPrice.Value * (1 - edSkidka.Value/100))
      end else begin
        if MyCurrencyFrameForm.Value > 1 then begin
          edSumm.Value := MyCurrencyFrameForm.Value * (edPrice.Value - edSkidka.Value);
          edSkidkaSumm.Value := MyCurrencyFrameForm.Value * edSkidka.Value;
        end else begin
          edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value - edSkidka.Value;
          edSkidkaSumm.Value := edSkidka.Value;
        end;
      end;
    end;
  end else begin
    edSumm.Value := 0;
    edSkidkaSumm.Value := 0;
  end;
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
        ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((edSkidka.Value * 100 / edPrice.Value), -2);
        ParamByName('DISCOUNT_TENGE_').AsFloat :=edSkidka.Value;
      end;
    end else begin
      ParamByName('DISCOUNT_PERC_').AsFloat := 0;
      ParamByName('DISCOUNT_TENGE_').AsFloat := 0;
    end;
    ParamByName('DISCOUNT_SUMM_').AsFloat := edSkidkaSumm.Value;
    ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
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

  if (NotifyNol = 1) and (FNotShowAmountWarning = False) then      // если панель товаров отражается, то предупреждение выходит там
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
  end;

  GetData;

  MyCurrencyFrameForm.edAmount.SetFocus;

  if OpenMode = omUpdate then
    pnShowDlg.Visible := False;

  if HaveRightToSeeOpt then begin
    if FVolumePrice then
      cbPrice.ItemIndex := 1;
  end else begin
    cbPrice.ItemIndex := 0;
    cbPrice.Enabled := False;
  end;
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

procedure TSaleDlgForm.aBreakTovarExecute(Sender: TObject);
var s : string; f : currency;
begin
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

      f := roundto(F/FPackAmount, -2);
      MyCurrencyFrameForm.edAmount.Text := FloatToStr(F);
    end

  END else
    ShowMessage('У товара не указано значение "Количество в упаковке"!');
end;

procedure TSaleDlgForm.GetData;
begin
  if OpenMode = omInsert then begin
    spGetData.ParamByName('g_product_').AsInteger := FProduct;
    spGetData.ParamByName('g_tochka_').AsInteger := CurSklad;
  end else begin
    spGetData.SQL.Text := 'EXECUTE PROCEDURE GET_ZAKAZ_DETAILS_TMP (?ZAKAZ_DETAILS_)';
    spGetData.ParamByName('ZAKAZ_DETAILS_').AsInteger := RecID;
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
      if (ParamByName('amount_').AsFloat = 0) and (AllowSellAbsGoods = 0) {and (FNotShowAmountWarning = False)} then begin
        MessageDlg('Остаток товара на складе 0 и после операции он станет отрицательным. Продолжение невозможно!', mtWarning, [mbYes], 0);
        btnOk.Enabled := False;
        Exit;
      end;

      if (UseScales = 1) and (FAmount > 0) then
        MyCurrencyFrameForm.edAmount.Text := FloatToStr(FAmount);
    end else begin
      lbName.Caption := ParamByName('TOVAR_NAME_').AsString;
      edPrice.Value := FPrice;
      if FPrice = FOptPrice then
        cbPrice.ItemIndex := 1;
      MyCurrencyFrameForm.edAmount.Text := ParamByName('AMOUNT_').AsString;
      if ParamByName('DISCOUNT_PERC_').AsFloat > 0 then begin
        cbSkidka.ItemIndex := 0;
        edSkidka.Value := ParamByName('DISCOUNT_PERC_').AsFloat;
      end else if ParamByName('DISCOUNT_TENGE_').AsFloat > 0 then begin
        cbSkidka.ItemIndex := 1;
        edSkidka.Value := ParamByName('DISCOUNT_TENGE_').AsFloat;
      end;
      edSumm.Value := ParamByName('SUMM_').AsFloat;
      edSkidkaSumm.Value := ParamByName('DISCOUNT_SUMM_').AsFloat;
      NDSValue := ParamByName('NDS_').AsFloat;
      NdsSumm  := ParamByName('NDS_SUMM_').AsFloat;
    end;
  end;
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
