unit frmOplataTovaraReal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxSplitter, frmDlg, frmDBEdit, mmSystem, FIBDataSet, pFIBDataSet,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, Math,
  AppEvnts, frmMyCurrencyFrame, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  dxSkinscxPCPainter, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxCurrencyEdit,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxInplaceContainer, cxDBTL,
  cxTLData, System.UITypes, cxNavigator, System.Actions, cxButtons,
  cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TOplataTovaraRealForm = class(TDBEditForm)
    Panel3: TPanel;
    Panel4: TPanel;
    Label10: TLabel;
    edBarcode: TEdit;
    splMenu: TcxSplitter;
    dsReadProd: TDataSource;
    dsReadCategory: TDataSource;
    aChooseTovar: TAction;
    aRefreshChd: TAction;
    spReadCategory: TpFIBDataSet;
    spReadProd: TpFIBDataSet;
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
    GroupBox1: TGroupBox;
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
    TimerSearch: TTimer;
    GetLastPrice: TpFIBStoredProc;
    lstCategory: TcxDBTreeList;
    clmnCategoryNAME: TcxDBTreeListColumn;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    lv1: TcxGridLevel;
    seOstatok: TcxCurrencyEdit;
    edNDS: TcxCurrencyEdit;
    edNDSSumm: TcxCurrencyEdit;
    edPrice: TcxCurrencyEdit;
    seSkidka: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    seSkidkaSumm: TcxCurrencyEdit;
    tvProductARTICUL: TcxGridDBColumn;
    tvProductNOMENCLATUR_NUM: TcxGridDBColumn;
    tvProductBARCODE: TcxGridDBColumn;
    tvProductNAME: TcxGridDBColumn;
    tvProductOSNOVANIE: TcxGridDBColumn;
    sbClear: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure aRefreshChdExecute(Sender: TObject);
    procedure edNDSChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure seSkidkaChange(Sender: TObject);
    procedure rbOptClick(Sender: TObject);
    procedure rbRoznicaClick(Sender: TObject);
    procedure grProductDblClick(Sender: TObject);
    procedure rbSkidkaInTengeClick(Sender: TObject);
    procedure rbSkidkaInProcentClick(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
    procedure TimerSearchTimer(Sender: TObject);
    procedure lstCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure tvProductFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure edPricePropertiesChange(Sender: TObject);
    procedure tvProductCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FG_product: Int64;
    FPName: String;
    FModeZ : Integer; // 0 - обычный заказ на реал, 1 - возврат товара
    FSkidka  : Double;       // скидка клиента при покупке
    FClient  : Int64;
    FCOST_PRICE : Double;   // себестоимость товара
  public
    property G_product: Int64 read FG_product write FG_product;
    property PName: String read FPName write FPName;
    property ModeZ: Integer read FModeZ write FModeZ default 0;
    property Skidka: Double read FSkidka write FSkidka;
    property Client: Int64 read FClient write FClient default 0;
    function CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure ItogRecalc;
    procedure GetSkidka;
  end;

var
  OplataTovaraRealForm: TOplataTovaraRealForm;

implementation

uses unCommonFunc, frmOplataTovaraRealN;

{$R *.dfm}

procedure TOplataTovaraRealForm.FormShow(Sender: TObject);
begin
  riEditRepositoryCurrencyItem := SetColumnDecimalPlaceCur(riEditRepositoryCurrencyItem);

  spReadCategory.ParamByName('g_client_').AsInt64 := FClient;
  OpenSp(spReadCategory, False);
  lstCategory.FocusedNode.Selected := True;

  MyCurrencyFrameForm.edAmount.Text := '1';  // по умолчанию поставлю 1

  // ПРИ ВОЗВРАТЕ ТОВАРА С РЕАЛИЗАЦИИ НЕ ДАЮ МЕНЯТЬ ЦЕНУ
  IF FModeZ = 1 THEN BEGIN
    edPrice.Enabled := False;
    rbRoznica.Enabled := False;
    rbOpt.Enabled := False;
    seSkidka.Enabled := False;
    edNDS.Enabled := False;
    Helpc := 60;
  END else
    Helpc := 59;
  edNDS.Value := NdsValue;
  aRefreshChd.Execute;

  tvProduct.RestoreFromIniFile('Settings_grid.ini', False, False, [], Self.Name + '-' + tvProduct.Name);
end;

function TOplataTovaraRealForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if MyCurrencyFrameForm.Value = 0 then begin
    MyCurrencyFrameForm.edAmount.SetFocus;
    MessageDlg('Количество не указано', mtInformation, [mbOK], 0);
    Exit;
  end;

  if seOstatok.Value = 0 then begin
    MessageDlg('Остаток товара в накладной 0, больше добавить нельзя. Продолжение невозможно!', mtWarning, [mbYes], 0);
    Exit;
  end;

  Result := True;
end;

procedure TOplataTovaraRealForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('G_PRODUCT_').AsInt64 := spReadProd.FieldByName('G_PRODUCT').AsLargeInt;
    ParamByName('AMOUNT_').AsFloat := MyCurrencyFrameForm.Value;
    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('SUMM_').AsFloat := edSumm.Value;
    if (seSkidka.Value <> 0) and (edPrice.Value > 0) then begin
      if rbSkidkaInProcent.Checked then begin
        ParamByName('DISCOUNT_PERC_').AsFloat := seSkidka.Value;
        ParamByName('DISCOUNT_TENGE_').AsFloat := edPrice.Value * seSkidka.Value/100;
      end else begin
        //ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo(seSkidka.Value * 100 / edPrice.Value, -2);
        //ParamByName('DISCOUNT_TENGE_').AsFloat := seSkidka.Value;
        ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((seSkidka.Value/MyCurrencyFrameForm.Value * 100 / edPrice.Value), -2);
        ParamByName('DISCOUNT_TENGE_').AsFloat := RoundTo(seSkidka.Value/MyCurrencyFrameForm.Value, -2);
      end;
    end else begin
      ParamByName('DISCOUNT_PERC_').AsFloat := 0;
      ParamByName('DISCOUNT_TENGE_').AsFloat := 0;
    end;
    ParamByName('DISCOUNT_SUMM_').AsFloat := seSkidkaSumm.Value;
    ParamByName('NDS_').AsFloat := edNDS.Value;  // теперь берется из настроек справочника "Моя фирма"
    ParamByName('NDS_SUMM_').AsFloat := edNDSSumm.Value;
    ParamByName('COST_PRICE_').AsFloat := FCOST_PRICE;
    ParamByName('ZAKAZ_NA_REAL_').AsInt64 := spReadProd.FieldByName('ZAKAZ_NA_REAL').AsLargeInt;
  end;
end;

procedure TOplataTovaraRealForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'zakaz_details_';
  MyCurrencyFrameForm.edAmount.Text := '1';
end;

procedure TOplataTovaraRealForm.btClearClick(Sender: TObject);
begin
  edBarcode.Clear;
end;

procedure TOplataTovaraRealForm.aRefreshChdExecute(Sender: TObject);
begin
  spReadProd.ParamByName('g_product_par_').AsInt64 := spReadCategory.FieldByName('g_product').AsLargeInt;
  spReadProd.ParamByName('g_client_').AsInt64 := FClient;
  spReadProd.ParamByName('g_tochka_').AsInt64 := CurSklad;
  OpenSp(spReadProd, False);

  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;

  GetSkidka;
end;

procedure TOplataTovaraRealForm.tvProductCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnOk.Click;
end;

procedure TOplataTovaraRealForm.tvProductFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if (spReadProd.Active) and (APrevFocusedRecord <> nil) then begin
    rbSkidkaInProcent.Checked := True;
    seSkidka.Value := 0;
    GetSkidka;
  end;
end;

procedure TOplataTovaraRealForm.edNDSChange(Sender: TObject);
begin
  edNDSSumm.Value := edSumm.Value * edNDS.Value / (100 + edNDS.Value);  //так считается по бухгалтерской формуле;
end;

procedure TOplataTovaraRealForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tvProduct.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvProduct.name);
end;

procedure TOplataTovaraRealForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (tvProduct.Controller.SelectedRowCount = 0) and (ModalResult = mrOk) then begin
    MessageDlg('Вы не выбрали ни одного товара! Выберите товар!', mtWarning, [mbOk], 0);
    edBarcode.Clear;
    CanClose := False;
    Exit;
  end;

  inherited;
  if Self.ModalResult = mrOk then begin
    CanClose := False;
    IF Success then begin
      OplataTovaraRealNForm.Readlist;
      OplataTovaraRealNForm.edOsnovanie.ModifiedAfterEnter := True;  // иначе не захватиться изменение, т.к. фактически там ничего не менялось
      //ShowMessage('Товар добавлен!');
      PlaySound(PChar('coin.wav'), 0, SND_FILENAME or SND_ASYNC);
    end;
  end;
end;

procedure TOplataTovaraRealForm.GetSkidka;
var skidka_proc : Real;
begin
  MyCurrencyFrameForm.edAmount.Text := '1';

  WITH spReadProd DO BEGIN
    GetLastPrice.ParamByName('MODE_').AsIntEGER := 1;
    GetLastPrice.ParamByName('G_PRODUCT_').AsInt64 := FieldByName('G_PRODUCT').AsLargeInt;
    GetLastPrice.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
    IF ExecSPTR(GetLastPrice) THEN
      FCOST_PRICE := GetLastPrice.ParamByName('price_').AsFloat
    ELSE BEGIN
      ShowMessage('Произошла ошибка при расчете стоимости товара!');
      EXIT;
    END;

    if rbRoznica.Checked then
      edPrice.Value := FieldByName('PRICE').AsFloat
    else
      edPrice.Value := FieldByName('VOLUME_PRICE').AsFloat;

    seOstatok.Value := FieldByName('AMOUNT').AsFloat;

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

    15.11.2018 оказывается цена в ZAKAZ_NA_REAL_PARENT УЖЕ С УЧЕТОМ СКИДКИ, ПОЭТОМУ ПО СУТИ ТУТ ВООБЩЕ ВСЕ ЭТИ
    ГАЛОЧКИ СО СКИДКАМИ И ПРОЧИМ НЕ НУЖНЫ НАФИГ
    }
    {if FieldByName('SKIDKA_SUM').AsFloat > 0 then begin
      rbSkidkaInTenge.Checked := True;
      seSkidka.Value := FieldByName('SKIDKA_SUM').AsFloat;
      if edPrice.Value = 0 then
        skidka_proc := 0
      else
        skidka_proc := RoundTo(seSkidka.Value * 100 /edPrice.Value, -2);
    end;}
  END;
end;

procedure TOplataTovaraRealForm.seSkidkaChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TOplataTovaraRealForm.rbOptClick(Sender: TObject);
begin
  edPrice.Value := spReadProd.FieldByName('VOLUME_PRICE').AsFloat;
end;

procedure TOplataTovaraRealForm.rbRoznicaClick(Sender: TObject);
begin
  // ЕСЛИ СПИСАНИЕ ТО СТАВЛЮ 0 В ЦЕНУ, Т.К. ФАКТИЧЕСКИ, ПРИ СПИСАНИИ, МЫ ПРОДАЕМ ТОВАР ПО НУЛЕВОЙ СТОИМОСТИ
  edPrice.Value := spReadProd.FieldByName('PRICE').AsFloat;
end;

procedure TOplataTovaraRealForm.grProductDblClick(Sender: TObject);
begin
  btnOk.Click; 
end;

procedure TOplataTovaraRealForm.edPricePropertiesChange(Sender: TObject);
begin
  ItogRecalc;
end;

procedure TOplataTovaraRealForm.rbSkidkaInTengeClick(Sender: TObject);
begin
  seSkidka.Properties.DisplayFormat := ',0.00;-,0.00';
  ItogRecalc;
end;

procedure TOplataTovaraRealForm.rbSkidkaInProcentClick(Sender: TObject);
begin
  seSkidka.Properties.DisplayFormat := '0.00%';
  ItogRecalc;
end;

procedure TOplataTovaraRealForm.ItogRecalc;
begin
  if (edPrice.Value > 0) then begin
    if FModeZ = 0 then begin
      if rbSkidkaInProcent.Checked then begin
        edSumm.Value := Max(MyCurrencyFrameForm.Value * (edPrice.Value * (1 - seSkidka.Value/100)), 0);
        seSkidkaSumm.Value := (MyCurrencyFrameForm.Value * edPrice.Value) - (MyCurrencyFrameForm.Value * edPrice.Value * (1 - seSkidka.Value/100))
      end else begin
        edSumm.Value := Max(MyCurrencyFrameForm.Value * (edPrice.Value - seSkidka.Value), 0);
        seSkidkaSumm.Value := (MyCurrencyFrameForm.Value * edPrice.Value) - (MyCurrencyFrameForm.Value * (edPrice.Value - seSkidka.Value))
      end;
    end
    // при возврате будет браться цена, по которой продали и все
    else begin
      edSumm.Value := MyCurrencyFrameForm.Value * edPrice.Value;
      seSkidkaSumm.Value := 0;
    end;
  end else begin
    edSumm.Value := 0;
    seSkidkaSumm.Value := 0;
  end;
  edNDSChange(Self);
end;

procedure TOplataTovaraRealForm.lstCategoryFocusedNodeChanged(
  Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  aRefreshChd.Execute;
  MyCurrencyFrameForm.edAmount.Text := '1';
end;

procedure TOplataTovaraRealForm.edBarcodeChange(Sender: TObject);
begin
  TimerSearch.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    TimerSearch.Enabled := True
  else BEGIN
    with spReadProd do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TOplataTovaraRealForm.edBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_UP then
    spReadProd.Prior
  else if Key = VK_DOWN then
    spReadProd.Next;
end;

procedure TOplataTovaraRealForm.TimerSearchTimer(Sender: TObject);
var s : string;
begin
  TimerSearch.Enabled := False;
  if (edBarcode.text <> '') then BEGIN
    with spReadProd do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (NOMENCLATUR_NUM CONTAINING ''' + edBarcode.text +
           ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''')';
      
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

    rbSkidkaInProcent.Checked := True;
    seSkidka.Value := 0;

    GetSkidka;
  END;
end;

procedure TOplataTovaraRealForm.MyCurrencyFrameFormedAmountChange(
  Sender: TObject);
begin
  inherited;
  MyCurrencyFrameForm.edAmountChange(Sender);
  ItogRecalc;
end;

end.
