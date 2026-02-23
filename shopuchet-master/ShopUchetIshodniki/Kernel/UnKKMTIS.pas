unit UnKKMTIS;

interface
  uses System.JSON, system.TypInfo, IdHTTP, System.SysUtils, System.Classes, System.StrUtils,
  System.Types, IdGlobal, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSLOpenSSL, System.Math;

type
  TKKMTIS = class

  private
    Logins: string;
    passwords: string;
    JSON_token: string;
    token: string;
    tokenExpire: TDateTime;

    JSON_ReplaceMoney: string;
    JSON_Reports: string;
    JSON_Tickets: string;
    JSON_QRHalyk: string;
    QRHalykStr: string;
    QRHalykTransactionID: string;

    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    URL: string;
    procedure createIDHTTP;
    procedure DestroyIDHTTP;
    function ParseToken: Boolean;
    function ParseReplaceMoney: Boolean;
    function ParseReports: Boolean;
    function ParseTickets: Boolean;
    function ParseQRHalyk: Boolean;
  public
    Request: string;
    err: string;
    IDTransatction_: string;
    JsonItems: WideString;
    qrCode: string;
    //Для печати чека
    TimeTicket: string;
    DateTicket: string;
    NumTicket: string;
    SKIDKA: string;
    IIN: string;
    RHM: string;
    FNum: string;
    Operators: string;
    Site: string;
    //Внесение/Изъятие
    OFDID: string;
    Num: string;


    //Необнуляемые суммы на начало смены
    A_SELL, A_SELL_RETURN, A_BUY, A_BUY_RETURN: Double;
    //Продажи за смену
    B_SELL, B_SELL_RETURN, B_BUY, B_BUY_RETURN: Double;
    B_CARD, B_CARD_RETURN, BB_CARD, BB_CARD_RETURN: Double;
    //Кол-во по видам
    COUNT_TICKET_SELL, COUNT_TICKET_RETURN_SELL, COUNT_TICKET_BUY,
    COUNT_TICKET_RETURN_BUY: Integer;
    //Необнуляемые суммы на конец смены
    N_SELL, N_SELL_RETURN, N_BUY, N_BUY_RETURN: Double;
    //Наличных в кассе и общая информация
    SUM_KASSA: Double;
    SMENA: Integer;
    StartDate: TDateTime;
    StartTime: TDateTime;
    EndDate: TDateTime;
    EndTime: TDateTime;
    //Снятие денег и вложение в кассу
    SUM_MD, SUM_MW: Double;

    constructor Create(Lg, ps: string; port: Integer);
    destructor Destroy;
    procedure Log(txt: String);
    procedure Errors(error: string);

    function GetToken(): string;
    function ReplaceMoney(OperType: Integer; Summ: Integer): string;
    function Reports(CloseShift: Boolean): string;
    procedure Itemsadd(Position: string; Price, Sum, Amount, SUMMSkidka, NDS, NDSSUMM: real; Mark: string);
    function PostTicket(Zakaz : Int64; operation: Integer; Sdacha, CashSum, NoCashSum, SUMZakaz, SummBonus: real; Idn: string; Transaction: string;
            NDS, NDSSUM: Double; Pos_Terminal: Integer; TypeOplata: Integer; REQUEST_NUMBER: string): string;
    function QRHalyk(summ: Real): string;
  end;


implementation

uses
  dmMain;


procedure TKKMTIS.Errors(error: string);
const
  errCode: array [-1..12] of string = ('Неизвестная ошибка',
                                      'Ошибка внешней системы',
                                      'Ошибка валидации',
                                      'Требуется переавторизация',
                                      'Невалидный токен',
                                      'Нет активных лицензий',
                                      'Доступ запрещен, недостаточно прав доступа',
                                      'Ошибка проведения операции на терминале',
                                      'У организации отсутствует QR код',
                                      'Ошибка при генерации QR кода',
                                      'Некорректный тип оплаты',
                                      'Время ожидания ответа истекло',
                                      'Некорректно посчитанный налог',
                                      'Отсутствует подключение к интернету');
var
  JS: TJSONValue;
  code: Integer;
begin
  //{ "error": { "code": 1, "text": "ghjfgj"} }
  try
    if Trim(error) = '' then
      exit;
    JS := TJSONObject.ParseJSONValue(error);
    try
      if Assigned(JS) then
        err := JS.GetValue<TJSONObject>('error').Values['text'].Value;
      if Trim(err) = '' then
      begin
        if not TryStrToInt(JS.GetValue<TJSONObject>('error').Values['code'].Value, code) then
          code := -1;
        err := errCode[code];
      end;
      Log('[TIS - ]' + err);
    finally
      if JS<>nil then
        FreeAndNil(JS);
    end;
  except
    on E: Exception do
      Log(e.ClassName + ': ' + e.Message);
  end;
end;

procedure TKKMTIS.createIDHTTP;
begin
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
      Log('Ошибка при создании OpenSSL с сообщением: ' + e.Message);
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
      IOHandler.DefStringEncoding := enUTF8;
    end;
  except
    on E: Exception do
      Log('Ошибка при создании idHTTP с сообщением: ' + e.Message);
  end;
end;

procedure TKKMTIS.DestroyIDHTTP;
begin
  if IdHTTP1 <> nil then
    FreeAndNil(IdHTTP1);
end;

procedure TKKMTIS.Log(txt: String);
begin
  with MainDM.MainLogFile do
  if Active then
    WriteLog(txt, True);
end;

constructor TKKMTIS.Create(Lg, ps: string; port: Integer);
begin
  Log('[TIS] - создаем объект для работы с TIS.');
  Logins := Lg;
  passwords := ps;
  URL := 'http://localhost:'+IntToStr(port)+'/api/';
  inherited Create;
end;

destructor TKKMTIS.Destroy;
begin
  inherited Destroy;
end;

function TKKMTIS.GetToken(): string;
var
  data: TStringList;
begin
  try
    Result := '';
    if Trim(Logins) = '' then
    begin
      Log('Вы не указали логин TIS в настройках');
      JSON_token := '';
      exit;
    end;
    if Trim(Passwords) = '' then
    begin
      Log('Вы не указали пароль TIS в настройках');
      JSON_token := '';
      exit;
    end;

    if IdHTTP1 = nil then
      createIDHTTP;
    Log('[TIS] - получение токена.');
    data := TStringList.Create;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    data.Add('{"Login": "'+logins+'", "password": "'+Passwords+'"}');
    try
      JSON_token := IdHTTP1.Post(URL + 'Authentication/Authenticate', data);
      if not ParseToken then
        Result := err;
      DestroyIDHTTP;
    except
      on E: Exception do begin
        Result := 'Нет связи с модулем ТИС! Ошибка: ' + e.Message;
        Log('[TIS] - .' + e.Message);
        err := Result;
      end;
    end;
  finally
    FreeAndNil(data);
  end;

end;

function TKKMTIS.ParseToken: Boolean;
var
  JS: TJSONValue;
  DatStr: string;
  StrArrD, StrArrT: TStringDynArray;
begin
  //Проверяем если ошибка, отправляяем в процедуру обработки ошибок
  if (Pos(LowerCase('error'), LowerCase(JSON_token))>0) or (Trim(JSON_token) = '') then
  begin
    Errors(JSON_token);
    Result := False;
  end
  else//Иначе работаем с Токенами
  begin
    try
      JS := TJSONObject.ParseJSONValue(JSON_token);
      try
        if Assigned(JS) then
        begin
          token := JS.GetValue<TJSONObject>('data').Values['accessToken'].Value;
          DatStr := JS.GetValue<TJSONObject>('data').Values['accessTokenExpiration'].Value; //"2022-05-15T06:02:10.7402813+06:00"
          StrArrD := SplitString(Copy(DatStr, 1, 10),'-');
          StrArrT := SplitString(Copy(DatStr, 12, 8),':');
        end;
        DatStr := StrArrD[2] +'.'+ StrArrD[1] +'.'+ StrArrD[0] +' '+ StrArrT[0] +':'+ StrArrT[1] +':'+ StrArrT[2];
        if not TryStrToDateTime(DatStr, tokenExpire) then
          tokenExpire := Now + 4/24 - 2/1440;
      finally
        if JS<>nil then
          FreeAndNil(JS);
      end;
      Result := True;
    except
      on E: Exception do
        Log('[TIS] - ошибка. Детали: ' +e.ClassName + ': ' + e.Message);
    end;
  end;
end;

function TKKMTIS.ReplaceMoney(OperType: Integer; Summ: Integer): string;
var
  data: TStringList;
begin
  Result := '';
  if Summ<=0 then
  begin
    Result := '[TIS] - Сумма должна быть больше 0';
    Log(Result);
    Exit;
  end;
  if tokenExpire<=Now then
    token := EmptyStr;
  if token = EmptyStr then
    GetToken;
  if IdHTTP1 = nil then
    createIDHTTP;
  try
    data := TStringList.Create;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: ' + token);
    data.Add('{"sum": '+IntToStr(Summ)+', "operationType": '+IntToStr(OperType)+'}');
    try
      JSON_ReplaceMoney := IdHTTP1.Post(URL + 'Cashbox/MoneyOperation', data);
      if not ParseReplaceMoney then
        Result := err;
      DestroyIDHTTP;
    except
      on e: Exception do
        Log('[TIS] - ошибка. Детали: ' + e.ClassName + ': ' + e.Message);
    end;
  finally
    FreeAndNil(data);
  end;
end;

function TKKMTIS.ParseReplaceMoney: Boolean;
var
  JS: TJSONValue;
begin
  //Проверяем если ошибка, отправляяем в процедуру обработки ошибок
  if (Pos(LowerCase('error'), LowerCase(JSON_ReplaceMoney))>0) or (Trim(JSON_ReplaceMoney) = '') then
  begin
    Errors(JSON_ReplaceMoney);
    Result := False;
  end
  else
  begin
    try
      JS := TJSONObject.ParseJSONValue(JSON_ReplaceMoney);
      try
        if Assigned(JS) then
        begin
          OFDID := JS.GetValue<TJSONObject>('data.cashbox').Values['identityNumber'].Value;
          Num := JS.GetValue<TJSONObject>('data.cashbox').Values['uniqueNumber'].Value;
        end;
      finally
        if JS<>nil then
          FreeAndNil(JS);
      end;
      Result := True;
    except
      on E: Exception do
        Log('[TIS] - ошибка. Детали: ' +e.ClassName + ': ' + e.Message);
    end;
  end;
end;

function TKKMTIS.Reports(CloseShift: Boolean): string;
var
  data: TStringList;
begin
  Result := '';
  try
    if tokenExpire<=Now then
      token := EmptyStr;
    if token = EmptyStr then
      GetToken;
    if IdHTTP1 = nil then
      createIDHTTP;
    data := TStringList.Create;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: ' + token);
    try
      if CloseShift then
      begin
        data.Add('{"withdrawal": false }');
        JSON_Reports := IdHTTP1.Post(URL + 'Cashbox/CloseShift', data);
      end
      else
        JSON_Reports := IdHTTP1.Post(URL + 'Cashbox/XReport', data);
      if not ParseReports then
        Result := err;
      DestroyIDHTTP;
    except
      on e: Exception do
        Log('[TIS] - ошибка. Детали: ' + e.ClassName + ': ' + e.Message);
    end;
  finally
    if Assigned(data) then
      FreeAndNil(data);
  end;
end;

function TKKMTIS.ParseReports: Boolean;
var
  JS: TJSONValue;
  DatStr, sumStr: string;
  StrArrD, StrArrT: TStringDynArray;
  i: Integer;
  JS_Pair: TJSONArray;
  sum: Double;
begin
  //Проверяем если ошибка, отправляяем в процедуру обработки ошибок
  if (Pos(LowerCase('error'), LowerCase(JSON_Reports))>0) or (Trim(JSON_Reports) = '') then
  begin
    Errors(JSON_Reports);
    Result := False;
  end
  else
  begin
    try
      JS := TJSONObject.ParseJSONValue(JSON_Reports);
      try
        if Assigned(JS) then
        begin
          //Данные о кассовом аппарате
          Num := JS.GetValue<TJSONObject>('data').Values['cashboxSN'].Value;
          RHM := JS.GetValue<TJSONObject>('data').Values['cashboxRN'].Value;
          //Продажи за смену
          //Суммы по продажам
          try
            try
              JS_Pair := JS.GetValue<TJSONArray>('data.sell.paymentsByTypesApiModel');
            except
              on E: Exception do
              begin
                Log(e.ClassName + ': ' + e.Message);
                Exit;
              end;
            end;
            B_SELL := 0;
            B_CARD := 0;
            if JS_Pair is TJSONArray then
              for i := 0 to JS_Pair.Count -1 do
              begin
                DatStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('type').Value;
                sumStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('sum').Value;
                if not TryStrToFloat(sumStr, sum) then
                  sum := 0;
                case StrToInt(DatStr) of
                  0: B_SELL := B_SELL + sum;
                  1: B_CARD := B_CARD + sum;
                  else
                    B_SELL := B_SELL + sum;
                end;
              end;
          finally
            FreeAndNilProperties(JS_Pair);
          end;
          //Суммы по возврату продаж
          try
            try
              JS_Pair := JS.GetValue<TJSONArray>('data.returnSell.paymentsByTypesApiModel');
            except
              on E: Exception do
              begin
                Log(e.ClassName + ': ' + e.Message);
                Exit;
              end;
            end;
            B_SELL_RETURN := 0;
            B_CARD_RETURN := 0;
            if JS_Pair is TJSONArray then
              for i := 0 to JS_Pair.Count -1 do
              begin
                DatStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('type').Value;
                sumStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('sum').Value;
                if not TryStrToFloat(sumStr, sum) then
                  sum := 0;
                case StrToInt(DatStr) of
                  0: B_SELL_RETURN := B_SELL_RETURN + sum;
                  1: B_CARD_RETURN := B_CARD_RETURN + sum;
                  else
                    B_SELL_RETURN := B_SELL_RETURN + sum;
                end;
              end;
          finally
            FreeAndNilProperties(JS_Pair);
          end;
          //Суммы по покупкам
          try
            try
              JS_Pair := JS.GetValue<TJSONArray>('data.buy.paymentsByTypesApiModel');
            except
              on E: Exception do
              begin
                Log(e.ClassName + ': ' + e.Message);
                Exit;
              end;
            end;
            B_BUY := 0;
            BB_CARD := 0;
            if JS_Pair is TJSONArray then
              for i := 0 to JS_Pair.Count -1 do
              begin
                DatStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('type').Value;
                sumStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('sum').Value;
                if not TryStrToFloat(sumStr, sum) then
                  sum := 0;
                case StrToInt(DatStr) of
                  0: B_BUY := B_BUY + sum;
                  1: BB_CARD := BB_CARD + sum;
                  else
                    B_BUY := B_BUY + sum;
                end;
              end;
          finally
            FreeAndNilProperties(JS_Pair);
          end;
          //Суммы по возврату покупок
          try
            try
              JS_Pair := JS.GetValue<TJSONArray>('data.returnBuy.paymentsByTypesApiModel');
            except
              on E: Exception do
              begin
                Log(e.ClassName + ': ' + e.Message);
                Exit;
              end;
            end;
            B_BUY_RETURN := 0;
            BB_CARD_RETURN := 0;
            if JS_Pair is TJSONArray then
              for i := 0 to JS_Pair.Count -1 do
              begin
                DatStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('type').Value;
                sumStr := TJSONObject(JS_Pair.Items[i] as TJSONObject).GetValue<TJSONString>('sum').Value;
                if not TryStrToFloat(sumStr, sum) then
                  sum := 0;
                case StrToInt(DatStr) of
                  0: B_BUY_RETURN := B_BUY_RETURN + sum;
                  1: BB_CARD_RETURN := BB_CARD_RETURN + sum;
                  else
                    B_BUY_RETURN := B_BUY_RETURN + sum;
                end;
              end;
          finally
            FreeAndNilProperties(JS_Pair);
          end;
          //Необнуляемые суммы на начало смены
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.startNonNullable').Values['sell'].Value, A_SELL) then
            A_SELL := 0;
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.startNonNullable').Values['returnSell'].Value, A_SELL_RETURN) then
            A_SELL_RETURN := 0;
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.startNonNullable').Values['buy'].Value, A_BUY) then
            A_BUY := 0;
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.startNonNullable').Values['returnBuy'].Value, A_BUY_RETURN) then
            A_BUY_RETURN := 0;
          //Необнуляемые суммы на конец смены
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.endNonNullable').Values['sell'].Value, N_SELL) then
            N_SELL := 0;
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.endNonNullable').Values['returnSell'].Value, N_SELL_RETURN) then
            N_SELL_RETURN := 0;
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.endNonNullable').Values['buy'].Value, N_BUY) then
            N_BUY := 0;
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data.endNonNullable').Values['returnBuy'].Value, N_BUY_RETURN) then
            N_BUY_RETURN := 0;
          //Снятие денег и вложение в кассу
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data').Values['putMoneySum'].Value, SUM_MD) then
            SUM_MD := 0; //Внесение
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data').Values['takeMoneySum'].Value, SUM_MW) then
            SUM_MW := 0; //Изъятие
          //Кол-во по видам
          if not TryStrToInt(JS.GetValue<TJSONObject>('data.sell').Values['count'].Value, COUNT_TICKET_SELL) then
            COUNT_TICKET_SELL := 0;
          if not TryStrToInt(JS.GetValue<TJSONObject>('data.returnSell').Values['count'].Value, COUNT_TICKET_RETURN_SELL) then
            COUNT_TICKET_RETURN_SELL := 0;
          if not TryStrToInt(JS.GetValue<TJSONObject>('data.buy').Values['count'].Value, COUNT_TICKET_BUY) then
            COUNT_TICKET_BUY := 0;
          if not TryStrToInt(JS.GetValue<TJSONObject>('data.returnBuy').Values['count'].Value, COUNT_TICKET_RETURN_BUY) then
            COUNT_TICKET_RETURN_BUY := 0;
          //Наличных в кассе и общая информация
          if not TryStrToFloat(JS.GetValue<TJSONObject>('data').Values['sumInCashbox'].Value, SUM_KASSA) then
            SUM_KASSA := 0;
          if not TryStrToInt(JS.GetValue<TJSONObject>('data').Values['shiftNumber'].Value, SMENA) then
            SMENA := 0;
          //Дата начала смены
          DatStr := JS.GetValue<TJSONObject>('data').Values['startOn'].Value;
          StrArrD := SplitString(Copy(DatStr, 1, 10),'-');
          StrArrT := SplitString(Copy(DatStr, 12, 8),':');
          if not TryStrToDate(StrArrD[2] +'.'+ StrArrD[1] +'.'+ StrArrD[0], StartDate) then
            StartDate := 0;
          if not TryStrToTime(StrArrT[0] +':'+ StrArrT[1] +':'+ StrArrT[2], StartTime) then
            StartTime := 0;
          //Дата окончания смены
          DatStr := JS.GetValue<TJSONObject>('data').Values['closeOn'].Value;
          if DatStr = 'null' then
          begin
            EndDate := Date;
            EndTime := Time;
          end
          else
          begin
            StrArrD := SplitString(Copy(DatStr, 1, 10),'-');
            StrArrT := SplitString(Copy(DatStr, 12, 8),':');
            if not TryStrToDate(StrArrD[2] +'.'+ StrArrD[1] +'.'+ StrArrD[0], EndDate) then
              EndDate := 0;
            if not TryStrToTime(StrArrT[0] +':'+ StrArrT[1] +':'+ StrArrT[2], EndTime) then
              EndTime := 0;
          end;
        end;
      finally
        if JS<>nil then
          FreeAndNil(JS);
      end;
      Result := True;
    except
      on E: Exception do
        Log('[TIS] - ошибка. Детали: ' +e.ClassName + ': ' + e.Message);
    end;
  end;
end;

function TKKMTIS.QRHalyk(summ: Real): string;
var
  data: TStringList;
begin
  Result := '';
  try
    if tokenExpire<=Now then
      token := EmptyStr;
    if token = EmptyStr then
      GetToken;
    if IdHTTP1 = nil then
      createIDHTTP;
    data := TStringList.Create;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    IdHTTP1.Request.CustomHeaders.Add('Authorization: ' + token);
    data.Add('{"sum": "'+FloatToStr(summ)+'"}');
    try
      JSON_QRHalyk := IdHTTP1.Post(URL + 'PaymentSystem/qenerateQrHalyk', data);
      if not ParseQRHalyk then
        Result := err;
      DestroyIDHTTP;
    except
      on e: Exception do
        Log('[TIS] - ошибка. Детали: ' + e.ClassName + ': ' + e.Message);
    end;
  finally
    if Assigned(data) then
      FreeAndNil(data);
  end;
end;

function TKKMTIS.ParseQRHalyk: Boolean;
var
  JS: TJSONValue;
begin
  //Проверяем если ошибка, отправляяем в процедуру обработки ошибок
  if (Pos(LowerCase('error'), LowerCase(JSON_QRHalyk))>0) or (Trim(JSON_QRHalyk) = '') then
  begin
    Errors(JSON_QRHalyk);
    Result := False;
  end
  else
  begin
    try
      JS := TJSONObject.ParseJSONValue(JSON_QRHalyk);
      try
        if Assigned(JS) then
        begin
          QRHalykStr := JS.GetValue<TJSONObject>('data').Values['QrCode'].Value;
          QRHalykTransactionID := JS.GetValue<TJSONObject>('data').Values['TransactionId'].Value;
        end;
      finally
        if JS<>nil then
          FreeAndNil(JS);
      end;
      Result := True;
    except
      on E: Exception do
        Log('[TIS] - ошибка. Детали: ' +e.ClassName + ': ' + e.Message);
    end;
  end;
end;

procedure TKKMTIS.Itemsadd(Position: string; Price, Sum, Amount, SUMMSkidka, NDS, NDSSUMM: real; Mark: string);
Var
  NDSStr, Jsontmp: WideString;
  SKItems, Markup: WideString;
  pos: WideString;
  marker: string;
  Pr: Double;
begin
  try
    pos := AnsiToUtf8(Position);
    if (NDS>0) or (NDSSUMM>0) then
    begin
      NDSStr := '"TaxPercent": ' +FloatToStr(NDS)+ ', "Tax": ' +
      FloatToStr(NDSSUMM) +', "TaxType": 100,';
    end
    else
    begin
      NDSStr := '"TaxPercent": 0, "Tax": 0, "TaxType": 0,';
    end;
    if (SUMMSkidka>0) then
      SKItems := '"Discount": '+FloatToStr(RoundTo(SUMMSkidka, -2))+','
    else
      SKItems := '"Discount": 0,';

    if (SUMMSkidka<0) then
      Pr := (SUMMSkidka*-1)/Amount
    else
      Pr := 0;

    Markup := '"Markup": 0,';

    if Mark = EmptyStr then
      marker := ''
    else
      marker := ', "Mark": "' + Mark + '"';
    {Jsontmp := '"Count": '+FloatToStr(Amount)+', "Price" : '+IntToStr(Round(Price))+
    ','+NDSStr+' "PositionName": "'+Trim(pos)+'", "PositionCode": "0", ' + SKItems +
	  '"Markup": 0, "SectionCode": "1", "IsStorno" : false, "MarkupDeleted": false, '+
    '"DiscountDeleted": false, "UnitCode": 796';}

    Jsontmp := '{"Count": '+FloatToStr(Amount)+', "Price" : '+FloatToStr(RoundTo(Price+Pr, -2))+
    ','+NDSStr+' "PositionName": "'+Trim(pos)+'", ' + SKItems +
	  markup + ' "UnitCode": 796'+marker+'}';

    if Trim(JsonItems) = '' then
      JsonItems := Jsontmp
    else
    begin
      JsonItems := JsonItems + ', '+ Jsontmp;
    end;
  except
    on E: Exception do
      Log('[TIS] - ошибка. Детали: ' + e.ClassName + ': ' + e.Message);
  end;
end;

function TKKMTIS.PostTicket(Zakaz : Int64; operation: Integer; Sdacha, CashSum, NoCashSum, SUMZakaz, SummBonus: real; Idn: string; Transaction: string;
  NDS, NDSSUM: Double; Pos_Terminal: Integer; TypeOplata: Integer; REQUEST_NUMBER: string): string;
var
  data: TStringStream;
  Bonus, Payments, Ticket_NonCash, TransId, Tax: string;
  s: WideString;
begin
  {Idn - ИИН покупателя, не реализовано в ТИС}
  {operation = 0-Покупка,1-возврат покупки, 2-Продажа, 3-возврат продажи}

  Result := '';
  SKIDKA := '';
  TransId := '';
  Request := '';
  if tokenExpire<=Now then
    token := EmptyStr;
  if token = EmptyStr then
    Result := GetToken;
  if Result<>EmptyStr then
    Exit;
  try
    try
      if NDSSUM>0 then
        Tax :=  '"TaxType": 100, "TaxPercent": '+FloatToStr(NDS)+', "Tax": ' + FloatToStr(NDSSUM)
      else
        Tax := '"TaxType": 0, "TaxPercent": 0, "Tax": 0 ';
      Bonus := '';
      Ticket_NonCash := '';
      if SummBonus > 0 then
        Bonus := '"TicketModifiers": [{"Sum" : '+FloatToStr(RoundTo(SummBonus, -2))+', "Text": "Оплата бонусами", '+
        '"Type": 1, '+Tax+'}],';
      Payments := '';
      if CashSum > 0 then
        Payments := '"Payments": [{ "sum": '+FloatToStr(RoundTo(CashSum, -2))+',"PaymentType": 0}';
      if NoCashSum > 0 then
      begin
        case operation of
          2:  //продажа
          begin
            case Pos_Terminal of
              1:  //Kaspi
              begin
                case TypeOplata of
                  1: Ticket_NonCash := ', "PaymentSystem": "0", "method": "0"';  //QR
                  2: Ticket_NonCash := ', "PaymentSystem": "0", "method": "1"'; //Card
                  else
                  begin
                    Result := 'Не возможно выполнить операцию. Выбран не существующий метод оплаты безналичным расчетом';
                    Log('[TIS] - ' + Result);
                    Exit;
                  end;
                end;
                TransId := '';
              end;
              2: //Halyk
              begin
                case TypeOplata of
                  3: Ticket_NonCash := ', "PaymentSystem": "1", "method": "0"';
                end;
                if QRHalyk(NoCashSum)='' then
                  TransId := QRHalykTransactionID;
              end;
              else
              begin
                Result := 'Не выбран ни один POS терминал, оплата безналичным расчетом не возможна';
                Log('[TIS] - ' +Result);
                Exit;
              end;
            end;
          end;
          3: //Возврат продажи
          begin
            case Pos_Terminal of
              1:  //Kaspi
              begin
                case TypeOplata of
                  1: Ticket_NonCash := ', "PaymentSystem": "0", "method": "0"';  //QR
                  2: Ticket_NonCash := ', "PaymentSystem": "0", "method": "1"'; //Card
                  else
                  begin
                    Result := 'Не возможно выполнить операцию. Данная продажа была выполнена на другом терминале';
                    Log('[TIS] - ' + Result);
                    Exit;
                  end;
                end;
                TransId := Transaction;
              end;
              2: //Halyk
              begin
                case TypeOplata of
                  3: Ticket_NonCash := ', "PaymentSystem": "1", "method": "0"';
                end;
                TransId := '';
              end;
              else
              begin
                Result := 'Не выбран ни один POS терминал, возврат безналичным расчетом не возможен';
                Log('[TIS] - ' +Result);
                Exit;
              end;
            end;
          end;
        end;

        if Payments = '' then
          Payments := '"Payments": [{ "sum": '+FloatToStr(RoundTo(NoCashSum, -2))+',"PaymentType": 1}'
        else
          Payments := Payments + ',{ "sum": '+FloatToStr(RoundTo(NoCashSum, -2))+',"PaymentType": 1}';
      end;
      if Payments = EmptyStr then
        Exit;
      Payments := Payments + '],';

      if TransId <> EmptyStr then
        TransId := ', "TransactionId": "'+TransId+'"';

      if IdHTTP1 = nil then
        createIDHTTP;
      //data := TStringList.Create;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      IdHTTP1.Request.CustomHeaders.Add('Authorization: ' + token);
      IdHTTP1.Request.CustomHeaders.Add('Request-Number: ' + REQUEST_NUMBER);
      data := TStringStream.Create('{"OperationType": ' + IntToStr(operation) + ',"Positions": ['+JsonItems+'],' + Bonus +
      Payments + '"Change": '+FloatToStr(RoundTo(Sdacha, -2))+', "RoundType": 0, "ExternalCheckNumber": "'+IntToStr(Zakaz)+
      '"'+TransId+Ticket_NonCash+'}', TEncoding.UTF8);
      s := data.DataString;
      JSON_Tickets := IdHTTP1.Post(URL + 'Cashbox/CheckOperation', data);
      if (Pos(LowerCase('"error":{"code":6'), LowerCase(JSON_Tickets))>0) then
      begin
        try
          s := IdHTTP1.Response.RawHeaders.Values['Request-Number'];
          Request := s;
          Log('Код ошибки = 6, request-number='+s);
        except
          Log('Код ошибки = 6, request-number не найден в ответе');
        end;
        {IdHTTP1.Request.CustomHeaders.FoldLines := False;
        IdHTTP1.Request.CustomHeaders.Clear;
        IdHTTP1.Request.CustomHeaders.Add('Authorization: ' + token);
        IdHTTP1.Request.CustomHeaders.Add('Request-Number: ' + s);
        data := TStringStream.Create('{"OperationType": ' + IntToStr(operation) + ',"Positions": ['+JsonItems+'],' + Bonus +
        Payments + '"Change": '+FloatToStr(RoundTo(Sdacha, -2))+', "RoundType": 0, "ExternalCheckNumber": "'+IntToStr(Zakaz)+
        }//'"'+TransId+Ticket_NonCash+'}', TEncoding.UTF8);
        //JSON_Tickets := IdHTTP1.Post(URL + 'Cashbox/CheckOperation', data);
      end;
      if not ParseTickets then
        Result := err;
      SKIDKA := FloatToStr(SummBonus);
      IIN := Idn;
      DestroyIDHTTP;
    except
      on e: Exception do
        Log('[TIS] - ошибка. Детали: ' + e.ClassName + ': ' + e.Message);
    end;
  finally
    if Assigned(data) then
      FreeAndNil(data);
  end;
end;

function TKKMTIS.ParseTickets: Boolean;
var
  JS: TJSONValue;
  DatStr: string;
  StrArrD, StrArrT: TStringDynArray;
begin
  //Проверяем если ошибка, отправляяем в процедуру обработки ошибок
  if (Pos(LowerCase('error'), LowerCase(JSON_Tickets))>0) or (Trim(JSON_Tickets) = '') then
  begin
    Errors(JSON_Tickets);
    Result := False;
  end
  else
  begin
    try
      JS := TJSONObject.ParseJSONValue(JSON_Tickets);
      try
        if Assigned(JS) then
        begin
          OFDID := JS.GetValue<TJSONObject>('data.cashbox').Values['identityNumber'].Value;
          Num := JS.GetValue<TJSONObject>('data.cashbox').Values['uniqueNumber'].Value;
          Operators := JS.GetValue<TJSONObject>('data.cashbox.ofd').Values['name'].Value;
          Site := JS.GetValue<TJSONObject>('data.cashbox.ofd').Values['host'].Value;
          NumTicket := JS.GetValue<TJSONObject>('data').Values['checkOrderNumber'].Value;
          DatStr := JS.GetValue<TJSONObject>('data').Values['dateTime'].Value;
          StrArrD := SplitString(Copy(DatStr, 1, 10),'-');
          StrArrT := SplitString(Copy(DatStr, 12, 8),':');
          RHM := JS.GetValue<TJSONObject>('data.cashbox').Values['registrationNumber'].Value;
          FNum := JS.GetValue<TJSONObject>('data').Values['checkNumber'].Value;
          qrCode := JS.GetValue<TJSONObject>('data').Values['ticketUrl'].Value;
          IDTransatction_ := JS.GetValue<TJSONObject>('data').Values['transactionId'].Value;
          if LowerCase(IDTransatction_) = 'null' then
            IDTransatction_ := '';
        end;
        DateTicket := StrArrD[2] +'.'+ StrArrD[1] +'.'+ StrArrD[0];
        TimeTicket := StrArrT[0] +':'+ StrArrT[1] +':'+ StrArrT[2];
      finally
        if JS<>nil then
          FreeAndNil(JS);
      end;
      Result := True;
    except
      on E: Exception do
        Log('[TIS] - ошибка. Детали: ' +e.ClassName + ': ' + e.Message);
    end;
  end;
end;

end.
