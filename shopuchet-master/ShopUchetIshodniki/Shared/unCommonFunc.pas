unit unCommonFunc;

interface

uses
  Windows, Classes, Forms, SysUtils, Messages, Controls, StdCtrls, ComCtrls, UnRekassa,
  Dialogs, cxPC, cxEdit, Graphics, WinSock, Registry, dmMain, frmCopyProgress, FIB, unErrorHandlers,
  pFIBStoredProc, Variants, dmReports, pFIBDataSet, DB, IniFiles, TurboActivateUnit, cxCurrencyEdit,
  cxTL, cxControls, cxDBTL, cxCheckBox, cxGridDBTableView, ComObj, unSupport, ActiveX, Types,
  DateUtils, smsc_api, StrUtils, UITypes, cxEditRepositoryItems, FprnM1C_TLB, unkkm, unShtrihDriver,
  unDisplayDriver, pFIBScripter, FIBDataSet, unKKMTIS, Winapi.TlHelp32, winsvc;

const
  WM_SHOWCREDITS        = WM_USER + 100;     {About - для начала показа Credits}

  WM_CONNECT            = WM_USER + 201;     {Main - для выполнения ConnectAction}
  WM_DISCONNECT         = WM_USER + 202;     {Main - для выполнения DisconnectAction}
  WM_CLOSEALLDIALOGS    = WM_USER + 203;     {Main - для закрытия всех диалоговых окон}
  WM_SETUPDIALOG        = WM_USER + 204;     {Setup - открытие окна настроек}

  WM_REGCOMP            = WM_USER + 300;     {RegCompDialogFrm - для выполнения подключения к}
                                             {БД с правами администратора для регистрации комп.}

  WM_SETUPCHANGED       = WM_USER + 301;
  WM_AUTOSIZEFORM       = WM_USER + 302;
  WM_INSOFFICIAL        = WM_USER + 303;  {ДОБАВИТЬ СОТРУДНИКА, В СПРАВОЧНИКЕ СОТРУДНИКОВ}
  WM_REFRESH            = WM_USER + 400;  {Обновить}
  WM_VIEWREC            = WM_USER + 401;  {Просмотреть запись}
  WM_INSREC             = WM_USER + 402;  {Вставить запись}
  WM_INSLIKEREC         = WM_USER + 403;  {Вставить копию записи}
  WM_UPDREC             = WM_USER + 404;  {Изменить запись}
  WM_DELREC             = WM_USER + 405;  {Удалить запись}
  WM_DELALLREC          = WM_USER + 406;  {Удалить все записи}
 // WM_CONFIRMREC       = WM_USER + 406;  {Утвердить запись}
  WM_UNCONFIRMREC       = WM_USER + 407;  {Отменить утверждение записи}
  WM_GETDATA            = WM_USER + 408;  {Прочитать данные в окне диалога}
  WM_VIEWHIS            = WM_USER + 409;  {Просмотреть историю}
  WM_APPLYCHANGES       = WM_USER + 410;  {Применить изменения перед утверждением объекта}
  WM_HELPME               = WM_USER + 411;  {Вызов справки}

  WM_ALIGNCONTROLS      = WM_USER + 412; {Выровнять контролы после OnShow (до Refresh)}

//  WM_VIEWREC2       = WM_USER + 412;  {Просмотреть запись 2}

  WM_INSCHILD           = WM_USER + 415;  {Вставить дочернюю запись}

  WM_STOPIB                   = WM_USER + 422;  {Остановить FireBird}
  WM_STARTIB                  = WM_USER + 423;  {Запустить FireBird}
  WM_ARCHIVEDB                = WM_USER + 424;  {Заархивировать БД}
  WM_RESTOREDB                = WM_USER + 425;  {Разархивировать БД}
  WM_GBAKMESSAGESCLOSED       = WM_USER + 430;  {Форма с логом GBAK.exe закрыта}
  WM_JOURNALCLOSED            = WM_USER + 435;  {Журнал закрыт}

  WM_FILLLIST                 = WM_USER + 442;  {Заполнить список для ревизии}
  WM_PAYFORREAL               = WM_USER + 443;  {ОПЛАТИТЬ ЗА ТОВАР, ВЫДАННЫЙ ПОД РЕАЛИЗАЦИЮ, РЕЖИМ "ВЫДАЧА ПОД РЕАЛИЗАЦИЮ"}
  WM_RETURNFORREAL            = WM_USER + 444;  {ВОЗВРАТ ТОВАРА, ВЫДАННОГО ПОД РЕАЛИЗАЦИЮ, РЕЖИМ "ВЫДАЧА ПОД РЕАЛИЗАЦИЮ"}
  WM_CLEARZAKAZ               = WM_USER + 445;  {ОЧИСТИТЬ ЗАКАЗ, РЕЖИМ "ПРОДАВЦА"}
  WM_DEL_TMP                  = WM_USER + 446;  //Удалить товар из накладной, РЕЖИМ "ПРОДАВЦА"
  WM_CLEARTABLE               = WM_USER + 447;  //Очистить таблицу для ревизии
  WM_IMPORT                   = WM_USER + 448;  //Импорт с Екселя для ревизии
  WM_CLICK_KAFE_TOVVIEW       = WM_USER + 449;  //Нажатие по кнопке в режиме кассира при отображении товаров кнопками
  WM_CLICK_FAST_TOVVIEW       = WM_USER + 450;  //Нажатие по кнопке в окне быстрых товаров

  WM_SETCONTROLSNOTMODIFIED = WM_USER + 451;  {Сбросить Modified у всех контролов формы диалога}
  WM_READONLYCONTROLS       = WM_USER + 452;  {Установить ReadOnly у всех контролов формы диалога}
  WM_BESTALIGN              = WM_USER + 453;  {Расположить оптимально Popup-control}


  WM_CORRECTALLOFFICGRANTS  = WM_USER + 475;  {Скорректировать привилегии всех пользователей}

//  WM_UPLOADDONE   = WM_USER + 500;  {Отправка сообщений завершена}

//  WM_SHOWPARENT   = WM_USER + 601;

  WM_PRINTDATA          = WM_USER + 701;  {Распечатать}
  WM_PRINTALLDATA       = WM_USER + 702;  {Распечатать все}
  WM_PRINTPREVIEW       = WM_USER + 703;  {Предварительный просмотр}
  WM_PAGESETUP          = WM_USER + 704;  {Настройка страницы}
  WM_SAVEREPORT         = WM_USER + 705;  {Сохранение отчёта}
  WM_OPENINEXCEL        = WM_USER + 706;  {Открыть отчёт в Excel'е}
  WM_INVERTCELL         = WM_USER + 707;  {Инвертировать ячейку в SpreadSheet'е}

  WM_REPORTWORKBOOKCLOSED = WM_USER + 710;  {Окно с отчётами закрылось}

  WM_CONFIRM              = WM_USER + 720;  {Утвердить докумет}
  WM_ATTACHEDDOC          = WM_USER + 730;  {Прикреплённые документы}

  WM_POPUPCLOSED          = WM_USER + 805;  {Всплывающее окно закрылось}

  C_Mask_36_18            = 'fm999G999G999G999G999G990D009999999999999999';
  C_Mask_18_9             = 'fm999G999G990D009999999';
  C_Mask_20_4             = 'fm9G999G999G999G999G990D0099';
  C_Mask_18_2             = 'fm9G999G999G999G999G990D00';
  C_Mask_Int              = 'fm9G999G999G999G999G990';
  CRLF                    = #13#10;


type
  TArr =  record
    ID: Int64;
    Name: String;
  end;

  TPrinterArr =  record
    Name: String;
    BillWidth: String;
    BillSdvig: Integer;
    BillQuantity: Integer;
  end;

  TScaleArr =  record
    Name: String;
    ModelId : Integer;
    IP: String;
    Port: String;
  end;

  TPosTerminalArr =  record
    IP: String;
    Model: Integer;
    Name: String;
  end;

var
  AppName : String;
  SelfHeight: Integer;
  SelfWidth: Integer;

  IsActivated : INTEGER;     // 1 - либо активирована, либо еще есть триальное время, 0 - ни то, ни другое
  GotLicenceInfo : Boolean;     // на виртуалке инфо о лицензии очень долго грузится, поэтому сделаю флаг, если False, то не показывать инфу в окне Лицензия
  trialFlags: LongWord;
  trialDaysRemaining : LongWord;
  ta : TurboActivate;
  isGenuine : Boolean;
  ZNUM      : String;
  isProKey : Boolean;      // базовая версия или ПРО
  isMainKey : Boolean;     // главный ключ или ДОП
  isConstKey : Boolean;    // постоянный ключ или абонент
  productKeyName : String; // для какой программы выдан ключ

  IsDebugHook : Integer;
  AllowSellAbsGoods : INTEGER;
  BackupDir : String;
  //CopyProgressForm : TCopyProgressForm;
  NdsValue : Double;
  Excel: Variant;
  FNeedBackup : Integer;  // нужно бэкап делать или нет. Может прогу просто открыли и все, ничего не делали, даже пароль не ввели, а прога делает бэкап. Поэтому сделал пока так, если пароль не ввоидил, а тут же программу закрыли, то бэкап не нужен

  // Печать чеков
  PrintOnPrinters : Boolean;
  PrintOnFr       : Boolean;
  CheckPrintDeviceFr : Integer;  // 0 - не выбрано, 1 - ФР Атол, 2 - ФР Штрих
  PrintersArr : array of TPrinterArr;
  BillSlogan : String;  // слоган для печати на кассовом чеке
  BillPrintChargedBonus : Integer; // печатать в чеке информацию о полученном бонусе за эту покупку
  {BillPrinter : String; // наименование принтера чеков
  BillWidth : Integer;  // ширина чеков, 80мм - 0, 58мм - 1, лист А4 - 2
  BillSdvig : Integer;
  BillQuantity : Integer; // сколько чеков печатать за раз}
  KKMPrinter : TKKMAtol;  // объект типа Атол
  KKMPrinterStrih : TShtrihDriver;  // объект типа Штрих
  //Параметры ReKassa
  Test_Rekassa: Integer;  //Тестовый режим ReKassa
  PrinterRekassa: TPrinterArr;
  KKMReKassa: TRekassa; //Объект Rekassa
  ReKassa: Boolean;   //Используется ReKassa
  {0: 'DOMAIN_TRADING', 1: 'DOMAIN_SERVICES';}
  DomainType: integer; //Сфера деятельности
  Login: string;      //Идентификатор кассы (логин)
  Pass: string;       //Пароль
  PinCode: string;   //ПИН-код (используется для закрытия смены)
  BillPrintBarcode: integer; //печатать штрихкод на чеке, для поиска чека сканером, 0 - нет, 1 - да

  //Параметры ТИС
  KKMTIS: TKKMTIS;   //Object TIS
  LoginTIS: string; //Login
  PassTIS: string;  //Password
  PortTis: Integer; //Port
  Terminal: Integer; //Pos terminal

  ComPortNumber  : Integer;     // номер COM-порта
  BaudRate    : Integer;        // скорость передачи данных
  IsFrConnectedAnotherComp : Integer; // ККМ подключен к другому компьютеру
  IpFrConnectAnotherComp : string; // IP-адрес этого другого компьютера

  FindShtrikh: Boolean; //Искать в интернете товар по штрихкоду
  CurrentOfficial : Int64;
  CurrentOfficialName : String;
  CurrentOfficialAppointment : Integer; // 1 - исполнитель, 0 - руководитель или главбух
  CurrencyVal : Integer;   // 0 - тенге, 1 - рубли, 2 - гривны
  YesNetwork : Integer; // сетевой режим, 0 - нет, 1- да
  LimitCount: Integer;  //Ограничивать загружаемые строки при сетевом режиме, 0-нет, 1-Да
  ServerName : String;  // имя компьютера-сервера
  WorkTimeBegin : Ttime;  // время начала работы
  WorkTimeEnd   : Ttime;  // время конца работы
  SkladArr : array of TArr;
  CurSklad : Int64;  //ID текущего склада
  CurSkladName : String;  //имя текущего склада
  Config   : Integer;  // конфигурация 0 - магазин, 1 - аптека, 2 - магазин автозапчастей, 3 - Производство (цех/пекарня), 4 - ЮВЕЛИРНЫЙ, 5 - КАФЕ, ФАСТФУД
  DoProductInSale : Integer; //Производить товар автоматически 0 - Нет, 1 - Да
  BarcodeLength : Integer; //Длина штрихкода, 0 - 13 знаков, 1 - 8 знаков
  ManyFirm: Integer;     // режим нескольких фирм. 0 - нет, 1 - да
  NotifyNol : Integer;   // предупреждать о добавлении товара с нулевой ценой при продаже 0 - нет, 1 - да
  NewLineSale : Integer; // не суммировать товары, а добавлять каждый товар новой строкой. 0 - нет, 1 - да
  UseTovarPlace : Integer;  // искать по полю "Место на складе" во всех режимах
  UseTovarNoteInSearch : Integer;  // искать по полю "Примечание" во всех режимах
  LicenseKeyPath : string;  //путь до каталога с лиц. ключом
  UseCurrency  : boolean;    //включить валюту
  ConfSetOneMaster : Boolean; // закрепить одного мастера за счетом, т.е. других мастеров невозможно будет выбрать
  ShowImens : Boolean;        // показывать список именинников при входе
  UseSelfPriceOnTransfer: Integer; //Какую цену юзать при трансфере, 0 - закупочную, 1 - розничную
  AddBonusForPromo : Boolean;       //начислять бонусы за рекомендации
  AmountBonusForPromo : Double;    //кол-во бонусов за рекомендации
  SendSmsWhenBonusAdd : Boolean;  //отправлять уведомление, когда пополняется бонусный счет
  TextSmsWhenBonusAdd : String;   //текст, который отправляется клиенту
  DoNotAllowCrossTime : Boolean;  //нельзя записывать клиента на время, которое у мастера уже закрыто
  BonusOnCreateClient : integer;  //размер бонуса для новых (создаваемых) клиентов
  DecimalCount        : integer;  // количество знаков после запятой
  DoNotShowRashodniki : Boolean;  // не показывать расходники в истории посещений и расписании
  DataAlreadyFilled   : Integer;  // товары уже были первично заполнены, заполнять не нужно
  FirstStartup        : Integer;  // первый запуск программы
  LastCheck           : Int64;    // id последней продажи, для печати последнего чека
  DoNotCreditBonusOnDolg : Integer;  // не начислять бонусы при продаже в долг, 1 - не начислять, 0 - начислять
  SetCursorOnTovar : Integer;        // устанавливать курсор на товар при сканировании штрихкода
  SetSaleOfGoods: Integer;           //Разграничение прав на просмотр продаж товара
  LetDoReturnWithoutSale: Integer;   //Разрешить оформлять возврат товара без продажи

  // настройки окна КАССИРА
  ShowSaleDlg     : Integer;  // показывать предварительное окно с количеством товара в режиме кассира 0 - нет, 1 - да
  ShowSaleDlgForVes : Integer; // показывать окно только для весовых товаров
  ShowSaleDlgKeys : Integer;  // показывать кнопки с цифрами
  ShowCostPrice   : Integer;  // показывать закупочные цены в режиме кассира
  ShowTovarPanel  : Integer;  // показывать панель с товарами
  RmkView         : Integer;  // вид рабочего места кассира, 1 - компактный, 0 - стандартный
  KafeTovarView   : Integer;  // показывать товары в виде панели с кнопками, для кафе/фастфуда
  ShowKassirPanel : Integer;  // показывать панель с выбором кассира
  OptPriceByDefault : Integer; // подставлять оптовые цены по умолчанию
  ShowInsClientBtn : Integer;  // показывать кнопку для создания новых клиентов
  ShowProductImg : Integer;   // показывать картинки товаров на рабочем месте кассира
  PinCodeForDelItems : String;   // PIN-код для удаления товаров из корзины

  //НАСТРОЙКА ВЕСОВ
  UseScales : integer;      //1 - пользуют весы, 0 - нет
  ScalesPrefix : String;    //префикс весового штрихкода
  ScalesIp : String;        //Айпи-адрес весов
  ScalesPort : String;      //Порт-адрес весов
  ScalesModel : Integer;    //Модель(фирма) весов: 0 - Масса-К, 1 - Rongta RLS1000
  ScalesArr : array of TScaleArr;

  //права для редактирования накладных
  HaveRightInsSale : Boolean;
  HaveRightUpdSale : Boolean;
  HaveRightDelSale : Boolean;
  HaveRightUpdPriceSale : Boolean;  //Менять цену при добавлении товара в продажу
  HaveRightUpdPriceRoznToOpt : Boolean;  //Менять цену с розницы на опт при добавлении товара в продажу
  HaveRightUpdDiscSale  : Boolean;  //Менять размер скидки при добавлении товара в продажу
  HaveRightPrintCheck   : Boolean;  //Печатать чек в Торговля-Продажи
  HaveRightInsPrihod : Boolean;
  HaveRightUpdPrihod : Boolean;
  HaveRightDelPrihod : Boolean;
  HaveRightInsSpisanie : Boolean;
  HaveRightUpdSpisanie : Boolean;
  HaveRightDelSpisanie : Boolean;
  HaveRightInsReturnClient : Boolean;
  HaveRightUpdReturnClient : Boolean;
  HaveRightDelReturnClient : Boolean;
  HaveRightInsMove : Boolean;   // перемещение между складами
  HaveRightUpdMove : Boolean;   // перемещение между складами
  HaveRightDelMove : Boolean;   // перемещение между складами

  // ПРАВА НА СПРАВОЧНИК ТОВАРОВ
  HaveRightInsPriceList : Boolean;
  HaveRightUpdPriceList : Boolean;
  HaveRightDelPriceList : Boolean;

  // ПРАВА НА СПРАВОЧНИК КЛИЕНТОВ
  HaveRightUpdBonusClient : Boolean;

  //право на просмотр остатков в режиме кассира
  HaveRightToSeeAmount : Boolean;

  //право на просмотр остатков на других складах
  HaveRightToSeeAmountSklad : Boolean;

  //право на просмотр оптовых цен в режиме кассира
  HaveRightToSeeOpt : Boolean;

  //право на просмотр закупочных цен в режиме кассира
  HaveRightToSeeCostPrice : Boolean;

  //право на оформление возврата товара
  HaveRightToVozvrat : Boolean;

  //СМСки автоматические
  SmsLogin : string;
  SmsPassword : string;
  SmsNotifyEnabled : Integer;
  SmsNotifyText : string;
  SmsHBEnabled : Integer;
  SmsHBText : string;
  SmsTranslit : integer;

  //Параметры для звонка
  CallLogin : String;
  CallAPIAddress : String;
  CallAPI : String;

  //Параметры для выгрузки ECWID
  ExportEcwid: Boolean;
  EcwidStoreID: string;
  EcwidSecretToken: string;
  // Параметры для выгрузки данных
  ExportKaspi: Boolean; //Выгрузка в каспий магазин
  merchantid: string;   //ID партнера
  IDSKU: Integer;       //Тип ключа для каспий магазина 0-Ключ ShopUchet, 1 - Артикул, 2 - баркод
  ExportDataType : String;  //выгрузка данных на облако, первый символ - Продажи, второй - Остатки, третий - Остатки в формате XML, четвертый - Прибыль
  ExportDataTypeFtp : String;  //выгрузка данных на FTP, первый символ - Продажи, второй - Остатки, третий - Остатки в формате XML, четвертый - Прибыль
  ExportInterval : Integer;  //выгрузка данных на облако: 0 Никогда, 1 При закрытии программы, 2 Каждые 15 минут, 3 Каждые 30 минут, 4 Каждые 45 минут, 5 Каждый час, 6 Каждые 2 часа, 7 Каждые 3 часа, 8 Каждые 4 часа
  ExportPath : String;  //выгрузка данных на облако: путь к папке
  UploadToFtp : Boolean;    //выгружать на FTP
  ExportFtpServer: String;
  ExportFtpPort: String;
  ExportFtpLogin: String;
  ExportFtpPassword: string;
  ItekaTochka: Int64;
  ExportThreadExists : Boolean;  // поток создается на MainForm и виден только там, поэтому создал переменную, которую видят все

  UploadToMobile : Boolean;    //выгружать в мобильное приложение
  ExportMobileServer: String;
  ExportMobileLogin: String;
  ExportMobilePassword: string;
  ExportMobileToken: String;   // теперь заходим по токену, даже если в мобилке пароль поменяли - токен старый можно в Шопучете не менять пароль

  //Параметры для онлайн-записи
  OnlineZapisEnabled : Boolean;   // True - онлайн-запись включена
  OnlineZapisLink    : string;    // ссылка на сервис онлайн-записи
  OnlineZapisLogin   : string;    // логин
  OnlineZapisPass    : string;    // пароль
  OnlineZapisRefresh : integer;   // 0 - 5 минут, 1 - 10 минут, 2 - 15 минут, 3 - 30 минут, 4 - 1 час, 5 - 3 часа, 6 - 1 раз при открытии программы
  OnlineZapisDoSyncAlways : Boolean;  //делать синхронизацию каждый раз перед созданием записи

  //Параметры синхронизации
  SyncFolder    : string;
  SyncInterval  : integer;
  SyncCurCompId : Int64;
  SyncLogFile   : TextFile;
  SyncId  : string;

  //Display
  DisplayDriver : TDisplayDriver;
  DisplayUse : Integer; // 0 - нет, 1 - Да
  DisplayModel : Integer;
  DisplayComPort : Integer;
  DisplayComPortStr : String;
  DisplayComBaudRate : integer;
  NotAccess: Boolean = False;

  //Pos-терминал
  UsePosTerminal : Integer;
  PosTerminalArr : array of TPosTerminalArr;
  {PosTerminalIp : String;
  PosTerminalNonCashPayType : Int64;}

  //*************************************************
  // ПРОГРАММА ДЛЯ УЧЕТА СТО
  //*************************************************
  DoNotShowAuto  : Boolean; // не показывать раздел с авто в накладной продажи
  UseDateEndSalaryReport : Boolean; //учитывтаь дату завершения работ при построении отчета о зарплате

  //*************************************************
  // РАЗНОЕ
  //*************************************************
  DeliveryService : Integer;
  isCredit: Boolean;

type
  TCustomStyle = (csShadow, csWebStyle, csRealBlank, csFlat, csStandard);

  TtbButtonsStyle = (bsText, bsGlyphText, bsGlyph);

  EMyException = class(Exception);


procedure Delay(msecs : DWORD);

function CheckTransparencyAllowed: Boolean;
{Если Windows 2K и выше, прозрачность возможна}

procedure SetTransparent(FrmHWND: HWND; Transparency: Integer);
{Если Windows 2K и выше, устанавливает заданную прозрачность от 0 до 100}

function GetUserName: String;

function GetConnectionsCount: Integer;

function GetComputerName: String;

function GetIPAddressList: TStringList;

function GetIPAddressListStr: String;

function GetDiskSerNum(Disk: String): DWORD;

function GetDiskSerNumStr(SN: Longword): String;

procedure GetPCData(var ComputerName: String; var OSPlatformId, OSMajorVer,
                    OSMinorVer, OSBuildNumber, CPUAmount, CPUType, FixedDrives,
                    DiskCSerNum: DWORD);

procedure GetPCDataStr(OSPlatformId, CPUType, FixedDrives, DiskCSerNum: DWORD;
                       var OSPlatformIdStr, CPUTypeStr, FixedDrivesStr, DiskCSerNumStr: String);

function IsHaveRight(RightItem: Integer; RightsArr: array of Integer): Boolean;

function IsHaveAnyRight(RightItemsArr, RightsArr: array of Integer): Boolean;

function CheckSumm(SIn: String; var SOut: String): Boolean; overload;
function CheckSumm(SIn: String; var SOut: String; Decimals: Integer): Boolean; overload;

procedure DivSumm(S: Extended; var Left, Right: Int64); overload;
procedure DivSumm(S: String; var Left, Right: Int64); overload;

function CheckAllIDDifferent(IDArr: array of Integer): Boolean;

function CheckDate(D: TDate; const BeginDateStr, EndDateStr: String): Boolean;
{Проверяет, входит ли D в диапазон BeginDate..EndDate}
{BeginDate, EndDate в формате 'dd.mm.yyyy'}

function CheckTime(D: TTime): Boolean;

function SummByWords(S: Extended): String;

function CheckRequizChanged(Owner: TComponent): Boolean;

function LPad(const S: String; const Len: Integer; const Pad: Char): String;
function RPad(const S: String; const Len: Integer; const Pad: Char): String;
function RCopy(const S: String; const Index, Count: Integer): String;
function PosFrom(const SubStr, Str: String; const FromPos: Integer): Integer;

function UnixToWindowsCRLF(UnixCRLFStr: String): String;
{Преобразует переносы строк в стиле Unix ($D (а также и $A))
 в переносы строк в стиле Windows}

{Меняет местами значения}
procedure SwapValues(var Value1, Value2: Integer); overload;
procedure SwapValues(var Value1, Value2: String);  overload;

function windows1251_2_WideString(const S: String): WideString;
function WideString_2_windows1251(const WS: WideString): String;
function rk1048_2_WideString(const S: String): WideString;
function WideString_2_rk1048(const WS: WideString): String;

function GetDateTime : String;      // формат DD.MM.YYYY
function GetDateTime2 : String;     // формат YYYYMMDDHHNNSS
function GetDateTime3 : String;     // формат YYYYMMDDHHNN
function GetDateTimeByFormat(ShortDateFormat : string; ShortTimeFormat : string; StrDate : string) : TDateTime;  //превратить string в дату по формату
function GetFormatStrByDateTime(ShortDateFormat : string; ShortTimeFormat : string; Date_ : TDatetime) : string;  //превратить дату в string по формату
function CurDate : String;
function CreateDirEx(const Dir: string): Boolean;

{Получить имя временного файла (уникального)}
function GetUniqTempFile(const Extension : String = 'tmp'): String;

{Возвращает значения настроек БД, которые спрятаны в таблице G_Firm_Rekvizit, пока только значение НДС}
procedure GetBDSettings;

{Делает Execute датакуери}
function ExecSP(SP: TpFIBStoredProc): Boolean;

{Делает Execute датакуери}
function ExecSPTR(SP: TpFIBStoredProc): Boolean;

{Делает Execute датакуери, пришло из салонучета, неохота было анализировать, и сравнивать с верхним ExecSP}
function ExecSPWT(SP: TpFIBStoredProc): Boolean;

{Делает Execute датакуери без коммита}
function ExecSPString(SP: TpFIBStoredProc): String;

{Делает Execute Script}
function ExecScript(SP: TpFIBScripter; Save : Boolean = False): String;

{Делает цвет из Hex в Color}
function HexToTColor( sColor : string ): TColor;

//Аналог NVL
function NVL(const Value, Deflt : OleVariant ) : OleVariant;

{Делает Экспорт оперативных данных - продажи и остатки товаров}
procedure ExportOperData;

{Общая процедура для экспорта, вызывается при закрытии и во время работы по таймеру}
procedure ExportOperDataCommon;

{Делает Read}
function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean;

{Делает Read без TryExcept}
function OpenSPClean(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean;

{Делает Read без Commit}
function ReadSP(SP: TpFIBDataSet): String;

{Сохраняет настройки в INI-файл}
procedure SaveSettingsIni(ModuleName : string; SettName : string; ValInt : Variant; ValStr : string);

{Читает настройки из INI-файл}
function ReadIntSettingsIni(ModuleName : string; SettName : string; DefVal : integer) : integer;

{Читает настройки из INI-файл}
function ReadDoubleSettingsIni(ModuleName : string; SettName : string; DefVal : double) : double;

{Читает настройки из INI-файл}
function ReadStrSettingsIni(ModuleName : string; SettName : string; DefVal : string) : string;

{Возвращает Height, который нужно установить при текущем DPI (то есть при текущем масштабе Windows - 100, 120, 150}
function ScaleDimension(const X: Integer): Integer;

{Проставить галочку пункту в DBTReeList}
procedure SetCheckRoutine(ANode: TcxTreeListNode; ANodeFrom : TcxTreeListNode; Val : Boolean);

{Проставить галочку пункту в DBTReeList}
procedure SetChecks(tl: TcxTreeList; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn);

{Проставить галочку всем пунктам в DBTReeList}
procedure SetChecksAllNone(SP : TpFIBDataSet; tl : TcxDBTreeList; Val : Boolean);

{Поставить фокус на строке}
procedure FocusRowcxGrid(tv : TcxGridDBTableView);

{Поставить фокус на строке}
procedure FocusRowAfterInscxGrid(tv : TcxGridDBTableView);

{Выполнить скрипт}
procedure ExecQuery(SP: TpFIBStoredProc);

{В cxCurrency при UseFormatOnEditing не работает OnValidate = False, все равно проверяется. А если
в поле присутствует знак %, то возникает ошибка. Надо перехватывать и убирать %
Компонент дочерний создать не удалось, потому пришлось делать тут топорно}
function GetOffValidation(S: string; var Error : Boolean) : String;

//процедура заполняющая ZNUM
function FillNumForLicense : String;

//Отправка и обработка SMS
function send_sms_process(sms : SMSC; phone : string; text : string; translit : Integer; time : string;
  var Balance : string; var ErrorCode : Integer; var ErrMsg : string) : Integer;

//Отправка одного SMS
function send_sms_one(phone : string; text : string; translit : Integer; time : string;
  var Balance : string; var ErrorCode : Integer; var ErrMsg : string) : Integer;

//Отправить СМС при создании новой записи к мастеру или счета
procedure SendSmsAfterScheduleCreate(Phone : string; GClient : integer; ClientName : String; TimeNofity : Integer;
edDate : TDate; teTimeBegin : Ttime); //Schedule : integer);

//Транслитерация русского текста
function TranslitRus(const Str: string): string;

//Есть ли хоть один русски символ
function HaveCrSymbol(const Str: string): Boolean;

//Разница в "целых" месяцах между датами, например 06.03.2018 и 25.02.2018 будет 1 месяц
function MonthBetweenMine(date1 : tDate; date2 : TDate) : Integer;

{Div не работает с FLoat числами, поэтому пришлось написать свою}
function MyDiv(Num1 : Double; Num2 : Double): Integer;

//Процедура совершения звонка
function MakeCall(phone : string; action : string; var ErrMsg : string) : Integer;

//Задать количество знаков после запятой для колонки типа TcxEditRepositoryCalcItem
function SetColumnDecimalPlace(col : TcxEditRepositoryCalcItem) : TcxEditRepositoryCalcItem;

//Задать количество знаков после запятой для колонки типа TcxEditRepositoryCurrencyItem
function SetColumnDecimalPlaceCur(col : TcxEditRepositoryCurrencyItem) : TcxEditRepositoryCurrencyItem;

//Установлен ли Ексель
function IsOLEObjectInstalled(Name: String): boolean;

//Получить ошибку связи с сервером
function GetServerConnectError(Error : string): string;

//Удалить файлы из папки по маске
procedure DeleteFilesFromFolder(Path, FileMask : string);

//Найти файлы из папки по маске
procedure GetFiles(APath, AMask: string; AList: TStrings);

//Записать в лог
procedure Log(txt: string);

//Включить LazyLoad
procedure SPLazyLoadEnable(SP : TpFIBDataSet; tv : TcxGridDBTableView);

//Математическое округление
//в Дельфи все родное округление банковское, и число 272,025 округлит как 272,02 а не 272,03
function MathRound(AValue: double; APrecision: integer): double;

function GetTempWindows: string; //Получение папки temp в windows

function GetProcess(FileName: string): Boolean;
function ServiceGetStatus(sMachine, sService: PChar): DWORD;
function ServiceRunning(sMachine, sService: PChar): Boolean;

{==================================================================}
implementation
{==================================================================}

uses
  unDigConversions, unToWord, unInitApp, unInfo;

function GetTempWindows: string;
var
  lng: DWORD;
  thePath: string;
begin
  SetLength(thePath, MAX_PATH) ;
  lng := GetTempPath(MAX_PATH, PChar(thePath)) ;
  SetLength(thePath, lng) ;
  result:= thePath;
end;

procedure Delay(msecs : DWORD);
var
   FirstTick : DWORD;
begin
     FirstTick:=GetTickCount;
     repeat
       Application.ProcessMessages; {Чтобы мастдай не сдох}
     until GetTickCount-FirstTick >= msecs;
end;

function CheckTransparencyAllowed: Boolean;
{Если Windows 2K и выше, прозрачность возможна}
var
  Major: Integer;
  Minor: Integer;
procedure GetWindowsVersion(var Major: Integer; var Minor: Integer);
var
  L : Longint;
begin
  L := GetVersion;
  Major := LoByte(LoWord(L));
  Minor := HiByte(LoWord(L));
end;
begin
  Result := False;
  GetWindowsVersion(Major, Minor);
  if (Major = 5) {а не >= ?)} and (Minor >= 0) then //Windows 2000(NT5) - 5.0, XP 5.1 
    Result := True;
end;

procedure SetTransparent(FrmHWND: HWND; Transparency: Integer);
{Если Windows 2K и выше, устанавливает заданную прозрачность от 0 до 100}
const
  LWA_ALPHA = $2;
  GWL_EXSTYLE = (-20);
  WS_EX_LAYERED = $80000;
var
  WindowLongOld: Longint;
  User32: Cardinal;
  SetLayeredWindowAttributes: function (FrmHWND: HWND; crKey: Byte; bAlpha: Byte;
    dwFlags: LongInt): LongInt; stdcall;
begin
  if CheckTransparencyAllowed then begin
    User32 := LoadLibrary('USER32');
    if User32 <> 0 then
    try
      SetLayeredWindowAttributes := GetProcAddress(User32, 'SetLayeredWindowAttributes');
      if @SetLayeredWindowAttributes <> nil then
      begin
        WindowLongOld := GetWindowLongA(FrmHWND, GWL_EXSTYLE);
        SetWindowLongA(FrmHWND, GWL_EXSTYLE, WindowLongOld or WS_EX_LAYERED);
        SetLayeredWindowAttributes(FrmHWND, 0, (255 * (100 - Transparency)) DIV 100,
          LWA_ALPHA);
      end;
    finally
      FreeLibrary(User32);
    end;
  end;
end;

function GetUserName: String;
var
  S       : String;
  lpBuffer: PChar;
  nSize   : DWORD;
  Ret     : Bool;
begin
  Result := 'UnknownName';
//  nSize := MAX_COMPUTERNAME_LENGTH + 1;
  nSize := 1024;
  SetLength(S, nSize);
  lpBuffer := PChar(S);
  Ret := Windows.GetUserName(lpBuffer, nSize);
  if Ret then
    Result := lpBuffer;
end;

function GetConnectionsCount: Integer;
begin
  with MainDm.spGetConnectCount do begin
    if not Transaction.InTransaction then
      Transaction.StartTransaction;
    Open;
    Result := RecordCount;
    if Transaction.InTransaction then
      Transaction.Rollback;
    Close;
  end;
end;

function GetComputerName: String;
var
  S       : String;
  lpBuffer: PChar;
  nSize   : DWORD;
  Ret     : Bool;
begin
  Result := 'UnknownName';
  nSize := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(S, nSize);
  lpBuffer := PChar(S);
  Ret := Windows.GetComputerName(lpBuffer, nSize);
  if Ret then
    Result := lpBuffer;
end;

function GetIPAddressList: TStringList;
const
  WSVer = $101;
type
  TInAddrArr = array[Byte] of PInAddr;
  PInAddrArr = ^TInAddrArr;
var
  wsaData    : TWSAData;
  P          : PHostEnt;
  Buf        : array [0..127] of Char;
  P_InAddrArr: PInAddrArr;
  i          : Integer;
begin
    Result := TStringList.Create;
    Result.Text := '';

  if WSAStartup(WSVer, wsaData) = 0 then begin
    if GetHostName(@Buf, 128) = 0 then begin
      P := GetHostByName(@Buf);
      if Assigned(P) then begin
        P_InAddrArr := PInAddrArr(P^.h_addr_list);
        i := 0;
        while Assigned(P_InAddrArr^[i]) do begin
          Result.Add(StrPas(Inet_NtoA(P_InAddrArr^[i]^)));
          inc(i);
        end;
      end; {if Assigned(P)}
    end; {if GetHostName(@Buf, 128) = 0}
    WSACleanup;
  end; {if WSAStartup(WSVer, wsaData) = 0}
end;

function GetIPAddressListStr: String;
const
  WSVer = $101;
type
  TInAddrArr = array[Byte] of PInAddr;
  PInAddrArr = ^TInAddrArr;
var
  wsaData    : TWSAData;
  P          : PHostEnt;
  Buf        : array [0..127] of Char;
  P_InAddrArr: PInAddrArr;
  i          : Integer;
begin
    Result := '';

  if WSAStartup(WSVer, wsaData) = 0 then begin
    if GetHostName(@Buf, 128) = 0 then begin
      P := GetHostByName(@Buf);
      if Assigned(P) then begin
        P_InAddrArr := PInAddrArr(P^.h_addr_list);
        i := 0;
        while Assigned(P_InAddrArr^[i]) do begin
          Result := Result + StrPas(Inet_NtoA(P_InAddrArr^[i]^)) + '; ';
          inc(i);
        end;

        if Length(Result) >= 2 then
          Delete(Result, Length(Result) - 1, 2);
      end; {if Assigned(P)}
    end; {if GetHostName(@Buf, 128) = 0}
    WSACleanup;
  end; {if WSAStartup(WSVer, wsaData) = 0}
end;

function GetDiskSerNum(Disk: String): DWORD;
var
  S1, S2                    : String;
  lpRootPathName,
  lpVolumeNameBuffer        : PChar;
  nVolumeNameSize,
  nVolumeSerialNumber,
  lpMaximumComponentLength,
  lpFileSystemFlags         : DWORD;
  lpFileSystemNameBuffer    : PChar;
  nFileSystemNameSize       : DWORD;
  Ret: Bool;
begin
  Result := 0;
  lpRootPathName := PChar(Disk + ':\');
  nVolumeNameSize := 255;
  SetLength(S1, nVolumeNameSize);
  lpVolumeNameBuffer := PChar(S1);
  nFileSystemNameSize := 255;
  SetLength(S2, nFileSystemNameSize);
  lpFileSystemNameBuffer := PChar(S2);

  Ret := Windows.GetVolumeInformation(lpRootPathName, lpVolumeNameBuffer,
           nVolumeNameSize, @nVolumeSerialNumber,
           lpMaximumComponentLength, lpFileSystemFlags,
           lpFileSystemNameBuffer, nFileSystemNameSize);

  if Ret then
    {All OK}
    Result := nVolumeSerialNumber;
end;

function GetDiskSerNumStr(SN: Longword): String;
var
  SNHi,
  SNLo  : Word;
begin
  SNHi := HiWord(SN);
  SNLo := LoWord(SN);
  Result := Word2Hex(SNLo) + Word2Hex(SNHi);
end;

procedure GetPCData(var ComputerName: String; var OSPlatformId, OSMajorVer,
                    OSMinorVer, OSBuildNumber, CPUAmount, CPUType, FixedDrives,
                    DiskCSerNum: DWORD);
var
  lpOSVersionInfo   : TOSVersionInfo;
  lpSystem_Info     : TSystemInfo;
  DrvLetter         : String;
  LogDrives         : DWORD;
  LogDrivesStr,
  FixedDrivesStr    : String;
  i,
  LogDrivesStrLen,
  DrvType           : UINT;
begin
  {Определяем имя компьютера}
  ComputerName := GetComputerName;

  {Определяем тип и версию ОС}
  lpOSVersionInfo.dwOSVersionInfoSize := SizeOf(lpOSVersionInfo);
  if Windows.GetVersionEx(lpOSVersionInfo) then
    with lpOSVersionInfo do begin
      OSPlatformId := dwPlatformId;  {VER_PLATFORM_WIN32s        (0) - Win32s on Windows 3.1}
                                     {VER_PLATFORM_WIN32_WINDOWS (1) - Win32 on Windows 95}
                                     {VER_PLATFORM_WIN32_NT      (2) - Win32 on Windows NT}
      OSMajorVer   := dwMajorVersion;
      OSMinorVer   := dwMinorVersion;
      OSBuildNumber:= dwBuildNumber;
    end
  else begin
    OSPlatformId := 0;
    OSMajorVer   := 0;
    OSMinorVer   := 0;
    OSBuildNumber:= 0;
  end;

  {Определяем тип CPU}
  Windows.GetSystemInfo(lpSystem_Info);
  CPUAmount := lpSystem_Info.dwNumberOfProcessors;
  if lpOSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT then  {Windows NT}
    CPUType := lpSystem_Info.wProcessorLevel  {3 - Intel 386}
                                              {4 - Intel 486}
                                              {5 - Intel Pentium}
                                              {6 - Intel Pentium II}
  else {Windows 95}
    CPUType := lpSystem_Info.dwProcessorType;

  {Определяем жесткие диски}
  {Получаем список логических дисков (битовое представление)}
  LogDrives := Windows.GetLogicalDrives;

  {Заполняем строку логических дисков (правый, младший разряд - диск A)}
  LogDrivesStr := DWord2Bin(LogDrives);

  {Определяем типы дисков для ранее найденных дисков
   и заполняем строку жестких дисков}
  LogDrivesStrLen := Length(LogDrivesStr);
  FixedDrivesStr := '';
  for i := 1 to LogDrivesStrLen do begin
	  if LogDrivesStr[i] = '0' then begin
  		FixedDrivesStr := FixedDrivesStr + '0';
	  	Continue;
  	end;
  	DrvLetter := Char(65 + (LogDrivesStrLen - i));
	  DrvType := Windows.GetDriveType(PChar(DrvLetter + ':\'));
  	if DrvType = 3 then	// Hard Drive
		  FixedDrivesStr := FixedDrivesStr + '1'
    else
  		FixedDrivesStr := FixedDrivesStr + '0';
  end;

  {Строим битовое представление имеющихся жестких дисков (правый, младший разряд - диск A)}
  FixedDrives := Bin2DWord(FixedDrivesStr);

  {Определяем серийный номер диска C}
	DiskCSerNum := GetDiskSerNum('C')
end;

function GetFixedDrivesStr(FixedDrives: DWORD): String;
var
  FixedDrivesStr    : String;
  FixedDrivesStrLen : Byte;
  DrvLetter,
  TmpStr            : String;
  i                 : Byte;
begin
  if FixedDrives = 0 then begin
    Result := 'Жестких дисков нет';
    Exit;
  end;
  {Получаем битовое представление списка жестких дисков}
  FixedDrivesStr := DWord2Bin(FixedDrives);
  {Формируем строку имен жестких дисков}
  FixedDrivesStrLen := Length(FixedDrivesStr);
  TmpStr := '';
  for i := FixedDrivesStrLen downto 1 do begin
    if FixedDrivesStr[i] = '1' then begin
    	DrvLetter := Char(65 + (FixedDrivesStrLen - i));
      TmpStr := TmpStr + DrvLetter + ': ';
    end;
  end;
  Result := TmpStr;
end;

procedure GetPCDataStr(OSPlatformId, CPUType, FixedDrives, DiskCSerNum: DWORD;
                       var OSPlatformIdStr, CPUTypeStr, FixedDrivesStr, DiskCSerNumStr: String);
begin
  case OSPlatformId of
    VER_PLATFORM_WIN32s       : OSPlatformIdStr := 'Win32s на Windows 3.1';  {не может быть}
    VER_PLATFORM_WIN32_WINDOWS: OSPlatformIdStr := 'Windows 95';
    VER_PLATFORM_WIN32_NT     : OSPlatformIdStr := 'Windows NT';
  else
    OSPlatformIdStr := 'Unknown';
  end;

  case CPUType of
    3, 386: CPUTypeStr := 'Intel 386';
    4, 486: CPUTypeStr := 'Intel 486';
    5, 586: CPUTypeStr := 'Intel Pentium';
    6     : CPUTypeStr := 'Intel Pentium II';
  else
    CPUTypeStr := 'Unknown';
  end;

  FixedDrivesStr := GetFixedDrivesStr(FixedDrives);

  DiskCSerNumStr := Word2Hex(HiWord(DiskCSerNum)) + '-' + Word2Hex(LoWord(DiskCSerNum));
end;

function IsHaveRight(RightItem: Integer; RightsArr: array of Integer): Boolean;
var
  i                 : Integer;
  Found             : Boolean;
  RightsArrHighBound: Integer;
begin
  Found := False;
  RightsArrHighBound := High(RightsArr);
  for i := 0 to RightsArrHighBound do
    if RightItem = RightsArr[i] then begin
      Found := True;
      Break;
    end;
  Result := Found;
end;

function IsHaveAnyRight(RightItemsArr, RightsArr: array of Integer): Boolean;
var
  i,j                    : Integer;
  Found                  : Boolean;
  RightItemsArrHighBound,
  RightsArrHighBound     : Integer;
begin
  Found := False;
  RightItemsArrHighBound := High(RightItemsArr);
  RightsArrHighBound := High(RightsArr);
  for i := 0 to RightItemsArrHighBound do begin
    for j := 0 to RightsArrHighBound do
      if RightItemsArr[i] = RightsArr[j] then begin
        Found := True;
        Break;
      end;
    if Found then
      Break;
  end;
  Result := Found;
end;

function CheckSumm(SIn: String; var SOut: String): Boolean;
{Проверяет допустимость суммы и формирует строку для записи в MT-сообщение.
 Убирает все разделители ('.', ',' и пробелы) из исходной строки.
 В выходной строке в качестве разделителя целой и дробной частей ставит ','}
const
  CharBeforeSeparator = 15;
  CharAfterSeparator = 2;
  Separator = ',';
var
  Len           : Integer;
  SpacePos,
  CommaPos,
  PointPos,
  SeparatorPos  : Integer;
  LeftVal,
  RightVal      : String;
  LastSeparator : Char;
  OldDecimalSeparator: Char;
  TestSumm      : Extended;
function CheckIsNumStr(S: String): Boolean;
var
  i   : Integer;
  Len : Integer;
begin
  Result := False;
  Len := Length(S);
  for i := 1 to Len do
    if not CharInSet(S[i], [' ', '.', ',', '0'..'9']) then
      Exit;
  Result := True;
end;
function MinMoreZero(A, B, C: Integer): Integer;
{Возвращает минимальное из трех чисел, большее 0. Если все числа <= 0,
 возвращается 0}
var
  MinAB: Integer;  {Минимальное из A, B, большее 0}
begin
  Result := 0;
  if (A <= 0) and (B <= 0) and (C <= 0) then
    Exit;

  {Находим минимальное из A, B, большее 0 (или 0, если оба <= 0}
  if A <= B then
    if A > 0 then
      MinAB := A
    else
      MinAB := B
  else  {A > B}
    if B > 0 then
      MinAB := B
    else
      MinAB := A;
  {Находим минимальное из MinAB, C, большее 0}
  if MinAB <= C then
    if MinAB > 0 then
      Result := MinAB
    else
      Result := C
  else  {MinAB > C}
    if C > 0 then
      Result := C
    else
      Result := MinAB;
end;

begin
  SOut := '';
  Result := False;
  Len := Length(SIn);
//  if Len < 4 then
//    Exit;

  if Len < 1 then
    Exit;

  {Строка состоит из допустимых символов?}
  if not CheckIsNumStr(SIn) then
    Exit;
  {Есть ли в строке точка или запятая?}
  if (Pos('.', SIn) =  0) and (Pos(',', SIn) = 0) then {Нет ни одного разделителя}
//    Exit;
    SIn := SIn + Separator + '00';

  {Ищем первый разделитель}
  SpacePos := Pos(' ', SIn);
  CommaPos := Pos(',', SIn);
  PointPos := Pos('.', SIn);
  SeparatorPos := MinMoreZero(SpacePos, CommaPos, PointPos);
  {Запоминаем последний разделитель}
  if SeparatorPos = SpacePos then
    LastSeparator := ' '
  else if SeparatorPos = CommaPos then
    LastSeparator := ','
  else
    LastSeparator := '.';

  {Выделяем левую и правую части}
  LeftVal := Copy(SIn, 1, SeparatorPos - 1);
  RightVal := Copy(SIn, SeparatorPos + 1, Len - SeparatorPos);

  {Есть еще разделители?}
  repeat
    SpacePos := Pos(' ', RightVal);
    CommaPos := Pos(',', RightVal);
    PointPos := Pos('.', RightVal);
    SeparatorPos := MinMoreZero(SpacePos, CommaPos, PointPos);
    if SeparatorPos > 0 then begin
      {Запоминаем последний разделитель}
      if SeparatorPos = SpacePos then
        LastSeparator := ' '
      else if SeparatorPos = CommaPos then
        LastSeparator := ','
      else
        LastSeparator := '.';
      LeftVal := LeftVal + Copy(RightVal, 1, SeparatorPos - 1);
      RightVal := Copy(RightVal, SeparatorPos + 1, Len - SeparatorPos);
    end;
  until SeparatorPos = 0;

  {Последний разделитель - точка или запятая?}
  if not CharInSet(LastSeparator, [',', '.']) then
    Exit;

  {До разделителя не меньше 1 знака?}
  if Length(LeftVal) < 1 then
    Exit;
  {До разделителя не больше CharBeforeSeparator знаков?}
  if Length(LeftVal) > CharBeforeSeparator then
    Exit;
  {После разделителя - CharAfterSeparator знаков?}
  if Length(RightVal) <> CharAfterSeparator then
//    Exit;
    begin
      if Length(RightVal) > CharAfterSeparator then
        exit
      else if Length(RightVal) = 1 then
        RightVal := RightVal + '0'
      else
        RightVal := RightVal + '00';
    end;
  {Формируем итоговое число}
  SOut := LeftVal + Separator + RightVal;

  OldDecimalSeparator := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := ',';  {Т.к. SummaOut, возвращаемая ф-ей CheckSumm, содержит ','}
    TestSumm := 0;
    try
      TestSumm := StrToFloat(SOut);
    except
      Exit;
    end;
  finally
    FormatSettings.DecimalSeparator := OldDecimalSeparator;
  end;

  if TestSumm > 0 then
    Result := True;
end;  {CheckSumm}

function CheckSumm(SIn: String; var SOut: String; Decimals: Integer): Boolean;
{Проверяет допустимость суммы, чтобы после десятичной точки было не больше Decimals цифр
 и формирует строку для вставки в FireBird.
 Убирает все разделители ('.', ',' и пробелы) из исходной строки.
 В выходной строке в качестве разделителя целой и дробной частей ставит '.'}
const
  CharBeforeSeparator = 15;
  Separator = '.';
var
  CharAfterSeparator: Integer;
  Len           : Integer;
  SpacePos,
  CommaPos,
  PointPos,
  SeparatorPos  : Integer;
  LeftVal,
  RightVal      : String;
  LastSeparator : Char;
  OldDecimalSeparator: Char;
  TestSumm      : Extended;
function CheckIsNumStr(S: String): Boolean;
var
  i   : Integer;
  Len : Integer;
begin
  Result := False;
  Len := Length(S);
  for i := 1 to Len do
    if not CharInSet(S[i], [' ', '.', ',', '0'..'9']) then
      Exit;
  Result := True;
end;
function MinMoreZero(A, B, C: Integer): Integer;
{Возвращает минимальное из трех чисел, большее 0. Если все числа <= 0,
 возвращается 0}
var
  MinAB: Integer;  {Минимальное из A, B, большее 0}
begin
  Result := 0;
  if (A <= 0) and (B <= 0) and (C <= 0) then
    Exit;

  {Находим минимальное из A, B, большее 0 (или 0, если оба <= 0}
  if A <= B then
    if A > 0 then
      MinAB := A
    else
      MinAB := B
  else  {A > B}
    if B > 0 then
      MinAB := B
    else
      MinAB := A;
  {Находим минимальное из MinAB, C, большее 0}
  if MinAB <= C then
    if MinAB > 0 then
      Result := MinAB
    else
      Result := C
  else  {MinAB > C}
    if C > 0 then
      Result := C
    else
      Result := MinAB;
end;

begin
  SOut := '';
  Result := False;

  CharAfterSeparator := Decimals;

  Len := Length(SIn);
//  if Len < 4 then
//    Exit;

  if Len < 1 then
    Exit;

  {Строка состоит из допустимых символов?}
  if not CheckIsNumStr(SIn) then
    Exit;
  {Есть ли в строке точка или запятая?}
  if (Pos('.', SIn) =  0) and (Pos(',', SIn) = 0) then {Нет ни одного разделителя}
//    Exit;
    SIn := SIn + Separator + '0000';

  {Ищем первый разделитель}
  SpacePos := Pos(' ', SIn);
  CommaPos := Pos(',', SIn);
  PointPos := Pos('.', SIn);
  SeparatorPos := MinMoreZero(SpacePos, CommaPos, PointPos);
  {Запоминаем последний разделитель}
  if SeparatorPos = SpacePos then
    LastSeparator := ' '
  else if SeparatorPos = CommaPos then
    LastSeparator := ','
  else
    LastSeparator := '.';

  {Выделяем левую и правую части}
  LeftVal := Copy(SIn, 1, SeparatorPos - 1);
  RightVal := Copy(SIn, SeparatorPos + 1, Len - SeparatorPos);

  {Есть еще разделители?}
  repeat
    SpacePos := Pos(' ', RightVal);
    CommaPos := Pos(',', RightVal);
    PointPos := Pos('.', RightVal);
    SeparatorPos := MinMoreZero(SpacePos, CommaPos, PointPos);
    if SeparatorPos > 0 then begin
      {Запоминаем последний разделитель}
      if SeparatorPos = SpacePos then
        LastSeparator := ' '
      else if SeparatorPos = CommaPos then
        LastSeparator := ','
      else
        LastSeparator := '.';
      LeftVal := LeftVal + Copy(RightVal, 1, SeparatorPos - 1);
      RightVal := Copy(RightVal, SeparatorPos + 1, Len - SeparatorPos);
    end;
  until SeparatorPos = 0;

  {Последний разделитель - точка или запятая?}
  if not CharInSet(LastSeparator, [',', '.']) then
    Exit;

  {До разделителя не меньше 1 знака?}
  if Length(LeftVal) < 1 then
    Exit;
  {До разделителя не больше CharBeforeSeparator знаков?}
  if Length(LeftVal) > CharBeforeSeparator then
    Exit;
  {После разделителя - не больше CharAfterSeparator знаков?}
  if Length(RightVal) > CharAfterSeparator then
    Exit;

  {Формируем итоговое число}
  SOut := LeftVal + Separator + RightVal;

  OldDecimalSeparator := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := Separator;  {Т.к. SummaOut, возвращаемая ф-ей CheckSumm, содержит '.'}
    TestSumm := 0;
    try
      TestSumm := StrToFloat(SOut);
    except
      Exit;
    end;
  finally
    FormatSettings.DecimalSeparator := OldDecimalSeparator;
  end;

  if TestSumm > 0 then
    Result := True;
end;  {CheckSumm}

procedure DivSumm(S: Extended; var Left, Right: Int64);
const
  CharBeforeSeparator = 15;
  CharAfterSeparator = 2;
var
  SummStr : String;
  PointPos: Integer;
begin
  Left := 0;
  Right := 0;
  SummStr := FloatToStrF(S, ffFixed, CharBeforeSeparator, CharAfterSeparator);
  PointPos := Pos('.', SummStr);
  if PointPos > 0 then begin
    Left  := StrToInt64(Copy(SummStr, 1, PointPos - 1));
    Right := StrToInt64(Copy(SummStr, PointPos + 1, Length(SummStr) - PointPos + 1));
  end
  else begin
    Left := StrToInt64(SummStr);
    Right := 0;
  end;
end;

procedure DivSumm(S: String; var Left, Right: Int64);
var
  PointPos: Integer;
begin
  Left := 0;
  Right := 0;
  PointPos := Pos('.', S);
  if PointPos > 0 then begin
    Left  := StrToInt64(Copy(S, 1, PointPos - 1));
    Right := StrToInt64(Copy(S, PointPos + 1, Length(S) - PointPos + 1));
  end
  else begin
    Left := StrToInt64(S);
    Right := 0;
  end;
end;

function CheckAllIDDifferent(IDArr: array of Integer): Boolean;
var
  HighItem: Integer;
  i, j    : Integer;
begin
  Result := True;
  HighItem := High(IDArr);
  for i := 0 to HighItem - 1 do
    for j := i + 1 to HighItem do
      if IDArr[i] = IDArr[j] then begin
        Result := False;
        Exit;
      end;
end;

function CheckDate(D: TDate; const BeginDateStr, EndDateStr: String): Boolean;
{Проверяет, входит ли D в диапазон BeginDate..EndDate}
{BeginDate, EndDate в формате 'dd.mm.yyyy'}
var
  OldShortDateFormat: String;
  OldDateSeparator: Char;
  BeginDate,
  EndDate: TDate;
begin
  Result := False;

  D := Trunc(D);

  try
    OldShortDateFormat := FormatSettings.ShortDateFormat;
    OldDateSeparator := FormatSettings.DateSeparator;
    FormatSettings.ShortDateFormat := 'ddmmyyyy';
    FormatSettings.DateSeparator := '.';
    try
      BeginDate := StrToDate(BeginDateStr);
      EndDate := StrToDate(EndDateStr);
      if (D >= BeginDate) and (D <= EndDate) then
        Result := True;
    finally
      FormatSettings.ShortDateFormat := OldShortDateFormat;
      FormatSettings.DateSeparator := OldDateSeparator;
    end;
  except
    on EConvertError do MessageDlg('Некорректная дата!', mtError, [mbOk], 0);
  end;
end;  {CheckDate}

function CheckTime(D: TTime): Boolean;
//Проверяет, корректно ли время D
var
  TimeBegin, TimeEnd: TTime;
begin
  Result := False;

  TimeBegin := StrToTime('00:00:00');
  TimeEnd   := StrToTime('23:59:59');

  try
    if (D >= TimeBegin) and (D <= TimeEnd) then
      Result := True;
  except
    on EConvertError do MessageDlg('Некорректная дата!', mtError, [mbOk], 0);
  end;
end;  {CheckTime}

function SummByWords(S: Extended): String;
var
  Tenge  : String;
  Tiin   : String;
begin
  Tenge := TengeToWord(Trunc(S));
  Tiin := Copy(IntToStr(Round(Frac(S) * 100)), 1, 2);

  if Length(Tiin) = 1 then
    Tiin := '0' + Tiin;

  Result := Tenge + Tiin + ' тиин';
end;

function CheckRequizChanged(Owner: TComponent): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Owner.ComponentCount - 1 do BEGIN
    if (Owner.Components[i] is TCustomEdit) then begin
      if (Owner.Components[i] as TCustomEdit).Modified then begin
        Result := True;
        Break;
      end;
    end
    else
      if (Owner.Components[i] is TcxCustomEdit) then begin
        if (Owner.Components[i] as TcxCustomEdit).EditModified then begin
          Result := True;
          Break;
        end;
      end
    {else   оказывается верхний TcxCustomEdit все покрывает
      if (Owner.Components[i].Name is TcxCurrencyEdit) then begin
        if (Owner.Components[i] as TcxCurrencyEdit).ModifiedAfterEnter then begin
          Result := True;
          Break;
        end;
      end }
  END;
end;

function LPad(const S: String; const Len: Integer; const Pad: Char): String;
begin
  Result := StringOfChar(Pad, Len - Length(S)) + S;
end;

function RPad(const S: String; const Len: Integer; const Pad: Char): String;
begin
  Result := S + StringOfChar(Pad, Len - Length(S));
end;

function RCopy(const S: String; const Index, Count: Integer): String;
begin
  {Например: Copy('123456789', 3, 2) = '78'}
  Result := Copy(S, Length(S) - (Index - 1), Count);
end;

{
function PosFrom(SubStr, Str: String; FromPos: Integer): Integer;
var
  TmpStr: String;
  TmpPos: Integer;
begin
  TmpStr := Copy(Str, FromPos, Length(Str) - FromPos + 1);
  TmpPos := Pos(SubStr, TmpStr);
  if TmpPos > 0 then
    Result := (FromPos - 1) + TmpPos
  else
    Result := 0;
end;
}

function PosFrom(const SubStr, Str: String; const FromPos: Integer): Integer;
var
  TmpPcr: PChar;
  TmpPcr1: Pointer;
  TmpPcr2: PChar;
begin
  TmpPcr := @Str[FromPos];
  TmpPcr2 := PChar(SubStr);
  TmpPcr1 := StrPos(TmpPcr, TmpPcr2);
  if TmpPcr1 = Nil then
    Result := 0
  else
    Result := FromPos + (TmpPcr1 - TmpPcr);
end;

function UnixToWindowsCRLF(UnixCRLFStr: String): String;
{Преобразует переносы строк в стиле Unix ($D (а также и $A))
 в переносы строк в стиле Windows}
const
  CR = #13;
  LF = #10;
  CRLF = CR + LF;
var
  CRPos,
  LFPos: Integer;
begin
  if UnixCRLFStr = '' then begin
    Result := '';
    Exit;
  end;

  Result := '';
  {Меняем одиночные CR на CRLF}
  repeat
    CRPos := Pos(CR, UnixCRLFStr);
    if CRPos > 0 then begin
      Result := Result + Copy(UnixCRLFStr, 1, CRPos - 1) + CRLF;
      if CRPos < Length(UnixCRLFStr) then
        if UnixCRLFStr[CRPos + 1] <> LF then
          Delete(UnixCRLFStr, 1, CRPos)
        else
          Delete(UnixCRLFStr, 1, CRPos + 1)
      else
        Delete(UnixCRLFStr, 1, CRPos);
    end;
  until (CRPos = 0) or (UnixCRLFStr = '');

  UnixCRLFStr := Result + UnixCRLFStr;

  Result := '';
  {Меняем одиночные LF на CRLF}
  repeat
    LFPos := Pos(LF, UnixCRLFStr);
    if LFPos > 0 then begin
      if LFPos > 1 then begin
        if UnixCRLFStr[LFPos - 1] <> CR then
          Result := Result + Copy(UnixCRLFStr, 1, LFPos - 1)
        else
          Result := Result + Copy(UnixCRLFStr, 1, LFPos - 2);
        Result := Result + CRLF;
        Delete(UnixCRLFStr, 1, LFPos);
      end
      else begin
        Result := CRLF;
        Delete(UnixCRLFStr, 1, 1);
      end;
    end;
  until (LFPos = 0) or (UnixCRLFStr = '');

  Result := Result + UnixCRLFStr;
end;

{Меняет местами значения}
procedure SwapValues(var Value1, Value2: Integer);
var
  TmpValue: Integer;
begin
  TmpValue  := Value1;
  Value1    := Value2;
  Value2    := TmpValue;
end;

procedure SwapValues(var Value1, Value2: String);
var
  TmpValue: String;
begin
  TmpValue  := Value1;
  Value1    := Value2;
  Value2    := TmpValue;
end;

function windows1251_2_WideString(const S: String): WideString;
begin
  Result := S;
end;

function WideString_2_windows1251(const WS: WideString): String;
begin
  Result := WS;
end;

function rk1048_2_WideString(const S: String): WideString;
var
  i: Integer;
begin
  Result := S;
  for i := 1 to Length(S) do
    case S[i] of
      #$8D: Result[i] := #$049A;
      #$8E: Result[i] := #$04BA;
      #$9D: Result[i] := #$049B;
      #$9E: Result[i] := #$04BB;
      #$A1: Result[i] := #$04B0;
      #$A2: Result[i] := #$04B1;
      #$A3: Result[i] := #$04D8;
      #$A5: Result[i] := #$04E8;
      #$AA: Result[i] := #$0492;
      #$AF: Result[i] := #$04AE;
      #$B2: Result[i] := #$0406;
      #$B3: Result[i] := #$0456;
      #$B4: Result[i] := #$04E9;
      #$BA: Result[i] := #$0493;
      #$BC: Result[i] := #$04D9;
      #$BD: Result[i] := #$04A2;
      #$BE: Result[i] := #$04A3;
      #$BF: Result[i] := #$04AF;
    else
      ; {Оставляем исходный символ без изменений}
    end; {case}

(*
  Result := '';
  for i := 1 to Length(S) do
    case S[i] of
      #$8D: Result := Result + #$049A;
      #$8E: Result := Result + #$04BA;
      #$9D: Result := Result + #$049B;
      #$9E: Result := Result + #$04BB;
      #$A1: Result := Result + #$04B0;
      #$A2: Result := Result + #$04B1;
      #$A3: Result := Result + #$04D8;
      #$A5: Result := Result + #$04E8;
      #$AA: Result := Result + #$0492;
      #$AF: Result := Result + #$04AE;
      #$B2: Result := Result + #$0406;
      #$B3: Result := Result + #$0456;
      #$B4: Result := Result + #$04E9;
      #$BA: Result := Result + #$0493;
      #$BC: Result := Result + #$04D9;
      #$BD: Result := Result + #$04A2;
      #$BE: Result := Result + #$04A3;
      #$BF: Result := Result + #$04AF;
{
      #$8D: Result := Result + WideChar(#$049A);
      #$8E: Result := Result + WideChar(#$04BA);
      #$9D: Result := Result + WideChar(#$049B);
      #$9E: Result := Result + WideChar(#$04BB);
      #$A1: Result := Result + WideChar(#$04B0);
      #$A2: Result := Result + WideChar(#$04B1);
      #$A3: Result := Result + WideChar(#$04D8);
      #$A5: Result := Result + WideChar(#$04E8);
      #$AA: Result := Result + WideChar(#$0492);
      #$AF: Result := Result + WideChar(#$04AE);
      #$B2: Result := Result + WideChar(#$0406);
      #$B3: Result := Result + WideChar(#$0456);
      #$B4: Result := Result + WideChar(#$04E9);
      #$BA: Result := Result + WideChar(#$0493);
      #$BC: Result := Result + WideChar(#$04D9);
      #$BD: Result := Result + WideChar(#$04A2);
      #$BE: Result := Result + WideChar(#$04A3);
      #$BF: Result := Result + WideChar(#$04AF);
}
    else
//      Result := Result + WideChar(S[i]); {Неправильно}
      Result := Result + S[i];
    end; {case}
//  Result := Result;
*)
end;

function WideString_2_rk1048(const WS: WideString): String;
var
  i: Integer;
begin
  Result := WS;
  for i := 1 to Length(WS) do
    case WS[i] of
      #$049A: Result[i] := #$8D;
      #$04BA: Result[i] := #$8E;
      #$049B: Result[i] := #$9D;
      #$04BB: Result[i] := #$9E;
      #$04B0: Result[i] := #$A1;
      #$04B1: Result[i] := #$A2;
      #$04D8: Result[i] := #$A3;
      #$04E8: Result[i] := #$A5;
      #$0492: Result[i] := #$AA;
      #$04AE: Result[i] := #$AF;
      #$0406: Result[i] := #$B2;
      #$0456: Result[i] := #$B3;
      #$04E9: Result[i] := #$B4;
      #$0493: Result[i] := #$BA;
      #$04D9: Result[i] := #$BC;
      #$04A2: Result[i] := #$BD;
      #$04A3: Result[i] := #$BE;
      #$04AF: Result[i] := #$BF;
    else
      ; {Оставляем исходный символ без изменений}
    end; {case}
(*
  Result := '';
  for i := 1 to Length(WS) do
    case WS[i] of
      #$049A: Result := Result + #$8D;
      #$04BA: Result := Result + #$8E;
      #$049B: Result := Result + #$9D;
      #$04BB: Result := Result + #$9E;
      #$04B0: Result := Result + #$A1;
      #$04B1: Result := Result + #$A2;
      #$04D8: Result := Result + #$A3;
      #$04E8: Result := Result + #$A5;
      #$0492: Result := Result + #$AA;
      #$04AE: Result := Result + #$AF;
      #$0406: Result := Result + #$B2;
      #$0456: Result := Result + #$B3;
      #$04E9: Result := Result + #$B4;
      #$0493: Result := Result + #$BA;
      #$04D9: Result := Result + #$BC;
      #$04A2: Result := Result + #$BD;
      #$04A3: Result := Result + #$BE;
      #$04AF: Result := Result + #$BF;
{
      #$049A: Result := Result + char(#$8D);
      #$04BA: Result := Result + char(#$8E);
      #$049B: Result := Result + char(#$9D);
      #$04BB: Result := Result + char(#$9E);
      #$04B0: Result := Result + char(#$A1);
      #$04B1: Result := Result + char(#$A2);
      #$04D8: Result := Result + char(#$A3);
      #$04E8: Result := Result + char(#$A5);
      #$0492: Result := Result + char(#$AA);
      #$04AE: Result := Result + char(#$AF);
      #$0406: Result := Result + char(#$B2);
      #$0456: Result := Result + char(#$B3);
      #$04E9: Result := Result + char(#$B4);
      #$0493: Result := Result + char(#$BA);
      #$04D9: Result := Result + char(#$BC);
      #$04A2: Result := Result + char(#$BD);
      #$04A3: Result := Result + char(#$BE);
      #$04AF: Result := Result + char(#$BF);
}
    else
//      Result := Result + char(WS[i]); {Неправильно}
      Result := Result + WS[i];
    end; {case}
//  Result := Result;
*)

end;

function GetDateTime : String;
Var Tmp : string;
Begin
   DateTimeToString(Tmp, 'DD.MM.YYYY HH:NN:SS', Now);
   Result := Tmp;
End;

function GetDateTime2 : String;
Var Tmp : string;
Begin
   DateTimeToString(Tmp, 'YYYYMMDDHHNNSS', Now);
   Result := Tmp;
End;

function GetDateTime3 : String;
Var Tmp : string;
Begin
   DateTimeToString(Tmp, 'YYYY-MM-DD HH:NN', Now);
   Result := Tmp;
End;

function GetDateTimeByFormat(ShortDateFormat : string; ShortTimeFormat : string; StrDate : string) : TDateTime;  //превратить string в дату по формату
var
  MySettings: TFormatSettings;
begin
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, MySettings);
  MySettings.DateSeparator := '-';
  MySettings.TimeSeparator := ':';
  MySettings.ShortDateFormat := ShortDateFormat; //'yyyy-mm-dd';
  MySettings.ShortTimeFormat := ShortTimeFormat; //'hh:nn:ss';

  result := StrToDateTime(StrDate, MySettings);
end;

function GetFormatStrByDateTime(ShortDateFormat : string; ShortTimeFormat : string;
Date_ : TDatetime) : string;  //превратить дату в string по формату
var
  MySettings: TFormatSettings;
begin
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, MySettings);
  MySettings.DateSeparator := '-';
  MySettings.TimeSeparator := ':';
  MySettings.ShortDateFormat := ShortDateFormat; //'yyyy-mm-dd';
  MySettings.ShortTimeFormat := ShortTimeFormat; //'hh:nn:ss';

  result := DateTimeToStr(Date_, MySettings);
end;

function CurDate: String;
var
   tmp : String;
begin
  DateTimeToString(Tmp, 'YYYYMMDD', date);
  Result := Tmp;
end;

function CreateDirEx(const Dir: string): Boolean;
{Создает каталог, заданный полным путем, например:
 C:\MyDir1\MyDir2\MyDir3}
var
  Len     : Integer;
  TmpDir  : String;
  i       : Integer;
begin
  Result := True;
  Len := Length(Dir);
  i := 1;
  TmpDir := '';
  repeat
    {Получаем очередной каталог пути}
    while (i <= Len) and (Dir[i] <> '\') do begin
      TmpDir := TmpDir + Dir[i];
      inc(i);
    end;
    {Если каталог не существует, пытаемся создать его}
    if not DirectoryExists(TmpDir) then
      if not CreateDir(TmpDir) then begin
        Result := False;
        Exit;
      end;
    if (i <= Len) and (Dir[i] = '\') then begin
      TmpDir := TmpDir + '\';
      inc(i);
    end;
    while (i <= Len) and (Dir[i] = '\') do
      inc(i);
  until i > Len;
end;

{Получить имя временного файла (уникального)}
function GetUniqTempFile(const Extension : String = 'tmp') : String;
var
  TempFilePath  : String;
  TempFileName  : String;
  TmpValue      : String;
  Guid          : TGuid;
begin
  Result := '';

  CreateGUID(Guid);
  TmpValue := GUIDToString(Guid);

  {Путь к папке TEMP}
  SetLength(TempFilePath, MAX_PATH + 10);
  {Получить путь к папке TEMP}
  GetTempPath(MAX_PATH + 10, @TempFilePath[1]);

  TempFilePath := PChar(TempFilePath);
  TempFileName := IncludeTrailingBackslash(TempFilePath) + TmpValue + '.' + Extension;

  Result := TempFileName;
end;

procedure GetBDSettings;
{Возвращает значения настроек БД, которые спрятаны в таблице G_Firm_Rekvizit,
пока только значение НДС
А также то, что в таблице System_Setup}
begin
  if not MainDM.dbMain.Connected then
    {Не подключены к БД}
    Exit;

  try
    if not MainDM.spGetSettings.Transaction.InTransaction then
      MainDM.spGetSettings.Transaction.StartTransaction;

    with MainDM.spGetSettings do begin
      ExecProc;
      NdsValue  := ParamByName('NDS_VALUE_').AsFloat;
    end;

    if MainDM.spGetSettings.Transaction.InTransaction then
      MainDM.spGetSettings.Transaction.Commit;

    // беру настройки, которые хранятся в SystemSetup
    MainDM.spGetSystemSetup.ParamByName('system_setup_').AsFloat := 5;
    ExecSp(MainDM.spGetSystemSetup);
    SyncCurCompId := StrToInt(FloatToStr(MainDM.spGetSystemSetup.ParamByName('s_value_').AsFloat));

    MainDM.spGetSystemSetup.ParamByName('system_setup_').AsFloat := 6;
    ExecSp(MainDM.spGetSystemSetup);

    SyncId := MainDM.spGetSystemSetup.ParamByName('str_value_').AsString;

    MainDM.spGetSystemSetup.ParamByName('system_setup_').AsFloat := 2;
    ExecSp(MainDM.spGetSystemSetup);
    AllowSellAbsGoods := StrToInt(FloatToStr(MainDM.spGetSystemSetup.ParamByName('s_value_').AsFloat));
  except
    on E: EFIBError do begin
      if MainDM.spGetSettings.Transaction.InTransaction then
        MainDM.spGetSettings.Transaction.Rollback;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in unCommonFunc.GetBDSettings)');
    end;
    on E: Exception do begin
      if MainDM.spGetSettings.Transaction.InTransaction then
        MainDM.spGetSettings.Transaction.Rollback;
      MessageDlg(E.Message + #13#10'(occured in unCommonFunc.GetBDSettings)', mtError, [mbOk], 0);
    end;
  end;
end;

function ExecSP(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;

  with SP do begin
    if SP.Database.Connected then begin
      try
        if not Transaction.InTransaction then
          Transaction.StartTransaction;

        ExecProc;

        if FieldIndex['ERR_CODE'] >= 0 then begin
          ErrCode := ParamByName('ERR_CODE').AsInteger;
          if (ErrCode <> 0) AND (ErrCode <> -900) then begin
            if SP.Transaction.InTransaction then
              SP.Transaction.Rollback;
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
      except
        on E: EFIBError do begin
          if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
            if SP.Database.Connected then begin
              MessageDlg(GetServerConnectError(e.Message), mtError, [mbOk], 0);
              SP.Database.Connected := False;
            end;
          end;
        end;
      end;
    end;
  end;

  Result := True;
end;

function ExecSPTR(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;

  with SP do begin
    if SP.Database.Connected then begin
      try
        if not Transaction.InTransaction then
          Transaction.StartTransaction;

        ExecProc;

        if FieldIndex['ERR_CODE'] >= 0 then begin
          ErrCode := ParamByName('ERR_CODE').AsInteger;
          if (ErrCode <> 0) AND (ErrCode <> -900) then begin
            if SP.Transaction.InTransaction then
              SP.Transaction.Rollback;
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
      except
        on E: EFIBError do begin
          if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
            if SP.Database.Connected then begin
              MessageDlg(GetServerConnectError(e.Message), mtError, [mbOk], 0);
              SP.Database.Connected := False;
            end;
          end
          else begin
            if SP.Transaction.InTransaction then
              SP.Transaction.CommitRetaining;
            DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in unCommonFunc.OpenSP)');
          end;
          Exit;
        end;
      end;
    end;
  end;

  Result := True;
end;

function ExecSPString(SP: TpFIBStoredProc): String;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
begin
  Result := '';

  with SP do begin
    if SP.Database.Connected then begin
      try
        if not Transaction.InTransaction then
          Transaction.StartTransaction;

        ExecProc;

        if FieldIndex['ERR_CODE'] >= 0 then begin
          if (ParamByName('ERR_CODE').AsInteger <> 0) AND (ParamByName('ERR_CODE').AsInteger <> -900) then begin
            if SP.Transaction.InTransaction then
              SP.Transaction.Rollback;
            if FieldIndex['ERR_MSG'] >= 0 then begin
              Result := 'Ошибка. ' + ParamByName('ERR_MSG').AsString;
            end
            else
              Result := 'Ошибка. Error code: ' + ParamByName('ERR_CODE').AsString;
            Exit;
          end;
        end;

        //if Transaction.InTransaction then
        //  Transaction.Commit;
      except
        on E: EFIBError do begin
          if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
            if SP.Database.Connected then begin
              Result := 'Ошибка. ' + GetServerConnectError(e.Message);
              SP.Database.Connected := False;
            end;
          end
          else begin
            if SP.Transaction.InTransaction then
              SP.Transaction.Rollback;
            Result := 'Ошибка. ' + IntToStr(E.SQLCode) + '. ' + E.Message;
          end;
          Exit;
        end;
      end;
    end;
  end;
end;

{Делает Экспорт оперативных данных - продажи и остатки товаров}
procedure ExportOperData;
var fs: TFileStream;
  SL:TStringList;
  zakaz_old, sklad_old : Int64;
  head_filled : Boolean;
  tovarIdOld, priceOld, catNameOld, totalOld : string;
begin
  if DirectoryExists(ExportPath) then begin
    if Copy(ExportDataType, 1, 1) = '1' then begin
      ReportsDM.PrepareReport(7);
      ReportsDM.spReport.ParamByName('date_begin_').AsDate := Now;
      ReportsDM.spReport.ParamByName('date_end_').AsDate := Now;
      ReportsDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
      ReportsDM.ShowReport(3, ExportPath + 'Продажи '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
    end;

    if Copy(ExportDataType, 2, 1) = '1' then begin
      ReportsDM.PrepareReport(12);
      ReportsDM.spReport.ParamByName('INCLUDE_NOL_').AsInteger := 0;
      ReportsDM.spReport.ParamByName('INCLUDE_FEW_').AsInteger := 0;
      ReportsDM.spReport.ParamByName('SORT_BY_NAME_').AsInteger := 0;
      ReportsDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
      ReportsDM.ShowReport(3, ExportPath + 'Остатки товаров ' + CurSkladName + ' на ' + DateToStr(Date) + '.xls');
    end;

    if Copy(ExportDataType, 3, 1) = '1' then begin
      try
        SL:= TStringList.Create;
        SL.Add('<?xml version="1.0" encoding="windows-1251"?>');
        SL.ADD('<PRODUCTS>');
        OpenSP(ReportsDM.spGetProductList, False);
        with ReportsDM.spGetProductList do begin
          First;
          while not Eof do begin
            if (FieldByName('g_product').AsString <> tovarIdOld) or (tovarIdOld = '') then begin
              if tovarIdOld <> '' then begin
                SL.Add('        <TOTAL>' + totalOld + '</TOTAL>');
                SL.Add('    </AMOUNT>');
                SL.Add('    <PRICE>' + priceOld + '</PRICE>');
                SL.Add('    <CATEGORY>' + catNameOld + '</CATEGORY>');
                SL.Add('  </PRODUCT>');
              end;

              SL.Add('  <PRODUCT>');
              SL.Add('    <BARCODE>' + FieldByName('barcode').AsString + '</BARCODE>');
              SL.Add('    <ARTICUL>' + FieldByName('ARTICUL').AsString + '</ARTICUL>');
              SL.Add('    <NAME>' + FieldByName('NAME').AsString + '</NAME>');
              SL.Add('    <AMOUNT>');
              SL.Add('        <SKLAD>' + FieldByName('TOCHKA_NAME').AsString + '</SKLAD>');
              SL.Add('        <AMOUNT_CUR>' + FieldByName('AMOUNT').AsString + '</AMOUNT_CUR>');
            end else begin
              SL.Add('        <SKLAD>' + FieldByName('TOCHKA_NAME').AsString + '</SKLAD>');
              SL.Add('        <AMOUNT_CUR>' + FieldByName('AMOUNT').AsString + '</AMOUNT_CUR>');
            end;

            tovarIdOld := FieldByName('G_PRODUCT').AsString;
            totalOld   := FieldByName('TOTAL').AsString;
            priceOld   := FieldByName('PRICE').AsString;
            catNameOld := FieldByName('CAT_NAME').AsString;
            Next;
          end;
          SL.Add('        <TOTAL>' + totalOld + '</TOTAL>');
          SL.Add('    </AMOUNT>');
          SL.Add('    <PRICE>' + priceOld + '</PRICE>');
          SL.Add('    <CATEGORY>' + catNameOld + '</CATEGORY>');
          SL.Add('  </PRODUCT>');
          SL.Add('</PRODUCTS>');
        end;

        fs:=TFileStream.Create(ExportPath + GetDateTime2 + '.xml', fmCreate);
        SL.SaveToStream(fs);
      finally
        fs.Free;
        SL.Free;
      end;
    end;

    if Copy(ExportDataType, 4, 1) = '1' then begin
      ReportsDM.PrepareReport(46);
      ReportsDM.spReport.ParamByName('date_begin_').AsDate := Now;
      ReportsDM.spReport.ParamByName('date_end_').AsDate := Now;
      ReportsDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
      ReportsDM.ShowReport(3, ExportPath + 'Прибыль '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
    end;

    // продажи в формате XML
    if Copy(ExportDataType, 5, 1) = '1' then begin
      try
        ReportsDM.spUniversal.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_)';
        ReportsDM.spUniversal.ParamByName('OBJECT_TYPE_').AsInteger := 1;
        OpenSP(ReportsDM.spUniversal, False);
        if ReportsDM.spUniversal.RecordCount > 0 then begin
          try
            try
              ReportsDM.spUniversalWrite.SelectSQL.Text := 'DELETE FROM SYNC_EXT_APP WHERE SYNC_EXT_APP = :SYNC_EXT_APP_';

              SL:= TStringList.Create;
              SL.Add('<?xml version="1.0" encoding="windows-1251"?>');
              SL.Add('<Sales>');

              with ReportsDM.spUniversal do begin
                First;
                zakaz_old := FieldByName('ZAKAZ').AsLargeInt;
                head_filled := false;
                while not Eof do begin
                  if zakaz_old <> FieldByName('ZAKAZ').AsLargeInt then begin
                    SL.Add('    </Items>');
                    SL.Add('  </Sale>');

                    head_filled := false;
                  end;

                  if not head_filled then begin
                    head_filled := True;
                    SL.ADD('  <Sale>');
                    SL.Add('    <Oper>' + FieldByName('OPER').AsString + '</Oper>');
                    SL.Add('    <Code>' + FieldByName('ZAKAZ').AsString + '</Code>');
                    SL.Add('    <Date>' + FieldByName('Z_DATE').AsString + '</Date>');
                    SL.Add('    <Client>' + FieldByName('CLIENT_NAME').AsString + '</Client>');
                    SL.Add('    <Sklad>' + FieldByName('SKLAD_NAME').AsString + '</Sklad>');
                    SL.Add('    <SummCash>' + FieldByName('SUMM_CASH').AsString + '</SummCash>');
                    SL.Add('    <SummNonCash>' + FieldByName('SUMM_NONCASH').AsString + '</SummNonCash>');
                    SL.Add('    <SummSert>' + FieldByName('SUMM_SERT').AsString + '</SummSert>');
                    SL.Add('    <Items>');
                  end;
                  SL.Add('      <Item>');
                  SL.Add('        <Articul>' + FieldByName('ARTICUL').AsString + '</Articul>');
                  SL.Add('        <Barcode>' + FieldByName('BARCODE').AsString + '</Barcode>');
                  SL.Add('        <Nomenclatur>' + FieldByName('NOMENCLATUR_NUM').AsString + '</Nomenclatur>');
                  SL.Add('        <Name>' + FieldByName('TOVAR_NAME').AsString + '</Name>');
                  SL.Add('        <Quantity>' + FieldByName('AMOUNT').AsString + '</Quantity>');
                  SL.Add('        <Price>' + FieldByName('PRICE').AsString + '</Price>');
                  SL.Add('        <Summ>' + FieldByName('SUMM').AsString + '</Summ>');
                  SL.Add('      </Item>');

                  zakaz_old := FieldByName('ZAKAZ').AsLargeInt;

                  // удаляю строку из очереди
                  ReportsDM.spUniversalWrite.ParamByName('SYNC_EXT_APP_').AsInt64 := FieldByName('SYNC_EXT_APP').AsLargeInt;
                  OpenSP(ReportsDM.spUniversalWrite, False);

                  Next;
                end;
              end;
              SL.Add('    </Items>');
              SL.Add('  </Sale>');
              SL.Add('</Sales>');

              fs:=TFileStream.Create(ExportPath + 'sales' + GetDateTime2 + '.xml', fmCreate);
              SL.SaveToStream(fs);

              if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
            except
              on E: EFIBError do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
              on E: Exception do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
            end;
          finally
            fs.Free;
            SL.Free;
          end;
        end;
      finally
        ReportsDM.spUniversal.Close;
      end;
    end;

    if Copy(ExportDataType, 6, 1) = '1' then begin
      try
        ReportsDM.spUniversal.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_)';
        ReportsDM.spUniversal.ParamByName('OBJECT_TYPE_').AsInteger := 2;
        OpenSP(ReportsDM.spUniversal, False);
        if ReportsDM.spUniversal.RecordCount > 0 then begin
          try
            try
              ReportsDM.spUniversalWrite.SelectSQL.Text := 'DELETE FROM SYNC_EXT_APP WHERE SYNC_EXT_APP = :SYNC_EXT_APP_';

              SL:= TStringList.Create;
              SL.Add('<?xml version="1.0" encoding="windows-1251"?>');
              SL.Add('<Arrivals>');

              with ReportsDM.spUniversal do begin
                First;
                sklad_old := FieldByName('ZAKAZ').AsLargeInt;
                head_filled := false;
                while not Eof do begin
                  if sklad_old <> FieldByName('ZAKAZ').AsLargeInt then begin
                    SL.Add('    </Items>');
                    SL.Add('  </Arrival>');

                    head_filled := false;
                  end;

                  if not head_filled then begin
                    head_filled := True;
                    SL.ADD('  <Arrival>');
                    SL.Add('    <Oper>' + FieldByName('OPER').AsString + '</Oper>');
                    SL.Add('    <Code>' + FieldByName('ZAKAZ').AsString + '</Code>');
                    SL.Add('    <Date>' + FieldByName('Z_DATE').AsString + '</Date>');
                    SL.Add('    <Provider>' + FieldByName('CLIENT_NAME').AsString + '</Provider>');
                    SL.Add('    <Sklad>' + FieldByName('SKLAD_NAME').AsString + '</Sklad>');
                    SL.Add('    <SummCash>' + FieldByName('SUMM_CASH').AsString + '</SummCash>');
                    SL.Add('    <SummNonCash>' + FieldByName('SUMM_NONCASH').AsString + '</SummNonCash>');
                    SL.Add('    <Items>');
                  end;
                  SL.Add('      <Item>');
                  SL.Add('        <Articul>' + FieldByName('ARTICUL').AsString + '</Articul>');
                  SL.Add('        <Barcode>' + FieldByName('BARCODE').AsString + '</Barcode>');
                  SL.Add('        <Nomenclatur>' + FieldByName('NOMENCLATUR_NUM').AsString + '</Nomenclatur>');
                  SL.Add('        <Name>' + FieldByName('TOVAR_NAME').AsString + '</Name>');
                  SL.Add('        <Quantity>' + FieldByName('AMOUNT').AsString + '</Quantity>');
                  SL.Add('        <Price>' + FieldByName('PRICE').AsString + '</Price>');
                  SL.Add('        <Summ>' + FieldByName('SUMM').AsString + '</Summ>');
                  SL.Add('      </Item>');

                  sklad_old := FieldByName('ZAKAZ').AsLargeInt;

                  // удаляю строку из очереди
                  ReportsDM.spUniversalWrite.ParamByName('SYNC_EXT_APP_').AsInt64 := FieldByName('SYNC_EXT_APP').AsLargeInt;
                  OpenSP(ReportsDM.spUniversalWrite, False);

                  Next;
                end;
              end;
              SL.Add('    </Items>');
              SL.Add('  </Arrival>');
              SL.Add('</Arrivals>');

              fs:=TFileStream.Create(ExportPath + 'arrivals' + GetDateTime2 + '.xml', fmCreate);
              SL.SaveToStream(fs);

              if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
            except
              on E: EFIBError do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
              on E: Exception do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
            end;
          finally
            fs.Free;
            SL.Free;
          end;
        end;
      finally
        ReportsDM.spUniversal.Close;
      end;
    end;
  end;
end;

{Общая процедура для экспорта, вызывается при закрытии и во время работы по таймеру}
procedure ExportOperDataCommon;
var fs: TFileStream;
  SL:TStringList;
  zakaz_old, sklad_old : Int64;
  head_filled : Boolean;
  tovarId, tovarIdOld, priceOld, catNameOld, totalOld : string;
begin
  if DirectoryExists(ExportPath) then begin
    if Copy(ExportDataType, 1, 1) = '1' then begin
      ReportsDM.PrepareReport(7);
      ReportsDM.spReport.ParamByName('date_begin_').AsDate := Now;
      ReportsDM.spReport.ParamByName('date_end_').AsDate := Now;
      ReportsDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
      ReportsDM.ShowReport(3, ExportPath + 'Продажи '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
    end;

    if Copy(ExportDataType, 2, 1) = '1' then begin
      ReportsDM.PrepareReport(12);
      ReportsDM.spReport.ParamByName('INCLUDE_NOL_').AsInteger := 0;
      ReportsDM.spReport.ParamByName('INCLUDE_FEW_').AsInteger := 0;
      ReportsDM.spReport.ParamByName('SORT_BY_NAME_').AsInteger := 0;
      ReportsDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
      ReportsDM.ShowReport(3, ExportPath + 'Остатки товаров ' + CurSkladName + ' на ' + DateToStr(Date) + '.xls');
    end;

    if Copy(ExportDataType, 3, 1) = '1' then begin
      try
        SL:= TStringList.Create;
        SL.Add('<?xml version="1.0" encoding="windows-1251"?>');
        SL.ADD('<PRODUCTS>');
        OpenSP(ReportsDM.spGetProductList, False);
        with ReportsDM.spGetProductList do begin
          First;
          while not Eof do begin
            if (FieldByName('g_product').AsString <> tovarIdOld) or (tovarIdOld = '') then begin
              if tovarIdOld <> '' then begin
                SL.Add('        <TOTAL>' + totalOld + '</TOTAL>');
                SL.Add('    </AMOUNT>');
                SL.Add('    <PRICE>' + priceOld + '</PRICE>');
                SL.Add('    <CATEGORY>' + catNameOld + '</CATEGORY>');
                SL.Add('  </PRODUCT>');
              end;

              SL.Add('  <PRODUCT>');
              SL.Add('    <BARCODE>' + FieldByName('barcode').AsString + '</BARCODE>');
              SL.Add('    <ARTICUL>' + FieldByName('ARTICUL').AsString + '</ARTICUL>');
              SL.Add('    <NAME>' + FieldByName('NAME').AsString + '</NAME>');
              SL.Add('    <AMOUNT>');
              SL.Add('        <SKLAD>' + FieldByName('TOCHKA_NAME').AsString + '</SKLAD>');
              SL.Add('        <AMOUNT_CUR>' + FieldByName('AMOUNT').AsString + '</AMOUNT_CUR>');
            end else begin
              SL.Add('        <SKLAD>' + FieldByName('TOCHKA_NAME').AsString + '</SKLAD>');
              SL.Add('        <AMOUNT_CUR>' + FieldByName('AMOUNT').AsString + '</AMOUNT_CUR>');
            end;

            tovarIdOld := FieldByName('G_PRODUCT').AsString;
            totalOld   := FieldByName('TOTAL').AsString;
            priceOld   := FieldByName('PRICE').AsString;
            catNameOld := FieldByName('CAT_NAME').AsString;
            Next;
          end;
          SL.Add('        <TOTAL>' + totalOld + '</TOTAL>');
          SL.Add('    </AMOUNT>');
          SL.Add('    <PRICE>' + priceOld + '</PRICE>');
          SL.Add('    <CATEGORY>' + catNameOld + '</CATEGORY>');
          SL.Add('  </PRODUCT>');
          SL.Add('</PRODUCTS>');
        end;

        fs:=TFileStream.Create(ExportPath + GetDateTime2 + '.xml', fmCreate);
        SL.SaveToStream(fs);
      finally
        fs.Free;
        SL.Free;
      end;
    end;

    if Copy(ExportDataType, 4, 1) = '1' then begin
      ReportsDM.PrepareReport(46);
      ReportsDM.spReport.ParamByName('date_begin_').AsDate := Now;
      ReportsDM.spReport.ParamByName('date_end_').AsDate := Now;
      ReportsDM.spReport.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
      ReportsDM.ShowReport(3, ExportPath + 'Прибыль '+ CurSkladName + ' за ' + DateToStr(Date) + '.xls');
    end;

    // продажи в формате XML
    if Copy(ExportDataType, 5, 1) = '1' then begin
      try
        ReportsDM.spUniversal.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_)';
        ReportsDM.spUniversal.ParamByName('OBJECT_TYPE_').AsInteger := 1;
        OpenSP(ReportsDM.spUniversal, False);
        if ReportsDM.spUniversal.RecordCount > 0 then begin
          try
            try
              ReportsDM.spUniversalWrite.SelectSQL.Text := 'DELETE FROM SYNC_EXT_APP WHERE SYNC_EXT_APP = :SYNC_EXT_APP_';

              SL:= TStringList.Create;
              SL.Add('<?xml version="1.0" encoding="windows-1251"?>');
              SL.Add('<Sales>');

              with ReportsDM.spUniversal do begin
                First;
                zakaz_old := FieldByName('ZAKAZ').AsLargeInt;
                head_filled := false;
                while not Eof do begin
                  if zakaz_old <> FieldByName('ZAKAZ').AsLargeInt then begin
                    SL.Add('    </Items>');
                    SL.Add('  </Sale>');

                    head_filled := false;
                  end;

                  if not head_filled then begin
                    head_filled := True;
                    SL.ADD('  <Sale>');
                    SL.Add('    <Oper>' + FieldByName('OPER').AsString + '</Oper>');
                    SL.Add('    <Code>' + FieldByName('ZAKAZ').AsString + '</Code>');
                    SL.Add('    <Date>' + FieldByName('Z_DATE').AsString + '</Date>');
                    SL.Add('    <Client>' + FieldByName('CLIENT_NAME').AsString + '</Client>');
                    SL.Add('    <Sklad>' + FieldByName('SKLAD_NAME').AsString + '</Sklad>');
                    SL.Add('    <SummCash>' + FieldByName('SUMM_CASH').AsString + '</SummCash>');
                    SL.Add('    <SummNonCash>' + FieldByName('SUMM_NONCASH').AsString + '</SummNonCash>');
                    SL.Add('    <SummSert>' + FieldByName('SUMM_SERT').AsString + '</SummSert>');
                    SL.Add('    <Items>');
                  end;
                  SL.Add('      <Item>');
                  SL.Add('        <Articul>' + FieldByName('ARTICUL').AsString + '</Articul>');
                  SL.Add('        <Barcode>' + FieldByName('BARCODE').AsString + '</Barcode>');
                  SL.Add('        <Nomenclatur>' + FieldByName('NOMENCLATUR_NUM').AsString + '</Nomenclatur>');
                  SL.Add('        <Name>' + FieldByName('TOVAR_NAME').AsString + '</Name>');
                  SL.Add('        <Quantity>' + FieldByName('AMOUNT').AsString + '</Quantity>');
                  SL.Add('        <Price>' + FieldByName('PRICE').AsString + '</Price>');
                  SL.Add('        <Summ>' + FieldByName('SUMM').AsString + '</Summ>');
                  SL.Add('      </Item>');

                  zakaz_old := FieldByName('ZAKAZ').AsLargeInt;

                  // удаляю строку из очереди
                  ReportsDM.spUniversalWrite.ParamByName('SYNC_EXT_APP_').AsInt64 := FieldByName('SYNC_EXT_APP').AsLargeInt;
                  OpenSP(ReportsDM.spUniversalWrite, False);

                  Next;
                end;
              end;
              SL.Add('    </Items>');
              SL.Add('  </Sale>');
              SL.Add('</Sales>');

              fs:=TFileStream.Create(ExportPath + 'sales' + GetDateTime2 + '.xml', fmCreate);
              SL.SaveToStream(fs);

              if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
            except
              on E: EFIBError do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
              on E: Exception do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
            end;
          finally
            fs.Free;
            SL.Free;
          end;
        end;
      finally
        ReportsDM.spUniversal.Close;
      end;
    end;

    if Copy(ExportDataType, 6, 1) = '1' then begin
      try
        ReportsDM.spUniversal.SelectSQL.Text := 'SELECT * FROM SYNC_EXT_APP_UPLOAD(:OBJECT_TYPE_)';
        ReportsDM.spUniversal.ParamByName('OBJECT_TYPE_').AsInteger := 2;
        OpenSP(ReportsDM.spUniversal, False);
        if ReportsDM.spUniversal.RecordCount > 0 then begin
          try
            try
              ReportsDM.spUniversalWrite.SelectSQL.Text := 'DELETE FROM SYNC_EXT_APP WHERE SYNC_EXT_APP = :SYNC_EXT_APP_';

              SL:= TStringList.Create;
              SL.Add('<?xml version="1.0" encoding="windows-1251"?>');
              SL.Add('<Arrivals>');

              with ReportsDM.spUniversal do begin
                First;
                sklad_old := FieldByName('ZAKAZ').AsLargeInt;
                head_filled := false;
                while not Eof do begin
                  if sklad_old <> FieldByName('ZAKAZ').AsLargeInt then begin
                    SL.Add('    </Items>');
                    SL.Add('  </Arrival>');

                    head_filled := false;
                  end;

                  if not head_filled then begin
                    head_filled := True;
                    SL.ADD('  <Arrival>');
                    SL.Add('    <Oper>' + FieldByName('OPER').AsString + '</Oper>');
                    SL.Add('    <Code>' + FieldByName('ZAKAZ').AsString + '</Code>');
                    SL.Add('    <Date>' + FieldByName('Z_DATE').AsString + '</Date>');
                    SL.Add('    <Provider>' + FieldByName('CLIENT_NAME').AsString + '</Provider>');
                    SL.Add('    <Sklad>' + FieldByName('SKLAD_NAME').AsString + '</Sklad>');
                    SL.Add('    <SummCash>' + FieldByName('SUMM_CASH').AsString + '</SummCash>');
                    SL.Add('    <SummNonCash>' + FieldByName('SUMM_NONCASH').AsString + '</SummNonCash>');
                    SL.Add('    <Items>');
                  end;
                  SL.Add('      <Item>');
                  SL.Add('        <Articul>' + FieldByName('ARTICUL').AsString + '</Articul>');
                  SL.Add('        <Barcode>' + FieldByName('BARCODE').AsString + '</Barcode>');
                  SL.Add('        <Nomenclatur>' + FieldByName('NOMENCLATUR_NUM').AsString + '</Nomenclatur>');
                  SL.Add('        <Name>' + FieldByName('TOVAR_NAME').AsString + '</Name>');
                  SL.Add('        <Quantity>' + FieldByName('AMOUNT').AsString + '</Quantity>');
                  SL.Add('        <Price>' + FieldByName('PRICE').AsString + '</Price>');
                  SL.Add('        <Summ>' + FieldByName('SUMM').AsString + '</Summ>');
                  SL.Add('      </Item>');

                  sklad_old := FieldByName('ZAKAZ').AsLargeInt;

                  // удаляю строку из очереди
                  ReportsDM.spUniversalWrite.ParamByName('SYNC_EXT_APP_').AsInt64 := FieldByName('SYNC_EXT_APP').AsLargeInt;
                  OpenSP(ReportsDM.spUniversalWrite, False);

                  Next;
                end;
              end;
              SL.Add('    </Items>');
              SL.Add('  </Arrival>');
              SL.Add('</Arrivals>');

              fs:=TFileStream.Create(ExportPath + 'arrivals' + GetDateTime2 + '.xml', fmCreate);
              SL.SaveToStream(fs);

              if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
            except
              on E: EFIBError do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
              on E: Exception do begin
                if ReportsDM.spUniversalWrite.Transaction.InTransaction then
                  ReportsDM.spUniversalWrite.Transaction.CommitRetaining;
              end;
            end;
          finally
            fs.Free;
            SL.Free;
          end;
        end;
      finally
        ReportsDM.spUniversal.Close;
      end;
    end;
  end;
end;

function ExecSPWT(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;
  with SP do begin
    try
      if SP.Database.Connected then begin
        if not Transaction.InTransaction then
          Transaction.StartTransaction;

        ExecProc;

        if FieldIndex['ERR_CODE'] >= 0 then begin
          ErrCode := ParamByName('ERR_CODE').AsInteger;
          if (ErrCode <> 0) AND (ErrCode <> -900) then begin
            if SP.Transaction.InTransaction then
              SP.Transaction.Rollback;
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
    except
      on E: EFIBError do begin
        if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
          if SP.Database.Connected then begin
            MessageDlg(GetServerConnectError(e.Message), mtError, [mbOk], 0);
            SP.Database.Connected := False;
          end;
        end
        else begin
          if SP.Transaction.InTransaction then
            SP.Transaction.CommitRetaining;
          DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in unCommonFunc.OpenSP)');
        end;
      end;
    end;
  end;

  Result := True;
end;

{Делает цвет из Hex в Color}
function HexToTColor( sColor : string ): TColor;
begin
  Result :=
    RGB(
      { get red value }
      StrToInt( '$'+Copy( sColor, 1, 2 ) ),
      { get green value }
      StrToInt( '$'+Copy( sColor, 3, 2 ) ),
      { get blue value }
      StrToInt( '$'+Copy( sColor, 5, 2 ) )
    );
end;

{Аналог NVL}
function NVL( const Value, Deflt : OleVariant ) : OleVariant;
begin
  if Value = NULL then
    Result := Deflt
  else
    Result := Value;
end;

function OpenSP(SP: TpFIBDataSet;
  UseBookmark: Boolean): Boolean;
var
  ErrCode: Integer;
  ErrMsg : String;
  BM: TBookmark;
begin
  Result := False;
  with SP do begin
    try
      if SP.Database.Connected then begin
        BM := GetBookmark;
        try
          Close;
          if SP.Transaction.InTransaction then
            SP.Transaction.CommitRetaining;
          Open;

          if Fields.FindField('ERR_CODE') <> Nil then begin
            if VarIsNull(FieldByName('ERR_CODE').Value) or (FieldByName('ERR_CODE').AsString = '') then
              ErrCode := 0
            else
              ErrCode := FieldByName('ERR_CODE').AsInteger;
            if ErrCode <> 0 then begin
              if SP.Transaction.InTransaction then
                SP.Transaction.CommitRetaining;
              if Fields.FindField('ERR_MSG').Index >= 0 then begin
                ErrMsg := FieldByName('ERR_MSG').AsString;
                DBErrorHandler(ErrCode, ErrMsg);
              end
              else
                MessageDlg('Error code: ' + IntToStr(ErrCode)
                   + #13#10'(occured in TDBDlgForm.OpenSP)', mtInformation, [mbOK], 0);
              Exit;
            end;
          end;

          if UseBookmark then
            if BM <> Nil then
              if BookmarkValid(BM) then
                try
                  GotoBookmark(BM);
                except
                end;
        finally;
          FreeBookmark(BM);
        end;
        Result := True;
      end;
    except
      on E: EFIBError do begin
        if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
          if SP.Database.Connected then begin
            MessageDlg(GetServerConnectError(e.Message), mtError, [mbOk], 0);
            SP.Database.Connected := False;
          end;
        end
        else begin
          if SP.Transaction.InTransaction then
            SP.Transaction.CommitRetaining;
          DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in unCommonFunc.OpenSP)');
        end;
      end;
      on E: Exception do begin
        if SP.Transaction.InTransaction then
          SP.Transaction.CommitRetaining;
        MessageDlg(E.Message + #13#10'(occured in unCommonFunc.OpenSP)', mtError, [mbOk], 0);
      end;
    end;
  end;
end;

function OpenSPClean(SP: TpFIBDataSet;
  UseBookmark: Boolean): Boolean;
var
  ErrCode: Integer;
  ErrMsg : String;
  BM: TBookmark;
begin
  Result := False;
  with SP do begin
    if SP.Database.Connected then begin
      BM := GetBookmark;
      try
        Close;
        if SP.Transaction.InTransaction then
          SP.Transaction.CommitRetaining;
        Open;

        if Fields.FindField('ERR_CODE') <> Nil then begin
          if VarIsNull(FieldByName('ERR_CODE').Value) or (FieldByName('ERR_CODE').AsString = '') then
            ErrCode := 0
          else
            ErrCode := FieldByName('ERR_CODE').AsInteger;
          if ErrCode <> 0 then begin
            if SP.Transaction.InTransaction then
              SP.Transaction.CommitRetaining;
            if Fields.FindField('ERR_MSG').Index >= 0 then begin
              ErrMsg := FieldByName('ERR_MSG').AsString;
              DBErrorHandler(ErrCode, ErrMsg);
            end
            else
              MessageDlg('Error code: ' + IntToStr(ErrCode)
                 + #13#10'(occured in TDBDlgForm.OpenSP)', mtInformation, [mbOK], 0);
            Exit;
          end;
        end;

        if UseBookmark then
          if BM <> Nil then
            if BookmarkValid(BM) then
              try
                GotoBookmark(BM);
              except
              end;
      finally;
        FreeBookmark(BM);
      end;
      Result := True;
    end;
  end;
end;

function ReadSP(SP: TpFIBDataSet): String;
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := '';

  with SP do begin
    try

      if SP.Database.Connected then begin
        Open;
      end else
        Result := 'Нет связи с базой данных.';

    except
      on E: EFIBError do begin
        if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
          if SP.Database.Connected then begin
            Result := GetServerConnectError(e.Message);
            SP.Database.Connected := False;
          end;
        end
        else begin
          Result := 'Код ошибки ' + IntToStr(E.SQLCode) + '. ' + E.Message;
        end;
      end;
      on E: Exception do begin
        Result := E.Message;
      end;
    end;
  end;
end;

{Сохраняет настройки в INI-файл}
procedure SaveSettingsIni(ModuleName : string; SettName : string; ValInt : Variant; ValStr : string);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    if VarIsNull(ValInt) then
      Ini.WriteString(ModuleName, SettName, ValStr)
    else
      Ini.WriteInteger(ModuleName, SettName, Integer(ValInt));
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;
end;

{Читает настройки из INI-файл}
function ReadIntSettingsIni(ModuleName : string; SettName : string; DefVal : integer) : integer;
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    result := Ini.ReadInteger(ModuleName, SettName, DefVal);
  finally
    Ini.Free;
  end;
end;

{Читает настройки из INI-файл}
function ReadDoubleSettingsIni(ModuleName : string; SettName : string; DefVal : double) : double;
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    result := Ini.ReadFloat(ModuleName, SettName, DefVal);
  finally
    Ini.Free;
  end;
end;

{Читает настройки из INI-файл}
function ReadStrSettingsIni(ModuleName : string; SettName : string; DefVal : string) : string;
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    Result := Ini.ReadString(ModuleName, SettName, DefVal);
  finally
    Ini.Free;
  end;
end;

{Возвращает Height, который нужно установить при текущем DPI (то есть при текущем масштабе Windows - 100, 120, 150}
function ScaleDimension(const X: Integer): Integer;
begin
  Result := MulDiv(X, Screen.PixelsPerInch, 96);
end;

{Проставить галочку пункту в DBTReeList}
procedure SetCheckRoutine(ANode: TcxTreeListNode; ANodeFrom : TcxTreeListNode; Val : Boolean);
var
  P : Pboolean;
begin
  if ANode.Data = nil then
  begin
    New(P);
    P^ := Val;
    ANode.Data := P;
  end
  else
    PBoolean(ANode.Data)^ := Val;
end;

{Проставить галочку пункту в DBTReeList}
procedure SetChecks(tl: TcxTreeList; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn);
var
  ANodeChild: TcxTreeListNode;
  i, Cnt : Integer;
  P : Pboolean;
  str : string;

  procedure SetCheckChild(ANode: TcxTreeListNode; Val : Boolean);
  var i : integer;
      LastChild : TcxTreeListNode;
  begin
    ANode.Expand(False);
    LastChild := ANode.GetLastChild;
    ANodeChild := ANode.GetFirstChild;
    for i := 0 to ANode.Count - 1 do begin
      SetCheckRoutine(ANodeChild, ANodeChild, Val);

      if ANodeChild.HasChildren then
        SetCheckChild(ANodeChild, Val);

      if LastChild <> ANodeChild then
        ANodeChild := ANodeChild.GetNext;
    end;
  end;
begin
  {
  Var b1:boolean = true;
 b2:boolean = false;
.....
      if (AColumn.DataBinding.FieldName = '') and (AColumn.Properties is TcxCheckBoxProperties) then
          ANode.Data:= @b1;
....

как вариант можно вот так,что бы избежать утечек памяти, просто времени разбирть не было
  }

  if (TcxDBTreeListColumn(AColumn).DataBinding.FieldName = '') and (AColumn.Properties is TcxCheckBoxProperties) then begin
    if ANode.Data = nil then
    begin
      New(P);
      P^ := True;
      ANode.Data := P;
    end
    else
      PBoolean(ANode.Data)^ := not PBoolean(ANode.Data)^;
  end;

  // если есть детки и галочка ставиться, то проставляю им всем галочки
  if (ANode.HasChildren) then
    SetCheckChild(ANode, PBoolean(ANode.Data)^);

  // если это дочка, и галочка ставится, то надо родителю тоже поставить
  // 05.02.2018 - убрал, в принципе не нужно, надо если - пусть сам ставит
  {if (ANode.Parent <> nil) and (PBoolean(ANode.Data)^ = True) then begin
    ANodePar := ANode.Parent;
    if ANodePar.Data = nil then
    begin
      New(P);
      P^ := True;
      ANodePar.Data := P;
    end
    else
      PBoolean(ANodePar.Data)^ := True;
  end;}

  // если это дочка, и галочка убирается, то надо проверить а у всех ли дочек убрана галочка, если у всех, то галочку у родителя надо тоже убрать
  if (ANode.Parent <> nil) and (PBoolean(ANode.Data)^ = False) then begin
    ANodeChild := ANode.Parent.GetFirstChild;
    Cnt := 0;
    for i := 0 to ANodeChild.Parent.ChildVisibleCount - 1 do begin
      str := ANodeChild.Texts[1];
      if ANodeChild.Data <> nil then
        if PBoolean(ANodeChild.Data)^ = True then
         Cnt := Cnt + 1;
      ANodeChild := ANodeChild.getNextSibling;
    end;
    if Cnt = 0 then begin
      if ANode.Parent.Data = nil then
      begin
        New(P);
        P^ := False;
        ANode.Parent.Data := P;
      end else
        PBoolean(ANode.Parent.Data)^ := False;  //везде поставил 0, а тут оставил такой вызов просто так
    end;
  end;

  tl.Repaint;
end;

{Проставить галочку всем пунктам в DBTReeList}
procedure SetChecksAllNone(SP : TpFIBDataSet; tl : TcxDBTreeList; Val : Boolean);
var ANode: TcxTreeListNode;
  P : Pboolean;
begin
  SP.First;
  ANode := tl.FocusedNode;
  while ANode <> nil do begin
    if ANode.Data = nil then
    begin
      New(P);
      P^ := True;
      ANode.Data := P;
      PBoolean(ANode.Data)^ := Val;
    end
    else
      PBoolean(ANode.Data)^ := Val;

    if ANode.HasChildren then ANode.Expand(False);
    ANode := ANode.GetNext;
    if ANode = nil then Break;
  end;
  tl.Repaint;
end;

{Поставить фокус на строке}
procedure FocusRowcxGrid(tv : TcxGridDBTableView);
begin
  if Assigned(tv.Controller.FocusedRow) then
    tv.Controller.FocusedRow.Selected := True;
end;

{Поставить фокус на строке после вставки}
procedure FocusRowAfterInscxGrid(tv : TcxGridDBTableView);
begin
  if tv.Controller.FocusedRow <> Nil then begin
    if tv.Controller.SelectedRowCount > 0 then
      tv.Controller.SelectedRows[0].Selected := False;
    tv.Controller.FocusedRow.Selected := True;
  end;
end;

{В cxCurrency при UseFormatOnEditing не работает OnValidate = False, все равно проверяется. А если
в поле присутствует знак %, то возникает ошибка. Надо перехватывать и убирать %
Компонент дочерний создать не удалось, потому пришлось делать тут топорно}
function GetOffValidation(S: string; var Error : Boolean) : String;
var
  APos: Integer;
begin
  APos := AnsiPos('%', S);
  if APos > 0 then begin
    Error := Error and (APos = 0);
    if not Error then
      Delete(S, APos, 1);
  end else
    Error := False;

  Result := S;
end;

procedure ExecQuery(SP: TpFIBStoredProc);
begin
  if SP.Database.Connected then begin
    if not SP.Transaction.InTransaction then
      SP.Transaction.StartTransaction;
    SP.ExecQuery;
    SP.Transaction.Commit;
  end;
end;

//процедура заполняющая ZNUM
function FillNumForLicense : String;
var ZNUM1, S, S1: String;
begin
  Result := '';

  try
    CoInitialize(nil);
    try
      S := GetWin32_BIOSInfo;

    finally
      CoUninitialize;
    end;
  except
    on E:EOleException do
        MessageDlg(Format('EOleException %s %x', [E.Message,E.ErrorCode]), mtError, [mbOK], 0);
    on E:Exception do
        MessageDlg(E.Classname + ':' + E.Message, mtError, [mbOK], 0);
  end;

  try
    CoInitialize(nil);
    try
      S1 := GetWin32_ProcessorInfo;
    finally
      CoUninitialize;
    end;
  except
    on E:EOleException do
        MessageDlg(Format('EOleException %s %x', [E.Message,E.ErrorCode]), mtError, [mbOK], 0);
    on E:Exception do
        MessageDlg(E.Classname + ':' + E.Message, mtError, [mbOK], 0);
  end;

  ZNUM1 := StringReplace(S, ' ', '', [rfReplaceAll]) + copy(S1, length(S1)-6, MaxInt);
  ZNUM1 := UDDDigestToStr(UDDString(ZNUM1));
  Result := UDDDigestToStr(UDDString(ZNUM1));
end;

//Отправка и обработка SMS
function Send_sms_process(sms : SMSC; phone : string; text : string; translit : Integer; time : string;
  var Balance : string; var ErrorCode : Integer; var ErrMsg : string) : Integer;
var ret, dd: TStringDynArray;
begin
  try
    if IsDebugHook = 0 then
      ret := sms.send_sms(phone, text, translit, time)
    else begin
      ret := StrUtils.SplitString('475, 2', ',');
      ret[0] := '440';
      ret[1] := '1';
    end;

    if ret[0] = '-999' then begin
      ErrorCode := -999;
      ErrMsg    := 'Нет связи с сервисом SMSC.RU. Проверьте интернет-соединение и попробуйте снова!';
      Exit;
    end;

    Result := StrToInt(Ret[0]);
    if StrToInt(ret[1]) > 0 then
      Balance := ret[3]

    else begin
      ErrorCode := StrToInt(ret[1][2]);
      case ErrorCode of
        1 : ErrMsg := 'Ошибка в параметрах.';
        2 : ErrMsg := 'Неверный логин или пароль.';
        3 : ErrMsg := 'Недостаточно средств на Вашем счете.';
        4 : ErrMsg := 'IP-адрес временно заблокирован из-за частых ошибок в запросах. Подробнее.';
        5 : ErrMsg := 'Неверный формат даты.';
        6 : ErrMsg := 'Сообщение запрещено (по тексту или по имени отправителя).';
        7 : ErrMsg := 'Неверный формат номера телефона.';
        8 : ErrMsg := 'Сообщение на указанный номер не может быть доставлено.';
        9 : ErrMsg := 'Отправка более одного одинакового запроса на передачу SMS-сообщения либо более пяти одинаковых запросов на получение стоимости сообщения в течение минуты.';
      end;
    end;
  except
    on E : Exception do begin
      ErrorCode := -20500;
      ErrMsg    := 'Ошибка: ' + E.Message;
      dd := ret;
    end;
  end;
end;

//Отправка одного SMS
function Send_sms_one(phone, text: string; translit: Integer; time: string;
  var Balance : string; var ErrorCode: integer; var ErrMsg: string): Integer;
var sms : SMSC;
begin
  Result := 0;

  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageDlg('Отправка SMS невозможна, т.к. не заполнен логин/пароль' + #10#13 +
      'к сервису SMSC.RU. Задайте логин/пароль в настройках программы!', mtWarning, [mbOK], 0);
    Exit;
  end;

  try
    sms := SMSC.Create;
    sms.SMSC_LOGIN := SmsLogin;
    sms.SMSC_PASSWORD := SmsPassword;
    Result := Send_sms_process(sms, phone, text, translit, time, Balance, ErrorCode, ErrMsg);
  finally
    sms.Destroy;
  end;
end;

//Отправить СМС при создании новой записи к мастеру или счета
procedure SendSmsAfterScheduleCreate(Phone : string; GClient : integer; ClientName : String; TimeNofity : Integer;
edDate : TDate; teTimeBegin : Ttime);// Schedule : integer});
var smsId, errcode : integer;
  ErrMsg, SmsNotifyTxt, SmsNotifyTxt1, sendTimeStr, str_tomorrow, Balance : string;
  hour : double;
  myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;
  sTime : TTime;
begin
  case TimeNofity of
    1 : hour := 0.5;
    2 : hour := 1;
    3 : hour := 2;
    4 : hour := 3;
    5 : hour := 4;
    6 : hour := 5;
  end;

  // если дата не сегодня, то выясню - вообще попадает ли на сегодня, надо ли высылать смс сегодня
  if (edDate > Date) then begin
    if (TimeNofity = 7) and (trunc((edDate + teTimeBegin) - 1) = Date) then
      sTime := teTimeBegin
    else
      Exit;  // если на сегодня не выпадает, то выхожу

    if SmsTranslit = 0 then
      str_tomorrow := 'завтра в '
    else
      str_tomorrow := 'zavtra v ';
    edDate := edDate - 1;
  end else begin
    sTime := teTimeBegin - hour/24;
    if SmsTranslit = 0 then
      str_tomorrow := 'сегодня в '
    else
      str_tomorrow := 'segodnya v ';
  end;


  if SmsTranslit = 1 then
    ClientName := TranslitRus(ClientName);

  SmsNotifyTxt1 := StringReplace(SmsNotifyText, '@name@', ClientName, []);
  SmsNotifyTxt := StringReplace(SmsNotifyTxt1, '@time@', str_tomorrow + Copy(TimeToStr(teTimeBegin), 1, 5), []);

  DecodeDateTime(edDate + sTime, myYear, myMonth, myDay,
                 myHour, myMin, mySec, myMilli);
  sendTimeStr := Format('%.*d',[2, myDay]) + Format('%.*d',[2, myMonth]) + Copy(IntToStr(myYear), 3, 2) +
                 Format('%.*d',[2, myHour]) + Format('%.*d',[2, myMin]);

  smsId := send_sms_one(Phone, SmsNotifyTxt, 0, sendTimeStr, Balance, errcode, errmsg);

  if errcode = -999 then begin
    MessageDlg('Невозможно отправить SMS-напоминание. Нет связи с сервисом SMSC.RU.' + #10#13 +
      'Проверьте интернет-соединение!', mtWarning, [mbOk], 0);
    Exit;
  end;

  MainDM.spInsSmsHistory.ParamByName('DATETIME_').AsDateTime := edDate + sTime;
  MainDM.spInsSmsHistory.ParamByName('g_client_').AsInt64 := GClient;
  MainDM.spInsSmsHistory.ParamByName('PHONE_NUMBER_').AsString := Phone;
  MainDM.spInsSmsHistory.ParamByName('TEXT_').AsString := SmsNotifyTxt;
  MainDM.spInsSmsHistory.ParamByName('SMS_ID_').AsInteger := smsId;
  if errcode = 0 then begin
    MainDM.spInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := -1;
    MainDM.spInsSmsHistory.ParamByName('ERROR_').Clear;
  end else begin
    if errcode = 7 then
      MainDM.spInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := 22
    else if errcode = 8 then
      MainDM.spInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := 25
    else
      MainDM.spInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := 100;
    MainDM.spInsSmsHistory.ParamByName('ERROR_').AsInteger := errcode;
    //MainDM.spInsSmsHistory.ParamByName('schedule_').AsInteger := schedule;
  end;
  ExecSPTR(MainDM.spInsSmsHistory);
end;

//Транслитерация русского текста
function TranslitRus(const Str: string): string;
const
  RArrayL = 'абвгдеёжзийклмнопрстуфхцчшщьыъэюя';
  RArrayU = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ';
  colChar = 33;
  arr: array[1..2, 1..ColChar] of string =
  (('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y',
    'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f',
    'kh', 'ts', 'ch', 'sh', 'shch', '''', 'y', '''', 'e', 'yu', 'ya'),
    ('A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y',
    'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F',
    'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '''', 'Y', '''', 'E', 'Yu', 'Ya'));
var
  i: Integer;
  LenS: Integer;
  p: integer;
  d: byte;
begin
  result := '';
  LenS := length(str);
  for i := 1 to lenS do
  begin
    d := 1;
    p := pos(str[i], RArrayL);
    if p = 0 then
    begin
      p := pos(str[i], RArrayU);
      d := 2
    end;
    if p <> 0 then
      result := result + arr[d, p]
    else
      result := result + str[i]; //если не русская буква, то берем исходную
  end;
end;

//Есть ли хоть один русски символ
function HaveCrSymbol(const Str: string): Boolean;
const
  RArrayL = 'абвгдеёжзийклмнопрстуфхцчшщьыъэюя';
  RArrayU = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ';
var
  i: Integer;
  LenS: Integer;
  p: integer;
begin
  result := false;
  LenS := length(str);
  for i := 1 to lenS do begin
    p := pos(str[i], RArrayL);
    if p = 0 then
      p := pos(str[i], RArrayU);

    if p <> 0 then begin
      result := true;
      Exit;
    end;
  end;
end;

//Разница в "целых" месяцах между датами, например 06.03.2018 и 25.02.2018 будет 1 месяц
function MonthBetweenMine(date1 : tDate; date2 : TDate) : Integer;
var y1, y2, m1, m2, d1, d2 : word;
begin
  DecodeDate(date1, y1, m1, d1);
  DecodeDate(date2, y2, m2, d2);
  Result := (m1 - m2) + (y1 - y2)*12;
end;

{Div не работает с FLoat числами, поэтому пришлось написать свою}
function MyDiv(Num1 : Double; Num2 : Double): Integer;
var F : double;
begin
  F := Num1 / Num2;     //таким образом я тупо отбрасываю все что после 2-х знаков после запятой, например 6.785 -> 6.78
  F := trunc(F);  // можно было сразу написать Trunc(F*100)/100;, но так почему-то глючило

  Result := StrToInt(FloatToStr(F));
end;

//Процедура совершения звонка
function MakeCall(phone : string; action : string; var ErrMsg : string) : Integer;
begin
  action := 'calls.make_call';

  if (phone = '') or (phone = '+7(   )   -') or (phone = '+7          ') then begin
    result := -100;
    ErrMsg := 'Телефон клиента не заполнен!';
    Exit;
  end;

  if (CallLogin = '') then begin
    result := -100;
    ErrMsg := 'Логин для совершения звонка не заполнен! Укажите его в настройках приложения!';
    Exit;
  end;

  if (CallAPIAddress = '') then begin
    result := -100;
    ErrMsg := 'Адрес API для совершения звонка не заполнен! Укажите его в настройках приложения!';
    Exit;
  end;

  if (CallAPI = '') then begin
    result := -100;
    ErrMsg := 'Ключ API для совершения звонка не заполнен! Укажите его в настройках приложения!';
    Exit;
  end;

  try
    MainDM.RESTClient.BaseURL := 'https://' + CallAPIAddress;
    MainDM.RESTClient.Params.ParameterByName('user_name').Value := CallLogin;
    MainDM.RESTClient.Params.ParameterByName('api_key').Value := CallAPI;
    MainDM.RESTClient.Params.ParameterByName('action').Value := 'calls.make_call';
    MainDM.RESTClient.Params.ParameterByName('to').Value := phone;

    //выполняем GET
    Screen.Cursor := crHourGlass;
    MainDM.RESTRequest.Execute;
    Screen.Cursor := crDefault;

    if Pos('200 OK', MainDM.RESTResponse.StatusText) > 0 then
      Result := 0
    else begin
      if Pos('FORBIDDEN', MainDM.RESTResponse.StatusText) > 0 then begin
        Result := -1;
        ErrMsg := 'Неверные данные логин/ключ API. Проверьте правильность данных!';
      end else begin
        Result := -100;
        ErrMsg := MainDM.RESTResponse.StatusText;
      end;
    end;
  except
    on E : Exception do begin
      result := -100;
      ErrMsg := 'Ошибка: ' + E.Message;
      Screen.Cursor := crDefault;
    end;
  end;
end;

//Задать количество знаков после запятой колонки типа TcxEditRepositoryCalcItem
function SetColumnDecimalPlace(col : TcxEditRepositoryCalcItem) : TcxEditRepositoryCalcItem;
begin
  col.Properties.DisplayFormat := ',0.'.PadRight(3 + FormatSettings.CurrencyDecimals, '0');

  result := col;
end;

//Задать количество знаков после запятой для колонки типа TcxEditRepositoryCurrencyItem
function SetColumnDecimalPlaceCur(col : TcxEditRepositoryCurrencyItem) : TcxEditRepositoryCurrencyItem;
begin
  col.Properties.DecimalPlaces := FormatSettings.CurrencyDecimals;
  col.Properties.DisplayFormat := ',0.'.PadRight(3 + FormatSettings.CurrencyDecimals, '0');

  result := col;
end;

// установлен ли Ексель
function IsOLEObjectInstalled(Name: String): boolean;
var
  ClassID: TCLSID;
begin
  Result := CLSIDFromProgID(PWideChar(WideString(Name)), ClassID) = S_OK;
end;

//Получить ошибку связи с сервером
function GetServerConnectError(Error : string): string;
begin
  Result := 'ПОТЕРЯНА СВЯЗЬ С СЕРВЕРОМ. СЕРВЕР "' + ServerName + '".' + CRLF + CRLF +
    'Закройте программу, проверьте соединение с сервером (Wi-Fi, Lan), и попробуйте ' +
    'запустить программу заново.' + CRLF + CRLF +
    'Детали: ' + Error;
  NotAccess := True;
end;

//Удалить файлы из папки по маске
procedure DeleteFilesFromFolder(Path, FileMask : string);
var
  MyFileList: TStringList;
  iCnt : integer;
begin
  MyFileList := nil;
  try
    MyFileList := TStringList.Create;

    GetFiles(Path, FileMask, MyFileList);
    {Go through each file in the list and delete it}
    for iCnt := 0 to MyFileList.Count - 1 do
      DeleteFile(MyFileList[iCnt]);
  finally
    MyFileList.Free;
  end;
end;

procedure GetFiles(APath, AMask: string; AList: TStrings);
var
  searchRec: SysUtils.TSearchRec;
begin
  APath := IncludeTrailingBackslash(APath);
  {Get all of the files in this directory which match the file mask}
  if FindFirst(APath + AMask + '*', faAnyFile, searchRec) = 0 then
    repeat
      with searchRec do
      begin
        if (Name <> '.') and (Name <> '..') then
          if (Attr and faDirectory <= 0) then
            AList.Add(APath + searchRec.Name);
      end;
      Application.ProcessMessages;
    until
      FindNext(searchRec) <> 0;
  SysUtils.FindClose(searchRec);
end;

procedure Log(txt: String);
begin
  with MainDM.MainLogFile do
    if Active then begin
      WriteLog(txt, True);
    end;
end;

{Делает Execute Script}
function ExecScript(SP: TpFIBScripter; Save : Boolean = False): String;
begin
  Result := '';

  try
    if (Save) and not (SP.Transaction.InTransaction) then
      SP.Transaction.StartTransaction;

    SP.ExecuteScript;

    if Save then
      SP.Transaction.Commit;
  except
    on E: EFIBError do begin
      Result := E.Message;
      SP.Transaction.Rollback;
    end;
    on E: Exception do begin
      Result := E.Message;
      SP.Transaction.Rollback;
    end;
  end;
end;

//Включить LazyLoad
procedure SPLazyLoadEnable(SP : TpFIBDataSet; tv : TcxGridDBTableView);
begin
  if (YesNetwork = 1) And (LimitCount = 1) then
  begin
    SP.CacheModelOptions.BufferChunks := 100;
    SP.CacheModelOptions.CacheModelKind := cmkStandard;

    tv.DataController.DataModeController.GridMode := True;
    tv.DataController.DataModeController.SyncMode := False;
  end;
end;

//Математическое округление
function MathRound(AValue: double; APrecision: integer): double;
var
  db2: double;
  i: int64;
  ii, ink, i1, LTypeNumber: integer;
begin
  begin
    if AValue < 0 then
      LTypeNumber := 0
    else LTypeNumber := 1;
    AValue := Abs(AValue);
  end;

  ink := 1;
  for ii := 1 to APrecision
    do ink := ink*10;
  db2 := AValue*ink*100;
  i := trunc(int(db2)/100);
  i1 := trunc(db2-i*100);
  if i1 > 49 then
    inc(i);
  if LTypeNumber = 0 then
    result := -1*(i/ink)
  else result := i/ink;
end;

function GetProcess(FileName: string): Boolean;
var
  h:THandle;
  pe:PROCESSENTRY32;
begin
  h := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  pe.dwSize := SizeOf(pe);
  Process32First(h, pe);
  repeat
    if AnsiLowerCase(ExtractFileName(pe.szExeFile)) = AnsiLowerCase(FileName) then
    begin
      Result := true;
      CloseHandle(h);
      exit;
    end;
  until not Process32Next(h, pe);
  CloseHandle(h);
  if findwindow(nil, PChar(FileName)) <> 0 then
  begin
    Result := true;
    exit;
  end;
  Result := false;
end;

function ServiceGetStatus(sMachine, sService: PChar): DWORD;
{******************************************}
  {*** Parameters: ***}
  {*** sService: specifies the name of the service to open
  {*** sMachine: specifies the name of the target computer
  {*** ***}
  {*** Return Values: ***}
  {*** -1 = Error opening service ***}
  {*** 1 = SERVICE_STOPPED ***}
  {*** 2 = SERVICE_START_PENDING ***}
  {*** 3 = SERVICE_STOP_PENDING ***}
  {*** 4 = SERVICE_RUNNING ***}
  {*** 5 = SERVICE_CONTINUE_PENDING ***}
  {*** 6 = SERVICE_PAUSE_PENDING ***}
  {*** 7 = SERVICE_PAUSED ***}
  {******************************************}

var
  SCManHandle, SvcHandle: SC_Handle;
  SS: TServiceStatus;
  dwStat: DWORD;
begin
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    // if Service installed
    if (SvcHandle > 0) then
    begin
      // SS structure holds the service status (TServiceStatus);
      if (QueryServiceStatus(SvcHandle, SS)) then
        dwStat := ss.dwCurrentState;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;

function ServiceRunning(sMachine, sService: PChar): Boolean;
begin
  Result := SERVICE_RUNNING = ServiceGetStatus(sMachine, sService);
end;

end.

