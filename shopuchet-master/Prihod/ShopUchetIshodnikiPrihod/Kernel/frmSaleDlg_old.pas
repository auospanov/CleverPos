unit frmSaleDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, dxExEdtr, dxDBEdtr, dxDBELib, frmMyCurrencyFrame,
  StdCtrls, dxCntner, dxEditor, dxEdLib, ExtCtrls, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, ActnList, AppEvnts, Buttons,
  cxLookAndFeelPainters, cxButtons, unCommonFunc, Math, FIB, Registry,
  frmDBDlg;

type
  TSaleDlgForm = class(TDBDlgForm)
    lb4: TLabel;
    edPrice: TdxCurrencyEdit;
    lb1: TLabel;
    lb3: TLabel;
    edSkidka: TdxCurrencyEdit;
    lb2: TLabel;
    lb6: TLabel;
    edSumm: TdxCurrencyEdit;
    edSkidkaSumm: TdxCurrencyEdit;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    pnName: TPanel;
    aBreakTovar: TAction;
    lbName: TLabel;
    pn1: TPanel;
    lb5: TLabel;
    cbPrice: TComboBox;
    lb7: TLabel;
    cbSkidka: TComboBox;
    btnBreakTovar: TButton;
    pn2: TPanel;
    cbShowForm: TCheckBox;
    tranRead: TpFIBTransaction;
    spGetData: TpFIBStoredProc;
    procedure FormShow(Sender: TObject);
    procedure edSkidkaChange(Sender: TObject);
    procedure edPriceChange(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
    procedure aBreakTovarExecute(Sender: TObject);
    procedure cbPriceChange(Sender: TObject);
    procedure cbSkidkaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FProduct : Integer;
    FProductName : String;
    FSkidka      : Double;       // скидка клиента при покупке
    FPrice       : Double;
    FOptPrice    : Double;
    FPackAmount  : Double;
    FNotShowAmountWarning : Boolean;  //показывать сообщение об отсутствии остатков товаров или нет. Если панель товаров на frmSaleMode отражается, то смс там выходит, тут не нужно
    procedure ItogRecalc;
  public
    property Product : Integer read FProduct write FProduct;
    property Price : Double read FPrice write FPrice;
    property OptPrice : Double read FOptPrice write FOptPrice;
    property PackAmount : Double read FPackAmount write FPackAmount;
    property ProductName : String read FProductName write FProductName;
    property Skidka : Double read FSkidka write FSkidka;
    property NotShowAmountWarning : Boolean read FNotShowAmountWarning write FNotShowAmountWarning;
  protected
    procedure GetData; override;
  end;

var
  SaleDlgForm: TSaleDlgForm;

implementation

uses
  unErrorHandlers, unInitApp;

{$R *.dfm}

procedure TSaleDlgForm.ItogRecalc;
begin
  if (edPrice.Value > 0) then begin
    if cbSkidka.ItemIndex = 0 then begin
      edSumm.Value := MyCurrencyFrameForm.Value * (edPrice.Value * (1 - edSkidka.Value/100));
      edSkidkaSumm.Value := (MyCurrencyFrameForm.Value * edPrice.Value) - (MyCurrencyFrameForm.Value * edPrice.Value * (1 - edSkidka.Value/100))
    end else begin
      edSumm.Value := MyCurrencyFrameForm.Value * (edPrice.Value - edSkidka.Value);
      edSkidkaSumm.Value := (MyCurrencyFrameForm.Value * edPrice.Value) - (MyCurrencyFrameForm.Value * (edPrice.Value - edSkidka.Value))
    end;
  end else begin
    edSumm.Value := 0;
    edSkidkaSumm.Value := 0;
  end;
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
end;

procedure TSaleDlgForm.edSkidkaChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TSaleDlgForm.edPriceChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TSaleDlgForm.MyCurrencyFrameFormedAmountChange(Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  ItogRecalc;
end;

procedure TSaleDlgForm.aBreakTovarExecute(Sender: TObject);
var s : string; F : double;
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
  spGetData.ParamByName('g_product_').AsInteger := FProduct;
  spGetData.ParamByName('g_tochka_').AsInteger := CurSklad;
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
    lbName.Caption := ParamByName('name_').AsString;
    FPrice := ParamByName('price_').AsFloat;
    FOptPrice := ParamByName('VOLUME_PRICE_').AsFloat;
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
    if (ParamByName('amount_').AsFloat <= 0) and (AllowSellAbsGoods = 0) and (FNotShowAmountWarning = False) then begin
      MessageDlg('Остаток товара на складе 0 и после операции он станет отрицательным. Продолжение невозможно!', mtWarning, [mbYes], 0);
      btnOk.Enabled := False;
      Exit;
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

procedure TSaleDlgForm.cbSkidkaChange(Sender: TObject);
begin
  if cbSkidka.ItemIndex = 0 then
    edSkidka.DisplayFormat := '0.00%'
  else
    edSkidka.DisplayFormat := ',0.00;-,0.00';
  ItogRecalc;
end;

procedure TSaleDlgForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Reg: TRegistry;
begin
  inherited;
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

procedure TSaleDlgForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ErrControl: TWinControl;
begin
  inherited;

  if ModalResult = mrOk then begin
    CanClose := false;

    if MyCurrencyFrameForm.Value = 0 then begin
      MyCurrencyFrameForm.edAmount.SetFocus;
      MessageDlg('Количество не указано', mtWarning, [mbOK], 0);
      Exit;
    end;

    if NotifyNol = 1 then
      if edPrice.Value = 0 then begin
        if MessageDlg('Цена товара указана 0, вы уверены, что хотите продолжить?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
          edPrice.SetFocus;
          Exit;
        end;
      end;

    CanClose := true;
  end;  
end;

end.
