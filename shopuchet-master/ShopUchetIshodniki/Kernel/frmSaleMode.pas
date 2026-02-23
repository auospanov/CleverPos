unit frmSaleMode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  FIBDataSet, pFIBDataSet, ExtCtrls, Menus, FIBDatabase, pFIBDatabase,
  ActnList, dxBar, dxBarExtItems, StdCtrls, fib,
  Buttons, unCommonFunc, Math, Clipbrd, AppEvnts, DateUtils, StrUtils,
  IniFiles, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxSpinButton, Mask, cxCurrencyEdit, frmMyCurrencyFrame, ComCtrls,
  frmDBEdit, cxLookAndFeelPainters, cxButtons, ToolWin,
  cxGraphics, cxLookAndFeels, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, dxSkinsdxBarPainter, cxTL,
  cxTLdxBarBuiltInMenu, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxInplaceContainer, cxDBTL, cxTLData, cxClasses, cxGridLevel,
  cxGridCustomView, cxGrid, cxCheckBox, cxControls, cxSplitter, System.UITypes,
  cxNavigator, System.Actions, cxEditRepositoryItems, dmReports, frmPopupOfficialList,
  frmPopupClientListSaleMode, dxLayoutControlAdapters, dxLayoutContainer,
  dxLayoutControl, dxLayoutcxEditAdapters, jpeg, pngimage, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  dxLayoutLookAndFeels;

const
  spReadTovarSQl = 'SELECT '+
                   ' T.G_PRODUCT, '+
                   ' T.ARTICUL, '+
                   ' T.BARCODE, '+
                   ' T.NOMENCLATUR_NUM, '+
                   ' T.NAME, '+
                   ' T.PRICE, '+
                   ' T.VOLUME_PRICE, '+
                   ' T.PACK_AMOUNT, '+
                   ' COALESCE(P.AMOUNT, 0) - COALESCE(P.AMOUNT_RESERVE, 0) AMOUNT, '+
                   ' T.CROSSCODE, '+
                   ' T.NOTE, '+
                   ' T.PLACE, '+
                   ' T.IS_KIT, '+
                   ' T.IS_CATEGORY, '+
                   ' T.IS_MARKED, '+
                   ' T.BRAND, '+
                   ' T.IS_WEIGHT, '+
                   ' T.VES_GRAMM, '+
                   ' T.VES_GRAMM_PRICE '+
               ' FROM (SELECT C.G_PRODUCT, '+
                '          G_PRODUCT_PAR, '+
                 '         '''' ARTICUL, '+
                 '         '''' BARCODE, '+
                 '         '''' NOMENCLATUR_NUM, '+
                 '         C.NAME, '+
                 '         0 PRICE, '+
                 '         0 VOLUME_PRICE, '+
                 '         0 PACK_AMOUNT, '+
                 '         '''' CROSSCODE, '+
                 '         '''' NOTE, '+
                 '         '''' PLACE, '+
                  '        0 IS_KIT, '+
                  '        C.IS_CATEGORY, '+
                  '        C.IS_MARKED, '+
                  '        C.IS_WEIGHT, '+
                  '        C.BRAND, '+
                  '        C.VES_GRAMM, '+
                  '        C.VES_GRAMM_PRICE '+
                  '    FROM G_PRODUCT C '+
                  '    WHERE C.IS_CATEGORY = 1 '+
                  '    AND C.DO_NOT_SHOW_RMK = 0 '+
                  '    AND :KAFE_VIEW_ = 1 '+
                  '    UNION ALL '+
                  '    SELECT G_PRODUCT, '+
                  '           G_PRODUCT_PAR, '+
                  '           ARTICUL, '+
                  '           BARCODE, '+
                  '           NOMENCLATUR_NUM, '+
                  '           NAME, '+
                  '           PRICE, '+
                  '           VOLUME_PRICE, '+
                  '           PACK_AMOUNT '+
                  '           ,CROSSCODE  '+
                  '           ,NOTE '+
                  '           ,PLACE '+
                  '           ,IS_KIT '+
                  '           ,IS_CATEGORY '+
                  '           ,IS_MARKED '+
                  '           ,IS_WEIGHT '+
                  '           ,BRAND '+
                  '           ,VES_GRAMM '+
                  '           ,VES_GRAMM_PRICE '+
                  '      FROM G_PRODUCT '+
                  '     WHERE IS_CATEGORY = 0 '+
                  '       AND IS_ACTIVE = 1 '+
                  '    UNION ALL  '+
                  '    SELECT T1.G_PRODUCT, '+
                  '           T1.G_PRODUCT_PAR, '+
                  '           T1.ARTICUL,  '+
                  '           B.BARCODE, '+
                  '           NOMENCLATUR_NUM, '+
                  '           T1.NAME||'' (доп.штрихкод)'', '+
                  '           T1.PRICE,  '+
                  '           T1.VOLUME_PRICE, '+
                  '           T1.PACK_AMOUNT  '+
                  '           ,T1.CROSSCODE '+
                  '           ,T1.NOTE   '+
                  '           ,T1.PLACE   '+
                  '           ,T1.IS_KIT  '+
                  '           ,T1.IS_CATEGORY  '+
                  '           ,T1.IS_MARKED '+
                  '           ,T1.IS_WEIGHT  '+
                  '           ,T1.BRAND     '+
                  '           ,T1.VES_GRAMM '+
                  '           ,T1.VES_GRAMM_PRICE  '+
                  '      FROM G_PRODUCT T1, LT_BARCODE B '+
                  '     WHERE IS_CATEGORY = 0  '+
                  '       AND IS_ACTIVE = 1  '+
                  '       AND B.G_PRODUCT = T1.G_PRODUCT) T LEFT OUTER JOIN (SELECT G_PRODUCT, AMOUNT, AMOUNT_RESERVE FROM LT_SKLAD_PRODUCT WHERE G_TOCHKA = :G_TOCHKA_)  P ON T.G_PRODUCT = P.G_PRODUCT';

type
  TTovar = record
    Product : Int64;
    Product_Par : Int64;
    Price : Double;
    Amount : Double;
    Summ : Double;
    SkidkaProc : Double;
    SkidkaVal  : Double;
    SkidkaSumm : Double;
    cbPrice    : Integer;
    cbSkidka   : Integer;
    CostPrice  : Double;
    Ostatok    : Double;
    IsKit      : Integer;
    Barcode    : string;
    IsMarked   : Integer;
    MarkCode   : string;
    IsTovarVes : Integer;
    VesGramm   : Double;
    VesGrammPrice : Double;
  end;

  TPutAsideSpis = record
    Num    : Integer;
    Client : Int64;
    Tovar  : array of TTovar;
    Summ   : Double;
    HintS  : String;
  end;

  TSaleModeForm = class(TDBListForm)
    spReadTmp: TpFIBDataSet;
    dsReadTmp: TDataSource;
    dsReadTovar: TDataSource;
    Panel3: TPanel;
    pnRight: TPanel;
    pnTovar: TPanel;
    splMenu: TcxSplitter;
    aRefreshChild: TAction;
    aDoSale: TAction;
    spInsZakaz: TpFIBStoredProc;
    spPostavshik: TpFIBDataSet;
    dsPostavshik: TDataSource;
    aFindAndIns: TAction;
    spFindProduct: TpFIBStoredProc;
    spInsProduct: TpFIBStoredProc;
    spGetData: TpFIBStoredProc;
    ApplicationEvents: TApplicationEvents;
    TimerSearch: TTimer;
    aGetDCard: TAction;
    aDelAll: TAction;
    dxBarButton2: TdxBarButton;
    spReadTovar: TpFIBDataSet;
    GetLastPrice: TpFIBStoredProc;
    aFindAnalog: TAction;
    dxBarStaticCnt: TdxBarStatic;
    pnOfficial: TPanel;
    lbOfficial: TLabel;
    pn3: TPanel;
    lb2: TLabel;
    edSearch: TEdit;
    aInsTov: TAction;
    pn4: TPanel;
    pn7: TPanel;
    pn5: TPanel;
    pn8: TPanel;
    pn9: TPanel;
    lbPrice: TLabel;
    aShowPanelTovar: TAction;
    pn11: TPanel;
    lbSumm: TLabel;
    pnWithBottomButtons: TPanel;
    pnButtonsLeft: TPanel;
    pnButtonsRight: TPanel;
    aFindDlg: TAction;
    aReturn: TAction;
    splButton: TcxSplitter;
    spGetSkidka: TpFIBStoredProc;
    pn10: TPanel;
    btnFindDlg: TcxButton;
    btnReturn: TcxButton;
    btnFindAnalog: TcxButton;
    cbByRecipe: TcxCheckBox;
    aInsFirst: TAction;
    btnClearSearch: TcxButton;
    aClearSearch: TAction;
    aTovarAmountBySklad: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    aPutAside: TAction;
    pmPutAsideSpis: TPopupMenu;
    aGetAside: TAction;
    aGetAsideWindow: TAction;
    spUpdZakazDetailsTmpPrices: TpFIBStoredProc;
    Panel1: TPanel;
    lbClient: TLabel;
    Panel4: TPanel;
    cxButton2: TcxButton;
    btnGetDCard: TcxButton;
    btnSetOfficialDefault: TcxButton;
    aSetOfficialDefault: TAction;
    lbTovarov: TLabel;
    lbNaimenovanii: TLabel;
    peOfficial: TcxPopupEdit;
    pnlTovarMain: TPanel;
    ScrollBox: TScrollBox;
    FlowPanel: TFlowPanel;
    aClickTovarViewButton: TAction;
    aShowFastTovar: TAction;
    btnShowFastTovar: TcxButton;
    Panel2: TPanel;
    tlCategory: TcxDBTreeList;
    clmnCategoryNAME: TcxDBTreeListColumn;
    splTov: TcxSplitter;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1VOLUME_PRICE: TcxGridDBColumn;
    clmtv1NOTE: TcxGridDBColumn;
    clmtv1PLACE: TcxGridDBColumn;
    clmProductAMOUNT: TcxGridDBColumn;
    lv1: TcxGridLevel;
    clmPrice: TcxGridDBColumn;
    aSetDiscountAll: TAction;
    spSetDiscountAll: TpFIBStoredProc;
    peClient: TcxPopupEdit;
    pnlCompactView: TPanel;
    lcCompactView: TdxLayoutControl;
    btnFindDlgCompact: TcxButton;
    btnInsTov: TcxButton;
    btnDelCompact: TcxButton;
    btnShowFastTovarCompact: TcxButton;
    btnUpdCompact: TcxButton;
    btnDelAllCompact: TcxButton;
    btnSetDiscountAllCompact: TcxButton;
    btnFindAnalogCompact: TcxButton;
    btnReturnCompact: TcxButton;
    dxlytgrpCompactViewGroup_Root: TdxLayoutGroup;
    dxlytgrpCompactViewGroup1: TdxLayoutGroup;
    dxLayoutItem1: TdxLayoutItem;
    lcCompactViewItem3: TdxLayoutItem;
    lcCompactViewItem2: TdxLayoutItem;
    dxlytgrpLayoutControl1Group2: TdxLayoutGroup;
    lcCompactViewItem4: TdxLayoutItem;
    lcCompactViewItem5: TdxLayoutItem;
    lcCompactViewItem7: TdxLayoutItem;
    lcCompactViewItem8: TdxLayoutItem;
    lcFindAnalog: TdxLayoutItem;
    lcVozvratItem: TdxLayoutItem;
    lcCompactViewGroup1: TdxLayoutAutoCreatedGroup;
    btnDoSaleCompact: TcxButton;
    lcCompactViewItem11: TdxLayoutItem;
    btnPutAsideCompact: TcxButton;
    lcCompactViewItem1: TdxLayoutItem;
    cbByRecipeCompact: TcxCheckBox;
    lcByRecipe: TdxLayoutItem;
    cbPrintBill: TcxCheckBox;
    Panel5: TPanel;
    lcByRecipeEmptyItem: TdxLayoutItem;
    Panel6: TPanel;
    lcFindAnalogEmptyItem: TdxLayoutItem;
    btnInsClient: TcxButton;
    aInsClient: TAction;
    spDoProduct: TpFIBStoredProc;
    Panel7: TPanel;
    lcVozvratEmptyItem: TdxLayoutItem;
    spGetProductImage: TpFIBStoredProc;
    spReadProductImg: TpFIBDataSet;
    pnlCommonRight: TPanel;
    grSale: TcxGrid;
    tvSale: TcxGridDBTableView;
    clmGridDBTableView1PRODUCT_NAME: TcxGridDBColumn;
    clmGridDBTableView1AMOUNT: TcxGridDBColumn;
    clmGridDBTableView1PRICE: TcxGridDBColumn;
    clmGridDBSUMM: TcxGridDBColumn;
    clmGridDBTableView1DISCOUNT_PERC: TcxGridDBColumn;
    clmGridDBTableView1DISCOUNT_SUMM: TcxGridDBColumn;
    clmGridDBTableView1NDS: TcxGridDBColumn;
    clmGridDBTableView1NDS_SUMM: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlImg: TPanel;
    img1: TImage;
    splSale1: TcxSplitter;
    btnAddServiceSumm: TcxButton;
    aAddServiceSumm: TAction;
    clmBrand: TcxGridDBColumn;
    clmTvProductBrand: TcxGridDBColumn;
    clmCrosscode: TcxGridDBColumn;
    clmVES_GRAMM: TcxGridDBColumn;
    clmVES_GRAMM_PRICE: TcxGridDBColumn;
    clmtvProductVES_GRAMM: TcxGridDBColumn;
    clmtvProductVES_GRAMMPrice: TcxGridDBColumn;
    dxlytlkndflst1: TdxLayoutLookAndFeelList;
    dxLayoutCxLookAndFeel1: TdxLayoutCxLookAndFeel;
    btnDoSale: TcxButton;
    btnRefreshChd: TcxButton;
    btnInsLike: TcxButton;
    btnDelAll: TcxButton;
    btnDelChd: TcxButton;
    btnUpdChd: TcxButton;
    btnSetDiscountAll: TcxButton;
    btnPutAside: TcxButton;
    clmSaleARTICUL: TcxGridDBColumn;
    clmSaleBARCODE: TcxGridDBColumn;
    spFindZakazByBarcode: TpFIBDataSet;
    lbSkidka: TLabel;
    procedure aRefreshChildExecute(Sender: TObject);
    procedure aDoSaleExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure aFindAndInsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure TimerSearchTimer(Sender: TObject);
    procedure aGetDCardExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aDelAllExecute(Sender: TObject);
    procedure aFindAnalogExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aShowPanelTovarExecute(Sender: TObject);
    procedure aFindDlgExecute(Sender: TObject);
    procedure aReturnExecute(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aInsTovExecute(Sender: TObject);
    procedure tAutoRefreshTimer(Sender: TObject);
    procedure tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure tvProductFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvSaleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tvProductCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure aInsFirstExecute(Sender: TObject);
    procedure peClientKeyPress(Sender: TObject; var Key: Char);
    procedure tvSaleDblClick(Sender: TObject);
    procedure aClearSearchExecute(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure aTovarAmountBySkladExecute(Sender: TObject);
    procedure aPutAsideExecute(Sender: TObject);
    procedure aGetAsideExecute(Sender: TObject);
    procedure aGetAsideWindowExecute(Sender: TObject);
    procedure aSetOfficialDefaultExecute(Sender: TObject);
    procedure peOfficialKeyPress(Sender: TObject; var Key: Char);
    procedure peOfficialPropertiesCloseUp(Sender: TObject);
    procedure peOfficialPropertiesInitPopup(Sender: TObject);
    procedure FlowPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure aShowFastTovarExecute(Sender: TObject);
    procedure lePostavshikPropertiesChange(Sender: TObject);
    procedure aSetDiscountAllExecute(Sender: TObject);
    procedure peClientPropertiesCloseUp(Sender: TObject);
    procedure peClientPropertiesInitPopup(Sender: TObject);
    procedure aInsClientExecute(Sender: TObject);
    procedure pnTovarClick(Sender: TObject);
    procedure tvSaleFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure aAddServiceSummExecute(Sender: TObject);
    procedure cbPrintBillCompactPropertiesChange(Sender: TObject);
    procedure cbPrintBillPropertiesChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    FClient, peClientTag : Int64;
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FSkidka    : Double;       // скидка клиента при покупке
    FSummZakaz : Double;       // сумма заказа
    FSummDiscount : Double;    // сумма скидки общая
    FBonusPercent : Double;    // процент бонуса от суммы заказа
    FSummBonus : Double;       // сумма накопленного бонуса за все время
    FMaxBonusPaySumm : Double;   // максимальная сумма, которую может оплатить клиент бонусами
    FNotFirst : Boolean;
    FrefreshProdBook : boolean; //рефрешить товары с букмарком или нет, с букмарком надо только при нажатии на кнопку "Обновить"
    //FShowTovarPanel : Boolean;  //показывать панель товаров
    FTovar : TTovar;
    Is_closing : Boolean;       // форма закрывается в данный момент
    FCOST_PRICE : Double;       // себестоимость товара
    FPutAsideSpis : array of TPutAsideSpis;  //список отложенных товаров
    FPopupOfficialForm : TPopupOfficialListForm;
    FInsByFastTovar    : Boolean;
    peOfficialTag : Int64;
    FArrIdParent  : Array of Integer; // массив ID родителей, текущий уровень - последняя ID
    FPopupClientForm : TPopupClientListSaleModeForm;
    FClientAddress : String;
    FClientIdn : String;
    procedure RefreshTovarRekv;
    procedure LoadProductImg;
    procedure RefreshTmp;
    procedure ClearTempTable;
    procedure WMClearZakaz(var Message: TMessage); message WM_CLEARZAKAZ;
    procedure WMDelTmp(var Message: TMessage); message WM_DEL_TMP;
    procedure WMClickKafeTovView(var Message: TMessage); message WM_CLICK_KAFE_TOVVIEW;
    procedure LocateFindedTovar;
    procedure RefreshClient(DoRefresh : boolean = true);
    procedure RefreshChild(IdCategory : Int64; ForKafeView : Integer = 0);
    procedure GetAsideSpis(id : Integer);
    procedure pmPutAsideSpisAddItem(Caption : String; Tag : integer; Hints : string);
    procedure FillTovarViewButtons(MainMenu : Boolean = true);  // Category = true значит надо идти по категориям
    procedure ClearTovarViewButtons;                            // Очистить все кнопки на панели
    procedure ClickTovarViewButton(Sender: TObject);  //клик по кнопке-товару
    function  FuncGetLastPrice(GProduct : Int64) : Boolean;
    function  CanUpdItem : Boolean;
    procedure SetpeClient(client : Int64);
    function FillLog(ODate : TDate; OTime : TTime; Summ, SummFact, Bonus, BonusPayed, SummCash, SummNonCash : Double) : string;
    function IsProgramActivated : Boolean;
  public
    constructor CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String = '');
    procedure InsData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  SaleModeForm: TSaleModeForm;

implementation

uses frmUpdProdazhaTovara, frmGetDCard, frmMain, dmMain, frmSaleDlg, frmSalePayment,
frmSearchTovarDlg, frmPrihodTovaraN, frmTovarAmountBySklad, frmGetTovarAsideSpis,
frmFastGoodsView, frmClient, frmSalePinCode, frmSaleMarkCodeInput, unLog, frmPosTerminalProcess, frmSearchZakazDlg, unFRPrinted, frmSetSkidka;

{$R *.dfm}

//данная форма испльзуется в двух проектах - Shopuchet и SalonUchet, Prizn = 100 - это SalonUchet, тут надо другие селекты юзать
constructor TSaleModeForm.CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String = '');
var Caption_ : String;
begin
  Caption_ := 'Рабочее место кассира';
  inherited Create(AOwner, Caption_, ActionName);

  if Prizn = 100 then begin
    spRead.SQLs.SelectSQL.Text := 'SELECT * FROM G_READ_G_PRODCAT_LIST(?TYPE_)';
    spReadTovar.SQLs.SelectSQL.Text := 'SELECT T.G_PRODUCT,' +
                                          'T.G_PRODUCT_PAR,' +
                                          'T.ARTICUL,' +
                                          'T.NOMENCLATUR_NUM,' +
                                          'T.BARCODE,' +
                                          'T.NAME,' +
                                          'T.PRICE,' +
                                          'T.VOLUME_PRICE,' +
                                          'COALESCE(P.AMOUNT, 0) AMOUNT,' +
                                          'PP.SKIDKA_PROC,' +
                                          'PP.SKIDKA_SUM,' +
                                          'T.GTYPE,' +
                                          'T.DURATION,' +
                                          'T.VES,' +
                                          'T.PRICE_VES ' +
                                      'FROM G_PRODUCT T LEFT OUTER JOIN LT_SKLAD_PRODUCT P ON T.G_PRODUCT = P.G_PRODUCT ' +
                                           'LEFT OUTER JOIN (SELECT G_PRODUCT, D.SKIDKA_PROC, D.SKIDKA_SUM ' +
                                                              'FROM G_DISCOUNT D ' +
                                                              'WHERE (D.DATE_BEGIN <= CURRENT_TIMESTAMP ' +       // -- ТОЛЬКО АКТИВНЫЕ
                                                                      'AND D.DATE_END >= CURRENT_TIMESTAMP ' +
                                                                      'AND D.DATE_BEGIN IS NOT NULL AND D.DATE_END IS NOT NULL ' +
                                                                    ') ' +
                                                                    'OR ' +
                                                                    '(D.DATE_BEGIN IS NULL AND D.DATE_END IS NULL) ' +
                                                           ') PP ON T.G_PRODUCT = PP.G_PRODUCT ' +
                                      'WHERE T.G_PRODUCT_PAR = DECODE(:G_PRODUCT_PAR_, -5, T.G_PRODUCT, :G_PRODUCT_PAR_) ' +
                                        'AND T.IS_CATEGORY = 0 ' +
                                        'AND T.IS_ACTIVE = 1 ' +
                                        'AND ( ' +
                                            '(T.GTYPE = :TYPE_ AND :TYPE_ > 0) ' +
                                            'OR ' +
                                            '(T.GTYPE IN (1,2) AND :TYPE_ = -1) ' +   // ВЫБИРАЮТСЯ РАСХОДНИКИ И ТОВАРЫ, ДЛЯ РЕЖИМА ПРИХОД ТОВАРА И СПИСАНИЕ ТОВАРА
                                            'OR ' +
                                            '(T.GTYPE IN (1,3) AND :TYPE_ = -2) ' +   // ВЫБИРАЮТСЯ ТОВАРЫ И УСЛУГИ, ДЛЯ РЕЖИМА ПРОДАЖИ ТОВАРА И УСЛУГ
                                            ') ' +
                                        'AND :G_TOCHKA_ = :G_TOCHKA_ ' +  // ПРОСТО ДЛЯ СОВМЕСТИМОСТИ ШОПУЧЕТ И САЛОНУЧЕТ
                                     'ORDER BY 6';
  end;
end;

procedure TSaleModeForm.ReadList;
var
  onChangeCat : TcxTreeListFocusedNodeChangedEvent;
begin
  IF IsProgramActivated = False THEN
    EXIT;

  onChangeCat := tlCategory.OnFocusedNodeChanged;
  tlCategory.OnFocusedNodeChanged := nil;

  spRead.ParamByName('IS_RMK_').AsInteger := 1;
  if KafeTovarView = 1 then begin
    spRead.ParamByName('type_').AsInteger := 1;
    // 11.02.2020 для теста пока поставил так, посмотрим на жалобы
    // теперь после продажи всегда уходит на главное окно с группами товаров
    spRead.ParamByName('g_product_par_').Clear;
    {if High(FArrIdParent) = -1 then
      spRead.ParamByName('g_product_par_').Clear
    else
      spRead.ParamByName('g_product_par_').AsInteger := FArrIdParent[High(FArrIdParent)];}
  end;

  inherited;

  if (KafeTovarView = 0) and (RmkView = 0) then
    aRefreshChild.Execute;

  RefreshTmp;

  tlCategory.OnFocusedNodeChanged := onChangeCat;

  if KafeTovarView = 1 then begin
    ClearTovarViewButtons;
    FillTovarViewButtons;
  end;
end;

procedure TSaleModeForm.FillTovarViewButtons(MainMenu: Boolean = true);
var vButton:TcxButton;
  SP : TpFIBDataSet;
begin
  if MainMenu then begin
    SP := spRead;
    SetLength(FArrIdParent, 0);
  end else
    SP := spReadTovar;

  // делаю кнопку Назад
  if High(FArrIdParent) > -1 then begin
    vButton:= TcxButton.Create(self);
    vButton.Parent := FlowPanel;
    vButton.width := 100;
    vButton.height := 100;
    vButton.OnClick := ClickTovarViewButton;
    vButton.Caption:= 'Назад';
    vButton.WordWrap := True;
    vButton.Font.Size := 10;
    vButton.Font.Color := clBlack;
    vButton.LookAndFeel.Kind := lfFlat;
    vButton.Tag := -100;
  end;

  SP.First;
  while not SP.Eof do begin
    vButton:= TcxButton.Create(self);
    vButton.Parent := FlowPanel;
    vButton.width := 100;
    vButton.height := 100;
    vButton.OnClick := ClickTovarViewButton;
    vButton.Caption:= SP.FieldByName('Name').AsString;
    if MainMenu = false then begin
      vButton.Tag := SP.FieldByName('is_category').AsInteger;
      if vButton.Tag = 0 then
        vButton.Caption := vButton.Caption + #13#10#13#10 + SP.FieldByName('Price').AsString + ' / ' + SP.FieldByName('Amount').AsString;
    end else
      vButton.Tag := 1;

    vButton.WordWrap := True;
    if Length(vButton.Caption) <= 50 then
      vButton.Font.Size := 10
    else
      vButton.Font.Size := 8;
    vButton.Font.Color := clBlack;
    vButton.LookAndFeel.Kind := lfFlat;
    vButton.Description := SP.FieldByName('g_product').AsString;
    //vButton.Tag := Integer(MainMenu);
    SP.Next;
  end;
end;

procedure TSaleModeForm.ClearTovarViewButtons;
var i : Integer;
begin
  for I := FlowPanel.ControlCount - 1 downto 0 do
    FlowPanel.Controls[i].Free;
end;

procedure TSaleModeForm.ClickTovarViewButton(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLICK_KAFE_TOVVIEW, WPARAM(Sender), 0);
end;

procedure TSaleModeForm.WMClickKafeTovView(var Message: TMessage);
var Id : int64;
begin
  // если нажали кнопку Назад
  if TcxButton(Message.WParam).Tag = -100 then begin
    SetLength(FArrIdParent, High(FArrIdParent));

    // если в массиве родительских категорий больше ничего нет, значит надо возвращаться в
    // главное меню
    if High(FArrIdParent) = -1 then
      Readlist
    else begin
      RefreshChild(FArrIdParent[High(FArrIdParent)], 1);
      ClearTovarViewButtons;
      FillTovarViewButtons(false);
    end;

    Exit;
  end;

  Id := StrToInt64(TcxButton(Message.WParam).Description);
  if TcxButton(Message.WParam).Tag = 1 then begin
    SetLength(FArrIdParent, High(FArrIdParent) + 2);
    FArrIdParent[High(FArrIdParent)] := Id;

    RefreshChild(Id, 1);

    //if spReadTovar.RecordCount > 0 then begin
      ClearTovarViewButtons;
      FillTovarViewButtons(False);
    //end else begin
    //  spRead.ParamByName('type_').AsInteger := 1;
    //  spRead.ParamByName('g_product_par_').AsInteger := Id;
    //  Readlist;
    //end;
  end else begin
    spReadTovar.Locate('g_product', Id, []);
    aIns.Execute;
  end;
end;

procedure TSaleModeForm.InsData;
var SaleDlg : TSaleDlgForm;
  UserCancel : Boolean;
  prodCheck : Boolean;
  showDlg : boolean;
  SaleMarkCodeInputForm: TSaleMarkCodeInputForm;
begin
  IF IsProgramActivated = False THEN
    EXIT;

  UserCancel := false;

  if (tvProduct.Controller.SelectedRowCount = 0) and (ShowTovarPanel = 1) and (KafeTovarView = 0) and
  (FInsByFastTovar = False) and (RmkView = 0) then begin
    MessageDlg('Вы не выбрали ни одного товара! Выберите товар!', mtWarning, [mbOk], 0);
    edSearch.Clear;
    Exit;
  end;

  if (ShowTovarPanel = 1) and (RmkView = 0) then
    if AllowSellAbsGoods = 0 then begin
      // если конфигурация Производство и товар "Готовый продукт" и стоит разрешение
      // производить товар при продаже, то это сообщение не выставляю
      if not ((Config = 3) and (DoProductInSale = 1) and ((FTovar.IsKit = 2) or
      (spReadTovar.FieldByName('is_kit').AsInteger = 2))) then begin
        if FInsByFastTovar then begin
          if FTovar.Ostatok <= 0 then begin
            MessageDlg('Остаток товара на складе 0 и после операции он станет отрицательным. Продолжение невозможно!', mtWarning, [mbYes], 0);
            Exit;
          end;
        end else if (KafeTovarView = 0) and (SetCursorOnTovar = 1) then begin
          if spReadTovar.FieldByName('amount').AsFloat <= 0 then begin
            MessageDlg('Остаток товара "' + spReadTovar.FieldByName('NAME').AsString + '" на складе 0 и после операции он станет отрицательным. Продолжение невозможно!', mtWarning, [mbYes], 0);
            Exit;
          end;
        end;
      end;
    end;

  if ShowSaleDlg = 1 then begin
    // проверяю надо ли показывать окно только для весового товара
    showDlg := true;
    if ShowSaleDlgForVes = 1 then begin
      if (Copy(FTovar.Barcode, 1, 2) <> ScalesPrefix) and (FTovar.IsTovarVes = 0) then
        showDlg := False;
    end;
  end else
    showDlg := false;

  if showDlg then begin
    SaleDlg := TSaleDlgForm.Create(Self);
    with SaleDlg do begin
      try
        OpenMode := omInsert;
        NotShowAmountWarning := ShowTovarPanel;
        Product := FTovar.Product;
        Skidka := FSkidka;
        VolumePrice := OptPriceByDefault;
        Amount      := FTovar.Amount;
        IsMarked    := FTovar.IsMarked;
        VesGrammPrice := FTovar.VesGrammPrice;

        if ShowModal = mrOk then begin
          FTovar.Price := edPrice.Value;
          FTovar.Amount := MyCurrencyFrameForm.Value;
          FTovar.Summ   := edSumm.Value;
          FTovar.SkidkaVal  := edSkidka.Value;
          FTovar.SkidkaSumm := edSkidkaSumm.Value;
          FTovar.cbPrice  := cbPrice.ItemIndex;
          FTovar.cbSkidka := cbSkidka.ItemIndex;

          FTovar.VesGrammPrice := edVesGrammPrice.Value;
        end else begin
          UserCancel := True;
          FTovar.Product := 0;
          FTovar.Product_Par := 0;
          FTovar.Price := 0;
          FTovar.Amount := 0;
          FTovar.Summ := 0;
          FTovar.SkidkaProc := 0;
          FTovar.SkidkaVal := 0;
          FTovar.SkidkaSumm := 0;
          FTovar.cbPrice := 0;
          FTovar.cbSkidka := 0;
          FTovar.IsMarked := 0;
          FTovar.Ostatok := 0;
          FTovar.IsTovarVes := 0;
          FTovar.MarkCode := '';
          FTovar.VesGrammPrice := 0;
        end;
      finally
        FreeAndNil(SaleDlg);
      end;
    end;
  end else begin
    spGetSkidka.ParamByName('g_product_').AsInt64 := FTovar.Product;
    if not spGetSkidka.Transaction.InTransaction then
      spGetSkidka.Transaction.StartTransaction;
    ExecSp(spGetSkidka);

    if spGetSkidka.Transaction.InTransaction then
      spGetSkidka.Transaction.CommitRetaining;

    // могут юзаться весы, а там количество передается уже при сканировании штрихкода
    // все вычисляется в процедуре G_GET_G_PRODUCT_BY_BARCODE
    {if (UseScales = 0) or (FTovar.Amount = 0) then begin
      if (FTovar.Ostatok > 0) and (FTovar.Ostatok < 1) and (AllowSellAbsGoods = 0) then
        FTovar.Amount := FTovar.Ostatok
      else
        FTovar.Amount := 1;
    end; }

    FTovar.cbSkidka := 1;
    // если скидка клиента больше скидки товара, то ставлю ее
    if FSkidka > spGetSkidka.ParamByName('SKIDKA_PROC_').AsFloat then begin
      FTovar.SkidkaProc := FSkidka;
      FTovar.SkidkaVal  := FTovar.Price * FSkidka / 100;
      FTovar.SkidkaSumm := FTovar.SkidkaVal;
    end else begin
      FTovar.SkidkaProc := spGetSkidka.ParamByName('SKIDKA_PROC_').AsFloat;
      FTovar.SkidkaVal  := spGetSkidka.ParamByName('SKIDKA_SUM_').AsFloat;
      FTovar.SkidkaSumm := spGetSkidka.ParamByName('SKIDKA_SUM_').AsFloat;
    end;

    FTovar.Summ   := MathRound(FTovar.Amount * (FTovar.Price - FTovar.SkidkaSumm), 2);  // делаю округление, чтобы потом не было проблем при передаче в ФР
  end;

  if UserCancel = false then begin
    if (NotifyNol = 1) {and (ShowTovarPanel = 1) and (RmkView = 0) } then begin
      if FTovar.Price = 0 then begin
        if MessageDlg('Цена товара указана 0, Вы уверены, что хотите продолжить?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
          Exit;
      end;
    end;

    if FTovar.IsMarked <> 0 then begin
      SaleMarkCodeInputForm := TSaleMarkCodeInputForm.Create(Self);
      with SaleMarkCodeInputForm do begin
        try
          if (ShowModal = mrOk) and (length(edMarkCode.Text) > 0) then
            FTovar.MarkCode := edMarkCode.Text

          else
            Exit;
        finally
          Free;
        end;
      end;
    end;

    with spInsProduct do begin
      ParamByName('G_PRODUCT_').AsInt64 := FTovar.Product;
      ParamByName('PRICE_').AsFloat := FTovar.Price;
      ParamByName('VES_GRAMM_PRICE_').AsFloat := FTovar.VesGrammPrice;
      ParamByName('AMOUNT_').AsFloat := FTovar.Amount;
      ParamByName('SUMM_').AsFloat := FTovar.Summ;
      ParamByName('NDS_').AsFloat := NdsValue;   //edNDS.Value;  -- теперь берется из настроек справочника "Моя фирма"
      ParamByName('NDS_SUMM_').AsFloat := FTovar.Summ * NdsValue / (100 + NdsValue);  //так считается по бухгалтерской формуле
      if (FTovar.SkidkaVal <> 0) and (FTovar.Price > 0) then begin
        if FTovar.cbSkidka = 0 then begin
          ParamByName('DISCOUNT_PERC_').AsFloat := FTovar.SkidkaVal;
          ParamByName('DISCOUNT_TENGE_').AsFloat := FTovar.Price * FTovar.SkidkaVal/100;
        end else begin
          //ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((FTovar.SkidkaVal * 100 / FTovar.Price), -5);
          //ParamByName('DISCOUNT_TENGE_').AsFloat := FTovar.SkidkaVal;
          ParamByName('DISCOUNT_PERC_').AsFloat := RoundTo((FTovar.SkidkaVal/FTovar.Amount * 100 / FTovar.Price), -2);
          ParamByName('DISCOUNT_TENGE_').AsFloat := RoundTo(FTovar.SkidkaVal/FTovar.Amount, -2);
        end;
      end else begin
        ParamByName('DISCOUNT_PERC_').AsFloat := 0;
        ParamByName('DISCOUNT_TENGE_').AsFloat := 0;
      end;
      ParamByName('DISCOUNT_SUMM_').AsFloat := FTovar.SkidkaSumm;
      ParamByName('IS_SPISANIE_').AsInteger := 0;
      ParamByName('NEW_LINE_SALE_').AsInteger := NewLineSale;
      ParamByName('COST_PRICE_').AsFloat := FCOST_PRICE;
      IF FTovar.cbPrice = 0 THEN
        ParamByName('MODE_').AsFloat := 1
      else
        ParamByName('MODE_').AsFloat := 2;

      {IF FTovar.cbSkidka = 0 THEN
        ParamByName('MODE1_').AsFloat := 0
      else
        ParamByName('MODE1_').AsFloat := 1;}

      ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
      ParamByName('DO_PRODUCT_IN_SALE_').AsInteger := DoProductInSale;
      ParamByName('MARK_CODE_').AsString := FTovar.MarkCode;

      if not Transaction.InTransaction then
        Transaction.StartTransaction;

      IF ExecSP(spInsProduct) THEN begin
        if Transaction.InTransaction then
          Transaction.Commit;

        RefreshTmp;

        spReadTmp.Locate('zakaz_details', spInsProduct.ParambyName('ZAKAZ_DETAILS_').AsInt64, []);
        if tvSale.Controller.FocusedRow <> Nil then begin
          if tvSale.Controller.SelectedRowCount > 0 then
            tvSale.Controller.SelectedRows[0].Selected := False;
          tvSale.Controller.FocusedRow.Selected := True;
        end;
        // если все нормально, то перезаполняю кнопки
        {if KafeTovarView = 1 then begin
          ClearTovarViewButtons;
          FillTovarViewButtons;
        end; }

        // ПОКАЗЫВАЮ КАРТИНКУ ЕСЛИ ЕСТЬ
        LoadProductImg;
      end;

      // обнуляю переменную
      FTovar.Product := 0;
      FTovar.Product_Par := 0;
      FTovar.Price := 0;
      FTovar.Amount := 0;
      FTovar.Summ := 0;
      FTovar.SkidkaProc := 0;
      FTovar.SkidkaVal := 0;
      FTovar.SkidkaSumm := 0;
      FTovar.cbPrice := 0;
      FTovar.cbSkidka := 0;
      FTovar.IsMarked := 0;
      FTovar.Ostatok := 0;
      FTovar.IsTovarVes := 0;
      FTovar.MarkCode := '';
      FTovar.VesGrammPrice := 0;
    end;
  end;
end;

function TSaleModeForm.IsProgramActivated: Boolean;
begin
  Result := True;
  IF (IsActivated = 0) THEN BEGIN
    MessageDlg('Лицензия истекла либо не зарегистрирована.' + #10#13 + 'Включены ограничения на количество продаж!', mtWarning, [mbOk], 0);
    aIns.Enabled := False;
    aUpd.Enabled := False;
    aDel.Enabled := False;
    aDelAll.Enabled := False;
    aGetDCard.Enabled := False;
    aPutAside.Enabled := False;
    aDoSale.Enabled := False;
    aFindAndIns.Enabled := False;
    aFindDlg.Enabled := FALSE;
    aFindAnalog.Enabled := FALSE;
    aShowFastTovar.Enabled := FALSE;
    aReturn.Enabled := FALSE;
    aInsTov.Enabled := False;
    aSetDiscountAll.Enabled := False;
    aAddServiceSumm.Enabled := False;
    aPutAside.Enabled := False;
    //lePostavshik.ENABLED := FALSE;
    peClient.ENABLED := FALSE;
    Result := False;
  END;
end;

// Добавить товар 10% за обслуживание
procedure TSaleModeForm.aAddServiceSummExecute(Sender: TObject);
begin
  try
    FTovar.Product := -2;
    FTovar.Product_Par := -1;
    FTovar.IsKit       := 0;
    FTovar.Price := RoundTo((FSummZakaz + FSummDiscount) * 0.1, -2);
    FTovar.Amount := 1;
    FTovar.cbPrice  := 0;
    FTovar.cbSkidka := 0;
    Insdata;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TSaleModeForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
  end;
end;

procedure TSaleModeForm.LoadProductImg;
var
  Graphic : TGraphic;
begin
  if ShowProductImg = 1 then begin
    img1.Picture := nil;
    spReadProductImg.ParamByName('G_Product_').AsInt64 := spReadTmp.FieldByName('g_product').AsLargeInt;
    OpenSp(spReadProductImg, False);
    if spReadProductImg.FieldByName('ptype').AsString <> '' then begin
      try
        case spReadProductImg.FieldByName('ptype').AsInteger of
             1: Graphic:=TJpegimage.Create;
             2: Graphic:=TPNGImage.Create;
             3: Graphic:=TBitmap.Create;
        else
          Graphic:=TJpegimage.Create;
        end;
        Graphic.Assign(spReadProductImg.FieldByName('IMG'));
        img1.Picture.Assign(Graphic);
      finally
        Graphic.Free;
      end;
    end;
  end;
end;

procedure TSaleModeForm.UpdData;
begin

  //if CanUpdItem then begin
    ClassForm := TSaleDlgForm.Create(Self);
    try
      {Вызываем метод предка}
      try
        (ClassForm as TSaleDlgForm).NotShowAmountWarning := ShowTovarPanel;
        ClassForm.KeyField := 'ZAKAZ_DETAILS_';
        ClassForm.RecID := spReadTmp.FieldByName(KeyFieldList).AsLargeInt;
        ClassForm.OpenMode := omUpdate;
        (ClassForm as TSaleDlgForm).IsMarked := spReadTmp.FieldByName('is_marked').AsInteger;

        if ClassForm.ShowModal = mrOk then
        begin
          RefreshTmp;
          if tvSale.Controller.FocusedRow <> Nil then begin
            if tvSale.Controller.SelectedRowCount > 0 then
              tvSale.Controller.SelectedRows[0].Selected := False;
            tvSale.Controller.FocusedRow.Selected := True;
          end;
        end;
      except
        on E: Exception do
          MessageDlg(E.Message + #13#10'(occured in TSaleModeForm.UpdData)', mtInformation, [mbOk], 0);
      end;
    finally
      ClassForm.Free;
    end;
  //end;
end;

procedure TSaleModeForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'ZAKAZ_DETAILS';
  KeyFieldClass := 'ZAKAZ_DETAILS_';
  inherited;
  if not HaveRightToSeeAmount then
    clmProductAMOUNT.Destroy;

  if not HaveRightToSeeOpt then
    clmtv1VOLUME_PRICE.Destroy;

  FPopupClientForm := TPopupClientListSaleModeForm.Create(Self);

  if ShowKassirPanel = 1 then
    FPopupOfficialForm := TPopupOfficialListForm.Create(Self);

  // буду всегда ставить Lazyload в spReadTovar, независимо от того, отображается панель с товарами или нет
  SPLazyLoadEnable(spReadTovar, tvProduct);
end;

// ОТЛОЖИТЬ ТОВАРЫ В СТОРОНУ ДЛЯ КЛИЕНТА
procedure TSaleModeForm.aPutAsideExecute(Sender: TObject);
var i, k, AIndex : integer;
  hints    : string;
begin
  // отложить товары можно только, если в корзине что-то есть
  if spReadTmp.RecordCount > 0 then begin
    hints := '';

    i := High(FPutAsideSpis) + 1;
    SetLength(FPutAsideSpis, i + 1);
    FPutAsideSpis[i].Num := i + 1;
    //FPutAsideSpis[i].Client := lePostavshik.EditValue;
    FPutAsideSpis[i].Client := peClientTag;

    with spReadTmp do begin
      First;
      while not eof do begin
        k := High(FPutAsideSpis[i].Tovar);
        SetLength(FPutAsideSpis[i].Tovar, k + 2);
        k := k + 1;
        FPutAsideSpis[i].Tovar[k].Product := FieldByName('g_product').AsLargeInt;
        FPutAsideSpis[i].Tovar[k].Price   := FieldByName('price').AsFloat;
        FPutAsideSpis[i].Tovar[k].Amount  := FieldByName('AMOUNT').AsFloat;
        FPutAsideSpis[i].Tovar[k].Summ  := FieldByName('AMOUNT').AsFloat * FieldByName('price').AsFloat - FieldByName('DISCOUNT_SUMM').AsFloat;
        FPutAsideSpis[i].Tovar[k].SkidkaProc  := FieldByName('DISCOUNT_PERC').AsFloat;
        FPutAsideSpis[i].Tovar[k].SkidkaVal  := FieldByName('DISCOUNT_TENGE').AsFloat;
        FPutAsideSpis[i].Tovar[k].SkidkaSumm := FPutAsideSpis[i].Tovar[k].Amount * FPutAsideSpis[i].Tovar[k].SkidkaVal;
        FPutAsideSpis[i].Tovar[k].CostPrice  := FieldByName('Cost_Price').AsFloat;
        FPutAsideSpis[i].Tovar[k].MarkCode   := FieldByName('mark_code').AsString;

        hints := hints + FieldByName('PRODUCT_NAME').AsString + ', ';
        Next;
      end;
    end;

    with tvSale.DataController.Summary do begin
      AIndex :=  FooterSummaryItems.IndexOfItemLink(clmGridDBSUMM);
      FPutAsideSpis[i].Summ := FooterSummaryValues[AIndex];
    end;

    delete(hints, length(hints)-1, 1);
    FPutAsideSpis[i].HintS := hints;

    pmPutAsideSpisAddItem('Чек№ ' + IntToStr(i + 1) + '. Сумма ' + FloatToStr(FPutAsideSpis[i].Summ),
                          i,
                          Hints);

    PostMessage(Self.Handle, WM_CLEARZAKAZ, 0, 0);
  end;
end;

// создание нового пункта меню
procedure TSaleModeForm.pmPutAsideSpisAddItem(Caption: String; Tag: integer;
  Hints: string);
var menuItem : TMenuItem;
begin
  menuItem := TMenuItem.Create(pmPutAsideSpis);
  menuItem.Caption := Caption;
  menuItem.OnClick := aGetAsideExecute;
  menuItem.Tag := Tag;
  menuItem.Hint := Hints;
  pmPutAsideSpis.Items.Add(menuItem);
end;

procedure TSaleModeForm.pnTovarClick(Sender: TObject);
begin
  inherited;

end;

// показать окно с отложенным списком товаров
procedure TSaleModeForm.aGetAsideWindowExecute(Sender: TObject);
var GetTovarAsideSpisForm: TGetTovarAsideSpisForm;
  i : integer;
begin
  GetTovarAsideSpisForm := TGetTovarAsideSpisForm.Create(Application);
  with GetTovarAsideSpisForm do begin
    dxMemData.Open;
    for I := High(FPutAsideSpis) downto 0 do begin
      dxMemData.Insert;
      dxMemData.FieldByName('Check').AsInteger  := FPutAsideSpis[i].Num;
      dxMemData.FieldByName('Summ').AsFloat     := FPutAsideSpis[i].Summ;
      dxMemData.FieldByName('Details').AsString := FPutAsideSpis[i].HintS;
      dxMemData.FieldByName('Id').AsInteger     := i;
    end;
    dxMemData.Refresh;

    try
      if ShowModal = mrOk then
        GetAsideSpis(CheckId);
    finally
      Free;
    end;
  end;
end;

// ACTION ВЫТАЩИТЬ ТОВАРЫ ИЗ ОТЛОЖЕННОГО СПИСКА
procedure TSaleModeForm.aGetAsideExecute(Sender: TObject);
var k : Integer;
begin
  k := (Sender as TMenuItem).Tag;
  GetAsideSpis(k);
end;

// PROC ВЫТАЩИТЬ ТОВАРЫ ИЗ ОТЛОЖЕННОГО СПИСКА
procedure TSaleModeForm.GetAsideSpis(id : Integer);
var i, j : Integer;
begin
  Cleartemptable;
  RefreshTmp;

  //lePostavshik.EditValue := FPutAsideSpis[id].Client;
  SetpeClient(FPutAsideSpis[id].Client);

  for I := 0 to High(FPutAsideSpis[id].Tovar) do begin
    with spInsProduct do begin
      ParamByName('G_PRODUCT_').AsInt64 := FPutAsideSpis[id].Tovar[i].Product;
      ParamByName('PRICE_').AsFloat := FPutAsideSpis[id].Tovar[i].Price;
      ParamByName('AMOUNT_').AsFloat := FPutAsideSpis[id].Tovar[i].Amount;
      ParamByName('SUMM_').AsFloat := FPutAsideSpis[id].Tovar[i].Summ;
      ParamByName('NDS_').AsFloat := NdsValue;   //edNDS.Value;  -- теперь берется из настроек справочника "Моя фирма"
      ParamByName('NDS_SUMM_').AsFloat := FPutAsideSpis[id].Tovar[i].Summ * NdsValue / (100 + NdsValue);  //так считается по бухгалтерской формуле
      ParamByName('DISCOUNT_PERC_').AsFloat := FPutAsideSpis[id].Tovar[i].SkidkaProc;
      ParamByName('DISCOUNT_TENGE_').AsFloat := FPutAsideSpis[id].Tovar[i].SkidkaVal;
      ParamByName('DISCOUNT_SUMM_').AsFloat := FPutAsideSpis[id].Tovar[i].SkidkaSumm;
      ParamByName('IS_SPISANIE_').AsInteger := 0;
      ParamByName('NEW_LINE_SALE_').AsInteger := NewLineSale;
      ParamByName('COST_PRICE_').AsFloat := FPutAsideSpis[id].Tovar[i].CostPrice;
      ParamByName('MODE_').AsFloat := 0;
      ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
      ParamByName('MARK_CODE_').AsString := FPutAsideSpis[id].Tovar[i].MarkCode;

      if not Transaction.InTransaction then
        Transaction.StartTransaction;

      IF ExecSP(spInsProduct) THEN begin
        if Transaction.InTransaction then
          Transaction.Commit;
      end;
    end;
  end;

  RefreshTmp;

  spReadTmp.Locate('zakaz_details', spInsProduct.ParambyName('ZAKAZ_DETAILS_').AsInt64, []);
  if tvSale.Controller.FocusedRow <> Nil then begin
    if tvSale.Controller.SelectedRowCount > 0 then
      tvSale.Controller.SelectedRows[0].Selected := False;
    tvSale.Controller.FocusedRow.Selected := True;
  end;

  for J := id to High(FPutAsideSpis)-1 do
    FPutAsideSpis[j] := FPutAsideSpis[j + 1];

  SetLength(FPutAsideSpis, High(FPutAsideSpis));

  //переформирую меню
  pmPutAsideSpis.Items.Clear;

  for i := 0 to High(FPutAsideSpis) do begin
    pmPutAsideSpisAddItem('Чек№ ' + IntToStr(i + 1) + '. Сумма ' + FloatToStr(FPutAsideSpis[i].Summ),
                          i,
                          FPutAsideSpis[i].Hints);
  end;
end;

procedure TSaleModeForm.SetpeClient(client: Int64);
begin
  peClientTag := client;
  spPostavshik.Locate('g_client', peClientTag, []);
  peClient.Text := spPostavshik.FieldByName('NAME_WITH_DOLG').AsString;
end;

procedure TSaleModeForm.aRefreshChildExecute(Sender: TObject);
//var onChangeTov : TcxGridFocusedRecordChangedEvent;
begin
  if ShowTovarPanel = 1 then begin
    try
      Screen.Cursor := crHourGlass;

      RefreshChild(spRead.FieldByName('g_product').AsLargeInt);
    finally
      //tvProduct.OnFocusedRecordChanged := onChangeTov;
      Screen.Cursor := crDefault;
    end;
  end;

  aIns.Enabled := spReadTovar.RecordCount > 0;
end;

procedure TSaleModeForm.RefreshChild(IdCategory: Int64; ForKafeView : Integer = 0);
begin
  //WHERE T.G_PRODUCT_PAR = DECODE(CAST(:G_PRODUCT_PAR_ AS BIGINT), -1, T.G_PRODUCT_PAR, CAST(:G_PRODUCT_PAR_ AS BIGINT))
  //spReadTovar.ParamByName('g_product_par_').AsInt64 := IdCategory;

  if spReadTovar.Active then
    spReadTovar.Close;

  spReadTovar.SelectSQL.Text := spReadTovarSQl;

  if IdCategory <> -1 then
    spReadTovar.SelectSQL.Text := spReadTovar.SelectSQL.Text + ' WHERE T.G_PRODUCT_PAR = ' + IntToStr(IdCategory);
  spReadTovar.SelectSQL.Text := spReadTovar.SelectSQL.Text + ' ORDER BY 5';

  spReadTovar.ParamByName('g_tochka_').AsInt64 := CurSklad;
  spReadTovar.ParamByName('KAFE_VIEW_').AsInteger := ForKafeView;

  //onChangeTov := tvProduct.OnFocusedRecordChanged;
  //tvProduct.OnFocusedRecordChanged := nil;
  OpenSp(spReadTovar, FrefreshProdBook);
  FrefreshProdBook := False;  // TRUE выставляется только при нажатии на кнопку ОБНОВИТЬ

  aFindDlg.Enabled := spReadTovar.RecordCount > 0;
  aTovarAmountBySklad.Enabled := spReadTovar.RecordCount > 0;

  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;

  RefreshTovarRekv;
end;

procedure TSaleModeForm.tvProductCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aIns.Execute;
end;

procedure TSaleModeForm.tvProductFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  if (spReadTovar.Active) and (APrevFocusedRecord <> nil) then
    RefreshTovarRekv;
end;

procedure TSaleModeForm.tvSaleDblClick(Sender: TObject);
begin
  {if (spReadTmp.RecordCount > 0) and (spReadTmp.FieldByName('G_product').AsLargeInt <> -2) then
    UpdData;}
  aUpd.Execute;
end;

procedure TSaleModeForm.tvSaleFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  LoadProductImg;
  aUpd.Enabled := (spReadTmp.RecordCount > 0) and (spReadTmp.FieldByName('g_product').AsInteger <> -2);
  aInsTov.Enabled := (spReadTmp.FieldByName('g_product').AsInteger <> -2)
    and (spReadTmp.FieldByName('is_marked').AsInteger = 0);
end;

procedure TSaleModeForm.tvSaleMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ActiveTVControl := ((Sender as TcxGridSite).GridView as TcxGridDBTableView);
end;

procedure TSaleModeForm.RefreshTovarRekv;
var price_str : string;
  ostatok_str : string;
begin
  WITH spReadTovar DO BEGIN
    FormatSettings.CurrencyString := '';
    price_str := StringReplace(CurrToStrF(spReadTovar.FieldByName('price').AsFloat, ffCurrency, 2), '.', ',', [rfReplaceAll]);
    ostatok_str := FormatFloat('0.'.PadRight(2 + FormatSettings.CurrencyDecimals, '0'), spReadTovar.FieldByName('amount').AsFloat);
    lbPrice.Caption := 'Цена ' + price_str;
    // если нет права, то не отражаю остатки
    if HaveRightToSeeAmount then
      lbPrice.Caption := lbPrice.Caption + '. Остаток ' + ostatok_str;

    if FuncGetLastPrice(FieldByName('G_PRODUCT').AsLargeInt) = False then begin
      ShowMessage('Произошла ошибка при расчете стоимости товара!');
      EXIT;
    end;

    // если нет права, то не отражаю остатки
    if (HaveRightToSeeCostPrice) and (ShowCostPrice = 1) then
      lbPrice.Caption := lbPrice.Caption + '. Цена закупки ' +
        StringReplace(CurrToStrF(FCOST_PRICE, ffCurrency, 2), '.', ',', [rfReplaceAll]);
  end;
end;

procedure TSaleModeForm.ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Scrollbox.VertScrollBar.Position := Scrollbox.VertScrollBar.Position - WheelDelta div 15;
end;

procedure TSaleModeForm.RefreshTmp;
var AIndex: integer;
begin
  OpenSp(spReadTmp, True);
  //pnStaticText.Caption := Format('%.*d',[4, spReadTmp.RecordCount]);
  aUpd.Enabled := (spReadTmp.RecordCount > 0) and (spReadTmp.FieldByName('g_product').AsInteger <> -2);
  aDel.Enabled := spReadTmp.RecordCount > 0;
  aDelAll.Enabled := spReadTmp.RecordCount > 0;
  aPutAside.Enabled := (spReadTmp.RecordCount > 0) or (High(FPutAsideSpis) > -1);
  aDoSale.Enabled   := spReadTmp.RecordCount > 0;
  aInsTov.Enabled   := spReadTmp.RecordCount > 0;
  aSetDiscountAll.Enabled := (spReadTmp.RecordCount > 0) and (HaveRightUpdDiscSale = true);
  aAddServiceSumm.Enabled := (aAddServiceSumm.Visible) and (spReadTmp.RecordCount > 0);
  
  // убираю галочку "По рецепту" ЕСЛИ ЗАПИСЕЙ ВО ВРЕМЕННОЙ ТАБЛИЦЕ БОЛЬШЕ НЕТ
  if spReadTmp.RecordCount = 0 then begin
    cbByRecipe.checked := false;
    cbByRecipeCompact.checked := false;
  end;

  FormatSettings.ThousandSeparator := ' ';
  FormatSettings.CurrencyString := '';
  with tvSale.DataController.Summary do begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(clmGridDBSUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then begin
      lbSumm.Caption := StringReplace(FloatToStrF(FooterSummaryValues[AIndex], ffCurrency, 10, 2), '.', ',', [rfReplaceAll]);
      FSummZakaz     := FooterSummaryValues[AIndex];
    end else begin
      lbSumm.Caption := '0,00';
      FSummZakaz     := 0;
    end;

    AIndex :=  FooterSummaryItems.IndexOfItemLink(clmGridDBTableView1DISCOUNT_SUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then begin
      FSummDiscount     := FooterSummaryValues[AIndex];
    end else begin
      FSummDiscount     := 0;
    end;
    lbSkidka.Caption  := 'Скидка ' + FormatFloat('0.00', FSummDiscount);

    AIndex :=  FooterSummaryItems.IndexOfItemLink(clmGridDBTableView1AMOUNT);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      lbTovarov.Caption := 'Товаров ' + FormatFloat('0.'.PadRight(2 + FormatSettings.CurrencyDecimals, '0'), FooterSummaryValues[AIndex])
    else
      lbTovarov.Caption := 'Товаров ' + FormatFloat('0.'.PadRight(2 + FormatSettings.CurrencyDecimals, '0'), 0);

    lbNaimenovanii.Caption := 'Наименований ' + FormatFloat('0.'.PadRight(2 + FormatSettings.CurrencyDecimals, '0'), spReadTmp.RecordCount);
  end
end;

procedure TSaleModeForm.aDoSaleExecute(Sender: TObject);
var pnt, res, MethodLoc, TransactionIDLoc : string;
    onEditChng : TNotifyEvent;
    SalePaymentForm: TSalePaymentForm;
    StrArr, StrNote: string;
    SumBonusCurrent : Double;
    PrintOnFrLoc, PrintOnPrintersLoc : Boolean;
    GPaymentType : Int64;
    sss, ss: Double;
    TypeTis: Integer;
begin
  pnt := '01';
  SumBonusCurrent := spReadTmp.FieldByName('SUM_TO_CHARGE_BONUS').AsFloat * FBonusPercent;
  SalePaymentForm := TSalePaymentForm.Create(Self);
  with SalePaymentForm do
  begin
    try
      lbSummSelf.Caption := lbSumm.Caption;
      SummZakaz  := FSummZakaz;
      SummZakazToChargeBonus := SumBonusCurrent;
      SummBonus  := FSummBonus;
      MaxBonusPaySumm := FMaxBonusPaySumm;
      BonusPercent := FBonusPercent;
      PaymentType := spPostavshik.FieldByName('is_beznal').AsInteger;
      ClientAddress := FClientAddress;
      ClientIdn := FClientIdn;
      is_Credit := isCredit;

      if (CheckPrintDeviceFr = 6) and (cbFiscalMode.Checked and PrintOnFr) then
      begin
        case Terminal of
          1:
          begin
            spPaymentTypes.Filtered := False;
            spPaymentTypes.Filter := 'IS_TIS_TYPE>0 AND IS_TIS_TYPE<3';
            spPaymentTypes.Filtered := True;
          end;
          2:
          begin
            spPaymentTypes.Filtered := False;
            spPaymentTypes.Filter := 'IS_TIS_TYPE>=3';
            spPaymentTypes.Filtered := True;
          end;
        end;
      end
      else
      begin
        spPaymentTypes.Filtered := False;
        spPaymentTypes.Filter := '';
      end;

      TypeTis := 0;
      if ShowModal = mrOk then
      begin
        if (CheckPrintDeviceFr = 6) and (cbFiscalMode.Checked and PrintOnFr) then
        begin
          if spPaymentTypes.Active then
          begin
            spPaymentTypes.Locate('G_NONCASH_PAY_TYPE', NonCashPayType, [loCaseInsensitive]);
            TypeTis := spPaymentTypes.FieldByName('IS_TIS_TYPE').AsInteger;
          end;
        end
        else
          TypeTis := 0;

        with spInsZakaz do
        begin
          ParamByName('Z_DATE_').AsDate := Date;
          ParamByName('Z_TIME_').AsTime := Time;
          ParamByName('IS_SPISANIE_').AsInteger := 0;
          ParamByName('ADDRESS_').AsString := mAddress.Text;
          //if lePostavshik.EditValue > 0 then
          if peClientTag > 0 then
            ParamByName('G_CLIENT_').AsInt64 := peClientTag;

          //----------------------------------------
          ParamByName('summ_').AsFloat := FSummZakaz;
          spInsZakaz.ParamByName('summ_fact_').AsFloat := SummCashForSave + SummNonCashForSave;
          spInsZakaz.ParamByName('SUMM_CASH_').AsFloat := SummCashForSave;
          spInsZakaz.ParamByName('SUMM_NONCASH_').AsFloat := SummNonCashForSave;

          if (SummCashForSave = 0) and (SummNonCashForSave > 0) then begin  //пока сделаю так, что безнал только в этом случае, в остальных - нал
            GPaymentType := 2;
            ParamByName('G_PAYMENT_TYPE_').AsInt64 := GPaymentType;
            ParamByName('PAYMENTS_').Clear;
          end else
          begin
            GPaymentType := 1;
            ParamByName('G_PAYMENT_TYPE_').AsInt64 := GPaymentType;

            if (SummCashForSave > 0) and (SummNonCashForSave > 0) then begin
              StrArr := '0-' + DateToStr(Date) + '-' + FloatToStr(SummCashForSave) + '-' + '1' +
                '~0-' + DateToStr(Date) + '-' + FloatToStr(SummNonCashForSave) + '-' + '2~';

              StringReplace(StrArr, ',', '.', [rfReplaceAll, rfIgnoreCase]);   //заменяю на всякий случай запятые на точки
              ParamByName('PAYMENTS_').AsString := StrArr;
            end else
              ParamByName('PAYMENTS_').Clear;
          end;
          //----------------------------------------
          if RmkView = 1 then
            ParamByName('by_recipe_').AsInteger := Integer(cbByRecipeCompact.checked)
          else
            ParamByName('by_recipe_').AsInteger := Integer(cbByRecipe.checked);
          ParamByName('IS_RESERVE_').AsInteger := 0;
          {IF cbPayBonus.Checked THEN
            ParamByName('summ_bonus_').AsFloat := MIN(FSummZakaz, SummBonus)  //ЕСЛИ БОНУСОВ БОЛЬШЕ ЧЕМ СУММА ЗАКАЗА, ТО ПОДСТАВЛЯЮ СУММУ ЗАКАЗА, ИНАЧЕ - ПОДСТАВЛЯЮ СУММУ БОНУСОВ
          else
            ParamByName('summ_bonus_').AsFloat := 0;}

          ParamByName('summ_bonus_').AsFloat := SummBonusForSave;
          ParamByName('summ_bonus_got_').AsFloat := edBonus.Value;            //ПЕРЕДАЮ СУММУ НАЧИСЛЕННЫХ БОНУСОВ ЗА ЗАКАЗ
          SumBonusCurrent := edBonus.Value;
          if (CheckPrintDeviceFr in [2,3,4]) and (Assigned(KKMPrinterStrih)) and (cbFiscalMode.Checked and PrintOnFr) then
            StrNote := 'Чек ОФД ' + KKMPrinterStrih.GetTicketNum
          else
            StrNote := '';
          ParamByName('note_').AsString := mNote.Text + ' ' + StrNote;

          // надо ли заносить продажу в отдельную таблицу для выгрузки в XML
          if (StrToInt(Copy(ExportDataType, 5, 1)) = 1) or (UploadToMobile) then
            ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 1
          else
            ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;

          ParamByName('NOT_MINUS_OSTATOK_').AsInteger := 0;

          // пользователя буду подставлять того, который выбран в поле "Сотрудник"
          if (ShowKassirPanel = 1) and (peOfficialTag > 0) then
            ParamByName('G_OFFICIAL_').AsInt64 := peOfficialTag;

          ParamByName('user_id_').AsInt64 := CurrentOfficial;
          ParamByName('log_body_').AsString := FillLog(ParamByName('Z_DATE_').AsDate, ParamByName('Z_TIME_').AsTime,
          ParamByName('summ_').AsFloat, ParamByName('summ_fact_').AsFloat,
          ParamByName('summ_bonus_got_').AsFloat, ParamByName('summ_bonus_').AsFloat,
          ParamByName('SUMM_CASH_').AsFloat, ParamByName('SUMM_NONCASH_').AsFloat);

          if NonCashPayType > 0 then
            ParamByName('G_NONCASH_PAY_TYPE_').AsInt64 := NonCashPayType
          else
            ParamByName('G_NONCASH_PAY_TYPE_').Clear;

          if ((PosTerminalProcessMethod <> '') and (PosTerminalProcessTransactionID <> '')) then
          begin
            ParamByName('POS_PAY_METHOD_').AsString := PosTerminalProcessMethod;
            ParamByName('POS_PAY_TRANSACTION_ID_').AsString := PosTerminalProcessTransactionID;
          end;

          if Assigned(KKMTIS) then
            ParamByName('REQUEST_NUMBER_').AsString := KKMTIS.Request
          else
            ParamByName('REQUEST_NUMBER_').AsString := '';
        end;

        pnt := '02';

        IF ExecSPTr(spInsZakaz) THEN
        BEGIN
          pnt := '06';
          sdacha   := Sdacha;

          // автоматически печатаю чек, если стоит галочка
          pnt := '07';
          LastCheck := spInsZakaz.ParamByName('zakaz_').AsInt64;
          //if (CbPrintbill.checked) or (cbPrintBillCompact.Checked) then
          // если подключен фискальный регистратор и человек убрал галочку "Фискальный режим",
          // то по-любасу печатаю на принтере чеков. Пока так.
          if (PrintOnPrinters and cbPrintOnPrinter.Checked) or (PrintOnFr and cbFiscalMode.Checked) or
             ((PrintOnFr = True) and (cbFiscalMode.Checked = False) and (PrintOnPrinters = True))
          then
          begin
            PrintOnFrLoc := (PrintOnFr and cbFiscalMode.Checked);

            if (CheckPrintDeviceFr = 6) and (PrintOnFrLoc) and (Assigned(KKMTIS)) then
            begin
              if (KKMTIS.Request <> '') then
                PrintOnFrLoc := False;
            end;

            // если идет печать чеков на ФР, то нехуй дублировать на принтер
            if PrintOnFrLoc = True then
              PrintOnPrintersLoc := False
            else
              PrintOnPrintersLoc := PrintOnPrinters;

            ReportsDM.PrintBill(LastCheck, FSummZakaz, SummCashPaidFact, SummNonCashForSave, Sdacha, 0,
              FormatSettings.CurrencyDecimals, SumBonusCurrent, mAddress.Text,
              False, PrintOnPrintersLoc, PrintOnFrLoc, SummBonus-SummBonusForSave+SumBonusCurrent,
              TypeTis);

          end;

          // прибавлю к накопленным бонусам текущего клиента бонусы от покупок
          // или отниму, если оплата бонусами идет, но бонусы прибавляю в любом случае
          //pnt := '05';
          //if cbPayBonus.Checked then
          //  FSummBonus := FSummBonus - MIN(FSummZakaz, FSummBonus);

          //FSummBonus := FSummBonus + edBonus.Value;
          //РАНЬШЕ БЫЛО ТАК, ЧТО КЛИЕНТ ПОСЛЕ ПРОДАЖИ ОСТАВАЛСЯ ПРЕЖНИМ, ТЕПЕРЬ ЖЕ КЛИЕНТ МЕНЯЕТСЯ НА ЧАСТНОЕ ЛИЦО, ПОЭТОМУ FSummBonus НАДО ЗАНУЛЯТЬ
          FSummBonus := 0;

          //переставлю обратно на клиента, который указан как по умолчанию, в данном режиме это частное лицо
          {if lePostavshik.EditValue <> 10 then begin
            with lePostavshik do begin
              onEditChng := Properties.OnChange;         //чтобы лишний раз на lePostavshik.OnChange не срабатывал ReadList
              Properties.OnChange := nil;
              EditValue := 10;
              Properties.OnChange := onEditChng;
              RefreshClient(false);
            end;
          end;}

          if peCLientTag <> 10 then begin
            OpenSp(spPostavshik, false);
            SetpeClient(10);
            RefreshClient(false);
          end;

          //поставлю обратно кассиром текущего пользователя
          aSetOfficialDefault.Execute;
          edSearch.Clear;

          ReadList;

          if (ShowTovarPanel = 1) and (KafeTovarView = 0) and (RmkView = 0) then begin
            spRead.Locate('G_product', -1, []);
            edSearch.SetFocus;
          end;

          //end;
        END;
      end;
    finally
      Free;
    end;
  end;
end;

function TSaleModeForm.FillLog(ODate : TDate; OTime : TTime; Summ, SummFact, Bonus, BonusPayed, SummCash, SummNonCash : Double) : String;
var i : integer;
begin
  Result := FillInsWayBill(1, ODate, OTime, peClient.Text, Summ,
    SummFact, Bonus, BonusPayed, spReadTmp);

  Result := Result + CRLF + 'Платежи.' + CRLF;
  if (SummCash + SummNonCash) = 0 then
    Result := Result + 'Платежи не произведены.' + CRLF

  else begin
    if SummCash > 0 then
      Result := Result + '- наличный, дата "' + DateToStr(ODate) + '", сумма "' + FloatToStr(SummCash) + '".' + CRLF;

    if SummNonCash > 0 then
      Result := Result + '- безналичный, дата "' + DateToStr(ODate) + '", сумма "' + FloatToStr(SummNonCash) + '".' + CRLF;
  end;
end;

procedure TSaleModeForm.aDelExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_DEL_TMP, 0, 0);
end;

procedure TSaleModeForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //lePostavshik.Properties.OnChange := nil;

  inherited;
  //ОЧИЩАЮ ВРЕМЕННУЮ ТАБЛИЦУ
  ClearTempTable;
end;

procedure TSaleModeForm.aFindAndInsExecute(Sender: TObject);
begin
  // поиск заказа для возврата
  IF (Length(KeysBuffer) = 15) and (Copy(KeysBuffer, 1, 3) = 'SHO') THEN BEGIN
    try
      spFindZakazByBarcode.ParamByName('barcode_').AsString := KeysBuffer;
      OpenSp(spFindZakazByBarcode, False);
      PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
      PrihodTovaraNForm.Zakaz := spFindZakazByBarcode.FieldByName('Zakaz').AsLargeInt;
      PrihodTovaraNForm.ZakazNote := spFindZakazByBarcode.FieldByName('Note').AsString;
      PrihodTovaraNForm.OpenMode := omInsert;
      PrihodTovaraNForm.Is_vozvrat := 1;
      if PrihodTovaraNForm.ShowModal = mrOK then
        ShowMessage('Возврат оформлен успешно!');
    finally
       FreeAndNil(PrihodTovaraNForm);
    end;
  END

  // поиск товара
  ELSE BEGIN
    spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
    if UseScales = 1 then
      spFindProduct.ParamByName('PREFIX_').AsString := ScalesPrefix
    else
      spFindProduct.ParamByName('PREFIX_').AsString := '';

    try
      if not spFindProduct.Transaction.InTransaction then
        spFindProduct.Transaction.StartTransaction;

      IF ExecSPTR(spFindProduct) THEN begin
        FTovar.Product := spFindProduct.ParamByName('G_PRODUCT_').AsInt64;
        FTovar.Product_Par := spFindProduct.ParamByName('g_product_category_').AsInt64;
        FTovar.IsKit       := spFindProduct.ParamByName('is_kit_').AsInteger;
        if OptPriceByDefault = 0 then
          FTovar.Price := spFindProduct.ParamByName('price_').AsFloat
        else
          FTovar.Price := spFindProduct.ParamByName('volume_price_').AsFloat;

        FTovar.Amount := spFindProduct.ParamByName('amount_').AsFloat;

        FTovar.cbPrice  := 0;
        FTovar.cbSkidka := 0;
        FTovar.Barcode := KeysBuffer;
        FTovar.IsMarked := spFindProduct.ParamByName('Is_Marked_').AsInteger;
        FTovar.IsTovarVes := spFindProduct.ParamByName('Is_weight_').AsInteger;

        FTovar.VesGrammPrice := spFindProduct.ParamByName('ves_gramm_price_').AsFloat;

        LocateFindedTovar;
        Insdata;
      end;
    except
      on E: Exception do
        MessageDlg(E.Message + #13#10'(occured in TSaleModeForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
    end;

    spFindProduct.ParamByName('BARCODE_').AsString := '';
  END;
end;

procedure TSaleModeForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  enableConnectAutoCheck : integer;
  str : string;
begin
  // ДЕЛАЮ ЧЕКБОКСЫ КНОПКАМИ
  {SetWindowLong(cbPrintBill.Handle, GWL_STYLE, GetWindowLong(cbPrintBill.Handle, GWL_STYLE) or BS_PUSHLIKE);
  SetWindowLong(cbByRecipe.Handle, GWL_STYLE, GetWindowLong(cbByRecipe.Handle, GWL_STYLE) or BS_PUSHLIKE);
  SetWindowLong(cbRozn.Handle, GWL_STYLE, GetWindowLong(cbRozn.Handle, GWL_STYLE) or BS_PUSHLIKE);
  SetWindowLong(cbOpt.Handle, GWL_STYLE, GetWindowLong(cbOpt.Handle, GWL_STYLE) or BS_PUSHLIKE);}

  // кнопки не переносят на другую строку по умолчанию, придется тут вручную делать
  btnFindDlg.Caption := 'Ручной поиск (F8)';
  btnReturn.Caption := 'Возврат'#13#10'товара (F10)';
  btnFindAnalog.Caption := 'Найти'#13#10'аналоги (F11)';

  if FileExists(extractfilepath(Application.ExeName)+'Button_colors.ini') then begin
    //открыли файл в директории программы
    Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Button_colors.ini', TEncoding.UTF8);
    try
      btnDoSale.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'SaleBtn', '239B56'));
      btnDoSale.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'SaleBtn', '239B56'));
      btnDoSale.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'SaleBtnDisabled', '239B56'));  //2ECC71
      lbSumm.Font.Color := HexToTColor(Ini.ReadString('SaleMode', 'SaleBtn', '239B56'));

      btnFindDlg.LookAndFeel.NativeStyle := False;
      btnFindDlg.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnFindDlg', '2E86C1'));
      btnFindDlg.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnFindDlg', '2E86C1'));
      btnFindDlg.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnFindDlgDisabled', '2E86C1'));

      btnShowFastTovar.LookAndFeel.NativeStyle := False;
      btnShowFastTovar.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnShowFastTovar', '2E86C1'));
      btnShowFastTovar.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnShowFastTovar', '2E86C1'));
      btnShowFastTovar.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnShowFastTovarDisabled', '2E86C1'));

      btnReturn.LookAndFeel.NativeStyle := False;
      btnReturn.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnReturn', 'CB4335'));
      btnReturn.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnReturn', 'CB4335'));
      btnReturn.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnReturnDisabled', 'CB4335'));

      btnGetDCard.LookAndFeel.NativeStyle := False;
      btnGetDCard.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnGetDCard', 'F4D03F'));
      btnGetDCard.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnGetDCard', 'F4D03F'));
      btnGetDCard.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnGetDCardDisabled', 'F4D03F'));

      btnRefreshChd.LookAndFeel.NativeStyle := False;
      btnRefreshChd.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnRefreshChd', '2E86C1'));
      btnRefreshChd.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnRefreshChd', '2E86C1'));
      btnRefreshChd.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnRefreshChdDisabled', '2E86C1'));

      btnInsLike.LookAndFeel.NativeStyle := False;
      btnInsLike.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnInsLike', '2E86C1'));
      btnInsLike.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnInsLike', '2E86C1'));
      btnInsLike.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnInsLikeDisabled', '2E86C1'));

      btnUpdChd.LookAndFeel.NativeStyle := False;
      btnUpdChd.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnUpdChd', 'F4D03F'));
      btnUpdChd.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnUpdChd', 'F4D03F'));
      btnUpdChd.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnUpdChdDisabled', 'F4D03F'));

      btnDelChd.LookAndFeel.NativeStyle := False;
      btnDelChd.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnDelChd', 'F4D03F'));
      btnDelChd.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnDelChd', 'F4D03F'));
      btnDelChd.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnDelChdDisabled', 'F4D03F'));

      btnDelAll.LookAndFeel.NativeStyle := False;
      btnDelAll.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnDelAll', 'F4D03F'));
      btnDelAll.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnDelAll', 'F4D03F'));
      btnDelAll.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnDelAllDisabled', 'F4D03F'));

      btnPutAside.LookAndFeel.NativeStyle := False;
      btnPutAside.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnPutAside', '2E86C1'));
      btnPutAside.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnPutAside', '2E86C1'));
      btnPutAside.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnPutAsideDisabled', '2E86C1'));

      btnSetDiscountAll.LookAndFeel.NativeStyle := False;
      btnSetDiscountAll.Colors.Default := HexToTColor(Ini.ReadString('SaleMode', 'btnSetDiscountAll', '2E86C1'));
      btnSetDiscountAll.Colors.Pressed := HexToTColor(Ini.ReadString('SaleMode', 'btnSetDiscountAll', '2E86C1'));
      btnSetDiscountAll.Colors.Disabled := HexToTColor(Ini.ReadString('SaleMode', 'btnSetDiscountAllDisabled', '2E86C1'));
      stlHeader.Color := HexToTColor(Ini.ReadString('SaleMode', 'grHeaders', '2E86C1'));

    finally
      Ini.Free;
    end;
  end;

  //ОЧИЩАЮ ВРЕМЕННУЮ ТАБЛИЦУ
  ClearTempTable;
  FNotFirst := False;

  //открыли файл в директории программы
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    //cbPrintBill.Checked := Ini.ReadInteger('PrintBill', 'PrintOnSale', 0) = 1;
    //cbPrintBillCompact.Checked := Ini.ReadInteger('PrintBill', 'PrintOnSale', 0) = 1;
    tlCategory.Height := Ini.ReadInteger('SaleMode', 'tlCategory', 130);
    if ShowTovarPanel = 1 then
      pnRight.Width := Ini.ReadInteger('SaleMode', 'pnRight', Round(SelfWidth/2))
    else
      pnRight.Align := alClient;

    pnButtonsLeft.Width := Ini.ReadInteger('SaleMode', 'pnButtonsLeft', Round(SelfWidth/2));
    pnlImg.Height := Ini.ReadInteger('SaleMode', 'pnlImgHeight', Round(pnRight.Height/4));
    enableConnectAutoCheck := Ini.ReadInteger('SaleMode', 'ConnectAutoCheck', 0);
  finally
    Ini.Free;
  end;

  //отражать панель товаров или нет
  if ShowTovarPanel = 0 then begin
    pnlTovarMain.Visible := False;
    splMenu.Visible := False;
    aFindDlg.Visible := True;
  end else begin
    aFindDlg.Visible := False;
  end;

  //отражать ли панель с выбором сотрудников
  if ShowKassirPanel = 1 then begin
    pnOfficial.Visible := True;
    aSetOfficialDefault.Execute;
  end;

  // показывать ли кнопку для создания новых клиентов
  if ShowInsClientBtn = 1 then begin
    aInsClient.Visible := True;
    aInsClient.Enabled := True;
  end else begin
    aInsClient.Visible := False;
    aInsClient.Enabled := False;
  end;

  inherited;

  OpenSp(spPostavshik, False);
  //lePostavshik.EditValue := 10; //ПОСТАВЛЮ ЧАСТНОЕ ЛИЦО АВТОМАТОМ
  SetpeClient(10);

  FSkidka := spPostavshik.FieldByName('skidka').AsFloat;

  //aIns.ShortCut := TextToShortCut('Enter');
  aDoSale.Enabled := False;
  aUpd.ShortCut := TextToShortCut('F6');
  aInsTov.ShortCut  :=  TextToShortCut('F5');
  aUpd.Caption := '';  // иначе откуда-то упорно появляется надпись изменить
  aDel.Caption := '';  // иначе откуда-то упорно появляется надпись изменить
  aRefresh.Caption := '';  // иначе откуда-то упорно появляется надпись изменить
  aClose.Caption := '';  // иначе откуда-то упорно появляется надпись изменить

  //ставлю крупные шрифты в гридах
  tvSale.Styles.Header.Font.Size := 11;
  grSale.Font.Size := 11;
  tvProduct.Styles.Header.Font.Size := 11;
  grProduct.Font.Size := 11;
  if Screen.PixelsPerInch = 120 then
    btnGetDCard.Font.Size := 11;       //иначе почему-то становиться слишком большой

  // если конфигурация аптека, то отражаю специфичную кнопку
  if RmkView = 1 then begin
    lcByRecipe.Visible := Config = 1;
    lcByRecipeEmptyItem.Visible := lcByRecipe.Visible;
  end else begin
    if Config = 1 then
      cbByRecipe.Visible := True
    else
      cbByRecipe.Visible := False;
  end;

  // если конфигурация магазин автозапчастей, то отражаю специфичную кнопку
  if Config = 2 then begin
    aFindAnalog.Visible := True;
    lcFindAnalog.Visible := True;
    lcFindAnalogEmptyItem.Visible := False;
    if ShowTovarPanel = 1 then
      aFindAnalog.Enabled := True            // кнопку отражаю только если панель товаров есть
    else
      aFindAnalog.Enabled := False;
  end else begin
    aFindAnalog.Visible := False;
    aFindAnalog.Enabled := False;
    lcFindAnalog.Visible := False;
    lcFindAnalogEmptyItem.Visible := True;
    clmCrosscode.Destroy;
  end;

  if Config <> 4 then begin
    clmVES_GRAMM.Destroy;
    clmVES_GRAMM_PRICE.Destroy;
  end;

  if High(SkladArr) > 0 then
    aTovarAmountBySklad.Visible := True
  else
    aTovarAmountBySklad.Visible := False;

  aReturn.Visible := HaveRightToVozvrat;
  aReturn.Enabled := aReturn.Visible;
  lcVozvratItem.Visible := aReturn.Visible;
  lcVozvratEmptyItem.Visible := lcVozvratItem.Visible = False;

  pnlCompactView.Visible := RmkView = 1;

  if KafeTovarView = 1 then begin
    pnTovar.Visible := False;
    aAddServiceSumm.Visible := True;
    tlCategory.DataController.DataSource := nil;
    tvProduct.DataController.DataSource  := nil;
    aFindDlg.Visible := True;
  end
  else if RmkView = 1 then begin
    aFindDlg.Visible := True;
    pnTovar.Visible := False;
    tlCategory.DataController.DataSource := nil;
    tvProduct.DataController.DataSource  := nil;
    pn7.Visible := False;
    pnWithBottomButtons.Visible := False;
    pnRight.Width := SelfWidth - Round(SelfWidth/3.5);
    {btnDoSaleCompact.Colors.Default    := HexToTColor('17A589');
    btnDoSaleCompact.Colors.Pressed   := HexToTColor('17A589');
    btnDoSaleCompact.Colors.DefaultText   := clWhite;
    btnDoSaleCompact.Colors.PressedText  := clWhite;
    btnDelCompact.Colors.Default      := HexToTColor('CB4335');
    btnDelCompact.Colors.Pressed      := HexToTColor('CB4335');
    btnDelCompact.Colors.DefaultText   := clWhite;
    btnDelCompact.Colors.PressedText  := clWhite;
    btnDelAllCompact.Colors.Default      := HexToTColor('CB4335');
    btnDelAllCompact.Colors.Pressed      := HexToTColor('CB4335');
    btnDelAllCompact.Colors.DefaultText   := clWhite;
    btnDelAllCompact.Colors.PressedText  := clWhite;}
    btnUpdCompact.OptionsImage.ImageIndex := -1;
    btnDelCompact.OptionsImage.ImageIndex := -1;
    btnDelAllCompact.OptionsImage.ImageIndex := -1;
  end;

  if (RmkView = 0) and (KafeTovarView = 0) and (ShowTovarPanel = 1) then
    edSearch.SetFocus
  else
    grSale.SetFocus;

  if ShowProductImg = 1 then begin
    pnlImg.Visible := True;
    splSale1.Visible := True;
  end;

  // надо постраивать под размер экрана
  // есть планшеты с разрешением 800х600 и есть моноблоки с разрешением 1024х768
  if pnlCompactView.Visible then begin
    if (Screen.Height > 600) and (Screen.Height <= 768) then begin
      dxLayoutItem1.Height := 70;
      lcCompactViewItem1.Height := 70;
      lcCompactViewItem2.Height := 70;
      lcCompactViewItem3.Height := 70;
      lcVozvratEmptyItem.Height := 70;
      lcVozvratItem.Height := 70;
      lcCompactViewItem4.Height := 70;
      lcCompactViewItem5.Height := 70;
      lcCompactViewItem7.Height := 70;
      lcCompactViewItem8.Height := 70;
      lcFindAnalog.Height := 70;
      lcFindAnalogEmptyItem.Height := 70;

      btnFindDlgCompact.Font.Size := 10;
      btnShowFastTovarCompact.Font.Size := 10;
      btnInsTov.Font.Size := 10;
      btnUpdCompact.Font.Size := 10;
      btnDelAllCompact.Font.Size := 10;
      btnDelCompact.Font.Size := 10;
      btnPutAsideCompact.Font.Size := 10;
      btnSetDiscountAllCompact.Font.Size := 10;
      btnFindAnalogCompact.Font.Size := 10;
      btnReturnCompact.Font.Size := 10;
      cbByRecipeCompact.Style.Font.Size := 10;
    end;

    if Screen.Height <= 600 then begin
      dxLayoutItem1.Height := 50;
      lcCompactViewItem1.Height := 50;
      lcCompactViewItem2.Height := 50;
      lcCompactViewItem3.Height := 50;
      lcVozvratEmptyItem.Height := 50;
      lcVozvratItem.Height := 50;
      lcCompactViewItem4.Height := 50;
      lcCompactViewItem5.Height := 50;
      lcCompactViewItem7.Height := 50;
      lcCompactViewItem8.Height := 50;
      lcFindAnalog.Height := 50;
      lcFindAnalogEmptyItem.Height := 50;

      btnFindDlgCompact.Font.Size := 8;
      btnShowFastTovarCompact.Font.Size := 8;
      btnInsTov.Font.Size := 8;
      btnUpdCompact.Font.Size := 8;
      btnDelAllCompact.Font.Size := 8;
      btnDelCompact.Font.Size := 8;
      btnPutAsideCompact.Font.Size := 8;
      btnSetDiscountAllCompact.Font.Size := 8;
      btnFindAnalogCompact.Font.Size := 8;
      btnReturnCompact.Font.Size := 8;
      cbByRecipeCompact.Style.Font.Size := 8;
      btnDoSaleCompact.Font.Size := 10;

      btnGetDCard.Font.Size := 8;
      btnSetOfficialDefault.Font.Size := 8;
      lbOfficial.Font.Size := 10;
      lbClient.Font.Size := 10;
    end;
  end;

end;

function TSaleModeForm.FuncGetLastPrice(GProduct : Int64): Boolean;
begin
  Result := True;

  GetLastPrice.ParamByName('MODE_').AsIntEGER := 1;
  GetLastPrice.ParamByName('G_PRODUCT_').AsInt64 := GProduct;
  GetLastPrice.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
  IF ExecSPWT(GetLastPrice) THEN
    FCOST_PRICE := GetLastPrice.ParamByName('price_').AsFloat
  ELSE
    Result := False;
end;

function TSaleModeForm.CanUpdItem: Boolean;
var SalePinCodeForm : TSalePinCodeForm;
begin
  Result := false;

  if PinCodeForDelItems <> '' then begin
    SalePinCodeForm := TSalePinCodeForm.Create(Application);
    try
      if SalePinCodeForm.ShowModal = mrOk then begin
        if SalePinCodeForm.edPinCode.text <> PinCodeForDelItems then begin
          MessageDlg('ПИН-код неверный. Удаление невозможно.', mtWarning, [mbOk], 0);
          Exit;
        end;

        Result := true;
      end else
        Exit;
    finally
      SalePinCodeForm.Free;
    end;
  end
  else
    Result := true;
end;

procedure TSaleModeForm.cbPrintBillCompactPropertiesChange(Sender: TObject);
begin
  //cbPrintBill.Checked := cbPrintBillCompact.Checked;
end;

procedure TSaleModeForm.cbPrintBillPropertiesChange(Sender: TObject);
begin
  //cbPrintBillCompact.Checked := cbPrintBill.Checked;
end;

procedure TSaleModeForm.ClearTempTable;
begin
  spDel.Params[0].Clear;
  ExecSPTR(spDel);
end;

procedure TSaleModeForm.ApplicationEventsMessage(var Msg: tagMSG;
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
            TimerSearch.Enabled := False;
            edSearch.Clear;
            aFindAndIns.Execute;
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

procedure TSaleModeForm.edSearchChange(Sender: TObject);
begin
  TimerSearch.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edSearch.Text <> '' then
    TimerSearch.Enabled := True
  else BEGIN
    with spReadTovar do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TSaleModeForm.edSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {if Key = VK_UP then
    tvProduct.Controller.FocusNextRecord(tvProduct.Controller.FocusedRecordIndex, false, False, false, false)
  else if Key = VK_DOWN then
    tvProduct.Controller.FocusNextRecord(tvProduct.Controller.FocusedRecordIndex, true, False, false, false);
  }
  if Key = VK_UP then
    spReadTovar.Prior
  else if Key = VK_DOWN then
    spReadTovar.Next;
end;

procedure TSaleModeForm.TimerSearchTimer(Sender: TObject);
var s : string;
begin
  TimerSearch.Enabled := False;
  if (edSearch.text <> '') then BEGIN
    with spReadTovar do begin
      s := '(NAME CONTAINING ''' + edSearch.text + ''') OR (ARTICUL CONTAINING ''' + edSearch.text + ''') OR (BARCODE CONTAINING '''+ edSearch.text + ''')' +
      ' OR (NOMENCLATUR_NUM CONTAINING '''+ edSearch.text + ''')';

      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edSearch.text + ''')';

      if UseTovarNoteInSearch = 1 then
        s := s + ' OR (NOTE CONTAINING ''' + edSearch.text + ''')';

      if Config = 2 then
        s := s + ' OR (CROSSCODE CONTAINING ''' + edSearch.text + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if tvProduct.Controller.FocusedRow <> Nil then begin
      if tvProduct.Controller.SelectedRowCount > 0 then
        tvProduct.Controller.SelectedRows[0].Selected := False;
      tvProduct.Controller.FocusedRow.Selected := True;
    end;
    RefreshTovarRekv;
  END;
end;

procedure TSaleModeForm.aGetDCardExecute(Sender: TObject);
var GetDCardForm: TGetDCardForm;
begin
  GetDCardForm := TGetDCardForm.Create(Self);
  with GetDCardForm do begin
    try
      GetDCardForm.Discont_card := spPostavshik.FieldByName('g_discont_card').AsLargeInt;
      if Showmodal = mrOK then begin
        if Client <> 0 then begin
          //lePostavshik.EditValue := Client;
          SetpeClient(Client);
          RefreshClient;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TSaleModeForm.lePostavshikPropertiesChange(Sender: TObject);
begin
  RefreshClient;
end;

procedure TSaleModeForm.RefreshClient(DoRefresh : Boolean = true);
begin
  FSkidka := spPostavshik.FieldByName('skidka').AsFloat;

  //ЗАПОЛНЯЮ СВЕДЕНИЯ ПО БОНУСАМ
  FBonusPercent := spPostavshik.FieldByName('N_PERCENT').AsFloat/100;
  FSummBonus := spPostavshik.FieldByName('SUMM').AsFloat;
  FMaxBonusPaySumm := spPostavshik.FieldByName('MAX_BONUS_PAY_SUMM').AsFloat;
  FClientAddress := spPostavshik.FieldByName('Address').AsString;
  FClientIdn := spPostavshik.FieldByName('Idn').AsString;

  if DoRefresh then begin
    spUpdZakazDetailsTmpPrices.ParamByName('CLIENT_SKIDKA_').AsFloat := FSkidka;
    spUpdZakazDetailsTmpPrices.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
    ExecSPTR(spUpdZakazDetailsTmpPrices);

    RefreshTmp;
  end;

  grSale.SetFocus;
end;

procedure TSaleModeForm.FlowPanelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  ScrollBox.SetFocus;
end;

procedure TSaleModeForm.FormActivate(Sender: TObject);
begin
  inherited;

  //каким-то образом, при выходе из базы, попадало сюда, а на тот момент база уже отключена, соответственно выходила ошибка при spPostavshik.ReopenLocate,
  //поэтому поставил дополнительно проверку, делать это только если коннект к БД есть
  if (FNotFirst) and (MainDM.dbMain.Connected) then
    spPostavshik.ReopenLocate('g_client')
  else
    FNotFirst := True;
end;

procedure TSaleModeForm.aHelpExecute(Sender: TObject);
begin
  HelpC := 16;
  inherited;
end;

procedure TSaleModeForm.aRefreshExecute(Sender: TObject);
begin
  FrefreshProdBook := True;
  dxBarButtonEnableAutoRefresh.Down := False;   //чтоб не работало автообновление
  inherited;
end;

procedure TSaleModeForm.aInsFirstExecute(Sender: TObject);
begin
  // в общем непонятно почему, но перестал отлавливаться нажатие клавиши Ентер
  // в ApplicationEvents, если у aIns стоит shortcut клавиша Ентер, не понял
  // с чем связано, почему-то такое поведение именно у aIns. Как всегда времени
  // и желания не было выяснять и потому сделал этот акшн и ему присвоил в
  // шорткат клавишу Ентер
  aIns.Execute;
end;

procedure TSaleModeForm.aClearSearchExecute(Sender: TObject);
begin
  edSearch.Clear;
  edSearch.SetFocus;
  aIns.Enabled := spReadTovar.RecordCount > 0;
end;

procedure TSaleModeForm.aDelAllExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLEARZAKAZ, 0, 0);
end;

procedure TSaleModeForm.WMClearzakaz(var Message: TMessage);
begin
  if CanUpdItem then begin
    Cleartemptable;
    RefreshTmp;
  end;
end;

procedure TSaleModeForm.WMDelTmp(var Message: TMessage);
begin
  if CanUpdItem then  begin
    if MessageDlg(Format('Удалить товар "%s" ?',
      [spReadTmp.FieldByName('PRODUCT_NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    spDel.ParamByName('zakaz_details_').AsInt64 := spReadTmp.FieldByName('zakaz_details').AsLargeInt;
    if ExecSPTR(spDel) then
      RefreshTmp;
  end;
end;

procedure TSaleModeForm.aFindAnalogExecute(Sender: TObject);
var s : string;
begin
  IF CONFIG = 2 THEN BEGIN
    s := spReadTovar.FieldByName('articul').AsString;
    edSearch.Clear;
    spRead.First;
    edSearch.Text := s;
  END;
end;

procedure TSaleModeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  Is_closing := True;
  inherited;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    //if RmkView = 1 then
    //  Ini.WriteInteger('PrintBill', 'PrintOnSale', Integer(cbPrintBillCompact.Checked))
    //else
    //  Ini.WriteInteger('PrintBill', 'PrintOnSale', Integer(cbPrintBill.Checked));
    Ini.WriteInteger('SaleMode', 'tlCategory', tlCategory.Height);
    Ini.WriteInteger('SaleMode', 'pnButtonsLeft', pnButtonsLeft.Width);
    if pnlTovarMain.Visible then
      Ini.WriteInteger('SaleMode', 'pnRight', pnRight.Width);   // если панель товаров скрыта, то не надо сохранять ширину правой панели - она и так будет на весь экран

    Ini.WriteInteger('SaleMode', 'pnlImgHeight', pnlImg.Height);
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;

  tvSale.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvSale.name);
  tvProduct.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvProduct.name);
end;

procedure TSaleModeForm.aSetDiscountAllExecute(Sender: TObject);
var
  SetSkidkaForm: TSetSkidkaForm;
begin
  SetSkidkaForm := TSetSkidkaForm.Create(Self);
  try

    with SetSkidkaForm do begin
      if ShowModal = mrOk then begin
        spSetDiscountAll.ParamByName('MODE_').AsInteger := cbSkidka.ItemIndex;
        spSetDiscountAll.ParamByName('DISCOUNT_').AsFloat := edSkidkaSumm.Value;
        spSetDiscountAll.ParamByName('DISCOUNT_TENGE_').AsFloat := edSkidkaSumm.Value;

        if ExecSPTR(spSetDiscountAll) then
          RefreshTmp;
      end;
    end;
  finally
    FreeAndNil(SetSkidkaForm);
  end;
end;

procedure TSaleModeForm.aSetOfficialDefaultExecute(Sender: TObject);
begin
  peOfficialTag   := CurrentOfficial;
  peOfficial.Text := CurrentOfficialName;
end;

procedure TSaleModeForm.aShowFastTovarExecute(Sender: TObject);
var
  FastGoodsViewForm: TFastGoodsViewForm;
begin
  FastGoodsViewForm := TFastGoodsViewForm.Create(Application);
  with FastGoodsViewForm do begin
    try
      if ShowModal = mrOk then begin
        FTovar.Product := GProd;
        FTovar.Ostatok := Ostatok;
        if (FTovar.Ostatok > 0) and (FTovar.Ostatok < 1) then
          FTovar.Amount := FTovar.Ostatok
        else
          FTovar.Amount := 1;
        FTovar.IsKit := IsKit;
        if OptPriceByDefault = 0 then
          FTovar.Price := Price
        else
          FTovar.Price := VolumePrice;

        FTovar.VesGrammPrice := VesGrammPrice;
        FTovar.IsMarked := IsMarked;
        FTovar.IsTovarVes := IsTovarVes;

        FInsByFastTovar := True;
        if FuncGetLastPrice(FTovar.Product) = False then begin
          ShowMessage('Произошла ошибка при расчете стоимости товара!');
          Exit;
        end;

        Insdata;
        FInsByFastTovar := False;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TSaleModeForm.aShowPanelTovarExecute(Sender: TObject);
var
  onChangeCat : TcxTreeListFocusedNodeChangedEvent;
begin
  if ShowTovarPanel = 0 then begin
    SaveSettingsIni('SaleMode', 'pnRight', pnRight.Width, '');  // предварительно запомню ширину панели
    pnlTovarMain.Visible := False;
    pnRight.Align := alClient;// .Width := SelfWidth;
    splMenu.Visible := False;
    aFindDlg.Visible := True;
    aFindAnalog.Enabled := False;
    spRead.Close;
  end else begin
    pnRight.Align := alLeft;     // ставлю снова выравнивание по левой стороне
    pnlTovarMain.Visible := True;
    pnRight.Width := ReadIntSettingsIni('SaleMode', 'pnRight', Round(Width/2));
    splMenu.Visible := True;
    pnRight.Left := 0;           //ставлю панель первой слева
    aFindDlg.Visible := False;
    aFindAnalog.Enabled := True;
    onChangeCat := tlCategory.OnFocusedNodeChanged;
    tlCategory.OnFocusedNodeChanged := nil;
    OpenSP(spRead, True);
    aRefreshChild.Execute;
    tlCategory.OnFocusedNodeChanged := onChangeCat;
  end;
end;

procedure TSaleModeForm.aTovarAmountBySkladExecute(Sender: TObject);
var TovarAmountBySkladForm: TTovarAmountBySkladForm;
begin
  TovarAmountBySkladForm := TTovarAmountBySkladForm.Create(Application);
  with TovarAmountBySkladForm do begin
    try
      GProduct := spReadTovar.FieldByName('g_product').AsLargeInt;
      Sklad := CurSklad;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TSaleModeForm.btn1Click(Sender: TObject);
//var str : TStringList;
begin
  //KeysBuffer := edt1.Text;
  //aFindAndIns.Execute;
  //str := TStringList.Create;
  //FreeAndNil(str);
  //str.Insert(1, 'asd');
end;

procedure TSaleModeForm.Button3Click(Sender: TObject);
var MyGUID : TGUID;
begin
  CreateGUID(MyGUID);
  ShowMessage(GUIDToString(MyGUID));
end;

procedure TSaleModeForm.aFindDlgExecute(Sender: TObject);
var SearchTovarDlgForm : TSearchTovarDlgForm;
begin
  //if (ShowTovarPanel = 1) and (RmkView = 0) then begin
  //  if KafeTovarView = 0 then
  //    edSearch.SetFocus
  //end else begin
    SearchTovarDlgForm := TSearchTovarDlgForm.Create(Self);
    with SearchTovarDlgForm do begin
      try
        if ShowModal = mrOk then begin
          FTovar.Product := spSearchTov.FieldByName('G_PRODUCT').AsLargeInt;
          FTovar.Product_Par := spSearchTov.FieldByName('g_product_par').AsLargeInt;
          FTovar.IsKit := spSearchTov.FieldByName('is_kit').AsInteger;
          if OptPriceByDefault = 0 then
            FTovar.Price := spSearchTov.FieldByName('price').AsFloat
          else
            FTovar.Price := spSearchTov.FieldByName('volume_price').AsFloat;
          FTovar.cbPrice  := 0;
          FTovar.cbSkidka := 0;
          FTovar.IsMarked   := spSearchTov.FieldByName('is_marked').AsInteger;
          FTovar.IsTovarVes := spSearchTov.FieldByName('is_weight').AsInteger;
          FTovar.Ostatok  := spSearchTov.fieldByName('amount').AsFloat;
          if (FTovar.Ostatok > 0) and (FTovar.Ostatok < 1) then
            FTovar.Amount := FTovar.Ostatok
          else
            FTovar.Amount := 1;
          FTovar.VesGrammPrice := spSearchTov.FieldByName('ves_gramm_price').AsFloat;
          LocateFindedTovar;
          Insdata;
        end;
      finally
        Free;
      end;
    end;
  //end;
end;

procedure TSaleModeForm.LocateFindedTovar;
var onChange : TNotifyEvent;
    onChangeCat : TcxTreeListFocusedNodeChangedEvent;
    onChangeTov : TcxGridFocusedRecordChangedEvent;
begin
  if (ShowTovarPanel = 1) and (KafeTovarView = 0) and (RmkView = 0)
  and (SetCursorOnTovar = 1) then begin
    onChange := edSearch.OnChange;
    edSearch.OnChange := nil;
    edSearch.Clear;
    spReadTovar.CancelConditions;   //очищаю фильтрацию если было
    spReadTovar.Conditions.Clear;
    edSearch.OnChange := onChange;
    onChangeCat := tlCategory.OnFocusedNodeChanged;
    onChangeTov := tvProduct.OnFocusedRecordChanged;

    Screen.Cursor := crHourGlass;
    tlCategory.OnFocusedNodeChanged := nil;
    tvProduct.OnFocusedRecordChanged  := nil;
    spRead.Locate('g_product', FTovar.Product_Par, []);

    //spReadTovar.ParamByName('g_product_par_').AsInt64 := spRead.FieldByName('g_product').AsLargeInt;
    //spReadTovar.ParamByName('g_tochka_').AsInt64 := CurSklad;
    //OpenSp(spReadTovar, False);
    RefreshChild(spRead.FieldByName('g_product').AsLargeInt);

    aIns.Enabled := spReadTovar.RecordCount > 0;
    spReadTovar.Locate('g_product', FTovar.Product, []);
    if tvProduct.Controller.FocusedRow <> Nil then begin
      if tvProduct.Controller.SelectedRowCount > 0 then
        tvProduct.Controller.SelectedRows[0].Selected := False;
      tvProduct.Controller.FocusedRow.Selected := True;
    end;
    RefreshTovarRekv;
    tvProduct.OnFocusedRecordChanged := onChangeTov;
    tlCategory.OnFocusedNodeChanged := onChangeCat;
    Screen.Cursor := crDefault;
  end
  // подсчитать стоимость товара мне все равно нужно
  else begin
    if FuncGetLastPrice(FTovar.Product) = False then
      ShowMessage('Произошла ошибка при расчете стоимости товара!');
  end;
end;

procedure TSaleModeForm.peClientKeyPress(Sender: TObject; var Key: Char);
begin
  peClient.DroppedDown := True;
end;

procedure TSaleModeForm.peOfficialKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TSaleModeForm.peOfficialPropertiesCloseUp(Sender: TObject);
begin
  if FPopupOfficialForm.AcceptRes then begin
    peOfficialTag := FPopupOfficialForm.spRead.FieldByName('ID').AsLargeInt;
    (Sender as TcxPopupEdit).Text := FPopupOfficialForm.spRead.FieldByName('name').AsString;
  end;
end;

procedure TSaleModeForm.peOfficialPropertiesInitPopup(Sender: TObject);
begin
  peOfficial.DroppedDown := True;
  FPopupOfficialForm.arefresh.Execute;
end;

procedure TSaleModeForm.tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  if not Is_closing then
    aRefreshChild.Execute;
end;

procedure TSaleModeForm.aReturnExecute(Sender: TObject);
var SearchZakazDlgForm: TSearchZakazDlgForm;
  zakazId : Int64;
begin

  // открываю окно поиска продажи
  SearchZakazDlgForm := TSearchZakazDlgForm.Create(Self);
  try
    SearchZakazDlgForm.ShowModal;
    if SearchZakazDlgForm.ContinueReturn then begin
      PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
      try
        PrihodTovaraNForm.Zakaz := SearchZakazDlgForm.Zakaz;
        PrihodTovaraNForm.ZakazNote := SearchZakazDlgForm.ZakazStr;
        PrihodTovaraNForm.OpenMode := omInsert;
        PrihodTovaraNForm.Is_vozvrat := 1;
        if PrihodTovaraNForm.ShowModal = mrOK then
          ShowMessage('Возврат оформлен успешно!');
      finally
        FreeAndNil(PrihodTovaraNForm);
      end;
    end;
  finally
     FreeAndNil(SearchZakazDlgForm);
  end;
end;

procedure TSaleModeForm.aInsClientExecute(Sender: TObject);
var
  ClientForm :TClientForm;
begin
  inherited;
  ClientForm := TClientForm.Create(Self);
  try
    ClientForm.OpenMode := omInsert;
    ClientForm.Id_Category := -1;
    ClientForm.Is_supplier := 0;
    if ClientForm.ShowModal = mrOk then BEGIN
      OpenSP(spPostavshik, False);
      SetpeClient(ClientForm.RecID);
      RefreshClient;
    END;
  finally
    ClientForm.Free;
  end;
end;

procedure TSaleModeForm.aInsExecute(Sender: TObject);
begin
  if peOfficial.DroppedDown then
    FPopupOfficialForm.CloseClick

  //else if lePostavshik.DroppedDown then
  //  lePostavshik.DroppedDown := False
  else if peClient.DroppedDown then
    FPopupClientForm.CloseClick

  else begin
    FTovar.Product  := spReadTovar.fieldByName('g_product').AsLargeInt;
    FTovar.IsMarked := spReadTovar.fieldByName('is_marked').AsInteger;
    FTovar.IsTovarVes := spReadTovar.fieldByName('is_weight').AsInteger;
    FTovar.Ostatok  := spReadTovar.fieldByName('amount').AsFloat;
    if (FTovar.Ostatok > 0) and (FTovar.Ostatok < 1) then
      FTovar.Amount := FTovar.Ostatok
    else
      FTovar.Amount := 1;

    if OptPriceByDefault = 0 then
      FTovar.Price := spReadTovar.fieldByName('price').AsFloat
    else
      FTovar.Price := spReadTovar.fieldByName('volume_price').AsFloat;

    FTovar.VesGrammPrice := spReadTovar.fieldByName('ves_gramm_price').AsFloat;

    inherited;
  end;
end;

procedure TSaleModeForm.aInsTovExecute(Sender: TObject);
begin
  // данный функционал будет добавлять товар по 1 шт, и именно тот, на котором счс стоит курсор во временной таблице
  FTovar.Product := spReadTmp.FieldByName('g_product').AsLargeInt;
  FTovar.Price   := spReadTmp.FieldByName('price').AsFloat;
  FTovar.IsKit   := spReadTmp.FieldByName('is_kit').AsInteger;
  FTovar.VesGrammPrice   := spReadTmp.FieldByName('ves_gramm_price').AsFloat;
  FTovar.Amount := 1;

  InsData;
end;

procedure TSaleModeForm.tAutoRefreshTimer(Sender: TObject);
begin
  tAutoRefresh.Enabled := False;    // на всякий тут оставлю, вдруг каким-то боком включится автообновление
end;

procedure TSaleModeForm.peClientPropertiesCloseUp(Sender: TObject);
begin
  if FPopupCLIENTForm.AcceptRes then begin
    SetpeClient(FPopupCLIENTForm.spRead.FieldByName('ID').AsLargeInt);
    RefreshClient;
    FPopupCLIENTForm.edBarcode.Clear;
  end;
end;

procedure TSaleModeForm.peClientPropertiesInitPopup(Sender: TObject);
begin
  peClient.DroppedDown := True;
  FPopupCLIENTForm.arefresh.Execute;
end;

end.
