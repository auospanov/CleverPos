unit PriceListUnSostav;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, AppEvnts, ExtCtrls, StdCtrls,
  Buttons, FIBDatabase, pFIBDatabase, DB, FIBDataSet, pFIBDataSet,
  frmMyCurrencyFrame,
  cxControls, cxSplitter, unCommonFunc, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxContainer, cxTL, cxMaskEdit,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxDBTL, cxTLData, cxTextEdit,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxNavigator,
  Vcl.Menus, cxButtons, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TPriceListUnSostavForm = class(TDlgForm)
    cxspltrMenu: TcxSplitter;
    pn1: TPanel;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    lb2: TLabel;
    shp3: TShape;
    shp4: TShape;
    spReadCategory: TpFIBDataSet;
    dsReadCategory: TDataSource;
    dsRead: TDataSource;
    tranRead: TpFIBTransaction;
    Panel4: TPanel;
    Label10: TLabel;
    sbClear: TSpeedButton;
    edBarcode: TEdit;
    tmrChangeEd: TTimer;
    spRead: TpFIBDataSet;
    lb3: TLabel;
    shp5: TShape;
    shp6: TShape;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    lv1: TcxGridLevel;
    edPrice: TcxCurrencyEdit;
    edPriceVol: TcxCurrencyEdit;
    tlCategory: TcxDBTreeList;
    clmnCategoryNAME: TcxDBTreeListColumn;
    btHelp: TcxButton;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    edVolume: TcxTextEdit;
    btnCalc: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure tmrChangeEdTimer(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure grProductDblClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure tvProductFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvProductCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnCalcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FId : Int64;
    FTyp : Integer;
    FExceptId : Int64;
    FAmount : String;
    FPrice : String;
    procedure RefreshPrice;
  public
    property Id : Int64 read FId write FId;
    property ExceptId : Int64 read FExceptId write FExceptId;
    property Amount : String read FAmount write FAmount;
    property Price : String read FPrice write FPrice;
    property Typ : Integer read FTyp write FTyp;   //1 - составной товар, 2 - продукт, 3 - продукт из продуктов
  end;

var
  PriceListUnSostavForm: TPriceListUnSostavForm;

implementation

uses
  dmMain, frmSostavCalc;

{$R *.dfm}

procedure TPriceListUnSostavForm.FormCreate(Sender: TObject);
begin
  inherited;

  SPLazyLoadEnable(spRead, tvProduct);
end;

procedure TPriceListUnSostavForm.FormShow(Sender: TObject);
var onChangeCat : TcxTreeListFocusedNodeChangedEvent;
begin
  inherited;

  onChangeCat := tlCategory.OnFocusedNodeChanged;
  tlCategory.OnFocusedNodeChanged := nil;
  OpenSp(spReadCategory, False);
  tlCategory.OnFocusedNodeChanged := onChangeCat;

  if FTyp = 100 then begin
    lb2.Visible := False;
    shp3.Visible := False;
    lb3.Visible := False;
    shp5.Visible := False;
    shp4.Visible := False;
    edPrice.Visible := False;
    shp6.Visible := False;
    edPriceVol.Visible := False;
    Label1.Visible := False;
    Shape1.Visible := False;
    Shape2.Visible := False;
    edVolume.Visible := False;
    btnCalc.Visible := False;

    spRead.SelectSQL.Text := 'select gr.g_product, name, articul, barcode, nomenclatur_num, pack_amount, price, volume_price '+
                              'from g_product gr '+
                              'where is_kit in (2,3) '+
                              'and gr.G_PRODUCT_PAR = DECODE(CAST(:G_PRODUCT_PAR_ AS BIGINT), -1, gr.G_PRODUCT_PAR, CAST(:G_PRODUCT_PAR_ AS BIGINT)) '+
                              'ORDER BY NAME, g_product';
  end else begin
    spRead.ParamByName('EXCEPT_PROD_').AsInt64 := FExceptId;

    {if FTyp in [1,2] then
      spRead.SQLs.SelectSQL.Text := spRead.SQLs.SelectSQL.Text + ' AND T.is_kit = 0'  // составные товары и полуфабрикаты могут состо€ть только из простых товаров, только они могут входить в состав набора
    else if FTyp = 3 then
      spRead.SQLs.SelectSQL.Text := spRead.SQLs.SelectSQL.Text + ' AND T.is_kit in (0, 2)'; // составной продукт (например пирожок) может состо€ть из полуфабрикатов и простых товаров
    }

    {if FTyp = 2 then begin
      lb2.Visible := False;
      shp3.Visible := False;
      lb3.Visible := False;
      shp5.Visible := False;
      shp4.Visible := False;
      edPrice.Visible := False;
      shp6.Visible := False;
      edPriceVol.Visible := False;
    end;}

    spRead.SQLs.SelectSQL.Text := spRead.SQLs.SelectSQL.Text + ' order by 4';
  end;

  spRead.ParamByName('G_PRODUCT_PAR_').AsInt64 := spReadCategory.fieldByName('g_product').AsLargeInt;
  OpenSp(spRead, False);
  if FId > 0 then begin
    spRead.Locate('g_product', FId, []);
    if Assigned(tvProduct.Controller.FocusedRow) then
      tvProduct.Controller.FocusedRow.Selected := True;
  end;
  RefreshPrice;

  if FAmount <> '' then
    MyCurrencyFrameForm.edAmount.Text := FAmount;

  if FPrice <> '' then
    edPrice.Value := StrToFloat(FPrice);
end;

procedure TPriceListUnSostavForm.tmrChangeEdTimer(Sender: TObject);
var s : string;
begin
  tmrChangeEd.Enabled := False;
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
    RefreshPrice;
  END;
end;

procedure TPriceListUnSostavForm.tvProductCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  btnOk.Click;
end;

procedure TPriceListUnSostavForm.tvProductFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  RefreshPrice;
end;

procedure TPriceListUnSostavForm.edBarcodeChange(Sender: TObject);
begin
  tmrChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    tmrChangeEd.Enabled := True
  else BEGIN
    with spRead do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TPriceListUnSostavForm.sbClearClick(Sender: TObject);
begin
  edBarcode.Clear;
  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;
  RefreshPrice;
end;

procedure TPriceListUnSostavForm.RefreshPrice;
begin
  MyCurrencyFrameForm.edAmount.Text := '1';

  if (AppName = 'shopuchet') then begin
    if spRead.fieldByName('PACK_AMOUNT').AsFloat > 0 then
      edVolume.Text := spRead.fieldByName('PACK_AMOUNT').AsString
    else
      edVolume.Text := 'Ќе задано';
  end;

  //if FTyp <> 2 then begin
    edPrice.Value := spRead.fieldByName('price').AsFloat;
    edPriceVol.Value := spRead.fieldByName('volume_price').AsFloat;
  //end else begin
  //  edPrice.Value := 0;
  //  edPriceVol.Value := 0;
  //end;
end;

procedure TPriceListUnSostavForm.grProductDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TPriceListUnSostavForm.tlCategoryFocusedNodeChanged(
  Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  Screen.Cursor := crHourGlass;
  spRead.ParamByName('g_product_par_').AsInt64 := spReadCategory.FieldByName('g_product').AsLargeInt;
  OpenSp(spRead, False);

  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;
  RefreshPrice;
  Screen.Cursor := crDefault;
end;

procedure TPriceListUnSostavForm.btnCalcClick(Sender: TObject);
var SostavCalcForm: TSostavCalcForm;
begin
  SostavCalcForm := TSostavCalcForm.Create(Self);
  try
    SostavCalcForm.MyCurrencyFrameForm.edAmount.Text := FloatToStr(MyCurrencyFrameForm.Value);
    SostavCalcForm.edPriceAll.Value := spRead.FieldByName('price').AsFloat * MyCurrencyFrameForm.Value;
    SostavCalcForm.edPriceVolAll.Value := spRead.FieldByName('volume_price').AsFloat * MyCurrencyFrameForm.Value;

    if SostavCalcForm.ShowModal = mrOk then begin
      edPrice.Value := SostavCalcForm.edPrice.Value;
      edPriceVol.Value := SostavCalcForm.edPriceVol.Value;
    end;
  finally
    SostavCalcForm.Free;
  end;
end;

procedure TPriceListUnSostavForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(69);
end;

end.
