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
  Menus, cxLabel, cxButtons, UITypes, dxBarBuiltInMenu, cxClasses;

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
    cbCurrency: TComboBox;
    cbFormula: TComboBox;
    tsConfig: TcxTabSheet;
    shp7: TShape;
    lb4: TLabel;
    shp8: TShape;
    tsPrintBill: TcxTabSheet;
    shp9: TShape;
    shp10: TShape;
    shp11: TShape;
    lb5: TLabel;
    lb6: TLabel;
    lb7: TLabel;
    shp13: TShape;
    shp12: TShape;
    shp14: TShape;
    cbPrinters: TComboBox;
    cbBillWidth: TComboBox;
    seSdvig: TcxSpinEdit;
    tsBackup: TcxTabSheet;
    shp15: TShape;
    lb9: TLabel;
    shp16: TShape;
    lb8: TLabel;
    shp18: TShape;
    shp17: TShape;
    rbDoBackupOnStart: TRadioButton;
    rbDoBackupOnExit: TRadioButton;
    cbBackupPeriod: TComboBox;
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
    rbNoNetwork: TRadioButton;
    rbYesNetwork: TRadioButton;
    btnSetServer: TBitBtn;
    btnTest: TBitBtn;
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
    lbl1: TLabel;
    Shape1: TShape;
    v: TShape;
    edServer: TEdit;
    lbServer: TLabel;
    lb32: TLabel;
    sh25: TShape;
    sh26: TShape;
    lbKassir: TLabel;
    shpKassir: TShape;
    shpKassir1: TShape;
    lbMagazin: TLabel;
    lbApteka: TLabel;
    lbAvtoZapchasti: TLabel;
    lbProizvodstvo: TLabel;
    cbConfig: TcxComboBox;
    lb34: TLabel;
    sh29: TShape;
    sh30: TShape;
    lbMestoNaSklade: TLabel;
    shpMestoNaSklade: TShape;
    shpMestoNaSklade1: TShape;
    ceCanSellNol: TcxCheckBox;
    ceManyFirm: TcxCheckBox;
    ceNotifyNol: TcxCheckBox;
    ceShowSaleDlg: TcxCheckBox;
    ceNewLineSale: TcxCheckBox;
    ceUseTovarPlace: TcxCheckBox;
    edSlogan: TcxTextEdit;
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
    lb25: TLabel;
    tsPrintLabel: TcxTabSheet;
    lb26: TLabel;
    shp23: TShape;
    lb27: TLabel;
    shp25: TShape;
    shp24: TShape;
    cbPrintersEtiket: TComboBox;
    shp26: TShape;
    cbChooseLentWidth: TComboBox;
    grp1: TGroupBox;
    lb33: TLabel;
    lb35: TLabel;
    cbNameBold: TCheckBox;
    spnNameSize: TcxSpinEdit;
    grp2: TGroupBox;
    lbl2: TLabel;
    cbPrintPrice: TCheckBox;
    cbPriceBold: TCheckBox;
    spnPriceSize: TcxSpinEdit;
    grp3: TGroupBox;
    shp27: TShape;
    lb36: TLabel;
    shp28: TShape;
    lbl3: TLabel;
    cbPrintSlogan: TCheckBox;
    cbSloganBold: TCheckBox;
    spnSloganSize: TcxSpinEdit;
    edSloganEtiket: TcxTextEdit;
    rbPrint: TRadioButton;
    rbPrinterA4: TRadioButton;
    cbA4Size: TComboBox;
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
    mSmsNotifyText: TcxMemo;
    cbEnableSmsHB: TcxCheckBox;
    mSmsHBText: TcxMemo;
    lbSmsName: TLabel;
    lb42: TLabel;
    lb44: TLabel;
    cbTranslit: TcxCheckBox;
    cbNotifySMS: TcxComboBox;
    lbCostPrice: TLabel;
    shpCostPrice: TShape;
    shpCostPrice1: TShape;
    ceUseCurrency: TcxCheckBox;
    lbSetOneMaster: TLabel;
    shpSetOneMaster: TShape;
    shpSetOneMaster1: TShape;
    cbSetOneMaster: TcxCheckBox;
    lb45: TLabel;
    shp33: TShape;
    shp34: TShape;
    cbShowCostPrice: TcxCheckBox;
    btHelp: TcxButton;
    btnDefaults: TcxButton;
    procedure peCustomStyleChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure petbButtonsStyleChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure peAutoRefreshChange(Sender: TObject);
    procedure peToolbarCustomStyleChange(Sender: TObject);
    procedure peTabCustomStyleChange(Sender: TObject);
    procedure pePopupFormBorderStyleChange(Sender: TObject);
    procedure pePopupFlatBorderChange(Sender: TObject);
    procedure cbBackupPeriodChange(Sender: TObject);
    procedure rbDoBackupOnStartClick(Sender: TObject);
    procedure cbPrintersChange(Sender: TObject);
    procedure cbBillWidthChange(Sender: TObject);
    procedure bedtFileNameButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure bedtFileNameChange(Sender: TObject);
    procedure cbCurrencyChange(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure rbNoNetworkClick(Sender: TObject);
    procedure rbYesNetworkClick(Sender: TObject);
    procedure btnSetServer1Click(Sender: TObject);
	procedure seSdvigChange(Sender: TObject);
    procedure Label27MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label27MouseLeave(Sender: TObject);
    procedure btnTest1Click(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure cbConfigChange(Sender: TObject);
    procedure edServerChange(Sender: TObject);
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
    procedure cbPrintPriceClick(Sender: TObject);
    procedure cbPrintSloganClick(Sender: TObject);
    procedure rbPrintClick(Sender: TObject);
    procedure lb39MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lb39MouseLeave(Sender: TObject);
    procedure lb39Click(Sender: TObject);
    procedure cbEnableHBPropertiesChange(Sender: TObject);
    procedure cbTranslitPropertiesChange(Sender: TObject);
    procedure cbTimeNofityPropertiesChange(Sender: TObject);
    procedure ceUseCurrencyPropertiesChange(Sender: TObject);
    procedure cbSetOneMasterPropertiesChange(Sender: TObject);
    procedure cbShowCostPricePropertiesChange(Sender: TObject);

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
    FUseScales : integer;      //1 - пользуют весы, 0 - нет
    FScalesPrefix : String;    //префикс весового штрихкода
    FUseCurrency : Boolean;    //открыть закупочные цены в валюте в Приходе товара
    FConfSetOneMaster : Boolean; // закрепить одного мастера за одним счетом
    FShowCostPrice : Boolean;    //показывать закупочные цены в режиме кассира

    FMenuFontName: String;
    FMenuFontSize: Integer;

    FGridFontName: String;
    FGridFontSize: Integer;

    function SaveSetup: Boolean;
    function ExecSP(SP: TpFIBStoredProc): Boolean;
    procedure FillFontItems;
    procedure SetDefaultSize(PriceSize : Integer; SloganSize : Integer; NameSize : Integer);
  protected
    procedure GetData; override;
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

uses unInitApp, unErrorHandlers, dmMain, unDBSupport, smsc_api;

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
begin
  inherited;
  pcCommon.ActivePage := tsCommon;

  {Заполняем Комбо списком шрифтов}
  FillFontItems;

  // заполняем принтеры
  try
    cbPrinters.Items.Assign(Printer.Printers);
    cbPrinters.ItemIndex := Printer.PrinterIndex;
    cbPrintersEtiket.Items.Assign(Printer.Printers);
    cbPrintersEtiket.ItemIndex := Printer.PrinterIndex;
  except
  end;

  GetData;
  if cbBillWidth.ItemIndex = 1 then
    edSlogan.Properties.MaxLength := 65;

  //ставлю всем компонентам размеры и шрифты, на разных DPI по разному
  lbApteka.Font.Size := 9;
  lbAvtoZapchasti.Font.Size := 9;
  lbMagazin.Font.Size := 9;
  lbProizvodstvo.Font.Size := 9;
  cbConfig.Style.Font.Size := 9;

  //в СалонУчете эти параметры не нужны
  if AppName = 'SalonUchet' then begin
    tsConfig.TabVisible := False;
    tsScales.TabVisible := False;
    lbFewCompany.Visible := False;
    shpFewCompany.Visible := False;
    shpFewCompany1.Visible := False;
    ceManyFirm.Visible := False;
    lbKassir.Visible := False;
    shpKassir.Visible := False;
    shpKassir1.Visible := False;
    ceShowSaleDlg.Visible := False;
    lbMestoNaSklade.Visible := False;
    shpMestoNaSklade.Visible := False;
    shpMestoNaSklade1.Visible := False;
    ceUseTovarPlace.Visible := False;
    lbCostPrice.Visible := False;
    shpCostPrice.Visible := False;
    shpCostPrice1.Visible := False;
    ceUseCurrency.Visible := False;
    cbShowCostPrice.Visible := False;
  end else begin
    shpSetOneMaster.Visible := False;
    cbSetOneMaster.Visible := False;
    shpSetOneMaster1.Visible := False;
    lbSetOneMaster.Visible := False;
    cbNotifySMS.Enabled := FALSE;
    cbNotifySMS.VISIBLE := FALSE;
    mSmsNotifyText.Enabled := FALSE;
    mSmsNotifyText.VISIBLE := FALSE;
    lbSmsName.VISIBLE := FALSE;
    cbEnableSmsHB.VISIBLE := FALSE;
    cbEnableSmsHB.Enabled := FALSE;
    mSmsHBText.Enabled := FALSE;
    mSmsHBText.VISIBLE := FALSE;
    cbTranslit.Enabled := FALSE;
    cbTranslit.VISIBLE := FALSE;
  end;
end;

procedure TSetupForm.GetData;
var
  Reg: TRegistry;
  Ini: TMeminifile; //необходимо создать объект, чтоб потом с ним работать
  SloganSize, PriceSize, NameSize : integer;
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

            {Валюта 0 - тенге 1 - рубли 2 - гривны}
            if ValueExists('Currency') then
              CurrencyVal := ReadInteger('Currency')
            else begin
              CurrencyVal := 0;
              WriteInteger('Currency', CurrencyVal);
            end;
            cbCurrency.ItemIndex := CurrencyVal;

            {Продавать товары с нулевым остатком или нет 0 - нет, 1 - да}
            if ValueExists('AllowSellAbsentGoods') then
              FAllowSellAbsentGoods := ReadInteger('AllowSellAbsentGoods')
            else begin
              FAllowSellAbsentGoods := 0;
              WriteInteger('AllowSellAbsentGoods', FAllowSellAbsentGoods);
            end;
            ceCanSellNol.Checked := FAllowSellAbsentGoods = 1;

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

            {показывать предварительное окно с количеством товара в режиме кассира 0 - нет, 1 - да}
            if ValueExists('ShowSaleDlg') then
              FShowSaleDlg := ReadInteger('ShowSaleDlg')
            else begin
              FShowSaleDlg := 0;
              WriteInteger('ShowSaleDlg', FShowSaleDlg);
            end;
            ceShowSaleDlg.Checked := FShowSaleDlg = 1;

            {закупочные цены в режиме кассира 0 - нет, 1 - да}
            if ValueExists('ShowCostPrice') then
              FShowCostPrice := ReadBool('ShowCostPrice')
            else begin
              FShowCostPrice := False;
              WriteBool('ShowCostPrice', FShowCostPrice);
            end;
            cbShowCostPrice.Checked := FShowCostPrice;

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

            {Отображать цены в валюте в приходе товара 0 - нет, 1 - да}
            if ValueExists('UseCurrency') then
              FUseCurrency := Readbool('UseCurrency')
            else begin
              FUseCurrency := false;
              WriteBool('UseCurrency', FUseCurrency);
            end;
            ceUseCurrency.Checked := FUseCurrency;

            {Закреплять мастера за счетом 0 - нет, 1 - да}
            if ValueExists('SetOneMaster') then
              FConfSetOneMaster := Readbool('SetOneMaster')
            else begin
              FConfSetOneMaster := false;
              WriteBool('SetOneMaster', FConfSetOneMaster);
            end;
            cbSetOneMaster.Checked := FConfSetOneMaster;

            {использовать весы со штрихкодом 0 - нет, 1 - да}
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

            {Принтер для печати чеков и ширина чековой ленты}
            if ValueExists('BillPrinterName') then begin
              BillPrinter := ReadString('BillPrinterName');
              cbPrinters.Text := BillPrinter;
            end else begin
              BillPrinter := cbPrinters.Text;
              WriteString('BillPrinterName', BillPrinter);
            end;
            if ValueExists('BillWidth') then begin
              BillWidth := ReadInteger('BillWidth');
              cbBillWidth.ItemIndex := BillWidth;
            end else begin
              BillWidth := cbBillWidth.ItemIndex;
              WriteInteger('BillWidth', BillWidth);
            end;
            if ValueExists('BillSdvig') then begin
              BillSdvig := ReadInteger('BillSdvig');
              seSdvig.Value := BillSdvig;
            end else begin
              BillSdvig := seSdvig.Value;
              WriteInteger('BillSdvig', BillSdvig);
            end;
            if ValueExists('BillSlogan') then begin
              BillSlogan := ReadString('BillSlogan');
              edSlogan.Text := BillSlogan;
            end else begin
              BillSlogan := 'автоматизировано при помощи Shopuchet.kz';
              WriteString('BillSlogan', BillSlogan);
            end;

            {Сетевой режим}
            if ValueExists('YesNetwork') then begin
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
            end;
			
            if ValueExists('Config') then begin
              Config := ReadInteger('Config');
              cbConfig.ItemIndex := Config;
            end else begin
              Config := cbConfig.ItemIndex;
              WriteInteger('Config', Config);
            end;

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
  end;

  // настройки из INI-файла
  Ini:=TMeminiFile.Create(Extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    //Cетевой режим, т.к. раньше сетевой режим хранился в реестре, то вверху читаю сначала реестр
    //а затем тут буду проверять, если не заполнено - то проверю здесь еще
    if YesNetwork = 0 then begin
      YesNetwork := Ini.ReadInteger('NetworkSettings', 'YesNetwork', 0);
      ServerName := Ini.ReadString('NetworkSettings', 'ServerName', '');
      rbYesNetwork.Checked := YesNetwork = 1;
      rbNoNetwork.Checked := YesNetwork = 0;
      edServer.Text := ServerName;
    end;

    // принтер для печати этикеток
    cbPrintersEtiket.ItemIndex := Ini.ReadInteger('Printetiket', 'PrinterIndex', 0);
    rbPrint.Checked := Ini.ReadInteger('Printetiket', 'PrinterEtiket', 1) = 1;
    rbPrinterA4.Checked := Ini.ReadInteger('Printetiket', 'PrinterA4', 0) = 1;
    cbChooseLentWidth.ItemIndex := Ini.ReadInteger('Printetiket', 'LentaWidth', 0);
    cbA4Size.ItemIndex := Ini.ReadInteger('Printetiket', 'A4Size', 0);
    edSloganEtiket.Text := Ini.ReadString('Printetiket', 'Slogan', '');
    cbPrintPrice.Checked := Ini.ReadInteger('Printetiket', 'PrintPrice', 0) = 1;
    cbPrintSlogan.Checked := Ini.ReadInteger('Printetiket', 'PrintSlogan', 0) = 1;
    cbPriceBold.Checked := Ini.ReadInteger('Printetiket', 'PriceBold', 0) = 1;
    cbSloganBold.Checked := Ini.ReadInteger('Printetiket', 'SloganBold', 0) = 1;
    PriceSize := Ini.ReadInteger('Printetiket', 'PriceSize', 0);
    SloganSize := Ini.ReadInteger('Printetiket', 'SloganSize', 0);
    NameSize := Ini.ReadInteger('Printetiket', 'NameSize', 0);
    cbNameBold.Checked := Ini.ReadInteger('Printetiket', 'NameBold', 0) = 1;
    SetDefaultSize(PriceSize, SloganSize, NameSize);

    edSmsLogin.Text := Ini.ReadString('SMS', 'Login', '');
    edSmsPassword.Text := Ini.ReadString('SMS', 'Password', '');
    cbNotifySMS.ItemIndex := Ini.ReadInteger('SMS', 'EnableSmsNotify', 0);
    mSmsNotifyText.Text := Ini.ReadString('SMS', 'SmsNotifyText', 'Добрый день, @name@! Салон красоты "Beauty" напоминает вам, что у вас запись @time@');
    cbEnableSmsHB.Checked := Ini.ReadInteger('SMS', 'EnableSmsHB', 0) = 1;
    mSmsHBText.Text := Ini.ReadString('SMS', 'SmsHbText', 'Добрый день, @name@! Салон красоты "Beauty" поздравляет Вас с Днем Рождения и дарит персональную скидку 10%!');
    cbTranslit.Checked := Ini.ReadInteger('SMS', 'TranslitSms', 0) = 1;
  finally
    Ini.Free;
  end;
end;

function TSetupForm.SaveSetup: Boolean;
var
  Reg: TRegistry;
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
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
            WriteInteger('AllowSellAbsentGoods', FAllowSellAbsentGoods);
            AllowSellAbsGoods := FAllowSellAbsentGoods;

            {Режим нескольких фирм 0 - нет, 1 - да}
            WriteInteger('ManyFirm', Integer(ceManyFirm.Checked));
            ManyFirm := Integer(ceManyFirm.Checked);

            {предупреждать о добавлении товара с нулевой ценой при продаже 0 - нет, 1 - да}
            WriteInteger('NotifyNol', FNotifyNol);
            NotifyNol := FNotifyNol;

            {показывать предварительное окно с количеством товара в режиме 0 - нет, 1 - да}
            WriteInteger('ShowSaleDlg', FShowSaleDlg);
            ShowSaleDlg := FShowSaleDlg;

            {показывать закупочные цены в режиме 0 - нет, 1 - да}
            WriteBool('ShowCostPrice', FShowCostPrice);
            ShowCostPrice := FShowCostPrice;

            {искать по полю "Место на складе" во всех режимах 0 - нет, 1 - да}
            WriteInteger('UseTovarPlace', FUseTovarPlace);
            UseTovarPlace := FUseTovarPlace;

            {Отображать валюты в приходе товара 0 - нет, 1 - да}
            WriteBool('UseCurrency', FUseCurrency);
            UseCurrency := FUseCurrency;

            {Закреплять мастера за счетом 0 - нет, 1 - да}
            WriteBool('SetOneMaster', FConfSetOneMaster);
            ConfSetOneMaster := FConfSetOneMaster;

            {не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да}
            WriteInteger('NewLineSale', FNewLineSale);
            NewLineSale := FNewLineSale;

            {Валюта 0 - тенге, 1 - рубли, 2 - гривны}
            WriteInteger('Currency', CurrencyVal);

            {использовать весы, 0 - нет, 1 - да}
            WriteInteger('UseScales', FUseScales);
            UseScales := FUseScales;

            {не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да}
            WriteString('ScalesPrefix', FScalesPrefix);
            ScalesPrefix := FScalesPrefix;

            {Принтер чеков и ширины ленты чеков}
            WriteString('BillPrinterName', BillPrinter);
            WriteInteger('BillWidth', BillWidth);
			      WriteInteger('BillSdvig', BillSdvig);
            WriteString('BillSlogan', BillSlogan);

            {конфигурация магазина}
            WriteInteger('Config', Config);

            {Шрифты}
            WriteString('MenuFontName', FMenuFontName);
            WriteInteger('MenuFontSize', FMenuFontSize);

            WriteString('GridFontName', FGridFontName);
            WriteInteger('GridFontSize', FGridFontSize);

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

    // принтер этикеток
    Ini.WriteInteger('Printetiket', 'PrinterIndex', cbPrintersEtiket.ItemIndex);
    Ini.WriteInteger('Printetiket', 'PrinterEtiket', Integer(rbPrint.Checked));
    Ini.WriteInteger('Printetiket', 'PrinterA4', Integer(rbPrinterA4.Checked));
    Ini.WriteInteger('Printetiket', 'LentaWidth', cbChooseLentWidth.ItemIndex);
    Ini.WriteInteger('Printetiket', 'A4Size', cbA4Size.ItemIndex);
    Ini.WriteString('Printetiket', 'PrinterName', cbPrintersEtiket.Text);
    Ini.WriteString('Printetiket', 'Slogan', edSloganEtiket.Text);
    Ini.WriteInteger('Printetiket', 'PrintPrice', Integer(cbPrintPrice.Checked));
    Ini.WriteInteger('Printetiket', 'PrintSlogan', Integer(cbPrintSlogan.Checked));
    Ini.WriteInteger('Printetiket', 'PriceBold', Integer(cbPriceBold.Checked));
    Ini.WriteInteger('Printetiket', 'SloganBold', Integer(cbSloganBold.Checked));
    Ini.WriteInteger('Printetiket', 'PriceSize', spnPriceSize.Value);
    Ini.WriteInteger('Printetiket', 'SloganSize', spnSloganSize.Value);
    Ini.WriteInteger('Printetiket', 'NameSize', spnNameSize.Value);
    Ini.WriteInteger('Printetiket', 'NameBold', Integer(cbNameBold.Checked));

    Ini.WriteString('SMS', 'Login', edSmsLogin.Text);
    Ini.WriteString('SMS', 'Password', edSmsPassword.Text);
    Ini.WriteInteger('SMS', 'EnableSmsNotify', cbNotifySMS.ItemIndex);
    Ini.WriteString('SMS', 'SmsNotifyText', mSmsNotifyText.Text);
    Ini.WriteInteger('SMS', 'EnableSmsHB', Integer(cbEnableSmsHB.Checked));
    Ini.WriteString('SMS', 'SmsHbText', mSmsHBText.Text);
    Ini.WriteInteger('SMS', 'TranslitSms', Integer(cbTranslit.Checked));

    SmsLogin := edSmsLogin.Text;
    SmsPassword := edSmsPassword.Text;
    SmsNotifyEnabled := cbNotifySMS.ItemIndex;
    SmsHBEnabled := Integer(cbEnableSmsHB.Checked);
    SmsNotifyText := mSmsNotifyText.Text;
    SmsHbText := mSmsHBText.Text;
    SmsTranslit := Integer(cbTranslit.Checked);
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
  end else
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

procedure TSetupForm.peAutoRefreshChange(Sender: TObject);
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

procedure TSetupForm.cbBackupPeriodChange(Sender: TObject);
begin
  FBackupPeriod := cbBackupPeriod.ItemIndex;
end;

procedure TSetupForm.rbDoBackupOnStartClick(Sender: TObject);
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
  FShowCostPrice := False;

  {не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да}
  ceNewLineSale.Checked := True;
  FNewLineSale := 1;

  {искать по полю "Место на складе" во всех режимах 0 - нет, 1 - да}
  ceUseTovarPlace.Checked := False;
  FUseTovarPlace := 0;

  {Отображать валюты в приходе товара}
  ceUseCurrency.Checked := False;
  FUseCurrency := False;

  {Закреплять мастера за счетом 0 - нет, 1 - да}
  cbSetOneMaster.Checked := False;
  FConfSetOneMaster := False;

  {использовать весы 0 - нет, 1 - да}
  cbUseScales.Checked := False;
  FUseScales := 0;

  {префикс весового штрихкода}
  edScalesPrefix.Text := '29';
  FScalesPrefix := '29';

  {Валюта}
  cbCurrency.ItemIndex := 0;
  CurrencyVal := 0;

  seSdvig.Value := 0;

  {конфигурация магазин - 0}
  cbConfig.ItemIndex := 0;

  //Сетевой режим откл
  rbNoNetwork.Checked := True;

  {Шрифт в меню}
  peMenuFont.ItemIndex := peMenuFont.Properties.Items.IndexOf(FMenuFontName);
  seMenuFontSize.EditValue := FMenuFontSize;

  {Шрифт в гридах}
  peGridFont.ItemIndex := peGridFont.Properties.Items.IndexOf(FGridFontName);
  seGridFontSize.EditValue := FGridFontSize;

  {Оповещаем главное окно об изменении настроек}
  //PostMessage(Application.MainForm.Handle, WM_SETUPCHANGED, 0, 0);
end;

procedure TSetupForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //inherited; {Полностью переопределяем метод}

  if ModalResult <> mrOk then
    Exit;

  CanClose := False;

  if (cbNotifySMS.ItemIndex + Integer(cbEnableSmsHB.Checked) > 0) and
  ((Trim(edSmsLogin.Text) = '') OR (Trim(edSmsPassword.Text) = '')) then begin
    MessageDlg('Вы включили автоматическую рассылку, но не указали логин/пароль к сервису SMSC.RU!', mtError, [mbOk], 0);
    pcCommon.ActivePage := tsSms;
    edSmsLogin.SetFocus;
    Exit;
  end;

  if SaveSetup then
    CanClose := True;
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
end;

procedure TSetupForm.ceUseCurrencyPropertiesChange(Sender: TObject);
begin
  FUseCurrency := ceUseCurrency.Checked;
end;

procedure TSetupForm.ceUseTovarPlacePropertiesChange(Sender: TObject);
begin
  FUseTovarPlace := Integer(ceUseTovarPlace.checked);
end;

procedure TSetupForm.ceCanSellNolPropertiesChange(Sender: TObject);
begin
  FAllowSellAbsentGoods := Integer(ceCanSellNol.checked);
end;

procedure TSetupForm.ceNewLineSalePropertiesChange(Sender: TObject);
begin
  FNewLineSale := Integer(ceNewLineSale.Checked);
end;

procedure TSetupForm.cbUseScalesPropertiesChange(Sender: TObject);
begin
  FUseScales := Integer(cbUseScales.Checked);
  edScalesPrefix.Enabled := cbUseScales.Checked;
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

procedure TSetupForm.cbPrintersChange(Sender: TObject);
begin
  BillPrinter := cbPrinters.Text;
end;

procedure TSetupForm.cbPrintPriceClick(Sender: TObject);
begin
  cbPriceBold.Enabled := cbPrintPrice.Checked;
  spnPriceSize.Enabled := cbPrintPrice.Checked;

  if cbPrintPrice.Checked = False then
    cbPriceBold.Checked := False;
end;

procedure TSetupForm.cbPrintSloganClick(Sender: TObject);
begin
  inherited;
  edSloganEtiket.Enabled := cbPrintSlogan.Checked;
  cbSloganBold.Enabled := cbPrintSlogan.Checked;
  spnSloganSize.Enabled := cbPrintSlogan.Checked;

  if cbPrintSlogan.Checked = False then
    cbSloganBold.Checked := False;
end;

procedure TSetupForm.cbSetOneMasterPropertiesChange(Sender: TObject);
begin
  FConfSetOneMaster := cbSetOneMaster.Checked;
end;

procedure TSetupForm.cbShowCostPricePropertiesChange(Sender: TObject);
begin
  FShowCostPrice := cbShowCostPrice.Checked;
end;

procedure TSetupForm.cbTimeNofityPropertiesChange(Sender: TObject);
begin
  mSmsNotifyText.Enabled := cbNotifySMS.ItemIndex > 0;
end;

procedure TSetupForm.cbTranslitPropertiesChange(Sender: TObject);
begin
  mSmsNotifyText.Text := TranslitRus(mSmsNotifyText.Text);
  mSmsHBText.Text := TranslitRus(mSmsHBText.Text);
end;

procedure TSetupForm.cbBillWidthChange(Sender: TObject);
begin
  BillWidth := cbBillWidth.ItemIndex;
  if BillWidth = 1 then begin
    if Length(edSlogan.Text) > 65 then begin
      MessageDlg('Слоган для печати слишком длинный.' + #13#10 + 'Он будет обрезан до подходящей длины.', mtWarning, [mbOK], 0);
      edSlogan.Properties.MaxLength := 65;
      edSlogan.Text := Copy(edSlogan.Text, 1, 65);
    end;
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

procedure TSetupForm.cbCurrencyChange(Sender: TObject);
begin
  CurrencyVal := cbCurrency.ItemIndex;
end;

procedure TSetupForm.cbEnableHBPropertiesChange(Sender: TObject);
begin
  mSmsHBText.Enabled := cbEnableSmsHB.Checked;
end;

procedure TSetupForm.Label27Click(Sender: TObject);
begin
  ShellExecute(handle,'open','https://shopuchet.kz/files/shopuchet_firebird.zip', nil, nil, SW_SHOW);
end;

procedure TSetupForm.rbNoNetworkClick(Sender: TObject);
begin
  btnSetServer.Enabled := False;
  btnTest.Enabled := False;
  edServer.Enabled := False;
  YesNetwork := 0;
  ServerName := '';
end;

procedure TSetupForm.rbYesNetworkClick(Sender: TObject);
begin
  btnSetServer.Enabled := True;
  btnTest.Enabled := True;
  edServer.Enabled := True;
  YesNetwork := 1;
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

procedure TSetupForm.seSdvigChange(Sender: TObject);
begin
  if seSdvig.Text <> '-' then
    BillSdvig := seSdvig.Value;
end;

procedure TSetupForm.SetDefaultSize(PriceSize, SloganSize, NameSize: Integer);
begin
  // у этикеток есть размеры по умолчанию, при переключении, или если не заданы настройки, надо ставить эти значения
  if cbChooseLentWidth.ItemIndex = 1 then begin     // 30*15
    if PriceSize = 0 then
      spnPriceSize.Value := 6
    else
      spnPriceSize.Value := PriceSize;

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

  dbTest.DBName := Servername + ':shopuchet';

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

procedure TSetupForm.cbConfigChange(Sender: TObject);
begin
  Config := cbConfig.ItemIndex;
  
  lbMagazin.Visible := Config = 0;
  lbApteka.Visible := Config = 1;
  lbAvtoZapchasti.Visible := Config = 2;
  lbProizvodstvo.Visible := Config = 3;
end;

procedure TSetupForm.edScalesPrefixKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TSetupForm.edServerChange(Sender: TObject);
begin
  ServerName := edServer.Text;
end;

procedure TSetupForm.rbPrintClick(Sender: TObject);
begin
  cbChooseLentWidth.Visible := rbPrint.Checked;
  cbA4Size.Visible := rbPrinterA4.Checked;
end;

end.
