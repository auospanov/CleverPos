unit UnECWID;

interface
uses
  IdIOHandler, system.TypInfo, System.UITypes, vcl.dialogs, System.SysUtils,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON, IdGlobal,
  System.Classes, Data.DB, dxmdaset;

type
  TECWID = class
  private
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Token, Store: string;
    procedure createIDHTTP;
    procedure DestroyIDHTTP;
    procedure Log(txt: String);
  public
    err: string;
    BodyBatch: string;
    constructor Create(IDStore_, SecretToken_: string);
    destructor Destroy;
    function addProducts(Prod, Amount, Price: string): string;
    function UpdProduct(ID_Prod, CNT: string): string;
    function DelProduct(ID_Prod: string): string;
    function FindProduct(ID_Prod: string): string;
    procedure GetProducts(off: string);
    procedure ParseJSONProducts(JSONStr: string);
    function FirstUpdateProducts: string;
    procedure AddBatch(Str: string; id: Integer; CNT: Double);
    function SendBatch(): string;
  end;

implementation

uses
  dmMain;

procedure TECWID.AddBatch(Str: string; id: Integer; CNT: Double);
begin
  //'[{"id": "123456","path": "/products/'+Str+'","method": "PUT","body": {"quantity": '+FloatToStr(CNT)+' }}, '+
  //'{"id": "1234567","path": "/products/478690520","method": "PUT","body": {"quantity": 50 } } ]';
  try
    if BodyBatch = EmptyStr then
      BodyBatch := '[{"id": "'+IntToStr(id)+'","path": "/products/'+Str+'","method": "PUT","body": {"quantity": '+FloatToStr(CNT)+' }}'
    else
      BodyBatch := BodyBatch + ', [{"id": "'+IntToStr(id)+'","path": "/products/'+Str+'","method": "PUT","body": {"quantity": '+FloatToStr(CNT)+' }}';
  except
  end;
end;

function TECWID.SendBatch(): string;
var
  URL: string;
  Data: TStringStream;
begin
  Result := '';
  try
    if BodyBatch = EmptyStr then
      Exit;
    try
      Data := TStringStream.Create(BodyBatch + ']',TEncoding.UTF8);
      URL := 'https://app.ecwid.com/api/v3/'+Store+'/batch?token='+Token;
      if IdHTTP1 = nil then
        createIDHTTP;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      Result := IdHTTP1.Post(URL, Data);
      Result := '';
      BodyBatch := '';
    except on E: Exception do
      Result := 'Ошибка при отправке batch запроса. Детали: ' + e.Message;
    end;
  finally
    DestroyIDHTTP;
    FreeAndNil(Data);
  end;
end;

function TECWID.FirstUpdateProducts: string;
begin
  try
    MainDM.dxECWID.Open;
    while not MainDM.dxECWID.Eof do
      MainDM.dxECWID.Delete;

    GetProducts('0');
    Result := '';
  except
    on e: Exception do
      Result := 'Ошибка при первом обновлении товаров. Детали: ' + e.Message;
  end;
end;

constructor TECWID.Create(IDStore_: string; SecretToken_: string);
begin
  Store := IDStore_; //20896022
  Token := SecretToken_; //secret_LPEjCC74ynbVn3m11afPw5cUT5UqZj4K
  inherited Create;
end;

destructor TECWID.Destroy;
begin
  inherited Destroy;
end;

procedure TECWID.Log(txt: String);
begin
  err := txt;
  with MainDM.MainLogFile do
  if Active then
    WriteLog(txt, True);
end;

procedure TECWID.createIDHTTP;
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

procedure TECWID.DestroyIDHTTP;
begin
  if IdHTTP1 <> nil then
    FreeAndNil(IdHTTP1);
  if IdSSLIOHandlerSocketOpenSSL1 <> nil then
    FreeAndNil(IdSSLIOHandlerSocketOpenSSL1);
end;

function TECWID.addProducts(Prod, Amount, Price: string): string;
var
  URL, s: string;
  Data: TStringStream;
  function JSParse(JSONStr: string): string;
  var
    JS: TJSONValue;
  begin
    try
      try
        JS := TJSONObject.ParseJSONValue(JSONStr);
        if Assigned(JS) then
        begin
          Result := JS.GetValue<TJSONString>('id').Value;
        end;
      except on E: Exception do
        Log('Ошибка при получении id товара. Детали: '+e.Message);
      end;
    finally
      if JS <> nil then
        FreeAndNil(JS);
    end;
  end;
begin
  try
    if StrToInt(Price) <= 0 then
    begin
      Result := '';
      Exit;
    end;
    s := '{"sku": "","quantity": '+Amount+',"name": "'+Prod+'","price": '+Price+',"compareToPrice": 0,'+
    '"costPrice": 0,"isShippingRequired": false,"weight": 0,"enabled": true,"description": "","productClassId": 0,'+
    '"volume": 0,"volumeUnit": "oz",'+
    '"created": "2014-01-01",'+
    '"fixedShippingRateOnly": false,"fixedShippingRate": 0,"nameTranslated": {"en": "'+Prod+'"}}';
    Data := TStringStream.Create(s,TEncoding.UTF8);
    URL := 'https://app.ecwid.com/api/v3/'+Store+'/products?token='+Token;
    if IdHTTP1 = nil then
      createIDHTTP;
    IdHTTP1.Request.CustomHeaders.FoldLines := False;
    IdHTTP1.Request.CustomHeaders.Clear;
    s := IdHTTP1.Post(URL, Data); //Возвращает ID продукта '{"id":477213787}'
    try
      if Trim(s) = EmptyStr then
      begin
        Log('Ошибка при добавлении товара');
        Exit;
      end;
      Result := JSParse(s);
    finally
      DestroyIDHTTP;
      FreeAndNil(Data);
    end;
  except
    on E: Exception do
      Log('Ошибка при добавлении товара. Детали: '+e.Message);
  end;
end;

function TECWID.UpdProduct(ID_Prod, CNT: string): string;
var
  URL, s: string;
  Data: TStringStream;
begin
  try
    try
      s := '{"quantityDelta": '+CNT+'}';
      Data := TStringStream.Create(s,TEncoding.UTF8);
      URL := 'https://app.ecwid.com/api/v3/'+Store+'/products/'+ID_Prod+'/inventory?token='+Token;
      if IdHTTP1 = nil then
        createIDHTTP;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      s := IdHTTP1.Put(URL, Data);
      Result := '';
    finally
      DestroyIDHTTP;
      FreeAndNil(Data);
    end;
  except
    on E: Exception do
      Result := 'Ошибка изменения кол-ва на складе у товара с ID='+ID_Prod+'. Детали: '+E.Message;
  end;
end;

function TECWID.DelProduct(ID_Prod: string): string;
var
  URL, s: string;
begin
  try
    try
      //Получаем список товаров
      URL := 'https://app.ecwid.com/api/v3/'+Store+'/products/'+ID_Prod+'?token='+Token;
      if IdHTTP1 = nil then
        createIDHTTP;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      s := IdHTTP1.Delete(URL);
      //'{"deleteCount":1}'
    finally
      DestroyIDHTTP;
    end;
  except
    on E: Exception do
      log('Ошибка при получении товаров: ' + e.Message);
  end;
end;

function TECWID.FindProduct(ID_Prod: string): string;
var
  URL, s: string;
  JS: TJSONValue;
begin
  try
    //Получаем список товаров
    try
      URL := 'https://app.ecwid.com/api/v3/'+Store+'/products/'+ID_Prod+'?token='+Token;
      if IdHTTP1 = nil then
        createIDHTTP;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      s := IdHTTP1.Get(URL);
      //'{"id":477612504,"sku":"76994","quantity":10,
    finally
      DestroyIDHTTP;
    end;
    if s = EmptyStr then
    begin
      Log('Товар с ID='+ID_Prod+' не найден');
      Result := '-1';
      Exit;
    end;
    try
      JS := TJSONObject.ParseJSONValue(s);
      if Assigned(JS) then
      begin
        Result := JS.GetValue<TJSONString>('quantity').Value;
      end;
    finally
      if JS <> nil then
        FreeAndNil(JS);
    end;
  except
    on E: Exception do
    begin
      if Pos('404', e.Message) >0 then
        log('Не найден товар на сайте с кодом ' + ID_Prod)
      else
        log('Ошибка при получении товаров: ' + e.Message);
    end;
  end;
end;

procedure TECWID.GetProducts(off: string);
var
  URL, s: string;
begin
  try
    //Получаем список товаров
    URL := 'https://app.ecwid.com/api/v3/'+Store+'/products?token='+Token;
    try
      if IdHTTP1 = nil then
          createIDHTTP;
      IdHTTP1.Request.CustomHeaders.FoldLines := False;
      IdHTTP1.Request.CustomHeaders.Clear;
      //IdHTTP1.Request.CustomHeaders.Add('Authorization: Bearer ' + SecretToken);
      ParseJSONProducts(IdHTTP1.Get(URL+'&offset=' + off));
    finally
      DestroyIDHTTP;
    end;
  except
    on E: Exception do
      log('Ошибка при получении товаров: ' + e.Message);
  end;
end;

procedure TECWID.ParseJSONProducts(JSONStr: string);
var
  JS: TJSONValue;
  JSArr: TJSONArray;
  i, offset_, total_: Integer;
  s: string;
  id, Name: string;
begin
  try
    if JSONStr = EmptyStr then Exit;
    try
      JS := TJSONObject.ParseJSONValue(JSONStr);
    except
      if JS <> nil then
        FreeAndNil(JS);
      Exit;
    end;
    offset_ := StrToInt(JS.GetValue<TJSONNumber>('offset').Value);
    total_ := StrToInt(JS.GetValue<TJSONNumber>('total').Value);
    {if not JS.TryGetValue('offset', offset_) then
      log('Параметр offset не найден');

    if not JS.TryGetValue('total', total_) then
      log('Параметр total не найден');}

    if Assigned(JS) then
    begin
      JSArr := JS.GetValue<TJSONArray>('items');
      {if not JS.TryGetValue<TJSONArray>('items', JSArr) then
        Exit;}
      if JSArr is TJSONArray then
      begin
        for i := 0 to JSArr.Count -1 do
        begin
          id := JSArr.Items[i].GetValue<TJSONString>('id').Value;
          Name := JSArr.Items[i].GetValue<TJSONString>('name').Value;

          MainDM.dxECWID.Insert;
          MainDM.dxECWID.FieldByName('ID').AsWideString := id;
          MainDM.dxECWID.FieldByName('NAME').AsWideString := Name;
          MainDM.dxECWID.Post;
          {if not JSArr.Items[i].TryGetValue('id', s) then
            Log('Параметр id не найден');
          Log('id: ' + s);
          if not JSArr.Items[i].TryGetValue('quantity', s) then
            Log('Параметр quantity не найден');
          Log('quantity: ' + s);
          if not JSArr.Items[i].TryGetValue('name', s) then
            Log('Параметр name не найден');
          Log('name: ' + s);}
        end;
      end;
      if offset_ + 100 < total_ then
      begin
        GetProducts(IntToStr(offset_ + 100));
      end;
    end;
  finally
    if JSArr <> nil then
      FreeAndNilProperties(JSArr);
    if JS <> nil then
      FreeAndNil(JS);
  end;
end;

end.
