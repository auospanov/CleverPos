unit frmProdazhaTovara;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxSplitter, frmDlg, frmDBEdit, mmSystem, FIBDataSet, pFIBDataSet,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, Math,
  AppEvnts, frmMyCurrencyFrame, Inifiles, DateUtils, cxLookAndFeelPainters,
  cxButtons, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, dxSkinscxPCPainter, cxFilter, cxData, cxDataStorage,
  cxDBData, cxCurrencyEdit, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxInplaceContainer, cxDBTL, cxTLData, cxCheckBox, System.UITypes, cxNavigator,
  System.Actions;

type
  TProdazhaTovaraForm = class(TDBEditForm)
    Panel3: TPanel;
    Panel4: TPanel;
    Label10: TLabel;
    edBarcode: TEdit;
    splMenu: TcxSplitter;
    dsRead: TDataSource;
    dsReadCategory: TDataSource;
    aChooseTovar: TAction;
    aRefreshChd: TAction;
    spReadCategory: TpFIBDataSet;
    spRead: TpFIBDataSet;
    spFindProduct: TpFIBStoredProc;
    Panel2: TPanel;
    Shape19: TShape;
    Shape14: TShape;
    Shape4: TShape;
    Shape7: TShape;
    Shape5: TShape;
    Shape1: TShape;
    Label1: TLabel;
    Shape3: TShape;
    Label3: TLabel;
    Shape6: TShape;
    Label4: TLabel;
    Shape8: TShape;
    Label2: TLabel;
    Shape12: TShape;
    Label8: TLabel;
    Shape16: TShape;
    Label11: TLabel;
    Shape20: TShape;
    grpNDS: TGroupBox;
    Shape10: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape15: TShape;
    Label6: TLabel;
    Shape11: TShape;
    rbRoznica: TRadioButton;
    rbOpt: TRadioButton;
    Panel5: TPanel;
    rbSkidkaInProcent: TRadioButton;
    rbSkidkaInTenge: TRadioButton;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    TimerChangeEd: TTimer;
    aeScanner: TApplicationEvents;
    GetLastPrice: TpFIBStoredProc;
    aBreakTovar: TAction;
    btnChooseTovar: TcxButton;
    aCustomizeColumns: TAction;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    lv1: TcxGridLevel;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    clmtv1VOLUME_PRICE: TcxGridDBColumn;
    clmtv1NOTE: TcxGridDBColumn;
    clmtv1PLACE: TcxGridDBColumn;
    edSumm: TcxCurrencyEdit;
    edPrice: TcxCurrencyEdit;
    seSkidka: TcxCurrencyEdit;
    seSkidkaSumm: TcxCurrencyEdit;
    seOstatok: TcxCurrencyEdit;
    edNDS: TcxCurrencyEdit;
    edNDSSumm: TcxCurrencyEdit;
    tlCategory: TcxDBTreeList;
    clmnCategoryNAME: TcxDBTreeListColumn;
    cbClose: TcxCheckBox;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    edCostPrice: TcxCurrencyEdit;
    sbClear: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aRefreshChdExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rbOptClick(Sender: TObject);
    procedure rbRoznicaClick(Sender: TObject);
    procedure grProductDblClick(Sender: TObject);
    procedure rbSkidkaInTengeClick(Sender: TObject);
    procedure rbSkidkaInProcentClick(Sender: TObject);
    procedure edAmountChange(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure aeScannerMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure aChooseTovarExecute(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure aBreakTovarExecute(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure tvProductFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure edPricePropertiesChange(Sender: TObject);
    procedure seSkidkaPropertiesChange(Sender: TObject);
    procedure edNDSPropertiesChange(Sender: TObject);
    procedure tvProductCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FG_product: Integer;
    FAmount   : Double;       // количество, если вдруг юзаются весы
    FPName: String;
    FIs_spisanie : Integer; // 0 - обычный заказ, 1 - списание товара
    FSkidka  : Double;       // скидка клиента при покупке
    FCOST_PRICE : Double;   // себестоимость товара
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
  public
    property G_product: Integer read FG_product write FG_product;
    property PName: String read FPName write FPName;
    property Is_spisanie: Integer read FIs_spisanie write FIs_spisanie default 0;
    property Skidka: Double read FSkidka write FSkidka;
  protected
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure ItogRecalc;
    procedure GetSkidka;
  end;

var
  ProdazhaTovaraForm: TProdazhaTovaraForm;

implementation

uses unCommonFunc, frmProdazhaTovaraN;

{$R *.dfm}

procedure TProdazhaTovaraForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
  onChangeCat : TcxTreeListFocusedNodeChangedEvent;
begin
  if FIs_spisanie = 0 then
    HELPC := 18
  else if FIs_spisanie = 1 then
    HELPC := 19
  else if FIs_spisanie = 2 then
    HELPC := 58
  else
    HELPC := 52;

  onChangeCat := tlCategory.OnFocusedNodeChanged;
  tlCategory.OnFocusedNodeChanged := nil;

  OpenSp(spReadCategory, False);
  tlCategory.FocusedNode.Selected := True;

  tlCategory.OnFocusedNodeChanged := onChangeCat;

  MyCurrencyFrameForm.edAmount.Text := '1';  // по умолчанию поставлю 1
  if FIs_spisanie IN [1,3,4] then begin
    rbRoznica.Visible := False;
    rbOpt.Visible     := False;
    //edPrice.Enabled   := False;
    seSkidka.Enabled  := False;
    edNDS.Enabled     := False;
    grpNDS.Visible    := False;
    rbSkidkaInProcent.Visible := False;
    rbSkidkaInTenge.Visible := False;
  end else begin
    seSkidka.Value := FSkidka;
    edNDS.Value := NdsValue;
  end;

  aRefreshChd.Execute;

  // галочка "Закрывать окно" и фильтр
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    cbClose.Checked := Ini.ReadInteger('ProdazhaTovara', 'cbClose', 0) = 1;
    tlCategory.Width := Ini.ReadInteger('ProdazhaTovara', 'tlCategoryWidth', ScaleDimension(250));
    Height := Ini.ReadInteger('ProdazhaTovara', 'Height', ScaleDimension(600)); //Constraints.MinHeight
    Width := Ini.ReadInteger('ProdazhaTovara', 'Width', ScaleDimension(650));   //Constraints.MinWidth
  finally
    Ini.Free;
  end;

  tvProduct.RestoreFromIniFile('Settings.ini', True, False, [], Self.Name + '-' + tvProduct.Name);

  // если конфигурация аптека, то отражаю специфичную кнопку
  if Config = 1 then
    aBreakTovar.Visible := True
  else
    aBreakTovar.Visible := False;
end;

function TProdazhaTovaraForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if MyCurrencyFrameForm.Value = 0 then begin
    MyCurrencyFrameForm.edAmount.setfocus;
    MessageDlg('Количество не указано', mtInformation, [mbOK], 0);
    Exit;
  end;

  if AllowSellAbsGoods = 0 then
    if seOstatok.Value = 0 then begin
      MessageDlg('Остаток товара на складе 0 и после операции он станет отрицательным. Продолжение невозможно!', mtWarning, [mbYes], 0);
      Exit;
    end;

  if (FIs_spisanie = 0) AND (NotifyNol = 1) then     // про цену ругаюсь только при продаже, т.к. при списании цена = 0
    if edPrice.Value = 0 then begin
      if MessageDlg('Цена товара указана 0, Вы уверены, что хотите продолжить?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
        ErrControl := edPrice;
        Exit;
      end;
    end;

  Result := True;
end;

procedure TProdazhaTovaraForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('G_PRODUCT_').AsInteger := spRead.FieldByName('G_PRODUCT').AsInteger;
    ParamByName('AMOUNT_').AsFloat := MyCurrencyFrameForm.Value;
    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('SUMM_').AsFloat := edSumm.Value;
    if (seSkidka.Value <> 0) and (edPrice.Value > 0) then begin
      if rbSkidkaInProcent.Checked then begin
        ParamByName('DISCOUNT_PERC_').AsFloat := seSkidka.Value;
        ParamByName('DISCOUNT_TENGE_').AsFloat := edPrice.Value * seSkidka.Value/100;
      end else begin
        ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((seSkidka.Value * 100 / edPrice.Value), -5);
        ParamByName('DISCOUNT_TENGE_').AsFloat := seSkidka.Value;
      end;
    end else begin
      ParamByName('DISCOUNT_PERC_').AsFloat := 0;
      ParamByName('DISCOUNT_TENGE_').AsFloat := 0;
    end;
    ParamByName('DISCOUNT_SUMM_').AsFloat := seSkidkaSumm.Value;
    ParamByName('NDS_').AsFloat := edNDS.Value;  // теперь берется из настроек справочника "Моя фирма"
    ParamByName('NDS_SUMM_').AsFloat := edNDSSumm.Value;
    ParamByName('IS_SPISANIE_').AsInteger := FIs_spisanie;
    ParamByName('NEW_LINE_SALE_').AsInteger := NewLineSale;
    ParamByName('COST_PRICE_').AsFloat := FCOST_PRICE;

    IF rbRoznica.Checked THEN
      ParamByName('MODE_').AsFloat := 1
    else
      ParamByName('MODE_').AsFloat := 2;

    ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
  end;
end;

procedure TProdazhaTovaraForm.FormCreate(Sender: TObject);
begin
  inherited;
  Constraints.MinHeight := ScaleDimension(508);
  Constraints.MinWidth := ScaleDimension(621);
  KeyField := 'zakaz_details_';
  MyCurrencyFrameForm.edAmount.Text := '1';
  if screen.PixelsPerInch <> 96 then
    Height := ScaleDimension(SelfHeight);
end;

procedure TProdazhaTovaraForm.aRefreshChdExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  spRead.ParamByName('g_product_par_').AsInteger := spReadCategory.FieldByName('g_product').AsInteger;
  spRead.ParamByName('g_tochka_').AsInteger := CurSklad;
  OpenSp(spRead, False);

  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;

  GetSkidka;
  Screen.Cursor := crDefault;
end;

procedure TProdazhaTovaraForm.tvProductCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnOk.Click;
end;

procedure TProdazhaTovaraForm.tvProductFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if (spRead.Active) and (APrevFocusedRecord <> nil) then
    GetSkidka;
end;

procedure TProdazhaTovaraForm.edNDSPropertiesChange(Sender: TObject);
begin
  edNDSSumm.Value := edSumm.Value * edNDS.Value / (100 + edNDS.Value);   //так считается по бухгалтерской формуле
end;

procedure TProdazhaTovaraForm.FormCloseQuery(Sender: TObject;
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
      ProdazhaTovaraNForm.Readlist;
      ProdazhaTovaraNForm.edOsnovanie.ModifiedAfterEnter := True;  // иначе не захватиться изменение, т.к. фактически там ничего не менялось
      if cbClose.Checked then
        CanClose := True
      else begin
        CanClose := False;
        ShowMessage('Товар добавлен!');
      end;
    end;
  end;
end;

procedure TProdazhaTovaraForm.GetSkidka;
var skidka_proc : DOUBLE;
begin
  if FAmount <> 0 then begin
    MyCurrencyFrameForm.edAmount.Text := FloatToStr(FAmount);
    FAmount := 0
  end else
    MyCurrencyFrameForm.edAmount.Text := '1';

  rbSkidkaInProcent.Checked := True;
  seSkidka.Value := 0;

  WITH spRead DO BEGIN
    if rbRoznica.Checked then
      edPrice.Value := spRead.FieldByName('PRICE').AsFloat
    else
      edPrice.Value := spRead.FieldByName('VOLUME_PRICE').AsFloat;

    seOstatok.Value := FieldByName('AMOUNT').AsFloat;

    GetLastPrice.ParamByName('MODE_').AsIntEGER := 1;
    GetLastPrice.ParamByName('G_PRODUCT_').AsIntEGER := spRead.FieldByName('G_PRODUCT').AsInteger;
    GetLastPrice.ParamByName('G_TOCHKA_').AsIntEGER := CurSklad;
    IF ExecSPTR(GetLastPrice) THEN begin
      FCOST_PRICE := GetLastPrice.ParamByName('price_').AsFloat;
      edCostPrice.Value := FCOST_PRICE;
    end ELSE BEGIN
      ShowMessage('Произошла ошибка при расчете стоимости товара!');
      EXIT;
    END;

    // ЕСЛИ СПИСАНИЕ/ПЕРЕМЕЩЕНИЕ ТО СТАВЛЮ В ЦЕНУ СЕБЕСТОИМОСТЬ ТОВАРА
    IF FIs_spisanie in [1,3,4] THEN BEGIN
      edPrice.Value := FCOST_PRICE;
      seSkidka.Value := 0;
    END ELSE BEGIN

      {if FieldByName('SKIDKA_PROC').AsFloat > 0 then begin
        rbSkidkaInProcent.Checked := True;
        seSkidka.Value := FieldByName('SKIDKA_PROC').AsFloat
      end else if FieldByName('SKIDKA_SUM').AsFloat > 0 then begin
        rbSkidkaInTenge.Checked := True;
        seSkidka.Value := FieldByName('SKIDKA_SUM').AsFloat;
      end;
      короче решил так - если есть скидка, то вставляю в тенге, а потом пересчитываю в проценты, а то если вставлять в процентах, и пересчитывать в тенге,
      то сумма получается чуть-чуть не та, которую хотел клиент изначально. Например товар стоит 8000, скидку поставили 1010, программа высчитала процент 12.62.
      Если сначала вставим процент 12.62, а затем посчитать сумму, то получится 6990.4, а не 6990, как должно было быть
      }
      if FieldByName('SKIDKA_SUM').AsFloat > 0 then begin
        rbSkidkaInTenge.Checked := True;
        seSkidka.Value := FieldByName('SKIDKA_SUM').AsFloat;
        skidka_proc := RoundTo((seSkidka.Value * 100 / edPrice.Value), -2);
      end;

      // вдруг у данного клиента есть своя скидка, если она больше то ставлю ее
      if FSkidka > 0 then begin
        if (FSkidka > seSkidka.Value) and (rbSkidkaInProcent.Checked) then  // если скидка в процентах
          seSkidka.Value := FSkidka

        else if rbSkidkaInTenge.Checked then begin  // если в Тенге, то придется рассчитывать сколько это будет в процентах, а потом сравнивать, т.к. скидка у клиента именно в процентаъ
          skidka_proc := seSkidka.Value*100/edPrice.Value;
          if FSkidka > skidka_proc then begin
            rbSkidkaInProcent.Checked := True;
            seSkidka.Value := FSkidka;
          end;
        end;
      end;
    END;
  END;
end;

procedure TProdazhaTovaraForm.edAmountChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TProdazhaTovaraForm.seSkidkaPropertiesChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TProdazhaTovaraForm.rbOptClick(Sender: TObject);
begin
  edPrice.Value := spRead.FieldByName('VOLUME_PRICE').AsFloat;
end;

procedure TProdazhaTovaraForm.rbRoznicaClick(Sender: TObject);
begin
  // ЕСЛИ СПИСАНИЕ ТО СТАВЛЮ 0 В ЦЕНУ, Т.К. ФАКТИЧЕСКИ, ПРИ СПИСАНИИ, МЫ ПРОДАЕМ ТОВАР ПО НУЛЕВОЙ СТОИМОСТИ
  IF FIs_spisanie = 1 THEN
    edPrice.Value := 0
  ELSE
    edPrice.Value := spRead.FieldByName('PRICE').AsFloat;
end;

procedure TProdazhaTovaraForm.grProductDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TProdazhaTovaraForm.edPricePropertiesChange(Sender: TObject);
begin
  edPrice.Text := StringReplace(edPrice.Text, ',', '.', [rfReplaceAll]);

  ItogRecalc;
end;

procedure TProdazhaTovaraForm.rbSkidkaInTengeClick(Sender: TObject);
begin
  seSkidka.Properties.DisplayFormat := ',0.00;-,0.00';
  ItogRecalc;
end;

procedure TProdazhaTovaraForm.rbSkidkaInProcentClick(Sender: TObject);
begin
  seSkidka.Properties.DisplayFormat := '0.00%';
  ItogRecalc;
end;

procedure TProdazhaTovaraForm.ItogRecalc;
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

procedure TProdazhaTovaraForm.tlCategoryFocusedNodeChanged(
  Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  aRefreshChd.Execute;
end;

procedure TProdazhaTovaraForm.edBarcodeChange(Sender: TObject);
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

procedure TProdazhaTovaraForm.edBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_UP then
    spRead.Prior
  else if Key = VK_DOWN then
    spRead.Next;
end;

procedure TProdazhaTovaraForm.MyCurrencyFrameFormedAmountChange(
  Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  ItogRecalc;
end;

procedure TProdazhaTovaraForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;

  // галочка "Закрывать окно"
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    Ini.WriteInteger('ProdazhaTovara', 'cbClose', Integer(cbClose.Checked));
    Ini.WriteInteger('ProdazhaTovara', 'tlCategoryWidth', tlCategory.Width);
    Ini.WriteInteger('ProdazhaTovara', 'Height', Height);
    Ini.WriteInteger('ProdazhaTovara', 'Width', Width);
  finally
    Ini.Free;
  end;

  tvProduct.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvProduct.name);
end;

procedure TProdazhaTovaraForm.TimerChangeEdTimer(Sender: TObject);
var s : string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spRead do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''') OR (CROSSCODE CONTAINING '''+ edBarcode.text + ''')';
      
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

    GetSkidka;
  END;
end;

procedure TProdazhaTovaraForm.aeScannerMessage(var Msg: tagMSG;
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

procedure TProdazhaTovaraForm.aChooseTovarExecute(Sender: TObject);
var onChange : TNotifyEvent;
    onChangeCat : TcxTreeListFocusedNodeChangedEvent;
    onChangeTov : TcxGridFocusedRecordChangedEvent;
begin
  onChange := edBarcode.OnChange;
  edBarcode.OnChange := nil;
  edBarcode.Clear;
  spRead.CancelConditions;   //очищаю фильтрацию если было
  spRead.Conditions.Clear;
  edBarcode.OnChange := onChange;
  onChangeCat := tlCategory.OnFocusedNodeChanged;
  onChangeTov := tvProduct.OnFocusedRecordChanged;

  spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
  if UseScales = 1 then
    spFindProduct.ParamByName('PREFIX_').AsString := ScalesPrefix
  else
    spFindProduct.ParamByName('PREFIX_').AsString := '';

  try
    IF ExecSPTR(spFindProduct) THEN BEGIN
      Screen.Cursor := crHourGlass;
      tlCategory.OnFocusedNodeChanged := nil;
      tvProduct.OnFocusedRecordChanged  := nil;
      FAmount := spFindProduct.ParamByName('amount_').AsFloat;
      spReadCategory.Locate('g_product', spFindProduct.ParamByName('g_product_category_').AsInteger, []);
      spRead.ParamByName('g_product_par_').AsInteger := spReadCategory.FieldByName('g_product').AsInteger;
      spRead.ParamByName('g_tochka_').AsInteger := CurSklad;
      OpenSp(spRead, False);
      spRead.Locate('g_product', spFindProduct.ParamByName('G_PRODUCT_').AsInteger, []);
      if tvProduct.Controller.FocusedRow <> Nil then begin
        if tvProduct.Controller.SelectedRowCount > 0 then
          tvProduct.Controller.SelectedRows[0].Selected := False;
        tvProduct.Controller.FocusedRow.Selected := True;
      end;
      GetSkidka;
      tvProduct.OnFocusedRecordChanged := onChangeTov;
      tlCategory.OnFocusedNodeChanged := onChangeCat;
      ModalResult := mrOk;     // закрываю окно, чтобы сработало OnCloseQuery
      Screen.Cursor := crDefault;
    END;
  except
    on E: Exception do begin
      tlCategory.OnFocusedNodeChanged := onChangeCat;
      tvProduct.OnFocusedRecordChanged := onChangeTov;
      MessageDlg(E.Message + #13#10'(occured in TSaleModeForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
    end;
  end;

  spFindProduct.ParamByName('BARCODE_').AsString := '';
end;

procedure TProdazhaTovaraForm.sbClearClick(Sender: TObject);
begin
  edBarcode.Clear;
  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;
  GetSkidka;
end;

procedure TProdazhaTovaraForm.aBreakTovarExecute(Sender: TObject);
var s : string;
    f : double;
    i : integer;
begin
  if (spRead.FieldByName('pack_amount').AsVariant > 0) then BEGIN
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

      f := roundto(F/spRead.FieldByName('pack_amount').AsFloat, -2);
      MyCurrencyFrameForm.edAmount.Text := FloatToStr(F);
    end

  END else
    ShowMessage('У товара не указано значение "Количество в упаковке"!');
end;

procedure TProdazhaTovaraForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  tvProduct.Controller.Customization := True;
end;

end.
