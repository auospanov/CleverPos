unit frmZakupkaTovara_old;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, dxEditor, dxExEdtr, dxDBEdtr,
  dxDBELib, dxCntner, dxEdLib, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, dxDBGrid, cxSplitter, dxTL,
  dxDBCtrl, dxDBTL, frmDlg, frmDBEdit, mmSystem, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  AppEvnts, frmMyCurrencyFrame, Inifiles, DateUtils, frmPrihodTovaraN,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack,
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
  System.Actions, cxEditRepositoryItems, cxClasses, cxButtons;

type
  TZakupkaTovaraForm1 = class(TDBEditForm)
    Panel2: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label4: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    GroupBox1: TGroupBox;
    Shape10: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape15: TShape;
    Label6: TLabel;
    Shape11: TShape;
    Panel3: TPanel;
    Panel4: TPanel;
    Label10: TLabel;
    edBarcode: TEdit;
    tlCategory: TdxDBTreeList;
    tlCategoryG_PRODUCT: TdxDBTreeListMaskColumn;
    tlCategoryG_PRODUCT_PAR: TdxDBTreeListMaskColumn;
    tlCategoryNAME: TdxDBTreeListMaskColumn;
    splMenu: TcxSplitter;
    grProduct: TdxDBGrid;
    dxDBGridMaskColumn1: TdxDBGridMaskColumn;
    dxDBGridMaskColumn2: TdxDBGridMaskColumn;
    dxDBGridMaskColumn3: TdxDBGridMaskColumn;
    dxDBGridMaskColumn5: TdxDBGridMaskColumn;
    dxDBGridMaskColumn6: TdxDBGridMaskColumn;
    dsRead: TDataSource;
    dsReadCategory: TDataSource;
    aChooseTovar: TAction;
    aRefreshChd: TAction;
    Label2: TLabel;
    Label7: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Shape12: TShape;
    Shape13: TShape;
    spReadCategory: TpFIBDataSet;
    spRead: TpFIBDataSet;
    spFindProduct: TpFIBStoredProc;
    edPrice: TdxCurrencyEdit;
    edSumm: TdxCurrencyEdit;
    edNDSSumm: TdxCurrencyEdit;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    aIns: TAction;
    btIns: TBitBtn;
    aUpd: TAction;
    btUpd: TBitBtn;
    cbClose: TCheckBox;
    aeScanner: TApplicationEvents;
    sbClear: TSpeedButton;
    TimerChangeEd: TTimer;
    Label8: TLabel;
    Shape14: TShape;
    Shape16: TShape;
    sePriceOpt: TdxCurrencyEdit;
    Label9: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    edNakrutkaR: TdxCurrencyEdit;
    Label11: TLabel;
    Shape19: TShape;
    Shape20: TShape;
    edNakrutkaO: TdxCurrencyEdit;
    seAmount: TdxCurrencyEdit;
    sePrice: TdxCurrencyEdit;
    GetLastPrice: TpFIBStoredProc;
    gbChangePrice: TGroupBox;
    cbUpdatePrice: TCheckBox;
    edNacenka: TdxCurrencyEdit;
    edNewPrice: TdxCurrencyEdit;
    cbUpdateOptPrice: TCheckBox;
    edOptNacenka: TdxCurrencyEdit;
    edNewOptPrice: TdxCurrencyEdit;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    aCustomizeColumns: TAction;
    grProductNOTE: TdxDBGridColumn;
    edNDS: TdxCurrencyEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure aRefreshChdExecute(Sender: TObject);
    procedure tlCategoryChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure edNDSChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grProductChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure grProductDblClick(Sender: TObject);
    procedure edPriceChange(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure MyCurrencyFrameForm1edAmountChange(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aeScannerMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure aChooseTovarExecute(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure cbUpdatePriceClick(Sender: TObject);
    procedure edNacenkaChange(Sender: TObject);
    procedure cbUpdateOptPriceClick(Sender: TObject);
    procedure edOptNacenkaChange(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
  private
    FArrPrice : TArrPrice;
    FG_product: Integer;
    FPName: String;
    FIs_vozvrat : Integer; // 0 - обычный приход, 1 - возврат товара
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    procedure RefreshRek;
  public
    property ArrPrice: TArrPrice read FArrPrice write FArrPrice;
    property G_product: Integer read FG_product write FG_product;
    property PName: String read FPName write FPName;
    property Is_vozvrat: Integer read FIs_vozvrat write FIs_vozvrat default 0;
  protected
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ZakupkaTovaraForm1: TZakupkaTovaraForm1;

implementation

uses unCommonFunc, frmPriceListUn;

{$R *.dfm}

procedure TZakupkaTovaraForm1.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
  i : integer;
  LRect : TRect;
begin
  // галочка "Закрывать окно"
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    cbClose.Checked := Ini.ReadInteger('ZakupkaTovara', 'cbClose', 0) = 1;
    tlCategory.Width := Ini.ReadInteger('ZakupkaTovara', 'tlCategoryWidth', 250);
    cbUpdatePrice.Checked := Ini.ReadInteger('ZakupkaTovara', 'cbUpdatePrice', 0) = 1;
    cbUpdateOptPrice.Checked := Ini.ReadInteger('ZakupkaTovara', 'cbUpdateOptPrice', 0) = 1;
    Height := Ini.ReadInteger('ZakupkaTovara', 'Height', Constraints.MinHeight);
    Width := Ini.ReadInteger('ZakupkaTovara', 'Width', Constraints.MinWidth);
  finally
    Ini.Free;
  end;

  OpenSp(spReadCategory, False);
  MyCurrencyFrameForm.edAmount.Text := '1';  // по умолчанию поставлю 1
  aRefreshChd.Execute;

  if FIs_vozvrat = 1 then begin
    HELPC := 20;
    edNDS.Enabled     := False;
    btIns.Visible := False;
    btUpd.Visible := False;
    gbChangePrice.Visible := False;
    cbUpdatePrice.Checked := False;
    cbUpdateOptPrice.Checked := False;
  end else
    HELPC := 17;
end;

function TZakupkaTovaraForm1.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if MyCurrencyFrameForm.Value = 0 then begin
    MyCurrencyFrameForm.edAmount.SetFocus;
    MessageDlg('Количество не указано', mtInformation, [mbOK], 0);
    Exit;
  end;

  {ХЗ зачем изначально ограничение поставил
  if edPrice.Value = 0 then begin
    ErrControl := edPrice;
    MessageDlg('Цена не указана', mtInformation, [mbOK], 0);
    Exit;
  end;}

  Result := True;
end;

procedure TZakupkaTovaraForm1.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('G_PRODUCT_').AsInteger := spRead.FieldByName('G_PRODUCT').AsInteger;
    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('AMOUNT_').AsFloat := MyCurrencyFrameForm.Value;
    ParamByName('SUMM_').AsFloat := edSumm.Value;
    ParamByName('NDS_').AsFloat := edNDS.Value;
    ParamByName('NDS_SUMM_').AsFloat := edNDSSumm.Value;
  end;
end;

procedure TZakupkaTovaraForm1.FormCreate(Sender: TObject);
begin
  inherited;
  Constraints.MinHeight := ScaleDimension(650);
  Constraints.MinWidth := ScaleDimension(780);
  KeyField := 'sklad_';
end;

procedure TZakupkaTovaraForm1.btClearClick(Sender: TObject);
begin
  edBarcode.Text := '';
end;

procedure TZakupkaTovaraForm1.aRefreshChdExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  spRead.ParamByName('g_product_par_').AsInteger := spReadCategory.FieldByName('g_product').AsInteger;
  spRead.ParamByName('g_tochka_').AsInteger := CurSklad;
  OpenSp(spRead, False);
  if Assigned(grProduct.FocusedNode) then
    grProduct.FocusedNode.Selected := True;
  RefreshRek;
  Screen.Cursor := crDefault;    
end;

procedure TZakupkaTovaraForm1.grProductChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  RefreshRek;
end;

procedure TZakupkaTovaraForm1.RefreshRek;
begin
  seAmount.Value := spRead.FieldByName('AMOUNT').AsFloat;
  sePrice.Value := spRead.FieldByName('PRICE').AsFloat;
  MyCurrencyFrameForm.edAmount.Text := '1';
  sePriceOpt.Value := spRead.FieldByName('VOLUME_PRICE').AsFloat;
  edNakrutkaR.Value := 0;
  edNakrutkaO.Value := 0;
  if FIs_vozvrat = 1 then
    edPrice.Value := spRead.FieldByName('PRICE').AsFloat
  else begin
    GetLastPrice.ParamByName('G_PRODUCT_').AsIntEGER := spRead.FieldByName('G_PRODUCT').AsInteger;
    GetLastPrice.ParamByName('G_TOCHKA_').AsIntEGER := CurSklad;
    ExecSPTR(GetLastPrice);

    edPrice.Value := GetLastPrice.ParamByName('price_').AsFloat;
  end;

  edNacenka.Value := edNakrutkaR.Value;
  edOptNacenka.Value := edNakrutkaO.Value;
  edNewPrice.Value := sePrice.Value;         // по идее в событии edNacenka.OnChange есть изменение цены edNewPrice, но из-за гребаных процентов, вычисляется не совсем то, например ==>
  edNewOptPrice.Value := sePriceOpt.Value;   //==> вместо 1140, может посчитаться 1139.78, поэтому решил тут тупо присваивать, а там пусть меняется уже чисто при изменении процентов
end;

procedure TZakupkaTovaraForm1.tlCategoryChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  aRefreshChd.Execute;
end;

procedure TZakupkaTovaraForm1.edNDSChange(Sender: TObject);
begin
  edNDSSumm.Value := edSumm.Value * edNDS.Value / 100;
end;

procedure TZakupkaTovaraForm1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (grProduct.SelectedCount = 0) and (ModalResult = mrOk) then begin
    MessageDlg('Вы не выбрали ни одного товара! Выберите товар!', mtWarning, [mbOk], 0);
    edBarcode.Clear;
    spRead.Filter := '';
    spRead.Filtered := False;
    CanClose := False;
    Exit;
  end;

  inherited;
  if Self.ModalResult = mrOk then begin
    IF Success then begin
      //***************************************************************************
      //ЕСЛИ СТОИТ ГАЛОЧКА "ИЗМЕНИТЬ ЦЕНУ" ТО ВСТАВЛЯЮ ДАННЫЙ ТОВАР В МАССИВ
      //И НОВАЯ ЦЕНА ДОЛЖНА РЕАЛЬНО ОТЛИЧАТЬСЯ ОТ СТАРОЙ, ВДРУГ ПРИХОД ПО СТАРОЙ ЦЕНЕ ПРИШЕЛ, ЦЕНА НЕ ИЗМЕНИЛАСЬ, А ГАЛОЧКУ УБРАТЬ ЗАБЫЛИ, АПДЕЙТ ВХОЛОСТУЮ СРАБОТАЕТ ПОЛУЧАЕТСЯ
      if ((cbUpdatePrice.Checked) and (edNewPrice.Value <> sePrice.Value)) or ((cbUpdateOptPrice.Checked) and (edNewOptPrice.Value <> sePriceOpt.Value)) then begin
        SetLength(FArrPrice, High(FArrPrice) + 2);
        FArrPrice[High(FArrPrice)].Id := spIns.ParamByName('sklad_').asInteger;
        FArrPrice[High(FArrPrice)].ProductId := spRead.FieldByName('G_PRODUCT').AsInteger;
        if (cbUpdatePrice.Checked) and (edNewPrice.Value <> sePrice.Value) then
          FArrPrice[High(FArrPrice)].Price := edNewPrice.Value;

        if (cbUpdateOptPrice.Checked) and (edNewOptPrice.Value <> sePriceOpt.Value) then
          FArrPrice[High(FArrPrice)].PriceOpt := edNewOptPrice.Value;
      end;
      //***************************************************************************

      PrihodTovaraNForm.Readlist;
      PrihodTovaraNForm.edOsnovanie.Modified := True;  // иначе не захватиться изменение, т.к. фактически там ничего не менялось
      if cbClose.Checked then
        CanClose := True
      else begin
        CanClose := False;
        ShowMessage('Товар добавлен!');
      end;
    end;
  end;
end;

procedure TZakupkaTovaraForm1.grProductDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TZakupkaTovaraForm1.edPriceChange(Sender: TObject);
var F : double;
begin
  inherited;
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
  if (FIs_Vozvrat = 0) and (edPrice.Value > 0) then begin
    F := sePrice.Value * 100 / edPrice.Value * 100;     //таким образом я тупо отбрасываю все что после 2-х знаков после запятой, например 6.785 -> 6.78
    F := trunc(F);  // можно было сразу написать Trunc(F*100)/100;, но так почему-то глючило
    F := F/100;
    edNakrutkaR.Value := F - 100;

    if sePriceOpt.Value > 0 then begin
      F := sePriceOpt.Value * 100 / edPrice.Value * 100;     //таким образом я тупо отбрасываю все что после 2-х знаков после запятой, например 6.785 -> 6.78
      F := trunc(F);          // можно было сразу написать Trunc(F*100)/100;, но так почему-то глючило
      F := F/100;
      edNakrutkaO.Value := F - 100;
    end else
      edNakrutkaO.Value := 0;
  end;

  edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;
  edNewOptPrice.Value := edPrice.Value + edPrice.Value*edOptNacenka.Value/100;
end;

procedure TZakupkaTovaraForm1.edBarcodeChange(Sender: TObject);
begin
  TimerChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    TimerChangeEd.Enabled := True
  else BEGIN
    with spRead do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TZakupkaTovaraForm1.TimerChangeEdTimer(Sender: TObject);
var s : string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spRead do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''')';
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if Assigned(grProduct.FocusedNode) then
      grProduct.FocusedNode.Selected := True;

    RefreshRek;
  END;
end;

procedure TZakupkaTovaraForm1.MyCurrencyFrameForm1edAmountChange(
  Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
end;

procedure TZakupkaTovaraForm1.aInsExecute(Sender: TObject);
var PriceListUnForm: TPriceListUnForm;
begin
  PriceListUnForm := TPriceListUnForm.Create(Self);
  with PriceListUnForm do begin
    try
      Id_Category := spReadCategory.FieldByName('g_product').AsInteger;
      OpenMode := omInsert;
      sbInsCategory.Visible := True;
      leCategory.Width := 337;
      if Showmodal = mrOk then begin
        // если создали новую категорию, то надо сделать Refresh
        if not (spReadCategory.Locate('g_product', leCategory.LookupKeyValue, [])) then begin
          OpenSp(spReadCategory, False);
          spReadCategory.Locate('g_product', leCategory.LookupKeyValue, [])
        end;
        aRefreshChd.Execute;
        spRead.Locate('g_product', RecId, []);
        if grProduct.FocusedNode <> Nil then begin
          if grProduct.SelectedCount > 0 then
            grProduct.SelectedNodes[0].Selected := False;
          grProduct.FocusedNode.Selected := True;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TZakupkaTovaraForm1.aUpdExecute(Sender: TObject);
var PriceListUnForm: TPriceListUnForm;
begin
  PriceListUnForm := TPriceListUnForm.Create(Self);
  with PriceListUnForm do begin
    try
      RecId := spRead.FieldByName('g_product').AsInteger;
      OpenMode := omUpdate;
      if Showmodal = mrOk then
        aRefreshChd.Execute;
    finally
      Free;
    end;
  end;
end;

procedure TZakupkaTovaraForm1.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
  c : Integer;
begin
  inherited;

  // галочка "Закрывать окно"
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    Ini.WriteInteger('ZakupkaTovara', 'cbClose', Integer(cbClose.Checked));
    Ini.WriteInteger('ZakupkaTovara', 'tlCategoryWidth', tlCategory.Width);
    Ini.WriteInteger('ZakupkaTovara', 'cbUpdatePrice', Integer(cbUpdatePrice.Checked));
    Ini.WriteInteger('ZakupkaTovara', 'cbUpdateOptPrice', Integer(cbUpdateOptPrice.Checked));

    Ini.WriteInteger('ZakupkaTovara', 'Height', Height);
    Ini.WriteInteger('ZakupkaTovara', 'Width', Width);
  finally
    Ini.Free;
  end;
end;

procedure TZakupkaTovaraForm1.aeScannerMessage(var Msg: tagMSG;
  var Handled: Boolean);
procedure ClearBuffer;
  begin
    if MilliSecondsBetween(Now, LastDateForAddedKey) > 200 then
    begin
      // при медленном вводе буфер очищяется, т.к. скан идет "мгновенно"
      KeysBuffer := '';
    end;
  end;
begin
  // обработка штрих-кодов
  // автор: jaydi85@gmail.com

  // данные считываем на WM_CHAR
  // НО КЛАВИШУ ЭНТЕР на WM_KEYDOWN
  // заканчиваем ввод
  IF Screen.ActiveForm <> Nil THEN BEGIN
    IF Screen.ActiveForm.Name = Self.Name THEN BEGIN
      if Msg.message = WM_KEYDOWN then
      begin
        if (Msg.wParam = 13) or (Msg.wParam = 10) then
        begin
          ClearBuffer;
          if KeysBuffer <> '' then begin
            // при сканировании нажатие энтера передавать никуда не надо
            Handled := True;
            TimerChangeEd.Enabled := False;
            aChooseTovar.Execute;
            KeysBuffer := '';
          end;
        end
      end;

      // сохраняем ввод
      if Msg.message = WM_CHAR then
      begin
        ClearBuffer;
        if Msg.wParam <> 13 then
        begin
          // нажали что-то другое (надо отбросить всякие шифты и контролы)
          KeysBuffer := KeysBuffer + Chr(Msg.wParam);
          LastDateForAddedKey := Now;
        end;
      end;
    END;
  END;
end;

procedure TZakupkaTovaraForm1.aChooseTovarExecute(Sender: TObject);
var onChange : TNotifyEvent;
    onChangeCat, onChangeTov : TTLChangeNodeEvent;
begin
  onChange := edBarcode.OnChange;
  edBarcode.OnChange := nil;
  edBarcode.Clear;
  spRead.CancelConditions;   //очищаю фильтрацию если было
  spRead.Conditions.Clear;
  edBarcode.OnChange := onChange;
  onChangeCat := tlCategory.OnChangeNode;
  onChangeTov := grProduct.OnChangeNode;

  spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;

  try
    IF ExecSPTR(spFindProduct) THEN BEGIN
      Screen.Cursor := crHourGlass;
      tlCategory.OnChangeNode := nil;
      grProduct.OnChangeNode  := nil;
      spReadCategory.Locate('g_product', spFindProduct.ParamByName('g_product_category_').AsInteger, []);
      spRead.ParamByName('g_product_par_').AsInteger := spReadCategory.FieldByName('g_product').AsInteger;
      spRead.ParamByName('g_tochka_').AsInteger := CurSklad;
      OpenSp(spRead, False);
      spRead.Locate('g_product', spFindProduct.ParamByName('G_PRODUCT_').AsInteger, []);
      edPrice.SetFocus;
      if grProduct.FocusedNode <> Nil then begin
        if grProduct.SelectedCount > 0 then
          grProduct.SelectedNodes[0].Selected := False;
        grProduct.FocusedNode.Selected := True;
      end;
      RefreshRek;
      grProduct.OnChangeNode := onChangeTov;
      tlCategory.OnChangeNode := onChangeCat;
      Screen.Cursor := crDefault;
    END;
  except
    on E: Exception do begin
      tlCategory.OnChangeNode := onChangeCat;
      grProduct.OnChangeNode := onChangeTov;
      MessageDlg(E.Message + #13#10'(occured in TZakupkaTovaraForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
    end;
  end;

  spFindProduct.ParamByName('BARCODE_').AsString := '';
end;

procedure TZakupkaTovaraForm1.sbClearClick(Sender: TObject);
begin
  edBarcode.Text := '';
  if Assigned(grProduct.FocusedNode) then
    grProduct.FocusedNode.Selected := True;
  RefreshRek;
end;

procedure TZakupkaTovaraForm1.cbUpdatePriceClick(Sender: TObject);
begin
  if cbUpdatePrice.Checked then begin
    edNacenka.Enabled := True;
    edNewPrice.Enabled := True;
  end else begin
    edNacenka.Enabled := False;
    edNewPrice.Enabled := False;
  end;
end;

procedure TZakupkaTovaraForm1.edNacenkaChange(Sender: TObject);
begin
  edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;
end;

procedure TZakupkaTovaraForm1.cbUpdateOptPriceClick(Sender: TObject);
begin
  if cbUpdateOptPrice.Checked then begin
    edOptNacenka.Enabled := True;
    edNewOptPrice.Enabled := True;
  end else begin
    edOptNacenka.Enabled := False;
    edNewOptPrice.Enabled := False;
  end;
end;

procedure TZakupkaTovaraForm1.edOptNacenkaChange(Sender: TObject);
begin
  edNewOptPrice.Value := edPrice.Value + edPrice.Value*edOptNacenka.Value/100;
end;

procedure TZakupkaTovaraForm1.aCustomizeColumnsExecute(Sender: TObject);
begin
  grProduct.ColumnsCustomizing;
end;

end.
