unit frmPriceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  ExtCtrls, Menus, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  ActnList, dxBar, dxBarExtItems,
  cxControls, cxSplitter, StdCtrls, Buttons, cxContainer, cxEdit,
  cxCheckBox, AppEvnts, DateUtils, unCommonFunc, Math, FIB,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, dxSkinsdxBarPainter, cxTL, cxTLdxBarBuiltInMenu,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxInplaceContainer,
  cxTLData, cxDBTL, cxClasses, cxGridLevel, cxGridCustomView, cxGrid, cxMaskEdit,
  cxTextEdit, frxClass, frxDBSet, frxBarcode, System.UITypes, cxNavigator,
  System.Actions, cxButtons;

type
  TPriceListForm = class(TDBListForm)
    splMenu: TcxSplitter;
    Panel1: TPanel;
    Panel3: TPanel;
    btnRefreshChd: TBitBtn;
    btnInsChd: TBitBtn;
    btnUpdChd: TBitBtn;
    btnDelChd: TBitBtn;
    btnViewChd: TBitBtn;
    btnInsLike: TBitBtn;
    aViewChd: TAction;
    aInsChd: TAction;
    aInsLikeChd: TAction;
    aUpdChd: TAction;
    aDelChd: TAction;
    aRefreshChd: TAction;
    aInsChild: TAction;
    spReadTovar: TpFIBDataSet;
    dsReadTovar: TDataSource;
    aSetNotActive: TAction;
    BitBtn1: TBitBtn;
    spSetNotActive: TpFIBStoredProc;
    bcActive: TdxBarCombo;
    aPrintLabel: TAction;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Label10: TLabel;
    ApplicationEvents: TApplicationEvents;
    TimerChangeEd: TTimer;
    aNewPrice: TAction;
    dxBarButton2: TdxBarButton;
    BitBtn3: TBitBtn;
    aDelChdAll: TAction;
    spFindProduct: TpFIBStoredProc;
    tlCategory: TcxDBTreeList;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    lv1: TcxGridLevel;
    clmtv1G_PRODUCT: TcxGridDBColumn;
    clmtv1G_PRODUCT_PAR: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    clmtv1VOLUME_PRICE: TcxGridDBColumn;
    clmtv1MF_COUNTRY: TcxGridDBColumn;
    clmtv1AMOUNT: TcxGridDBColumn;
    clmtv1AMOUNT_RESERVE: TcxGridDBColumn;
    clmtv1AMOUNT_NA_REAL: TcxGridDBColumn;
    clmtv1PLACE: TcxGridDBColumn;
    clmtv1PackAmount: TcxGridDBColumn;
    clmnCategoryNAME: TcxDBTreeListColumn;
    edBarcode: TcxTextEdit;
    btClear: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aRefreshChdExecute(Sender: TObject);
    procedure aViewChdExecute(Sender: TObject);
    procedure aInsChdExecute(Sender: TObject);
    procedure aInsLikeChdExecute(Sender: TObject);
    procedure aUpdChdExecute(Sender: TObject);
    procedure aDelChdExecute(Sender: TObject);
    procedure aInsChildExecute(Sender: TObject);
    procedure aSetNotActiveExecute(Sender: TObject);
    procedure bcActiveChange(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure aPrintLabelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure aDelChdAllExecute(Sender: TObject);
    procedure tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvProductCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edBarcodePropertiesChange(Sender: TObject);
  private
    { Private declarations }
    ByScanner : Integer;   //инициация сканером
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FIns_Child : Integer;  //признак что вызывается INSDATA для создания дочерней записи
    FrefreshProdBook : boolean; // рефрешить товары с букмарком или нет, с букмарком надо только при нажатии на кнопку "Обновить"
    Is_closing : Boolean;       // форма закрывается в данный момент
    function CheckSelectedNode : Boolean;  //выбрана ли хоть одна запись
    procedure SelectGrProductNode;
    procedure WMInsChild(var Message: TMessage); message WM_INSCHILD;
  public
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  PriceListForm: TPriceListForm;
  onChangeCat : TcxTreeListFocusedNodeChangedEvent;

implementation

uses frmPriceListUn, frmCategory, frmDBEdit, frmPriceListRepFilter,
  dmReports, frmPrintEtiketSetup, unErrorHandlers;

{$R *.dfm}

procedure TPriceListForm.ReadList;
begin
  onChangeCat := tlCategory.OnFocusedNodeChanged;
  tlCategory.OnFocusedNodeChanged := nil;

  inherited;
  aView.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aDel.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aUpd.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aInsChild.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aInsLike.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);

  aRefreshChd.Execute;
  tlCategory.OnFocusedNodeChanged := onChangeCat;
end;

procedure TPriceListForm.ViewData;
begin
  ClassForm := TCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.InsData;
begin
  ClassForm := TCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    if FIns_Child = 1 then
      (ClassForm as TCategoryForm).leCategory.EditValue := spRead.FieldByName('g_product').AsInteger
    else
      (ClassForm as TCategoryForm).leCategory.Enabled := False;

    FIns_Child := 0;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.InsLikeData;
begin
  ClassForm := TCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.UpdData;
begin
  ClassForm := TCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Is_closing := True;

  inherited;
  tvProduct.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvProduct.name);
end;

procedure TPriceListForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'G_PRODUCT';
  KeyFieldClass := 'G_PRODUCT_';
  inherited;
  FIns_Child := 0;
end;

procedure TPriceListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить группу "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  inherited;
end;

procedure TPriceListForm.aRefreshChdExecute(Sender: TObject);
begin
  {if spReadTovar.Active then
    spReadTovar.Close;
  if spRead.FieldByName('G_PRODUCT').AsInteger = -1 then
    spReadTovar.SelectSQL.Text := 'SELECT  T.G_PRODUCT,' + #10#13 +
                                  'T.G_PRODUCT_PAR,' + #10#13 +
                                  'T.ARTICUL,' + #10#13 +
                                  'T.NOMENCLATUR_NUM,' + #10#13 +
                                  'T.BARCODE,' + #10#13 +
                                  'T.NAME,' + #10#13 +
                                  'T.PRICE,' + #10#13 +
                                  'T.VOLUME_PRICE,' + #10#13 +
                                  'T.PACK_AMOUNT,' + #10#13 +
                                  'T.MF_COUNTRY,' + #10#13 +
                                  'COALESCE(P.AMOUNT, 0) AMOUNT,' + #10#13 +
                                  'COALESCE(P.AMOUNT_RESERVE, 0) AMOUNT_RESERVE,' + #10#13 +
                                  'COALESCE((SELECT SUM(Z.AMOUNT_ALL - Z.AMOUNT_PAYED - COALESCE(Z.AMOUNT_RETURNED, 0))' + #10#13 +
                                              'FROM ZAKAZ_NA_REAL Z, ZAKAZ_REAL_PARENT ZP' + #10#13 +
                                             'WHERE Z.G_PRODUCT = T.G_PRODUCT AND Z.IS_PAYED_ALL = 0' + #10#13 +
                                               'AND ZP.ZAKAZ_REAL_PARENT = Z.ZAKAZ_REAL_PARENT' + #10#13 +
                                               'AND ZP.G_TOCHKA = :G_TOCHKA_), 0) AMOUNT_NA_REAL,' + #10#13 +
                                  'T.G_UNIT' + #10#13 +
                                  ',T.CROSSCODE' + #10#13 +
                                  ',T.IS_ACTIVE' + #10#13 +
                                  ',T.NOTE' + #10#13 +
                                  ',T.PLACE' + #10#13 +
                              'FROM (SELECT G.G_PRODUCT,' + #10#13 +
                                           'G.G_PRODUCT_PAR,' + #10#13 +
                                           'G.ARTICUL,' + #10#13 +
                                           'G.NOMENCLATUR_NUM,' + #10#13 +
                                           'G.BARCODE,' + #10#13 +
                                           'G.NAME,' + #10#13 +
                                           'G.PRICE,' + #10#13 +
                                           'G.VOLUME_PRICE,' + #10#13 +
                                           'G.PACK_AMOUNT,' + #10#13 +
                                           'G.MF_COUNTRY,' + #10#13 +
                                           'COALESCE(U.SHORT_NAME, U.NAME) G_UNIT' + #10#13 +
                                           ',G.CROSSCODE' + #10#13 +
                                           ',G.IS_ACTIVE' + #10#13 +
                                           ',G.NOTE' + #10#13 +
                                           ',G.PLACE' + #10#13 +
                                      'FROM G_PRODUCT G, G_UNIT U' + #10#13 +
                                     'WHERE G.IS_CATEGORY = 0' + #10#13 +
                                       'AND G.IS_ACTIVE = :IS_ACTIVE_' + #10#13 +
                                       'AND G.G_UNIT = U.G_UNIT' + #10#13 +
                                    'UNION ALL' + #10#13 +
                                    'SELECT T1.G_PRODUCT,' + #10#13 +
                                           'T1.G_PRODUCT_PAR,' + #10#13 +
                                           'T1.ARTICUL,' + #10#13 +
                                           'T1.NOMENCLATUR_NUM,' + #10#13 +
                                           'B.BARCODE,' + #10#13 +
                                           'T1.NAME||''(доп.штрихкод)'',' + #10#13 +
                                           'T1.PRICE,' + #10#13 +
                                           'T1.VOLUME_PRICE,' + #10#13 +
                                           'T1.PACK_AMOUNT,' + #10#13 +
                                           'T1.MF_COUNTRY,' + #10#13 +
                                           'COALESCE(U.SHORT_NAME, U.NAME) G_UNIT' + #10#13 +
                                           ',T1.CROSSCODE' + #10#13 +
                                           ',T1.IS_ACTIVE' + #10#13 +
                                           ',T1.NOTE' + #10#13 +
                                           ',T1.PLACE' + #10#13 +
                                      'FROM G_PRODUCT T1, LT_BARCODE B, G_UNIT U' + #10#13 +
                                     'WHERE IS_CATEGORY = 0' + #10#13 +
                                       'AND IS_ACTIVE = :IS_ACTIVE_' + #10#13 +
                                       'AND T1.G_UNIT = U.G_UNIT' + #10#13 +
                                       'AND B.G_PRODUCT = T1.G_PRODUCT) T LEFT OUTER JOIN LT_SKLAD_PRODUCT P ON T.G_PRODUCT = P.G_PRODUCT and P.G_TOCHKA = :G_TOCHKA_' + #10#13 +
                              'ORDER BY 6'
  ELSE
    spReadTovar.SelectSQL.Text := 'SELECT  T.G_PRODUCT,' + #10#13 +
                                  'T.G_PRODUCT_PAR,' + #10#13 +
                                  'T.ARTICUL,' + #10#13 +
                                  'T.NOMENCLATUR_NUM,' + #10#13 +
                                  'T.BARCODE,' + #10#13 +
                                  'T.NAME,' + #10#13 +
                                  'T.PRICE,' + #10#13 +
                                  'T.VOLUME_PRICE,' + #10#13 +
                                  'T.PACK_AMOUNT,' + #10#13 +
                                  'T.MF_COUNTRY,' + #10#13 +
                                  'COALESCE(P.AMOUNT, 0) AMOUNT,' + #10#13 +
                                  'COALESCE(P.AMOUNT_RESERVE, 0) AMOUNT_RESERVE,' + #10#13 +
                                  'COALESCE((SELECT SUM(Z.AMOUNT_ALL - Z.AMOUNT_PAYED - COALESCE(Z.AMOUNT_RETURNED, 0))' + #10#13 +
                                              'FROM ZAKAZ_NA_REAL Z, ZAKAZ_REAL_PARENT ZP' + #10#13 +
                                             'WHERE Z.G_PRODUCT = T.G_PRODUCT AND Z.IS_PAYED_ALL = 0' + #10#13 +
                                               'AND ZP.ZAKAZ_REAL_PARENT = Z.ZAKAZ_REAL_PARENT' + #10#13 +
                                               'AND ZP.G_TOCHKA = :G_TOCHKA_), 0) AMOUNT_NA_REAL,' + #10#13 +
                                  'T.G_UNIT' + #10#13 +
                                  ',T.CROSSCODE' + #10#13 +
                                  ',T.IS_ACTIVE' + #10#13 +
                                  ',T.NOTE' + #10#13 +
                                  ',T.PLACE' + #10#13 +
                              'FROM (SELECT G.G_PRODUCT,' + #10#13 +
                                           'G.G_PRODUCT_PAR,' + #10#13 +
                                           'G.ARTICUL,' + #10#13 +
                                           'G.NOMENCLATUR_NUM,' + #10#13 +
                                           'G.BARCODE,' + #10#13 +
                                           'G.NAME,' + #10#13 +
                                           'G.PRICE,' + #10#13 +
                                           'G.VOLUME_PRICE,' + #10#13 +
                                           'G.PACK_AMOUNT,' + #10#13 +
                                           'G.MF_COUNTRY,' + #10#13 +
                                           'COALESCE(U.SHORT_NAME, U.NAME) G_UNIT' + #10#13 +
                                           ',G.CROSSCODE' + #10#13 +
                                           ',G.IS_ACTIVE' + #10#13 +
                                           ',G.NOTE' + #10#13 +
                                           ',G.PLACE' + #10#13 +
                                      'FROM G_PRODUCT G, G_UNIT U' + #10#13 +
                                     'WHERE G.IS_CATEGORY = 0' + #10#13 +
                                       'AND G.IS_ACTIVE = :IS_ACTIVE_' + #10#13 +
                                       'AND G.G_UNIT = U.G_UNIT' + #10#13 +
                                    'UNION ALL' + #10#13 +
                                    'SELECT T1.G_PRODUCT,' + #10#13 +
                                           'T1.G_PRODUCT_PAR,' + #10#13 +
                                           'T1.ARTICUL,' + #10#13 +
                                           'T1.NOMENCLATUR_NUM,' + #10#13 +
                                           'B.BARCODE,' + #10#13 +
                                           'T1.NAME||''(доп.штрихкод)'',' + #10#13 +
                                           'T1.PRICE,' + #10#13 +
                                           'T1.VOLUME_PRICE,' + #10#13 +
                                           'T1.PACK_AMOUNT,' + #10#13 +
                                           'T1.MF_COUNTRY,' + #10#13 +
                                           'COALESCE(U.SHORT_NAME, U.NAME) G_UNIT' + #10#13 +
                                           ',T1.CROSSCODE' + #10#13 +
                                           ',T1.IS_ACTIVE' + #10#13 +
                                           ',T1.NOTE' + #10#13 +
                                           ',T1.PLACE' + #10#13 +
                                      'FROM G_PRODUCT T1, LT_BARCODE B, G_UNIT U' + #10#13 +
                                     'WHERE IS_CATEGORY = 0' + #10#13 +
                                       'AND IS_ACTIVE = :IS_ACTIVE_' + #10#13 +
                                       'AND T1.G_UNIT = U.G_UNIT' + #10#13 +
                                       'AND B.G_PRODUCT = T1.G_PRODUCT) T LEFT OUTER JOIN LT_SKLAD_PRODUCT P ON T.G_PRODUCT = P.G_PRODUCT and P.G_TOCHKA = :G_TOCHKA_' + #10#13 +
                              'WHERE T.G_PRODUCT_PAR = 4' + #10#13 +
                              'ORDER BY 6'; }

  spReadTovar.ParamByName('g_product_par_').AsInteger := spRead.FieldByName('G_PRODUCT').AsInteger;
  spReadTovar.ParamByName('g_tochka_').AsInteger := CurSklad;
  if bcActive.ItemIndex = 0 then
    spReadTovar.ParamByName('is_active_').AsInteger := 1
  else
    spReadTovar.ParamByName('is_active_').AsInteger := 0;

  Screen.Cursor := crSQLWait;
  OpenSP(spReadTovar, FrefreshProdBook);
  SelectGrProductNode;
  Screen.Cursor := crDefault;

  aViewChd.Enabled := spReadTovar.RecordCount > 0;
  //aInsChd.Enabled  := (spRead.RecordCount > 1) and (spRead.FieldByName('g_product').AsInteger <> -1);;      //кнопка добавить товар доступна, если есть хоть одна родительская категория, но это не "Все товары"
  aInsLikeChd.Enabled := (spReadTovar.RecordCount > 0);
  aUpdChd.Enabled := spReadTovar.RecordCount > 0;
  aDelChd.Enabled := spReadTovar.RecordCount > 0;
  aDelChdAll.Enabled := spReadTovar.RecordCount > 0;  
  aSetNotActive.Enabled := spReadTovar.RecordCount > 0;
  aPrintLabel.Enabled := spReadTovar.RecordCount > 0;
  aNewPrice.Enabled := spReadTovar.RecordCount > 0;
  dxBarStaticRecCnt.Caption := IntToStr(spReadTovar.RecordCount);
end;

procedure TPriceListForm.aViewChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  if CheckSelectedNode = False then
    Exit;

  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omView;
    PriceListUnForm.RecID := spReadTovar.FieldByName('g_product').AsInteger;
    PriceListUnForm.ShowModal;
  finally
    PriceListUnForm.Free;
  end;
end;

procedure TPriceListForm.aInsChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omInsert;
    PriceListUnForm.Id_Category := spRead.FieldByName('g_product').AsInteger;
    // если KeysBuffer не пустой, то значит процедура вызвана сканером штрихкода,
    // то передаю его в форму PriceListUnForm и подставляю как штрихкод
    if ByScanner = 1 then
      PriceListUnForm.BARCODE := KeysBuffer;

    if PriceListUnForm.ShowModal = mrOk then
    begin
      aRefreshChd.Execute;
      spReadTovar.Locate('g_product', PriceListUnForm.RecID, []);
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

procedure TPriceListForm.aInsLikeChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  if CheckSelectedNode = False then
    Exit;

  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omInsertLike;
    PriceListUnForm.RecID := spReadTovar.FieldByName('g_product').AsInteger;
    // если старому товару меняется цена, то создается новый товар, с новым артикулом и новой ценой
    if (Sender as TAction).Name = 'aNewPrice' then
      PriceListUnForm.G_PROD_FOR_NEW_PRICE := spReadTovar.FieldByName('g_product').AsInteger;
    if PriceListUnForm.ShowModal = mrOk then
    begin
      aRefreshChd.Execute;
      spReadTovar.Locate('g_product', PriceListUnForm.RecID, []);
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

procedure TPriceListForm.aUpdChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  // если грид пустой и поле edBarcode.Text не пустое то значит будет вызываться форма для добавления товара через сканер штрихкода
  if (tvProduct.Controller.SelectedRowCount = 0) and (edBarcode.Text <> '') then begin
    aInsChd.Execute;
    Exit;
  end;

  if CheckSelectedNode = False then
    Exit;

  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omUpdate;
    PriceListUnForm.RecID := spReadTovar.FieldByName('g_product').AsInteger;
    if PriceListUnForm.ShowModal = mrOk then
    begin
      aRefreshChd.Execute;
      spReadTovar.Locate('g_product', PriceListUnForm.RecID, []);
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

procedure TPriceListForm.aDelChdExecute(Sender: TObject);
var i : integer;
    str : string;
begin
  if CheckSelectedNode = False then
    Exit;

  if tvProduct.Controller.SelectedRowCount > 1 then
    str := 'группу товаров?'
  else
    str := 'товар "%s"?';

  if MessageDlg(Format('Удалить '+ str,
    [spReadTovar.FieldByName('NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  for i := 0 to tvProduct.Controller.SelectedRowCount - 1 do begin
    spDel.ParamByName('g_product_').AsInteger := tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index];
    if not ExecSPTR(spDel) then begin
      aRefreshChd.Execute;
      Exit;
    end;
  end;

  aRefreshChd.Execute;
end;

procedure TPriceListForm.aDelChdAllExecute(Sender: TObject);
begin
  if MessageDlg('Удалить все товары категории?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spReadTovar.First;
  while not spReadTovar.Eof do begin
    spDel.ParamByName('g_product_').AsInteger := spReadTovar.FieldByName('g_product').AsInteger;
    if not ExecSPTR(spDel) then begin
      aRefreshChd.Execute;
      Exit;
    end;
    spReadTovar.Next;
  end;

  aRefreshChd.Execute;
end;

procedure TPriceListForm.aInsChildExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_INSCHILD, 0, 0);
end;

procedure TPriceListForm.WMInsChild(var Message: TMessage);
begin
  FIns_Child := 1;
  InsData;
end;

procedure TPriceListForm.aSetNotActiveExecute(Sender: TObject);
begin
  if CheckSelectedNode = False then
    Exit;

  if MessageDlg(Format('Изменить признак активности товара "%s" ?',
    [spReadTovar.FieldByName('NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spSetNotActive.ParamByName('g_product_').AsInteger := spReadTovar.FieldByName('g_product').AsInteger;
  IF spReadTovar.FieldByName('IS_ACTIVE').AsInteger = 0 THEN
    spSetNotActive.ParamByName('IS_ACTIVE_').AsInteger := 1
  ELSE BEGIN
    //НЕЛЬЗЯ СДЕЛАТЬ НЕАКТИВНЫМ, ЕСЛИ ЕСТЬ ТОВАР НА СКЛАДЕ ИЛИ НА РЕАЛИЗАЦИИ
    {
    зачем??? убрал
    if (spReadTovar.FieldByName('amount').AsFloat > 0) or (spReadTovar.FieldByName('AMOUNT_NA_REAL').AsFloat > 0) then begin
      MessageDlg('Товар еше есть на складе или отдан под реализацию. Сделать неактивным невозможно!', mtInformation, [mbOk], 0);
      Exit;
    end;}
    spSetNotActive.ParamByName('IS_ACTIVE_').AsInteger := 0;
  END;

  if not spSetNotActive.Transaction.InTransaction then
    spSetNotActive.Transaction.StartTransaction;

  if ExecSP(spSetNotActive) then begin
    if spSetNotActive.Transaction.InTransaction then
      spSetNotActive.Transaction.Commit;
    aRefreshChd.Execute;
  end;
end;

procedure TPriceListForm.bcActiveChange(Sender: TObject);
begin
  Readlist;
end;

procedure TPriceListForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  tvProduct.Controller.Customization := True;
end;

procedure TPriceListForm.aPrintLabelExecute(Sender: TObject);
var PrintEtiketSetupForm : TPrintEtiketSetupForm;
    SloganOrPrice : integer;
    sql_str : string;
begin
  //если программа не активирована, то не буду давать делать этикетки
  if IsActivated = 0 then begin
    MessageDlg('Программа не активирована! Включены ограничения. Печать этикеток невозможна.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if CheckSelectedNode = False then
    Exit;
  try
    PrintEtiketSetupForm := TPrintEtiketSetupForm.Create(Application);
    if PrintEtiketSetupForm.ShowModal = mrOk then begin
      sql_str := 'WITH RECURSIVE TREE AS (SELECT g.name, g.barcode, TRUNC(g.price) PRICE, 1 levl' +
                          ' FROM G_PRODUCT g' +
                         ' WHERE g.g_product = ' + spReadTovar.FieldByName('g_product').AsString +
                        ' UNION ALL' +
                        ' SELECT g.name, g.barcode, TRUNC(g.price) PRICE, gg.levl + 1 levl' +
                          ' FROM G_PRODUCT g INNER JOIN TREE GG ON GG.name = g.name' +
                         ' WHERE g.g_product = ' + spReadTovar.FieldByName('g_product').AsString +
                           ' and gg.levl < ' + PrintEtiketSetupForm.edAmount.Text +
                          ' )' +
                 ' SELECT * FROM TREE';

      //короче такая тема - делалось все на скорях 20.09.2016, одному клиенту не нужна была цена на ценике, поэтому просто добавил строку "Цена и слоган" третьим пунктом в cbSloganOrPrice
      //а в ReportsDM.PrintLabel как-раз печатается и цена и слоган, если SloganOrPrice = -1, соответственно тут буду переводить, если cbSloganOrPrice.ItemIndex = 2, то SloganOrPrice = -1
      ReportsDM.PrintLabel(PrintEtiketSetupForm.cbPrinters.Text,
                          Integer(PrintEtiketSetupForm.rbPrint.Checked),
                          sql_str,
                          PrintEtiketSetupForm.cbChooseLentWidth.ItemIndex,
                          Integer(PrintEtiketSetupForm.cbPrintPrice.checked),
                          Integer(PrintEtiketSetupForm.cbPriceBold.checked),
                          Integer(PrintEtiketSetupForm.spnPriceSize.Value),
                          Integer(PrintEtiketSetupForm.cbPrintSlogan.checked),
                          Integer(PrintEtiketSetupForm.cbSloganBold.checked),
                          Integer(PrintEtiketSetupForm.spnSloganSize.Value),
                          PrintEtiketSetupForm.edSlogan.text,
                          StrToInt(PrintEtiketSetupForm.edAmount.text),
                          SloganOrPrice,
                          spReadTovar.FieldByName('Barcode').AsString,
                          spReadTovar.FieldByName('name').AsString,
                          spReadTovar.FieldByName('price').AsString,
                          Integer(PrintEtiketSetupForm.cbNameBold.checked),
                          Integer(PrintEtiketSetupForm.spnNameSize.Value));
    end;
  finally
    PrintEtiketSetupForm.free;
  end;
end;

procedure TPriceListForm.edBarcodePropertiesChange(Sender: TObject);
begin
  TimerChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    TimerChangeEd.Enabled := True
  else BEGIN
    with spReadTovar do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TPriceListForm.SelectGrProductNode;
begin
  if tvProduct.Controller.FocusedRow <> Nil then begin
    if tvProduct.Controller.SelectedRowCount > 0 then
      tvProduct.Controller.SelectedRows[0].Selected := False;
    tvProduct.Controller.FocusedRow.Selected := True;
  end;
end;

function TPriceListForm.CheckSelectedNode : Boolean;
begin
  Result := False;

  if tvProduct.Controller.SelectedRowCount = 0 then begin
    MessageDlg('Вы не выбрали ни одного товара! Выберите товар!', mtWarning, [mbOk], 0);
    edBarcode.Clear;
    spReadTovar.Filter := '';
    spReadTovar.Filtered := False;
    Exit;
  end;

  Result := True;
end;

procedure TPriceListForm.FormShow(Sender: TObject);
begin
  inherited;
  ActiveListControl := grProduct;
  FrefreshProdBook := True;  // не ставить Bookmark при обновлении по событию tlCategoryFocusedNodeChanged
  ByScanner := 0;
  tlCategory.SetFocus;

  tvProduct.RestoreFromIniFile('Settings.ini', True, False, [], Self.Name + '-' + tvProduct.name);

  // если конфигурация магазин, то эти колонки не нужны
  if Config <> 1 then begin
    clmtv1PackAmount.Destroy;
    clmtv1MF_COUNTRY.Destroy;
  end;

  aIns.Caption := 'Добавить группу';
  aUpd.Caption := 'Изменить группу';
  aDel.Caption := 'Удалить группу';
end;

procedure TPriceListForm.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var N : integer;
    barcode : string;
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

            // если штрихкод начинается на ScalesPrefix, то надо очистить 5 цифр отвечающих за вес
            if Copy(KeysBuffer, 1, 2) = ScalesPrefix then begin
              barcode := Copy(KeysBuffer, 1, 7) + '00000';
              N := (StrToInt(Copy(KeysBuffer, 2, 1))+
                   StrToInt(Copy(KeysBuffer, 4, 1))+
                   StrToInt(Copy(KeysBuffer, 6, 1))+
                   StrToInt(Copy(KeysBuffer, 8, 1))+
                   StrToInt(Copy(KeysBuffer, 10, 1))+
                   StrToInt(Copy(KeysBuffer, 12, 1))
                  ) * 3+
                   StrToInt(Copy(KeysBuffer, 1, 1))+
                   StrToInt(Copy(KeysBuffer, 3, 1))+
                   StrToInt(Copy(KeysBuffer, 5, 1))+
                   StrToInt(Copy(KeysBuffer, 7, 1))+
                   StrToInt(Copy(KeysBuffer, 9, 1))+
                   StrToInt(Copy(KeysBuffer, 11, 1));

              N := N MOD 10;
              IF N > 0 THEN
                N := 10 - N;

              KeysBuffer := barcode + IntToStr(N);
            end;

            //проверяю, вдруг такой товар уже есть, тогда вызываю апдейт
            onChangeCat := tlCategory.OnFocusedNodeChanged;
            tlCategory.OnFocusedNodeChanged := nil;
            try
              spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
              if not spFindProduct.Transaction.InTransaction then
                spFindProduct.Transaction.StartTransaction;
              spFindProduct.ExecProc;
              if spFindProduct.Transaction.InTransaction then
                spFindProduct.Transaction.Commit;
            except
              on E: EFIBError do begin
                tlCategory.OnFocusedNodeChanged := onChangeCat;
                if spFindProduct.Transaction.InTransaction then
                  spFindProduct.Transaction.Rollback;
                DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBListForm.DelData)');
              end;
              on E: Exception do begin
                tlCategory.OnFocusedNodeChanged := onChangeCat;
                if spFindProduct.Transaction.InTransaction then
                  spFindProduct.Transaction.Rollback;
                MessageDlg(E.Message + #13#10'(occured in TDBListForm.DelData)', mtError, [mbOk], 0);
              end;
            end;
            IF spFindProduct.ParamByName('g_product_').AsInteger > 0 THEN BEGIN
              spRead.Locate('g_product', spFindProduct.ParamByName('g_product_category_').AsInteger, []);
              spReadTovar.ParamByName('g_product_par_').AsInteger := spRead.FieldByName('g_product').AsInteger;
              spReadTovar.ParamByName('g_tochka_').AsInteger := CurSklad;
              OpenSp(spReadTovar, False);
              spReadTovar.Locate('g_product', spFindProduct.ParamByName('G_PRODUCT_').AsInteger, []);
              if tvProduct.Controller.FocusedRow <> Nil then begin
                if tvProduct.Controller.SelectedRowCount > 0 then
                  tvProduct.Controller.SelectedRows[0].Selected := False;
                tvProduct.Controller.FocusedRow.Selected := True;
              end;
              aUpdChd.Execute;
            END else begin
              ByScanner := 1;
              aInsChd.execute;
              ByScanner := 0;
            end;
            tlCategory.OnFocusedNodeChanged := onChangeCat;
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

procedure TPriceListForm.TimerChangeEdTimer(Sender: TObject);
var s: string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spReadTovar do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (NOMENCLATUR_NUM CONTAINING ''' + edBarcode.text +
           ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''') OR (CROSSCODE CONTAINING '''+ edBarcode.text + ''')';

      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edBarcode.text + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    SelectGrProductNode;
  END;
end;

procedure TPriceListForm.tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  inherited;
  aView.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aDel.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aUpd.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aInsChild.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);
  aInsLike.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsInteger <> -1);

  // если форма не открывается-закрывается, то вызываю
  if not Is_closing then begin
    FrefreshProdBook := False;
    aRefreshChd.Execute;
    FrefreshProdBook := True;
  end;
end;

procedure TPriceListForm.tvProductCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aUpdChd.Execute;
end;

procedure TPriceListForm.btClearClick(Sender: TObject);
begin
  edBarcode.Clear;
  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;
end;

procedure TPriceListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 5;
  Application.HelpContext(5);
  inherited;
end;

end.
