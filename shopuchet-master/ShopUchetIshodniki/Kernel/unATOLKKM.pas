unit unATOLKKM;

interface
uses Windows, Classes, SysUtils, ComObj, ActiveX, Variants;
const
  // Регистры ККМ
  // Числовые константы
  kvKKMNumber = 0;
  kvPaymentType1_KREDIT_Enabled = 2;
  kvPaymentType2_TARA_Enabled = 3;
  kvPaymentType3_PAYCARD_Enabled = 41;
  kvPrintSectionName = 39;
  kvSlipDocsEnabled = 40;
  kvPrintReclama = 45;
  kvAutoOpenDrawer = 46;
  kvPrintKassirNames = 56;
  kvClisheLinesCount = 66;
  kvPrintSectionNumbers = 72;
  kvPrintOpenSessionDoc = 73;
  kvQuantityPrintType = 80;
  kvWinterTimeType = 82;
  kvHeaderPrintType = 196;
  kvCheckPrintType = 198;
  kvExtendedZXReports = 207;
  kvCheckLiftValue = 233;

  // Строковые константы
  ksSeparatorChar = 201;
  ksHeaderStr1 = 0;
  ksHeaderStr2 = 1;
  ksHeaderStr3 = 2;
  ksHeaderStr4 = 3;
  ksHeaderStr5 = 4;
  ksHeaderStr6 = 5;

  ksClisheStr1 = 69;
  ksClisheStr2 = 70;
  ksClisheStr3 = 71;
  ksClisheStr4 = 72;
  ksClisheStr5 = 73;
  ksClisheStr6 = 74;
  ksClisheStr7 = 75;
  ksClisheStr8 = 76;
  ksClisheStr9 = 77;
  ksClisheStr10 = 78;
  ksClisheStr11 = 79;
  ksClisheStr12 = 80;
  ksClisheStr13 = 81;
  ksClisheStr14 = 82;
  ksClisheStr15 = 83;
  ksClisheStr16 = 84;
  ksClisheStr17 = 85;
  ksClisheStr18 = 86;
  ksClisheStr19 = 87;
  ksClisheStr20 = 88;

  ksPaymentType1Name = 66;
  ksPaymentType2Name = 67;
  ksPaymentType3Name = 68;

type
  TUnitCodePage = (ucpRU = 0, ucpARM = 1, ucpMOL = 2, ucpUA = 3, ucpLIT = 4,
    ucpTURKM = 5, ucpMON = 6, ucpBEL = 7, ucpLATV = 8, ucpGEOR = 9, ucpKAZ = 10,
    ucpEST = 11, ucpAZER = 12, ucpKIRG = 13, ucpTAG = 14, ucpUZ = 15,
    ucpPOL = 16, ucpROM = 17, ucpBOLG = 18, ucpENG = 19);

  TUnitType = (utCPU = 1, utFM = 2, utBoot = 3, utPrnSoft);
  // 1 – ПО основного процессора ККМ;
  // 2 – ПО процессора фискального модуля ККМ;
  // 3 – ПО загрузочного блока основного процессора ККМ;
  // 4 – ПО принтера

  // Информация о модуле
  TUnitInfo = record
    UnitType: TUnitType;
    UmajorVersion: integer;
    UminorVersion: integer;
    Ubuild: integer;
    UcodePage: TUnitCodePage;
  end;

  // Строковые параметры 69..88
  // TFRClisheFooter = TArray<String>;

  // Наименование видов оплат
  // Строки 66..68 параметров

  TDeviceType = (dtNotDefined = 0, dtKKM = 1, dtScales = 2, dtMemoPlus = 3);
  // Тип оборудования:
  // 0 – не определен;
  // 1 – ККМ;
  // 2 – весы электронные;
  // 3 – Memo Plus™;

  TTextWrapMode = (wNotWrap = 0, wByWords = 1, wByStrings = 2);

  TDeviceMode = (dmOffLine = 32768, dmOnline = 16384, dmPassiveOnline = 8192,
    dmFR = 4096, dmFP = 2048);
  // Поддерживаемые оборудованием режимы:
  // 32768 – режим OffLine;
  // 16384 – режим OnLine;
  // 8192 – пассивный OnLine (принтер чеков);
  // 4096 – фискальный регистратор;
  // 2048 – фискальная плата

  // Параметры устройства
  TDeviceMetrics = record
    UprotocolVersion: integer;
    Utype: TDeviceType;
    Umodel: integer;
    Umode: TDeviceMode;
    UmajorVersion: integer;
    UminorVersion: integer;
    Ubuild: integer;
    UcodePage: TUnitCodePage;
    Udescription: string;
  end;

  TKKMFont = record
    Italic: boolean;
    Bold: boolean;
    Negative: boolean; // Фон символов RW
    Underline: boolean; // Подчеркнутый шрифт RW
    DblHeight: boolean; // Шрифт двойной высоты RW
    DblWidth: boolean; // Шрифт двойной толщины RW
  end;

  TKKMReportType = (rtKLGash = 0, rtZReport = 1, rtXReport = 2,
    rtFPDateRange = 3, rtFPSessRange = 4, rtFPDateRangeFull = 5,
    rtFPSessRangeFull = 6, rtSections = 7, rtKassir = 8, rtGoods = 9,
    rtHours = 10, rtQuantity = 11, rtEKLZActItogs = 22, rtEKLZSessItogs = 23,
    rtEKLZSessionKL = 24, rtEKLZKPK = 25, rtEKLZDatesShortByOtdel = 26,
    rtEKLZDatesFullByOtdel = 27);
  // 0 Гашение контрольной ленты
  // 1  Суточный отчет с гашением
  // 2  Суточный отчет без гашения
  // 3  Краткий фискальный отчет по диапазону дат.
  // Входные свойства – Day, Month, Year, EndDay, EndMonth, EndYear
  // 4  Краткий фискальный отчет по диапазону смен.
  // Входные свойства – Session, EndSession
  // 5  Полный фискальный отчет по диапазону дат.
  // Входные свойства – Day, Month, Year, EndDay, EndMonth, EndYear
  // 6  Полный фискальный отчет по диапазону смен.
  // Входные свойства – Session, EndSession
  // 7  Отчет по секциям
  // 8  Отчет по кассирам
  // 9  Отчет по товарам
  // 10 Отчет по часам
  // 11 Отчет по количеству
  // 22 ЭКЛЗ итоги активизации
  // 23 ЭКЛЗ итоги смены.
  // Входные свойства – Session
  // 24 ЭКЛЗ контрольная лента смены.
  // Входные свойства – Session
  // 25 ЭКЛЗ документ по номеру КПК.
  // Входные свойства – EKLZKPKNumber
  // 26 ЭКЛЗ по датам краткий по отделам.
  // Входные свойства – Day, Month, Year, EndDay, EndMonth, EndYear
  // 27 ЭКЛЗ по датам полный по отделам.
  // Входные свойства – Day, Month, Year, EndDay, EndMonth, EndYear
  // 28 ЭКЛЗ по датам краткий по итогам смен.
  // Входные свойства – Day, Month, Year, EndDay, EndMonth, EndYear
  // 29 ЭКЛЗ по датам полный по итогам смен.
  // Входные свойства – Day, Month, Year, EndDay, EndMonth, EndYear
  // 30 ЭКЛЗ по сменам краткий по отделам.
  // Входные свойства – Session, EndSession
  // 31 ЭКЛЗ по сменам полный по отделам.
  // Входные свойства – Session, EndSession
  // 32 ЭКЛЗ по сменам краткий по итогам смен.
  // Входные свойства – Session, EndSession
  // 33 ЭКЛЗ по сменам полный по итогам смен.
  // Входные свойства – Session, EndSession
  // 34 Печать документа из ЭЖ по номеру.
  // Входные свойства – DocNumber
  // 35 Печать ЭЖ (полная КЛ).
  // Входные свойства – ClearJrn
  // 36 Печать ЭЖ (краткая КЛ).
  // Входные свойства – ClearJrn
  // 37 Печать сохранённых отчётов с гашением
  // 38 Служебный отчет
  // 39 Печать отчета из SD-карты
  // 40 Ведомость общих показаний

  TCheckType = (ctSale = 1, ctReturn = 2, ctAnnulate = 3, ctBuy = 4,
    ctBuyReturn = 5, ctBuyAnnulate = 6);
  // Тип чека:
  // 1 – продажа;
  // 2 – возврат продажи;
  // 3 – аннулирование продажи;
  // 4 – покупка;
  // 5 – возврат покупки;
  // 6 – аннулирование покупки

  TTypeClose = (tcCash = 0, tcType1 = 1, tcType2 = 2, tcType3 = 3, tcType4 = 4,
    tcType5 = 5);
  // Виды оплаты
  // 0 - Наличными, 1 - Вид оплаты 1..

  // Режимы работы ККМ
  TKKMMode = (kmSelect = 0, kmRegistration = 1, kmXReport = 2, kmZReport = 3,
    kmProgram = 4);

  TKKMCheckState = (csClosed = 0, csSaleOpened = 1, csSaleReturnOpened = 2,
    csSaleAnnulateOpened = 3, csBuyOpened = 4, csBuyReturnOpened = 5);
  // 0 – закрыт;
  // 1 – открыт чек продажи;
  // 2 – открыт чек возврата продажи;
  // 3 – открыт чек аннулирования продажи;
  // 4 – открыт чек покупки;
  // 5 – открыт чек возврата покупки

  TKKMDriver = class
  protected
    FDevice: Variant; // объект драйвера
  private
    FReportType: TKKMReportType;

    function GetInboundStream: string;
    procedure SetInboundStream(const Value: string);
    function GetDisablePasswordSettings: boolean;
    procedure SetAccessPassword(const Value: string);
    procedure SetAdvancedMode(const Value: integer);
    procedure SetAdvancedRegistration(const Value: boolean);
    procedure SetAlignment(const Value: integer);
    procedure SetApplicationHandle(const Value: THandle);
    procedure SetAutoSize(const Value: boolean);
    procedure SetBarcode(const Value: string);
    procedure SetBarcodeControlCode(const Value: boolean);
    procedure SetBarcodeType(const Value: integer);
    procedure SetBaudRate(const Value: integer);
    procedure SetBufferingMode(const Value: boolean);
    procedure SetCheckNumber(const Value: integer);
    procedure SetCheckType(const Value: TCheckType);
    procedure SetCount(const Value: integer);
    procedure SetCounterType(const Value: integer);
    procedure SetCurrentDeviceIndex(const Value: integer);
    procedure SetCurrentDeviceName(const Value: string);
    procedure SetCurrentDeviceNumber(const Value: integer);
    procedure SetDay(const Value: word);
    procedure SetDefaultPassword(const Value: string);
    procedure SetDepartment(const Value: integer);
    procedure SetDestination(const Value: integer);
    procedure SetDeviceEnabled(const Value: boolean);
    procedure SetDeviceSettings(const Value: string);
    procedure SetDevicesSettings(const Value: string);
    procedure SetDiscountType(const Value: integer);
    procedure SetDiscountTypeNumber(const Value: integer);
    procedure SetDiscountValue(const Value: Double);
    procedure SetDrawerOffTimeout(const Value: integer);
    procedure SetDrawerOnQuantity(const Value: integer);
    procedure SetDrawerOnTimeout(const Value: integer);
    procedure SetDuration(const Value: integer);
    procedure SetEnableCheckSumm(const Value: boolean);
    procedure SetEndDay(const Value: word);
    procedure SetEndMonth(const Value: word);
    procedure SetEndSession(const Value: integer);
    procedure SetEndYear(const Value: word);
    procedure SetEntryNum(const Value: integer);
    procedure SetFileName(const Value: string);
    procedure SetFontBold(const Value: boolean);
    procedure SetFontDblHeight(const Value: boolean);
    procedure SetFontDblWidth(const Value: boolean);
    procedure SetFontItalic(const Value: boolean);
    procedure SetFontNegative(const Value: boolean);
    procedure SetFontUnderline(const Value: boolean);
    procedure SetFrequency(const Value: integer);
    procedure SetHeight(const Value: integer);
    procedure SetHour(const Value: word);
    procedure SetJrnBrightness(const Value: integer);
    procedure SetJrnFont(const Value: integer);
    procedure SetJrnFontHeight(const Value: integer);
    procedure SetJrnLineSpacing(const Value: integer);
    procedure SetLineNumber(const Value: integer);
    procedure SetMachineName(const Value: string);
    procedure SetMachineNumber(const Value: string);
    procedure SetMinute(const Value: word);
    procedure SetModel(const Value: integer);
    procedure SetModelCheck(const Value: boolean);
    procedure SetMonth(const Value: word);
    procedure Setname(const Value: string);
    procedure SetOperationType(const Value: integer);
    procedure SetOperatorNo(const Value: integer);
    procedure SetOutBoundStream(const Value: string);
    procedure SetPercents(const Value: Double);
    procedure SetPictureNumber(const Value: integer);
    procedure SetPortNumber(const Value: integer);
    procedure SetPrice(const Value: Double);
    procedure SetPrintBarcodeText(const Value: integer);
    procedure SetPrintPurpose(const Value: integer);
    procedure SetQuantity(const Value: Double);
    procedure SetRecBrightness(const Value: integer);
    procedure SetRecFont(const Value: integer);
    procedure SetRecFontHeight(const Value: integer);
    procedure SetRecLineSpacing(const Value: integer);
    procedure SetRegisterNumber(const Value: integer);
    procedure SetScale(const Value: Double);
    procedure SetScaleVB(const Value: Double);
    procedure SetSecond(const Value: word);
    procedure SetSlipDocCopyCountHorz(const Value: integer);
    procedure SetSlipDocCopyCountVert(const Value: integer);
    procedure SetSlipDocCopyShiftHorz(const Value: integer);
    procedure SetSlipDocCopyShiftVert(const Value: integer);
    procedure SetSlipDocLeftMargin(const Value: integer);
    procedure SetSlipDocOrientation(const Value: integer);
    procedure SetSlipDocTopMargin(const Value: integer);
    procedure SetSlotNumber(const Value: integer);
    procedure SetStreamFormat(const Value: integer);
    procedure SetKKMSumm(const Value: Double);
    function GetKKMSumm: Double;
    procedure SetTaxTypeNumber(const Value: integer);
    procedure SetTestMode(const Value: boolean);
    procedure SetTextWrap(const Value: integer);
    procedure SetTypeClose(const Value: TTypeClose);
    procedure SetUmode(const Value: TDeviceMode);
    procedure SetUmodel(const Value: integer);
    procedure SetUseAccessPassword(const Value: boolean);
    procedure SetWidth(const Value: integer);
    procedure SetWriteLogFile(const Value: word);
    procedure SetYear(const Value: word);
    procedure SetDisableParamWindow(const Value: boolean);
    procedure SetDisablePasswordSettings(const Value: boolean);
    procedure SetLockDevices(const Value: boolean);
    procedure SetShowProgress(const Value: boolean);
    procedure SetKKMMode(Value: TKKMMode);
    function GetKKMMode: TKKMMode;
    function GetAccessPassword: string;
    function GetAdvancedMode: integer;
    function GetAdvancedRegistration: boolean;
    function GetAlignment: integer;
    function GetApplicationHandle: THandle;
    function GetAutoSize: boolean;
    function GetBadParam: integer;
    function GetBadParamDescription: string;
    function GetBarcode: string;
    function GetBarcodeType: integer;
    function GetBatteryLow: boolean;
    function GetBaudRate: integer;
    function GetBufferingMode: boolean;
    function GetChange: Double;
    function GetCharLineLength: integer;
    function GetCheckNumber: integer;
    function GetCheckPaperPresent: boolean;
    function GetCheckState: TKKMCheckState;
    function GetCheckType: TCheckType;
    function GetControlPaperPresent: boolean;
    function GetCount: integer;
    function GetCounterType: integer;
    function GetCoverOpened: boolean;
    function GetCurrentDeviceIndex: integer;
    function GetCurrentDeviceName: string;
    function GetCurrentDeviceNumber: integer;
    function GetDay: word;
    function GetDefaultPassword: string;
    function GetDepartment: integer;
    function GetDestination: integer;
    function GetDeviceCount: integer;
    function GetCheckMode:integer;
    function GetDeviceEnabled: boolean;
    function GetDeviceDescription: string;
    function GetDeviceSettings: string;
    function GetDevicesSettings: string;
    function GetDisableParamWindow: boolean;
    function GetDiscountType: integer;
    function GetDiscountTypeNumber: integer;
    function GetDiscountValue: Double;
    function GetDocNumber: integer;
    function GetDrawerOffTimeout: integer;
    function GetDrawerOnQuantity: integer;
    function GetDrawerOnTimeout: integer;
    function GetDrawerOpened: boolean;
    function GetDuration: integer;
    function GetECRError: integer;
    function GetECRErrorDescription: string;
    function GetEnableCheckSumm: boolean;
    function GetEndDay: word;
    function GetEndMonth: word;
    function GetEndSession: integer;
    function GetEndYear: word;
    function GetEntryNum: integer;
    function GetBarcodeControlCode: boolean;
    function GetFileName: string;
    function GetFiscal: boolean;
    function GetFontBold: boolean;
    function GetFontDblHeight: boolean;
    function GetFontDblWidth: boolean;
    function GetFontItalic: boolean;
    function GetFontNegative: boolean;
    function GetFontUnderline: boolean;
    function GetFrequency: integer;
    function GetHeight: integer;
    function GetHour: word;
    function GetINN: string;
    function GetIsDemo: boolean;
    function GetJrnBrightness: integer;
    function GetJrnCharLineLength: integer;
    function GetJrnFont: integer;
    function GetJrnFontHeight: integer;
    function GetJrnLineSpacing: integer;
    function GetJrnPixelLineLength: integer;
    function GetLineNumber: integer;
    function GetLockDevices: boolean;
    function GetMachineName: string;
    function GetMachineNumber: string;
    function GetMinute: word;
    function GetModel: integer;
    function GetModelCheck: boolean;
    function GetMonth: word;
    function GetName: string;
    function GetOperationType: integer;
    function GetOperatorNo: integer;
    function GetOutBoundStream: string;
    function GetOutOfPaper: boolean;
    function GetPasswordEntered: boolean;
    function GetPercents: Double;
    function GetPictureNumber: integer;
    function GetPictureState: integer;
    function GetPixelLineLength: integer;
    function GetKKMPointPosition: word;
    procedure SetKKMPointPosition(Value: word);
    function GetPortNumber: integer;
    function GetPrice: Double;
    function GetPrintBarcodeText: integer;
    function GetPrinterConnectionFailed: boolean;
    function GetPrinterCutMechanismError: boolean;
    function GetPrinterMechanismError: boolean;
    function GetPrinterOverheatError: boolean;
    function GetPrintPurpose: integer;
    function GetQuantity: Double;
    function GetRcpCharLineLength: integer;
    function GetRcpPixelLineLength: integer;
    function GetRecBrightness: integer;
    function GetRecFont: integer;
    function GetRecFontHeight: integer;
    function GetRecLineSpacing: integer;
    function GetRegisterNumber: integer;
    function GetRemainder: Double;
    function GetResultCode: integer;
    function GetResultDescription: string;
    function GetROMVersion: string;
    function GetScale: Double;
    function GetScaleVB: Double;
    function GetSecond: word;
    function GetSerialNumber: string;
    function GetServerVersion: string;
    function GetSession: integer;
    function GetSessionOpened: boolean;
    function GetShowProgress: boolean;
    function GetSlipCharLineLength: integer;
    function GetSlipDocCharLineLength: integer;
    function GetSlipDocCopyCountHorz: integer;
    function GetSlipDocCopyCountVert: integer;
    function GetSlipDocCopyShiftHorz: integer;
    function GetSlipDocCopyShiftVert: integer;
    function GetSlipDocLeftMargin: integer;
    function GetSlipDocOrientation: integer;
    function GetSlipDocTopMargin: integer;
    function GetSlipPixelLineLength: integer;
    function GetSlotNumber: integer;
    function GetStreamFormat: integer;
    function GetTaxTypeNumber: integer;
    function GetTestMode: boolean;
    function GetTextWrap: integer;
    function GetTypeClose: TTypeClose;
    function GetUmode: TDeviceMode;
    function GetUmodel: integer;
    function GetUseAccessPassword: boolean;
    function GetVersion: string;
    function GetWidth: integer;
    function GetWriteLogFile: word;
    function GetYear: word;
    procedure SetSession(const Value: integer);
    function GetKKMPassword: string;
    procedure SetKKMPassword(Value: string);
    function GetKKMCaption: string;
    procedure SetKKMCaption(Value: string);
    procedure SetKKMValue(Value: integer);
    function GetKKMValue: integer;
    procedure SetReportType(const Value: TKKMReportType);
    function GetReportType: TKKMReportType;
    function GetKKMValuePurpose: integer;
    function GetKKMIs54FZ: boolean;
    function GetEJState: integer;
    function GetKKMCharLineLength: integer;
    procedure SetKKMValuePurpose(const Value: integer);
    function GetKKMCaptionPurpose: integer;
    procedure SetKKMCaptionPurpose(const Value: integer);
    function GetOperatorName: string;
    function GetOperatorPassword: string;
    procedure SetOperatorName(const Value: string);
    procedure SetOperatorPassword(const Value: string);
    function GetDeviceEnableTimeout: integer;
    procedure SetDeviceEnableTimeout(const Value: integer);
    function GetBarcodeColumns: integer;
    function GetBarcodeOptions: integer;
    function GetBarcodeRows: integer;
    function GetCorrectionLevel: integer;
    procedure SetBarcodeColumns(const Value: integer);
    procedure SetBarcodeOptions(const Value: integer);
    procedure SetBarcodeRows(const Value: integer);
    procedure SetCorrectionLevel(const Value: integer);
    function GetTransactionType: integer;
    procedure SetTransactionType(const Value: integer);
    function GetMaxCaptionLength: integer;
    procedure SetMaxCaptionLength(const Value: integer);
    function GetFRLicense: integer;
    procedure SetFRLicense(const Value: integer);
    function GetEKLZFlags: integer;
    procedure SetEKLZFlags(const Value: integer);
    procedure SetAttrNumber(const Value: integer);
    procedure SetAttrValue(const Value: string);
    function GetAttrNumber: integer;
    function GetAttrValue: string;
    function AddDevice: integer;
    function DeleteDevice: integer;

    public
    constructor Create;
    destructor Destroy;
    function ShowProperties(): integer; // Показать Страницу Свойств
    function SetMode(): integer; // Установить режим
    function ResetMode(): integer; // Выход из режима
    function LockKeyboard(): integer;
    function UnLockKeyboard(): integer;
    function Beep(): integer;
    function Sound(): integer; // Нужно задать Duration и Frequency
    function DisplayDraw: integer;
    // Нужно задать Caption. Вывод информации (посегментно) на дисплей ККМ
    function AdvancedDisplayWrite(): integer;
    // Выводит на дисплей ККМ произвольную информацию
    function RunCommand(): integer;
    function OpenDrawer(): integer; // Открыть денежный ящик
    function AdvancedOpenDrawer(): integer;
    // импульсное открытие денежного ящика
    function FullCut(): integer;
    function PartialCut(): integer;
    function GetStatus(): integer;
    function GetLastError(): integer;
    function GetCurrentMode(): integer;
    function GetRegister(): integer;
    function GetSumm(): integer; // Наличные в ДЯ. PointPosition вх / Summ вых
    function GetUnitVersion(): integer; // Получить версию
    function GetDeviceMetrics(): integer;
    function GetSupportedMode(): integer;
    function GetRange(): integer; // Получить диапазоны фискальных отчетов
    function GetLastSummary(): integer;
    // При выполнении метода в свойство Summ записывается сменный итог.
    function OpenSession(): integer;
    // Метод открывает смену на ККМ (in TestMode, Caption)
    function CashIncome(): integer;
    // Метод регистрирует внесение наличных денег в кассу (in TestMode, Summ)
    function CashOutcome(): integer;
    // Метод регистрирует выплату наличных денег из кассы (in TestMode, Summ)
    function Report(): integer; // ReportType: 0 … 11 и 22 … 37,
    function NewDocument(): integer;
    // Данные метод является сервисным и представляет собой логическое
    // сочетание нескольких кассовых операций (GetStatus(), SetMode(), CancelCheck() и т.д.).
    function OpenCheck(): integer;
    // Метод открывает чек соответствующего типа (свойство CheckType)
    function Registration(): integer; // Метод производит регистрацию продажи
    function Annulate(): integer; // Аннулирование продажи
    function Return(): integer;
    // Метод производит регистрацию возврата продажи
    function Buy(): integer; // Метод производит регистрацию покупки
    function BuyReturn(): integer;
    // Метод производит регистрацию возврата покупки
    function BuyAnnulate(): integer;
    // Метод производит регистрацию аннулирование покупки
    function Storno(): integer; // Метод производит сторнирование регистрации
    // (продажи, возврата продажи, аннулирования продажи, покупки, возврата покупки)
    function PercentsCharge(): integer;
    // Метод производит регистрацию процентной надбавки на весь чек или последнюю операцию
    function PercentsDiscount(): integer;
    // Метод производит регистрацию процентной скидки на весь чек или последнюю операцию
    function SummCharge(): integer;
    // Метод производит регистрацию надбавки суммой на весь чек или последнюю операцию
    function SummDiscount(): integer;
    // Метод производит регистрацию скидки суммой на весь чек или последнюю операцию
    function ResetChargeDiscount(): integer;
    // Метод отменяет последнюю проведенную операцию начисления скидки или надбавки любого типа
    function Payment(): integer;
    // Метод производит регистрацию платежа по чеку заданным
    // типом оплаты с подсчетом суммы сдачи и неоплаченного остатка чека
    function StornoPayment(): integer;
    // Сторнирование платежа на сумму, заданным типом оплаты
    function CancelCheck(): integer;
    // Метод производит аннулирование (отмену) всего чека.
    // При этом на чеке печатается «ЧЕК АННУЛИРОВАН»
    function CloseCheck(): integer; // Закрытие чека без подсчета суммы сдачи

    function GetLicense(): integer;
    function SetLicense(): integer;

    function Delivery(): integer;
    // Закрытие чека продажи с оплатой наличными и подсчетом суммы сдачи
    function SummTax(): integer;
    // Регистрация налога, предварительно настроенного в ККМ
    function ResetTax(): integer; // Отмена налога указанного типа
    function PrintString(): integer;
    // Метод служит для печати строки символов
    // на чековой ленте и/или контрольной ленте

    function WriteAttribute: integer;

    function PowerOff(): integer;
    // Программное выключение ККМ
    function AddField(): integer; // Метод служит для формирования строки
    // текста во внутреннем буфере драйвера с использованием различного
    // формата написания символов, для последующей печати на ККМ при помощи метода PrintField
    function PrintField(): integer;
    // При вызове метода на чековой и/или контрольной,
    // в зависимости от значения свойства PrintPurpose, ленте будет напечатан текст, заданный в свойстве Caption
    function PrintHeader(): integer;
    // Метод печатает на чеке клише, запрограммированное в ККМ
    function PrintFooter(): integer;
    // Метод печатает на чеке блок атрибутов чека, идентичный тому, который печатается в отчетах без гашения
    function BeginDocument(): integer;
    // Печать нефискального документа на принтере ПД.
    // Метод переводит драйвер в состояние буферизации данных, добавляемых методами печати строки и поля
    function EndDocument(): integer; // Печать на принтере ПД.
    // Метод передает данные из внутреннего буфера драйвера на печать в ККМ, освобождает выделенную для внутреннего буфера память и выводит драйвер из состояния буферизации записей
    function BeginFiscDocument(): integer;
    // Подкладной документ при печати на ККМ состоит из оригинала с фискальным признаком и его копий
    function PrintLastCheckCopy():integer;
    function EndFiscDocument(): integer;
    // Для ККМ ФЕЛИКС-3СК метод выводит драйвер из режима печати подкладных документов.
    // Для ККМ ПРИМ-07К метод выводит на печать подкладной документ с фискальным признаком и несколько его копий.
    function PrintBarcode(): integer;
    // Метод печатает штрихкод, задаваемоый в свойствах Barcode и BarcodeType,
    // с отступом от левого края, равным LeftMargin и выравниванием, указанным в свойстве Alignment.
    // Размеры печатаемого штрихкода задаются свойствами Height (в элементарных строках),
    // Scale (в процентах от реального размера) и AutoSize
    function PrintBitmap(): integer;
    // При выполнении метод печатает битовую строки. Формат битовой строки указывается в свойстве StreamFormat, а ее значение в свойстве OutboundStream. Растр будет печататься с отступом от левого края, равным LeftMargin и выравниванием, указанным в свойстве Alignment.
    // Размеры печатаемой битовой строки задаются свойствами Scale (в процентах от реального размера) и AutoSize.
    // Принтер (чековой / контрольной ленты), на котором нужно напечатать, задается свойством PrintPurpose
    function PrintBitmapFromFile(): integer;
    // При выполнении метод печатает картинку из указываемого файла с заданным отступом
    function GetStatusPictureArray(): integer;
    // При выполнении метод получает состояние массива картинок в памяти ККМ. При этом определяются – количество свободных байт в массиве (свойство Count), количество картинок
    // в массиве (PictureNumber) и состояние последней добавленной картинки в массиве (открыта / закрыта) – свойство PictureState
    function GetStatusPicture(): integer;
    // Метод по номеру картинки в памяти ККМ запрашивает параметры этой картинки: состояние картинки, ее ширину и высоту
    function PrintPicture(): integer;
    function BeginReport(): integer;
    function SetRecord: integer;
    function EndAdd() :integer;
    // Метод печатает картинку по номеру PictureNumber, записанную в память ККМ, с заданным выравниванием и отступом от левого края
    function ClearOutput(): integer;
    // Метод освобождает выделенную для внутреннего буфера память и выводит драйвер из состояния буферизации записей, не передавая данных из внутреннего буфера драйвера в ККМ.
    // Использование метода позволяет «отменить» начатое методами BeginAdd и BeginDocument добавление данных в ККМ.
    { Программирование ККМ }
    function SetPassword(): integer;
    // Метод устанавливает пароль доступа к ККМ. Пароль доступа к ККМ задается свойством Password.
    // После успешного выполнения метода значение свойства AccessPassword меняется на установленное
    function GetPassword(): integer;
    // Метод записывает в свойство Password пароль доступа к ККМ из таблицы настроек ККМ
    function SetCaption(): integer; // Строковые параметры ККМ (приложение 9)
    // Метод используется для программирования текстовых системных параметров ККМ. Программируемое значение задается в свойстве Caption, номер параметра – в свойстве CaptionPurpose,
    Function Fiscalization(): integer;
    Function ResetSummary(): integer;
    // максимально возможная длина строки – в свойстве MaxCaptionLength (даже в случае, если при выполнении метода произошла ошибка)
    function GetCaption(): integer;
    // Метод используется для получения значений текстовых системных параметров ККМ, номер параметра задается в свойстве CaptionPurpose.
    function SetValue(): integer; // Числовые параметры ККМ (приложение 10)
    // Метод используется для программирования числовых (не строковых) системных настроек ККМ. Значение задается в свойстве Value, номер настройки – в свойстве ValuePurpose
    function GetValue(): integer;
    // Метод используется для получения значений числовых (не строковых) системных настроек ККМ. Номер настройки задается в свойстве ValuePurpose.
    // В случае успешного завершения метода значение настройки сохраняется в свойстве Value
    function SetSettings(): integer;
    // Метод используется для записи данных в указанную ячейку любой системной таблицы ККМ.
    // Структура таблиц описана в руководстве оператора и в протоколе работы ККМ, входящими в комплект поставки ККМ
    function GetSettings(): integer;
    // Метод используется для получения содержимого указанной ячейки из любой системной таблицы ККМ.
    // Структура таблиц описана в руководстве оператора и в протоколе работы ККМ, входящими в комплект поставки ККМ
    function SetDate(): integer;
    // Метод устанавливает системную дату в ККМ. Если вводимая дата больше, чем на один день, текущей даты,
    // то ККМ требует подтверждения ввода даты – необходимо второй раз вызвать метод.
    function SetTime(): integer; // Метод устанавливает системное время в ККМ
    function SetPointPosition(): integer;
    // Метод устанавливает положение десятичной точки в ККМ. Новое положение точки (количество разрядов после (справа от) десятичной точки) задается в свойстве PointPosition.
    // Выполнение метода допустимо только после проведения общего гашения ККМ
    function DeviceEnableEx(): integer;
    // Метод позволяет организовать очередь печати на ККМ.
    // Поведение драйвера при вызове метода регулируется единственным свойством DeviceEnableTimeout.
    function EKLZGetStatus: integer;
    function GetRecord: integer;
    function EndReport: integer;
    function TestDevice: integer;
    function DemoPrint:integer;
    function print(caption: string; textwrap:TTextWrapMode; alignment: integer): integer;
  published
    //СтатусЭЖ
    property EJState: integer read GetEJState;
    //ЕстьПоддержка54ФЗ
    property Is54FZ: boolean read GetKKMIs54FZ;
    // Значение регистра чисел RW
    property ValuePurpose: integer read GetKKMValuePurpose
      write SetKKMValuePurpose;

    // Значение регистра строк RW
    property CaptionPurpose: integer read GetKKMCaptionPurpose
      write SetKKMCaptionPurpose;

    property EKLZFlags: integer read GetEKLZFlags write SetEKLZFlags;
    // –0 – 1
    // 0 – продажа
    // 2 – возврат продажи

    // 2
    // 0 – архив закрыт
    // 1 – архив открыт

    // 3
    // 0 – ЭКЛЗ не активизировано
    // 1 – ЭКЛЗ активизировано

    // 4
    // 0 – нет отчета
    // 1 – отчет снимается

    // 5
    // 0 – документ закрыт
    // 1 – документ открыт

    // 6
    // 0 – смена закрыта
    // 1 – смена открыта

    // 7
    // 0 – нет неисправимой ошибки устройства
    // 1 – есть неисправимая ошибка устройства

    // Окно свойств драйвера
    property DisablePasswordSettings: boolean read GetDisablePasswordSettings
      write SetDisablePasswordSettings; // ЗапретИзмененияПароля RW
    property LockDevices: boolean read GetLockDevices write SetLockDevices;
    // БлокироватьУстройства RW
    property DisableParamWindow: boolean read GetDisableParamWindow
      write SetDisableParamWindow; // ЗапретОкнаПараметров RW

    property ShowProgress: boolean read GetShowProgress write SetShowProgress;
    // Признак показа прогресса RW
    property Mode: TKKMMode read GetKKMMode write SetKKMMode;
    // режим работы RW
    property Password: string read GetKKMPassword write SetKKMPassword;
    // Пароль входа в режим RW
    property Barcode: string read GetBarcode write SetBarcode;
    // Символьный эквивалент штрихкода RW

    property License: integer read GetFRLicense write SetFRLicense;
    // Номер лицензии

    property ReportType: TKKMReportType read FReportType write SetReportType;
    // Для метода AddField
    property FontBold: boolean read GetFontBold write SetFontBold;
    // Шрифт двойной толщины RW
    property FontItalic: boolean read GetFontItalic write SetFontItalic;
    // Шрифт курсивом RW
    property FontNegative: boolean read GetFontNegative write SetFontNegative;
    // Фон символов RW
    property FontUnderline: boolean read GetFontUnderline
      write SetFontUnderline; // Подчеркнутый шрифт RW
    property FontDblHeight: boolean read GetFontDblHeight
      write SetFontDblHeight; // Шрифт двойной высоты RW
    property FontDblWidth: boolean read GetFontDblWidth write SetFontDblWidth;
    // Шрифт двойной ширины RW

    property MaxCaptionLength: integer read GetMaxCaptionLength
      write SetMaxCaptionLength;

    property PrintPurpose: integer read GetPrintPurpose write SetPrintPurpose;
    // Назначение печати: RW
    // 1 – печать на ЧЛ;
    // 2 – печать на КЛ;
    // 3 – печать на ЧЛ и КЛ

    property PictureState: integer read GetPictureState;
    // Состояние последней картинки в памяти ККМ: R
    // 0 – закрыта;
    // 1 – открыта

    // Номер атрибута
    property AttrNumber: integer read GetAttrNumber write SetAttrNumber;
    property AttrValue: string read GetAttrValue write SetAttrValue;

    property PictureNumber: integer read GetPictureNumber
      write SetPictureNumber;
    // Количество картинок в памяти ККМ: 1 ... 255 RW

    property FileName: string read GetFileName write SetFileName;
    // Имя файла картинки RW

    property Width: integer read GetWidth write SetWidth;
    // Ширина картинки: 1 ... 65535 RW
    property Height: integer read GetHeight write SetHeight;
    // Высота изображения: 1 … 65535 RW
    property PrintBarcodeText: integer read GetPrintBarcodeText
      write SetPrintBarcodeText;
    // Печатать символьный эквивалент штрихкода:
    // 0 – не печатать;
    // 1 – печатать над ШК;
    // 2 – печатать под ШК;
    // 3 – печатать над/под ШК

    property BarcodeControlCode: boolean read GetBarcodeControlCode
      write SetBarcodeControlCode;
    // Признак использования контрольного символа RW

    property BarcodeType: integer read GetBarcodeType write SetBarcodeType;
    // Тип штрихкода: RW
    // 0 – UPC-A;
    // 1 – CODE39;
    // 2 – (E/J)AN13;
    // 3 – (E/J)AN8;
    // 4 – UPC-E;
    // 5 –ITF;
    // 6 – CODEBAR;
    // 7 –CODE93;
    // 8 – CODE128;
    // 10 – PDF 417;
    // 20 – CODE32;
    // 82 – EAN 128 CC-A/B;
    // 83 – EAN 128 CC-C
    // 84 - QR

    property CorrectionLevel: integer read GetCorrectionLevel
      write SetCorrectionLevel;
    // Уровень коррекции ошибок ШК
    property BarcodeOptions: integer read GetBarcodeOptions
      write SetBarcodeOptions;
    // Параметры ШК
    property BarcodeColumns: integer read GetBarcodeColumns
      write SetBarcodeColumns;

    property BarcodeRows: integer read GetBarcodeRows write SetBarcodeRows;

    property Scale: Double read GetScale write SetScale;
    // Масштаб изображения RW
    property ScaleVB: Double read GetScaleVB write SetScaleVB;
    // Масштаб изображения RW
    property AutoSize: boolean read GetAutoSize write SetAutoSize;
    // Авторазмер RW

    property Frequency: integer read GetFrequency write SetFrequency;
    // Частота в Гц 100..2500 RW
    property Duration: integer read GetDuration write SetDuration;
    // Длительность мс 10..2550 кратное 10 RW

    property Alignment: integer read GetAlignment write SetAlignment;
    // Выравнивание: 0 – по левому краю; 1 – по центру; 2 – по правому краю RW
    property EntryNum: integer read GetEntryNum write SetEntryNum;
    // Номер реквизита RW
    property Caption: string read GetKKMCaption write SetKKMCaption;
    // Строка 24 симв макс RW
    property LineNumber: integer read GetLineNumber write SetLineNumber;
    // Номер строки 1..2
    property Percents: Double read GetPercents write SetPercents;
    // Процент надбавки: 0,01 … 100,00 RW
    property Destination: integer read GetDestination write SetDestination;
    // Область действия надбавки: 0 – на чек; 1 – на позицию RW

    property StreamFormat: integer read GetStreamFormat write SetStreamFormat;
    property OutboundStream: string read GetOutBoundStream
      write SetOutBoundStream;
    // Выходной поток данных
    property InboundStream: string read GetInboundStream write SetInboundStream;
    // Входной поток данных

    property DeviceEnableTimeout: integer read GetDeviceEnableTimeout
      write SetDeviceEnableTimeout;
    // Время ожидания в очереди (мсек)
    // Если DeviceEnableTimeout=0, то метод включает DeviceEnabled.
    // Если DeviceEnableTimeout>0, то драйвер ожидает указанное время. Если по истечении указанного времени ККМ не освободилась, чек распечатан не будет, и драйвер сообщит, что устройство недоступно.
    // Если DeviceEnableTimeout=-1, то драйвер ожидает освобождения ККМ без ограничения времени.

    property Umode:           TDeviceMode read GetUmode write SetUmode;
    property EnableCheckSumm: boolean read GetEnableCheckSumm
      write SetEnableCheckSumm; // Проверять наличность RW

    property SlipDocCopyCountHorz: integer read GetSlipDocCopyCountHorz
      write SetSlipDocCopyCountHorz;
    // Количество копий по горизонтали подкладного документа: 0…9 RW
    property SlipDocCopyCountVert: integer read GetSlipDocCopyCountVert
      write SetSlipDocCopyCountVert;
    // Количество копий по вертикали подкладного документа: 0…9 RW
    property SlipDocCopyShiftHorz: integer read GetSlipDocCopyShiftHorz
      write SetSlipDocCopyShiftHorz;
    // Смещение копий по горизонтали подкладного документа: 0…99 RW
    property SlipDocCopyShiftVert: integer read GetSlipDocCopyShiftVert
      write SetSlipDocCopyShiftVert;
    // Смещение копий по вертикали подкладного документа: 0…99 RW

    property RegisterNumber: integer read GetRegisterNumber
      write SetRegisterNumber;
    // Номер регистра: 1 … 36 RW   (стр 64-66) RW
    property CheckType: TCheckType read GetCheckType write SetCheckType;
    // Тип чека: RW
    // 1 – продажа;
    // 2 – возврат продажи;
    // 3 – аннулирование продажи;
    // 4 – покупка;
    // 5 – возврат покупки;
    // 6 – аннулирование покупки
    property TypeClose: TTypeClose read GetTypeClose write SetTypeClose;
    // Тип закрытия чека: RW
    // 0 - наличными;
    // 1 - тип оплаты 1;
    // 2 - тип оплаты 2;
    // 3 - тип оплаты 3;
    // 4 - тип оплаты 4;
    // 5 - тип оплаты 5
    property OperationType: integer read GetOperationType
      write SetOperationType;
    // Тип операции: 0 – продажа; 1 – покупка RW
    property CounterType: integer read GetCounterType write SetCounterType;
    // Тип счетчика: 1 – несбрасываемый; 2 – сбрасываемый RW
    property TaxTypeNumber: integer read GetTaxTypeNumber
      write SetTaxTypeNumber; // Номер налоговой ставки: 1 ... 5 RW
    property DiscountTypeNumber: integer read GetDiscountTypeNumber
      write SetDiscountTypeNumber; // Номер скидки: 0 ... 16 RW

    property OutOfPaper: boolean read GetOutOfPaper;
    // Признак отсутствия бумаги R
    property PrinterConnectionFailed: boolean read GetPrinterConnectionFailed;
    // Признак отсутствия связи с принтером чеков R
    property PrinterMechanismError: boolean read GetPrinterMechanismError;
    // Признак ошибки печатающего устройства R
    property PrinterCutMechanismError: boolean read GetPrinterCutMechanismError;
    // Ошибка отрезчика R
    property PrinterOverheatError: boolean read GetPrinterOverheatError;
    // Перегрев печатающей головки R

    property DrawerOnTimeout: integer read GetDrawerOnTimeout
      write SetDrawerOnTimeout;
    // Включения денежного ящика, в 10 мсек: 0 … 9999 RW
    property DrawerOffTimeout: integer read GetDrawerOffTimeout
      write SetDrawerOffTimeout;
    // Выключения денежного ящика, в 10 мсек: 0 … 9999 RW
    property DrawerOnQuantity: integer read GetDrawerOnQuantity
      write SetDrawerOnQuantity;
    // Количество импульсов для открытия денежного ящика: 0 … 99 RW
    property OperatorName: string read GetOperatorName write SetOperatorName;
    // Имя кассира RW
    property OperatorPassword: string read GetOperatorPassword
      write SetOperatorPassword;
    // Пароль кассира RW
    property OperatorNo: integer read GetOperatorNo write SetOperatorNo;
    // Номер кассира RW
    property Fiscal: boolean read GetFiscal;
    // Признак фискализированности ККМ R
    property Hour: word read GetHour write SetHour; // Текущий час RW 0..23 RW
    property Minute: word read GetMinute write SetMinute;
    // Текущая минута 1..59 RW
    property Second: word read GetSecond write SetSecond;
    // Текущая секунда 1..59 RW
    property Day:   word read GetDay write SetDay; // Текущий день 1..31 RW
    property Month: word read GetMonth write SetMonth;
    // Текущий месяц 1..12 RW
    property Year: word read GetYear write SetYear;
    // Текущий год 1998..2089 RW
    property EndDay: word read GetEndDay write SetEndDay;
    // День последней записи ФП: 1 … 31 RW
    property EndMonth: word read GetEndMonth write SetEndMonth;
    // Месяц последней записи ФП: 1 … 12 RW
    property EndYear: word read GetEndYear write SetEndYear;
    // Год последней записи ФП: 1998 … 2089 RW
    property EndSession: integer read GetEndSession write SetEndSession;
    // Номер смены последней записи ФП: 0000…2000 RW

    property SerialNumber: string read GetSerialNumber;
    // Серийный номер ККМ: строка до 8 символов RW
    property INN: string read GetINN;
    // Идентификационный номер налогоплательщика: 000000000000 … 999999999999 RW
    property ROMVersion: string read GetROMVersion;
    // Версия ПО ККМ R
    property AdvancedMode: integer read GetAdvancedMode write SetAdvancedMode;
    // Подрежим ККМ RW
    property SlotNumber: integer read GetSlotNumber write SetSlotNumber;
    // Номер слота 1..3 RW
    property DrawerOpened: boolean read GetDrawerOpened;
    // Признак открытости денежного ящика R
    property SessionOpened: boolean read GetSessionOpened;
    // Признак открытости смены R
    property CheckPaperPresent: boolean read GetCheckPaperPresent;
    // Признак наличия бумаги в принтере чеков R
    property ControlPaperPresent: boolean read GetControlPaperPresent;
    // Признак наличия бумаги в принтере контрольной ленты R
    property CoverOpened: boolean read GetCoverOpened;
    // Признак открытости крышки R
    property PasswordEntered: boolean read GetPasswordEntered;
    // Признак «введенности» пароля R
    property Umodel: integer read GetUmodel write SetUmodel; // Модель ККМ RW
    property CheckNumber: integer read GetCheckNumber write SetCheckNumber;
    // Номер текущего чека: 0000…9999 RW
    property Session: integer read GetSession write SetSession;
    // Номер смены: 0000…2000 R
    property CheckState: TKKMCheckState read GetCheckState;
    // Текущее состояние чека R
    // 0 – закрыт;
    // 1 – открыт чек продажи;
    // 2 – открыт чек возврата продажи;
    // 3 – открыт чек аннулирования продажи;
    // 4 – открыт чек покупки;
    // 5 – открыт чек возврата покупки
    property Summ: Double read GetKKMSumm write SetKKMSumm;
    // Сумма чека: 0.00 … 99999999.99 RW
    property TextWrap: integer read GetTextWrap write SetTextWrap;
    // Перенос текста: 0 - нет переноса. 1 - по словам. 2 - по строке RW
    property Count: integer read GetCount write SetCount;
    // Количество строк: 1 ... 65535 R
    property TransactionType: integer read GetTransactionType
      write SetTransactionType;
    // ТипТранзакции
    // Свойство содержит номер транзакции, характеризующий данные, полученные методом GetRecord.
    // 1
    // Продажа по свободной цене
    // Summ – сумма продажи;
    // Department – секция, в которую зарегистрирована операция
    // 2
    // Сторно по свободной цене
    // Summ – сумма сторно;
    // Department – секция, в которую зарегистрирована операция
    // 3
    // Аннулирование по свободной цене.
    // Summ – сумма аннулированния
    // 4
    // Возврат по свободной цене.
    // Summ – сумма возврата
    // 5
    // Абсолютная скидка на операцию.
    // Summ – сумма скидки
    // 6
    // Абсолютная надбавка на операцию.
    // Summ – сумма надбавки
    // 7
    // Процентная скидка на операцию.
    // Percents – размер скидки в процентах
    // 8
    // Процентная надбавка на операцию
    // Percents – размер надбавки в процентах
    // 11
    // Продажа по внутреннему коду товара.
    // PLUNumber – код товара;
    // Quantity – проданное количество
    // 12
    // Сторно по внутреннему коду.
    // PLUNumber – код товара;
    // Quantity – сторнированное количество
    // 13
    // Аннулирование по внутреннему коду.
    // PLUNumber – код товара;
    // Quantity – аннулированное количество
    // 14
    // Возврат по внутреннему коду.
    // PLUNumber – код товара;
    // Quantity – возвращенное количество
    // 21
    // Продажа по внешнему коду товара.
    // Summ – сумма продажи;
    // Department – секция, в которую зарегистрирована операция
    // 22
    // Сторно по внешнему коду товара.
    // Summ – сумма продажи;
    // Department – секция, в которую зарегистрирована операция
    // 23
    // Аннулирование по внешнему коду товара.
    // Summ – сумма аннулированния
    // 24
    // Возврат по внешнему коду товара.
    // Summ – сумма возврата
    // 35
    // Абсолютная скидка на весь чек.
    // Summ – сумма скидки
    // 36
    // Абсолютная надбавка на весь чек.
    // Summ – сумма надбавки
    // 37
    // Процентная скидка на весь чек.
    // Percents – размер скидки в процентах
    // 38
    // Процентная надбавка на весь чек.
    // Percents – размер надбавки в процентах
    // 42
    // Оплата наличными
    // 44
    // Оплата типом 1 (КРЕДИТОМ)
    // 47
    // Оплата типом 2 (ТАРОЙ)
    // 48
    // Оплата типом 3 (ПЛ. КАРТОЙ)
    // 50
    // Внесение денег в кассу.
    // Summ – внесенная сумма
    // 51
    // Выплата денег из кассы.
    // Summ – выплаченная сумма
    //
    // 55
    // Конец чека.
    // Day, Month, Year, Hour, Minute – дата и время закрытия чека;
    // Operator – номер кассира, закрывшего чек

    property ECRError: integer read GetECRError;
    // Код последней ошибки R
    property ECRErrorDescription: string read GetECRErrorDescription;
    // Описание последней ошибки R
    property BatteryLow: boolean read GetBatteryLow;
    // Признак разряженности аккумулятора ККМ R
    property BufferingMode: boolean read GetBufferingMode
      write SetBufferingMode;
    // Признак нахождения в режиме буферизации документа RW
    property Value: integer read GetKKMValue write SetKKMValue;
    // Значения регистров 33-35 RW
    property DocNumber: integer read GetDocNumber;
    // Номер документа: 0 … 99999999 R
    property Remainder: Double read GetRemainder;
    // Остаток в чеке: 0.00 … 99999999.99 R
    property Change: Double read GetChange;
    // Сумма сдачи: 0.00 … 99999999.99 R
    property MachineNumber: string read GetMachineNumber write SetMachineNumber;
    // Регистрационный номер машины: строка цифр длиной не более 10 символов RW
    property name:     string read GetName write Setname; // Название товара RW
    property Quantity: Double read GetQuantity write SetQuantity;
    // Количество товара: 0.000 ... 9999999.999 RW
    property Price: Double read GetPrice write SetPrice;
    // Цена товара: 0.00 ... 99999999.99 RW
    property Department: integer read GetDepartment write SetDepartment;
    // Секция RW
    property AdvancedRegistration: boolean read GetAdvancedRegistration
      write SetAdvancedRegistration; // Расширенная регистрация RW
    property RecFont: integer read GetRecFont write SetRecFont;
    // Шрифт на ЧЛ: RW
    // 0 - настроенный в ККМ;
    // 1 - 8х6;
    // 2 - 7х6;
    // 3 - 6х6;
    // 4 - 5х6
    property RecFontHeight: integer read GetRecFontHeight
      write SetRecFontHeight; // Высота текста на ЧЛ:
    // 0 - настроенная в ККМ;
    // 1 - растянутый по высоте шрифт;
    // 2 - не используется;
    // 3 - шрифт единичной высоты
    property RecBrightness: integer read GetRecBrightness
      write SetRecBrightness; // Яркость текста на ЧЛ: 0 … 15 RW
    property RecLineSpacing: integer read GetRecLineSpacing
      write SetRecLineSpacing;
    // Межстрочный интервал на ЧЛ: -19 ... 255 RW
    property JrnFont: integer read GetJrnFont write SetJrnFont;
    // Шрифт на КЛ:  RW
    // 0 - настроенный в ККМ;
    // 1 - 8х6;
    // 2 - 7х6;
    // 3 - 6х6;
    // 4 - 5х6
    property JrnFontHeight: integer read GetJrnFontHeight
      write SetJrnFontHeight; // Высота текста на КЛ: RW
    // 0 - настроенная в ККМ;
    // 1 - растянутый по высоте шрифт;
    // 2 - не используется;
    // 3 - шрифт единичной высоты
    property JrnBrightness: integer read GetJrnBrightness
      write SetJrnBrightness; // Яркость текста на КЛ: 0 … 15 RW
    property JrnLineSpacing: integer read GetJrnLineSpacing
      write SetJrnLineSpacing;
    // Межстрочный интервал на КЛ: -19 ... 255 RW
    property DiscountType: integer read GetDiscountType write SetDiscountType;
    // Тип применяемой скидки (надбавки) 0 — денежная скидка(надбавка); 1 — процентная скидка(надбавка). RW
    property DiscountValue: Double read GetDiscountValue write SetDiscountValue;
    // Размер применяемой скидки (надбавки) RW
    property ResultCode:        integer read GetResultCode; // Результат R
    property ResultDescription: string read GetResultDescription;
    // Сообщение результата R
    property BadParam: integer read GetBadParam;
    // Ошибка параметра R
    property BadParamDescription: string read GetBadParamDescription;
    // Сообщение ошибки параметра R
    property TestMode: boolean read GetTestMode write SetTestMode;
    // Тестовый режим RW
    property PointPosition: word read GetKKMPointPosition
      write SetKKMPointPosition;
    // Положение десятичной точки 0..3 RW
    property ModelCheck: boolean read GetModelCheck write SetModelCheck;
    // Проверять модель ККМ RW
    property CharLineLength: integer read GetCharLineLength;
    // Длина строки символов на текущей станции R
    property PixelLineLength: integer read GetPixelLineLength;
    // Длина строки в точках на текущей станции R
    property RcpCharLineLength: integer read GetRcpCharLineLength;
    // Длина строки символов на ЧЛ: в зависимости от модели ККМ R
    property RcpPixelLineLength: integer read GetRcpPixelLineLength;
    // Длина строки в точках на ЧЛ: в зависимости от модели ККМ R
    property JrnCharLineLength: integer read GetJrnCharLineLength;
    // Длина строки символов на КЛ: в зависимости от модели ККМ R
    property JrnPixelLineLength: integer read GetJrnPixelLineLength;
    // Длина строки в точках на КЛ: в зависимости от модели ККМ R
    property SlipCharLineLength: integer read GetSlipCharLineLength;
    // Длина строки символов на ПД: в зависимости от модели ККМ R
    property SlipPixelLineLength: integer read GetSlipPixelLineLength;
    // Длина строки в точках на ПД: в зависимости от модели ККМ R
    property SlipDocCharLineLength: integer read GetSlipDocCharLineLength;
    // Ширина подкладного документа, в символах: 0…99 RW
    property SlipDocTopMargin: integer read GetSlipDocTopMargin
      write SetSlipDocTopMargin;
    // Верхний отступ подкладного документа: 0…99 RW
    property SlipDocLeftMargin: integer read GetSlipDocLeftMargin
      write SetSlipDocLeftMargin;
    // Левый отступ подкладного документа: 0…99 RW
    property SlipDocOrientation: integer read GetSlipDocOrientation
      write SetSlipDocOrientation;
    // Ориентация подкладного документа: RW
    // 0 – нормальная;
    // 1 – повернутая на 180
    property Version: string read GetVersion;
    // Версия драйвера R
    property ServerVersion: string read GetServerVersion;
    // Версия сервера R
    property ApplicationHandle: THandle read GetApplicationHandle
      write SetApplicationHandle;
    // Дескриптор главного окна клиентского приложения RW
    property DeviceDescription: string read GetDeviceDescription;
    // Название драйвера R
    property IsDemo: boolean read GetIsDemo;
    // Флаг работы в демонстрационном режиме R
    property CurrentDeviceIndex: integer read GetCurrentDeviceIndex
      write SetCurrentDeviceIndex; // Индекс текущего ЛУ: 0 … 98 RW
    property CurrentDeviceNumber: integer read GetCurrentDeviceNumber
      write SetCurrentDeviceNumber; // Номер текущего ЛУ: 1 … 99 RW
    property DeviceEnabled: boolean read GetDeviceEnabled
      write SetDeviceEnabled; // Флаг «Устройство включено» RW
    property MachineName: string read GetMachineName write SetMachineName;
    // Имя ПК в сети RW
    property PortNumber: integer read GetPortNumber write SetPortNumber;
    // Номер порта ПК: 1001 – COM1 … 1256 – COM256 RW
    property BaudRate: integer read GetBaudRate write SetBaudRate;
    // Скорость обмена с ПК: RW
    // 3 – 1200;
    // 4 – 2400;
    // 5 – 4800;
    // 7 – 9600;
    // 9 – 14400;
    // 10 – 19200;
    // 12 – 38400;
    // 14 – 57600;
    // 18 – 115200
    property Model: integer read GetModel write SetModel; // Модель ККМ RW
    property AccessPassword: string read GetAccessPassword
      write SetAccessPassword;
    // Пароль доступа к ККМ: строка цифр длиной не более 8 RW
    property UseAccessPassword: boolean read GetUseAccessPassword
      write SetUseAccessPassword;
    // Использовать пароль доступа к ККМ RW
    property DefaultPassword: string read GetDefaultPassword
      write SetDefaultPassword;
    // Пароль оператора ККМ, используемый по умолчанию RW
    property WriteLogFile: word read GetWriteLogFile write SetWriteLogFile;
    // Расширенный журнал: RW
    // 0 – в журнал попадает только базовая информация;
    // 1 – добавляет в журнал дополнительные сведения о работе протокола нижнего уровня
    property DevicesSettings: string read GetDevicesSettings
      write SetDevicesSettings;
    // Параметры логических устройств в виде строки RW
    property DeviceSettings: string read GetDeviceSettings
      write SetDeviceSettings;
    // Параметры логического устройства в виде строки RW
    property CurrentDeviceName: string read GetCurrentDeviceName
      write SetCurrentDeviceName; // Название ЛУ RW
    property DeviceCount: integer read GetDeviceCount;
    // Количество ЛУ: 1 … 99 R
  end;

implementation

{ TKKMDriver }

function TKKMDriver.AddField: integer;
begin
  Result := FDevice.AddField;
end;

function TKKMDriver.AdvancedDisplayWrite: integer;
begin
  Result := FDevice.AdvancedDisplayWrite;
end;

function TKKMDriver.AdvancedOpenDrawer: integer;
begin
  Result := FDevice.AdvancedOpenDrawer;
end;

function TKKMDriver.Annulate: integer;
begin
  Result := FDevice.Annulate;
end;

function TKKMDriver.Beep: integer;
begin
  Result := FDevice.Beep;
end;

function TKKMDriver.BeginDocument: integer;
begin
  Result := FDevice.BeginDocument;
end;

function TKKMDriver.BeginFiscDocument: integer;
begin
  Result := FDevice.BeginFiscDocument;
end;

function TKKMDriver.Buy: integer;
begin
  Result := FDevice.Buy;
end;

function TKKMDriver.BuyAnnulate: integer;
begin
  Result := FDevice.BuyAnnulate;
end;

function TKKMDriver.BuyReturn: integer;
begin
  Result := FDevice.BuyReturn;
end;

function TKKMDriver.CancelCheck: integer;
begin
  Result := FDevice.CancelCheck;
end;

function TKKMDriver.CashIncome: integer;
begin
  Result := FDevice.CashIncome;
end;

function TKKMDriver.CashOutcome: integer;
begin
  Result := FDevice.CashOutcome;
end;

function TKKMDriver.ClearOutput: integer;
begin
  Result := FDevice.ClearOutput;
end;

function TKKMDriver.CloseCheck: integer;
begin
  Result := FDevice.CloseCheck;
end;

constructor TKKMDriver.Create;
begin
  CoInitialize(nil);
  inherited Create;
  if VarIsEmpty(FDevice) then
    try
      FDevice := CreateOLEObject('AddIn.FprnM45');
      FDevice.ENQTimeout := 60000; // Таймаут ожидания ответа драйвера 60сек
    except
      on E: exception do
        raise exception.Create('Ошибка создания объекта драйвера Атол: ' + E.Message +
        '. Возможно не установлен драйвер Атол.');
    end;
end;

function TKKMDriver.Delivery: integer;
begin
  Result := FDevice.Delivery;
end;

destructor TKKMDriver.Destroy;
begin
  if not VarIsEmpty(FDevice) then
    FDevice := 0;
  inherited Destroy;
  CoUninitialize;
end;

function TKKMDriver.DeviceEnableEx: integer;
begin
  Result := FDevice.DeviceEnableEx;
end;

function TKKMDriver.DisplayDraw: integer;
begin
  Result := FDevice.DisplayDraw;
end;

function TKKMDriver.EKLZGetStatus: integer;
begin
  Result := FDevice.EKLZGetStatus;
end;

function TKKMDriver.EndReport: integer;
begin
  Result := FDevice.EndReport;
end;

function TKKMDriver.TestDevice: integer;
begin
  Result := FDevice.TestDevice;
end;

function TKKMDriver.DemoPrint: integer;
begin
  Result := FDevice.DemoPrint;
end;


function TKKMDriver.GetRecord: integer;
begin
  Result := FDevice.GetRecord;
end;

function TKKMDriver.EndDocument: integer;
begin
  Result := FDevice.EndDocument;
end;

function TKKMDriver.EndFiscDocument: integer;
begin
  Result := FDevice.EndFiscDocument;
end;

function TKKMDriver.PrintLastCheckCopy: integer;
begin
  Result := FDevice.PrintLastCheckCopy;
end;

function TKKMDriver.FullCut: integer;
begin
  Result := FDevice.FullCut;
end;

function TKKMDriver.GetAccessPassword: string;
begin
  Result := FDevice.AccessPassword;
end;

function TKKMDriver.GetAdvancedMode: integer;
begin
  Result := FDevice.AdvancedMode;
end;

function TKKMDriver.GetAdvancedRegistration: boolean;
begin
  Result := FDevice.AdvancedRegistration;
end;

function TKKMDriver.GetAlignment: integer;
begin
  Result := FDevice.Alignment;
end;

function TKKMDriver.GetApplicationHandle: THandle;
begin
  Result := FDevice.ApplicationHandle;
end;

function TKKMDriver.GetAttrNumber: integer;
begin
  Result := FDevice.AttrNumber;
end;

function TKKMDriver.GetAttrValue: string;
begin
  Result := FDevice.AttrValue;
end;

function TKKMDriver.AddDevice:integer;
begin
  Result := FDevice.AddDevice;
end;

function TKKMDriver.DeleteDevice:integer;
begin
  Result := FDevice.DeleteDevice;
end;

function TKKMDriver.Print(caption: string; textwrap:TTextWrapMode; alignment: integer): integer;
begin
  FDevice.SetKKMCaption :=  caption;
  FDevice.Settextwrap := textwrap;
  FDevice.Settextwrap := alignment;
  result := FDevice.printstring;
end;

function TKKMDriver.GetAutoSize: boolean;
begin
  Result := FDevice.AutoSize;
end;

function TKKMDriver.GetBadParam: integer;
begin
  Result := FDevice.BadParam;
end;

function TKKMDriver.GetBadParamDescription: string;
begin
  Result := FDevice.BadParamDescription;
end;

function TKKMDriver.GetBarcode: string;
begin
  Result := FDevice.Barcode;
end;

function TKKMDriver.GetBarcodeType: integer;
begin
  Result := FDevice.BarcodeType;
end;

function TKKMDriver.GetBatteryLow: boolean;
begin
  Result := FDevice.BatteryLow;
end;

function TKKMDriver.GetBaudRate: integer;
begin
  Result := FDevice.BaudRate;
end;

function TKKMDriver.GetBufferingMode: boolean;
begin
  Result := FDevice.BufferingMode;
end;

function TKKMDriver.GetCaption: integer;
begin
  Result := FDevice.GetCaption;
end;

function TKKMDriver.GetChange: Double;
begin
  Result := FDevice.Change;
end;

function TKKMDriver.GetCharLineLength: integer;
begin
  Result := FDevice.CharLineLength;
end;

function TKKMDriver.GetCheckNumber: integer;
begin
  Result := FDevice.CheckNumber;
end;

function TKKMDriver.GetCheckPaperPresent: boolean;
begin
  Result := FDevice.CheckPaperPresent;
end;

function TKKMDriver.GetCheckState: TKKMCheckState;
begin
  Result := TKKMCheckState(FDevice.CheckState);
end;

function TKKMDriver.GetCheckType: TCheckType;
begin
  Result := TCheckType(FDevice.CheckType);
end;

function TKKMDriver.GetControlPaperPresent: boolean;
begin
  Result := FDevice.ControlPaperPresent;
end;

function TKKMDriver.GetCorrectionLevel: integer;
begin
  Result := FDevice.CorrectionLevel;
end;

function TKKMDriver.GetCount: integer;
begin
  Result := FDevice.Count;
end;

function TKKMDriver.GetCounterType: integer;
begin
  Result := FDevice.CounterType;
end;

function TKKMDriver.GetCoverOpened: boolean;
begin
  Result := FDevice.CoverOpened;
end;

function TKKMDriver.GetCurrentDeviceIndex: integer;
begin
  Result := FDevice.CurrentDeviceIndex;
end;

function TKKMDriver.GetCurrentDeviceName: string;
begin
  Result := FDevice.CurrentDeviceName;
end;

function TKKMDriver.GetCurrentDeviceNumber: integer;
begin
  Result := FDevice.CurrentDeviceNumber;
end;

function TKKMDriver.GetCurrentMode: integer;
begin
  Result := FDevice.GetCurrentMode;
end;

function TKKMDriver.GetDay: word;
begin
  Result := FDevice.Day;
end;

function TKKMDriver.GetDefaultPassword: string;
begin
  Result := FDevice.DefaultPassword;
end;

function TKKMDriver.GetDepartment: integer;
begin
  Result := FDevice.Department;
end;

function TKKMDriver.GetDestination: integer;
begin
  Result := FDevice.Destination;
end;

function TKKMDriver.GetDeviceCount: integer;
begin
  Result := FDevice.DeviceCount;
end;
function TKKMDriver.GetCheckMode: integer;
begin
  Result := FDevice.CheckMode;
end;



function TKKMDriver.GetDeviceDescription: string;
begin
  Result := FDevice.DeviceDescription;
end;

function TKKMDriver.GetDeviceEnabled: boolean;
begin
  Result := FDevice.DeviceEnabled;
end;

function TKKMDriver.GetDeviceEnableTimeout: integer;
begin
  Result := FDevice.DeviceEnableTimeout;
end;

function TKKMDriver.GetDeviceMetrics: integer;
begin
  Result := FDevice.GetDeviceMetrics;
end;

function TKKMDriver.GetDeviceSettings: string;
begin
  Result := FDevice.DeviceSettings;
end;

function TKKMDriver.GetDevicesSettings: string;
begin
  Result := FDevice.DevicesSettings;
end;

function TKKMDriver.GetDisableParamWindow: boolean;
begin
  Result := FDevice.DisableParamWindow;
end;

function TKKMDriver.GetDisablePasswordSettings: boolean;
begin
  Result := FDevice.DisablePasswordSettings;
end;

function TKKMDriver.GetDiscountType: integer;
begin
  Result := FDevice.DiscountType;
end;

function TKKMDriver.GetDiscountTypeNumber: integer;
begin
  Result := FDevice.DiscountTypeNumber;
end;

function TKKMDriver.GetDiscountValue: Double;
begin
  Result := FDevice.DiscountValue;
end;

function TKKMDriver.GetDocNumber: integer;
begin
  Result := FDevice.DocNumber;
end;

function TKKMDriver.GetDrawerOffTimeout: integer;
begin
  Result := FDevice.DrawerOffTimeout;
end;

function TKKMDriver.GetDrawerOnQuantity: integer;
begin
  Result := FDevice.DrawerOnQuantity;
end;

function TKKMDriver.GetDrawerOnTimeout: integer;
begin
  Result := FDevice.DrawerOnTimeout;
end;

function TKKMDriver.GetDrawerOpened: boolean;
begin
  Result := FDevice.DrawerOpened;
end;

function TKKMDriver.GetDuration: integer;
begin
  Result := FDevice.Duration;
end;

function TKKMDriver.GetECRError: integer;
begin
  Result := FDevice.ECRError;
end;

function TKKMDriver.GetECRErrorDescription: string;
begin
  Result := FDevice.ECRErrorDescription;
end;

function TKKMDriver.GetEKLZFlags: integer;
begin
  Result := FDevice.EKLZFlags;
end;

function TKKMDriver.GetEnableCheckSumm: boolean;
begin
  Result := FDevice.EnableCheckSumm;
end;

function TKKMDriver.GetEndDay: word;
begin
  Result := FDevice.EndDay;
end;

function TKKMDriver.GetEndMonth: word;
begin
  Result := FDevice.EndMonth;
end;

function TKKMDriver.GetEndSession: integer;
begin
  Result := FDevice.EndSession;
end;

function TKKMDriver.GetEndYear: word;
begin
  Result := FDevice.EndYear;
end;

function TKKMDriver.GetEntryNum: integer;
begin
  Result := FDevice.EntryNum;
end;

function TKKMDriver.GetBarcodeColumns: integer;
begin
  Result := FDevice.BarcodeColumns;
end;

function TKKMDriver.GetBarcodeControlCode: boolean;
begin
  Result := FDevice.BarcodeControlCode;
end;

function TKKMDriver.GetBarcodeOptions: integer;
begin
  Result := FDevice.BarcodeOptions;
end;

function TKKMDriver.GetBarcodeRows: integer;
begin
  Result := FDevice.BarcodeRows;
end;

function TKKMDriver.GetFileName: string;
begin
  Result := FDevice.FileName;
end;

function TKKMDriver.GetFiscal: boolean;
begin
  Result := FDevice.Fiscal;
end;

function TKKMDriver.GetFontBold: boolean;
begin
  Result := FDevice.FontBold;
end;

function TKKMDriver.GetFontDblHeight: boolean;
begin
  Result := FDevice.FontDblHeight;
end;

function TKKMDriver.GetFontDblWidth: boolean;
begin
  Result := FDevice.FontDblWidth;
end;

function TKKMDriver.GetFontItalic: boolean;
begin
  Result := FDevice.FontItalic;
end;

function TKKMDriver.GetFontNegative: boolean;
begin
  Result := FDevice.FontNegative;
end;

function TKKMDriver.GetFontUnderline: boolean;
begin
  Result := FDevice.FontUnderline;
end;

function TKKMDriver.GetFrequency: integer;
begin
  Result := FDevice.Frequency;
end;

function TKKMDriver.GetFRLicense: integer;
begin
  Result := FDevice.License;
end;

function TKKMDriver.GetHeight: integer;
begin
  Result := FDevice.Height;
end;

function TKKMDriver.GetHour: word;
begin
  Result := FDevice.Hour;
end;

function TKKMDriver.GetInboundStream: string;
begin
  Result := FDevice.InboundStream;
end;

function TKKMDriver.GetINN: string;
begin
  Result := FDevice.INN;
end;

function TKKMDriver.GetIsDemo: boolean;
begin
  Result := FDevice.IsDemo;
end;

function TKKMDriver.GetJrnBrightness: integer;
begin
  Result := FDevice.JrnBrightness;
end;

function TKKMDriver.GetJrnCharLineLength: integer;
begin
  Result := FDevice.JrnCharLineLength;
end;

function TKKMDriver.GetJrnFont: integer;
begin
  Result := FDevice.JrnFont;
end;

function TKKMDriver.GetJrnFontHeight: integer;
begin
  Result := FDevice.JrnFontHeight;
end;

function TKKMDriver.GetJrnLineSpacing: integer;
begin
  Result := FDevice.JrnLineSpacing;
end;

function TKKMDriver.GetJrnPixelLineLength: integer;
begin
  Result := FDevice.JrnPixelLineLength;
end;

function TKKMDriver.GetKKMCaption: string;
begin
  Result := FDevice.Caption;
end;

function TKKMDriver.GetKKMCaptionPurpose: integer;
begin
  Result := FDevice.CaptionPurpose;
end;

function TKKMDriver.GetKKMMode: TKKMMode;
begin
  Result := TKKMMode(FDevice.Mode);
end;

function TKKMDriver.GetKKMPassword: string;
begin
  Result := FDevice.Password;
end;

function TKKMDriver.GetKKMSumm: Double;
begin
  Result := FDevice.Summ;
end;

function TKKMDriver.GetKKMValue: integer;
begin
  Result := FDevice.Value;
end;

function TKKMDriver.GetKKMValuePurpose: integer;
begin
  Result := FDevice.ValuePurpose;
end;

function  TKKMDriver.GetKKMCharLineLength: integer;
begin
  Result := FDevice.CharLineLength;
end;

function  TKKMDriver.GetKKMIs54FZ: boolean;
begin
  Result := FDevice.Is54FZ;
end;

function  TKKMDriver.GetEJState: integer;
begin
  FDevice.GetEJState;
  Result := FDevice.value;
end;


function TKKMDriver.GetLastError: integer;
begin
  Result := FDevice.GetLastError;
end;

function TKKMDriver.GetLastSummary: integer;
begin
  Result := FDevice.GetLastSummary;
end;

function TKKMDriver.GetLicense: integer;
begin
  Result := FDevice.GetLicense;
end;

function TKKMDriver.GetLineNumber: integer;
begin
  Result := FDevice.LineNumber;
end;

function TKKMDriver.GetLockDevices: boolean;
begin
  Result := FDevice.LockDevices;
end;

function TKKMDriver.GetMachineName: string;
begin
  Result := FDevice.MachineName;
end;

function TKKMDriver.GetMachineNumber: string;
begin
  Result := FDevice.MachineNumber;
end;

function TKKMDriver.GetMaxCaptionLength: integer;
begin
  Result := FDevice.MaxCaptionLength;
end;

function TKKMDriver.GetMinute: word;
begin
  Result := FDevice.Minute;
end;

function TKKMDriver.GetModel: integer;
begin
  Result := FDevice.Model;
end;

function TKKMDriver.GetModelCheck: boolean;
begin
  Result := FDevice.ModelCheck;
end;

function TKKMDriver.GetMonth: word;
begin
  Result := FDevice.Month;
end;

function TKKMDriver.GetName: string;
begin
  Result := FDevice.Name;
end;

function TKKMDriver.GetOperationType: integer;
begin
  Result := FDevice.OperationType;
end;

function TKKMDriver.GetOperatorName: string;
begin
  Result := FDevice.OperatorName;
end;

function TKKMDriver.GetOperatorNo: integer;
begin
  Result := FDevice.OperatorNo;
end;

function TKKMDriver.GetOperatorPassword: string;
begin
  Result := FDevice.OperatorPassword;
end;

function TKKMDriver.GetOutBoundStream: string;
begin
  Result := FDevice.OutboundStream;
end;

function TKKMDriver.GetOutOfPaper: boolean;
begin
  Result := FDevice.OutOfPaper;
end;

function TKKMDriver.GetPassword: integer;
begin
  Result := FDevice.GetPassword;
end;

function TKKMDriver.GetPasswordEntered: boolean;
begin
  Result := FDevice.PasswordEntered;
end;

function TKKMDriver.GetPercents: Double;
begin
  Result := FDevice.Percents;
end;

function TKKMDriver.GetPictureNumber: integer;
begin
  Result := FDevice.PictureNumber;
end;

function TKKMDriver.GetPictureState: integer;
begin
  Result := FDevice.PictureState;
end;

function TKKMDriver.GetPixelLineLength: integer;
begin
  Result := FDevice.PixelLineLength;
end;

function TKKMDriver.GetKKMPointPosition: word;
begin
  Result := FDevice.PointPosition;
end;

function TKKMDriver.GetPortNumber: integer;
begin
  Result := FDevice.PortNumber;
end;

function TKKMDriver.GetPrice: Double;
begin
  Result := FDevice.Price;
end;

function TKKMDriver.GetPrintBarcodeText: integer;
begin
  Result := FDevice.PrintBarcodeText;
end;

function TKKMDriver.GetPrinterConnectionFailed: boolean;
begin
  Result := FDevice.PrinterConnectionFailed;
end;

function TKKMDriver.GetPrinterCutMechanismError: boolean;
begin
  Result := FDevice.PrinterCutMechanismError;
end;

function TKKMDriver.GetPrinterMechanismError: boolean;
begin
  Result := FDevice.PrinterMechanismError;
end;

function TKKMDriver.GetPrinterOverheatError: boolean;
begin
  Result := FDevice.PrinterOverheatError;
end;

function TKKMDriver.GetPrintPurpose: integer;
begin
  Result := FDevice.PrintPurpose;
end;

function TKKMDriver.GetQuantity: Double;
begin
  Result := FDevice.Quantity;
end;

function TKKMDriver.GetRange: integer;
begin
  Result := FDevice.GetRange;
end;

function TKKMDriver.GetRcpCharLineLength: integer;
begin
  Result := FDevice.RcpCharLineLength;
end;

function TKKMDriver.GetRcpPixelLineLength: integer;
begin
  Result := FDevice.RcpPixelLineLength;
end;

function TKKMDriver.GetRecBrightness: integer;
begin
  Result := FDevice.RecBrightness;
end;

function TKKMDriver.GetRecFont: integer;
begin
  Result := FDevice.RecFont;
end;

function TKKMDriver.GetRecFontHeight: integer;
begin
  Result := FDevice.RecFontHeight;
end;

function TKKMDriver.GetRecLineSpacing: integer;
begin
  Result := FDevice.RecLineSpacing;
end;

function TKKMDriver.GetRegister: integer;
begin
  Result := FDevice.GetRegister;
end;

function TKKMDriver.GetRegisterNumber: integer;
begin
  Result := FDevice.RegisterNumber;
end;

function TKKMDriver.GetRemainder: Double;
begin
  Result := FDevice.Remainder;
end;

function TKKMDriver.GetReportType: TKKMReportType;
begin
  Result := TKKMReportType(FDevice.ReportType);
end;

function TKKMDriver.GetResultCode: integer;
begin
  Result := FDevice.ResultCode;
end;

function TKKMDriver.GetResultDescription: string;
begin
  Result := FDevice.ResultDescription;
end;

function TKKMDriver.GetROMVersion: string;
begin
  Result := FDevice.ROMVersion;
end;

function TKKMDriver.GetScale: Double;
begin
  Result := FDevice.Scale;
end;

function TKKMDriver.GetScaleVB: Double;
begin
  Result := FDevice.ScaleVB;
end;

function TKKMDriver.GetSecond: word;
begin
  Result := FDevice.Second;
end;

function TKKMDriver.GetSerialNumber: string;
begin
  Result := FDevice.SerialNumber;
end;

function TKKMDriver.GetServerVersion: string;
begin
  Result := FDevice.ServerVersion;
end;

function TKKMDriver.GetSession: integer;
begin
  Result := FDevice.Session;
end;

function TKKMDriver.GetSessionOpened: boolean;
begin
  Result := FDevice.SessionOpened;
end;

function TKKMDriver.GetSettings: integer;
begin
  Result := FDevice.GetSettings;
end;

function TKKMDriver.GetShowProgress: boolean;
begin
  Result := FDevice.ShowProgress;
end;

function TKKMDriver.GetSlipCharLineLength: integer;
begin
  Result := FDevice.SlipCharLineLength;
end;

function TKKMDriver.GetSlipDocCharLineLength: integer;
begin
  Result := FDevice.SlipDocCharLineLength;
end;

function TKKMDriver.GetSlipDocCopyCountHorz: integer;
begin
  Result := FDevice.SlipDocCopyCountHorz;
end;

function TKKMDriver.GetSlipDocCopyCountVert: integer;
begin
  Result := FDevice.SlipDocCopyCountVert;
end;

function TKKMDriver.GetSlipDocCopyShiftHorz: integer;
begin
  Result := SlipDocCopyShiftHorz;
end;

function TKKMDriver.GetSlipDocCopyShiftVert: integer;
begin
  Result := FDevice.SlipDocCopyShiftVert;
end;

function TKKMDriver.GetSlipDocLeftMargin: integer;
begin
  Result := FDevice.SlipDocLeftMargin;
end;

function TKKMDriver.GetSlipDocOrientation: integer;
begin
  Result := FDevice.SlipDocOrientation;
end;

function TKKMDriver.GetSlipDocTopMargin: integer;
begin
  Result := FDevice.SlipDocTopMargin;
end;

function TKKMDriver.GetSlipPixelLineLength: integer;
begin
  Result := FDevice.SlipPixelLineLength;
end;

function TKKMDriver.GetSlotNumber: integer;
begin
  Result := FDevice.SlotNumber;
end;

function TKKMDriver.GetStatus: integer;
begin
  Result := FDevice.GetStatus;
end;

function TKKMDriver.GetStatusPicture: integer;
begin
  Result := FDevice.GetSatusPicture;
end;

function TKKMDriver.GetStatusPictureArray: integer;
begin
  Result := FDevice.GetStatusPictureArray;
end;

function TKKMDriver.GetStreamFormat: integer;
begin
  Result := FDevice.StreamFormat;
end;

function TKKMDriver.GetSumm: integer;
begin
  Result := FDevice.GetSumm;
end;

function TKKMDriver.GetSupportedMode: integer;
begin
  Result := FDevice.GetSupportedMode;
end;

function TKKMDriver.GetTaxTypeNumber: integer;
begin
  Result := FDevice.TaxTypeNumber;
end;

function TKKMDriver.GetTestMode: boolean;
 begin
 Result := FDevice.TestMode;
end;

function TKKMDriver.GetTextWrap: integer;
begin
  Result := FDevice.TextWrap;
end;

function TKKMDriver.GetTransactionType: integer;
begin
  Result := FDevice.TransactionType;
end;

function TKKMDriver.GetTypeClose: TTypeClose;
begin
  Result := TTypeClose(FDevice.TypeClose);
end;

function TKKMDriver.GetUmode: TDeviceMode;
begin
  Result := TDeviceMode(FDevice.Umode);
end;

function TKKMDriver.GetUmodel: integer;
begin
  Result := FDevice.Umodel;
end;

function TKKMDriver.GetUnitVersion: integer;
begin
  Result := FDevice.GetUnitVersion;
end;

function TKKMDriver.GetUseAccessPassword: boolean;
begin
  Result := FDevice.UseAccessPassword;
end;

function TKKMDriver.GetValue: integer;
begin
  Result := FDevice.GetValue;
end;

function TKKMDriver.GetVersion: string;
begin
  Result := FDevice.Version;
end;

function TKKMDriver.GetWidth: integer;
begin
  Result := FDevice.Width;
end;

function TKKMDriver.GetWriteLogFile: word;
begin
  Result := FDevice.WriteLogFile;
end;

function TKKMDriver.GetYear: word;
begin
  Result := FDevice.Year;
end;

function TKKMDriver.LockKeyboard: integer;
begin
  Result := FDevice.LockKeyboard;
end;

function TKKMDriver.NewDocument: integer;
begin
  Result := FDevice.NewDocument;
end;

function TKKMDriver.OpenCheck: integer;
begin
  Result := FDevice.OpenCheck;
end;

function TKKMDriver.OpenDrawer: integer;
begin
  Result := FDevice.OpenDrawer;
end;

function TKKMDriver.OpenSession: integer;
begin
  Result := FDevice.OpenSession;
end;

function TKKMDriver.PartialCut: integer;
begin
  Result := FDevice.PartialCut;
end;

function TKKMDriver.Payment: integer;
begin
  Result := FDevice.Payment;
end;

function TKKMDriver.PercentsCharge: integer;
begin
  Result := FDevice.PercentCharge;
end;

function TKKMDriver.PercentsDiscount: integer;
begin
  Result := FDevice.PercentsDiscount;
end;

function TKKMDriver.PowerOff: integer;
begin
  Result := FDevice.PowerOff;
end;

function TKKMDriver.PrintBarcode: integer;
begin
  Result := FDevice.PrintBarcode;
end;

function TKKMDriver.PrintBitmap: integer;
begin
  Result := FDevice.PrintBitmap;
end;

function TKKMDriver.PrintBitmapFromFile: integer;
begin
  Result := FDevice.PrintBitmapFromFile;
end;

function TKKMDriver.PrintField: integer;
begin
  Result := FDevice.PrintField;
end;

function TKKMDriver.PrintFooter: integer;
begin
  Result := FDevice.PrintFooter;
end;

function TKKMDriver.PrintHeader: integer;
begin
  Result := FDevice.PrintHeader;
end;

function TKKMDriver.PrintPicture: integer;
begin
  Result := FDevice.PrintPicture;
end;

function TKKMDriver.SetRecord: integer;
begin
  Result := FDevice.SetRecord;
end;

function TKKMDriver.BeginReport: integer;
begin
  Result := FDevice.BeginReport;
end;

function TKKMDriver.EndAdd: integer;
begin
  Result := FDevice.EndAdd;
end;

function TKKMDriver.PrintString: integer;
begin
  Result := FDevice.PrintString;
end;

function TKKMDriver.Registration: integer;
begin
  Result := FDevice.Registration;
end;

function TKKMDriver.Report: integer;
begin
  Result := FDevice.Report;
end;

function TKKMDriver.ResetChargeDiscount: integer;
begin
  Result := FDevice.ResetChargeDiscount;
end;

function TKKMDriver.ResetMode: integer;
begin
  Result := FDevice.ResetMode;
end;

function TKKMDriver.ResetTax: integer;
begin
  Result := FDevice.ResetTax;
end;

function TKKMDriver.Return: integer;
begin
  Result := FDevice.Return;
end;

function TKKMDriver.RunCommand: integer;
begin
  Result := FDevice.RunCommand;
end;

procedure TKKMDriver.SetAccessPassword(const Value: string);
begin
  FDevice.AccessPassword := Value;
end;

procedure TKKMDriver.SetAdvancedMode(const Value: integer);
begin
  FDevice.AdvancedMode := Value;
end;

procedure TKKMDriver.SetAdvancedRegistration(const Value: boolean);
begin
  FDevice.AdvancedRegistration := Value;
end;

procedure TKKMDriver.SetAlignment(const Value: integer);
begin
  FDevice.Alignment := Value;
end;

procedure TKKMDriver.SetApplicationHandle(const Value: THandle);
begin
  FDevice.ApplicationHandle := Value;
end;

procedure TKKMDriver.SetAttrNumber(const Value: integer);
begin
  FDevice.AttrNumber := Value;
end;

procedure TKKMDriver.SetAttrValue(const Value: string);
begin
  FDevice.AttrValue := Value;
end;

procedure TKKMDriver.SetAutoSize(const Value: boolean);
begin
  FDevice.AutoSize := Value;
end;

procedure TKKMDriver.SetBarcode(const Value: string);
begin
  FDevice.Barcode := Value;
end;

procedure TKKMDriver.SetBarcodeColumns(const Value: integer);
begin
  FDevice.BarcodeColumns := Value;
end;

procedure TKKMDriver.SetBarcodeControlCode(const Value: boolean);
begin
  FDevice.BarcodeControlCode := Value;
end;

procedure TKKMDriver.SetBarcodeOptions(const Value: integer);
begin
  FDevice.BarcodeOptions := Value;
end;

procedure TKKMDriver.SetBarcodeRows(const Value: integer);
begin
  FDevice.BarcodeRows := Value;
end;

procedure TKKMDriver.SetBarcodeType(const Value: integer);
begin
  FDevice.BarcodeType := Value;
end;

procedure TKKMDriver.SetBaudRate(const Value: integer);
begin
  FDevice.BaudRate := Value;
end;

procedure TKKMDriver.SetBufferingMode(const Value: boolean);
begin
  FDevice.BufferingMode := Value;
end;

function TKKMDriver.Fiscalization: integer;
begin
  Result := FDevice.Fiscalization;
end;

function TKKMDriver.ResetSummary: integer;
begin
  Result := FDevice.ResetSummary;
end;

function TKKMDriver.SetCaption: integer;
begin
  Result := FDevice.SetCaption;
end;

procedure TKKMDriver.SetCheckNumber(const Value: integer);
begin
  FDevice.CheckNumber := Value;
end;

procedure TKKMDriver.SetCheckType(const Value: TCheckType);
begin
  FDevice.CheckType := integer(Value);
end;

procedure TKKMDriver.SetCorrectionLevel(const Value: integer);
begin
  FDevice.CorrectionLevel := Value;
end;

procedure TKKMDriver.SetCount(const Value: integer);
begin
  FDevice.Count := Value;
end;

procedure TKKMDriver.SetCounterType(const Value: integer);
begin
  FDevice.CounterType := Value;
end;

procedure TKKMDriver.SetCurrentDeviceIndex(const Value: integer);
begin
  FDevice.CurrentDeviceIndex := Value;
end;

procedure TKKMDriver.SetCurrentDeviceName(const Value: string);
begin
  FDevice.CurrentDeviceName := Value;
end;

procedure TKKMDriver.SetCurrentDeviceNumber(const Value: integer);
begin
  FDevice.CurrentDeviceNumber := Value;
end;

function TKKMDriver.SetDate: integer;
begin
  Result := FDevice.SetDate;
end;

procedure TKKMDriver.SetDay(const Value: word);
begin
  FDevice.Day := Value;
end;

procedure TKKMDriver.SetDefaultPassword(const Value: string);
begin
  FDevice.DefaultPassword := Value;
end;

procedure TKKMDriver.SetDepartment(const Value: integer);
begin
  FDevice.Department := Value;
end;

procedure TKKMDriver.SetDestination(const Value: integer);
begin
  FDevice.Destination := Value;
end;

procedure TKKMDriver.SetDeviceEnabled(const Value: boolean);
begin
  FDevice.DeviceEnabled := Value;
end;

procedure TKKMDriver.SetDeviceEnableTimeout(const Value: integer);
begin
  FDevice.DeviceEnableTimeout := Value;
end;

procedure TKKMDriver.SetDeviceSettings(const Value: string);
begin
  FDevice.DeviceSettings := Value;
end;

procedure TKKMDriver.SetDevicesSettings(const Value: string);
begin
  FDevice.DevicesSettings := Value;
end;

procedure TKKMDriver.SetDisableParamWindow(const Value: boolean);
begin
  FDevice.DisableParamWindow := Value;
end;

procedure TKKMDriver.SetDisablePasswordSettings(const Value: boolean);
begin
  FDevice.DisablePasswordSettings := Value;
end;

procedure TKKMDriver.SetDiscountType(const Value: integer);
begin
  FDevice.DiscountType := Value;
end;

procedure TKKMDriver.SetDiscountTypeNumber(const Value: integer);
begin
  FDevice.DiscountTypeNumber := Value;
end;

procedure TKKMDriver.SetDiscountValue(const Value: Double);
begin
  FDevice.DiscountValue := Value;
end;

procedure TKKMDriver.SetDrawerOffTimeout(const Value: integer);
begin
  FDevice.DrawerOffTimeout := Value;
end;

procedure TKKMDriver.SetDrawerOnQuantity(const Value: integer);
begin
  FDevice.DrawerOnQuantity := Value;
end;

procedure TKKMDriver.SetDrawerOnTimeout(const Value: integer);
begin
  FDevice.DrawerOnTimeout := Value;
end;

procedure TKKMDriver.SetDuration(const Value: integer);
begin
  FDevice.Duration := Value;
end;

procedure TKKMDriver.SetEKLZFlags(const Value: integer);
begin
  FDevice.EKLZFlags := Value;
end;

procedure TKKMDriver.SetEnableCheckSumm(const Value: boolean);
begin
  FDevice.EnableCheckSumm := Value;
end;

procedure TKKMDriver.SetEndDay(const Value: word);
begin
  FDevice.EndDay := Value;
end;

procedure TKKMDriver.SetEndMonth(const Value: word);
begin
  FDevice.EndMonth := Value;
end;

procedure TKKMDriver.SetEndSession(const Value: integer);
begin
  FDevice.EndSession := Value;
end;

procedure TKKMDriver.SetEndYear(const Value: word);
begin
  FDevice.EndYear := Value;
end;

procedure TKKMDriver.SetEntryNum(const Value: integer);
begin
  FDevice.EntryNum := Value;
end;

procedure TKKMDriver.SetFileName(const Value: string);
begin
  FDevice.FileName := Value;
end;

procedure TKKMDriver.SetFontBold(const Value: boolean);
begin
  FDevice.FontBold := Value;
end;

procedure TKKMDriver.SetFontDblHeight(const Value: boolean);
begin
  FDevice.FontDblHeight := Value;
end;

procedure TKKMDriver.SetFontDblWidth(const Value: boolean);
begin
  FDevice.FontDblWidth := Value;
end;

procedure TKKMDriver.SetFontItalic(const Value: boolean);
begin
  FDevice.FontItalic := Value;
end;

procedure TKKMDriver.SetFontNegative(const Value: boolean);
begin
  FDevice.FontNegative := Value;
end;

procedure TKKMDriver.SetFontUnderline(const Value: boolean);
begin
  FDevice.FontUnderline := Value;
end;

procedure TKKMDriver.SetFrequency(const Value: integer);
begin
  FDevice.Frequency := Value;
end;

procedure TKKMDriver.SetFRLicense(const Value: integer);
begin
  FDevice.License := Value;
end;

procedure TKKMDriver.SetHeight(const Value: integer);
begin
  FDevice.Height := Value;
end;

procedure TKKMDriver.SetHour(const Value: word);
begin
  FDevice.Hour := Value;
end;

procedure TKKMDriver.SetInboundStream(const Value: string);
begin
  FDevice.InboundStream := Value;
end;

procedure TKKMDriver.SetJrnBrightness(const Value: integer);
begin
  FDevice.JrnBrightness := Value;
end;

procedure TKKMDriver.SetJrnFont(const Value: integer);
begin
  FDevice.JrnFont := Value;
end;

procedure TKKMDriver.SetJrnFontHeight(const Value: integer);
begin
  FDevice.JrnFontHeight := Value;
end;

procedure TKKMDriver.SetJrnLineSpacing(const Value: integer);
begin
  FDevice.JrnLineSpacing := Value;
end;

procedure TKKMDriver.SetKKMCaption(Value: string);
begin
  FDevice.Caption := Value;
end;

procedure TKKMDriver.SetKKMCaptionPurpose(const Value: integer);
begin
  FDevice.CaptionPurpose := Value;
end;

procedure TKKMDriver.SetKKMMode(Value: TKKMMode);
begin
  FDevice.Mode := integer(Value);
end;

procedure TKKMDriver.SetKKMPassword(Value: string);
begin
  FDevice.Password := Value;
end;

procedure TKKMDriver.SetKKMPointPosition(Value: word);
begin
  FDevice.PointPosition := Value;
end;

procedure TKKMDriver.SetKKMSumm(const Value: Double);
begin
  FDevice.Summ := Value;
end;

procedure TKKMDriver.SetKKMValue(Value: integer);
begin
  FDevice.Value := Value;
end;

procedure TKKMDriver.SetKKMValuePurpose(const Value: integer);
begin
  FDevice.ValuePurpose := Value;
end;

function TKKMDriver.SetLicense: integer;
begin
  Result := FDevice.SetLicense;
end;

procedure TKKMDriver.SetLineNumber(const Value: integer);
begin
  FDevice.LineNumber := Value;
end;

procedure TKKMDriver.SetLockDevices(const Value: boolean);
begin
  FDevice.LockDevices := Value;
end;

procedure TKKMDriver.SetMachineName(const Value: string);
begin
  FDevice.MachineName := Value;
end;

procedure TKKMDriver.SetMachineNumber(const Value: string);
begin
  FDevice.MachineNumber := Value;
end;

procedure TKKMDriver.SetMaxCaptionLength(const Value: integer);
begin
  FDevice.MaxCaptionLength := Value;
end;

procedure TKKMDriver.SetMinute(const Value: word);
begin
  FDevice.Minute := Value;
end;

function TKKMDriver.SetMode: integer;
begin
  Result := FDevice.SetMode;
end;

procedure TKKMDriver.SetModel(const Value: integer);
begin
  FDevice.Model := Value;
end;

procedure TKKMDriver.SetModelCheck(const Value: boolean);
begin
  FDevice.ModelCheck := Value;
end;

procedure TKKMDriver.SetMonth(const Value: word);
begin
  FDevice.Month := Value;
end;

procedure TKKMDriver.Setname(const Value: string);
begin
  FDevice.Name := Value;
end;

procedure TKKMDriver.SetOperationType(const Value: integer);
begin
  FDevice.OperationType := Value;
end;

procedure TKKMDriver.SetOperatorName(const Value: string);
begin
  FDevice.OperatorName := Value;
end;

procedure TKKMDriver.SetOperatorNo(const Value: integer);
begin
  FDevice.OperatorNo := Value;
end;

procedure TKKMDriver.SetOperatorPassword(const Value: string);
begin
  FDevice.OperatorPassword := Value;
end;

procedure TKKMDriver.SetOutBoundStream(const Value: string);
begin
  FDevice.OutboundStream := Value;
end;

function TKKMDriver.SetPassword: integer;
begin
  Result := FDevice.SetPassword;
end;

procedure TKKMDriver.SetPercents(const Value: Double);
begin
  FDevice.Percents := Value;
end;

procedure TKKMDriver.SetPictureNumber(const Value: integer);
begin
  FDevice.PictureNumber := Value;
end;

function TKKMDriver.SetPointPosition: integer;
begin
  Result := FDevice.SetPointPosition;
end;

procedure TKKMDriver.SetPortNumber(const Value: integer);
begin
  FDevice.PortNumber := Value;
end;

procedure TKKMDriver.SetPrice(const Value: Double);
begin
  FDevice.Price := Value;
end;

procedure TKKMDriver.SetPrintBarcodeText(const Value: integer);
begin
  FDevice.PrintBarcodeText := Value;
end;

procedure TKKMDriver.SetPrintPurpose(const Value: integer);
begin
  FDevice.PrintPurpose := Value;
end;

procedure TKKMDriver.SetQuantity(const Value: Double);
begin
  FDevice.Quantity := Value;
end;

procedure TKKMDriver.SetRecBrightness(const Value: integer);
begin
  FDevice.RecBrightness := Value;
end;

procedure TKKMDriver.SetRecFont(const Value: integer);
begin
  FDevice.RecFont := Value;
end;

procedure TKKMDriver.SetRecFontHeight(const Value: integer);
begin
  FDevice.RecFontHeight := Value;
end;

procedure TKKMDriver.SetRecLineSpacing(const Value: integer);
begin
  FDevice.RecLineSpacing := Value;
end;

procedure TKKMDriver.SetRegisterNumber(const Value: integer);
begin
  FDevice.RegisterNumber := Value;
end;

procedure TKKMDriver.SetReportType(const Value: TKKMReportType);
begin
  FDevice.ReportType := integer(Value);
end;

procedure TKKMDriver.SetScale(const Value: Double);
begin
  FDevice.Scale := Value;
end;

procedure TKKMDriver.SetScaleVB(const Value: Double);
begin
  FDevice.ScaleVB := Value;
end;

procedure TKKMDriver.SetSecond(const Value: word);
begin
  FDevice.Second := Value;
end;

procedure TKKMDriver.SetSession(const Value: integer);
begin
  FDevice.Session := Value;
end;

function TKKMDriver.SetSettings: integer;
begin
  Result := FDevice.SetSettings;
end;

procedure TKKMDriver.SetShowProgress(const Value: boolean);
begin
  FDevice.ShowProgress := Value;
end;

procedure TKKMDriver.SetSlipDocCopyCountHorz(const Value: integer);
begin
  FDevice.SlipDocCopyCountHorz := Value;
end;

procedure TKKMDriver.SetSlipDocCopyCountVert(const Value: integer);
begin
  FDevice.SlipDocCopyCountVert := Value;
end;

procedure TKKMDriver.SetSlipDocCopyShiftHorz(const Value: integer);
begin
  FDevice.SlipDocCopyShiftHorz := Value;
end;

procedure TKKMDriver.SetSlipDocCopyShiftVert(const Value: integer);
begin
  FDevice.SlipDocCopyShiftVert := Value;
end;

procedure TKKMDriver.SetSlipDocLeftMargin(const Value: integer);
begin
  FDevice.SlipDocLeftMargin := Value;
end;

procedure TKKMDriver.SetSlipDocOrientation(const Value: integer);
begin
  FDevice.SlipDocOrientation := Value;
end;

procedure TKKMDriver.SetSlipDocTopMargin(const Value: integer);
begin
  FDevice.SlipDocTopMargin := Value;
end;

procedure TKKMDriver.SetSlotNumber(const Value: integer);
begin
  FDevice.SlotNumber := Value;
end;

procedure TKKMDriver.SetStreamFormat(const Value: integer);
begin
  FDevice.StreamFormat := Value;
end;

procedure TKKMDriver.SetTaxTypeNumber(const Value: integer);
begin
  FDevice.TaxTypeNumber := Value;
end;

procedure TKKMDriver.SetTestMode(const Value: boolean);
begin
  FDevice.TestMode := Value;
end;

procedure TKKMDriver.SetTextWrap(const Value: integer);
begin
  FDevice.TextWrap := Value;
end;

function TKKMDriver.SetTime: integer;
begin
  Result := FDevice.SetTime;
end;

procedure TKKMDriver.SetTransactionType(const Value: integer);
begin
  FDevice.TransactionType := Value;
end;

procedure TKKMDriver.SetTypeClose(const Value: TTypeClose);
begin
  FDevice.TypeClose := integer(Value);
end;

procedure TKKMDriver.SetUmode(const Value: TDeviceMode);
begin
  FDevice.Umode := integer(Value);
end;

procedure TKKMDriver.SetUmodel(const Value: integer);
begin
  FDevice.Umodel := Value;
end;

procedure TKKMDriver.SetUseAccessPassword(const Value: boolean);
begin
  FDevice.UseAccessPassword := Value;
end;

function TKKMDriver.SetValue: integer;
begin
  Result := FDevice.SetValue;
end;

procedure TKKMDriver.SetWidth(const Value: integer);
begin
  FDevice.Width := Value;
end;

procedure TKKMDriver.SetWriteLogFile(const Value: word);
begin
  FDevice.WriteLogFile := Value;
end;

procedure TKKMDriver.SetYear(const Value: word);
begin
  FDevice.Year := Value;
end;

function TKKMDriver.ShowProperties: integer;
begin
  Result := FDevice.ShowProperties;
end;

function TKKMDriver.Sound: integer;
begin
  Result := FDevice.Sound;
end;

function TKKMDriver.Storno: integer;
begin
  Result := FDevice.Storno;
end;

function TKKMDriver.StornoPayment: integer;
begin
  Result := FDevice.StornoPayment;
end;

function TKKMDriver.SummCharge: integer;
begin
  Result := FDevice.SummCharge;
end;

function TKKMDriver.SummDiscount: integer;
begin
  Result := FDevice.SummDiscount;
end;

function TKKMDriver.SummTax: integer;
begin
  Result := FDevice.SummTax;
end;

function TKKMDriver.UnLockKeyboard: integer;
begin
  Result := FDevice.UnLockKeyboard;
end;

function TKKMDriver.WriteAttribute: integer;
begin
  Result := FDevice.WriteAttribute;
end;

end.
