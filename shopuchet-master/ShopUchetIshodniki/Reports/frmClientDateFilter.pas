unit frmClientDateFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, ExtCtrls, AppEvnts, Buttons, DB, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, frmDBDlg, ActnList, cxSpinEdit,
  cxTimeEdit, cxPC,
  cxSplitter, frmTreeFrame, cxRadioGroup, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxCurrencyEdit, cxCheckBox, cxDBTL,
  cxTLData, frmGridFrame, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, frmPopupClientMultList, System.UITypes,
  dxBarBuiltInMenu, Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions,
  Vcl.Menus, cxButtons, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TClientDateFilterForm = class(TDBDlgForm)
    tranRead: TpFIBTransaction;
    spIspolnitel: TpFIBDataSet;
    dsIspolnitel: TDataSource;
    PageControl: TcxPageControl;
    tsDates: TcxTabSheet;
    tsSklad: TcxTabSheet;
    Panel2: TPanel;
    btAll: TButton;
    btNone: TButton;
    pnOfficial: TPanel;
    Label4: TLabel;
    Shape6: TShape;
    Shape5: TShape;
    cbOfficial: TCheckBox;
    pnClient: TPanel;
    Label3: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    cbClient: TCheckBox;
    pnPayment: TPanel;
    Label7: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    cbPayment: TCheckBox;
    pnTime: TPanel;
    ceTime: TCheckBox;
    edTimeBegin: TcxTimeEdit;
    edTimeEnd: TcxTimeEdit;
    pnDate: TPanel;
    byDay: TRadioButton;
    byMonth: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    edDate: TcxDateEdit;
    edEndDate: TcxDateEdit;
    Shape4: TShape;
    byYear: TRadioButton;
    byPeriod: TRadioButton;
    pnReal: TPanel;
    Label5: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    ComboBox: TComboBox;
    tsTovar: TcxTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Label10: TLabel;
    cbTovAll: TCheckBox;
    edSearchTovar: TEdit;
    Panel5: TPanel;
    Panel7: TPanel;
    cbCatAll: TCheckBox;
    TovCatFrame: TTreeFrame;
    splMenu: TcxSplitter;
    TimerTovar: TTimer;
    tsSetNewPrices: TcxTabSheet;
    lb1: TLabel;
    sh1: TShape;
    sh2: TShape;
    lb2: TLabel;
    sh3: TShape;
    sh4: TShape;
    lb3: TLabel;
    sh5: TShape;
    sh6: TShape;
    lb4: TLabel;
    sh7: TShape;
    sh8: TShape;
    sh9: TShape;
    lb5: TLabel;
    sh10: TShape;
    pnPostavshik: TPanel;
    sh11: TShape;
    lb6: TLabel;
    sh12: TShape;
    cbPostavshikAll: TCheckBox;
    tsPredzakaz: TcxTabSheet;
    lb7: TLabel;
    sh13: TShape;
    lb8: TLabel;
    sh14: TShape;
    sh15: TShape;
    sh16: TShape;
    lb9: TLabel;
    sh17: TShape;
    sh18: TShape;
    lb10: TLabel;
    sh19: TShape;
    sh20: TShape;
    rbUnit: TcxRadioButton;
    rbProcent: TcxRadioButton;
    lbMode0: TLabel;
    cbbRound: TcxComboBox;
    lb12: TLabel;
    sh21: TShape;
    sh22: TShape;
    lb13: TLabel;
    lbVybor1: TLabel;
    lbVybor2: TLabel;
    lbVybor3: TLabel;
    lbMode1: TLabel;
    dsFirm: TDataSource;
    spFirm: TpFIBDataSet;
    pnContragent: TPanel;
    Label9: TLabel;
    rbClient: TRadioButton;
    rbPostavshik: TRadioButton;
    pnActSverki: TPanel;
    Label6: TLabel;
    Shape19: TShape;
    Shape21: TShape;
    Label11: TLabel;
    Label12: TLabel;
    Shape22: TShape;
    Shape24: TShape;
    edRukovod: TEdit;
    Shape23: TShape;
    cbbFirm: TcxLookupComboBox;
    Shape20: TShape;
    edClientDir: TEdit;
    edAmountAdd: TcxCurrencyEdit;
    cbDoSklad: TcxComboBox;
    cbMetodVybora: TcxComboBox;
    cbPredzakazMode: TcxComboBox;
    edValue: TcxCurrencyEdit;
    edOldCourse: TcxCurrencyEdit;
    edNewCourse: TcxCurrencyEdit;
    peClient: TcxPopupEdit;
    pePostavshik: TcxPopupEdit;
    leIspolnitel: TcxLookupComboBox;
    cbxPayment: TcxComboBox;
    TovaryFrame: TGridFrame;
    frmSklad: TGridFrame;
    cbChangePrice: TcxCheckBox;
    cbChangeCategory: TcxCheckBox;
    cbChangeMinOstatok: TcxCheckBox;
    cbMode: TcxComboBox;
    cbRoundMode: TcxComboBox;
    leCategory: TcxLookupComboBox;
    shp1: TShape;
    shp2: TShape;
    edMinAmount: TcxCurrencyEdit;
    lbWhatPrice: TLabel;
    shpWhatPrice: TShape;
    shpWhatPrice1: TShape;
    cbWhatPrice: TcxComboBox;
    pnlSalaryMode: TPanel;
    Shape9: TShape;
    Label8: TLabel;
    Shape10: TShape;
    cbSalaryMode: TcxComboBox;
    cbCnahgeSalesComm: TcxCheckBox;
    Shape11: TShape;
    edSalesComm: TcxCurrencyEdit;
    cbChangeKitTypeCheckBox: TcxCheckBox;
    Shape12: TShape;
    cbChagneKitType: TcxComboBox;
    pnlTovarCategory: TPanel;
    shp3: TShape;
    lb11: TLabel;
    shp4: TShape;
    cbTovarCategory: TCheckBox;
    sp1: TpFIBDataSet;
    ds1: TDataSource;
    leTovarCategory: TcxLookupComboBox;
    spProductCategory: TpFIBDataSet;
    dsProductCategory: TDataSource;
    cbKaspiCheckBox: TcxCheckBox;
    shpKaspi: TShape;
    cbKaspi: TcxComboBox;
    cbMakeBySF: TcxCheckBox;
    pnlExcludeStatyaPrihod: TPanel;
    leExcludeStatya: TcxLookupComboBox;
    spExcludeStatya: TpFIBDataSet;
    dsExcludeStatya: TDataSource;
    cbExcludeStatya: TcxCheckBox;
    cbExcludeStatyaAll: TcxCheckBox;
    shp5: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure byMonthClick(Sender: TObject);
    procedure byYearClick(Sender: TObject);
    procedure byPeriodClick(Sender: TObject);
    procedure byDayClick(Sender: TObject);
    procedure edDateExit(Sender: TObject);
    procedure leIspolnitelChange(Sender: TObject);
    procedure ceTimeClick(Sender: TObject);
    procedure cbCatAllClick(Sender: TObject);
    procedure cbTovAllClick(Sender: TObject);
    procedure btAllClick(Sender: TObject);
    procedure btNoneClick(Sender: TObject);
    procedure cbPaymentClick(Sender: TObject);
    procedure cbClientClick(Sender: TObject);
    procedure cbOfficialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edSearchTovarChange(Sender: TObject);
    procedure TimerTovarTimer(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure peClientKeyPress(Sender: TObject; var Key: Char);
    procedure cbModeChange(Sender: TObject);
    procedure rbUnitClick(Sender: TObject);
    procedure cbMetodVyboraChange(Sender: TObject);
    procedure cbPredzakazModeChange(Sender: TObject);
    procedure rbPostavshikClick(Sender: TObject);
    procedure cbbFirmPropertiesChange(Sender: TObject);
    procedure TovCatFrametlCommonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure peClientPropertiesCloseUp(Sender: TObject);
    procedure peClientPropertiesInitPopup(Sender: TObject);
    procedure pePostavshikPropertiesInitPopup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb1PropertiesChange(Sender: TObject);
    procedure cbChangePricePropertiesChange(Sender: TObject);
    procedure cbChangeCategoryPropertiesChange(Sender: TObject);
    procedure cbChangeMinOstatokPropertiesChange(Sender: TObject);
    procedure cbCnahgeSalesCommPropertiesChange(Sender: TObject);
    procedure cbChangeKitTypeCheckBoxPropertiesChange(Sender: TObject);
    procedure cbPostavshikAllClick(Sender: TObject);
    procedure cbTovarCategoryClick(Sender: TObject);
    procedure cbKaspiCheckBoxPropertiesChange(Sender: TObject);
    procedure cbExcludeStatysAllPropertiesChange(Sender: TObject);
    procedure cbExcludeStatyaAllPropertiesChange(Sender: TObject);
  private
    FSotrudnik : Int64;
    FTovarCategory : Int64;
    FDateBegin : TDate;
    FDateEnd   : TDate;
    FClient    : Int64;
    FClientCategory  : Int64;
    FPostavshik   : Int64;
    FContrAgentName : String;
    FContrAgentDirName : String;
    FFirmName     : String;
    FFIORukovod   : String;
    FPayment      : Int64;
    FCategoryArr  : String;
    FTovarArr     : String;
    FTovarName    : String;
    FSkladsArr    : String;
    FSkladsArrStr : String;
    FModeR : Integer;             // 100 - Сервис - массовое изменение цен товаров
    FPopupClientForm : TPopupClientMultListForm;
    peClientTag, pePostavshikTag : int64;
    function FillCatArr : STRING;
    procedure EnableItems;
  public
    property DateBegin : TDate read FDateBegin write FDateBegin;
    property DateEnd   : TDate read FDateEnd write FDateEnd;
    property Client    : Int64 read FClient write FClient;
    property ClientCategory  : Int64 read FClientCategory write FClientCategory;
    property ContrAgentName  : String read FContrAgentName write FContrAgentName;
    property ContrAgentDirName  : String read FContrAgentDirName write FContrAgentDirName;
    property FirmName  : String read FFirmName write FFirmName;
    property FIORukovod  : String read FFIORukovod write FFIORukovod;
    property Postavshik  : Int64 read FPostavshik write FPostavshik;
    property Sotrudnik : Int64 read FSotrudnik write FSotrudnik;
    property TovarCategory : Int64 read FTovarCategory write FTovarCategory;
    property Payment   : Int64 read FPayment write FPayment;
    property Category  : String read FCategoryArr write FCategoryArr;
    property Tovar     : String read FTovarArr write FTovarArr;
    property TovarName  : String read FTovarName write FTovarName;
    property SkladsArr  : String read FSkladsArr write FSkladsArr;
    property SkladsArrStr  : String read FSkladsArrStr write FSkladsArrStr;
    property ModeR  : Integer read FModeR write FModeR;
  end;

var
  ClientDateFilterForm: TClientDateFilterForm;
  P : Pboolean;

implementation

uses unCommonFunc;

{$R *.dfm}

{
ИЗНАЧАЛЬНО НЕПРАВИЛЬНО СДЕЛАЛ ТЕПЕРЬ ХУЙ ПОБЕДИ ТАМ, РЕШИЛ ПО НОВЫМ ОТЧЕТАМ, У КОТОРЫХ ФИЛЬТР
БОЛЬШЕ ИЛИ РАВНО 1000 ДЕЛАТЬ ДРУГУЮ ВЕТКУ

ModeR:
1 - ПРИБЫЛЬ МАГАЗИНА
2, 7 - ОТЧЕТ О ДВИЖЕНИИ ТОВАРА В МАГАЗИНЕ, ИСТОРИЯ ТОВАРА
3, 31, 32 - ОТЧЕТ О ПРОДАЖАХ В МАГАЗИНЕ
4 - ОТЧЕТ ПО ПРИХОДУ ТОВАРА
5 - ОТЧЕТ ПО ОСТАТКАМ ДЕНЕГ
6 - ОТЧЕТ ПО ТОВАРУ НА РЕАЛИЗАЦИИ
8 - ОТЧЕТ ПО ОСТАТКАМ ТОВАРОВ НА РЕАЛИЗАЦИИ И РЕВИЗИЯ
9 - ОТЧЕТ АКТ СВЕРКИ
10 - ОТЧЕТ О ЗАРПЛАТЕ
11 - ОТЧЕТ ОБ ОСТАТКАХ ТОВАРОВ НА ДАТУ
12 - ОТЧЕТ ОБ ОСТАТКАХ ТОВАРА И ПРОДАЖАМ ЗА ПЕРИОД
13 - ОТЧЕТЫ, ГДЕ НУЖЕН ТОЛЬКО ДАТЫ И СКЛАДЫ

100 - МАССОВОЕ ИЗМЕНИЕ ЦЕН ТОВАРОВ
101 - ПРЕДЗАКАЗ ТОВАРОВ

1000 - РЕЙТИНГ ПРОДАВЦА
1001 - РЕЙТИНГ ПРОДАВЦА ПО ГРУППАМ
}

procedure TClientDateFilterForm.FormShow(Sender: TObject);
var onEditChng : TNotifyEvent;    //чтобы не срабатывало открытие spRead при открытии формы, в случае когда вкладка была не "Дата"
begin
  riEditRepositoryCurrencyItem := SetColumnDecimalPlaceCur(riEditRepositoryCurrencyItem);

  // у одного клиента почему-то надписи были укороченные, поставлю их тут силком полные
  byDay.width := ScaleDimension(100);
  byMonth.width := ScaleDimension(100);
  byYear.width := ScaleDimension(100);
  byPeriod.width := ScaleDimension(152);

  onEditChng := PageControl.OnChange;
  PageControl.OnChange := nil;
  PageControl.ActivePage := tsDates;
  PageControl.OnChange := onEditChng;

  edDate.Date := Date;
  edEndDate.Date := Date;
  pnReal.Visible := False;
  pnActSverki.Visible := False;
  pnPostavshik.Visible := False;
  tsTovar.TabVisible := False;
  tsSetNewPrices.TabVisible := False;
  tsPredzakaz.TabVisible := False;
  pnContragent.Visible := False;
  pnlSalaryMode.Visible := False;
  pnlTovarCategory.Visible := False;
  cbMakeBySF.Visible := False;
  pnlExcludeStatyaPrihod.Visible := False;

  IF FModeR < 1000 THEN BEGIN
    // открываю склады, и если больше 1, то делаю вкладку видимой и ставлю галочку на текущий склад
    IF High(SkladArr) > 0 THEN BEGIN
      tsSklad.TabVisible := True;
      OpenSP(frmSklad.spReadFrame, False);
      frmSklad.spReadFrame.Locate('g_tochka', CurSklad, []);
      frmSklad.SetCheckOne(frmSklad.tvMain.ViewData.Records[frmSklad.tvMain.DataController.FocusedRecordIndex]);
    END;

    if FModeR = 1 then begin         //ПРИБЫЛЬ МАГАЗИНА
      pnOfficial.Visible := True;
      pnTime.Visible := False;
      pnPostavshik.Visible := True;
      pnlExcludeStatyaPrihod.Visible := True;

      OpenSP(spIspolnitel, False);
      if CurrentOfficialAppointment = 1 then begin // если это продавец, то он видит только свои продажи
        spIspolnitel.Filter := 'g_official = ' + IntToStr(CurrentOfficial);
        spIspolnitel.Filtered := True;
        cbOfficial.Checked := False;
        cbOfficial.Enabled := False;
        leIspolnitel.EditValue := CurrentOfficial;
      end;
      cbExcludeStatya.Checked := ReadIntSettingsIni('Reports', 'RepProfit', 0) = 1;

    end else IF FModeR in [2, 7] then begin   //ОТЧЕТ О ДВИЖЕНИИ ТОВАРА В МАГАЗИНЕ, ИСТОРИЯ ТОВАРА
      pnOfficial.Visible := False;
      pnPayment.Visible := False;
      pnClient.Visible := False;
      pnTime.Visible := False;
      tsTovar.TabVisible := True;
      IF FModeR = 2 then
        pnPostavshik.Visible := True;

    END else IF FModeR in [3, 31, 32] then begin   //ОТЧЕТ О ПРОДАЖАХ В МАГАЗИНЕ
      pnPayment.Visible := False;

      OpenSP(spIspolnitel, False);
      if CurrentOfficialAppointment = 1 then begin // если это продавец, то он видит только свои продажи
        spIspolnitel.Filter := 'g_official = ' + IntToStr(CurrentOfficial);
        spIspolnitel.Filtered := True;
        cbOfficial.Checked := False;
        cbOfficial.Enabled := False;
        leIspolnitel.EditValue := CurrentOfficial;
      end;

      if FModeR <> 32 then begin             // ДЛЯ ОТЧЕТА ПО ПРОДАЖАМ В РАЗРЕЗЕ НАКЛАДНЫХ - НЕ НАДО ТОВАРЫ
        tsTovar.TabVisible := True;
        FPopupClientForm.tsGroups.TabVisible := True;
        pnPostavshik.Visible := True;
      end
      else begin
        pnClient.Visible := False;
        pnOfficial.Visible := False;
      end;
    END else IF FModeR = 4 then begin   //ОТЧЕТ ПО ПРИХОДУ ТОВАРА
      pnPayment.Visible := False;
      pnClient.Visible := False;
      pnTime.Visible := False;
      pnOfficial.Visible := False;
      tsTovar.TabVisible := True;
    END else IF FModeR = 5 then begin   //ОТЧЕТ ПО ОСТАТКАМ ДЕНЕГ
      byMonth.Visible := False;
      byYear.Visible := False;
      byPeriod.Visible := False;
      pnPayment.Visible := False;
      pnClient.Visible := False;
      pnTime.Visible := False;
      pnOfficial.Visible := False;
    END else IF FModeR = 6 then begin   //ОТЧЕТ ПО ТОВАРУ НА РЕАЛИЗАЦИИ
      pnPayment.Visible := False;
      pnTime.Visible := False;
      pnOfficial.Visible := False;
      pnReal.Visible := True;
      FPopupClientForm.tsGroups.TabVisible := True;
    END else IF FModeR = 8 then begin   //ОТЧЕТ ПО ОСТАТКАМ ТОВАРОВ НА РЕАЛИЗАЦИИ И РЕВИЗИЯ
      tsTovar.TabVisible := True;
      PageControl.ActivePage := tsTovar;
      tsDates.TabVisible := False;
      tsSklad.TabVisible := False;
    END else IF FModeR = 9 then begin   //ОТЧЕТ АКТ СВЕРКИ
      pnActSverki.Visible := True;
      pnContragent.Visible := True;
      cbClient.Enabled := False;
      cbClient.Visible := False;
      cbClient.Enabled := False;
      cbClient.Visible := False;
      cbPostavshikAll.Checked := False;
      cbPostavshikAll.Enabled := False;
      cbPostavshikAll.Visible := False;
      pnPayment.Visible := False;
      pnOfficial.Visible := False;
      peClient.Enabled := True;
      cbMakeBySF.Visible := True;
      cbMakeBySF.Checked := ReadIntSettingsIni('AktSverki', 'MakeBySF', 0) = 1;
      OpenSP(spFirm, False);
      if spFirm.RecordCount > 1 then
        spFirm.Locate('is_default', 1, [])
      else
        spFirm.First;
      cbbFirm.EditValue := spFirm.FieldByName('G_FIRM_REKVIZIT').AsLargeInt;

    END else IF FModeR = 10 then begin    //ОТЧЕТ О ЗАРПЛАТЕ
      pnlSalaryMode.Visible := True;
      pnClient.Visible := false;
      pnPayment.Visible := false;
      OpenSP(spIspolnitel, False);
      cbOfficial.Checked := False;
      cbOfficial.Visible := False;

    END else IF FModeR = 11 then begin    //ОТЧЕТ ОБ ОСТАТКАХ ТОВАРОВ НА ДАТУ
      pnClient.Visible := false;
      pnPayment.Visible := false;
      byMonth.Enabled := False;
      byYear.Enabled := false;
      byPeriod.Enabled := false;
      pnOfficial.Visible := False;
      pnTime.Visible := False;
      tsTovar.TabVisible := True;

    END else IF FModeR = 12 then begin   // ОТЧЕТ ОБ ОСТАТКАХ ТОВАРОВ И ПРОДАЖАХ ЗА ПЕРИОД ПО СКЛАДАМ ПО ВСЕМ ТОВАРАМ
      pnPayment.Visible := False;
      pnClient.Visible := False;
      pnTime.Visible := False;
      pnOfficial.Visible := False;
      tsSklad.TabVisible := False;

    END else IF FModeR = 13 then begin   // ОТЧЕТЫ, ГДЕ НУЖЕН ТОЛЬКО ДАТЫ И СКЛАДЫ
      pnPayment.Visible := False;
      pnClient.Visible := False;
      pnTime.Visible := False;
      pnOfficial.Visible := False;
      tsSklad.TabVisible := False;
      tsSklad.TabVisible := True;

    END else IF FModeR = 100 then begin   //МАССОВОЕ ИЗМЕНИЕ ЦЕН ТОВАРОВ
      tsTovar.TabVisible := True;
      tsSetNewPrices.TabVisible := True;
      PageControl.ActivePage := tsSetNewPrices;
      tsDates.TabVisible := false;
      tsSklad.TabVisible := false;      // обычно этого делать не нужно, но тут просто режим, который вообще не нуждается в складах
      OpenSP(spProductCategory, False);

      if CurrencyVal = 0 then
      begin
        cbKaspiCheckBox.Visible := True;
        shpKaspi.Visible := True;
        cbKaspi.Visible := True;
      end
      else
      begin
        cbKaspiCheckBox.Visible := False;
        shpKaspi.Visible := False;
        cbKaspi.Visible := False;
      end;

      if Config = 4 then begin
        EnableItems;
        cbWhatPrice.ItemIndex := 1; // ставлю изменение цены за грамм по умолчанию для ювелирок
      end;

    END else IF FModeR = 101 then begin   //ПРЕДЗАКАЗ ТОВАРОВ
      PageControl.ActivePage := tsPredzakaz;
      tsDates.Enabled := False;
      pnTime.Visible := False;
      tsSklad.TabVisible := False;
      pnClient.Visible := False;
      pnOfficial.Visible := False;
      pnPayment.Visible := False;
      pnPostavshik.Visible := true;
      cbPostavshikAll.Checked := False;
      cbPostavshikAll.Enabled := False;
      cbPostavshikAll.Visible := False;
      tsPredzakaz.TabVisible := true;
      cbbRound.ItemIndex := 0;
    end;

  END  // IF FModeR < 1000 THEN BEGIN
  ELSE BEGIN

    pnPayment.Visible := False;
    pnlSalaryMode.Visible := False;
    pnClient.Visible := False;
    pnOfficial.Visible := False;
    pnPostavshik.Visible := False;
    pnReal.Visible := False;
    pnActSverki.Visible := False;

    if FModeR = 1000 then begin
      pnOfficial.Visible := True;
      OpenSP(spIspolnitel, False);
    end;

    if FModeR = 1001 then begin
      pnOfficial.Visible := True;
      OpenSP(spIspolnitel, False);
      pnlTovarCategory.Visible := True;
      OpenSP(spProductCategory, False);
    end;

  END; // IF FModeR > 1000 THEN BEGIN

  //если программа не активирована, то буду давать формировать только за сегодня
  if IsActivated = 0 then begin
    MessageDlg('Программа не активирована! Включены ограничения!', mtWarning, [mbOK], 0);
    byDay.Checked := True;
    byMonth.Enabled := False;
    byYear.Enabled := false;
    byPeriod.Enabled := false;
  end;
end;

procedure TClientDateFilterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TovaryFrame.FreeList;
  frmSklad.FreeList;

  if cbMakeBySF.Visible then
    SaveSettingsIni('AktSverki', 'MakeBySF', Integer(cbMakeBySF.Checked), '');

  if pnlExcludeStatyaPrihod.Visible then
    SaveSettingsIni('Reports', 'RepProfit', Integer(cbExcludeStatya.Checked), '');
end;

procedure TClientDateFilterForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i : integer;
begin
  inherited;
  if ModalResult = mrOK then begin
    FDateBegin := edDate.Date;
    FDateEnd   := edEndDate.Date;

    if not cbPayment.Checked then
      FPayment := cbxPayment.itemindex + 1;

    if not cbClient.Checked then
      if peClientTag = 0 then begin
        Showmessage('Выберите клиента!');
        CanClose := False;
        Exit;
      end;

    if (pnPostavshik.Visible) and (cbMetodVybora.ItemIndex > 0) then
      if pePostavshikTag <= 0 then begin
        Showmessage('Выберите поставщика!');
        PageControl.ActivePage := tsDates;
        CanClose := False;
        Exit;
      end;

    if not cbOfficial.Checked then
      if leIspolnitel.EditValue > 0 then
        FSotrudnik := leIspolnitel.EditValue
      else begin
        Showmessage('Выберите сотрудника!');
        CanClose := False;
        Exit;
      end;

    if not cbCatAll.Checked then begin
      FCategoryArr := FillCatArr;
      if FCategoryArr = '~' then
        FCategoryArr := '';
    end;

    if not cbTovAll.Checked then BEGIN
      FTovarArr := '~';
      FTovarArr := FTovarArr + TovaryFrame.FillArr;

      if FTovarArr = '~' then
        FTovarArr := '';
    END;

    if FModeR = 7 then
      if FTovarArr = '' then begin
        Showmessage('Выберите хотя бы один товар!');
        PageControl.ActivePage := tsTovar;
        CanClose := False;
        Exit;
      end;

    IF (((cbMode.ItemIndex < 4) AND (edValue.Value <> 0)) or ((cbMode.ItemIndex = 4) AND ((edOldCourse.Value <> 0) or (edNewCourse.Value <> 0)))) then begin
      if (FModeR = 100) and (cbCatAll.checked) and (cbTovAll.checked) then
        if MessageDlg('Вы не выбрали НИ ОДНОГО товара, поэтому изменение будет применено ко ВСЕМ товарам!' + CRLF +
          'Вы уверены, что хотите изменить цены ВСЕХ товаров? Операция не обратима!', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then begin
          PageControl.ActivePage := tsTovar;
          CanClose := False;
          Exit;
        end;
    end;

    if FModeR = 9 then begin
      if rbClient.checked then begin
        if peClient.Text = '' then begin
          MessageDlg('Выберите клиента!', mtInformation, [mbOK], 0);
          CanClose := False;
          Exit;
        end;
        FContrAgentName := peClient.Text
      end else begin
        if pePostavshik.Text = '' then begin
          MessageDlg('Выберите поставщика!', mtInformation, [mbOK], 0);
          CanClose := False;
          Exit;
        end;
        FContrAgentName := pePostavshik.Text;
        FClient := FPostavshik;
      end;

      IF cbbFirm.EditValue = 0 THEN begin
        MessageDlg('Выберите свою компанию!', mtInformation, [mbOK], 0);
        CanClose := False;
        Exit;
      end;
    end;

    if FModeR = 10 then begin
      if VarIsNull(leIspolnitel.EditValue) or (leIspolnitel.EditValue = 0) then begin
        Showmessage('Выберите сотрудника!');
        leIspolnitel.SetFocus;
        CanClose := False;
        Exit;
      end;
    end;

    if FModeR = 100 then begin
      if cbChangePrice.Checked then begin
        if (cbMode.ItemIndex < 4) AND (edValue.Value = 0) then begin
          MessageDlg('Укажите значение!', mtInformation, [mbOK], 0);
          PageControl.ActivePage := tsSetNewPrices;
          edValue.SetFocus;
          CanClose := False;
          Exit;
        end;

        if (cbMode.ItemIndex = 4) AND (edOldCourse.Value = 0) and (edNewCourse.Value = 0) then begin
          MessageDlg('Укажите значения курсов!', mtInformation, [mbOK], 0);
          PageControl.ActivePage := tsSetNewPrices;
          edNewCourse.SetFocus;
          CanClose := False;
          Exit;
        end;
      end;

      if (cbChangeCategory.Checked) and ((leCategory.EditValue = 0) or (leCategory.EditValue = null)) then begin
        MessageDlg('Выберите группу товаров!', mtInformation, [mbOK], 0);
        PageControl.ActivePage := tsSetNewPrices;
        leCategory.SetFocus;
        CanClose := False;
        Exit;
      end;
    end;

    {if FModeR = 1000 then begin
      if cbOfficial.Checked = false then begin
        if VarIsNull(leIspolnitel.EditValue) or (leIspolnitel.EditValue = 0) then begin
          Showmessage('Выберите сотрудника!');
          leIspolnitel.SetFocus;
          CanClose := False;
          Exit;
        end;
      end;
    end;}

    if FModeR = 1001 then begin
      if not cbTovarCategory.Checked then
        if leTovarCategory.EditValue > 0 then
          FTovarCategory := leTovarCategory.EditValue
        else begin
          Showmessage('Выберите группу товаров!');
          CanClose := False;
          Exit;
        end;
    end;

    //ЗАПОЛНЯЮ МАССИВ СКЛАДОВ
    IF frmSklad.spReadFrame.RecordCount > 1 THEN BEGIN
      FSkladsArrStr := 'Склады: ';
      FSkladsArr := '-';
      for i := 0 to frmSklad.AList.Count-1 do begin
        FSkladsArr := FSkladsArr + IntToStr(frmSklad.AList[i]) + '-';

        frmSklad.spReadFrame.Locate('g_tochka', frmSklad.AList[i], []);
        FSkladsArrStr := FSkladsArrStr + frmSklad.spReadFrame.FieldByName('name').AsString + ', ';
      end;
      FSkladsArrStr := copy(FSkladsArrStr, 1, LastDelimiter(',', FSkladsArrStr)-1);
    END;
  end;
end;

procedure TClientDateFilterForm.byMonthClick(Sender: TObject);
begin
  edDate.Date := edDate.Date - 30;
  edDate.Enabled := False;
  edEndDate.Enabled := False;
end;

procedure TClientDateFilterForm.byYearClick(Sender: TObject);
begin
  edDate.Date := edEndDate.Date - 365;
  edDate.Enabled := False;
  edEndDate.Enabled := False;
end;

procedure TClientDateFilterForm.byPeriodClick(Sender: TObject);
begin
  edDate.Enabled := True;
  edEndDate.Enabled := True;
end;

procedure TClientDateFilterForm.byDayClick(Sender: TObject);
begin
  edDate.Date := Date;
  edDate.Enabled := True;
  edEndDate.Enabled := False;
  edEndDate.Date := edDate.Date;
end;

procedure TClientDateFilterForm.edDateExit(Sender: TObject);
begin
  if byDay.Checked then
    edEndDate.Date := edDate.Date;
end;

procedure TClientDateFilterForm.leIspolnitelChange(Sender: TObject);
begin
  FSotrudnik := leIspolnitel.EditValue;
end;

procedure TClientDateFilterForm.ceTimeClick(Sender: TObject);
begin
  edTimeBegin.Enabled := ceTime.Checked;
  edTimeEnd.Enabled := ceTime.Checked;
end;

procedure TClientDateFilterForm.cbCatAllClick(Sender: TObject);
begin
  if cbCatAll.Checked then begin
    cbTovAll.Checked := True;
    cbTovAll.Enabled := False;
    cbTovAllClick(Sender);
    TovCatFrame.spReadFrame.Close;
    TovCatFrame.tlCommon.Clear;
    TovCatFrame.tlCommon.Enabled := False;
  end else begin
    OpenSp(TovCatFrame.spReadFrame, False);
    TovCatFrame.tlCommon.Enabled := True;
    TovCatFrame.tlCommon.FullExpand;
    TovCatFrame.tlCommon.SetFocus;
    if FModeR <> 31 then     //ДЛЯ ОТЧЕТА ПО ПРОДАЖАМ ПО КАТЕГОРИЯМ - НЕ НУЖНЫ ТОВАРЫ
      cbTovAll.Enabled := True;
  end;
end;

procedure TClientDateFilterForm.cbChangeCategoryPropertiesChange(
  Sender: TObject);
begin
  leCategory.Enabled := cbChangeCategory.Checked;
end;

procedure TClientDateFilterForm.cbChangeKitTypeCheckBoxPropertiesChange(
  Sender: TObject);
begin
  cbChagneKitType.Enabled := cbChangeKitTypeCheckBox.Checked;
end;

procedure TClientDateFilterForm.cbChangeMinOstatokPropertiesChange(
  Sender: TObject);
begin
  edMinAmount.Enabled := cbChangeMinOstatok.Checked;
end;

procedure TClientDateFilterForm.cbChangePricePropertiesChange(Sender: TObject);
begin
  cbMode.Enabled := cbChangePrice.Checked;
  edValue.Enabled := cbChangePrice.Checked;
  cbRoundMode.Enabled := cbChangePrice.Checked;
  cbWhatPrice.Enabled := cbChangePrice.Checked;
end;

procedure TClientDateFilterForm.cbTovAllClick(Sender: TObject);
begin
  if cbTovAll.Checked then begin
    TovaryFrame.ClearList;
    TovaryFrame.spReadFrame.Close;
    TovaryFrame.grMain.Enabled := False;
  end else begin
    Screen.Cursor := crHourGlass;
    TovaryFrame.spReadFrame.ParamByName('g_category_').AsString := FillCatArr;
    OpenSp(TovaryFrame.spReadFrame, False);
    TovaryFrame.grMain.Enabled := True;
    TovaryFrame.grMain.SetFocus;
    Screen.Cursor := crDefault;
  end;
end;

procedure TClientDateFilterForm.cbTovarCategoryClick(Sender: TObject);
begin
  if cbTovarCategory.Checked then begin
    leTovarCategory.Clear;
    leTovarCategory.Enabled := False;
    FTovarCategory := 0;
  end else
    leTovarCategory.Enabled := True;
end;

function TClientDateFilterForm.FillCatArr : STRING;
var ANode, ANodeOld: TcxTreeListNode;
begin
  ANodeOld := TovCatFrame.tlCommon.FocusedNode;
  //ЗАПОЛНЯЮ МАССИВ КАТЕГОРИЙ
  Result := '~';
  TovCatFrame.tlCommon.GotoBOF;
  TovCatFrame.tlCommon.TopNode.Focused := True;
  ANode := TovCatFrame.tlCommon.FocusedNode;
  while ANode <> nil do begin
    if ANode.Data <> nil then
      if PBoolean(ANode.Data)^ then
        Result  := Result + IntToStr(ANode.Values[2]) + '~';

    ANode := ANode.GetNext;
    if ANode = nil then BEGIN
      Break;
    END;
  end;

  ANodeOld.Focused := True;
end;

procedure TClientDateFilterForm.TovCatFrametlCommonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TovCatFrame.tlCommonMouseDown(Sender, Button, Shift, X, Y);
  if not cbTovAll.Checked then begin
    Screen.Cursor := crHourGlass;
    TovaryFrame.spReadFrame.ParamByName('g_category_').AsString := FillCatArr;
    OpenSp(TovaryFrame.spReadFrame, False);
    Screen.Cursor := crDefault;
  end;
end;

procedure TClientDateFilterForm.btAllClick(Sender: TObject);
begin
  frmSklad.SetRemoveCheckAll(true);
end;

procedure TClientDateFilterForm.btNoneClick(Sender: TObject);
begin
  frmSklad.SetRemoveCheckAll(false);
end;

procedure TClientDateFilterForm.cbPaymentClick(Sender: TObject);
begin
  if cbPayment.Checked then begin
    cbxPayment.ItemIndex := -1;
    cbxPayment.Enabled := False;
  end else begin
    cbxPayment.Enabled := True;
    cbxPayment.ItemIndex := 0;
  end
end;

procedure TClientDateFilterForm.cbPostavshikAllClick(Sender: TObject);
begin
  if cbPostavshikAll.Checked then begin
    pePostavshikTag := 0;
    pePostavshik.Clear;
    pePostavshik.Enabled := False;
    FClient := 0;
  end else
    pePostavshik.Enabled := True;
end;

procedure TClientDateFilterForm.cbClientClick(Sender: TObject);
begin
  if cbClient.Checked then begin
    peClientTag := 0;
    peClient.Clear;
    peClient.Enabled := False;
    FClient := 0;
  end else
    peClient.Enabled := True;
end;

procedure TClientDateFilterForm.cbCnahgeSalesCommPropertiesChange(
  Sender: TObject);
begin
  edSalesComm.Enabled := cbCnahgeSalesComm.Checked;
  if not cbCnahgeSalesComm.Checked then
    edSalesComm.Value := 0;
end;

procedure TClientDateFilterForm.cbExcludeStatyaAllPropertiesChange(
  Sender: TObject);
begin
  leExcludeStatya.Enabled := not cbExcludeStatyaAll.Checked;
end;

procedure TClientDateFilterForm.cbExcludeStatysAllPropertiesChange(
  Sender: TObject);
begin
  cbExcludeStatyaAll.Enabled := cbExcludeStatya.Checked;

  if cbExcludeStatya.Checked then
    OpenSp(spExcludeStatya, False)
  else begin
    if spExcludeStatya.Active then
      spExcludeStatya.Close;
  end;

end;

procedure TClientDateFilterForm.cbKaspiCheckBoxPropertiesChange(
  Sender: TObject);
begin
  inherited;
  cbKaspi.Enabled := cbKaspiCheckBox.Checked;
end;

procedure TClientDateFilterForm.cbOfficialClick(Sender: TObject);
begin
  if cbOfficial.Checked then begin
    leIspolnitel.Clear;
    leIspolnitel.Enabled := False;
    FSotrudnik := 0;
  end else
    leIspolnitel.Enabled := True;
end;

procedure TClientDateFilterForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPopupClientForm := TPopupClientMultListForm.Create(Self);
  TovaryFrame.CreateList;
  frmSklad.CreateList;
end;

procedure TClientDateFilterForm.edSearchTovarChange(Sender: TObject);
begin
  TimerTovar.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edSearchTovar.Text <> '' then
    TimerTovar.Enabled := True
  else BEGIN
    with TovaryFrame.spReadFrame do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TClientDateFilterForm.EnableItems;
begin
  lbWhatPrice.Visible := (cbMode.ItemIndex = 5) or (Config = 4);
  shpWhatPrice.Visible := (cbMode.ItemIndex = 5) or (Config = 4);
  shpWhatPrice1.Visible := (cbMode.ItemIndex = 5) or (Config = 4);
  cbWhatPrice.Visible := (cbMode.ItemIndex = 5) or (Config = 4);

  if Config = 4 then begin
    if cbMode.ItemIndex <> 5 then begin
      cbWhatPrice.Properties.Items.Clear;
      cbWhatPrice.Properties.Items.Add('Розничная, оптовая');
      cbWhatPrice.Properties.Items.Add('Цена продажи за грамм');
      cbWhatPrice.ItemIndex := 1;    // ставлю цену продажи за грамм по умолчанию
    end
    else if cbMode.ItemIndex = 5 then begin
      cbWhatPrice.Properties.Items.Clear;
      cbWhatPrice.Properties.Items.Add('Розничная');
      cbWhatPrice.Properties.Items.Add('Оптовая');
      cbWhatPrice.Properties.Items.Add('Цена продажи за грамм');
      cbWhatPrice.ItemIndex := 2;    // ставлю цену продажи за грамм по умолчанию
    end;
  end;
end;

procedure TClientDateFilterForm.TimerTovarTimer(Sender: TObject);
var s: string;
begin
  TimerTovar.Enabled := False;
  if (edSearchTovar.text<>'') then begin
    with TovaryFrame.spReadFrame do begin
      s := '(NAME CONTAINING ''' + edSearchTovar.text + ''') OR (ARTICUL CONTAINING ''' + edSearchTovar.text + ''') OR (BARCODE CONTAINING '''+ edSearchTovar.text + ''')';
      
      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edSearchTovar.text + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if TovaryFrame.tvMain.Controller.FocusedRow <> Nil then begin
      if TovaryFrame.tvMain.Controller.SelectedRowCount > 0 then
        TovaryFrame.tvMain.Controller.SelectedRows[0].Selected := False;
      TovaryFrame.tvMain.Controller.FocusedRow.Selected := True;
    end;
  END;
end;

procedure TClientDateFilterForm.PageControlChange(Sender: TObject);
begin
  // иначе когда вызываем отчет История товара, spRead сразу открывается, и открытие окна подтормаживает, если товаров много. Потому решил открытие здесь делать
  if (FModeR in [2,7,8]) and (cbCatAll.Checked) and (PageControl.ActivePage = tsTovar) then begin
    cbCatAll.Checked := False;
    cbTovAll.Checked := False;
    if FModeR = 7 then begin
      cbCatAll.Visible := False;
      cbTovAll.Visible := False;
    end;
  end;
end;

procedure TClientDateFilterForm.peClientKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TClientDateFilterForm.peClientPropertiesCloseUp(Sender: TObject);
begin
  if FPopupCLIENTForm.AcceptRes then begin
    if FPopupCLIENTForm.dxPageControl.ActivePage = FPopupCLIENTForm.ts1 then begin
      peClientTag := FPopupCLIENTForm.spRead.FieldByName('ID').AsLargeInt;
      pePostavshikTag := FPopupCLIENTForm.spRead.FieldByName('ID').AsLargeInt;
      (Sender as TcxPopupEdit).Text := FPopupCLIENTForm.spRead.FieldByName('name').AsString;

      if (Sender as TcxPopupEdit).Name = 'peClient' then
        FClient := peClientTag
      else
        FPostavshik := pePostavshikTag;
    end else begin
      peClientTag := FPopupCLIENTForm.spGroups.FieldByName('ID').AsLargeInt;
      (Sender as TcxPopupEdit).Text := FPopupCLIENTForm.spGroups.FieldByName('name').AsString;
      FClientCategory := peClientTag;
    end;
  end;
end;

procedure TClientDateFilterForm.peClientPropertiesInitPopup(Sender: TObject);
begin
  peClient.DroppedDown := True;
  FPopupCLIENTForm.IsPostavshik := 0;
  FPopupCLIENTForm.arefresh.Execute;
end;

procedure TClientDateFilterForm.pePostavshikPropertiesInitPopup(
  Sender: TObject);
begin
  pePostavshik.DroppedDown := True;
  FPopupCLIENTForm.IsPostavshik := 1;
  FPopupCLIENTForm.arefresh.Execute;
end;

procedure TClientDateFilterForm.cbModeChange(Sender: TObject);
begin


  {if (cbMode.ItemIndex in [0, 2]) then
    edValue.Properties.DisplayFormat := ',0.00%'
  else
    edValue.Properties.DisplayFormat := ',0.00';}
end;

procedure TClientDateFilterForm.rbUnitClick(Sender: TObject);
begin
  cbbRound.Enabled := rbProcent.Checked;
  if (rbProcent.Checked) then
    edAmountAdd.Properties.DisplayFormat := ',0.00%'
  else
    edAmountAdd.Properties.DisplayFormat := ',0.00';
end;

procedure TClientDateFilterForm.cbMetodVyboraChange(Sender: TObject);
begin
  tsDates.Enabled := cbMetodVybora.ItemIndex > 0;
  pnDate.Visible := cbMetodVybora.ItemIndex = 2;

  lbVybor1.Visible := cbMetodVybora.ItemIndex = 0;
  lbVybor2.Visible := cbMetodVybora.ItemIndex = 1;
  lbVybor3.Visible := cbMetodVybora.ItemIndex = 2;
end;

procedure TClientDateFilterForm.cbPredzakazModeChange(Sender: TObject);
begin
  lbMode0.Visible := cbPredzakazMode.ItemIndex = 0;
  lbMode1.Visible := cbPredzakazMode.ItemIndex = 1;
end;

procedure TClientDateFilterForm.rbPostavshikClick(Sender: TObject);
begin
  pnPostavshik.Visible := rbPostavshik.Checked;
  pnClient.Visible := rbClient.Checked;
end;

procedure TClientDateFilterForm.cb1PropertiesChange(Sender: TObject);
begin
  edValue.Enabled := cbMode.ItemIndex <> 4;
  edOldCourse.Enabled := cbMode.ItemIndex = 4;
  edNewCourse.Enabled := cbMode.ItemIndex = 4;

  EnableItems;
end;

procedure TClientDateFilterForm.cbbFirmPropertiesChange(Sender: TObject);
begin
  edRukovod.Text := spFirm.FieldByName('head').asString;
end;

end.
