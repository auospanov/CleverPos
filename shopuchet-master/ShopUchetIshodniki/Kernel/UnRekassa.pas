unit UnRekassa;

interface

uses System.JSON, system.TypInfo, IdIOHandler, IdIOHandlerSocket, System.UITypes, vcl.dialogs,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, System.SysUtils, dateUtils, VLLogFile,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.Classes, IdLogEvent, Math, idGlobal;

type
  TMoney = (MONEY_PLACEMENT_DEPOSIT, MONEY_PLACEMENT_WITHDRAWAL);
  TTypes = (DOWNLOAD, EMAIL, {PRINTER, }QR);
  TPAYMENTSTYPE = (PAYMENT_CASH, PAYMENT_CARD, PAYMENT_MOBILE);
  //PAYMENT_CASH - Оплата наличными
  //PAYMENT_CARD - Оплата картой
  //PAYMENT_MOBILE - Оплата мобильными
  TOPERATION = (OPERATION_SELL_RETURN, OPERATION_SELL, OPERATION_BUY_RETURN, OPERATION_BUY);
type
  TResultGetOPERATION = record
    SUM_SELL: Double;
    SUM_CARD: Double;
    SUM_MOBILE: Double;
  end;
type
  TReKassa = class

  private
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdLogEvent1 : TIdLogEvent;
    MoneyRepl: string;
    procedure createIDHTTP;
    procedure DestroyIDHTTP;
    function ReGetParams: boolean;
    procedure Received(ASender: TComponent; const AText,
  AData: string);
    procedure Log(txt: String);
  public
    Pin_Code: string;
    err: string;
    RHM: string;
    BIN: string;
    OFDID: string;
    fdoMode: string;
    FNum: string;
    SKIDKA: string;
    NumDoc: string;
    TimeDoc: string;
    DateDoc: string;
    Number, Pass_Code: string;
    crs: Integer;
    shiftID: Integer;
    TicketID: Integer;
    LastTime: TTime;
    qrCode: string;
    JsonItems: String;
    token: string;
    CashRegisterlist: string;
    Shift: string;
    SingleShift: string;
    ShiftTicketlist: string;
    Ticket: String;
    XRequestID: string;
    TicketInfo: string;
    CancelTicket: string;
    ReportX: string;
    CloseShift: string;
    TicketReceipts : string;
    IIN: string;

    //Необнуляемые суммы на начало смены
    A_SELL, A_SELL_RETURN, A_BUY, A_BUY_RETURN: Double;
    //Продажи за смену
    B_SELL, B_SELL_RETURN, B_BUY, B_BUY_RETURN: Double;
    B_CARD, B_CARD_RETURN, BB_CARD, BB_CARD_RETURN: Double;
    B_MOBILE, B_MOBILE_RETURN, BB_MOBILE, BB_MOBILE_RETURN: Double;
    //Кол-во по видам
    COUNT_TICKET_SELL, COUNT_TICKET_RETURN_SELL, COUNT_TICKET_BUY,
    COUNT_TICKET_RETURN_BUY, COUNT_MD, COUNT_MW: Integer;
    //Необнуляемые суммы на конец смены
    N_SELL, N_SELL_RETURN, N_BUY, N_BUY_RETURN: Double;
    //Наличных в кассе и общая информация
    SUM_KASSA: Double;
    SMENA: Integer;
    StartDate: TDate;
    StartTime: TTime;
    //Снятие денег и вложение в кассу
    SUM_MD, SUM_MW: Double;

    constructor Create(Lg, ps, Pin: string; Test_Rekassa: Integer);
    destructor Destroy;
    function GetToken(): Boolean;
    function GetCashRegisterlist(): Boolean;
    function GetCashRegisterShiftlist(): Boolean;
    function GetSingleShift(): Boolean;
    function GetShiftTicketlist(shifts: Integer): Boolean;
    function PostTicket(operation: string; Sdacha, CashSum, NoCashSum, SUMZakaz, SummBonus: real; DT: integer; Idn: string): Boolean;
    function GetTicket(TicketID: integer): Boolean;
    function GetReportX(): Boolean;
    function PostCloseShift(): Boolean;
    function PostTicketReceipts(types: TTypes; TicketID: Integer): Boolean;
    procedure Loged(txt: WideString);
    function ReplaceMoney(Oper: Integer; SUM: real): Boolean;
    procedure ParsePostTicket;
    procedure ParseCSR(JsonStr: string);
    procedure ParseShift(JsonStr: string);
    procedure ParseShiftTicketlist(JsonStr: string);
    procedure ParseReportX(JsonStr: string);
    procedure Itemsadd(Position: string; Price, Sum, Amount, PercSkidka, SUMMSkidka, NDS, NDSSUMM: real);
    procedure ParseTicketReceipts;
    function GetClosedShift(CloseShift: boolean): boolean;
    function iscon(): boolean;
  end;

implementation

uses
  dmMain;

var
  ApiKey: string = '23663bfa-2501-4cc2-99af-205b727b0189';
  URL: string = 'https://app.rekassa.kz/partner/';
{const
  //Тестовая
  ApiKey_Test: string = '6821eedc-4240-4a68-85ee-2f5b025e65c7';
  URL_Test: string = 'https://api-test.rekassa.kz/';
  //******************************************************************************
  //Тестовая заблокирована
  //VP8D27N9-W8M
  //5e4uW2repLsIU"7eputWiPDaoRxTBSJ+
  //******************************************************************************
  //Боевая
  ApiKey: string = '23663bfa-2501-4cc2-99af-205b727b0189';
  URL: string = 'https://app.rekassa.kz/partner/';}

procedure TReKassa.Log(txt: String);
begin
  with MainDM.MainLogFile do
  if Active then
    WriteLog(txt, True);
end;

function TReKassa.iscon(): boolean;
begin
  try
    Log('[reKassa] - проверка связи с сервером');
    if IdHTTP1 = nil then
      createIDHTTP;
    IdHTTP1.Get('http://www.ya.ru');
    Result := true;
  except
    Result := false;
  end;
end;

constructor TReKassa.Create(Lg, ps, Pin: string; Test_Rekassa: Integer);
begin
  Log('[reKassa] - создаем объект для работы с reKassa.');
  LastTime := 0;
  Number := Lg;
  Pass_Code := ps;
  Pin_Code := Pin;
  if Test_Rekassa = 1 then
  begin //Тестовая
    ApiKey := '6821eedc-4240-4a68-85ee-2f5b025e65c7';
    URL := 'https://api-test.rekassa.kz/';
  end
  else
  begin //Боевая
    ApiKey := '23663bfa-2501-4cc2-99af-205b727b0189';
    URL := 'https://app.rekassa.kz/partner/';
  end;
  inherited Create;
end;

destructor TReKassa.Destroy;
begin
  inherited Destroy;
end;

procedure TReKassa.Received(ASender: TComponent; const AText,
  AData: string);
var
  s: string;
  i: Integer;
  JS: TJSONValue;
begin
  if AnsiPos('NOT_ENOUGH_CASH', AData) >0 then
  begin
    i := pos('{',AData);
    s := Copy(AData, i, length(AData) - i +1) ;
    JS := TJSONObject.ParseJSONValue(s);
    if Assigned(JS) then
    begin
      try
        s := 'Ошибка reKassa: Недостаточно денег. Вы пытаетесь взять: ' +
        JS.GetValue<TJSONString>('meta.OPERATION_CASH_SUM').Value +
        '. У вас осталось денег в кассе: '+
        JS.GetValue<TJSONString>('meta.CURRENT_CASH_SUM').Value;
        Loged(s + ' Чек не был отправлен в ОФД.');
      except
        Loged('Ошибка reKassa: Недостаточно денег в кассе. Чек не был отправлен в ОФД.');
      end;
    end;
  end;
  if AnsiPos('INVALID_TOKEN', AData) >0 then
  begin
    Loged('Ошибка reKassa: Неверное значение token');
  end;
  if (AnsiPos('BLOCKED', AData) >0) or (AnsiPos('CASH_REGISTER_BLOCKED', AData) >0) then
  begin
    Loged('Ошибка reKassa: Касса заблокирована' + #13#10 + 'Требование о приостановлении операций по кассе');
  end;
  if AnsiPos('CASH_REGISTER_OFFLINE_PERIOD_EXPIRED', AData) >0 then
  begin
    Loged('Ошибка reKassa: Превышен оффлайн период');
  end;
  if AnsiPos('CASH_REGISTER_SHIFT_PERIOD_EXPIRED', AData) >0 then
  begin
    Loged('Ошибка reKassa: Чек не может быть отправлен в ОФД, так как смена '+
    'превысила 24 часа. Закройте смену.');
  end;
  if AnsiPos('PERMISSION_ERROR', AData) >0 then
  begin
    Loged('Ошибка reKassa: PERMISSION_ERROR');
  end;
  if AnsiPos('DUPLICATE_EXTERNAL_ID', AData) >0 then
  begin
    Loged('Ошибка reKassa: DUPLICATE_EXTERNAL_ID');
  end;
  if AnsiPos('CASH_REGISTER_SHOULD_HAVE_SHIFT_OPEN', AData) >0 then
  begin
    Loged('Ошибка reKassa: В кассовом аппарате должна быть открыта смена');
  end;
  {if AnsiPos('WRONG_PASSWORD', AData) >0 then
  begin
    Loged('Ошибка reKassa: Неверный пароль');
  end;}
  if AnsiPos('ACCESS_DENIED', AData) >0 then
  begin
    Loged('Ошибка reKassa: Нет доступа к reKassa');
  end;
end;

procedure TReKassa.createIDHTTP;
begin
  try
    IdLogEvent1 := TIdLogEvent.Create;
    IdLogEvent1.OnReceived := Received;
  except
    on E: Exception do
      Loged('Ошибка при создании LogEvent с сообщением: ' + e.Message);
  end;
  try
    IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    with IdSSLIOHandlerSocketOpenSSL1 do
    begin
      SSLOptions.Method := sslvTLSv1;  //sslvSSLv23
      SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
      SSLOptions.Mode := sslmClient;
      SSLOptions.VerifyMode := [];
      SSLOptions.VerifyDepth := 0;
    end;
  except
    on E: Exception do
      Loged('Ошибка при создании OpenSSL с сообщением: ' + e.Message);
  end;
  try
    IdHTTP1 := TIdHTTP.Create(nil);
    with IdHTTP1 do
    begin
      IOHandler := IdSSLIOHandlerSocketOpenSSL1;
      AllowCookies := True;
      HandleRedirects := true;
      ProxyParams.BasicAuthentication := false;
      ProxyParams.ProxyPort := 0;
      Request.CharSet := 'utf-8';
      Request.ContentType := 'application/json';
      Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
      Request.BasicAuthentication := False;
      Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
      Request.Ranges.Units := 'bytes';
      HTTPOptions := [];
      Intercept := IdLogEvent1;
      IOHandler.DefStringEncoding := enUTF8;
    end;
    IdLogEvent1.Active := True;
  except
    on E: Exception do
      Loged('Ошибка при создании idHTTP с сообщением: ' + e.Message);
  end;
end;

procedure TReKassa.DestroyIDHTTP;
begin
  if IdHTTP1 <> nil then
    FreeAndNil(IdHTTP1);
  if IdSSLIOHandlerSocketOpenSSL1 <> nil then
    FreeAndNil(IdSSLIOHandlerSocketOpenSSL1);
  if IdLogEvent1 <> nil then
    FreeAndNil(IdLogEvent1);
end;

function TReKassa.GetToken(): Boolean;
var
  data: TStringList;
begin
  try
    Result := False;
    if Trim(Number) = '' then
    begin
      Loged('Вы не указали логин ReKassa в настройках');
      token := '';
      exit;
    end;
    if Trim(Pass_Code) = '' then
    begin
      Loged('Вы не указали пароль ReKassa в настройках');
      token := '';
      exit;
    end;
    if Length(Pin_Code)<>4 then
    begin
      Loged('Вы не указали ПИН-код ReKassa в настройках');
      token := '';
      exit;
    end;
    if IdHTTP1 = nil then
      createIDHTTP;
    Log('[reKassa] - получение токена.');
    data := TStringList.Create;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    data.Add('{"number": "'+Number+'", "password": "'+Pass_Code+'"}');
    try
      //token := URL + 'api/auth/login?apiKey=' + ApiKey;
      token := IdHTTP1.Post(URL + 'api/auth/login?apiKey=' + ApiKey, data);
      LastTime := Time;
      Result := True;
      DestroyIDHTTP;
    except
      begin
        if iscon then
          Loged('Не верно указан логин или пароль для ReKassa')
        else
          Loged('Проверьте соединение с интернетом.');
      end;
    end;
  finally
    FreeAndNil(data);
  end;
end;

function TReKassa.GetCashRegisterlist(): Boolean;
begin
  Result := False;
  try
    if (MinutesBetween(Time, LastTime) > 14) or (LastTime = 0) or (Trim(token)='') then
      GetToken();
    if Trim(token) = '' then
      Exit;
    if Trim(token) = '' then
      Exit;
    if IdHTTP1 = nil then
      createIDHTTP;

    Log('[reKassa] - запрос списка кассовых аппаратов.');
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
    CashRegisterlist := IdHTTP1.Get(URL + 'api/crs');
    Result := True;
    DestroyIDHTTP;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

function TReKassa.GetCashRegisterShiftlist(): Boolean;
begin
  Result := False;
  try
    if (MinutesBetween(Time, LastTime) > 14) or (LastTime = 0) or (Trim(token)='') or (crs = 0) then
      if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;

    Log('[reKassa] - запрос списка открытых смен.');
    if IdHTTP1 = nil then
      createIDHTTP;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token); //'+LowerCase(BoolToStr(includeOpen))+'
    Shift := IdHTTP1.Get(URL + 'api/crs/'+IntToStr(crs)+'/shifts?includeOpen=True&page=0&size=20');
    Result := True;
    DestroyIDHTTP;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

function TReKassa.GetSingleShift(): Boolean;
begin
  Result := False;
  try
    if (MinutesBetween(Time, LastTime) > 14) or (LastTime = 0) or (Trim(token)='')
        or (crs = 0) or (shiftID = 0)
    then
      if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;
    if shiftID = -1 then
    begin
      Result := True;
      Exit;
    end;
    Log('[reKassa] - запрос данных о смене.');
    if IdHTTP1 = nil then
      createIDHTTP;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
    SingleShift := IdHTTP1.Get(URL + 'api/crs/'+IntToStr(crs)+'/shifts/'+ IntToStr(shiftID));
    Result := True;
    DestroyIDHTTP;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

function TReKassa.GetShiftTicketlist(shifts: Integer): Boolean;
begin
  Result := False;
  try
    if (MinutesBetween(Time, LastTime) > 14) or (LastTime = 0) or (Trim(token)='')
        or (crs = 0) or (shiftID = 0)
    then
      if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;

    if shiftID = -1 then
    begin
      Result := True;
      Exit;
    end;

    Log('[reKassa] - запрос списка чеков.');
    if IdHTTP1 = nil then
      createIDHTTP;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
    ShiftTicketlist := IdHTTP1.Get(URL + 'api/crs/'+IntToStr(crs)+'/shifts/'+ IntToStr(shifts)+'/tickets?page=0&size=20');
    Result := True;
    XRequestID := IdHTTP1.Response.RawHeaders.Values['X-Request-ID'];
    DestroyIDHTTP;
    //Loged(XRequestID);
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

function TReKassa.PostTicket(operation: string; Sdacha, CashSum, NoCashSum, SUMZakaz, SummBonus: real; DT: integer; Idn: string): Boolean;
var
  Data: TStringStream;
  Dat: TDateTime;
  y, m, d, h, mm, ss, ms: Word;
  DmnTp: string;
  JS_Pay: string;
  s: Widestring;
  extension: string;
  JS_DISCOUNT: string;
begin
  Result := False;
  try
    if operation = 'OPERATION_SELL_RETURN' then
      Log('[reKassa] - операция с чеком, возврат.')
    else
      Log('[reKassa] - операция с чеком, продажа.');
    if Trim(JsonItems) = '' then
      Exit;
    extension := '';
    if Trim(Idn)<>'' then
    begin
      extension := '"extensionOptions" : { "customerIinOrBin" : "'+ Idn + '"},';
    end;
    SKIDKA := '';
    IIN := Trim(Idn);
    case DT of
      0: DmnTp := 'DOMAIN_TRADING';
      1: DmnTp := 'DOMAIN_SERVICES';
    end;
    JS_Pay := '';
    if CashSum<>0 then
    begin
      if NoCashSum<>0 then
      begin
        JS_Pay := '[{"type" : "PAYMENT_CASH", "sum" : {"bills" : "'+IntToStr(Trunc(SUMZakaz-NoCashSum))+
        '", "coins" : '+IntToStr(Trunc(Frac(SUMZakaz-NoCashSum)*100))+'}},{"type" : "PAYMENT_CARD", '+
        '"sum" : {"bills" : "'+IntToStr(Trunc(NoCashSum))+
          '", "coins" : '+IntToStr(Trunc(Frac(NoCashSum)*100))+'}}]';
      end
      else
      begin
        JS_Pay := '[{"type" : "PAYMENT_CASH", "sum" : {"bills" : "'+IntToStr(Trunc(SUMZakaz-NoCashSum))+
        '", "coins" : '+IntToStr(Trunc(Frac(SUMZakaz-NoCashSum)*100))+'}}]';
      end;
    end
    else
    begin
      if NoCashSum<>0 then
      begin
        JS_Pay := '[{"type" : "PAYMENT_CARD", '+
        '"sum" : {"bills" : "'+IntToStr(Trunc(NoCashSum))+
          '", "coins" : '+IntToStr(Trunc(Frac(NoCashSum)*100))+'}}]';
      end;
    end;
    if Trim(JS_Pay) = '' then
    begin
      Result := false;
      err := 'Ошибка ReKassa: Не указана сумма платежа';
      exit;
    end;

    if SummBonus>0 then
    begin
      JS_DISCOUNT := '"discount" : {"sum": {"bills": "'+IntToStr(Trunc(SummBonus))+'", "coins": '+
      IntToStr(Trunc(Frac(SummBonus)*100))+' },  "auxiliary": [{ "key": "DISCOUNT", "value": "'+IntToStr(Trunc(SummBonus))+
      '.'+IntToStr(Trunc(Frac(SummBonus)*100))+'" }]},';
    end
    else
      JS_DISCOUNT := '';

    if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;
    if IdHTTP1 = nil then
      createIDHTTP;
    Dat := Now;
    DecodeDate(Dat, y, m, d);
    DecodeTime(Dat, h, mm, ss, ms);
    try
      //
      Data := TStringStream.Create('',TEncoding.UTF8);
      if operation = 'OPERATION_SELL_RETURN' then
      begin
        Data.WriteString('{"operation" : "'+operation+'", "dateTime" : {"date" : {"year" : "' +IntToStr(y)+
        '", "month" : "' +IntToStr(m)+'", "day" : "' +IntToStr(d)+'"},' +
        '"time" : {"hour" : "' +IntToStr(h)+'", "minute" : "' +IntToStr(mm)+'", "second" : "' +
        IntToStr(ss)+
        '"}}, "domain" : {"type" : "' + DmnTp +'"}, '+extension+' "items" : ['+
        JsonItems + '], "payments" : ' + JS_Pay +', "amounts" : {'+
        '"total" : {"bills" : "'+IntToStr(Trunc(SUMZakaz))+'", "coins" : '+
        IntToStr(Trunc(Frac(SUMZakaz)*100))+'}, "taken" : {"bills" : "0",'+
        ' "coins" : 0}, "change" : {"bills" : "0", "coins" : 0}}}');
      end
      else
      begin


        Data.WriteString('{"operation" : "'+operation+'", "dateTime" : {"date" : {"year" : "' +IntToStr(y)+
        '", "month" : "' +IntToStr(m)+'", "day" : "' +IntToStr(d)+'"},' +
        '"time" : {"hour" : "' +IntToStr(h)+'", "minute" : "' +IntToStr(mm)+'", "second" : "' +
        IntToStr(ss)+
        '"}}, "domain" : {"type" : "' + DmnTp +'"}, '+extension+' "items" : ['+
        JsonItems + '], "payments" : ' + JS_Pay +', "amounts" : {'+
        '"total" : {"bills" : "'+IntToStr(Trunc(SUMZakaz - SummBonus))+'", "coins" : '+
        IntToStr(Trunc(Frac(SUMZakaz - SummBonus)*100))+'},'+JS_DISCOUNT+' "taken" : {"bills" : "'+
        IntToStr(Trunc(CashSum))+
        '", "coins" : '+IntToStr(Trunc(Frac(CashSum)*100))+'}, "change" : {"bills" : "'+
        IntToStr(Trunc(Sdacha))+'",'+
        ' "coins" : '+IntToStr(Trunc(Frac(Sdacha)*100))+'}}}');
      end;
      //s := Data.Text;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
      IdHTTP1.Request.CustomHeaders.Add('X-Request-ID: ' + XRequestID);
      Ticket := IdHTTP1.Post(URL + 'api/crs/'+IntToStr(crs)+'/tickets', Data);
      Result := True;
      SKIDKA := FloatToStr(SummBonus);
      ParsePostTicket;
      DestroyIDHTTP;
    finally
      FreeAndNil(Data);
    end;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

function TReKassa.GetTicket(TicketID: Integer): Boolean;
begin
  Result := False;
  try
    Log('[reKassa] - запрос чека.');
    if (MinutesBetween(Time, LastTime) > 14) or (LastTime = 0) or (Trim(token)='')
      or (crs = 0)
    then
      if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;
    if IdHTTP1 = nil then
      createIDHTTP;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
    TicketInfo := IdHTTP1.Get(URL + 'api/crs/'+IntToStr(crs)+'/tickets/'+ IntToStr(TicketID));
    Result := True;
    DestroyIDHTTP;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

function TReKassa.GetReportX(): Boolean;
begin
  Result := False;
  try
    Log('[reKassa] - запрос Х отчета');
    if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;
    if IdHTTP1 = nil then
      createIDHTTP;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
    IdHTTP1.Request.CustomHeaders.Add('X-Request-ID: ' + XRequestID);
    ReportX := IdHTTP1.Get(URL + 'api/crs/'+IntToStr(crs)+'/shifts/'+ IntToStr(shiftID) +'/reports/x');
    Result := True;
    DestroyIDHTTP;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

function TReKassa.PostCloseShift(): Boolean;
var
  data: TStringList;
begin
  Result := False;
  try
    Log('[reKassa] - закрытие смены.');
    try
      if not ReGetParams() then Exit;
      if Trim(token) = '' then
        Exit;
      if IdHTTP1 = nil then
        createIDHTTP;
      Data := TStringList.Create;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      IdHTTP1.Request.CustomHeaders.Add('cash-register-password: ' + Pin_Code);
      IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
      IdHTTP1.Request.CustomHeaders.Add('X-Request-ID: ' + XRequestID);
      CloseShift := IdHTTP1.Post(URL + 'api/crs/'+IntToStr(crs)+'/shifts/'+ IntToStr(shiftID) +'/close', Data);
      Result := True;
      DestroyIDHTTP;
    finally
      FreeAndNil(data);
    end;
  except
    Loged('Ошибка reKassa: Не возможно закрыть смену, проверьте ПИН-код в настройках');
  end;
end;

function TReKassa.PostTicketReceipts(types: TTypes; TicketID: Integer): Boolean;
var
  data: TStringList;
  tps: string;
begin
  Result := False;
  try
    Log('[reKassa] - получение данных о чеке.');
    if (MinutesBetween(Time, LastTime) > 14) or (LastTime = 0) or (Trim(token)='')
        or (crs = 0) or (shiftID = 0)
    then
      if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;
    if IdHTTP1 = nil then
      createIDHTTP;
    tps := GetEnumName(TypeInfo(TTypes), Ord(types));
    try
      Data := TStringList.Create;
      case types of
        DOWNLOAD:
          Data.Add('{"type" : "DOWNLOAD"}');
        EMAIL:
          Data.Add('{"type" : "EMAIL", "receiver" : {"email" : "Vadymus@mail.ru"}}');
        //PRINTER:
          //Data.Add('{"type" : "PRINTER"}');
        QR:
          Data.Add('{"type" : "QR"}');
        else
          Data.Add('{"type" : "PRINTER"}');
      end;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
      TicketReceipts := IdHTTP1.Post(URL + 'api/crs/'+IntToStr(crs)+'/tickets/'+IntToStr(TicketID)+'/receipts', Data);
      Result := True;
      DestroyIDHTTP;
    finally
      FreeAndNil(data);
    end;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;

procedure TReKassa.Loged(txt: WideString);
begin
  err := txt;
  Log('[reKassa].error - ' + txt);
end;

procedure TReKassa.ParsePostTicket;
var
  JS: TJSONValue;
  s: string;
begin
  try
    if Trim(Ticket) = '' then
      exit;
    JS := TJSONObject.ParseJSONValue(Ticket);
    try
      if Assigned(JS) then
      begin
        qrCode := JS.GetValue<TJSONString>('qrCode').Value;
        FNum := JS.GetValue<TJSONString>('ticketNumber').Value;
        NumDoc := JS.GetValue<TJSONString>('shiftDocumentNumber').Value;
        s := JS.GetValue<TJSONString>('messageTime').Value;
        TimeDoc := copy(s, pos('T',s) +1, Length(s) - pos('T',s));
        TimeDoc := copy(TimeDoc, 1, pos('.',TimeDoc) -1);
        DateDoc := copy(s, 1, pos('T',s) -1);
        DateDoc := copy(DateDoc, 9,2) + '.' + copy(DateDoc, 6,2) + '.' + copy(DateDoc, 1,4);
      end;
    finally
      if JS<>nil then
        FreeAndNil(JS);
    end;
  except
    on E: Exception do
      Loged(e.ClassName + ': ' + e.Message);
  end;
end;

procedure TReKassa.ParseCSR(JsonStr: string);
var
  JSON_userCashRegisterRoles: TJSONArray;
  JS: TJSONValue;
  s: string;
begin
  try
    if Trim(JsonStr) = '' then
      exit;
    JS := TJSONObject.ParseJSONValue(JsonStr);
    try
      //JSONObj := TJSONObject.Create;
      if Assigned(JS) then
      begin
        JSON_userCashRegisterRoles := JS.GetValue<TJSONArray>('_embedded.userCashRegisterRoles');
        if JSON_userCashRegisterRoles is TJSONArray then
        begin
          s := TJSONValue(JSON_userCashRegisterRoles.Items[0] as TJSONObject).GetValue<TJSONObject>('cashRegister').Values['id'].Value;
          OFDID := TJSONValue(JSON_userCashRegisterRoles.Items[0] as TJSONObject).GetValue<TJSONObject>('cashRegister').Values['fdoId'].Value;
          RHM := TJSONValue(JSON_userCashRegisterRoles.Items[0] as TJSONObject).GetValue<TJSONObject>('cashRegister').Values['registrationNumber'].Value;
          fdoMode :=TJSONValue(JSON_userCashRegisterRoles.Items[0] as TJSONObject).GetValue<TJSONObject>('cashRegister').Values['fdoMode'].Value;
        end;
        if not TryStrToInt(s, crs) then
          crs := 0;

      end;
    finally
      if JSON_userCashRegisterRoles<>nil then
        FreeAndNil(JSON_userCashRegisterRoles);
    end;
  except
    on E: Exception do
      Loged(e.ClassName + ': ' + e.Message);
  end;
end;

procedure TReKassa.ParseShift(JsonStr: string);
var
  JSON_userCashRegisterRoles: TJSONArray;
  JS: TJSONValue;
  s: string;
begin
  try
    if Trim(JsonStr) = '' then
      exit;
    if Pos('_embedded":{"shifts', JsonStr) = 0 then
    begin
      shiftID := -1;
      Exit;
    end;
    JS := TJSONObject.ParseJSONValue(JsonStr);
    try
      //JSONObj := TJSONObject.Create;

      if Assigned(JS) then
      begin
        try
          JSON_userCashRegisterRoles := JS.GetValue<TJSONArray>('_embedded.shifts');
          if JSON_userCashRegisterRoles is TJSONArray then
            s := TJSONObject(JSON_userCashRegisterRoles.Items[0] as TJSONObject).Values['shiftNumber'].Value;
          if not TryStrToInt(s, shiftID) then
            shiftID := 0;
        except
          on E: Exception do
            Loged(e.ClassName + ': ' + e.Message);
        end;
      end;
    finally
      if JSON_userCashRegisterRoles<>nil then
        FreeAndNil(JSON_userCashRegisterRoles);
    end;
  except
    on E: Exception do
      Loged(e.ClassName + ': ' + e.Message);
  end;
end;

procedure TReKassa.ParseShiftTicketlist(JsonStr: string);
var
  JS: TJSONValue;
  JS_ShiftTicketlist: TJSONArray;
  s: string;
begin
  try
    if Trim(JsonStr) = '' then
      Exit;
    try
      JS := TJSONObject.ParseJSONValue(JsonStr);
      try
        if Assigned(JS) then
        begin
          JS_ShiftTicketlist := JS.GetValue<TJSONArray>('_embedded.tickets');
          if JS_ShiftTicketlist is TJSONArray then
            s := TJSONObject(JS_ShiftTicketlist.Items[0] as TJSONObject).GetValue<TJSONString>('id').Value;
          if not TryStrToInt(s, TicketID) then
            TicketID := 0;
        end;
      finally
        if JS_ShiftTicketlist<>nil then
          FreeAndNil(JS_ShiftTicketlist);
      end;
    finally
      if JS<>nil then
        FreeAndNilProperties(JS);
    end;
  except
    on E: Exception do
      Loged(e.ClassName + ': ' + e.Message);
  end;
end;

procedure TReKassa.ParseReportX(JsonStr: string);
var
  JS: TJSONValue;
  JS_ReportX, JS_Pair: TJSONArray;
  s: string;
  Operation: TOPERATION;
  PayType: TPAYMENTSTYPE;
  i: Integer;
  Money: TMoney;
  y, m, d, h, mm, sec: Integer;

  function GetOPERATION(JS_TMP: TJSONArray): TResultGetOPERATION;
  var
    j: Integer;
    s: string;
  begin
    try
      Result.SUM_SELL := 0;
      Result.SUM_CARD := 0;
      Result.SUM_MOBILE := 0;
      for j := 0 to JS_TMP.Count -1 do
      begin
        s := TJSONObject(JS_TMP.Items[j] as TJSONObject).GetValue<TJSONString>('payment').Value;
        PayType := TPAYMENTSTYPE(GetEnumValue(TypeInfo(TPAYMENTSTYPE), s));
        case PayType of
          PAYMENT_CASH:
          begin
            s := TJSONObject(JS_TMP.Items[j] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
            if not TryStrToFloat(s, Result.SUM_SELL) then
              Result.SUM_SELL := 0;
          end;
          PAYMENT_CARD:
          begin
            s := TJSONObject(JS_TMP.Items[j] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
            if not TryStrToFloat(s, Result.SUM_CARD) then
              Result.SUM_CARD := 0;
          end;
          PAYMENT_MOBILE:
          begin
            s := TJSONObject(JS_TMP.Items[j] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
            if not TryStrToFloat(s, Result.SUM_MOBILE) then
              Result.SUM_MOBILE := 0;
          end;
        end;
      end;
    except
    end;
  end;
begin
  if Trim(JsonStr) = '' then
    Exit;
  try
    Log('[reKassa] - Х отчет. печать');
    JS := TJSONObject.ParseJSONValue(JsonStr);
    try
      if Assigned(JS) then
      begin
        //Получаем данные по текущей смене
        try
          JS_ReportX := JS.GetValue<TJSONArray>('data.ticketOperations');
        except
          on E: Exception do
          begin
            Loged(e.ClassName + ': ' + e.Message);
            Exit;
          end;
        end;
        if JS_ReportX is TJSONArray then
        for i := 0 to JS_ReportX.Count -1 do
        begin
          try
            s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operation').Value;
            Operation := TOPERATION(GetEnumValue(TypeInfo(TOPERATION), s));
            case Operation of
              OPERATION_SELL_RETURN:
              begin
                JS_Pair := TJSONValue(TJSONObject.ParseJSONValue(JS_ReportX.Items[i].ToJSON)).GetValue<TJSONArray>('payments');
                if JS_Pair is TJSONArray then
                begin
                  B_SELL_RETURN := GetOPERATION(JS_Pair).SUM_SELL;
                  B_CARD_RETURN := GetOPERATION(JS_Pair).SUM_CARD;
                  B_MOBILE_RETURN := GetOPERATION(JS_Pair).SUM_MOBILE;
                end;
              end;
              OPERATION_SELL:
              begin
                JS_Pair := TJSONValue(TJSONObject.ParseJSONValue(JS_ReportX.Items[i].ToJSON)).GetValue<TJSONArray>('payments');
                if JS_Pair is TJSONArray then
                begin
                  B_SELL := GetOPERATION(JS_Pair).SUM_SELL;
                  B_CARD := GetOPERATION(JS_Pair).SUM_CARD;
                  B_MOBILE := GetOPERATION(JS_Pair).SUM_MOBILE;
                end;
              end;
              OPERATION_BUY_RETURN:
              begin
                JS_Pair := TJSONValue(TJSONObject.ParseJSONValue(JS_ReportX.Items[i].ToJSON)).GetValue<TJSONArray>('payments');
                if JS_Pair is TJSONArray then
                begin
                  B_BUY_RETURN := GetOPERATION(JS_Pair).SUM_SELL;
                  BB_CARD_RETURN := GetOPERATION(JS_Pair).SUM_CARD;
                  BB_MOBILE_RETURN := GetOPERATION(JS_Pair).SUM_MOBILE;
                end;
              end;
              OPERATION_BUY:
              begin
                JS_Pair := TJSONValue(TJSONObject.ParseJSONValue(JS_ReportX.Items[i].ToJSON)).GetValue<TJSONArray>('payments');
                if JS_Pair is TJSONArray then
                begin
                  B_BUY := GetOPERATION(JS_Pair).SUM_SELL;
                  BB_CARD := GetOPERATION(JS_Pair).SUM_CARD;
                  BB_MOBILE := GetOPERATION(JS_Pair).SUM_MOBILE;
                end;
              end;
            end;
          except
            on E: Exception do
              Loged(e.ClassName + ': ' + e.Message);
          end;
        end;

        //Кол-во чеков
        try
          JS_ReportX := JS.GetValue<TJSONArray>('data.totalResult');
        except
          on E: Exception do
          begin
            Loged(e.ClassName + ': ' + e.Message);
            Exit;
          end;
        end;
        if JS_ReportX is TJSONArray then
        for i := 0 to JS_ReportX.Count -1 do
        begin
          try
            s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operation').Value;
            Operation := TOPERATION(GetEnumValue(TypeInfo(TOPERATION), s));
            case Operation of
              OPERATION_SELL_RETURN:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('count').Value;
                if not TryStrToInt(s, COUNT_TICKET_RETURN_SELL) then
                  COUNT_TICKET_RETURN_SELL := 0;
              end;
              OPERATION_SELL:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('count').Value;
                if not TryStrToInt(s, COUNT_TICKET_SELL) then
                  COUNT_TICKET_SELL := 0;
              end;
              OPERATION_BUY_RETURN:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('count').Value;
                if not TryStrToInt(s, COUNT_TICKET_RETURN_BUY) then
                  COUNT_TICKET_RETURN_BUY := 0;
              end;
              OPERATION_BUY:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('count').Value;
                if not TryStrToInt(s, COUNT_TICKET_BUY) then
                  COUNT_TICKET_BUY := 0;
              end;
            end;
          except
            on E: Exception do
              Loged(e.ClassName + ': ' + e.Message);
          end;
        end;
        //****************************************************************
        if JS_Pair <> nil then
          FreeAndNilProperties(JS_Pair);
        if JS_ReportX <> nil then
          FreeAndNilProperties(JS_ReportX);
        //************************************************************************************************
        //Получаем данные на начало смены
        try
          JS_ReportX := JS.GetValue<TJSONArray>('data.startShiftNonNullableSums');
        except
          on E: Exception do
          begin
            Loged(e.ClassName + ': ' + e.Message);
            Exit;
          end;
        end;
        if JS_ReportX is TJSONArray then
        for i := 0 to JS_ReportX.Count -1 do
        begin
          try
            s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operation').Value;
            Operation := TOPERATION(GetEnumValue(TypeInfo(TOPERATION), s));
            case Operation of
              OPERATION_SELL_RETURN:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, A_SELL_RETURN) then
                  A_SELL_RETURN := 0;
              end;
              OPERATION_SELL:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, A_SELL) then
                  A_SELL := 0;
              end;
              OPERATION_BUY_RETURN:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, A_BUY_RETURN) then
                  A_BUY_RETURN := 0;
              end;
              OPERATION_BUY:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, A_BUY) then
                  A_BUY := 0;
              end;
            end;
          except
            on E: Exception do
              Loged(e.ClassName + ': ' + e.Message);
          end;
        end;
        //*************************************************************************************************
        //Получаем данные на конец смены
        try
          if JS_ReportX <> nil then
            FreeAndNilProperties(JS_ReportX);
          JS_ReportX := JS.GetValue<TJSONArray>('data.nonNullableSums');
        except
          on E: Exception do
          begin
            Loged(e.ClassName + ': ' + e.Message);
            Exit;
          end;
        end;
        if JS_ReportX is TJSONArray then
        for i := 0 to JS_ReportX.Count -1 do
        begin
          try
            s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operation').Value;
            Operation := TOPERATION(GetEnumValue(TypeInfo(TOPERATION), s));
            //N_SELL, N_SELL_RETURN, N_BUY, N_BUY_RETURN
            case Operation of
              OPERATION_SELL_RETURN:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, N_SELL_RETURN) then
                  N_SELL_RETURN := 0;
              end;
              OPERATION_SELL:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, N_SELL) then
                  N_SELL := 0;
              end;
              OPERATION_BUY_RETURN:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, N_BUY_RETURN) then
                  N_BUY_RETURN := 0;
              end;
              OPERATION_BUY:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('sum.bills').Value;
                if not TryStrToFloat(s, N_BUY) then
                  N_BUY := 0;
              end;
            end;
          except
            on E: Exception do
              Loged(e.ClassName + ': ' + e.Message);
          end;
        end;
        //*************************************************************************************************
        //COUNT_MD, COUNT_MW, SUM_MD, SUM_MW
        try
          JS_ReportX := JS.GetValue<TJSONArray>('data.moneyPlacements');
        except
          on E: Exception do
          begin
            Loged(e.ClassName + ': ' + e.Message);
            Exit;
          end;
        end;
        if JS_ReportX is TJSONArray then
        for i := 0 to JS_ReportX.Count -1 do
        begin
          try
            s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operation').Value;
            Money := TMoney(GetEnumValue(TypeInfo(TMoney), s));
            case Money of
              MONEY_PLACEMENT_DEPOSIT:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operationsCount').Value;
                if not TryStrToInt(s, COUNT_MD) then
                  COUNT_MD := 0;
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operationsSum.bills').Value;
                if not TryStrToFloat(s, SUM_MD) then
                  SUM_MD := 0;
              end;
              MONEY_PLACEMENT_WITHDRAWAL:
              begin
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operationsCount').Value;
                if not TryStrToInt(s, COUNT_MW) then
                  COUNT_MW := 0;
                s := TJSONObject(JS_ReportX.Items[i] as TJSONObject).GetValue<TJSONString>('operationsSum.bills').Value;
                if not TryStrToFloat(s, SUM_MW) then
                  SUM_MW := 0;
              end;
            end;
          except
            on E: Exception do
              Loged(e.ClassName + ': ' + e.Message);
          end;
        end;
        //*************************************************************************************************
        try
          //Общая информация и итоги в кассе
          if JS_ReportX <> nil then
            FreeAndNilProperties(JS_ReportX);
          s := JS.GetValue<TJSONString>('data.cashSum.bills').Value;
          if not TryStrToFloat(s, SUM_KASSA) then
            SUM_KASSA := 0;
          s := JS.GetValue<TJSONString>('data.shiftNumber').Value;
          if not TryStrToInt(s, SMENA) then
            SMENA := 0;
        except
          on E: Exception do
          begin
            Loged('Ошибка при получении общей информации с сообщением: ' + e.Message);
            Exit;
          end;
        end;
        try
          //Собираем дату и время открытия смены
          s := JS.GetValue<TJSONString>('data.openShiftTime.date.year').Value;
          if not TryStrToInt(s, y) then
            y := 0;
          s := JS.GetValue<TJSONString>('data.openShiftTime.date.month').Value;
          if not TryStrToInt(s, m) then
            m := 0;
          s := JS.GetValue<TJSONString>('data.openShiftTime.date.day').Value;
          if not TryStrToInt(s, d) then
            d := 0;
          StartDate := EncodeDate(y, m, d);

          s := JS.GetValue<TJSONString>('data.openShiftTime.time.hour').Value;
          if not TryStrToInt(s, h) then
            h := 0;
          s := JS.GetValue<TJSONString>('data.openShiftTime.time.minute').Value;
          if not TryStrToInt(s, mm) then
            mm := 0;
          s := JS.GetValue<TJSONString>('data.openShiftTime.time.second').Value;
          if not TryStrToInt(s, sec) then
            sec := 0;
          StartTime := EncodeTime(h, mm, sec, 0);
        except
          on E: Exception do
            Loged('Ошибка при формировании даты открытия смены с сообщением: ' + e.Message);
        end;
      end;
    finally
      if JS_ReportX<>nil then
        FreeAndNil(JS_ReportX);
    end;
  finally
    if JS<>nil then
      FreeAndNilProperties(JS);
  end;
end;

procedure TRekassa.Itemsadd(Position: string; Price, Sum, Amount, PercSkidka, SUMMSkidka, NDS, NDSSUMM: real);
Var
  NDSStr, SKIDKA, Jsontmp: String;
  SKItems: string;
  pos: WideString;
begin
  try
    Pos := Trim(Position);
    Pos := StringReplace(Pos, '\', '\\', [rfReplaceAll]);

    if (NDS>0) or (NDSSUMM>0) then
    begin
      NDSStr := '"taxes": [{"sum": {"bills": "' +IntToStr(Trunc(NDSSUMM))+ '","coins": ' +
      IntToStr(Trunc(Frac(NDSSUMM)*100))+'},"percent": ' +IntToStr(Trunc(NDS*1000))+
      ',"taxType": 100,"isInTotalSum": true,"taxationType": 100}]';
    end
    else
    begin
      NDSStr := '';
    end;
    if (PercSkidka>0) or (SUMMSkidka>0) then
    begin
      if (NDS>0) or (NDSSUMM>0) then
        SKIDKA := '{"key": "DISCOUNT","value": "'+IntToStr(Trunc(PercSkidka))+
        '%"},{"key": "DISCOUNT_MARKUP_TAX","value": "'+FloatToStr(RoundTo((NDSSUMM/PercSkidka), -2))+'"}'
      else
        SKIDKA := '{"key": "DISCOUNT","value": "'+IntToStr(Trunc(PercSkidka))+'%"}';

      SKItems := '{"type": "ITEM_TYPE_DISCOUNT","discount": {"sum": {"bills": "'+
      IntToStr(Trunc(SUMMSkidka))+'","coins": ' +IntToStr(Trunc(Frac(SUMMSkidka)*100))+'}}}';
    end
    else
    begin
      SKIDKA := '';
      SKItems := '';
    end;

    if trim(NDSStr)=EmptyStr then
    begin
      if Trim(SKIDKA)=EmptyStr then
      begin
        Jsontmp := '{"type" : "ITEM_TYPE_COMMODITY", "commodity" : {"name" : "' +Trim(Pos)+'", '+
        '"sectionCode" : "1", "quantity" : ' + IntToStr(Round(Amount * 1000)) +', "price" : {'+
        '"bills" : "' +IntToStr(Trunc(Price))+ '", "coins" : ' +IntToStr(Trunc(Frac(Price)*100))+
        '}, "sum" : {"bills" : "' +IntToStr(Trunc(Sum))+
        '", "coins" : '+IntToStr(Trunc(Frac(Sum)*100))+'}, "auxiliary" : [{"key" : "UNIT_TYPE",'+
        '"value" : "PIECE"}]}}';
      end
      else
      begin
        Jsontmp := '{"type" : "ITEM_TYPE_COMMODITY", "commodity" : {"name" : "' +Trim(Pos)+'", '+
        '"sectionCode" : "1", "quantity" : ' + IntToStr(Round(Amount * 1000)) +', "price" : {'+
        '"bills" : "' +IntToStr(Trunc(Price))+ '", "coins" : ' +IntToStr(Trunc(Frac(Price)*100))+
        '}, "sum" : {"bills" : "' +IntToStr(Trunc(Sum))+
        '", "coins" : '+IntToStr(Trunc(Frac(Sum)*100))+'}, "auxiliary" : [{"key" : "UNIT_TYPE",'+
        '"value" : "PIECE"},'+SKIDKA+']}}';
      end;
    end
    else
    begin
      if Trim(SKIDKA)=EmptyStr then
      begin
        Jsontmp := '{"type" : "ITEM_TYPE_COMMODITY", "commodity" : {"name" : "' +Trim(Pos)+'", '+
        '"sectionCode" : "1",'+NDSStr + ', '+
        ' "quantity" : ' + IntToStr(Round(Amount * 1000)) +', "price" : {'+
        '"bills" : "' +IntToStr(Trunc(Price))+ '", "coins" : ' +IntToStr(Trunc(Frac(Price)*100))+
        '}, "sum" : {"bills" : "' +IntToStr(Trunc(Sum))+
        '", "coins" : '+IntToStr(Trunc(Frac(Sum)*100))+'}, "auxiliary" : [{"key" : "UNIT_TYPE",'+
        '"value" : "PIECE"}]}}';
      end
      else
      begin
        Jsontmp := '{"type" : "ITEM_TYPE_COMMODITY", "commodity" : {"name" : "' +Trim(Pos)+'", '+
        '"sectionCode" : "1",'+NDSStr + ', '+
        ' "quantity" : ' + IntToStr(Round(Amount * 1000)) +', "price" : {'+
        '"bills" : "' +IntToStr(Trunc(Price))+ '", "coins" : ' +IntToStr(Trunc(Frac(Price)*100))+
        '}, "sum" : {"bills" : "' +IntToStr(Trunc(Sum))+
        '", "coins" : '+IntToStr(Trunc(Frac(Sum)*100))+'}, "auxiliary" : [{"key" : "UNIT_TYPE",'+
        '"value" : "PIECE"},'+SKIDKA+']}}';
      end;
    end;
    if Trim(SKIDKA)<>EmptyStr then
    begin
      Jsontmp := Jsontmp + ', ' + SKItems;
    end;
    if Trim(JsonItems) = '' then
      JsonItems := Jsontmp
    else
    begin
      JsonItems := JsonItems + ', '+ Jsontmp;
    end;
    JsonItems := StringReplace(JsonItems, '\', '\\', [rfReplaceAll]);
  except
    on E: Exception do
      Loged(e.ClassName + ': ' + e.Message);
  end;
end;

procedure TReKassa.ParseTicketReceipts;
var
  JS: TJSONValue;
  s: string;
begin
  try
    if Trim(TicketReceipts) = '' then
      Exit;
    try
      JS := TJSONObject.ParseJSONValue(TicketReceipts);
      if Assigned(JS) then
        qrCode := JS.GetValue<TJSONString>('qrCode').Value;
    finally
      if JS<>nil then
        FreeAndNilProperties(JS);
    end;
  except
    on E: Exception do
      Loged(e.ClassName + ': ' + e.Message);
  end;
end;

function TReKassa.GetClosedShift(CloseShift: boolean): boolean;
var
  JS: TJSONObject;
  dt: string;
  Dat: TDateTime;
  Opened: Boolean;
begin
  Result := false;
  if GetSingleShift() then
  begin
    if shiftID = -1 then
    begin
      Result := False;
      Exit;
    end;
    try
      JS := TJSONObject.Create;
      JS := TJSONObject.ParseJSONValue(SingleShift) as TJSONObject;
      dt := JS.Values['open'].Value;
      if not TryStrToBool(dt, Opened) then
        Opened := false;
      {if not Opened then
      begin
        Result := True;
        exit;
      end;}
      dt := JS.Values['openTime'].Value;
      dt := copy(dt, 9, 2) + '.' + copy(dt, 6, 2) + '.' + copy(dt, 1, 4) + ' ' +
      copy(dt, 12, 8);
      if not TryStrToDateTime(dt, Dat) then
        Dat := Now;
      if ((Now -1) > Dat) and (Opened) then
      begin
        if CloseShift then
          Result := False
        else
          Result := True;
      end
      else
        Result := False;
    finally
      FreeAndNilProperties(JS);
    end;
  end;
end;

function TReKassa.ReGetParams: boolean;
begin
  Result := false;
  if not GetToken then exit;
  try
    if not GetCashRegisterlist then Exit;
    ParseCSR(CashRegisterlist);
    if UpperCase(fdoMode) = 'BLOCKED' then
    begin
      Loged('Ошибка reKassa: Ваша касса заблокирована');
      Exit;
    end;
    if not GetCashRegisterShiftlist then Exit;
    ParseShift(Shift);
    if not GetShiftTicketlist(shiftID) then Exit;
    ParseShiftTicketlist(ShiftTicketlist);
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      Loged(E.ClassName + ' ' + e.Message);
    end;
  end;
end;

function TReKassa.ReplaceMoney(Oper: Integer; SUM: real): Boolean;
var
  data: TStringList;
  Dat: TDateTime;
  y, m, d, h, mm, ss, ms: Word;
  Operation: string;
begin
  Result := False;
  try
    //if (MinutesBetween(Time, LastTime) > 14) or (LastTime = 0) or (Trim(token)='') or (crs = 0) then
    if not ReGetParams() then Exit;
    if Trim(token) = '' then
      Exit;
    try
      case Oper of
        0:
        begin
          Operation := 'MONEY_PLACEMENT_DEPOSIT';
          Log('[reKassa] - операция внесения денег');
        end;
        1:
        begin
          Operation := 'MONEY_PLACEMENT_WITHDRAWAL';
          Log('[reKassa] - операция изъятия денег');
        end;
      end;
      Data := TStringList.Create;
      Dat := Now;
      DecodeDate(Dat, y, m, d);
      DecodeTime(Dat, h, mm, ss, ms);
      data.Add('{"datetime" : {"date" : {"year" : "'+IntToStr(y)+'","month" : "'+IntToStr(m)+
      '","day" : "'+IntToStr(d)+'"},"time" : {"hour" : "'+IntToStr(h)+'","minute" : "'+IntToStr(mm)+
      '","second" : "'+IntToStr(ss)+'"}},"operation" : "'+Operation+'","sum" : {"bills" : "'+
      IntToStr(Trunc(SUM))+
      '","coins" : '+IntToStr(Trunc(Frac(SUM)*100))+'}}');
      if IdHTTP1 = nil then
        createIDHTTP;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
      IdHTTP1.Request.CustomHeaders.Add('X-Request-ID: ' + XRequestID);
      MoneyRepl := IdHTTP1.Post(URL + 'api/crs/'+IntToStr(crs)+'/cash', Data);
      Result := True;
    finally
      FreeAndNil(data);
    end;
  except
    on E: Exception do
    begin
      Result := false;
      Log('[reKassa]. error - ' + e.ClassName + ' error: ' + e.Message);
    end;
  end;
end;


end.
