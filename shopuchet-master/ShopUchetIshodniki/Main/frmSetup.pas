unit frmSetup;

interface

{$I ShopUchet.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, dxBar,
  Registry, unCommonFunc, frmDlg, cxPC, cxControls, AppEvnts,
  DB, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDatabase, pFIBDatabase, ActnList, frmDBDlg, Printers, FileCtrl, Shellapi, ShlObj, Activex, FIB,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, cxDropDownEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxMemo, cxButtonEdit, cxCheckBox, cxCurrencyEdit, Inifiles,
  Menus, cxLabel, cxButtons, UITypes, dxBarBuiltInMenu, cxClasses,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, cxEditRepositoryItems, unkkm, unShtrihDriver, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGrid, Variants,
  cxDBData, System.Actions, cxGridDBTableView, dxmdaset, unLog, cxRadioGroup,
  unDisplayDriver, pFIBScripter, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox;

type
  TSetupForm = class(TDlgForm)
    spUpd: TpFIBStoredProc;
    spGetData: TpFIBStoredProc;
    tranRead: TpFIBTransaction;
    tranWrite: TpFIBTransaction;
    dbTest: TpFIBDatabase;
    pcCommon: TcxPageControl;
    tsCommon: TcxTabSheet;
    shpFewCompany: TShape;
    shp5: TShape;
    shp3: TShape;
    shp1: TShape;
    lb1: TLabel;
    shp2: TShape;
    lb2: TLabel;
    shp4: TShape;
    lb3: TLabel;
    shp6: TShape;
    lbFewCompany: TLabel;
    shpFewCompany1: TShape;
    tsConfig: TcxTabSheet;
    shp7: TShape;
    lb4: TLabel;
    shp8: TShape;
    tsPrintBill: TcxTabSheet;
    tsBackup: TcxTabSheet;
    shp15: TShape;
    lb9: TLabel;
    shp16: TShape;
    lb8: TLabel;
    shp18: TShape;
    shp17: TShape;
    tsNetwork: TcxTabSheet;
    pn1: TPanel;
    lb11: TLabel;
    lb12: TLabel;
    lb13: TLabel;
    lb14: TLabel;
    lb15: TLabel;
    lb16: TLabel;
    pn2: TPanel;
    lb17: TLabel;
    lb18: TLabel;
    lb19: TLabel;
    lb21: TLabel;
    ts3: TcxTabSheet;
    sh2: TShape;
    sh1: TShape;
    lb20: TLabel;
    lb22: TLabel;
    sh13: TShape;
    sh14: TShape;
    ts1: TcxTabSheet;
    sh18: TShape;
    sh17: TShape;
    sh16: TShape;
    sh15: TShape;
    lb28: TLabel;
    lb29: TLabel;
    lb30: TLabel;
    lb31: TLabel;
    sh19: TShape;
    sh20: TShape;
    sh21: TShape;
    sh22: TShape;
    sh23: TShape;
    sh24: TShape;
    lbServer: TLabel;
    lblNotifyNol: TLabel;
    shpNotifyNol: TShape;
    shpNotifyNol1: TShape;
    lbMagazin: TLabel;
    lbApteka: TLabel;
    lbAvtoZapchasti: TLabel;
    lbProizvodstvo: TLabel;
    cbConfig: TcxComboBox;
    lblNewLineSale: TLabel;
    shpNewLineSale: TShape;
    shpNewLineSale1: TShape;
    lbMestoNaSklade: TLabel;
    shpMestoNaSklade: TShape;
    shpMestoNaSklade1: TShape;
    ceCanSellNol: TcxCheckBox;
    ceManyFirm: TcxCheckBox;
    ceNotifyNol: TcxCheckBox;
    ceNewLineSale: TcxCheckBox;
    ceUseTovarPlace: TcxCheckBox;
    bedtFileName: TcxButtonEdit;
    peCustomStyle: TcxComboBox;
    mTestMenuFont: TcxMemo;
    mTestGridFont: TcxMemo;
    peMenuFont: TcxComboBox;
    peGridFont: TcxComboBox;
    seMenuFontSize: TcxSpinEdit;
    seGridFontSize: TcxSpinEdit;
    lbllb25: TLabel;
    shpsh6: TShape;
    shpsh11: TShape;
    peAutoRefresh: TcxComboBox;
    tsScales: TcxTabSheet;
    lb10: TLabel;
    lb23: TLabel;
    shp19: TShape;
    shp20: TShape;
    cbUseScales: TcxCheckBox;
    lb24: TLabel;
    shp21: TShape;
    shp22: TShape;
    edScalesPrefix: TcxTextEdit;
    tsPrintLabel: TcxTabSheet;
    lb26: TLabel;
    shp23: TShape;
    shp24: TShape;
    tsSms: TcxTabSheet;
    lb37: TLabel;
    lb38: TLabel;
    lb39: TLabel;
    lb40: TLabel;
    shp29: TShape;
    shp30: TShape;
    edSmsLogin: TcxTextEdit;
    lb41: TLabel;
    shp31: TShape;
    shp32: TShape;
    edSmsPassword: TcxTextEdit;
    cbEnableSmsHB: TcxCheckBox;
    mSmsHBText: TcxMemo;
    lb42: TLabel;
    lb44: TLabel;
    cbTranslit: TcxCheckBox;
    lbCostPrice: TLabel;
    shpCostPrice: TShape;
    shpCostPrice1: TShape;
    ceUseCurrency: TcxCheckBox;
    lbDoNotCreditBonusOnDolg: TLabel;
    shpDoNotCreditBonusOnDolg: TShape;
    shpDoNotCreditBonusOnDolg1: TShape;
    cbDoNotCreditBonusOnDolg: TcxCheckBox;
    btHelp: TcxButton;
    btnDefaults: TcxButton;
    lblShowImens: TLabel;
    shpShowImens: TShape;
    shpShowImens1: TShape;
    cbShowImens: TcxCheckBox;
    tsBonuses: TcxTabSheet;
    Label1: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    cbAddBonusForPromo: TcxCheckBox;
    Label2: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    cbSendSmsWhenBonusAdd: TcxCheckBox;
    Label3: TLabel;
    Shape6: TShape;
    Shape7: TShape;
    edBonusAmount: TcxCurrencyEdit;
    Shape8: TShape;
    Label4: TLabel;
    Shape9: TShape;
    Label5: TLabel;
    mTextSmsWhenBonusAdd: TcxMemo;
    Label6: TLabel;
    Shape10: TShape;
    Shape11: TShape;
    Label7: TLabel;
    edBonusOnCreateClient: TcxTextEdit;
    tsZvonki: TcxTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    lbMoiZvonki: TLabel;
    Label10: TLabel;
    Shape12: TShape;
    Label11: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    edCallAPIAddress: TcxTextEdit;
    Shape15: TShape;
    edCallAPI: TcxTextEdit;
    Label12: TLabel;
    Shape16: TShape;
    Shape17: TShape;
    edCallLogin: TcxTextEdit;
    Label13: TLabel;
    Label14: TLabel;
    Shape18: TShape;
    Shape19: TShape;
    edDecimalCount: TcxTextEdit;
    Label15: TLabel;
    tsOnlineZapis: TcxTabSheet;
    cbEnableOnlineZapis: TcxCheckBox;
    Label16: TLabel;
    Shape20: TShape;
    Shape21: TShape;
    edOnlineZapisLink: TcxTextEdit;
    tsSync: TcxTabSheet;
    Label17: TLabel;
    Shape22: TShape;
    Shape23: TShape;
    cbOnlineZapisRefresh: TcxComboBox;
    Label18: TLabel;
    Label19: TLabel;
    Shape24: TShape;
    Shape25: TShape;
    edOnlineZapisLogin: TcxTextEdit;
    Shape26: TShape;
    Label20: TLabel;
    Shape27: TShape;
    edOnlineZapisPass: TcxTextEdit;
    cbOnlineZapisDoSyncAlways: TcxCheckBox;
    lbSalary: TLabel;
    tsKassir: TcxTabSheet;
    lbKassir: TLabel;
    shpKassir: TShape;
    shpKassir1: TShape;
    ceShowSaleDlg: TcxCheckBox;
    shpShowCostPrice: TShape;
    lbShowCostPrice: TLabel;
    cbShowCostPrice: TcxCheckBox;
    shpShowCostPrice1: TShape;
    Label21: TLabel;
    Shape28: TShape;
    Shape29: TShape;
    cbOptPriceByDefault: TcxCheckBox;
    Label23: TLabel;
    Shape32: TShape;
    Shape33: TShape;
    cbShowTovarPanel: TcxCheckBox;
    Label24: TLabel;
    Shape34: TShape;
    Shape35: TShape;
    cbShowKassirPanel: TcxCheckBox;
    Shape36: TShape;
    Label25: TLabel;
    cbShowKafeTovarView: TcxCheckBox;
    Shape37: TShape;
    Label27: TLabel;
    tsSkidkaGrid: TcxTabSheet;
    cxGrid1: TcxGrid;
    tvSkidkaGrid: TcxGridTableView;
    clmSummFrom: TcxGridColumn;
    clmSummTo: TcxGridColumn;
    clmSkidkaVal: TcxGridColumn;
    clmBonusVal: TcxGridColumn;
    cxGrid1Level1: TcxGridLevel;
    Label29: TLabel;
    btnAddSkidkaGrid: TcxButton;
    lbUseTovarNoteInSearch: TLabel;
    shpUseTovarNoteInSearch: TShape;
    shpUseTovarNoteInSearch1: TShape;
    cbUseTovarNoteInSearch: TcxCheckBox;
    Label28: TLabel;
    Shape40: TShape;
    Shape41: TShape;
    cbRmkView: TcxComboBox;
    pcPrinters: TcxPageControl;
    tsPrinters: TcxTabSheet;
    tsFr: TcxTabSheet;
    lbl1: TLabel;
    Shape1: TShape;
    v: TShape;
    edSlogan: TcxTextEdit;
    lbComPortNumber: TLabel;
    shpComPortNumber: TShape;
    lbBaudRate: TLabel;
    shpBaudRate: TShape;
    shpComPortNumber1: TShape;
    cbComPortNumber: TcxComboBox;
    shpBaudRate1: TShape;
    cbBaudRate: TcxComboBox;
    lbBaudRateNote: TLabel;
    btnFiscalPrinterConnect: TcxButton;
    lbFiscalPrinter: TLabel;
    mdPrinters: TdxMemData;
    mdPrintersName: TStringField;
    dsPrinters: TDataSource;
    gr1: TcxGrid;
    tvPrinters: TcxGridDBTableView;
    tvPrintersColumn1: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    tvPrintersColumn2: TcxGridDBColumn;
    pnlPrinters: TPanel;
    btnIns: TBitBtn;
    btnDel: TBitBtn;
    aChild: TActionList;
    aAddPrint: TAction;
    aDelPrint: TAction;
    intgrfldPrintersBillSdvig: TIntegerField;
    clmPrintersColumn3: TcxGridDBColumn;
    mdPrintersBillWidth: TStringField;
    clmPrintersColumn4: TcxGridDBColumn;
    intgrfldPrintersBillQuantity: TIntegerField;
    Label26: TLabel;
    Shape38: TShape;
    Shape39: TShape;
    cbShowInsClientBtn: TcxCheckBox;
    lbDoProductInSale: TLabel;
    shpDoProductInSale: TShape;
    shpDoProductInSale1: TShape;
    cbDoProductInSale: TcxCheckBox;
    lbDoProductInSale1: TLabel;
    Label32: TLabel;
    Shape46: TShape;
    Shape47: TShape;
    cbPrintChargedBonus: TcxCheckBox;
    Label33: TLabel;
    Shape48: TShape;
    Shape49: TShape;
    cbBarcodeLength: TcxComboBox;
    cbCurrency: TcxComboBox;
    cbFormula: TcxComboBox;
    cbSalary: TcxComboBox;
    Label34: TLabel;
    Shape50: TShape;
    Shape51: TShape;
    cbShowProductImg: TcxCheckBox;
    Label35: TLabel;
    Shape52: TShape;
    Shape53: TShape;
    cbShowSaleDlgForVes: TcxCheckBox;
    Label36: TLabel;
    Shape54: TShape;
    Shape55: TShape;
    cbShowSaleDlgKeys: TcxCheckBox;
    pcPrintMode: TcxPageControl;
    tsEtiket: TcxTabSheet;
    Shape56: TShape;
    Label37: TLabel;
    Shape57: TShape;
    lblCannot1: TLabel;
    tsCennik: TcxTabSheet;
    Shape58: TShape;
    Label38: TLabel;
    Shape59: TShape;
    Label39: TLabel;
    Shape60: TShape;
    Shape61: TShape;
    edPinCode: TcxTextEdit;
    lbSmsName: TLabel;
    Label41: TLabel;
    Shape62: TShape;
    Shape63: TShape;
    cbDeliveryService: TcxCheckBox;
    Label42: TLabel;
    lb5: TLabel;
    shp9: TShape;
    shp10: TShape;
    cbCheckPrintDeviceFr: TcxComboBox;
    cbPrintOnPrinters: TcxCheckBox;
    cbPrintOnFr: TcxCheckBox;
    tsDisplay: TcxTabSheet;
    lb6: TLabel;
    lb7: TLabel;
    shp11: TShape;
    shp12: TShape;
    cbMonoblockList: TcxComboBox;
    cbEnableDisplay: TcxCheckBox;
    btnDisplayCalibrate: TcxButton;
    lb27: TLabel;
    shp14: TShape;
    cbDisplayComPort: TcxComboBox;
    shp13: TShape;
    grp1: TGroupBox;
    lb33: TLabel;
    lb35: TLabel;
    spnNameSize: TcxSpinEdit;
    grp2: TGroupBox;
    lbl2: TLabel;
    spnPriceSize: TcxSpinEdit;
    grp4: TGroupBox;
    lb32: TLabel;
    spnArticulSize: TcxSpinEdit;
    grp3: TGroupBox;
    shp27: TShape;
    lb36: TLabel;
    shp28: TShape;
    lbl3: TLabel;
    spnSloganSize: TcxSpinEdit;
    edSloganEtiket: TcxTextEdit;
    grp5: TGroupBox;
    lb34: TLabel;
    lb43: TLabel;
    spnCennikNameSize: TcxSpinEdit;
    grp6: TGroupBox;
    lb45: TLabel;
    spnCennikPriceSize: TcxSpinEdit;
    grp7: TGroupBox;
    shp25: TShape;
    lb46: TLabel;
    shp26: TShape;
    lb47: TLabel;
    spnCennikSloganSize: TcxSpinEdit;
    edSloganCennik: TcxTextEdit;
    mdScales: TdxMemData;
    strngfld1: TStringField;
    dsScales: TDataSource;
    pnlScales: TPanel;
    pnl1: TPanel;
    btnAddPrint: TBitBtn;
    btnDelPrint: TBitBtn;
    cxGrid2: TcxGrid;
    tv1: TcxGridDBTableView;
    clm1: TcxGridDBColumn;
    clm2: TcxGridDBColumn;
    clm3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    aAddScale: TAction;
    aDelScale: TAction;
    strngfldScalesIP: TStringField;
    strngfldScalesPort: TStringField;
    mdScalesModelId: TIntegerField;
    cbPrintersEtiket: TcxComboBox;
    cbA4Size: TcxComboBox;
    cbChooseLentWidth: TcxComboBox;
    rbPrint: TcxRadioButton;
    rbPrinterA4: TcxRadioButton;
    cbNameBold: TcxCheckBox;
    cbPriceBold: TcxCheckBox;
    cbArticulBold: TcxCheckBox;
    cbPrintPrice: TcxCheckBox;
    cbPrintArticul: TcxCheckBox;
    cbPrintSlogan: TcxCheckBox;
    cbSloganBold: TcxCheckBox;
    cbCennikSize: TcxComboBox;
    cbCennikNameBold: TcxCheckBox;
    cbCennikPriceBold: TcxCheckBox;
    cbCennikPrintPrice: TcxCheckBox;
    cbCennikPrintSlogan: TcxCheckBox;
    cbCennikSloganBold: TcxCheckBox;
    cbBackupPeriod: TcxComboBox;
    rbDoBackupOnStart: TcxRadioButton;
    rbDoBackupOnExit: TcxRadioButton;
    rbNoNetwork: TcxRadioButton;
    rbYesNetwork: TcxRadioButton;
    edServer: TcxTextEdit;
    btnSetServer: TcxButton;
    btnTest: TcxButton;
    btnSetupSync: TcxButton;
    lbDisplayCalibrate: TLabel;
    shp33: TShape;
    shp34: TShape;
    lb25: TLabel;
    cbDisplayComBaudRate: TcxComboBox;
    lbSyncCompNotif: TLabel;
    lbSyncId: TLabel;
    lbSyncCompText: TLabel;
    btnDisableSync: TcxButton;
    pnlSync: TPanel;
    pnl3: TPanel;
    btnAddSyncComp: TBitBtn;
    btnDelScale: TBitBtn;
    cxGrid3: TcxGrid;
    tv2: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    aAddSyncComp: TAction;
    aDelSyncComp: TAction;
    spReadSyncComps: TpFIBDataSet;
    dsReadSyncComps: TDataSource;
    clmtv2SYNC_COMPS: TcxGridDBColumn;
    clmtv2NAME: TcxGridDBColumn;
    clmtv2IS_CURRENT: TcxGridDBColumn;
    lb48: TLabel;
    shp35: TShape;
    shp36: TShape;
    cbSetCursorOnTovar: TcxCheckBox;
    tsPayTerminal: TcxTabSheet;
    tsPosTerminals: TcxTabSheet;
    lb51: TLabel;
    lbDomainType: TLabel;
    cbDomainType: TcxComboBox;
    lbLogin: TLabel;
    edLogin: TcxTextEdit;
    shpPass: TShape;
    lbPass: TLabel;
    shpPass1: TShape;
    edPass: TcxTextEdit;
    shpPinCode: TShape;
    lbPincode: TLabel;
    shpPincode1: TShape;
    edtPin: TcxTextEdit;
    shpPrnt1: TShape;
    shpPrnt2: TShape;
    lbPrntRekassa: TLabel;
    btnAddPrint1: TBitBtn;
    cbPrnt: TcxComboBox;
    shp43: TShape;
    lbl4: TLabel;
    shp44: TShape;
    cbSetSaleOfGoods: TcxCheckBox;
    cbLimitCount: TcxCheckBox;
    edtPort: TcxTextEdit;
    lblPort: TLabel;
    edtLoginTIS: TcxTextEdit;
    edtPassTIS: TcxTextEdit;
    cbTerminal: TcxComboBox;
    lblTerminal: TLabel;
    lbl5: TLabel;
    shp45: TShape;
    shp46: TShape;
    cbFindShtrikh: TcxCheckBox;
    lbl6: TLabel;
    shp47: TShape;
    shp48: TShape;
    cbCredit: TcxCheckBox;
    dsPosTerminal: TDataSource;
    cxgrdTerminal: TcxGrid;
    tvPosTerminal: TcxGridDBTableView;
    cxgrdbclmn1: TcxGridDBColumn;
    cxgrdbclmn2: TcxGridDBColumn;
    cxgrdlvl1: TcxGridLevel;
    Panel2: TPanel;
    btnDelTerminal: TBitBtn;
    btnAddTerminal: TBitBtn;
    lbllb52: TLabel;
    shp42: TShape;
    shp41: TShape;
    cbUsePosTerminal: TcxCheckBox;
    a1: TAction;
    mdPosTerminal: TdxMemData;
    atncfldMemDataPosTerminalID: TAutoIncField;
    strngfldMemDataPosTerminalIP: TStringField;
    mdMemDataPosTerminalTypeTerminal: TIntegerField;
    strngfldPosTerminalName: TStringField;
    lb49: TLabel;
    shp37: TShape;
    shp38: TShape;
    cbLetDoReturnWithoutSale: TcxCheckBox;
    lb50: TLabel;
    shp39: TShape;
    shp40: TShape;
    cbBillPrintBarcode: TcxCheckBox;

    procedure peCustomStyleChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure petbButtonsStyleChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure peToolbarCustomStyleChange(Sender: TObject);
    procedure peTabCustomStyleChange(Sender: TObject);
    procedure pePopupFormBorderStyleChange(Sender: TObject);
    procedure pePopupFlatBorderChange(Sender: TObject);
    procedure cbBackupPeriod1Change(Sender: TObject);
    procedure rbDoBackupOnStart1Click(Sender: TObject);
    procedure cbPrinters1Change(Sender: TObject);
    procedure cbBillWidth1Change(Sender: TObject);
    procedure bedtFileNameButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure bedtFileNameChange(Sender: TObject);
    procedure cbCurrency1Change(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure rbNoNetwork1Click(Sender: TObject);
    procedure rbYesNetwork1Click(Sender: TObject);
    procedure btnSetServer1Click(Sender: TObject);
	  procedure seSdvigChange(Sender: TObject);
    procedure Label27MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label27MouseLeave(Sender: TObject);
    procedure btnTest1Click(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure cbConfigChange(Sender: TObject);
    procedure edtServer1Change(Sender: TObject);
    procedure ceShowSaleDlgPropertiesChange(Sender: TObject);
    procedure ceNewLineSalePropertiesChange(Sender: TObject);
    procedure ceNotifyNolPropertiesChange(Sender: TObject);
    procedure ceCanSellNolPropertiesChange(Sender: TObject);
    procedure ceUseTovarPlacePropertiesChange(Sender: TObject);
    procedure peMenuFontPropertiesChange(Sender: TObject);
    procedure seMenuFontSizePropertiesChange(Sender: TObject);
    procedure peGridFontPropertiesChange(Sender: TObject);
    procedure seGridFontSizePropertiesChange(Sender: TObject);
    procedure edSloganPropertiesChange(Sender: TObject);
    procedure edScalesPrefixKeyPress(Sender: TObject; var Key: Char);
    procedure cbUseScalesPropertiesChange(Sender: TObject);
    procedure edScalesPrefixPropertiesChange(Sender: TObject);
    procedure cbPrintPrice1Click(Sender: TObject);
    procedure cbPrintSlogan1Click(Sender: TObject);
    procedure rbPrint1Click(Sender: TObject);
    procedure lb39MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lb39MouseLeave(Sender: TObject);
    procedure lb39Click(Sender: TObject);
    procedure cbEnableHBPropertiesChange(Sender: TObject);
    procedure cbTranslitPropertiesChange(Sender: TObject);
    procedure ceUseCurrencyPropertiesChange(Sender: TObject);
    procedure cbShowCostPricePropertiesChange(Sender: TObject);
    procedure cbShowImensPropertiesChange(Sender: TObject);
    procedure cxCheckBox1PropertiesChange(Sender: TObject);
    procedure cbSendSmsWhenBonusAddPropertiesChange(Sender: TObject);
    procedure edBonusAmountPropertiesChange(Sender: TObject);
    procedure mTextSmsWhenBonusAddPropertiesChange(Sender: TObject);
    procedure edBonusOnCreateClientPropertiesChange(Sender: TObject);
    procedure lbMoiZvonkiClick(Sender: TObject);
    procedure edDecimalCountPropertiesChange(Sender: TObject);
    procedure edDecimalCountExit(Sender: TObject);
    procedure cbEnableOnlineZapisPropertiesChange(Sender: TObject);
    procedure btnFiscalPrinterConnectClick(Sender: TObject);
    procedure cbCheckPrintDevicePropertiesChange(Sender: TObject);
    procedure pcCommonChange(Sender: TObject);
    procedure btnDisableSyncClick(Sender: TObject);
    procedure btnSetupSync1Click(Sender: TObject);
    procedure btnAddSkidkaGridClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure tvSkidkaGridDataControllerNewRecord(
      ADataController: TcxCustomDataController; ARecordIndex: Integer);
    procedure cbUseTovarNoteInSearchPropertiesChange(Sender: TObject);
    procedure cbRmkViewPropertiesChange(Sender: TObject);
    procedure aAddPrintExecute(Sender: TObject);
    procedure aDelPrintExecute(Sender: TObject);
    procedure btnAddCompToSync1Click(Sender: TObject);
    procedure edScalesIpKeyPress(Sender: TObject; var Key: Char);
    procedure cbFrConnectAnotherCompPropertiesChange(Sender: TObject);
    procedure cbPrintArticul1Click(Sender: TObject);
    procedure peAutoRefreshPropertiesChange(Sender: TObject);
    procedure cbPrintOnPrintersPropertiesChange(Sender: TObject);
    procedure cbPrintOnFrPropertiesChange(Sender: TObject);
    procedure cbEnableDisplayPropertiesChange(Sender: TObject);
    procedure cbCennikPrintSlogan1Click(Sender: TObject);
    procedure cbCennikPrintPrice1Click(Sender: TObject);
    procedure aAddScaleExecute(Sender: TObject);
    procedure aDelScaleExecute(Sender: TObject);
    procedure cbMonoblockListPropertiesChange(Sender: TObject);
    procedure btnDisplayCalibrateClick(Sender: TObject);
    procedure aAddSyncCompExecute(Sender: TObject);
    procedure aDelSyncCompExecute(Sender: TObject);
    procedure cbUsePosTerminalPropertiesChange(Sender: TObject);
    procedure edPosTerminalIpKeyPress(Sender: TObject; var Key: Char);
    procedure edtPinKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddPrint1Click(Sender: TObject);
    procedure edtPinExit(Sender: TObject);
    procedure btnAddTerminalClick(Sender: TObject);
    procedure btnDelTerminalClick(Sender: TObject);
    procedure cbLetDoReturnWithoutSalePropertiesChange(Sender: TObject);
  private
    FtbButtonsStyle: TtbButtonsStyle;
    FAutoRefresh: Integer;
    FPopupFormBorderStyle: TcxEditPopupBorderStyle;
    FPopupFlatBorder: Boolean;
    FBackupDir : String;     // папка для хранения резервной копии
    FBackupPeriod : Integer; // 0 - каждый день, 1 - каждую неделю, 2 - раз в месяц, 3 - никогда
    FDoBackupOnStart : Integer; // 1 - при входе в программу, 0 - при выходе из нее
    FAllowSellAbsentGoods : Integer; // 1 - продавать товары с нулевым остатком, 0 - не продавать товары с нулевым остатком
    FNotifyNol : Integer;   // предупреждать о добавлении товара с нулевой ценой при продаже 0 - нет, 1 - да
    FShowSaleDlg : Integer; // показывать предварительное окно с количеством товара в режиме кассира 0 - нет, 1 - да
    FNewLineSale : Integer; // не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да
    FUseTovarPlace : Integer; // искать по полю "Место на складе" во всех режимах
    FUseTovarNoteInSearch : Integer; // искать по полю "Примечание" во всех режимах
    FUseScales : integer;      //1 - пользуют весы, 0 - нет
    FScalesPrefix : String;    //префикс весового штрихкода
    FScalesIp : String;        //Адрес весов
    FScalesPort : String;      //Порт весов
    FScalesModel : Integer;    //Фирма весов
    FUseCurrency : Boolean;    //открыть закупочные цены в валюте в Приходе товара
    FConfSetOneMaster : Boolean; // закрепить одного мастера за одним счетом
    FShowCostPrice : Integer;    //показывать закупочные цены в режиме кассира
    FShowImens     : Boolean;    //показывать список именинников при входе в программу
    FAddBonusForPromo : Boolean;     //начислять бонусы за рекомендации
    FAmountBonusForPromo : Double;   //кол-во бонусов за рекомендации
    FSendSmsWhenBonusAdd : Boolean;  //отправлять уведомление, когда пополняется бонусный счет
    FTextSmsWhenBonusAdd : String;   //текст, который отправляется клиенту
    FDoNotAllowCrossTime : Boolean;  //нельзя записывать клиента на время, которое у мастера уже закрыто
    FBonusOnCreateClient : integer;  //размер бонуса для новых (создаваемых) клиентов
    FUseDateEndSalaryReport : Boolean; //учитывтаь дату завершения работ при построении отчета о зарплате
    FNonCashPayTypePosTerminal : Int64; // тип безналичной оплаты для пос-терминала
    FLetDoReturnWithoutSale : Integer;  //Разрешить оформлять возврат товара без продажи

    //Параметры онлайн-записи
    FOnlineZapisEnabled : Boolean;  // True - онлайн-запись включена
    FOnlineZapisLink    : string;   // ссылка на сервис онлайн-записи
    FOnlineZapisLogin   : string;   // логин
    FOnlineZapisPass    : string;   // пароль
    FOnlineZapisRefresh : integer;  // 0 - при открытии программы, 1 - каждый раз при создании записи
    FOnlineZapisDoSyncAlways : Boolean;  //делать синхронизацию каждый раз перед созданием записи

    FMenuFontName: String;
    FMenuFontSize: Integer;

    FGridFontName: String;
    FGridFontSize: Integer;
    FOldRec : TSettingsRec;
    FNewRec : TSettingsRec;
    FSyncEnabled : Boolean;
    FDisplayComPortStrOld : String;
    function GetFrStatus : Boolean;
    function CheckSkidkaGrid : Boolean;
    function SaveSetup: Boolean;
    function ExecSP(SP: TpFIBStoredProc): Boolean;
    procedure RmkViewChange;
    procedure FillFontItems;
    procedure FillSyncComps;
    procedure SetDefaultSize(PriceSize, ArticulSize : Integer; SloganSize : Integer; NameSize : Integer);
    procedure SetCennikDefaultSize(PriceSize, SloganSize, NameSize : Integer);
    procedure SwitchTs(index : integer);
  protected
    procedure GetData; override;
    procedure OpenSyncSetup(IsAddNewComp : boolean);
  public
  end;

const
  WRITABLE_FONTTYPE = 256;
  foAnsiOnly        = True;
  foTrueTypeOnly    = True;
  foFixedPitchOnly  = False;
  foOEMFontsOnly    = False;
  foNoOEMFonts      = False;
  foNoSymbolFonts   = True;
  foScalableOnly    = True;

implementation

uses unInitApp, unErrorHandlers, dmMain, unDBSupport, smsc_api, frmSyncSetup,
frmPrintersSetup, frmScalesSetup, unReKassa, frmMain, UnKKMTIS, frmTerminalSetup;

{$R *.DFM}
//================================================================
function CenterVertical(const rect: TRect; h: Integer): Integer;
begin
  Result := (rect.bottom + rect.top - h) div 2;
end;

function CenterHorizontal(const rect: TRect; w: Integer): Integer;
begin
  Result := (rect.right + rect.left - w) div 2;
end;

function BrowserCallback(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer
  stdcall;
var
  r1, r2: TRect;
begin
  result := 0;
  if uMsg = BFFM_INITIALIZED then
  begin
    GetWindowRect(wnd, r1);
    r2 := Rect(0, 0, Screen.Width, Screen.Height);
    MoveWindow(wnd, CenterHorizontal(r2, r1.Right - r1.left), CenterVertical(r2,
      r1.Bottom - r1.Top),
      r1.Right - r1.Left, r1.Bottom - r1.Top, false);
  end;
end;
//================================================================

procedure TSetupForm.FormShow(Sender: TObject);
var
  i : Integer;
  h: THandle;
begin
  inherited;
  pcCommon.ActivePage := tsCommon;

  {Заполняем Комбо списком шрифтов}
  FillFontItems;

  // заполняем принтеры
  try
    cbPrintersEtiket.Properties.Items.Assign(Printer.Printers);
    cbPrintersEtiket.ItemIndex := Printer.PrinterIndex;  // принтер по умолчанию
  except
  end;

  // заполняю COM-порты
  for i:=1 to 256 do begin
    cbCOMPortNumber.Properties.items.Add('COM' + IntToStr(i));
    cbDisplayComPort.Properties.items.Add('COM' + IntToStr(i));
  end;

  {shpComPortNumber.Visible := False;
  shpBaudRate.Visible := False;
  shpComPortNumber1.Visible := False;
  shpBaudRate1.Visible := False;}
  lbUseTovarNoteInSearch.Visible := False;
  shpUseTovarNoteInSearch.Visible := False;
  shpUseTovarNoteInSearch1.Visible := False;
  cbUseTovarNoteInSearch.Visible := False;

  //GetData;

  //29.10.2019 решил что нах это надо, пусть сам смотрит как у него влазит слоган
  //if cbBillWidth.ItemIndex = 1 then
  //  edSlogan.Properties.MaxLength := 65;

  //ставлю всем компонентам размеры и шрифты, на разных DPI по разному
  lbApteka.Font.Size := 9;
  lbAvtoZapchasti.Font.Size := 9;
  lbMagazin.Font.Size := 9;
  lbProizvodstvo.Font.Size := 9;
  cbConfig.Style.Font.Size := 9;

  //в СалонУчете эти параметры не нужны
  if (AppName = 'salonuchet') or (AppName = 'serviceuchet') then begin
    tsConfig.TabVisible := False;
    tsScales.TabVisible := False;
    if AppName = 'serviceuchet' then
      tsKassir.TabVisible := False

    else begin
      lbShowCostPrice.Visible := False;
      shpShowCostPrice.Visible := False;
      shpShowCostPrice1.Visible := False;
      cbShowCostPrice.Visible := False;
      Label21.Visible := False;
      Shape28.Visible := False;
      Shape29.Visible := False;
      cbOptPriceByDefault.Visible := False;
      Label24.Visible := False;
      Shape34.Visible := False;
      Label25.Visible := False;
      Shape36.Visible := False;
      Shape35.Visible := False;
      cbShowKassirPanel.Visible := False;
      Shape37.Visible := False;
      cbShowKafeTovarView.Visible := False;
    end;

    tsSync.TabVisible   := False;
    tsSkidkaGrid.TabVisible   := False;
    lbFewCompany.Visible := False;
    shpFewCompany.Visible := False;
    shpFewCompany1.Visible := False;
    ceManyFirm.Visible := False;
    lbMestoNaSklade.Visible := False;
    shpMestoNaSklade.Visible := False;
    shpMestoNaSklade1.Visible := False;
    ceUseTovarPlace.Visible := False;
    lbCostPrice.Visible := False;
    shpCostPrice.Visible := False;
    shpCostPrice1.Visible := False;
    ceUseCurrency.Visible := False;
    lbShowCostPrice.Visible := False;
    shpShowCostPrice.Visible := False;
    shpShowCostPrice1.Visible := False;
    cbShowCostPrice.Visible := False;

    lbSalary.Visible := False;
    cbSalary.Visible := False;
  end;

  if (AppName = 'shopuchet') or (AppName = 'starShop') then begin
    lblShowImens.Visible := False;
    shpShowImens.Visible := False;
    shpShowImens1.Visible := False;
    cbShowImens.Visible := False;
    tsBonuses.TabVisible := False;

    tsOnlineZapis.TabVisible := False;
    tsZvonki.TabVisible := False;

    if MainDM.dbMain.Connected = False then begin
      tsCommon.TabVisible := False;
      tsConfig.TabVisible := False;
      tsKassir.TabVisible := False;
      tsPrintBill.TabVisible := False;
      tsScales.TabVisible := False;
      tsSms.TabVisible := False;
      tsSync.TabVisible := False;
      tsPosTerminals.TabVisible := False;
    end;

    // поля "Поиск по примечанию"
    lbUseTovarNoteInSearch.Visible := True;
    shpUseTovarNoteInSearch.Visible := True;
    shpUseTovarNoteInSearch1.Visible := True;
    cbUseTovarNoteInSearch.Visible := True;

    if (isProKey = False) then begin
      tsSync.TabVisible := False;
    end;

  end;

end;

procedure TSetupForm.GetData;
var
  Reg: TRegistry;
  Ini: TMeminifile; //необходимо создать объект, чтоб потом с ним работать
  SloganSize, PriceSize, ArticulSize, NameSize : integer;
  CennikSloganSize, CennikPriceSize, CennikNameSize : integer;
  i, p : integer;
  str, str1 : string;
begin
  inherited;

  mTestMenuFont.Lines.Clear;
  mTestMenuFont.Lines.Add('Текст на русском');
  mTestMenuFont.Lines.Add('English text');

  mTestGridFont.Lines.Clear;
  mTestGridFont.Lines.Add('Текст на русском');
  mTestGridFont.Lines.Add('English text');

  peCustomStyle.ItemIndex := Integer(CustomStyle);  {Уже загружено в GetCustomStyle}
  try
    Reg := TRegistry.Create;
    try
      with Reg do begin
        RootKey := RegSetupRoot;
        LazyWrite := False;  {Сохраняем ключи до закрытия}
        if OpenKey(RegSetupKey, True) then
          try
            {-----------------------}
            {Внешний вид и поведение}
            {-----------------------}
            {Стиль панелей инструментов}
            {if ValueExists('ToolbarStyle') then
              ToolbarStyle := TdxBarManagerStyle(ReadInteger('ToolbarStyle'))
            else begin
              ToolbarStyle := bmsEnhanced;
              WriteInteger('ToolbarStyle', Integer(ToolbarStyle));
            end;
            peToolbarCustomStyle.ItemIndex := Integer(ToolbarStyle); }
            {----------------------------}
            {Стиль диалоговых окон задан выше}
            {----------------------------}
            {Стиль закладок}
            {if ValueExists('TabStyle') then
              TabStyle := TcxPCStyleID(ReadInteger('TabStyle'))
            else begin
              TabStyle := 4;  //dxtsFlat
              WriteInteger('TabStyle', Integer(TabStyle));
            end;
            peTabCustomStyle.ItemIndex := Integer(TabStyle); }

            {----------------------------}
            {Стиль кнопок в списках}
            {if ValueExists('tbButtonsStyle') then
              FtbButtonsStyle := TtbButtonsStyle(ReadInteger('tbButtonsStyle'))
            else begin
              FtbButtonsStyle := bsGlyphText;
              WriteInteger('tbButtonsStyle', Integer(FtbButtonsStyle));
            end;
            petbButtonsStyle.ItemIndex := Integer(FtbButtonsStyle);}
            {----------------------------}
            {Автообновление списков}
            if ValueExists('AutoRefresh') then  {Когда выполнять AutoRefresh}
              FAutoRefresh := ReadInteger('AutoRefresh')
            else begin
              FAutoRefresh := 5; {5 мин.}
              WriteInteger('AutoRefresh', FAutoRefresh);
            end;
            case FAutoRefresh of
              0  : peAutoRefresh.ItemIndex := 0;
              1  : peAutoRefresh.ItemIndex := 1;
              2  : peAutoRefresh.ItemIndex := 2;
              3  : peAutoRefresh.ItemIndex := 3;
              4  : peAutoRefresh.ItemIndex := 4;
              5  : peAutoRefresh.ItemIndex := 5;
              10 : peAutoRefresh.ItemIndex := 6;
              20 : peAutoRefresh.ItemIndex := 7;
              30 : peAutoRefresh.ItemIndex := 8;
            end;
            {Стиль выпадающих окон}
           { if ValueExists('PopupFormBorderStyle') then
              FPopupFormBorderStyle := TcxEditPopupBorderStyle(ReadInteger('PopupFormBorderStyle'))
            else begin
              FPopupFormBorderStyle := epbsDialog;
              WriteInteger('PopupFormBorderStyle', Integer(FPopupFormBorderStyle));
            end;  }
            {case FPopupFormBorderStyle of
              pbsDialog  : pePopupFormBorderStyle.ItemIndex := 0;
              pbsSimple  : pePopupFormBorderStyle.ItemIndex := 1;
              pbsSysPanel: pePopupFormBorderStyle.ItemIndex := 2;
            end;}
            {Плоская рамка выпад. окна}
            if ValueExists('PopupFlatBorder') then
              FPopupFlatBorder := ReadBool('PopupFlatBorder')
            else begin
              FPopupFlatBorder := True;
              WriteBool('PopupFlatBorder', FPopupFlatBorder);
            end;
            {if FPopupFlatBorder then
              pePopupFlatBorder.ItemIndex := 1
            else
              pePopupFlatBorder.ItemIndex := 0; }

            {Папка для хранения копии БД}
            if ValueExists('BackupDir') then
              FBackupDir := ReadString('BackupDir')
            else begin
              FBackupDir := ExtractFilePath(Application.exename) + 'Backup';
              WriteString('BackupDir', FBackupDir);
            end;
            bedtFileName.Text := FBackupDir;

            {Периодичность создания копии БД}
            if ValueExists('BackupPeriod') then
              FBackupPeriod := ReadInteger('BackupPeriod')
            else begin
              FBackupPeriod := 0;
              WriteInteger('BackupPeriod', FBackupPeriod);
            end;
            cbBackupPeriod.ItemIndex := FBackupPeriod;

            {Когда делать копию БД - при входе в программу (1), или при выходе (0)}
            if ValueExists('DoBackupOnStart') then
              FDoBackupOnStart := ReadInteger('DoBackupOnStart')
            else begin
              FDoBackupOnStart := 0;
              WriteInteger('DoBackupOnStart', FDoBackupOnStart);
            end;
            rbDoBackupOnStart.Checked := FDoBackupOnStart = 1;
            rbDoBackupOnExit.Checked := FDoBackupOnStart = 0;

            {Валюта 0 - тенге 1 - рубли 2 - гривны 3 - узбекский сум}
            if ValueExists('Currency') then
              CurrencyVal := ReadInteger('Currency')
            else begin
              CurrencyVal := 0;
              WriteInteger('Currency', CurrencyVal);
            end;
            cbCurrency.ItemIndex := CurrencyVal;

            {Продавать товары с нулевым остатком или нет 0 - нет, 1 - да}
            {if ValueExists('AllowSellAbsentGoods') then
              FAllowSellAbsentGoods := ReadInteger('AllowSellAbsentGoods')
            else begin
              FAllowSellAbsentGoods := 0;
              WriteInteger('AllowSellAbsentGoods', FAllowSellAbsentGoods);
            end;
            ceCanSellNol.Checked := FAllowSellAbsentGoods = 1;}

            {Режим нескольких фирм 0 - нет, 1 - да}
            if ValueExists('ManyFirm') then
              ceManyFirm.Checked := ReadInteger('ManyFirm') = 1
            else begin
              ceManyFirm.Checked := false;
              WriteInteger('ManyFirm', 0);
            end;

            {предупреждать о добавлении товара с нулевой ценой при продаже, 0 - нет, 1 - да}
            if ValueExists('NotifyNol') then
              FNotifyNol := ReadInteger('NotifyNol')
            else begin
              FNotifyNol := 0;
              WriteInteger('NotifyNol', FNotifyNol);
            end;
            ceNotifyNol.Checked := FNotifyNol = 1;

            {не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да}
            if ValueExists('NewLineSale') then
              FNewLineSale := ReadInteger('NewLineSale')
            else begin
              FNewLineSale := 0;
              WriteInteger('NewLineSale', NewLineSale);
            end;
            ceNewLineSale.Checked := FNewLineSale = 1;

            {искать по полю "Место на складе" во всех режимах 0 - нет, 1 - да}
            if ValueExists('UseTovarPlace') then
              FUseTovarPlace := ReadInteger('UseTovarPlace')
            else begin
              FUseTovarPlace := 0;
              WriteInteger('UseTovarPlace', FUseTovarPlace);
            end;
            ceUseTovarPlace.Checked := FUseTovarPlace = 1;

            {искать по полю "Примечание" во всех режимах 0 - нет, 1 - да}
            if ValueExists('UseTovarNoteInSearch') then
              FUseTovarNoteInSearch := ReadInteger('UseTovarNoteInSearch')
            else begin
              FUseTovarNoteInSearch := 0;
              WriteInteger('UseTovarNoteInSearch', FUseTovarNoteInSearch);
            end;
            cbUseTovarNoteInSearch.Checked := FUseTovarNoteInSearch = 1;

            {Отображать цены в валюте в приходе товара 0 - нет, 1 - да}
            if ValueExists('UseCurrency') then
              FUseCurrency := Readbool('UseCurrency')
            else begin
              FUseCurrency := false;
              WriteBool('UseCurrency', FUseCurrency);
            end;
            ceUseCurrency.Checked := FUseCurrency;

            {Показывать именинников при входе 0 - нет, 1 - да}
            if ValueExists('ShowImens') then
              FShowImens := Readbool('ShowImens')
            else begin
              FShowImens := false;
              WriteBool('ShowImens', FShowImens);
            end;
            cbShowImens.Checked := FShowImens;

            {Начислять бонусы за рекомендацию 0 - нет, 1 - да}
            if ValueExists('AddBonusForPromo') then
              FAddBonusForPromo := Readbool('AddBonusForPromo')
            else begin
              FAddBonusForPromo := false;
              WriteBool('AddBonusForPromo', FAddBonusForPromo);
            end;
            cbAddBonusForPromo.Checked := FAddBonusForPromo;

            {Не начислять бонусы при продаже в долг, 1 - не начислять, 0 - начислять}
            if ValueExists('DoNotCreditBonusOnDolg') then begin
              DoNotCreditBonusOnDolg := ReadInteger('DoNotCreditBonusOnDolg');
              //cbDoNotCreditBonusOnDolg.ItemIndex := DoNotCreditBonusOnDolg;  что это вообще?
            end else begin
              DoNotCreditBonusOnDolg := 0;
              WriteInteger('DoNotCreditBonusOnDolg', DoNotCreditBonusOnDolg);
            end;
            cbDoNotCreditBonusOnDolg.Checked := DoNotCreditBonusOnDolg = 1;

            {Количество бонусов за рекомендацию}
            if ValueExists('AmountBonusForPromo') then
              FAmountBonusForPromo := ReadFloat('AmountBonusForPromo')
            else begin
              FAmountBonusForPromo := 0;
              WriteFloat('AmountBonusForPromo', FAmountBonusForPromo);
            end;
            edBonusAmount.Value := FAmountBonusForPromo;

            {Отправлять СМС когда начислили бонусы за рекомендацию}
            if ValueExists('SendSmsWhenBonusAdd') then
              FSendSmsWhenBonusAdd := Readbool('SendSmsWhenBonusAdd')
            else begin
              FSendSmsWhenBonusAdd := false;
              WriteBool('SendSmsWhenBonusAdd', FSendSmsWhenBonusAdd);
            end;
            cbSendSmsWhenBonusAdd.checked := FSendSmsWhenBonusAdd;

            {Текст СМС когда начислили бонусы за рекомендацию}
            if ValueExists('TextSmsWhenBonusAdd') then
              FTextSmsWhenBonusAdd := ReadString('TextSmsWhenBonusAdd')
            else begin
              FTextSmsWhenBonusAdd := '@name@, Вам начислено @bonus@ бонусов за рекомендацию друзьям! Салон красоты "Beauty".';
              WriteString('TextSmsWhenBonusAdd', FTextSmsWhenBonusAdd);
            end;
            mTextSmsWhenBonusAdd.Text := FTextSmsWhenBonusAdd;

            {размер бонуса для новых (создаваемых) клиентов}
            if ValueExists('BonusOnCreateClient') then
              FBonusOnCreateClient := ReadInteger('BonusOnCreateClient')
            else begin
              FBonusOnCreateClient := 0;
              WriteInteger('BonusOnCreateClient', FBonusOnCreateClient);
            end;
            edBonusOnCreateClient.Text := IntToStr(FBonusOnCreateClient);

            {Устанавливать курсор на товар при сканировании штрихкода, 1 - да, 0 - нет}
            if ValueExists('SetCursorOnTovar') then begin
              SetCursorOnTovar := ReadInteger('SetCursorOnTovar');
            end else begin
              SetCursorOnTovar := 0;
              WriteInteger('SetCursorOnTovar', SetCursorOnTovar);
            end;
            cbSetCursorOnTovar.Checked := SetCursorOnTovar = 1;

            {Разграничение прав на просмотр прихода товара}
            if ValueExists('SetSaleOfGoods') then begin
              SetSaleOfGoods := ReadInteger('SetSaleOfGoods');
            end else begin
              SetSaleOfGoods := 0;
              WriteInteger('SetSaleOfGoods', SetSaleOfGoods);
            end;
            cbSetSaleOfGoods.Checked := SetSaleOfGoods = 1;

            {Разрешить оформлять возврат товара без продажи 0 - нет, 1 - да}
            if ValueExists('LetDoReturnWithoutSale') then begin
              FLetDoReturnWithoutSale := ReadInteger('LetDoReturnWithoutSale');
            end else begin
              FLetDoReturnWithoutSale := 0;
              WriteInteger('LetDoReturnWithoutSale', FLetDoReturnWithoutSale);
            end;
            cbLetDoReturnWithoutSale.Checked := FLetDoReturnWithoutSale = 1;

            //================ ВЕСЫ ========================
            {использовать весы со штрихкодом 0 - нет, 1 - да}
            // старое значение удаляю из реестра, т.к. оно больше не нужно
            if ValueExists('UseScales') then
              FUseScales := ReadInteger('UseScales')
            else begin
              FUseScales := 0;
              WriteInteger('UseScales', FUseScales);
            end;
            cbUseScales.Checked := FUseScales = 1;

            {префикс весового штрихкода}
            if ValueExists('ScalesPrefix') then
              FScalesPrefix := ReadString('ScalesPrefix')
            else begin
              FScalesPrefix := '29';
              WriteString('ScalesPrefix', FScalesPrefix);
            end;
            edScalesPrefix.Text := FScalesPrefix;

            if ValueExists('ScalesArray') then begin
              mdScales.Open;
              i := 0;
              Str := ReadString('ScalesArray');
              while Length(Str) > 1 do begin
                mdScales.Insert;
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdScales.FieldByName('Name').AsString := str1;

                // Модель
                Delete(str, 1, p);
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdScales.FieldByName('ModelId').AsInteger := StrToInt(str1);

                // IP
                Delete(str, 1, p);
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdScales.FieldByName('IP').AsString := str1;

                // Port
                Delete(str, 1, p);
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdScales.FieldByName('Port').AsString := str1;

                Delete(str, 1, p);
                i := i + 1;
              end;
              mdScales.Refresh;
            end else begin
              if (ValueExists('ScalesIp')) or (ValueExists('ScalesPort')) or
              (ValueExists('ScalesModel')) then begin
                if ReadString('ScalesIp') <> '' then begin
                  mdScales.Open;
                  mdScales.Insert;
                  if ReadInteger('ScalesModel') = 0 then
                    mdScales.FieldByName('Name').AsString := 'Масса-К'
                  else if ReadInteger('ScalesModel') = 1 then
                    mdScales.FieldByName('Name').AsString := 'Rongta RLS1000'
                  else if ReadInteger('ScalesModel') = 2 then
                    mdScales.FieldByName('Name').AsString := 'Штрих-Принт (Штрих-М)';

                  mdScales.FieldByName('ModelId').AsInteger := ReadInteger('ScalesModel');
                  mdScales.FieldByName('IP').AsString := ReadString('ScalesIp');
                  mdScales.FieldByName('Port').AsString := ReadString('ScalesPort');
                  mdScales.Refresh;
                end;
              end;
            end;
            //================ ВЕСЫ КОНЕЦ ========================

            {Принтер для печати чеков и ширина чековой ленты}
            // старое значение удаляю из реестра, т.к. оно больше не нужно
            if ValueExists('CheckPrintDevice') then begin
              if ReadInteger('CheckPrintDevice') > 0 then begin
                CheckPrintDeviceFr  := ReadInteger('CheckPrintDevice');
                PrintOnFr           := true;
                cbPrintOnFr.Checked := true;
              end
              else begin
                PrintOnPrinters           := true;
                cbPrintOnPrinters.Checked := True;
              end;

              DeleteValue('CheckPrintDevice');
            end else begin
              if ValueExists('PrintOnPrinters') then begin
                PrintOnPrinters := ReadBool('PrintOnPrinters');
                cbPrintOnPrinters.Checked := PrintOnPrinters;
              end else begin
                PrintOnPrinters := cbPrintOnPrinters.Checked;
                WriteBool('PrintOnPrinters', PrintOnPrinters);
              end;
              if ValueExists('PrintOnFr') then begin
                PrintOnFr := ReadBool('PrintOnFr');
                cbPrintOnFr.Checked := PrintOnFr;
              end else begin
                PrintOnFr := cbPrintOnFr.Checked;
                WriteBool('CheckPrintDeviceFr', PrintOnFr);
              end;

              if ValueExists('CheckPrintDeviceFr') then begin
                CheckPrintDeviceFr := ReadInteger('CheckPrintDeviceFr');
                cbCheckPrintDeviceFr.ItemIndex := CheckPrintDeviceFr;
              end else begin
                CheckPrintDeviceFr := cbCheckPrintDeviceFr.ItemIndex;
                WriteInteger('CheckPrintDeviceFr', CheckPrintDeviceFr);
              end;
            end;

            if ValueExists('BillPrinters') then begin
              mdPrinters.Open;
              i := 0;
              Str := ReadString('BillPrinters');
              while Length(Str) > 1 do begin
                mdPrinters.Insert;
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdPrinters.FieldByName('Name').AsString := str1;

                // ширина
                Delete(str, 1, p);
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdPrinters.FieldByName('BillWidth').AsString := str1;

                // сдвиг
                Delete(str, 1, p);
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdPrinters.FieldByName('BillSdvig').AsInteger := StrToInt(str1);

                // количество копий
                Delete(str, 1, p);
                p := pos('~', Str);
                str1 := Copy(Str, 1, p-1);
                mdPrinters.FieldByName('BillQuantity').AsInteger := StrToInt(str1);

                Delete(str, 1, p);
                i := i + 1;
              end;
              mdPrinters.Refresh;
            end else begin
              if (ValueExists('BillPrinterName')) or (ValueExists('BillWidth')) or
              (ValueExists('BillSdvig')) or (ValueExists('BillQuantity'))  then begin
                if ReadString('BillPrinterName') <> '' then begin
                  mdPrinters.Open;
                  mdPrinters.Insert;
                  mdPrinters.FieldByName('Name').AsString := ReadString('BillPrinterName');
                  if ReadInteger('BillWidth') = 0 then
                    mdPrinters.FieldByName('BillWidth').AsString := '80 мм'
                  else if ReadInteger('BillWidth') = 0 then
                    mdPrinters.FieldByName('BillWidth').AsString := '58 мм'
                  else
                    mdPrinters.FieldByName('BillWidth').AsString := 'Лист А4 (товарный чек)';
                  mdPrinters.FieldByName('BillSdvig').AsInteger := ReadInteger('BillSdvig');
                  mdPrinters.FieldByName('BillQuantity').AsInteger := ReadInteger('BillQuantity');
                  mdPrinters.Refresh;
                end;
              end;
            end;

            if ValueExists('BillSlogan') then begin
              BillSlogan := ReadString('BillSlogan');
              edSlogan.Text := BillSlogan;
            end else begin
              BillSlogan := 'автоматизировано при помощи Shopuchet.kz';
              WriteString('BillSlogan', BillSlogan);
            end;

            if ValueExists('BillPrintChargedBonus') then begin
              BillPrintChargedBonus := ReadInteger('BillPrintChargedBonus');
              cbPrintChargedBonus.Checked := BillPrintChargedBonus = 1;
            end else begin
              BillPrintChargedBonus := 0;
              WriteInteger('BillPrintChargedBonus', BillPrintChargedBonus);
            end;

            if ValueExists('BillPrintBarcode') then begin
              BillPrintBarcode := ReadInteger('BillPrintBarcode');
              cbBillPrintBarcode.Checked := BillPrintBarcode = 1;
            end else begin
              BillPrintBarcode := 0;
              WriteInteger('BillPrintBarcode', BillPrintBarcode);
            end;

            if ValueExists('ComPortNumber') then begin
              ComPortNumber := ReadInteger('ComPortNumber');
              cbComPortNumber.ItemIndex := ComPortNumber - 1;
            end else begin
              ComPortNumber := -1;
              WriteInteger('ComPortNumber', ComPortNumber);
            end;
            if ValueExists('BaudRate') then begin
              BaudRate := ReadInteger('BaudRate');
              cbBaudRate.ItemIndex := BaudRate;
            end else begin
              BaudRate := 6;
              WriteInteger('BaudRate', BaudRate);
            end;
            {if ValueExists('FrConnectAnotherComp') then begin
              IsFrConnectedAnotherComp := ReadInteger('FrConnectAnotherComp');
              cbFrConnectAnotherComp.Checked := IsFrConnectedAnotherComp = 1;
            end else begin
              IsFrConnectedAnotherComp := 0;
              WriteInteger('FrConnectAnotherComp', IsFrConnectedAnotherComp);
            end;
            if ValueExists('IpFrConnectAnotherComp') then begin
              IpFrConnectAnotherComp := ReadString('IpFrConnectAnotherComp');
              edIpFrConnectAnotherComp.Text := IpFrConnectAnotherComp;
            end else begin
              IpFrConnectAnotherComp := '';
              WriteString('IpFrConnectAnotherComp', IpFrConnectAnotherComp);
            end;}

            {Сетевой режим}
            {if ValueExists('YesNetwork') then begin
              YesNetwork := ReadInteger('YesNetwork');
              rbYesNetwork.Checked := YesNetwork = 1;
            end else begin
              YesNetwork := 0;
              WriteInteger('YesNetwork', YesNetwork);
              rbNoNetwork.Checked := true;
            end;
            if ValueExists('ServerName') then begin
              ServerName := ReadString('ServerName');
              edServer.Text := ServerName;
            end else begin
              edServer.Text := '';
              ServerName := '';
              WriteString('ServerName', ServerName);
            end;}
			
            if ValueExists('Config') then begin
              Config := ReadInteger('Config');
              cbConfig.ItemIndex := Config;
            end else begin
              Config := cbConfig.ItemIndex;
              WriteInteger('Config', Config);
            end;

            //Производить товар автоматически 0 - Нет, 1 - Да
            if ValueExists('DoProductInSale') then
              DoProductInSale := ReadInteger('DoProductInSale')
            else begin
              DoProductInSale := 0;
              WriteInteger('DoProductInSale', DoProductInSale);
            end;
            cbDoProductInSale.Checked := DoProductInSale = 1;

            //Доставка сервис 0 - Нет, 1 - Да
            if ValueExists('DeliveryService') then
              DeliveryService := ReadInteger('DeliveryService')
            else begin
              DeliveryService := 0;
              WriteInteger('DeliveryService', DeliveryService);
            end;
            cbDeliveryService.Checked := DeliveryService = 1;

            //Длина штрихкода 0 - 13 знаков, 1 - 8 знаков
            if ValueExists('BarcodeLength') then
              BarcodeLength := ReadInteger('BarcodeLength')
            else begin
              BarcodeLength := 0;
              WriteInteger('BarcodeLength', BarcodeLength);
            end;
            cbBarcodeLength.ItemIndex := BarcodeLength;

            //*******************************************
            //конфигурация рабочего места кассира
            //*******************************************
            //вид РМК, 1 - компактный, 0 - стандартный
            if ValueExists('RmkView') then
              RmkView := ReadInteger('RmkView')
            else begin
              RmkView := 0;
              WriteInteger('RmkView', RmkView);
            end;
            cbRmkView.ItemIndex := RmkView;
            RmkViewChange;

            {показывать предварительное окно с количеством товара в режиме кассира 0 - нет, 1 - да}
            if ValueExists('ShowSaleDlg') then
              FShowSaleDlg := ReadInteger('ShowSaleDlg')
            else begin
              FShowSaleDlg := 0;
              WriteInteger('ShowSaleDlg', FShowSaleDlg);
            end;
            ceShowSaleDlg.Checked := FShowSaleDlg = 1;

            {показывать предварительное окно только для весовых товаров 0 - нет, 1 - да}
            if ValueExists('ShowSaleDlgForVes') then
              cbShowSaleDlgForVes.Checked := ReadInteger('ShowSaleDlgForVes') = 1
            else begin
              ShowSaleDlgForVes := 0;
              WriteInteger('ShowSaleDlgForVes', ShowSaleDlgForVes);
            end;

            {показывать в предварительном окне кнопки с цифрами 0 - нет, 1 - да}
            if ValueExists('ShowSaleDlgKeys') then
              cbShowSaleDlgKeys.Checked := ReadInteger('ShowSaleDlgKeys') = 1
            else begin
              ShowSaleDlgKeys := 0;
              WriteInteger('ShowSaleDlgKeys', ShowSaleDlgKeys);
            end;

            {закупочные цены в режиме кассира 0 - нет, 1 - да}
            if ValueExists('ShowCostPrice') then
              FShowCostPrice := ReadInteger('ShowCostPrice')
            else begin
              FShowCostPrice := 0;
              WriteInteger('ShowCostPrice', FShowCostPrice);
            end;
            cbShowCostPrice.Checked := FShowCostPrice = 1;

            //выставлять оптовые цены при продаже
            if ValueExists('OptPriceByDefault') then
              OptPriceByDefault := ReadInteger('OptPriceByDefault')
            else begin
              OptPriceByDefault := 0;
              WriteInteger('OptPriceByDefault', OptPriceByDefault);
            end;
            cbOptPriceByDefault.Checked := OptPriceByDefault = 1;

            //показывать панель с товарами
            if ValueExists('ShowTovarPanel') then
              ShowTovarPanel := ReadInteger('ShowTovarPanel')
            else begin
              ShowTovarPanel := 0;
              WriteInteger('ShowTovarPanel', ShowTovarPanel);
            end;
            cbShowTovarPanel.Checked := ShowTovarPanel = 1;

            //Показывать панель с выбором сотрудника
            if ValueExists('ShowKassirPanel') then
              ShowKassirPanel := ReadInteger('ShowKassirPanel')
            else begin
              ShowKassirPanel := 0;
              WriteInteger('ShowKassirPanel', ShowKassirPanel);
            end;
            cbShowKassirPanel.Checked := ShowKassirPanel = 1;

            //Показывать товары в виде кнопок, для кафе/баров
            if ValueExists('KafeTovarView') then
              KafeTovarView := ReadInteger('KafeTovarView')
            else begin
              KafeTovarView := 0;
              WriteInteger('KafeTovarView', KafeTovarView);
            end;
            cbShowKafeTovarView.Checked := KafeTovarView = 1;

            //показывать кнопку для создания новых клиентов
            if ValueExists('ShowInsClientBtn') then
              ShowInsClientBtn := ReadInteger('ShowInsClientBtn')
            else begin
              ShowInsClientBtn := 0;
              WriteInteger('ShowInsClientBtn', ShowInsClientBtn);
            end;
            cbShowInsClientBtn.Checked := ShowInsClientBtn = 1;

            //показывать картинки товаров
            if ValueExists('ShowProductImg') then
              ShowProductImg := ReadInteger('ShowProductImg')
            else begin
              ShowProductImg := 0;
              WriteInteger('ShowProductImg', ShowProductImg);
            end;
            cbShowProductImg.Checked := ShowProductImg = 1;

            //ПИН-КОД для удаления товаров из корзины
            if ValueExists('PinCodeForDelItems') then
              PinCodeForDelItems := ReadString('PinCodeForDelItems')
            else begin
              PinCodeForDelItems := '';
              WriteString('PinCodeForDelItems', PinCodeForDelItems);
            end;
            edPinCode.Text := PinCodeForDelItems;

            //*******************************************
            // ДИСПЛЕЙ
            //*******************************************
            if ValueExists('DisplayUse') then
              DisplayUse := ReadInteger('DisplayUse')
            else begin
              DisplayUse := 0;
              WriteInteger('DisplayUse', DisplayUse);
            end;
            cbEnableDisplay.Checked := DisplayUse = 1;

            //модель дисплея
            if ValueExists('DisplayModel') then
              DisplayModel := ReadInteger('DisplayModel')
            else begin
              DisplayModel := -1;
              WriteInteger('DisplayModel', DisplayModel);
            end;
            cbMonoblockList.ItemIndex := DisplayModel;

            //Com-Port дисплея
            if ValueExists('DisplayComPort') then
              DisplayComPort := ReadInteger('DisplayComPort')
            else begin
              DisplayComPort := -1;
              WriteInteger('DisplayComPort', DisplayComPort);
            end;
            cbDisplayComPort.ItemIndex := DisplayComPort;

            if ValueExists('DisplayComPortStr') then
              DisplayComPortStr := ReadString('DisplayComPortStr')
            else begin
              DisplayComPortStr := '';
              WriteString('DisplayComPortStr', DisplayComPortStr);
            end;
            FDisplayComPortStrOld := DisplayComPortStr;

            //Скорость Com-Port дисплея
            if ValueExists('DisplayComBaudRate') then
              DisplayComBaudRate := ReadInteger('DisplayComBaudRate')
            else begin
              DisplayComBaudRate := -1;
              WriteInteger('DisplayComBaudRate', DisplayComBaudRate);
            end;
            cbDisplayComBaudRate.ItemIndex := DisplayComBaudRate;

            //************************************************
            // pos-терминал
            //************************************************
            //включение терминала
            if ValueExists('UsePosTerminal') then
              UsePosTerminal := ReadInteger('UsePosTerminal')
            else begin
              UsePosTerminal := 0;
              WriteInteger('UsePosTerminal', UsePosTerminal);
            end;
            cbUsePosTerminal.Checked := UsePosTerminal = 1;

            if cbUsePosTerminal.Checked then begin
              if ValueExists('PosTerminalArray') then begin
                mdPosTerminal.Open;
                Str := ReadString('PosTerminalArray');
                while Length(Str) > 1 do begin
                  mdPosTerminal.Insert;
                  p := pos('~', Str);
                  str1 := Copy(Str, 1, p-1);
                  mdPosTerminal.FieldByName('IP').AsString := str1;

                  // Модель
                  Delete(str, 1, p);
                  p := pos('~', Str);
                  str1 := Copy(Str, 1, p-1);
                  mdPosTerminal.FieldByName('TypeTerminal').AsInteger := StrToInt(str1);

                  // Наименование
                  Delete(str, 1, p);
                  p := pos('~', Str);
                  str1 := Copy(Str, 1, p-1);
                  mdPosTerminal.FieldByName('Name').AsString := str1;

                  Delete(str, 1, p);
                end;
                mdPosTerminal.Refresh;
              end else begin
                //IP-адрес терминала
                if ValueExists('PosTerminalIp') then begin
                  mdPosTerminal.Open;
                  mdPosTerminal.Insert;
                  mdPosTerminal.FieldByName('IP').AsString := ReadString('PosTerminalIp');
                  mdPosTerminal.FieldByName('TypeTerminal').AsInteger := 1;
                  mdPosTerminal.FieldByName('Name').AsString := 'Kaspi Терминал';
                  mdPosTerminal.Refresh;
                end;

                //edPosTerminalIp.Text := PosTerminalIp;

                // тип безналичной оплаты по которой будет отправка на терминал
                {if ValueExists('PosTerminalNonCashPayType') then
                  PosTerminalNonCashPayType := ReadInteger('PosTerminalNonCashPayType')
                else begin
                  PosTerminalNonCashPayType := 1;
                  WriteInteger('PosTerminalNonCashPayType', PosTerminalNonCashPayType);
                end;
                OpenSp(spPaymentTypes, False); }
                //leGNonCashPayType.EditValue := PosTerminalNonCashPayType;
              end;
            end;
            btnAddTerminal.Enabled := cbUsePosTerminal.Checked = True;
            btnDelTerminal.Enabled := (cbUsePosTerminal.Checked = True) and (mdPosTerminal.RecordCount > 0);
            cxgrdTerminal.Enabled := cbUsePosTerminal.Checked = True;
            //************************************************

            {-----------------------}
            {Шрифты                 }
            {-----------------------}
            {Шрифт в меню}
            if ValueExists('MenuFontName') then
              FMenuFontName := ReadString('MenuFontName')
            else begin
              FMenuFontName := 'Tahoma';
              WriteString('MenuFontName', FMenuFontName);
            end;
            peMenuFont.ItemIndex := peMenuFont.Properties.Items.IndexOf(FMenuFontName);
            {----------------------------}
            if ValueExists('MenuFontSize') then
              FMenuFontSize := ReadInteger('MenuFontSize')
            else begin
              FMenuFontSize := 9;
              WriteInteger('MenuFontSize', FMenuFontSize);
            end;
            seMenuFontSize.EditValue := FMenuFontSize;

            {----------------------------}
            {Шрифт в сетках}
            if ValueExists('GridFontName') then
              FGridFontName := ReadString('GridFontName')
            else begin
              FGridFontName := 'Tahoma';
              WriteString('GridFontName', FGridFontName);
            end;
            peGridFont.ItemIndex := peGridFont.Properties.Items.IndexOf(FGridFontName);
            {----------------------------}
            if ValueExists('GridFontSize') then
              FGridFontSize := ReadInteger('GridFontSize')
            else begin
              FGridFontSize := 9;
              WriteInteger('GridFontSize', FGridFontSize);
            end;
            seGridFontSize.EditValue := FGridFontSize;
            {----------------------------}

            {Параметры Rekassa}
            if ValueExists('ReKassa') then
              ReKassa := ReadBool('ReKassa')
            else
            begin
              ReKassa := False;
              WriteBool('ReKassa', ReKassa);
            end;
            if ValueExists('Login') then
            begin
              Login := ReadString('Login');
              edLogin.Text := Login;
            end
            else
            begin
              Login := '';
              edLogin.Text := Login;
              WriteString('Login', Login);
            end;
            if ValueExists('Pass') then
            begin
              Pass := ReadString('Pass');
              edPass.Text := Pass;
            end
            else
            begin
              Pass := '';
              edPass.Text := Pass;
              WriteString('Pass', Pass);
            end;
            if ValueExists('Pin_Code') then
            begin
              PinCode := ReadString('Pin_Code');
              edtPin.Text := PinCode;
            end
            else
            begin
              PinCode := '';
              edtPin.Text := PinCode;
              WriteString('Pin_Code', PinCode);
            end;
            if ValueExists('DomainType') then
            begin
              DomainType := ReadInteger('DomainType');
              cbDomainType.ItemIndex := DomainType;
            end
            else
            begin
              cbDomainType.ItemIndex := 0;
              DomainType := cbDomainType.ItemIndex;
              WriteInteger('DomainType', DomainType);
            end;
            cbPrnt.Properties.Items.Assign(Printer.Printers);
            if ValueExists('RekassaPrinters') then
            begin
              Str := ReadString('RekassaPrinters');
              if trim(Str) <> EmptyStr then
              begin
                p := pos('~', Str);
                PrinterRekassa.Name := Copy(Str, 1, p-1);
                // ширина
                Delete(str, 1, p);
                p := pos('~', Str);
                PrinterRekassa.BillWidth := Copy(Str, 1, p-1);
                // сдвиг
                Delete(str, 1, p);
                p := pos('~', Str);
                PrinterRekassa.BillSdvig := StrToInt(Copy(Str, 1, p-1));
                // количество копий
                Delete(str, 1, p);
                p := pos('~', Str);
                PrinterRekassa.BillQuantity := StrToInt(Copy(Str, 1, p-1));
                for i := 0 to cbPrnt.Properties.Items.Count -1 do
                begin
                  if cbPrnt.Properties.Items[i] = PrinterRekassa.Name then
                  begin
                    cbPrnt.ItemIndex := i;
                    break;
                  end;
                end;
              end;
            end;
            //Параметры ТИС
            if ValueExists('LoginTIS') then
            begin
              LoginTIS := ReadString('LoginTIS');
              edtLoginTIS.Text := LoginTIS;
            end
            else
            begin
              LoginTIS := '';
              edtLoginTIS.Text := LoginTIS;
              WriteString('LoginTIS', LoginTIS);
            end;
            if ValueExists('PassTIS') then
            begin
              PassTIS := ReadString('PassTIS');
              edtPassTIS.Text := PassTIS;
            end
            else
            begin
              PassTIS := '';
              edtPassTIS.Text := PassTIS;
              WriteString('PassTIS', PassTIS);
            end;
            if ValueExists('PortTIS') then
            begin
              PortTIS := ReadInteger('PortTIS');
              edtPort.Text := IntToStr(PortTIS);
            end
            else
            begin
              PortTIS := 0;
              edtPort.Text := IntToStr(PortTIS);
              WriteInteger('PortTIS', PortTIS);
            end;
            if ValueExists('TerminalTIS') then
            begin
              Terminal := ReadInteger('TerminalTIS');
              cbTerminal.ItemIndex := Terminal;
            end
            else
            begin
              Terminal := 0;
              cbTerminal.ItemIndex := Terminal;
              WriteInteger('TerminalTIS', Terminal);
            end;
            if ValueExists('FindShtrikh') then
            begin
              FindShtrikh := ReadBool('FindShtrikh');
              cbFindShtrikh.Checked := FindShtrikh;
            end
            else
            begin
              FindShtrikh := False;
              cbFindShtrikh.Checked := FindShtrikh;
              WriteBool('FindShtrikh', FindShtrikh);
            end;

            if ValueExists('isCredit') then
            begin
              isCredit := ReadBool('isCredit');
              cbCredit.Checked := isCredit;
            end
            else
            begin
              isCredit := False;
              cbCredit.Checked := isCredit;
              WriteBool('isCredit', isCredit);
            end;
          finally
            CloseKey;
          end;
      end;
    finally
      Reg.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TSetupForm.GetData)', mtError, [mbOk], 0);
  end;

  if MainDM.dbMain.Connected then begin
    spGetdata.ParamByName('system_setup_').AsFloat := 1;
    ExecSp(spGetdata);
    cbFormula.ItemIndex := spGetdata.ParamByName('s_value_').AsInteger;

    //как платить комиссию продавцам
    spGetdata.ParamByName('system_setup_').AsFloat := 4;
    ExecSp(spGetdata);
    cbSalary.ItemIndex := spGetdata.ParamByName('s_value_').AsInteger;

    spGetdata.ParamByName('system_setup_').AsFloat := 2;
    ExecSp(spGetdata);
    ceCanSellNol.Checked := spGetdata.ParamByName('s_value_').AsInteger = 1;
  end;

  // настройки из INI-файла
  Ini:=TMeminiFile.Create(Extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    //Cетевой режим, т.к. раньше сетевой режим хранился в реестре, то вверху читаю сначала реестр
    //а затем тут буду проверять, если не заполнено - то проверю здесь еще
    //if YesNetwork = 0 then begin
      YesNetwork := Ini.ReadInteger('NetworkSettings', 'YesNetwork', 0);
      rbYesNetwork.Checked := YesNetwork = 1;
      rbNoNetwork.Checked := YesNetwork = 0;

      ServerName := Ini.ReadString('NetworkSettings', 'ServerName', '');
      LimitCount := Ini.ReadInteger('NetworkSettings', 'LimitCount', 0);
      cbLimitCount.Checked := LimitCount = 1;
      edServer.Text := ServerName;
    //end;

    // принтер для печати этикеток
    cbPrintersEtiket.ItemIndex := Ini.ReadInteger('Printetiket', 'PrinterIndex', 0);
    rbPrint.Checked := Ini.ReadInteger('Printetiket', 'PrinterEtiket', 1) = 1;
    rbPrinterA4.Checked := Ini.ReadInteger('Printetiket', 'PrinterA4', 0) = 1;
    cbChooseLentWidth.ItemIndex := Ini.ReadInteger('Printetiket', 'LentaWidth', 0);
    cbA4Size.ItemIndex := Ini.ReadInteger('Printetiket', 'A4Size', 0);
    cbCennikSize.ItemIndex := Ini.ReadInteger('Printetiket', 'CennikSize', 0);
    //этикетки
    edSloganEtiket.Text := Ini.ReadString('Printetiket', 'Slogan', '');
    cbPrintPrice.Checked := Ini.ReadInteger('Printetiket', 'PrintPrice', 0) = 1;
    cbPrintArticul.Checked := Ini.ReadInteger('Printetiket', 'PrintArticul', 0) = 1;
    cbPrintSlogan.Checked := Ini.ReadInteger('Printetiket', 'PrintSlogan', 0) = 1;
    cbPriceBold.Checked := Ini.ReadInteger('Printetiket', 'PriceBold', 0) = 1;
    cbArticulBold.Checked := Ini.ReadInteger('Printetiket', 'PriceArticul', 0) = 1;
    cbSloganBold.Checked := Ini.ReadInteger('Printetiket', 'SloganBold', 0) = 1;
    PriceSize := Ini.ReadInteger('Printetiket', 'PriceSize', 0);
    ArticulSize := Ini.ReadInteger('Printetiket', 'ArticulSize', 0);
    SloganSize := Ini.ReadInteger('Printetiket', 'SloganSize', 0);
    NameSize := Ini.ReadInteger('Printetiket', 'NameSize', 0);
    cbNameBold.Checked := Ini.ReadInteger('Printetiket', 'NameBold', 0) = 1;
    SetDefaultSize(PriceSize, ArticulSize, SloganSize, NameSize);
    //ценники
    edSloganCennik.Text := Ini.ReadString('Printetiket', 'CennikSlogan', '');
    cbCennikPrintPrice.Checked := Ini.ReadInteger('Printetiket', 'CennikPrintPrice', 0) = 1;
    cbCennikPrintSlogan.Checked := Ini.ReadInteger('Printetiket', 'CennikPrintSlogan', 0) = 1;
    cbCennikPriceBold.Checked := Ini.ReadInteger('Printetiket', 'CennikPriceBold', 0) = 1;
    cbCennikSloganBold.Checked := Ini.ReadInteger('Printetiket', 'CennikSloganBold', 0) = 1;
    CennikPriceSize := Ini.ReadInteger('Printetiket', 'CennikPriceSize', 0);
    CennikSloganSize := Ini.ReadInteger('Printetiket', 'CennikSloganSize', 0);
    CennikNameSize := Ini.ReadInteger('Printetiket', 'CennikNameSize', 0);
    cbCennikNameBold.Checked := Ini.ReadInteger('Printetiket', 'CennikNameBold', 0) = 1;
    SetCennikDefaultSize(CennikPriceSize, CennikSloganSize, CennikNameSize);
    //seSdvig.Value := Ini.ReadInteger('Printetiket', 'Sdvig', 0);

    // СМС
    edSmsLogin.Text := Ini.ReadString('SMS', 'Login', '');
    edSmsPassword.Text := Ini.ReadString('SMS', 'Password', '');
    cbEnableSmsHB.Checked := Ini.ReadInteger('SMS', 'EnableSmsHB', 0) = 1;
    mSmsHBText.Text := Ini.ReadString('SMS', 'SmsHbText', 'Добрый день, @name@! Салон красоты "Beauty" поздравляет Вас с Днем Рождения и дарит персональную скидку 10%!');
    cbTranslit.Checked := Ini.ReadInteger('SMS', 'TranslitSms', 0) = 1;

    //Мои звонки
    edCallLogin.Text := Ini.ReadString('Calls', 'CallLogin', '');
    edCallAPIAddress.Text := Ini.ReadString('Calls', 'CallAPIAddress', '');
    edCallAPI.Text := Ini.ReadString('Calls', 'CallAPI', '');

    //Онлайн-запись
    cbEnableOnlineZapis.Checked := Ini.ReadInteger('OnlineZapis', 'OnlineZapisEnabled', 0) = 1;
    edOnlineZapisLink.Text := Ini.ReadString('OnlineZapis', 'OnlineZapisLink', '');
    edOnlineZapisLogin.Text := Ini.ReadString('OnlineZapis', 'OnlineZapisLogin', '');
    edOnlineZapisPass.Text := Ini.ReadString('OnlineZapis', 'OnlineZapisPass', '');
    cbOnlineZapisRefresh.ItemIndex := Ini.ReadInteger('OnlineZapis', 'OnlineZapisRefresh', 0);
    cbOnlineZapisDoSyncAlways.Checked := Ini.ReadInteger('OnlineZapis', 'OnlineZapisDoSyncAlways', 0) = 1;

    //Кол-во знаков после запятой
    edDecimalCount.Text := Ini.ReadString('Config', 'DecimalCount', '2');

  finally
    Ini.Free;
  end;

  //записываю старые значения
  FolDrec.Country  := cbCurrency.Text;
  FolDrec.Formula  := cbFormula.Text;
  FolDrec.ZpCalc   := cbSalary.Text;
  FolDrec.CanSellNol := ceCanSellNol.Checked;
  FolDrec.ManyFirm   := ceManyFirm.Checked;
  FolDrec.NotifyNol  := ceNotifyNol.Checked;
  FolDrec.NewLineSale  := ceNewLineSale.Checked;
  FolDrec.UseTovarPlace := ceUseTovarPlace.Checked;
  FolDrec.UseTovarNoteInSearch := cbUseTovarNoteInSearch.Checked;
  FolDrec.UseCurrency := ceUseCurrency.Checked;
  FolDrec.Config      := cbConfig.Text;
  FolDrec.BarcodeLength := cbBarcodeLength.Text;
  FolDrec.DecimalCount  := edDecimalCount.Text;
  FolDrec.DoProductInSale := cbDoProductInSale.Checked;
  FolDrec.DeliveryService := cbDeliveryService.Checked;
  FolDrec.ShowCostPrice   := cbShowCostPrice.Checked;
  FolDrec.PinCode         := edPinCode.Text;
  //FolDrec.CheckPrintDevice:= cbCheckPrintDevice.Text;
  FolDrec.ComPortNumber   := cbComPortNumber.Text;
  FolDrec.BaudRate        := cbBaudRate.Text;
  FolDrec.UseScales       := cbUseScales.Checked;
  FolDrec.ScalesPrefix    := edScalesPrefix.Text;
  //FolDrec.ScalesIp        := edScalesIp.Text;
  //FolDrec.ScalesPort      := edScalesPort.Text;
  //FolDrec.Scales          := cbScales.Text;
  FolDrec.SmsLogin        := edSmsLogin.Text;
  FolDrec.SmsPassword     := edSmsPassword.Text;
  FolDrec.BackupFileName  := bedtFileName.Text;
  FolDrec.BackupPeriod    := cbBackupPeriod.Text;
  FolDrec.DoBackupOnStart := rbDoBackupOnStart.Checked;
  FolDrec.NoNetwork       := rbNoNetwork.Checked;
  FolDrec.Server          := edServer.Text;
  FolDrec.SyncFileName    := SyncFolder;
  FolDrec.SyncInterval    := SyncInterval;
  FolDrec.LetDoReturnWithoutSale := FLetDoReturnWithoutSale;
end;

function TSetupForm.SaveSetup: Boolean;
var
  Reg: TRegistry;
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  i : integer;
  d : DOUBLE;
  str : string;
  aValue : Variant;
begin
  Result := False;
  try
    Reg := TRegistry.Create;
    try
      with Reg do begin
        RootKey := RegSetupRoot;
        LazyWrite := False;  {Сохраняем ключи до закрытия}
        if OpenKey(RegSetupKey, True) then
          try
            {Внешний вид и поведение}
            WriteInteger('ToolbarStyle', Integer(ToolbarStyle));
            WriteInteger('CustomStyle', Integer(CustomStyle));
            WriteInteger('TabStyle', Integer(TabStyle));

            WriteInteger('tbButtonsStyle', Integer(FtbButtonsStyle));
            WriteInteger('AutoRefresh', FAutoRefresh);

            WriteInteger('PopupFormBorderStyle', Integer(FPopupFormBorderStyle));
            WriteBool('PopupFlatBorder', FPopupFlatBorder);

            if SysUtils.DirectoryExists(FBackupDir) = False then begin
              MessageDlg('Папка для сохранения копии БД не существует! "' + FBackupDir + '"', mtError, [mbOK], 0);
              pcCommon.ActivePage := tsBackup;
              Exit;
            end;
            WriteString('BackupDir', FBackupDir);
            BackupDir := FBackupDir;
            
            WriteInteger('BackupPeriod', FBackupPeriod);

            WriteInteger('DoBackupOnStart', FDoBackupOnStart);
            {Продавать товары с нулевым остатком или нет 0 - нет, 1 - да}
            //WriteInteger('AllowSellAbsentGoods', FAllowSellAbsentGoods);
            AllowSellAbsGoods := FAllowSellAbsentGoods;

            {Режим нескольких фирм 0 - нет, 1 - да}
            WriteInteger('ManyFirm', Integer(ceManyFirm.Checked));
            ManyFirm := Integer(ceManyFirm.Checked);

            {предупреждать о добавлении товара с нулевой ценой при продаже 0 - нет, 1 - да}
            WriteInteger('NotifyNol', FNotifyNol);
            NotifyNol := FNotifyNol;

            {искать по полю "Место на складе" во всех режимах 0 - нет, 1 - да}
            WriteInteger('UseTovarPlace', FUseTovarPlace);
            UseTovarPlace := FUseTovarPlace;

            {искать по полю "Место на складе" во всех режимах 0 - нет, 1 - да}
            WriteInteger('UseTovarNoteInSearch', FUseTovarNoteInSearch);
            UseTovarNoteInSearch := FUseTovarNoteInSearch;

            {Отображать валюты в приходе товара 0 - нет, 1 - да}
            WriteBool('UseCurrency', FUseCurrency);
            UseCurrency := FUseCurrency;

            {Закреплять мастера за счетом 0 - нет, 1 - да}
            WriteBool('SetOneMaster', FConfSetOneMaster);
            ConfSetOneMaster := FConfSetOneMaster;

            {Показывать окно с именинниками 0 - нет, 1 - да}
            WriteBool('ShowImens', FShowImens);
            ShowImens := FShowImens;

            {Начислять бонусы за рекомменд 0 - нет, 1 - да}
            WriteBool('AddBonusForPromo', FAddBonusForPromo);
            AddBonusForPromo := FAddBonusForPromo;

            {Не начислять бонусы при продаже в долг, 1 - не начислять, 0 - начислять}
            DoNotCreditBonusOnDolg := Integer(cbDoNotCreditBonusOnDolg.Checked);
            WriteInteger('DoNotCreditBonusOnDolg', DoNotCreditBonusOnDolg);

            {Устанавливать курсор на товар при сканировании штрихкода, 1 - да, 0 - нет}
            SetCursorOnTovar := Integer(cbSetCursorOnTovar.Checked);
            WriteInteger('SetCursorOnTovar', SetCursorOnTovar);

            //Разграничение прав на просмотр прихода товара
            SetSaleOfGoods := Integer(cbSetSaleOfGoods.Checked);
            WriteInteger('SetSaleOfGoods', SetSaleOfGoods);

            {Размер бонусов за рекомменд}
            WriteFloat('AmountBonusForPromo', FAmountBonusForPromo);
            AmountBonusForPromo := FAmountBonusForPromo;

            {Отправлять СМС при начислении бонусов за рекомменд}
            WriteBool('SendSmsWhenBonusAdd', FSendSmsWhenBonusAdd);
            SendSmsWhenBonusAdd := FSendSmsWhenBonusAdd;

            {Текст СМС при начислении бонусов за рекомменд}
            WriteString('TextSmsWhenBonusAdd', FTextSmsWhenBonusAdd);
            TextSmsWhenBonusAdd := FTextSmsWhenBonusAdd;

            {нельзя записывать клиента на время, которое у мастера уже закрыто}
            WriteBool('DoNotAllowCrossTime', FDoNotAllowCrossTime);
            DoNotAllowCrossTime := FDoNotAllowCrossTime;

            {размер бонуса для новых (создаваемых) клиентов}
            WriteInteger('BonusOnCreateClient', FBonusOnCreateClient);
            BonusOnCreateClient := FBonusOnCreateClient;

            {не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да}
            WriteInteger('NewLineSale', FNewLineSale);
            NewLineSale := FNewLineSale;

            {Разрешить оформлять возврат товара без продажи}
            WriteInteger('LetDoReturnWithoutSale', FLetDoReturnWithoutSale);
            LetDoReturnWithoutSale := FLetDoReturnWithoutSale;

            {Валюта 0 - тенге, 1 - рубли, 2 - гривны}
            WriteInteger('Currency', CurrencyVal);

            // ====================================================
            // ВЕСЫ
            // ====================================================
            {использовать весы, 0 - нет, 1 - да}
            WriteInteger('UseScales', FUseScales);
            UseScales := FUseScales;

            {префикс весового товара}
            WriteString('ScalesPrefix', FScalesPrefix);
            ScalesPrefix := FScalesPrefix;

            if (FUseScales = 1) and (mdScales.Active) then begin
              SetLength(ScalesArr, 0);
              mdScales.First;
              i := 0;
              while not mdScales.eof do begin
                str := str + mdScales.FieldByName('name').AsString + '~' + mdScales.FieldByName('ModelId').AsString +
                  '~' + mdScales.FieldByName('IP').AsString + '~' + mdScales.FieldByName('Port').AsString + '~';
                i := i + 1;
                mdScales.Next;
              end;

              //сначала сохраню все в массив
              WriteString('ScalesArray', str);

              //удаляю старые значения
              if ValueExists('ScalesIp') then begin
                DeleteValue('ScalesIp');
                DeleteValue('ScalesPort');
                DeleteValue('ScalesModel');
              end;
            end;
            str := '';

            // ====================================================
            // ВЕСЫ КОНЕЦ
            // ====================================================

            {Принтер чеков и ширины ленты чеков}
            PrintOnPrinters := cbPrintOnPrinters.Checked;
            PrintOnFr       := cbPrintOnFr.Checked;
            CheckPrintDeviceFr := cbCheckPrintDeviceFr.ItemIndex;
            WriteInteger('CheckPrintDeviceFr', CheckPrintDeviceFr);
            WriteBool('PrintOnPrinters', PrintOnPrinters);
            WriteBool('PrintOnFr', PrintOnFr);
            if (PrintOnPrinters) and (mdPrinters.Active) then begin
              SetLength(PrintersArr, 0);
              mdPrinters.First;
              i := 0;
              while not mdPrinters.eof do begin
                str := str + mdPrinters.FieldByName('name').AsString + '~' + mdPrinters.FieldByName('BillWidth').AsString +
                  '~' + mdPrinters.FieldByName('BillSdvig').AsString + '~' + mdPrinters.FieldByName('BillQuantity').AsString + '~';
                i := i + 1;
                mdPrinters.Next;
              end;

              //сначала сохраню все в массив
              WriteString('BillPrinters', str);

              //удаляю старые значения
              if ValueExists('BillPrinterName') then begin
                DeleteValue('BillPrinterName');
                DeleteValue('BillWidth');
                DeleteValue('BillSdvig');
                DeleteValue('BillQuantity');
              end;
            end;
            WriteString('BillSlogan', BillSlogan);
            if cbPrintOnFr.Checked then
            begin
              if (ReKassa) and (cbCheckPrintDeviceFr.ItemIndex=5) then
              begin
                if Trim(cbDomainType.Text)='' then
                begin
                  MessageDlg('Выберите сферу деятельности', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  cbDomainType.SetFocus;
                  Exit;
                end
                else
                  DomainType := cbDomainType.ItemIndex;

                if Trim(edLogin.Text)='' then
                begin
                  MessageDlg('Введите логин для ReKassa', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  edLogin.SetFocus;
                  Exit;
                end
                else
                  Login := edLogin.Text;
                if Trim(edPass.Text)='' then
                begin
                  MessageDlg('Введите пароль для ReKassa', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  edPass.SetFocus;
                  Exit;
                end
                else
                  Pass := edPass.Text;
                if Length(Trim(edtPin.Text))<>4 then
                begin
                  MessageDlg('Не верный ПИН-код', mtError, [mbok],0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  edtPin.SetFocus;
                  Exit;
                end;
                if (Trim(edtPin.Text)='') or (Trim(edtPin.Text)='0') then
                begin
                  MessageDlg('Введите ПИН-код для ReKassa', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  edtPin.SetFocus;
                  Exit;
                end
                else
                  PinCode := edtPin.Text;
                if Assigned(KKMReKassa) then
                  KKMReKassa.Destroy;
                KKMReKassa := TReKassa.Create(Login, Pass, PinCode, Test_Rekassa);
                if Trim(cbPrnt.Text) = EmptyStr then
                begin
                  MessageDlg('Для печати вам необходимо выбрать принтер', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  cbPrnt.SetFocus;
                  exit;
                end
                else
                begin
                  if PrinterRekassa.BillWidth = EmptyStr then
                    PrinterRekassa.BillWidth := '80 мм';
                  if PrinterRekassa.BillQuantity = 0  then
                    PrinterRekassa.BillQuantity := 1;
                  PrinterRekassa.Name := cbPrnt.Text;
                  str := {str + }PrinterRekassa.Name + '~' +
                          PrinterRekassa.BillWidth +
                          '~' + IntToStr(PrinterRekassa.BillSdvig) + '~' +
                          IntToStr(PrinterRekassa.BillQuantity) + '~';
                  //сохраняем
                  WriteString('RekassaPrinters', str);
                end;
                WriteBool('ReKassa', ReKassa);
                WriteString('Login', Login);
                WriteString('Pass', Pass);
                WriteString('Pin_Code', PinCode);
                WriteInteger('DomainType', DomainType);
              end;
              if cbCheckPrintDeviceFr.ItemIndex=6 then
              begin
                if Trim(edtLoginTIS.Text) = EmptyStr then
                begin
                  MessageDlg('Вы не указали логин', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  edtLoginTIS.SetFocus;
                  exit;
                end;
                if Trim(edtPassTIS.Text) = EmptyStr then
                begin
                  MessageDlg('Вы не указали пароль', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  edtPassTIS.SetFocus;
                  exit;
                end;
                if (Trim(edtPort.Text) = EmptyStr) or (edtPort.Text = '0') then
                begin
                  MessageDlg('Вы не указали порт', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  edtPort.SetFocus;
                  exit;
                end;

                if Trim(cbPrnt.Text) = EmptyStr then
                begin
                  MessageDlg('Для печати вам необходимо выбрать принтер', mtInformation, [mbOK], 0);
                  pcCommon.ActivePage := tsPrintBill;
                  pcPrinters.ActivePage := tsFr;
                  cbPrnt.SetFocus;
                  exit;
                end
                else
                begin
                  if PrinterRekassa.BillWidth = EmptyStr then
                    PrinterRekassa.BillWidth := '80 мм';
                  if PrinterRekassa.BillQuantity = 0  then
                    PrinterRekassa.BillQuantity := 1;
                  PrinterRekassa.Name := cbPrnt.Text;
                  str := {str + }PrinterRekassa.Name + '~' +
                          PrinterRekassa.BillWidth +
                          '~' + IntToStr(PrinterRekassa.BillSdvig) + '~' +
                          IntToStr(PrinterRekassa.BillQuantity) + '~';
                  //сохраняем
                  WriteString('RekassaPrinters', str);
                end;
                if not TryStrToInt(edtPort.Text, PortTis) then
                  PortTis := 0;
                LoginTIS := edtLoginTIS.Text;
                PassTIS := edtPassTIS.Text;
                Terminal := cbTerminal.ItemIndex;
                {Параметры ТИС}
                WriteInteger('PortTIS', PortTis);
                WriteString('LoginTIS', LoginTIS);
                WriteString('PassTIS', PassTIS);
                WriteInteger('TerminalTIS', Terminal);
              end;
            end;

            isCredit := cbCredit.Checked;
            WriteBool('isCredit', isCredit);

            BillPrintChargedBonus := Integer(cbPrintChargedBonus.Checked);
            WriteInteger('BillPrintChargedBonus', BillPrintChargedBonus);

            BillPrintBarcode := Integer(cbBillPrintBarcode.Checked);
            WriteInteger('BillPrintBarcode', BillPrintBarcode);

            ComPortNumber := cbComPortNumber.ItemIndex + 1;
            WriteInteger('ComPortNumber', ComPortNumber);
            BaudRate := cbBaudRate.ItemIndex;
			      WriteInteger('BaudRate', BaudRate);

            {конфигурация магазина}
            WriteInteger('Config', Config);

            {Производить товары автоматически 0 - нет, 1 - да}
            DoProductInSale := Integer(cbDoProductInSale.Checked);
            WriteInteger('DoProductInSale', DoProductInSale);

            {Доставка сервис 0 - нет, 1 - да}
            DeliveryService := Integer(cbDeliveryService.Checked);
            WriteInteger('DeliveryService', DeliveryService);

            {Длина штрихкода 0 - 13, 1 - 8}
            BarcodeLength := cbBarcodeLength.ItemIndex;
            WriteInteger('BarcodeLength', BarcodeLength);

            //*******************************************
            //конфигурация рабочего места кассира
            //*******************************************
            {показывать предварительное окно с количеством товара в режиме 0 - нет, 1 - да}
            WriteInteger('ShowSaleDlg', FShowSaleDlg);
            ShowSaleDlg := FShowSaleDlg;

            //показывать предварительное окно только для весового товара 0 - нет, 1 - да
            ShowSaleDlgForVes := Integer(cbShowSaleDlgForVes.Checked);
            WriteInteger('ShowSaleDlgForVes', ShowSaleDlgForVes);

            //показывать в предварительном окне кнопки-цифры 0 - нет, 1 - да
            ShowSaleDlgKeys := Integer(cbShowSaleDlgKeys.Checked);
            WriteInteger('ShowSaleDlgKeys', ShowSaleDlgKeys);

            //показывать предварительное окно с количеством товара в режиме 0 - нет, 1 - да
            WriteInteger('ShowSaleDlg', FShowSaleDlg);
            ShowSaleDlg := FShowSaleDlg;

            {показывать закупочные цены в режиме 0 - нет, 1 - да}
            WriteInteger('ShowCostPrice', FShowCostPrice);
            ShowCostPrice := FShowCostPrice;

            //выставлять оптовые цены при продаже
            OptPriceByDefault := Integer(cbOptPriceByDefault.Checked);
            WriteInteger('OptPriceByDefault', OptPriceByDefault);

            //вид РМК, 1 - компактный, 0 - стандартный
            RmkView := Integer(cbRmkView.ItemIndex);
            WriteInteger('RmkView', RmkView);

            //показывать панель с товарами
            if Config = 5 then begin
              WriteInteger('ShowTovarPanel', 1);
              ShowTovarPanel := 1;

              RmkView := 0;
              WriteInteger('RmkView', RmkView);
            end
            else begin
              ShowTovarPanel := Integer(cbShowTovarPanel.Checked);
              WriteInteger('ShowTovarPanel', ShowTovarPanel);
            end;

            //Показывать панель с выбором сотрудника
            ShowKassirPanel := Integer(cbShowKassirPanel.Checked);
            WriteInteger('ShowKassirPanel', ShowKassirPanel);

            //Показывать товары в виде кнопок
            if Config = 5 then begin
              WriteInteger('KafeTovarView', 1);
              KafeTovarView := 1;
            end
            else begin
              KafeTovarView := Integer(cbShowKafeTovarView.Checked);
              WriteInteger('KafeTovarView', KafeTovarView);
            end;

            //показывать кнопку для создания новых клиентов
            ShowInsClientBtn := Integer(cbShowInsClientBtn.Checked);
            WriteInteger('ShowInsClientBtn', ShowInsClientBtn);

            //показывать кнопку для создания новых клиентов
            ShowProductImg := Integer(cbShowProductImg.Checked);
            WriteInteger('ShowProductImg', ShowProductImg);

            //ПИН-КОД для удаления товаров из корзины
            PinCodeForDelItems := edPinCode.Text;
            WriteString('PinCodeForDelItems', PinCodeForDelItems);

            //*******************************************
            // ДИСПЛЕЙ
            //*******************************************
            DisplayUse := Integer(cbEnableDisplay.Checked);
            WriteInteger('DisplayUse', DisplayUse);

            DisplayModel := cbMonoblockList.ItemIndex;
            WriteInteger('DisplayModel', DisplayModel);

            DisplayComPort := cbDisplayComPort.ItemIndex;
            WriteInteger('DisplayComPort', DisplayComPort);

            DisplayComPortStr := cbDisplayComPort.Text;
            WriteString('DisplayComPortStr', DisplayComPortStr);

            DisplayComBaudRate := cbDisplayComBaudRate.ItemIndex;
            WriteInteger('DisplayComBaudRate', DisplayComBaudRate);

            //************************************************
            // POS-терминал
            //************************************************
            {if cbUsePosTerminal.Checked and (cxgrdbclmn1.EditValue = '') then begin
              MessageDlg('Подключен POS-терминал, но не указан его IP-адрес!', mtError, [mbOK], 0);
              pcCommon.ActivePage := tsPosTerminals;
              Exit;
            end;

            if cbUsePosTerminal.Checked and (cxgrdbclmn2.EditValue <= 0) then begin
              MessageDlg('Подключен POS-терминал, но не указан его тип!', mtError, [mbOK], 0);
              pcCommon.ActivePage := tsPosTerminals;
              Exit;
            end;}

            str := '';
            UsePosTerminal := Integer(cbUsePosTerminal.Checked);
            WriteInteger('UsePosTerminal', UsePosTerminal);
            if (UsePosTerminal = 1) and (mdPosTerminal.Active) then begin
              SetLength(PosTerminalArr, 0);
              with mdPosTerminal do begin
                First;
                while not eof do begin
                  str := str + FieldByName('IP').AsString + '~' + FieldByName('TypeTerminal').AsString +
                    '~' + FieldByName('Name').AsString + '~';
                  Next;
                end;
              end;

              WriteString('PosTerminalArray', str);
            end;
            str := '';
            //************************************************

            //************************************************
            // Для программы "Учет автосервиса"
            //************************************************
            {учитывтаь дату завершения работ при построении отчета о зарплате 0 - нет, 1 - да}
            WriteBool('UseDateEndSalaryReport', FUseDateEndSalaryReport);
            UseDateEndSalaryReport := FUseDateEndSalaryReport;

            {Шрифты}
            WriteString('MenuFontName', FMenuFontName);
            WriteInteger('MenuFontSize', FMenuFontSize);

            WriteString('GridFontName', FGridFontName);
            WriteInteger('GridFontSize', FGridFontSize);
            FindShtrikh := cbFindShtrikh.Checked;
            WriteBool('FindShtrikh', FindShtrikh);

            {Оповещаем главное окно об изменении настроек}
            PostMessage(Application.MainForm.Handle, WM_SETUPCHANGED, 0, 0);
          finally
            CloseKey;
          end;
      end;
    finally
      Reg.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TSetupForm.SaveSetup)', mtError, [mbOk], 0);
  end;

  Ini := TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    //сетевой режим
    Ini.WriteInteger('NetworkSettings', 'YesNetwork', Integer(rbYesNetwork.Checked));
    Ini.WriteString('NetworkSettings', 'ServerName', edServer.Text);
    Ini.WriteInteger('NetworkSettings', 'LimitCount', Integer(cbLimitCount.Checked));
    // принтер этикеток
    Ini.WriteInteger('Printetiket', 'PrinterIndex', cbPrintersEtiket.ItemIndex);
    Ini.WriteInteger('Printetiket', 'PrinterEtiket', Integer(rbPrint.Checked));
    Ini.WriteInteger('Printetiket', 'PrinterA4', Integer(rbPrinterA4.Checked));
    Ini.WriteInteger('Printetiket', 'LentaWidth', cbChooseLentWidth.ItemIndex);
    Ini.WriteInteger('Printetiket', 'A4Size', cbA4Size.ItemIndex);
    Ini.WriteInteger('Printetiket', 'CennikSize', cbCennikSize.ItemIndex);
    Ini.WriteString('Printetiket', 'PrinterName', cbPrintersEtiket.Text);
    //этикетки
    Ini.WriteString('Printetiket', 'Slogan', edSloganEtiket.Text);
    Ini.WriteInteger('Printetiket', 'PrintPrice', Integer(cbPrintPrice.Checked));
    Ini.WriteInteger('Printetiket', 'PrintArticul', Integer(cbPrintArticul.Checked));
    Ini.WriteInteger('Printetiket', 'PrintSlogan', Integer(cbPrintSlogan.Checked));
    Ini.WriteInteger('Printetiket', 'PriceBold', Integer(cbPriceBold.Checked));
    Ini.WriteInteger('Printetiket', 'ArticulBold', Integer(cbArticulBold.Checked));
    Ini.WriteInteger('Printetiket', 'SloganBold', Integer(cbSloganBold.Checked));
    Ini.WriteInteger('Printetiket', 'PriceSize', spnPriceSize.Value);
    Ini.WriteInteger('Printetiket', 'ArticulSize', spnArticulSize.Value);
    Ini.WriteInteger('Printetiket', 'SloganSize', spnSloganSize.Value);
    Ini.WriteInteger('Printetiket', 'NameSize', spnNameSize.Value);
    Ini.WriteInteger('Printetiket', 'NameBold', Integer(cbNameBold.Checked));
    //ценники
    Ini.WriteString ('Printetiket', 'CennikSlogan', edSloganCennik.Text);
    Ini.WriteInteger('Printetiket', 'CennikPrintPrice', Integer(cbCennikPrintPrice.Checked));
    Ini.WriteInteger('Printetiket', 'CennikPrintSlogan', Integer(cbCennikPrintSlogan.Checked));
    Ini.WriteInteger('Printetiket', 'CennikPriceBold', Integer(cbCennikPriceBold.Checked));
    Ini.WriteInteger('Printetiket', 'CennikSloganBold', Integer(cbCennikSloganBold.Checked));
    Ini.WriteInteger('Printetiket', 'CennikPriceSize', spnCennikPriceSize.Value);
    Ini.WriteInteger('Printetiket', 'CennikSloganSize', spnCennikSloganSize.Value);
    Ini.WriteInteger('Printetiket', 'CennikNameSize', spnCennikNameSize.Value);
    Ini.WriteInteger('Printetiket', 'CennikNameBold', Integer(cbCennikNameBold.Checked));
    //Ini.WriteInteger('Printetiket', 'Sdvig', seSdvig.Value);

    //СМС
    Ini.WriteString('SMS', 'Login', edSmsLogin.Text);
    Ini.WriteString('SMS', 'Password', edSmsPassword.Text);
    Ini.WriteInteger('SMS', 'EnableSmsHB', Integer(cbEnableSmsHB.Checked));
    Ini.WriteString('SMS', 'SmsHbText', mSmsHBText.Text);
    Ini.WriteInteger('SMS', 'TranslitSms', Integer(cbTranslit.Checked));
    SmsLogin := edSmsLogin.Text;
    SmsPassword := edSmsPassword.Text;
    SmsHBEnabled := Integer(cbEnableSmsHB.Checked);
    SmsHbText := mSmsHBText.Text;
    SmsTranslit := Integer(cbTranslit.Checked);

    //Мои звонки
    Ini.WriteString('Calls', 'CallLogin', edCallLogin.Text);
    Ini.WriteString('Calls', 'CallAPIAddress', edCallAPIAddress.Text);
    Ini.WriteString('Calls', 'CallAPI', edCallAPI.Text);
    CallLogin := edCallLogin.Text;
    CallAPIAddress := edCallAPIAddress.Text;
    CallAPI        := edCallAPI.Text;

    //Онлайн-запись
    Ini.WriteInteger('OnlineZapis', 'OnlineZapisEnabled', Integer(cbEnableOnlineZapis.Checked));
    //сохранять линк буду без последнего слэша, его буду добавлять позже
    if Copy(edOnlineZapisLink.Text, Length(edOnlineZapisLink.Text), 1) = '/' then
      edOnlineZapisLink.Text := Copy(edOnlineZapisLink.Text, 1, Length(edOnlineZapisLink.Text)-1);

    Ini.WriteString('OnlineZapis', 'OnlineZapisLink', edOnlineZapisLink.Text);
    Ini.WriteString('OnlineZapis', 'OnlineZapisLogin', edOnlineZapisLogin.Text);
    Ini.WriteString('OnlineZapis', 'OnlineZapisPass', edOnlineZapisPass.Text);
    Ini.WriteInteger('OnlineZapis', 'OnlineZapisRefresh', cbOnlineZapisRefresh.ItemIndex);
    Ini.WriteInteger('OnlineZapis', 'OnlineZapisDoSyncAlways', Integer(cbOnlineZapisDoSyncAlways.Checked));
    OnlineZapisEnabled := cbEnableOnlineZapis.Checked;
    OnlineZapisLink    := edOnlineZapisLink.Text;
    OnlineZapisLogin   := edOnlineZapisLogin.Text;
    OnlineZapisPass    := edOnlineZapisPass.Text;
    OnlineZapisRefresh := cbOnlineZapisRefresh.ItemIndex;
    OnlineZapisDoSyncAlways := cbOnlineZapisDoSyncAlways.Checked;

    //Кол-во знаков после запятой
    Ini.WriteString('Config', 'DecimalCount', edDecimalCount.Text);
    DecimalCount := StrToInt(edDecimalCount.Text);
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;

  if MainDM.dbMain.Connected then begin
    spUpd.ParamByName('s_value_').AsString := IntToStr(cbFormula.ItemIndex);
    spUpd.ParamByName('system_setup_').AsInteger := 1;
    if Execsp(spUpd) then
      Result := True;

    if Result then begin
      spUpd.ParamByName('s_value_').AsString := IntToStr(Integer(ceCanSellNol.checked));
      spUpd.ParamByName('system_setup_').AsInteger := 2;
      if Execsp(spUpd) then
        Result := True;
    end;

    if Result then begin
      spUpd.ParamByName('s_value_').AsString := IntToStr(cbSalary.ItemIndex);
      spUpd.ParamByName('system_setup_').AsInteger := 4;
      if Execsp(spUpd) then
        Result := True;
    end;

    // сохраняю скидочную сетку
    if Result then begin
      if tvSkidkaGrid.DataController.RecordCount > 0 then begin
        tvSkidkaGrid.DataController.UpdateData;
        if CheckSkidkaGrid then begin
          //удаляю сначала все записи
          MainDM.spWriteUniversal.SelectSQL.Text := 'DELETE FROM G_CLIENT_DISC_VAL_GRID';
          OpenSP(MainDM.spWriteUniversal, False);
          MainDM.spWriteUniversal.Transaction.CommitRetaining;
          
          MainDM.spWriteUniversal.SelectSQL.Text := 'INSERT INTO G_CLIENT_DISC_VAL_GRID (G_CLIENT_DISC_VAL_GRID, SUMM_FROM, SUMM_TO, SKIDKA_VAL, BONUS_VAL) ' +
                                                     'VALUES (GEN_ID(GEN_G_CLIENT_DISC_VAL_GRID, 1), :SUMM_FROM_, :SUMM_TO_, :SKIDKA_VAL_, :BONUS_VAL_)';
          for i := 0 to tvSkidkaGrid.DataController.RecordCount-1 do begin
            d := tvSkidkaGrid.DataController.Values[i, 0];
            MainDM.spWriteUniversal.ParamByName('SUMM_FROM_').AsFloat := d;

            d := tvSkidkaGrid.DataController.Values[i, 1];
            MainDM.spWriteUniversal.ParamByName('SUMM_TO_').AsFloat := d;

            d := tvSkidkaGrid.DataController.Values[i, 2];
            MainDM.spWriteUniversal.ParamByName('SKIDKA_VAL_').AsFloat := d;

            d := tvSkidkaGrid.DataController.Values[i, 3];
            MainDM.spWriteUniversal.ParamByName('BONUS_VAL_').AsFloat := d;

            if OpenSP(MainDM.spWriteUniversal, False) = False then begin
              Result := False;
              Exit;
            end;
            MainDM.spWriteUniversal.Params.ClearValues;
          end;
          MainDM.spWriteUniversal.Transaction.CommitRetaining;
          MainDM.spWriteUniversal.Close;
        end else
          Result := False;
      end;
    end;

    // сравниваю старые и новые значения
    FNewRec.Country  := cbCurrency.Text;
    FNewRec.Formula  := cbFormula.Text;
    FNewRec.ZpCalc   := cbSalary.Text;
    FNewRec.CanSellNol := ceCanSellNol.Checked;
    FNewRec.ManyFirm   := ceManyFirm.Checked;
    FNewRec.NotifyNol  := ceNotifyNol.Checked;
    FNewRec.NewLineSale  := ceNewLineSale.Checked;
    FNewRec.UseTovarPlace := ceUseTovarPlace.Checked;
    FNewRec.UseTovarNoteInSearch := cbUseTovarNoteInSearch.Checked;
    FNewRec.UseCurrency := ceUseCurrency.Checked;
    FNewRec.Config      := cbConfig.Text;
    FNewRec.BarcodeLength := cbBarcodeLength.Text;
    FNewRec.DecimalCount  := edDecimalCount.Text;
    FNewRec.DoProductInSale := cbDoProductInSale.Checked;
    FNewRec.DeliveryService := cbDeliveryService.Checked;
    FNewRec.ShowCostPrice   := cbShowCostPrice.Checked;
    FNewRec.PinCode         := edPinCode.Text;
    //FNewRec.CheckPrintDevice:= cbCheckPrintDevice.Text;
    FNewRec.ComPortNumber   := cbComPortNumber.Text;
    FNewRec.BaudRate        := cbBaudRate.Text;
    FNewRec.UseScales       := cbUseScales.Checked;
    FNewRec.ScalesPrefix    := edScalesPrefix.Text;
    //FNewRec.ScalesIp        := edScalesIp.Text;
    //FNewRec.ScalesPort      := edScalesPort.Text;
    //FNewRec.Scales          := cbScales.Text;
    FNewRec.SmsLogin        := edSmsLogin.Text;
    FNewRec.SmsPassword     := edSmsPassword.Text;
    FNewRec.BackupFileName  := bedtFileName.Text;
    FNewRec.BackupPeriod    := cbBackupPeriod.Text;
    FNewRec.DoBackupOnStart := rbDoBackupOnStart.Checked;
    FNewRec.NoNetwork       := rbNoNetwork.Checked;
    FNewRec.Server          := edServer.Text;
    FNewRec.SyncFileName    := SyncFolder;
    FNewRec.SyncInterval    := SyncInterval;
    FNewRec.LetDoReturnWithoutSale  := FLetDoReturnWithoutSale;
    str := FillLogSettings(FOldRec, FNewRec);

    if str <> '' then begin
      with MainDm.spUniversal do begin
        Transaction     := MainDm.tranMainWrite;
        StoredProcName := 'LOG_OPER_INS';
        ParamByName('ITEM_TYPE_').AsInteger := 14;
        ParamByName('USER_ID_').AsInt64 := CurrentOfficial;
        ParamByName('OPER_DATE_').AsDate := Date;
        ParamByName('OPER_TYPE_').AsInteger := 2;
        ParamByName('LOG_BODY_').AsString := str;
        ExecSPTr(MainDm.spUniversal);
      end;
    end;
  end else
    Result := True;
end;

function TSetupForm.CheckSkidkaGrid: Boolean;
var i : integer;
  AValue, AValue1 : Variant;
  d, d1 : Double;
  AValueStr, AValueStr1 : String;
begin
  Result := false;

  // значения в столбцах "ОТ" и "ДО" должны только увеличиваться
  for i := 0 to tvSkidkaGrid.DataController.RecordCount - 1 do begin
    AValue := tvSkidkaGrid.DataController.Values[i, 0];
    AValue1 := tvSkidkaGrid.DataController.Values[i, 1];

    if VarIsClear(AValue) or VarIsEmpty(AValue) or VarIsNull(AValue) or
    VarIsClear(AValue1) or VarIsEmpty(AValue1) or VarIsNull(AValue1) then begin
      MessageDlg('Значение "Сумма до" или "Сумма от" не должно быть пустое.', mtError, [mbOK], 0);
      tvSkidkaGrid.DataController.FocusedRowIndex := i;
      Exit;
    end;

    d1 := AValue1;
    d  := AValue;

    if d1 <= d then begin
      MessageDlg('Значение "Сумма до" должно быть больше значения "Сумма от".', mtError, [mbOK], 0);
      tvSkidkaGrid.DataController.FocusedRowIndex := i;
      Exit;
    end;

    // значение в "Сумма от" не может быть меньше значения "Сумма до" предыдущей строки
    if i > 0 then begin
      AValue1 := tvSkidkaGrid.DataController.Values[i-1, 1];
      d1 := AValue1;

      if d1 >= d then begin
        MessageDlg('Значение "Сумма от" должно быть больше предыдущего значения "Сумма до".', mtError, [mbOK], 0);
        tvSkidkaGrid.DataController.FocusedRowIndex := i;
        Exit;
      end;
    end;
  end;

  Result := True;
end;

procedure TSetupForm.peToolbarCustomStyleChange(Sender: TObject);
begin
  inherited;
  //ToolbarStyle := TdxBarManagerStyle(peToolbarCustomStyle.ItemIndex);
end;

procedure TSetupForm.peCustomStyleChange(Sender: TObject);
begin
  inherited;
  CustomStyle := TCustomStyle(peCustomStyle.ItemIndex);
  SetCustomStyle;
end;

procedure TSetupForm.peTabCustomStyleChange(Sender: TObject);
begin
  inherited;
  //TabStyle := TcxPCStyleID(peTabCustomStyle.ItemIndex);
  SetCustomStyle;
end;

procedure TSetupForm.petbButtonsStyleChange(Sender: TObject);
begin
  inherited;
  //FtbButtonsStyle := TtbButtonsStyle(petbButtonsStyle.ItemIndex);
//  SetCustomStyle;  {Здесь их нет}
end;

procedure TSetupForm.pcCommonChange(Sender: TObject);
var i : Integer;
  str : string;
begin
  case pcCommon.ActivePageIndex of
    3: //tsPrintBill
    begin
      SwitchTs(0);
      SwitchTs(1);
      pcPrinters.ActivePageIndex := 0;
      aDelPrint.Enabled := mdPrinters.RecordCount > 0;
    end;
    4: //tsPrintLabel
    begin
      pcPrintMode.ActivePage := tsEtiket;
    end;
    5: //tsScales
    begin
      aDelScale.Enabled := mdScales.RecordCount > 0;
    end;
    8: //tsPosTerminals
    begin
      btnDelTerminal.Enabled := mdPosTerminal.RecordCount > 0;
    end;
    16: //tsSync
    begin
      if (btnDisableSync.Enabled = False) and (MainDm.dbMain.Connected = True) then
      begin
        FillSyncComps;    // заполняю список компьютеров
        FOldRec.SyncEnabled := lbSyncCompNotif.Visible;
      end;
    end;
    13: //tsSkidkaGrid
    begin
      if MainDm.dbMain.Connected = True then
      begin
        //скидочная таблица клиентам
        MainDM.spReadUniversal.SelectSQL.Text := 'Select * from G_CLIENT_DISC_VAL_GRID order by 1';
        OpenSP(MainDM.spReadUniversal, False);
        MainDM.spReadUniversal.First;
        while not MainDM.spReadUniversal.Eof do begin
          with tvSkidkaGrid.DataController do begin
            i := AppendRecord;
            Values[i, clmSummTo.Index]    := MainDM.spReadUniversal.FieldByName('SUMM_TO').AsFloat;
            Values[i, clmSummFrom.Index]  := MainDM.spReadUniversal.FieldByName('SUMM_FROM').AsFloat;
            Values[i, clmSkidkaVal.Index] := MainDM.spReadUniversal.FieldByName('SKIDKA_VAL').AsFloat;
            Values[i, clmBonusVal.Index]  := MainDM.spReadUniversal.FieldByName('BONUS_VAL').AsFloat;
          end;
          MainDM.spReadUniversal.Next;
        end;
        MainDM.spReadUniversal.Close;
      end
      else
      begin
        btnAddSkidkaGrid.Enabled := False;
        cxGrid1.Enabled := False;
      end;
    end;
  end;
end;

procedure TSetupForm.FillSyncComps;
var str : string;
begin
  spReadSyncComps.ParamByName('current_comp_id_').AsInt64 := SyncCurCompId;
  OpenSp(spReadSyncComps, False);

  lbSyncCompNotif.Visible := spReadSyncComps.RecordCount > 0;
  lbSyncCompText.Visible := spReadSyncComps.RecordCount > 0;
  pnlSync.Visible := spReadSyncComps.RecordCount > 0;
  btnDisableSync.Visible := spReadSyncComps.RecordCount > 0;
  btnDisableSync.Enabled := spReadSyncComps.RecordCount > 0;
  aAddSyncComp.Enabled := spReadSyncComps.RecordCount > 0;
  aDelSyncComp.Enabled := spReadSyncComps.RecordCount > 0;

  if spReadSyncComps.RecordCount > 0 then begin
    if (SyncId <> '') and (Pos('{', lbSyncId.Caption) = 0) then begin
      lbSyncId.Caption := lbSyncId.Caption + ': ' + SyncId;
      lbSyncId.Visible := True;
      lbSyncId.Width := lbSyncCompNotif.Width;
    end;
  end;
end;

procedure TSetupForm.peAutoRefreshPropertiesChange(Sender: TObject);
begin
  inherited;
  {В минутах}
  case peAutoRefresh.ItemIndex of
    0: FAutoRefresh := 0;
    1: FAutoRefresh := 1;
    2: FAutoRefresh := 2;
    3: FAutoRefresh := 3;
    4: FAutoRefresh := 4;
    5: FAutoRefresh := 5;
    6: FAutoRefresh := 10;
    7: FAutoRefresh := 20;
    8: FAutoRefresh := 30;
  end;
end;

procedure TSetupForm.pePopupFormBorderStyleChange(Sender: TObject);
begin
  inherited;
  {case pePopupFormBorderStyle.ItemIndex of
    0: FPopupFormBorderStyle := pbsDialog;
    1: FPopupFormBorderStyle := pbsSimple;
    2: FPopupFormBorderStyle := pbsSysPanel;
  end;}
end;

procedure TSetupForm.pePopupFlatBorderChange(Sender: TObject);
begin
  inherited;
  {if pePopupFlatBorder.ItemIndex = 0 then
    FPopupFlatBorder := False
  else
    FPopupFlatBorder := True; }
end;

procedure TSetupForm.cbBackupPeriod1Change(Sender: TObject);
begin
  FBackupPeriod := cbBackupPeriod.ItemIndex;
end;

procedure TSetupForm.rbDoBackupOnStart1Click(Sender: TObject);
begin
  FDoBackupOnStart := Integer(rbDoBackupOnStart.Checked);
end;

procedure TSetupForm.peMenuFontPropertiesChange(Sender: TObject);
begin
  inherited;
  FMenuFontName := peMenuFont.Properties.Items[peMenuFont.ItemIndex];
  if peMenuFont.ItemIndex >= 0 then
    mTestMenuFont.Style.Font.Name := FMenuFontName;
end;

procedure TSetupForm.seMenuFontSizePropertiesChange(Sender: TObject);
begin
  inherited;
  FMenuFontSize := seMenuFontSize.Value;
  mTestMenuFont.Style.Font.Size := FMenuFontSize;
end;

procedure TSetupForm.peGridFontPropertiesChange(Sender: TObject);
begin
  inherited;
  FGridFontName := peGridFont.Properties.Items[peGridFont.ItemIndex];
  if peGridFont.ItemIndex >= 0 then
    mTestGridFont.Style.Font.Name := FGridFontName;
end;

procedure TSetupForm.seGridFontSizePropertiesChange(Sender: TObject);
begin
  inherited;
  FGridFontSize := seGridFontSize.Value;
  mTestGridFont.Style.Font.Size := FGridFontSize;
end;

procedure TSetupForm.btnAddSkidkaGridClick(Sender: TObject);
var CurRow : integer;
  AValue : Variant;
begin
  tvSkidkaGrid.DataController.AppendRecord;
  CurRow := tvSkidkaGrid.DataController.RecordCount-1;
  cxGrid1.SetFocus;
  tvSkidkaGrid.DataController.FocusedRowIndex := CurRow;

  with tvSkidkaGrid.DataController do begin
    if RecordCount = 1 then begin
      Values[0, clmSummFrom.Index] := '0';
      Values[CurRow, clmSkidkaVal.Index] := 0;
      Values[CurRow, clmBonusVal.Index] := 0;
      Values[CurRow, clmSummTo.Index] := Values[CurRow, clmSummFrom.Index] + 100000;
    end
    else begin
      AValue := tvSkidkaGrid.DataController.Values[CurRow - 1, 1];
      Values[CurRow, clmSummFrom.Index] := AValue + 1;
      Values[CurRow, clmSummTo.Index] := AValue + 100000;
      Values[CurRow, clmSkidkaVal.Index] := tvSkidkaGrid.DataController.Values[CurRow - 1, clmSkidkaVal.Index];
      Values[CurRow, clmBonusVal.Index] := tvSkidkaGrid.DataController.Values[CurRow - 1, clmBonusVal.Index];
    end;
  end;
end;

procedure TSetupForm.btnAddTerminalClick(Sender: TObject);
var
  TerminalSetupForm: TTerminalSetupForm;
begin
  TerminalSetupForm := TTerminalSetupForm.Create(Self);
  with TerminalSetupForm do begin
    try
      if ShowModal = mrOk then begin
        if not mdPosTerminal.Active then
          mdPosTerminal.Open;

        if mdPosTerminal.Locate('IP', edIp.Text, []) then begin
          MessageDlg('Нельзя добавить терминалы с одинаковым IP-адресом!', mtError, [mbOk], 0);
          Exit;
        end;

        if mdPosTerminal.Locate('TypeTerminal', cbTerminal.ItemIndex + 1, []) then begin
          MessageDlg('Нельзя добавить два одинаковых терминала! Сначала удалите имеющийся.', mtError, [mbOk], 0);
          Exit;
        end;

        mdPosTerminal.Insert;
        mdPosTerminal.FieldByName('IP').AsString := edIp.Text;
        mdPosTerminal.FieldByName('TypeTerminal').AsInteger := cbTerminal.ItemIndex + 1;
        mdPosTerminal.FieldByName('Name').AsString := cbTerminal.Text;
        mdPosTerminal.Refresh;
        btnDelTerminal.Enabled := mdPosTerminal.RecordCount > 0;
      end;
    finally
      FreeAndNil(TerminalSetupForm);
    end;
  end;
end;

procedure TSetupForm.tvSkidkaGridDataControllerNewRecord(
  ADataController: TcxCustomDataController; ARecordIndex: Integer);
var CurRow : integer;
  AValue : Variant;
begin
  CurRow := tvSkidkaGrid.DataController.RecordCount-1;

  with tvSkidkaGrid.DataController do begin
    AValue := tvSkidkaGrid.DataController.Values[CurRow - 1, 1];
    Values[CurRow, clmSummFrom.Index] := AValue + 1;
    Values[CurRow, clmSummTo.Index] := AValue + 100000;
    Values[CurRow, clmSkidkaVal.Index] := tvSkidkaGrid.DataController.Values[CurRow - 1, clmSkidkaVal.Index];
    Values[CurRow, clmBonusVal.Index] := tvSkidkaGrid.DataController.Values[CurRow - 1, clmBonusVal.Index];
  end;
end;

procedure TSetupForm.btnDefaultsClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Установить для всех настроек значения по умолчанию?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  {Устанавливаем значения по умолчанию}
  {Стиль панелей инструментов}
  ToolbarStyle := bmsEnhanced;

  {Стиль диалогов}
  CustomStyle := csRealBlank;

  {Стиль закладок}
  TabStyle := 1{dxtsTabs};

  {Стиль списков}
  FtbButtonsStyle := bsGlyphText;
  FAutoRefresh := 5;

  {Стиль выпадающих окон}
  {FPopupFormBorderStyle := pbsDialog;
  FPopupFlatBorder := True; }

  FBackupDir := ExtractFilePath(Application.exename) + 'Backup';

  FBackupPeriod := 0;

  {Шрифт в меню}
  FMenuFontName := 'Tahoma';
  FMenuFontSize := 9;

  {Шрифт в гридах}
  FGridFontName := 'Tahoma';
  FGridFontSize := 9;

  {---------------------------}

  {Стиль панелей инструментов}
  //peToolbarCustomStyle.ItemIndex := Integer(ToolbarStyle);

  {Стиль диалогов}
  peCustomStyle.ItemIndex := Integer(CustomStyle);  {Уже загружено в GetCustomStyle}

  {Стиль Закладок}
  //peTabCustomStyle.ItemIndex := Integer(TabStyle);

  {Стиль списков}
  //petbButtonsStyle.ItemIndex := Integer(FtbButtonsStyle);
  peAutoRefresh.ItemIndex := 5;  {Через 5 сек}

  {Стиль выпадающих окон}
  //pePopupFormBorderStyle.ItemIndex := 0; {pbsDialog}
  //pePopupFlatBorder.ItemIndex := 1; {True}

  {Папака для хранения копии БД}
  bedtFileName.Text := FBackupDir;

  {Период создания копии БД}
  cbBackupPeriod.ItemIndex := FBackupPeriod;

  {Делать копию при входе в приложение, или при выходе}
  rbDoBackupOnStart.Checked := False;
  rbDoBackupOnExit.Checked := True;
  FDoBackupOnStart := 0;

  {Продавать товары с нулевым остатком 0 -нет, 1 - да}
  ceCanSellNol.Checked := False;
  FAllowSellAbsentGoods := 0;

  {Режим нескольких фирм 0 -нет, 1 - да}
  ceManyFirm.Checked := False;

  {предупреждать о добавлении товара с нулевой ценой при продаже 0 -нет, 1 - да}
  ceNotifyNol.Checked := False;
  FNotifyNol := 0;

  {показывать предварительное окно с количеством товара в режиме кассира 0 -нет, 1 - да}
  ceShowSaleDlg.Checked := True;
  FShowSaleDlg := 1;

  {показывать закупочные цены в режиме кассира 0 -нет, 1 - да}
  cbShowCostPrice.Checked := False;
  FShowCostPrice := 0;

  {вид РМК 1 - компактный, 0 - стандартный}
  cbRmkView.ItemIndex := 1;
  RmkView := 1;

  {показывать кнопку для создания новых клиентов}
  cbShowInsClientBtn.Checked := False;
  ShowInsClientBtn := 0;

  //показывать кнопку для создания новых клиентов
  cbShowProductImg.Checked := False;
  ShowProductImg := 0;

  {не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да}
  ceNewLineSale.Checked := True;
  FNewLineSale := 1;

  {искать по полю "Место на складе" во всех режимах 0 - нет, 1 - да}
  ceUseTovarPlace.Checked := False;
  FUseTovarPlace := 0;

  {искать по полю "Место на складе" во всех режимах 0 - нет, 1 - да}
  cbUseTovarNoteInSearch.Checked := False;
  FUseTovarNoteInSearch := 0;

  {Отображать валюты в приходе товара}
  ceUseCurrency.Checked := False;
  FUseCurrency := False;

  {Показывать окно с именинниками 0 - нет, 1 - да}
  cbShowImens.Checked := False;
  FShowImens := False;

  {Начислять бонусы за рекомендацию 0 - нет, 1 - да}
  cbAddBonusForPromo.Checked := False;
  FAddBonusForPromo := False;

  {Не Начислять бонусы за продажу в долг, 0 - начислять, 1 - не начислять}
  cbDoNotCreditBonusOnDolg.Checked := False;

  {Устанавливать курсор на товар при сканировании штрихкода, 0 - нет, 1 - да}
  cbSetCursorOnTovar.Checked := False;

  //Отключаем распределение прав на просмотр прихода товара
  cbSetSaleOfGoods.Checked := False;

  {размер бонуса для новых (создаваемых) клиентов}
  edBonusOnCreateClient.Text := '0';
  FBonusOnCreateClient := 0;

  {Разрешить оформлять возврат товара без продажи, 0 - нет, 1 - да}
  cbLetDoReturnWithoutSale.Checked := False;
  FLetDoReturnWithoutSale := 0;

  {Выключить онлайн-запись}
  cbEnableOnlineZapis.Checked := False;
  FOnlineZapisEnabled := False;

  {использовать весы 0 - нет, 1 - да}
  cbUseScales.Checked := False;
  FUseScales := 0;

  {префикс весового штрихкода}
  edScalesPrefix.Text := '29';
  FScalesPrefix := '29';

  {IP-адрес весов}
  //edScalesIp.Text := '192.168.1.87';
  //FScalesIp := '192.168.1.87';
  //FScalesPort := '5001';
  //FScalesModel := 0;

  {Валюта}
  cbCurrency.ItemIndex := 0;
  CurrencyVal := 0;

  //seSdvig.Value := 0;

  {============= ПЕЧАТЬ ЧЕКОВ ==========}
  if cbPrintChargedBonus.Enabled then
    cbPrintChargedBonus.Checked := False;

  if cbBillPrintBarcode.Enabled then
    cbBillPrintBarcode.Checked := False;
  {============= ПЕЧАТЬ ЧЕКОВ END ==========}

  {конфигурация магазин - 0}
  cbConfig.ItemIndex := 0;

  cbBarcodeLength.ItemIndex := 0;

  cbCheckPrintDeviceFr.ItemIndex := 0;
  cbPrintOnFr.Checked := False;
  cbPrintOnPrinters.Checked := False;
  cbPrnt.ItemIndex := 0;
  //Сетевой режим откл
  rbNoNetwork.Checked := True;

  //Кол-во знаков после запятой
  edDecimalCount.Text := '2';

  //как платить комиссию продавцам
  cbSalary.ItemIndex := 0;

  {Шрифт в меню}
  peMenuFont.ItemIndex := peMenuFont.Properties.Items.IndexOf(FMenuFontName);
  seMenuFontSize.EditValue := FMenuFontSize;

  {Шрифт в гридах}
  peGridFont.ItemIndex := peGridFont.Properties.Items.IndexOf(FGridFontName);
  seGridFontSize.EditValue := FGridFontSize;

  {Оповещаем главное окно об изменении настроек}
  //PostMessage(Application.MainForm.Handle, WM_SETUPCHANGED, 0, 0);
end;

procedure TSetupForm.btnDelTerminalClick(Sender: TObject);
begin
  mdPosTerminal.Delete;
  btnDelTerminal.Enabled := mdPosTerminal.RecordCount > 0;
end;

procedure TSetupForm.btnFiscalPrinterConnectClick(Sender: TObject);
var
  Pin: string;
  Port: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    case cbCheckPrintDeviceFr.ItemIndex of
      3:
      begin
        if not GetProcess('WebCash.PrintModule.Window.exe') then
        begin
          lbFiscalPrinter.Caption := 'Не запущен модуль печати WebKassa';
          Exit;
        end;
      end;
      4:
      begin
        if not GetProcess('Lkassa.exe') then
        begin
          lbFiscalPrinter.Caption := 'Не запущен модуль печати LightKassa';
          Exit;
        end;
      end;
      6:
      begin
        if not GetProcess('Trinity.LM.Api.exe') and (not ServiceRunning(nil, 'TrinityIntegrationModule')) then
        begin
          lbFiscalPrinter.Caption := 'Не запущен модуль интеграции Trinity';
          Exit;
        end;
      end;
    end;

    if cbCheckPrintDeviceFr.ItemIndex = 1 then
    begin
      KKMPrinter := TKKMAtol.Create;
      KKMPrinter.Connect(0,0);
      GetFrStatus;
    end
    else
      if cbCheckPrintDeviceFr.ItemIndex in [2,3,4] then begin
        if (cbComPortNumber.ItemIndex < 0) then begin
          MessageDlg('Вы выбрали фиск. регистратор, работающий через драйвер Штрих-М, ' +
            'но не указали COM-порт для подключения!', mtError, [mbOk], 0);
          cbComPortNumber.SetFocus;
          Exit;
        end;

        {if (cbFrConnectAnotherComp.checked) and (edIpFrConnectAnotherComp.Text = '') then begin
          MessageDlg('Вы указали, что ФР подключен к другому компьютеру, но не указали его IP-адрес.', mtError, [mbOk], 0);
          edIpFrConnectAnotherComp.SetFocus;
          Exit;
        end;}
        if not Assigned(KKMPrinterStrih) then begin
          KKMPrinterStrih := TShtrihDriver.Create;
          KKMPrinterStrih.Connect(cbComPortNumber.ItemIndex + 1, cbBaudRate.ItemIndex,
            {Integer(cbFrConnectAnotherComp.Checked), edIpFrConnectAnotherComp.Text}
            0, '');
        end;
        GetFrStatus;
      end
      else
        if cbCheckPrintDeviceFr.ItemIndex = 5 then
        begin
          Pin := edtPin.Text;
          if not Assigned(KKMReKassa) then
            KKMReKassa := TRekassa.Create(edLogin.Text, edPass.Text, Pin, Test_Rekassa)
          else
          begin
            KKMReKassa.Destroy;
            KKMReKassa := TRekassa.Create(edLogin.Text, edPass.Text, Pin, Test_Rekassa)
          end;

          if KKMReKassa.GetToken then
            lbFiscalPrinter.Caption := 'Устройство "ReKassa 3.0" подключено успешно.'
          else
            lbFiscalPrinter.Caption := KKMReKassa.err;
        end
        else
          if cbCheckPrintDeviceFr.ItemIndex = 6 then
          begin
            if not TryStrToInt(edtPort.Text, Port) then
            begin
              lbFiscalPrinter.Caption := 'Не указан порт.';
              edtPort.SetFocus;
              Exit;
            end
            else
            begin
              if Port = 0 then
              begin
                lbFiscalPrinter.Caption := 'Не указан порт.';
                edtPort.SetFocus;
                Exit;
              end
            end;
            if TRIM(edtLoginTIS.Text)= EmptyStr then
            begin
              lbFiscalPrinter.Caption := 'Не указан логин.';
              edtLoginTIS.SetFocus;
              Exit;
            end;
            if TRIM(edtPassTIS.Text)= EmptyStr then
            begin
              lbFiscalPrinter.Caption := 'Не указан пароль.';
              edtPassTIS.SetFocus;
              Exit;
            end;
            if not Assigned(KKMTIS) then
              KKMTIS := TKKMTIS.Create(edtLoginTIS.Text, edtPassTIS.Text, StrToInt(edtPort.Text))
            else
            begin
              KKMTIS.Destroy;
              KKMTIS := TKKMTIS.Create(edtLoginTIS.Text, edtPassTIS.Text, StrToInt(edtPort.Text));
            end;

            if KKMTIS.GetToken = '' then
              lbFiscalPrinter.Caption := 'Устройство "ТИС" подключено успешно.'
            else
              lbFiscalPrinter.Caption := KKMTIS.err;
          end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TSetupForm.btnOkClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOK;
end;

function TSetupForm.GetFrStatus : Boolean;
var str : string;
begin
  result := false;
  try
    if (cbCheckPrintDeviceFr.ItemIndex = 1) and Assigned(KKMPrinter) then begin
      if KKMPrinter.GetConnectionStatus then begin
        lbFiscalPrinter.Caption := 'Устройство "' + KKMPrinter.GetDeviceName + '" подключено успешно.';
        result := True;
      end else
        lbFiscalPrinter.Caption := 'Ошибка при подключении. Код ' + InttoStr(KKMPrinter.GetResultCode) +
          '. ' + KKMPrinter.GetResultDescription;
    end
    else if (cbCheckPrintDeviceFr.ItemIndex in [2,3,4]) and Assigned(KKMPrinterStrih) then begin
      if KKMPrinterStrih.GetConnectionStatus then begin
        if KKMPrinterStrih.GetDeviceName(str) then begin
          lbFiscalPrinter.Caption := 'Устройство "' + str + '" подключено успешно.';
          result := True;
        end
        else
          MessageDlg(str, mtError, [mbOk], 0);
      end else
        lbFiscalPrinter.Caption := 'Ошибка при подключении. Код ' + InttoStr(KKMPrinterStrih.GetResultCode) +
          '. ' + KKMPrinterStrih.GetResultDescription;
    end;
  except
    on E: Exception do
      MessageDlg('Ошибка ' + E.Message + #13#10'В доступе отказано', mtError, [mbOk], 0);
  end;

  lbFiscalPrinter.Width  := 520;
  lbFiscalPrinter.Height := 40;
end;

procedure TSetupForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //inherited; {Полностью переопределяем метод}

  

  if ModalResult <> mrOk then
    Exit;

  CanClose := False;

  if (cbEnableSmsHB.Checked) and
  ((Trim(edSmsLogin.Text) = '') OR (Trim(edSmsPassword.Text) = '')) then begin
    MessageDlg('Вы включили автоматическую рассылку, но не указали логин/пароль к сервису SMSC.RU!', mtError, [mbOk], 0);
    pcCommon.ActivePage := tsSms;
    edSmsLogin.SetFocus;
    Exit;
  end;

  if (cbCheckPrintDeviceFr.ItemIndex = 2) and (cbComPortNumber.ItemIndex < 0) then begin
    MessageDlg('Вы выбрали фиск. регистратор, работающий через драйвер Штрих-М, ' +
      'но не указали COM-порт для подключения!', mtError, [mbOk], 0);
    pcCommon.ActivePage := tsPrintBill;
    cbComPortNumber.SetFocus;
    Exit;
  end;

  {if (cbCheckPrintDevice.ItemIndex = 2) and (cbFrConnectAnotherComp.checked) and (edIpFrConnectAnotherComp.Text = '') then begin
    MessageDlg('Вы указали, что ФР подключен к другому компьютеру, но не указали его IP-адрес.', mtError, [mbOk], 0);
    edIpFrConnectAnotherComp.SetFocus;
    Exit;
  end;}

  if SaveSetup then begin
    if (FDisplayComPortStrOld <> DisplayComPortStr) and (cbEnableDisplay.Checked)
    and Assigned(DisplayDriver) then begin
      DisplayDriver.Free;
      DisplayDriver := nil;
    end;

    CanClose := True;
  end;
end;

procedure TSetupForm.FillFontItems;
  function IsValidFont(Box: TcxComboBox;
    LogFont: TLogFont; FontType: Integer): Boolean;
  begin
    Result := True;
    if foAnsiOnly then
      Result := Result and (LogFont.lfCharSet = ANSI_CHARSET);
    if foTrueTypeOnly then
      Result := Result and (FontType and TRUETYPE_FONTTYPE = TRUETYPE_FONTTYPE);
    if foFixedPitchOnly then
      Result := Result and (LogFont.lfPitchAndFamily and FIXED_PITCH = FIXED_PITCH);
    if foOEMFontsOnly then
      Result := Result and (LogFont.lfCharSet = OEM_CHARSET);
    if foNoOEMFonts then
      Result := Result and (LogFont.lfCharSet <> OEM_CHARSET);
    if foNoSymbolFonts then
      Result := Result and (LogFont.lfCharSet <> SYMBOL_CHARSET);
    if foScalableOnly then
      Result := Result and (FontType and RASTER_FONTTYPE = 0);
  end;
  function EnumFontsProc(var EnumLogFont: TEnumLogFont; var TextMetric: TNewTextMetric;
    FontType: Integer; Data: LPARAM): Integer; export; stdcall;
  var
    FaceName: string;
  begin
    FaceName := StrPas(EnumLogFont.elfLogFont.lfFaceName);
    with TcxComboBox(Data) do begin
      if (Properties.Items.IndexOf(FaceName) < 0) and IsValidFont(TcxComboBox(Data), EnumLogFont.elfLogFont, FontType) then begin
        if EnumLogFont.elfLogFont.lfCharSet <> SYMBOL_CHARSET then
          FontType := FontType or WRITABLE_FONTTYPE;
        Properties.Items.AddObject(FaceName, TObject(FontType));
      end;
    end;
    Result := 1;
  end;
var
  DC: HDC;
begin
  with peMenuFont do begin
    //Items.BeginUpdate;
    //try
      Clear;
      DC := GetDC(0);
      try
        EnumFontFamilies(DC, nil, @EnumFontsProc, Longint(peMenuFont));
      finally
        ReleaseDC(0, DC);
      end;
    //finally
    //  Items.EndUpdate;
    //end;
  end;

  with peGridFont do begin
    //Items.BeginUpdate;
    //try
      Clear;
      DC := GetDC(0);
      try
        EnumFontFamilies(DC, nil, @EnumFontsProc, Longint(peGridFont));
      finally
        ReleaseDC(0, DC);
      end;
    //finally
    //  Items.EndUpdate;
    //end;
  end;
end;

procedure TSetupForm.ceNotifyNolPropertiesChange(Sender: TObject);
begin
  FNotifyNol := Integer(ceNotifyNol.checked);
end;

procedure TSetupForm.ceShowSaleDlgPropertiesChange(Sender: TObject);
begin
  FShowSaleDlg := Integer(ceShowSaleDlg.Checked);
  if (FShowSaleDlg = 1) then begin
    cbShowSaleDlgForVes.Enabled := True;
    cbShowSaleDlgKeys.Enabled := True;
  end else begin
    cbShowSaleDlgForVes.Checked := False;
    cbShowSaleDlgKeys.Checked := False;
    cbShowSaleDlgForVes.Enabled := False;
    cbShowSaleDlgKeys.Enabled := False;
  end;
end;

procedure TSetupForm.ceUseCurrencyPropertiesChange(Sender: TObject);
begin
  FUseCurrency := ceUseCurrency.Checked;
end;

procedure TSetupForm.ceUseTovarPlacePropertiesChange(Sender: TObject);
begin
  FUseTovarPlace := Integer(ceUseTovarPlace.checked);
end;

procedure TSetupForm.cxCheckBox1PropertiesChange(Sender: TObject);
begin
  FAddBonusForPromo := cbAddBonusForPromo.Checked;

  edBonusAmount.Enabled := cbAddBonusForPromo.Checked;
  cbSendSmsWhenBonusAdd.Enabled := cbAddBonusForPromo.Checked;
  if cbAddBonusForPromo.Checked = False then begin
    edBonusAmount.Value := 0;
    cbSendSmsWhenBonusAdd.Checked := False;
  end;
end;

procedure TSetupForm.ceCanSellNolPropertiesChange(Sender: TObject);
begin
  FAllowSellAbsentGoods := Integer(ceCanSellNol.checked);
end;

procedure TSetupForm.ceNewLineSalePropertiesChange(Sender: TObject);
begin
  FNewLineSale := Integer(ceNewLineSale.Checked);
end;

procedure TSetupForm.cbUsePosTerminalPropertiesChange(Sender: TObject);
begin
  if (cbCheckPrintDeviceFr.ItemIndex = 6) and (cbPrintOnFr.Checked) and (cbUsePosTerminal.Checked) then
  begin
    cbUsePosTerminal.Checked := False;
    ShowMessage('POS терминал не совместим с системой ТИС.');
  end;
  btnAddTerminal.Enabled := cbUsePosTerminal.Checked = True;
  btnDelTerminal.Enabled := cbUsePosTerminal.Checked = True;
  cxgrdTerminal.Enabled := cbUsePosTerminal.Checked = True;
  { зачем???
  if cbUsePosTerminal.Checked then
  begin
    MainDM.mdPosTerminal.Close;
    if FileExists(ExtractFilePath(Application.ExeName) + 'PosTerminals.data') then
      MainDM.mdPosTerminal.LoadFromBinaryFile(ExtractFilePath(Application.ExeName) + 'PosTerminals.data');
    MainDM.mdPosTerminal.Open;

    dxMemDataTypeTerminal.Open;
  end;}
end;

procedure TSetupForm.cbUseScalesPropertiesChange(Sender: TObject);
begin
  FUseScales := Integer(cbUseScales.Checked);
  edScalesPrefix.Enabled := cbUseScales.Checked;
end;

procedure TSetupForm.cbUseTovarNoteInSearchPropertiesChange(Sender: TObject);
begin
  FUseTovarNoteInSearch := Integer(cbUseTovarNoteInSearch.Checked);
end;

procedure TSetupForm.edScalesPrefixPropertiesChange(Sender: TObject);
begin
  FScalesPrefix := edScalesPrefix.Text;
end;

function TSetupForm.ExecSP(SP: TpFIBStoredProc): Boolean;
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;

  with SP do begin
    if not Transaction.InTransaction then
      Transaction.StartTransaction;

    ExecProc;

    if FieldIndex['ERR_CODE'] >= 0 then begin
      ErrCode := ParamByName('ERR_CODE').AsInteger;
      if ErrCode <> 0 then begin
        if Transaction.InTransaction then
          Transaction.Rollback;
        if FieldIndex['ERR_MSG'] >= 0 then begin
          ErrMsg := ParamByName('ERR_MSG').AsString;
          DBErrorHandler(ErrCode, ErrMsg);
        end
        else
          MessageDlg('Error code: ' + IntToStr(ErrCode)
             + #13#10'(occured in TDlgForm.CallSP)', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;

    if Transaction.InTransaction then
      Transaction.Commit;
  end;

  Result := True;
end;

procedure TSetupForm.cbPrintArticul1Click(Sender: TObject);
begin
  cbArticulBold.Enabled := cbPrintArticul.Checked;
  spnArticulSize.Enabled := cbPrintArticul.Checked;

  if cbPrintArticul.Checked = False then
    cbArticulBold.Checked := False;
end;

procedure TSetupForm.cbPrinters1Change(Sender: TObject);
begin
  //BillPrinter := cbPrinters.Text;
end;

procedure TSetupForm.cbPrintOnFrPropertiesChange(Sender: TObject);
begin
  SwitchTs(1);
end;

procedure TSetupForm.cbPrintOnPrintersPropertiesChange(Sender: TObject);
begin
  SwitchTs(0);
end;

procedure TSetupForm.cbPrintPrice1Click(Sender: TObject);
begin
  cbPriceBold.Enabled := cbPrintPrice.Checked;
  spnPriceSize.Enabled := cbPrintPrice.Checked;

  if cbPrintPrice.Checked = False then
    cbPriceBold.Checked := False;
end;

procedure TSetupForm.cbPrintSlogan1Click(Sender: TObject);
begin
  inherited;
  edSloganEtiket.Enabled := cbPrintSlogan.Checked;
  cbSloganBold.Enabled := cbPrintSlogan.Checked;
  spnSloganSize.Enabled := cbPrintSlogan.Checked;

  if cbPrintSlogan.Checked = False then
    cbSloganBold.Checked := False;
end;

procedure TSetupForm.cbRmkViewPropertiesChange(Sender: TObject);
begin
  RmkViewChange;
end;

procedure TSetupForm.RmkViewChange;
begin
  if cbRmkView.ItemIndex = 1 then begin
    cbShowTovarPanel.Checked := True;
    cbShowTovarPanel.Enabled := False;
    cbShowKafeTovarView.Checked := False;
    cbShowKafeTovarView.Enabled := False;
  end
  else begin
    cbShowTovarPanel.Checked := False;
    cbShowTovarPanel.Enabled := True;
    cbShowKafeTovarView.Checked := False;
    cbShowKafeTovarView.Enabled := True;
  end;
end;

procedure TSetupForm.cbSendSmsWhenBonusAddPropertiesChange(Sender: TObject);
begin
  FSendSmsWhenBonusAdd := cbSendSmsWhenBonusAdd.Checked;
  mTextSmsWhenBonusAdd.Enabled := cbSendSmsWhenBonusAdd.Checked;
end;

procedure TSetupForm.cbShowCostPricePropertiesChange(Sender: TObject);
begin
  FShowCostPrice := Integer(cbShowCostPrice.Checked);
end;

procedure TSetupForm.cbShowImensPropertiesChange(Sender: TObject);
begin
  FShowImens := cbShowImens.Checked;
end;

procedure TSetupForm.cbTranslitPropertiesChange(Sender: TObject);
begin
  mSmsHBText.Text := TranslitRus(mSmsHBText.Text);
end;

procedure TSetupForm.cbBillWidth1Change(Sender: TObject);
begin
  {BillWidth := cbBillWidth.ItemIndex;
  if BillWidth = 1 then begin
    if Length(edSlogan.Text) > 65 then begin
      MessageDlg('Слоган для печати слишком длинный.' + #13#10 + 'Он будет обрезан до подходящей длины.', mtWarning, [mbOK], 0);
      edSlogan.Properties.MaxLength := 65;
      edSlogan.Text := Copy(edSlogan.Text, 1, 65);
    end;
  end;}
end;

procedure TSetupForm.aAddPrintExecute(Sender: TObject);
var PrintersSetupForm: TPrintersSetupForm;
begin
  PrintersSetupForm := TPrintersSetupForm.Create(Self);
  with PrintersSetupForm do begin
    try
      if ShowModal = mrOk then begin
        if not mdPrinters.Active then
          mdPrinters.Open;

        if mdPrinters.Locate('Name', cbPrinters.Text, []) then begin
          MessageDlg('Нельзя добавить два одинаковых принтера!', mtError, [mbOk], 0);
          Exit;
        end;

        mdPrinters.Insert;
        mdPrinters.FieldByName('Name').AsString := cbPrinters.Text;
        mdPrinters.FieldByName('BillWidth').AsString := cbBillWidth.Text;
        mdPrinters.FieldByName('BillSdvig').AsInteger := seSdvig.Value;
        mdPrinters.FieldByName('BillQuantity').AsInteger := StrToInt(edBillQuantity.Text);
        mdPrinters.Refresh;
        aDelPrint.Enabled := mdPrinters.RecordCount > 0;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TSetupForm.aAddScaleExecute(Sender: TObject);
var ScalesSetupForm: TScalesSetupForm;
begin
  ScalesSetupForm := TScalesSetupForm.Create(Self);
  with ScalesSetupForm do begin
    try
      if ShowModal = mrOk then begin
        if not mdScales.Active then
          mdScales.Open;

        if mdScales.Locate('IP', edScalesIp.Text, []) then begin
          MessageDlg('Нельзя добавить весы с одинаковым IP-адресом!', mtError, [mbOk], 0);
          Exit;
        end;

        mdScales.Insert;
        mdScales.FieldByName('Name').AsString := cbScales.Text;
        mdScales.FieldByName('ModelId').AsInteger := cbScales.ItemIndex;
        mdScales.FieldByName('IP').AsString := edScalesIp.Text;
        mdScales.FieldByName('Port').AsString := edScalesPort.Text;
        mdScales.Refresh;
        aDelScale.Enabled := mdScales.RecordCount > 0;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TSetupForm.aAddSyncCompExecute(Sender: TObject);
begin
  OpenSyncSetup(True);
end;

procedure TSetupForm.aDelPrintExecute(Sender: TObject);
begin
  mdPrinters.Delete;
  aDelPrint.Enabled := mdPrinters.RecordCount > 0;
end;

procedure TSetupForm.aDelScaleExecute(Sender: TObject);
begin
  mdScales.Delete;
  aDelScale.Enabled := mdScales.RecordCount > 0;
end;

procedure TSetupForm.aDelSyncCompExecute(Sender: TObject);
var spScriptWrite : TpFIBScripter;
resp : string;
begin

  if spReadSyncComps.FieldByName('is_current').AsInteger = 1 then begin
    MessageDlg('Нельзя удалить текущий компьютер.' + CRLF +
      'Вы можете просто отключить синхронизацию кнопкой ниже.', mtWarning, [mbOk], 0);
    Exit;
  end;

  if MessageDlg(Format('Вы удаляете компьютер "%s" из синхронизации.' + CRLF +
    'Это действие НЕОБРАТИМО, Вы уверены, что хотите продолжить?',
    [spReadSyncComps.FieldByName('NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spScriptWrite := TpFIBScripter.Create(nil);
  spScriptWrite.Database := MainDm.dbMain;
  spScriptWrite.Transaction := tranWrite;
  try
    spScriptWrite.Script.Text := 'delete from sync_comps where sync_comps = ' + spReadSyncComps.FieldByName('sync_comps').AsString;
    resp := ExecScript(spScriptWrite, true);
    if resp <> '' then
      MessageDlg('Ошибка удаления. ' + resp, mtError, [mbOk], 0)
    else begin
      MessageDlg('Компьютер удален из синхронизации успешно.', mtInformation, [mbOk], 0);
      FillSyncComps;
    end;
  finally
    FreeAndNil(spScriptWrite);
  end;
end;

procedure TSetupForm.bedtFileNameButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
var
  sDir : String;
begin
  if SelectDirectory('Выберите папку', '', sDir) then begin
    bedtFileName.Text := IncludeTrailingPathDelimiter(sDir);
    FBackupDir := IncludeTrailingPathDelimiter(sDir);
  end;
end;

procedure TSetupForm.bedtFileNameChange(Sender: TObject);
begin
  inherited;
  ceCanSellNol.ModifiedAfterEnter := True;
  FBackupDir := bedtFileName.Text;
end;

procedure TSetupForm.btnDisableSyncClick(Sender: TObject);
begin
  // заполняю таблицу со списком компьютеров SYNC_COMPS, а потом размножу базу с уже заполненной таблицей
  // перед началом почищу табличку
  TRY
    Screen.Cursor := crHourGlass;

    //удаляю все триггеры
    with MainDm.spUniversal do begin
      StoredProcName := 'LOG_DEINIT';
      if not ExecSP(MainDm.spUniversal) then
        Exit;
    end;

    with MainDm.spReadUniversal do begin
      Transaction := MainDm.tranMainWrite;
      SelectSQL.Text := 'DELETE FROM SYNC_COMPS';
      if not OpenSp(MainDm.spReadUniversal, False) then Exit;
      if Transaction.InTransaction then
        Transaction.CommitRetaining;
      Close;

      SelectSQL.Text := 'DELETE FROM LOGS';
      if not OpenSp(MainDm.spReadUniversal, False) then Exit;
      if Transaction.InTransaction then
        Transaction.CommitRetaining;
      Close;

      //зануляю ID текущего компа в SYSTEM_SETUP
      SelectSQL.Text := 'UPDATE SYSTEM_SETUP SET S_VALUE = 0, STR_VALUE = NULL WHERE (SYSTEM_SETUP IN (5,6))';
      OpenSp(MainDm.spReadUniversal, False);
      if Transaction.InTransaction then
        Transaction.CommitRetaining;
      Close;
    end;

    lbSyncCompNotif.Visible := False;
    lbSyncId.Visible := False;
    pnlSync.Visible := False;
    lbSyncCompText.Visible := False;
    btnDisableSync.Visible := False;
    btnDisableSync.Enabled := btnDisableSync.Visible;
    SyncId := '';
    SyncCurCompId := 0;
    FNewRec.SyncEnabled := False;
  FINALLY
    Screen.Cursor := crDefault;
    MainDm.spUniversal.Transaction := MainDm.tranMainRead;
  END;
end;
procedure TSetupForm.btnDisplayCalibrateClick(Sender: TObject);
begin
  if cbMonoblockList.ItemIndex = 1 then begin
    if not Assigned(DisplayDriver) then
      DisplayDriver := TDisplayDriver.Create(DisplayModel, DisplayComPortStr, DisplayComBaudRate);

    DisplayDriver.Calibrate;
  end;
end;

procedure TSetupForm.cbCurrency1Change(Sender: TObject);
begin
  CurrencyVal := cbCurrency.ItemIndex;
end;

procedure TSetupForm.cbEnableDisplayPropertiesChange(Sender: TObject);
begin
  cbMonoblockList.Enabled := cbEnableDisplay.Checked;
  cbDisplayComPort.Enabled := cbEnableDisplay.Checked;
  cbDisplayComBaudRate.Enabled := cbEnableDisplay.Checked;
  btnDisplayCalibrate.Enabled := (cbEnableDisplay.Checked) and (cbMonoblockList.ItemIndex = 1);

  if cbEnableDisplay.Checked = False then begin
    cbDisplayComPort.ClearSelection;
  end;
end;

procedure TSetupForm.cbEnableHBPropertiesChange(Sender: TObject);
begin
  mSmsHBText.Enabled := cbEnableSmsHB.Checked;
end;

procedure TSetupForm.cbEnableOnlineZapisPropertiesChange(Sender: TObject);
begin
  edOnlineZapisLink.Enabled := cbEnableOnlineZapis.Checked;
  edOnlineZapisLogin.Enabled := cbEnableOnlineZapis.Checked;
  edOnlineZapisPass.Enabled := cbEnableOnlineZapis.Checked;
  cbOnlineZapisRefresh.Enabled := cbEnableOnlineZapis.Checked;
  cbOnlineZapisDoSyncAlways.Enabled := cbEnableOnlineZapis.Checked;
  if not cbEnableOnlineZapis.Checked then
    cbOnlineZapisDoSyncAlways.Checked := False;
end;

procedure TSetupForm.cbFrConnectAnotherCompPropertiesChange(Sender: TObject);
begin
  {edIpFrConnectAnotherComp.Enabled := cbFrConnectAnotherComp.Checked;
  if cbFrConnectAnotherComp.Checked = false then
    edIpFrConnectAnotherComp.Clear;}
end;

procedure TSetupForm.cbLetDoReturnWithoutSalePropertiesChange(Sender: TObject);
begin
  FLetDoReturnWithoutSale := Integer(cbLetDoReturnWithoutSale.Checked);
end;

procedure TSetupForm.cbMonoblockListPropertiesChange(Sender: TObject);
begin
  btnDisplayCalibrate.Visible := cbMonoblockList.ItemIndex = 1;
  btnDisplayCalibrate.Enabled := btnDisplayCalibrate.Visible;
  lbDisplayCalibrate.Visible  := cbMonoblockList.ItemIndex = 1;
end;

procedure TSetupForm.Label27Click(Sender: TObject);
begin
  ShellExecute(handle,'open','https://shopuchet.kz/files/shopuchet_firebird.zip', nil, nil, SW_SHOW);
end;

procedure TSetupForm.rbNoNetwork1Click(Sender: TObject);
begin
  btnSetServer.Enabled := False;
  btnTest.Enabled := False;
  edServer.Enabled := False;
  cbLimitCount.Enabled := False;
  YesNetwork := 0;
  ServerName := '';
  LimitCount := 0;
end;

procedure TSetupForm.rbYesNetwork1Click(Sender: TObject);
begin
  btnSetServer.Enabled := True;
  btnTest.Enabled := True;
  edServer.Enabled := True;
  cbLimitCount.Enabled := True;
  YesNetwork := 1;
  LimitCount := 0;
end;

procedure TSetupForm.btnSetServer1Click(Sender: TObject);
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  ComputerName: array[0..MAX_PATH] of Char;
  Title: string;
  WindowList: Pointer;
  Result: Boolean;
  ShellMalloc: IMalloc;
  sSelectRemoteServer, ServerNameTest:string;
begin
  sSelectRemoteServer:='Выберите компьютер "Сервер"';

  if Failed(SHGetSpecialFolderLocation(Application.Handle, CSIDL_NETWORK, ItemIDList)) then
    raise Exception.Create('Имя данного компьютера не поддерживается!');

  try
    FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);

    BrowseInfo.hwndOwner := Application.Handle;
    BrowseInfo.pidlRoot := ItemIDList;
    BrowseInfo.pszDisplayName := ComputerName;

    Title := sSelectRemoteServer;

    BrowseInfo.lpszTitle := PChar(Pointer(Title));
    BrowseInfo.ulFlags := BIF_BROWSEFORCOMPUTER;
    browseinfo.lpfn := BrowserCallback;
    WindowList := DisableTaskWindows(0);

    try
      Result := SHBrowseForFolder(BrowseInfo) <> nil;
    finally
      EnableTaskWindows(WindowList);
    end;

    if Result then begin
      ServerNameTest := ComputerName;
      if LowerCase(ServerNameTest) = LowerCase(GetComputerName) then begin
        MessageDlg('Нельзя указать текущий компьютер в качестве Сервера. Если текущий компьютер и есть Сервер,' + #10#13 +
                   'то ничего указывать не надо. Отключите сетевой режим.', mtWarning, [mbOk], 0);
        Exit;
      end;

      ServerName := ComputerName;
      edServer.Text := ServerName;
    end;
  finally
    if Succeeded(SHGetMalloc(ShellMalloc)) then
      ShellMalloc.Free(ItemIDList);
  end;
end;

procedure TSetupForm.btnSetupSync1Click(Sender: TObject);
begin
  OpenSyncSetup(False);
end;

procedure TSetupForm.btnAddCompToSync1Click(Sender: TObject);
begin
  OpenSyncSetup(True);
end;

procedure TSetupForm.btnAddPrint1Click(Sender: TObject);
var
  PrintersSetupForm: TPrintersSetupForm;
  i: Integer;
begin
  PrintersSetupForm := TPrintersSetupForm.Create(Self);
  with PrintersSetupForm do begin
    try
      cbPrinters.Enabled := false;
      edBillQuantity.Text := intToStr(PrinterRekassa.BillQuantity);
      seSdvig.Value := PrinterRekassa.BillSdvig;
      for i := 0 to cbBillWidth.Properties.Items.Count -1 do
      begin
        if cbBillWidth.Properties.Items[i] = PrinterRekassa.BillWidth then
        begin
          cbBillWidth.ItemIndex := i;
          break;
        end;
      end;
      FrPrnt := cbPrnt.Text;
      if ShowModal = mrOk then
      begin
        PrinterRekassa.BillWidth := cbBillWidth.Text;
        PrinterRekassa.BillSdvig := seSdvig.Value;
        PrinterRekassa.BillQuantity := StrToInt(edBillQuantity.Text);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TSetupForm.OpenSyncSetup(IsAddNewComp : boolean);
var SyncSetupForm: TSyncSetupForm;
begin
  SyncSetupForm := TSyncSetupForm.Create(Self);
  try
    SyncSetupForm.SyncEnabled := lbSyncCompNotif.Visible;
    SyncSetupForm.AddNewComp := IsAddNewComp;
    SyncSetupForm.SyncId := SyncId;

    if SyncSetupForm.ShowModal = mrOk then begin
      if IsAddNewComp then begin
        FillSyncComps;    // заполняю список компьютеров
      end;
      FNewRec.SyncEnabled := True;
    end;
  finally
    SyncSetupForm.Free;
  end;
end;

procedure TSetupForm.seSdvigChange(Sender: TObject);
begin
  //if seSdvig.Text <> '-' then
  //  BillSdvig := seSdvig.Value;
end;

procedure TSetupForm.SetDefaultSize(PriceSize, ArticulSize, SloganSize, NameSize: Integer);
begin
  // у этикеток есть размеры по умолчанию, при переключении, или если не заданы настройки, надо ставить эти значения
  if cbChooseLentWidth.ItemIndex in [1,10] then begin     // 30*15
    if PriceSize = 0 then
      spnPriceSize.Value := 6
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 6
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 6
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 6
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex in [0, 2, 3]  then begin     // 29*20, 47*25, 43*25
    if PriceSize = 0 then
      spnPriceSize.Value := 7
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 7
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 7
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 7
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex = 5 then begin     // 58*30
    if PriceSize = 0 then
      spnPriceSize.Value := 9
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 9
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 9
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 9
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex in [4, 6, 7, 8] then begin     // 58*40, 58*60, 58*100
    if PriceSize = 0 then
      spnPriceSize.Value := 10
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 10
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 10
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 10
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex = 9 then begin     // 100*70
    if PriceSize = 0 then
      spnPriceSize.Value := 12
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 12
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 12
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 12
    else
      spnNameSize.Value := NameSize;
  end
end;

procedure TSetupForm.SetCennikDefaultSize(PriceSize, SloganSize,
  NameSize: Integer);
begin
  // у ценников есть размеры по умолчанию
  if cbCennikSize.ItemIndex = 0 then begin     // 35 x 60
    if PriceSize = 0 then
      spnCennikPriceSize.Value := 15
    else
      spnCennikPriceSize.Value := PriceSize;

    if SloganSize = 0 then
      spnCennikSloganSize.Value := 7
    else
      spnCennikSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnCennikNameSize.Value := 10
    else
      spnCennikNameSize.Value := NameSize;
  end
  else if cbCennikSize.ItemIndex = 1 then begin     // 40 x 60
    if PriceSize = 0 then
      spnCennikPriceSize.Value := 15
    else
      spnCennikPriceSize.Value := PriceSize;

    if SloganSize = 0 then
      spnCennikSloganSize.Value := 9
    else
      spnCennikSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnCennikNameSize.Value := 10
    else
      spnCennikNameSize.Value := NameSize;
  end
  else if cbCennikSize.ItemIndex = 2 then begin     // Лист А5
    if PriceSize = 0 then
      spnCennikPriceSize.Value := 25
    else
      spnCennikPriceSize.Value := PriceSize;

    if SloganSize = 0 then
      spnCennikSloganSize.Value := 15
    else
      spnCennikSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnCennikNameSize.Value := 22
    else
      spnCennikNameSize.Value := NameSize;
  end;
end;

procedure TSetupForm.SwitchTs(index : integer);
begin
  if index = 0 then begin
    if cbPrintOnPrinters.Checked = false then
      tvPrinters.Focused := False;

    gr1.Enabled := cbPrintOnPrinters.Checked;
    aAddPrint.Enabled := cbPrintOnPrinters.Checked;
    aDelPrint.Enabled := (cbPrintOnPrinters.Checked) and (mdPrinters.RecordCount > 0);
    edSlogan.Enabled := cbPrintOnPrinters.Checked;
    cbPrintChargedBonus.Enabled := cbPrintOnPrinters.Checked;
    cbBillPrintBarcode.Enabled := cbPrintOnPrinters.Checked;
  end
  else begin
    cbCheckPrintDeviceFr.Enabled := cbPrintOnFr.Checked;
    btnFiscalPrinterConnect.Enabled := cbPrintOnFr.Checked;
    cbComPortNumber.Enabled := cbPrintOnFr.Checked;
    cbBaudRate.Enabled := cbPrintOnFr.Checked;
    if cbPrintOnFr.Checked = false then begin
      cbCheckPrintDeviceFr.ItemIndex := 0;
    end;
  end;
  {if cbPrintOnFr.Checked then
    MainForm.sbiFrOperations.Visible := ivAlways;
  if cbCheckPrintDeviceFr.ItemIndex = 5 then
  begin
    MainForm.aOpenSession.Visible := False;
  end;}
end;

procedure TSetupForm.edSloganPropertiesChange(Sender: TObject);
begin
  BillSlogan := edSlogan.Text;
end;

procedure TSetupForm.Label27MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  Screen.Cursor := crHandPoint;
end;

procedure TSetupForm.lb39Click(Sender: TObject);
begin
  ShellExecute(handle,'open','https://smsc.ru/?ppshopuchet', nil, nil, SW_SHOW);
end;

procedure TSetupForm.lb39MouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TSetupForm.lb39MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TSetupForm.lbMoiZvonkiClick(Sender: TObject);
begin
  ShellExecute(handle,'open','https://Moizvonki.ru', nil, nil, SW_SHOW);
end;

procedure TSetupForm.mTextSmsWhenBonusAddPropertiesChange(Sender: TObject);
begin
  FTextSmsWhenBonusAdd := mTextSmsWhenBonusAdd.Text;
end;

procedure TSetupForm.Label27MouseLeave(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crDefault;
end;

procedure TSetupForm.btnTest1Click(Sender: TObject);
begin
  if Servername = '' then begin
    ShowMessage('Компьютер "Сервер" не указан!');
    Exit;
  end;

  if DataBaseName = 'Salonuchet.fdb' then
    dbTest.DBName := ServerName + ':salonuchet'
  else if DataBaseName = 'SERVICEUCHET.FDB' then
    dbTest.DBName := ServerName + ':serviceuchet'
  else
    dbTest.DBName := ServerName + ':shopuchet';

  dbTest.ConnectParams.Username := 'sysdba';//UserName;
  dbTest.ConnectParams.Password := 'masterkey';//Password;
  dbTest.ConnectParams.RoleName := 'admin';

  with dbTest do begin
    try
      Open;
    except
      on E: EFIBError do
        case E.SQLCode of
          -902: MessageDlg(E.Message + #13#10'В доступе отказано. Возможно БД нет по данному пути.', mtInformation, [mbOk], 0);
          -904: MessageDlg('Недоступная база данных'#13#10 +
                  '(возможно, сервер FireBird остановлен).'#13#10 +
                  'В доступе отказано', mtError, [mbOk], 0);
        else
          MessageDlg('Ошибка № ' + IntToStr(E.SQLCode) + ' - ' + E.Message + ':'#13#10 +
                     'В доступе отказано', mtError, [mbOk], 0);
        end;
      on E: Exception do
        MessageDlg('Ошибка ' + E.Message + #13#10'В доступе отказано', mtError, [mbOk], 0);
    end;
  end;

  if dbTest.connected then
    ShowMessage('Подключение прошло успешно!');

  DisconnectFromFB(dbTest);
end;

procedure TSetupForm.btHelpClick(Sender: TObject);
begin
  Application.HelpContext(61);
end;

procedure TSetupForm.cbCennikPrintPrice1Click(Sender: TObject);
begin
  cbCennikPriceBold.Enabled := cbCennikPrintPrice.Checked;
  spnCennikPriceSize.Enabled := cbCennikPrintPrice.Checked;

  if cbCennikPrintPrice.Checked = False then
    cbCennikPriceBold.Checked := False;
end;

procedure TSetupForm.cbCennikPrintSlogan1Click(Sender: TObject);
begin
  edSloganCennik.Enabled := cbCennikPrintSlogan.Checked;
  cbCennikSloganBold.Enabled := cbCennikPrintSlogan.Checked;
  spnCennikSloganSize.Enabled := cbCennikPrintSlogan.Checked;

  if cbCennikPrintSlogan.Checked = False then
    cbCennikSloganBold.Checked := False;
end;

procedure TSetupForm.cbCheckPrintDevicePropertiesChange(Sender: TObject);
begin
  ReKassa := false;
  if cbCheckPrintDeviceFr.ItemIndex = 0 then begin
    cbBaudRate.ItemIndex := -1;
    cbComPortNumber.ItemIndex := -1;
    CheckPrintDeviceFr := 0;
  end
  else
    if cbCheckPrintDeviceFr.ItemIndex in [1, 2, 3, 4] then
      GetFrStatus
    else
      if cbCheckPrintDeviceFr.ItemIndex = 5 then //Rekassa
      begin
        //MessageDlg('Для печати вам необходимо настроить принтер чеков', mtInformation, [mbOK], 0);
        ReKassa := true;
        GetFrStatus;
      end
      else
        GetFrStatus;

  btnFiscalPrinterConnect.Enabled := cbCheckPrintDeviceFr.ItemIndex in [1, 2, 3, 4, 5, 6];
  lbFiscalPrinter.Visible := cbCheckPrintDeviceFr.ItemIndex in [1, 2, 3, 4, 5, 6];

  lbComPortNumber.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4];
  shpComPortNumber.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4, 5, 6];
  lbBaudRate.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4];
  shpBaudRate.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4, 5, 6];
  shpComPortNumber1.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4, 5, 6];
  cbComPortNumber.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4];
  shpBaudRate1.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4, 5, 6];
  cbBaudRate.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4];
  lbBaudRateNote.Visible := cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4];

  lbDomainType.Visible := cbCheckPrintDeviceFr.ItemIndex in [5];
  cbDomainType.Visible := cbCheckPrintDeviceFr.ItemIndex in [5];
  lbLogin.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  edLogin.Visible := cbCheckPrintDeviceFr.ItemIndex in [5];
  lbPass.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  shpPass.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  shpPass1.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  edPass.Visible := cbCheckPrintDeviceFr.ItemIndex in [5];
  lbPincode.Visible := cbCheckPrintDeviceFr.ItemIndex in [5];
  shpPinCode.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  shpPincode1.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  edtPin.Visible := cbCheckPrintDeviceFr.ItemIndex in [5];
  btnAddPrint1.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  lbPrntRekassa.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  shpPrnt1.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  shpPrnt2.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];
  cbPrnt.Visible := cbCheckPrintDeviceFr.ItemIndex in [5, 6];


  edtPort.Visible := cbCheckPrintDeviceFr.ItemIndex in [6];
  lblPort.Visible := cbCheckPrintDeviceFr.ItemIndex in [6];
  edtLoginTIS.Visible := cbCheckPrintDeviceFr.ItemIndex in [6];
  edtPassTIS.Visible := cbCheckPrintDeviceFr.ItemIndex in [6];
  lblTerminal.Visible := cbCheckPrintDeviceFr.ItemIndex in [6];
  cbTerminal.Visible := cbCheckPrintDeviceFr.ItemIndex in [6];

  if (cbCheckPrintDeviceFr.ItemIndex = 6) and (cbPrintOnFr.Checked) and (cbUsePosTerminal.Checked) then
  begin
    cbUsePosTerminal.Checked := False;
    ShowMessage('POS терминал будет отключен в системе ShopUchet и перенаправлен в систему ТИС');
  end;


  lbFiscalPrinter.Caption := '';

  if cbCheckPrintDeviceFr.ItemIndex <> 1 then
    if Assigned(KKMPrinter) then begin
      KKMPrinter.Destroy;
      KKMPrinter := nil;
    end;
  if cbCheckPrintDeviceFr.ItemIndex <> 5 then
    if Assigned(KKMReKassa) then
    begin
      ReKassa := False;
      KKMReKassa.Destroy;
      KKMReKassa := nil;
    end;
  if not (cbCheckPrintDeviceFr.ItemIndex in [2, 3, 4]) then
    if Assigned(KKMPrinterStrih) then begin
      KKMPrinterStrih.Destroy;
      KKMPrinterStrih := nil;
    end;
end;

procedure TSetupForm.cbConfigChange(Sender: TObject);
begin
  Config := cbConfig.ItemIndex;

  lbMagazin.Visible := Config = 0;
  lbApteka.Visible := Config = 1;
  lbAvtoZapchasti.Visible := Config = 2;
  lbProizvodstvo.Visible := Config = 3;

  lbDoProductInSale.Visible := Config = 3;
  shpDoProductInSale.Visible := Config = 3;
  shpDoProductInSale1.Visible := Config = 3;
  cbDoProductInSale.Visible := Config = 3;
  lbDoProductInSale1.Visible := Config = 3;
end;

procedure TSetupForm.edBonusAmountPropertiesChange(Sender: TObject);
begin
  FAmountBonusForPromo := edBonusAmount.Value;
end;

procedure TSetupForm.edBonusOnCreateClientPropertiesChange(Sender: TObject);
begin
  FBonusOnCreateClient := StrToInt(edBonusOnCreateClient.Text);
end;

procedure TSetupForm.edDecimalCountExit(Sender: TObject);
begin
  if edDecimalCount.Text = '' then
    edDecimalCount.Text := '2';

  if not (StrToInt(edDecimalCount.Text) in [0,1,2,3,4,5]) then begin
    MessageDlg('Значение может быть от 0 до 5!', mtWarning, [mbOK], 0);
    if StrToInt(edDecimalCount.Text) < 0 then
      edDecimalCount.Text := '0'
    else
      edDecimalCount.Text := '5';
  end;
end;

procedure TSetupForm.edDecimalCountPropertiesChange(Sender: TObject);
begin
  if edDecimalCount.Text = '' then
    Exit;

  if not (StrToInt(edDecimalCount.Text) in [0,1,2,3,4,5]) then begin
    MessageDlg('Значение может быть от 0 до 5!', mtWarning, [mbOK], 0);
    if StrToInt(edDecimalCount.Text) < 0 then
      edDecimalCount.Text := '0'
    else
      edDecimalCount.Text := '5';
  end;
end;

procedure TSetupForm.edPosTerminalIpKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', '.', #8]) then
    Key := #0;
end;

procedure TSetupForm.edScalesIpKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', '.', #8]) then
    Key := #0;
end;

procedure TSetupForm.edScalesPrefixKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TSetupForm.edtPinExit(Sender: TObject);
begin
  inherited;
  if Length(Trim(edtPin.Text))<>4 then
    MessageDlg('Не верный ПИН-код', mtError, [mbok],0);
end;

procedure TSetupForm.edtPinKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TSetupForm.edtServer1Change(Sender: TObject);
begin
  ServerName := edServer.Text;
end;

procedure TSetupForm.rbPrint1Click(Sender: TObject);
begin
  cbChooseLentWidth.Visible := rbPrint.Checked;
  cbA4Size.Visible := rbPrinterA4.Checked;
end;

end.
