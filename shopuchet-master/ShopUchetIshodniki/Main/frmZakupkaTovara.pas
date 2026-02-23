unit frmZakupkaTovara;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxSplitter, frmDlg, frmDBEdit, mmSystem, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  AppEvnts, frmMyCurrencyFrame, Inifiles, DateUtils, frmPrihodTovaraN,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxCustomData,
  cxStyles, cxTL, cxTLdxBarBuiltInMenu, dxSkinscxPCPainter, cxFilter, cxData,
  cxDataStorage, cxDBData, cxCheckBox, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxInplaceContainer, cxDBTL, cxTLData;

type
  TZakupkaTovaraForm = class(TDBEditForm)
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
    Panel3: TPanel;
    Panel4: TPanel;
    Label10: TLabel;
    splMenu: TcxSplitter;
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
    aIns: TAction;
    btIns: TBitBtn;
    aUpd: TAction;
    btUpd: TBitBtn;
    aeScanner: TApplicationEvents;
    sbClear: TSpeedButton;
    TimerChangeEd: TTimer;
    Label8: TLabel;
    Shape14: TShape;
    Shape16: TShape;
    Label9: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Label11: TLabel;
    Shape19: TShape;
    Shape20: TShape;
    GetLastPrice: TpFIBStoredProc;
    gbChangePrice: TGroupBox;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    aCustomizeColumns: TAction;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    tlCategory: TcxDBTreeList;
    clmnCategoryNAME: TcxDBTreeListColumn;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    clmtv1VOLUME_PRICE: TcxGridDBColumn;
    clmtv1NOTE: TcxGridDBColumn;
    clmtv1PLACE: TcxGridDBColumn;
    lv1: TcxGridLevel;
    edPrice: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    seAmount: TcxCurrencyEdit;
    edPriceRozn: TcxCurrencyEdit;
    sePriceOpt: TcxCurrencyEdit;
    edNakrutkaR: TcxCurrencyEdit;
    edNakrutkaO: TcxCurrencyEdit;
    edNacenka: TcxCurrencyEdit;
    edNewPrice: TcxCurrencyEdit;
    edNewOptPrice: TcxCurrencyEdit;
    edOptNacenka: TcxCurrencyEdit;
    edBarcode: TcxTextEdit;
    cbUpdatePrice: TcxCheckBox;
    cbUpdateOptPrice: TcxCheckBox;
    cbClose: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure aRefreshChdExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grProductDblClick(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aeScannerMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure aChooseTovarExecute(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure cbUpdatePriceClick(Sender: TObject);
    procedure cbUpdateOptPriceClick(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
    procedure tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure tvProductFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure edNacenkaPropertiesChange(Sender: TObject);
    procedure edOptNacenkaPropertiesChange(Sender: TObject);
    procedure edPricePropertiesChange(Sender: TObject);
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
  ZakupkaTovaraForm: TZakupkaTovaraForm;

implementation

uses unCommonFunc, frmPriceListUn;

{$R *.dfm}

procedure TZakupkaTovaraForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
  i : integer;
  LRect : TRect;
  onChangeCat : TcxTreeListFocusedNodeChangedEvent;
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

  onChangeCat := tlCategory.OnFocusedNodeChanged;
  tlCategory.OnFocusedNodeChanged := nil;

  OpenSp(spReadCategory, False);
  MyCurrencyFrameForm.edAmount.Text := '1';  // по умолчанию поставлю 1
  aRefreshChd.Execute;

  tlCategory.OnFocusedNodeChanged := onChangeCat;

  if FIs_vozvrat = 1 then begin
    HELPC := 20;
    btIns.Visible := False;
    btUpd.Visible := False;
    gbChangePrice.Visible := False;
    cbUpdatePrice.Checked := False;
    cbUpdateOptPrice.Checked := False;
  end else
    HELPC := 17;
end;

function TZakupkaTovaraForm.CheckParams(var ErrControl: TWinControl): Boolean;
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

procedure TZakupkaTovaraForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('G_PRODUCT_').AsInteger := spRead.FieldByName('G_PRODUCT').AsInteger;
    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('AMOUNT_').AsFloat := MyCurrencyFrameForm.Value;
    ParamByName('SUMM_').AsFloat := edSumm.Value;
  end;
end;

procedure TZakupkaTovaraForm.FormCreate(Sender: TObject);
begin
  inherited;
  Constraints.MinHeight := ScaleDimension(650);
  Constraints.MinWidth := ScaleDimension(780);
  KeyField := 'sklad_';
end;

procedure TZakupkaTovaraForm.btClearClick(Sender: TObject);
begin
  edBarcode.Text := '';
end;

procedure TZakupkaTovaraForm.aRefreshChdExecute(Sender: TObject);
var
  onChangeCat : TcxGridFocusedRecordChangedEvent;
begin
  Screen.Cursor := crHourGlass;
  onChangeCat := tvProduct.OnFocusedRecordChanged;
  tvProduct.OnFocusedRecordChanged := nil;

  spRead.ParamByName('g_product_par_').AsInteger := spReadCategory.FieldByName('g_product').AsInteger;
  spRead.ParamByName('g_tochka_').AsInteger := CurSklad;
  OpenSp(spRead, False);
  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;
  RefreshRek;

  tvProduct.OnFocusedRecordChanged := onChangeCat;
  Screen.Cursor := crDefault;    
end;

procedure TZakupkaTovaraForm.RefreshRek;
begin
  seAmount.Value := spRead.FieldByName('AMOUNT').AsFloat;
  edPriceRozn.Value := spRead.FieldByName('PRICE').AsFloat;
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
  edNewPrice.Value := edPriceRozn.Value;         // по идее в событии edNacenka.OnChange есть изменение цены edNewPrice, но из-за гребаных процентов, вычисляется не совсем то, например ==>
  edNewOptPrice.Value := sePriceOpt.Value;   //==> вместо 1140, может посчитаться 1139.78, поэтому решил тут тупо присваивать, а там пусть меняется уже чисто при изменении процентов
end;

procedure TZakupkaTovaraForm.tvProductFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  RefreshRek;
end;

procedure TZakupkaTovaraForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (tvProduct.Controller.SelectedRowCount = 0) and (ModalResult = mrOk) then begin
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
      if ((cbUpdatePrice.Checked) and (edNewPrice.Value <> edPriceRozn.Value)) or ((cbUpdateOptPrice.Checked) and (edNewOptPrice.Value <> sePriceOpt.Value)) then begin
        SetLength(FArrPrice, High(FArrPrice) + 2);
        FArrPrice[High(FArrPrice)].Id := spIns.ParamByName('sklad_').asInteger;
        FArrPrice[High(FArrPrice)].ProductId := spRead.FieldByName('G_PRODUCT').AsInteger;
        if (cbUpdatePrice.Checked) and (edNewPrice.Value <> edPriceRozn.Value) then
          FArrPrice[High(FArrPrice)].Price := edNewPrice.Value;

        if (cbUpdateOptPrice.Checked) and (edNewOptPrice.Value <> sePriceOpt.Value) then
          FArrPrice[High(FArrPrice)].PriceOpt := edNewOptPrice.Value;
      end;
      //***************************************************************************

      PrihodTovaraNForm.Readlist;
      PrihodTovaraNForm.edOsnovanie.ModifiedAfterEnter := True;  // иначе не захватиться изменение, т.к. фактически там ничего не менялось
      if cbClose.Checked then
        CanClose := True
      else begin
        CanClose := False;
        ShowMessage('Товар добавлен!');
      end;
    end;
  end;
end;

procedure TZakupkaTovaraForm.grProductDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TZakupkaTovaraForm.tlCategoryFocusedNodeChanged(
  Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  aRefreshChd.Execute;
end;

procedure TZakupkaTovaraForm.edPricePropertiesChange(Sender: TObject);
var F : double;
begin
  edPrice.Text := StringReplace(edPrice.Text, ',', '.', [rfReplaceAll]);

  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
  if (FIs_Vozvrat = 0) and (edPrice.Value > 0) then begin
    F := edPriceRozn.Value * 100 / edPrice.Value * 100;     //таким образом я тупо отбрасываю все что после 2-х знаков после запятой, например 6.785 -> 6.78
    F := trunc(F);  // можно было сразу написать Trunc(F*100)/100;, но так почему-то глючило
    F := F/100;
    edNakrutkaR.Value := F; //edNakrutkaR.Value := F - 100;    нахуя??? хз

    if sePriceOpt.Value > 0 then begin
      F := sePriceOpt.Value * 100 / edPrice.Value * 100;     //таким образом я тупо отбрасываю все что после 2-х знаков после запятой, например 6.785 -> 6.78
      F := trunc(F);          // можно было сразу написать Trunc(F*100)/100;, но так почему-то глючило
      F := F/100;
      edNakrutkaO.Value := F; //edNakrutkaO.Value := F - 100;   нахуя??? хз
    end else
      edNakrutkaO.Value := 0;
  end;

  edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;
  edNewOptPrice.Value := edPrice.Value + edPrice.Value*edOptNacenka.Value/100;
end;

procedure TZakupkaTovaraForm.edBarcodeChange(Sender: TObject);
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

procedure TZakupkaTovaraForm.TimerChangeEdTimer(Sender: TObject);
var s : string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spRead do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''')';
      
      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edBarcode.text + ''')';
        
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if Assigned(tvProduct.Controller.FocusedRow) then
      tvProduct.Controller.FocusedRow.Selected := True;

    RefreshRek;
  END;
end;

procedure TZakupkaTovaraForm.aInsExecute(Sender: TObject);
var PriceListUnForm: TPriceListUnForm;
begin
  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.Id_Category := spReadCategory.FieldByName('g_product').AsInteger;
    PriceListUnForm.OpenMode := omInsert;
    if PriceListUnForm.Showmodal = mrOk then begin
      // если создали новую категорию, то надо сделать Refresh
      if not (spReadCategory.Locate('g_product', PriceListUnForm.leCategory.EditValue, [])) then begin
        OpenSp(spReadCategory, False);
        spReadCategory.Locate('g_product', PriceListUnForm.leCategory.EditValue, [])
      end;
      aRefreshChd.Execute;
      spRead.Locate('g_product', PriceListUnForm.RecId, []);
      if tvProduct.Controller.FocusedRow <> Nil then begin
        if tvProduct.Controller.SelectedRowCount > 0 then
          tvProduct.Controller.SelectedRows[0].Selected := False;
        tvProduct.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    PriceListUnForm.Free;
  end;
end;

procedure TZakupkaTovaraForm.aUpdExecute(Sender: TObject);
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

procedure TZakupkaTovaraForm.FormClose(Sender: TObject;
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

  tvProduct.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvProduct.name);
end;

procedure TZakupkaTovaraForm.aeScannerMessage(var Msg: tagMSG;
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

procedure TZakupkaTovaraForm.aChooseTovarExecute(Sender: TObject);
var onChange : TNotifyEvent;
    onChangeCat : TcxTreeListFocusedNodeChangedEvent;
    onChangeTov : TcxGridFocusedRecordChangedEvent;
begin
  onChange := edBarcode.Properties.OnChange;
  edBarcode.Properties.OnChange := nil;
  edBarcode.Clear;
  spRead.CancelConditions;   //очищаю фильтрацию если было
  spRead.Conditions.Clear;
  edBarcode.Properties.OnChange := onChange;
  onChangeCat := tlCategory.OnFocusedNodeChanged;
  onChangeTov := tvProduct.OnFocusedRecordChanged;

  spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;

  try
    IF ExecSPTR(spFindProduct) THEN BEGIN
      Screen.Cursor := crHourGlass;
      tlCategory.OnFocusedNodeChanged := nil;
      tvProduct.OnFocusedRecordChanged  := nil;
      spReadCategory.Locate('g_product', spFindProduct.ParamByName('g_product_category_').AsInteger, []);
      spRead.ParamByName('g_product_par_').AsInteger := spReadCategory.FieldByName('g_product').AsInteger;
      spRead.ParamByName('g_tochka_').AsInteger := CurSklad;
      OpenSp(spRead, False);
      spRead.Locate('g_product', spFindProduct.ParamByName('G_PRODUCT_').AsInteger, []);
      edPrice.SetFocus;
      if tvProduct.Controller.FocusedRow <> Nil then begin
        if tvProduct.Controller.SelectedRowCount > 0 then
          tvProduct.Controller.SelectedRows[0].Selected := False;
        tvProduct.Controller.FocusedRow.Selected := True;
      end;
      RefreshRek;
      tvProduct.OnFocusedRecordChanged := onChangeTov;
      tlCategory.OnFocusedNodeChanged := onChangeCat;
      Screen.Cursor := crDefault;
    END;
  except
    on E: Exception do begin
      tlCategory.OnFocusedNodeChanged := onChangeCat;
      tvProduct.OnFocusedRecordChanged := onChangeTov;
      MessageDlg(E.Message + #13#10'(occured in TZakupkaTovaraForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
    end;
  end;

  spFindProduct.ParamByName('BARCODE_').AsString := '';
end;

procedure TZakupkaTovaraForm.sbClearClick(Sender: TObject);
begin
  edBarcode.Text := '';
  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;
  RefreshRek;
end;

procedure TZakupkaTovaraForm.cbUpdatePriceClick(Sender: TObject);
begin
  if cbUpdatePrice.Checked then begin
    edNacenka.Enabled := True;
    edNewPrice.Enabled := True;
  end else begin
    edNacenka.Enabled := False;
    edNewPrice.Enabled := False;
  end;
end;

procedure TZakupkaTovaraForm.edNacenkaPropertiesChange(Sender: TObject);
begin
  edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;
end;

procedure TZakupkaTovaraForm.cbUpdateOptPriceClick(Sender: TObject);
begin
  if cbUpdateOptPrice.Checked then begin
    edOptNacenka.Enabled := True;
    edNewOptPrice.Enabled := True;
  end else begin
    edOptNacenka.Enabled := False;
    edNewOptPrice.Enabled := False;
  end;
end;

procedure TZakupkaTovaraForm.edOptNacenkaPropertiesChange(Sender: TObject);
begin
  edNewOptPrice.Value := edPrice.Value + edPrice.Value*edOptNacenka.Value/100;
end;

procedure TZakupkaTovaraForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  tvProduct.Controller.Customization := True;
end;

procedure TZakupkaTovaraForm.MyCurrencyFrameFormedAmountChange(
  Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.EditValue;
end;

end.
