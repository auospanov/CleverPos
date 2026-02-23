unit frmZakupkaTovara;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, dxEditor, dxExEdtr, dxDBEdtr,
  dxDBELib, dxCntner, dxEdLib, ExtCtrls, StdCtrls, Menus, Oracle, ActnList,
  Buttons, VLSummdxEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, dxDBGrid, cxSplitter, dxTL,
  dxDBCtrl, dxDBTL, frmDlg, frmDBEdit, mmSystem, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  AppEvnts, frmMyCurrencyFrame, Inifiles, DateUtils;

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
    GroupBox1: TGroupBox;
    Shape10: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape15: TShape;
    Label6: TLabel;
    Shape11: TShape;
    edNDS: TVLSummdxEdit;
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
    dxDBGridMaskColumn4: TdxDBGridMaskColumn;
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
    Panel5: TPanel;
    cbUpdatePrice: TCheckBox;
    edNacenka: TdxCurrencyEdit;
    edNewPrice: TdxCurrencyEdit;
    cbProcOrVal: TComboBox;
    cbPrice: TComboBox;
    edZakupAmount: TdxCurrencyEdit;
    Label12: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    cbShowMode: TCheckBox;
    cbUpdateOptPrice: TCheckBox;
    edOptNacenka: TdxCurrencyEdit;
    cbProcOrValOpt: TComboBox;
    cbPriceOpt: TComboBox;
    edZakupAmountOpt: TdxCurrencyEdit;
    Label13: TLabel;
    Shape23: TShape;
    Shape24: TShape;
    edNewPriceOpt: TdxCurrencyEdit;
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
    procedure cbShowModeClick(Sender: TObject);
  private
    FG_product: Integer;
    FPName: String;
    FIs_vozvrat : Integer; // 0 - обычный приход, 1 - возврат товара
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    procedure RefreshRek;
  public
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

uses unCommonFunc, frmPrihodTovaraN, frmPriceListUn;

{$R *.dfm}

procedure TZakupkaTovaraForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  Height := 601;
  
  OpenSp(spReadCategory, False);
  MyCurrencyFrameForm.edAmount.Text := '1';  // по умолчанию поставлю 1
  aRefreshChd.Execute;

  if FIs_vozvrat = 1 then begin
    HELPC := 20;
    edNDS.Enabled     := False;
    btIns.Visible := False;
    btUpd.Visible := False;
  end else
    HELPC := 17;

  // галочка "Закрывать окно"
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    cbClose.Checked := Ini.ReadInteger('ZakupkaTovara', 'cbClose', 0) = 1;
    tlCategory.Width := Ini.ReadInteger('ZakupkaTovara', 'tlCategoryWidth', 250);
    cbUpdatePrice.Checked := Ini.ReadInteger('ZakupkaTovara', 'cbUpdatePrice', 0) = 1;
    edNacenka.Value := Ini.ReadFloat('ZakupkaTovara', 'edNacenka', 0);
  finally
    Ini.Free;
  end;
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
    ParamByName('NDS_').AsFloat := edNDS.SummValue;
    ParamByName('NDS_SUMM_').AsFloat := edNDSSumm.Value;
  end;
end;

procedure TZakupkaTovaraForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'sklad_';
end;

procedure TZakupkaTovaraForm.btClearClick(Sender: TObject);
begin
  edBarcode.Text := '';
end;

procedure TZakupkaTovaraForm.aRefreshChdExecute(Sender: TObject);
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

procedure TZakupkaTovaraForm.grProductChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  RefreshRek;
end;

procedure TZakupkaTovaraForm.RefreshRek;
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

  if cbUpdatePrice.Checked then
    edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;
end;

procedure TZakupkaTovaraForm.tlCategoryChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  aRefreshChd.Execute;
end;

procedure TZakupkaTovaraForm.edNDSChange(Sender: TObject);
begin
  edNDSSumm.Value := edSumm.Value * edNDS.SummValue / 100;
end;

procedure TZakupkaTovaraForm.FormCloseQuery(Sender: TObject;
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
      //обновлю цену товару
      if cbUpdatePrice.Checked then begin
        spUpdatePrice.ParamByName('price_').AsFloat := edPrice.Value + edPrice.Value*edNacenka.Value/100;
        spUpdatePrice.ParamByName('g_product_').AsFloat := spRead.FieldByName('G_PRODUCT').AsInteger;
        if not spUpdatePrice.Transaction.InTransaction then
          spUpdatePrice.Transaction.StartTransaction;
        spUpdatePrice.ExecQuery;
        if spUpdatePrice.Transaction.InTransaction then
          spUpdatePrice.Transaction.Commit;
      end;

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

procedure TZakupkaTovaraForm.grProductDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TZakupkaTovaraForm.edPriceChange(Sender: TObject);
begin
  inherited;
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
  if (FIs_Vozvrat = 0) and (edPrice.Value > 0) then begin
    edNakrutkaR.Value := sePrice.Value * 100 / edPrice.Value - 100;
    if sePriceOpt.Value > 0 then
      edNakrutkaO.Value := sePriceOpt.Value * 100 / edPrice.Value - 100
    else
      edNakrutkaO.Value := 0;
  end;

  if cbUpdatePrice.Checked then
    edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;  
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
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (NOMENCLATUR_NUM CONTAINING ''' + edBarcode.text +
           ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''')';
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

procedure TZakupkaTovaraForm.MyCurrencyFrameForm1edAmountChange(
  Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
end;

procedure TZakupkaTovaraForm.aInsExecute(Sender: TObject);
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
begin
  inherited;

  // галочка "Закрывать окно"
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    Ini.WriteInteger('ZakupkaTovara', 'cbClose', Integer(cbClose.Checked));
    Ini.WriteInteger('ZakupkaTovara', 'tlCategoryWidth', tlCategory.Width);
    Ini.WriteInteger('ZakupkaTovara', 'cbUpdatePrice', Integer(cbUpdatePrice.Checked));
    Ini.WriteFloat('ZakupkaTovara', 'edNacenka', edNacenka.Value);
  finally
    Ini.Free;
  end;
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
begin
  edBarcode.Clear;

  spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;

  try
    IF ExecSPTR(spFindProduct) THEN BEGIN
      spReadCategory.Locate('g_product', spFindProduct.ParamByName('g_product_category_').AsInteger, []);
      aRefreshChd.Execute;
      spRead.Locate('g_product', spFindProduct.ParamByName('G_PRODUCT_').AsInteger, []);
      if grProduct.FocusedNode <> Nil then begin
        if grProduct.SelectedCount > 0 then
          grProduct.SelectedNodes[0].Selected := False;
        grProduct.FocusedNode.Selected := True;
      end;
      edPrice.SetFocus;
    END;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TZakupkaTovaraForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
  end;

  spFindProduct.ParamByName('BARCODE_').AsString := '';
end;

procedure TZakupkaTovaraForm.sbClearClick(Sender: TObject);
begin
  edBarcode.Text := '';
  if Assigned(grProduct.FocusedNode) then
    grProduct.FocusedNode.Selected := True;
  RefreshRek;
end;

procedure TZakupkaTovaraForm.cbUpdatePriceClick(Sender: TObject);
begin
  if cbUpdatePrice.Checked then begin
    edNacenka.Enabled := True;
    edNewPrice.Enabled := True;
    edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;
  end else begin
    edNacenka.Enabled := False;
    edNewPrice.Enabled := False;
    edNacenka.Value := 0;
    edNewPrice.Value := 0;
  end;
end;

procedure TZakupkaTovaraForm.edNacenkaChange(Sender: TObject);
begin
  edNewPrice.Value := edPrice.Value + edPrice.Value*edNacenka.Value/100;
end;

procedure TZakupkaTovaraForm.cbShowModeClick(Sender: TObject);
begin
  if cbShowMode.Checked then begin
    Height := 663;
  end else begin
    Height := 601;
    cbUpdatePrice.Checked := False;
    cbUpdateOptPrice.Checked := False;
  end
end;

end.
