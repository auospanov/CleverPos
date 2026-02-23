unit unMobileUploadRoutine;

interface
  uses Windows, SysUtils, Classes, pFIBDataSet, System.JSON, REST.Client, REST.Types,
  unExtPascalUtils, IdGlobal, IdHashSHA, IdHMAC, IdHMACSHA1, system.TypInfo, IdSSLOpenSSL,
  FIB, pFIBDatabase, Inifiles, VCL.Forms;

function BuildGprodJson(SP : TpFIBDataSet; OUT Error_message : string) : TJSONArray;
function SendToMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Server, Token : String; Body : TJSONObject) : String;
function LogonToMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Server, Login, Pass : String; Body : TJSONObject) : String;
function GetToken(Token, Server, Login, Pass : String) : String;
function GetFromMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Token : String) : String;
function ConfirmLoadFromMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Token : String) : String;
function ReSendAfterError(dbase: TpFIBDatabase; tran: TpFIBTransaction; str, Token: string): string;

implementation

uses
  dmMain, unCommonFunc;

function ReSendAfterError(dbase: TpFIBDatabase; tran: TpFIBTransaction; str, Token: string): string;
var
  i: Integer;
  o, data: TJSONObject;
  json_array: TJSONArray;
  data_is_added, delete_is_added : boolean;
  resp, errStr: string;
  spRead: TpFIBDataSet;
begin
  try
    spRead := TpFIBDataSet.Create(nil);
    spRead.Database := dbase;
    spRead.Transaction := tran;
    spRead.UpdateTransaction := tran;

    for i := 0 to Length(str) do
    begin
      if str[i] = '[' then
      begin
        str := Copy(str, i +1, Length(str) -i +1);
        Break;
      end;
    end;
    for i := 0 to Length(str) do
    begin
      if str[i] = ']' then
      begin
        str := Copy(str, 1, i -1);
        Break;
      end;
    end;
    try
      o := TJSONObject.Create;
      data := TJSONObject.Create;
      spRead.SelectSQL.Text := 'SELECT G_PRODUCT, G_PRODUCT_PAR PARENT_ID, articul, barcode, '+
      'DECODE(NAME, '+QuotedStr('')+', '+QuotedStr('Без названия')+', NAME) TOVAR_NAME, price, is_category '+
      'FROM G_PRODUCT where G_PRODUCT in ('+ str +')';
      //========================================================================
      // ОБЪЕКТ G_PRODUCT
      //========================================================================
      try
        resp := ReadSP(spRead);
        if resp <> '' then
        begin
          Log('Ошибка чтения списка товаров для выгрузки. ' + resp);
          Exit;
        end;

        if spRead.RecordCount > 0 then
        begin
          data_is_added := true;
          o.AddPair('data', data);
          json_array := BuildGprodJson(spRead, errStr);
          if json_array = nil then
          begin
            Log(errStr);
            Exit;
          end;

          data.AddPair('g_product', json_array);
        end;
      except
        on E: Exception do begin
          Log('Ошибка выгрузки товаров в моб. приложение. Point 029. Детали: ' + E.Message);
          Exit;
        end;
      end;
      spRead.Close;
      //========================================================================
      // ОБЪЕКТ G_PRODUCT КОНЕЦ
      //========================================================================
      if data_is_added or delete_is_added then
      begin
        Log(o.ToString);
        Result := SendToMobile(MainDm.RESTClient, MainDm.RESTRequest, MainDm.RESTResponse,
          ExportMobileServer, Token, o);
      end;
    finally
      FreeAndNilProperties(data);
      FreeAndNilProperties(json_array);
      FreeAndNil(o);
    end;
  except
    on e: Exception do
      Log('Ошибка отправки на сервер в моб. приложении. Детали: ' + e.Message);
  end;
end;

function CalculateHMACSHA256(const value, salt: String): String;
var
  hmac: TIdHMACSHA256;
  hash: TIdBytes;
begin
  LoadOpenSSLLibrary;

  if not TIdHashSHA256.IsAvailable then
    raise Exception.Create('SHA256 hashing is not available!');

  hmac := TIdHMACSHA256.Create;
  try
    hmac.Key := IndyTextEncoding_UTF8.GetBytes(salt);
    hash := hmac.HashValue(IndyTextEncoding_UTF8.GetBytes(value));
    Result := ToHex(hash);
  finally
    hmac.Free;
  end;
end;

function BuildGprodJson(SP : TpFIBDataSet; OUT Error_message : string) : TJSONArray;
var
  json_item: TJSONObject;
  str : string;
begin

  Error_message := '';
  Result := TJSONArray.Create();

  try
    try
      with SP do begin
        First;

        while not Eof do begin
          try
            json_item := TJSONObject.Create;
            json_item.AddPair( TJSONPair.Create('rec_id', FieldByName('G_PRODUCT').AsString));
            json_item.AddPair( TJSONPair.Create('parent_id', FieldByName('PARENT_ID').AsString));
            json_item.AddPair( TJSONPair.Create('articul', StringReplace(FieldByName('articul').AsString, '\', '\\', [rfReplaceAll])));
            json_item.AddPair( TJSONPair.Create('barcode', FieldByName('barcode').AsString));
            json_item.AddPair( TJSONPair.Create('name', StringReplace(StringReplace(FieldByName('TOVAR_NAME').AsString, '\', '\\', [rfReplaceAll]), #9, ' ', [rfReplaceAll])));//StrToJS(FieldByName('TOVAR_NAME').AsString)));
            json_item.AddPair( TJSONPair.Create('price', floattostrf(FieldByName('price').AsFloat, ffFixed, 15, 2)));
            json_item.AddPair( TJSONPair.Create('is_category', FieldByName('is_category').AsString) );
            Result.AddElement(json_item);

            Next;
          finally
            //g_product_item.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
          end;
        end;
      end;
    finally
      //g_product.Free;  // ЕСЛИ СТАВИТЬ ТО ПОЧЕМУ-ТО ОШИБКА ACCESS VIOLATION, ПОХОЖЕ ЧТО o.Free В КОНЦЕ ДОСТАТОЧНО
    end;
  except
    on E: Exception do begin
      Error_message := 'Ошибка выгрузки товаров в моб. приложение. Детали: ' + E.Message;
      Result := nil;
    end;
  end;
end;

function SendToMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Server, Token : String; Body : TJSONObject) : String;
var str : string;
  LJsonResponse: TJSONObject;
  LResult: TJSONArray;
begin
  Result := '';

  try
    RESTClient.BaseURL := 'https://api.shopuchet.kz/api/load'; //'https://api.shopuchet.kz/api/load';
    RESTRequest.Params.AddHeader('X-Auth-Token', Token);
    RESTRequest.Params.AddHeader('security-hash', CalculateHMACSHA256(Token,'target'));

    RESTRequest.Method := rmPost;
    RESTRequest.AddBody(Body);
    //RESTRequest.Params.ParameterByName('username').Options := [TRESTRequestParameterOption.poDoNotEncode];

    if IsDebugHook = 0 then
      RESTRequest.Execute
    else
      Exit;

    if Pos('200', RESTResponse.StatusText) = 0 then
      Result := 'Ошибка при отправке на сервер. Детали: ' + MainDm.RESTResponse.StatusText + ': ' +
        MainDm.RESTResponse.Content

    else
    begin
      str := RESTResponse.JSONText;
      if Pos('error', str) > 0 then
      begin
        str := '{"result":' + str + '}';
        LJsonResponse := TJSONObject.ParseJSONValue(str) as TJSONObject;
        LResult := LJsonResponse.GetValue('result') as TJSONArray;
        Result := 'Ошибка при отправке на сервер. Детали: ' + LResult.Items[0].GetValue<string>('table') + ', ' +
         LResult.Items[0].GetValue<string>('field') +  ', ' + LResult.Items[0].GetValue<string>('value') + ', ' +
         LResult.Items[0].GetValue<string>('error');
      end;
    end;
  except
    on E : Exception do begin
      Result := 'Ошибка при отправке на сервер моб. приложения. Блок Except. Детали: ' + E.Message;
    end;
  end;
end;

function LogonToMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Server, Login, Pass : String; Body : TJSONObject) : String;
begin
  Result := '';

  try
    RESTClient.BaseURL := 'https://api.shopuchet.kz/logon?username='+Login+'&password='+Pass;
    RESTRequest.Method := rmGet;

    if IsDebugHook = 0 then begin
      RESTRequest.Execute;

      if Pos('200', RESTResponse.StatusText) = 0 then
        Result := 'Ошибка при логине. Детали: ' + MainDm.RESTResponse.StatusText + ': ' +
        MainDm.RESTResponse.Content
      else
        Result := RESTResponse.Content;
    end;
  except
    on E : Exception do begin
      Result := 'Ошибка при логине. Блок Except. Детали: ' + E.Message;
    end;
  end;
end;

function GetToken(Token, Server, Login, Pass : String) : String;
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  o, data, delete: TJSONObject;
  res : string;
begin
  Result := '';

  if Token = '' then begin
    o := TJSONObject.Create;
    try
      res := LogonToMobile(MainDm.RESTClient, MainDm.RESTRequest, MainDm.RESTResponse,
        Server, Login, Pass, o);
    finally
      o.free;
      o := nil;
    end;

    if Pos('Ошибка при логине', res) > 0 then begin
      if Pos('Нет такого пользователя', res) > 0 then
        Result := 'Ошибка при выгрузке. Детали:' + CRLF + 'Пользователя "' + Login + '" не существует.'
      else
        Result := 'Ошибка при выгрузке. Детали:' + CRLF + res;

      Exit;
    end
    else begin
      try
        Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
        try
          Ini.WriteString('ExportOperData', 'MobileToken', res);
        finally
          Ini.UpdateFile;
          Ini.Free;
        end;

        Result := res;
      except
        on E: Exception do
          Result := 'Ошибка : ' + E.Message;
      end;
    end;
  end
  else
    Result := Token;
end;

function GetFromMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Token : String) : String;
begin
  Result := '';

  try
    RESTClient.BaseURL := 'https://api.shopuchet.kz/api/unload';
    RESTRequest.Params.AddHeader('X-Auth-Token', Token);
    RESTRequest.Params.AddHeader('security-hash', CalculateHMACSHA256(Token,'target'));

    RESTRequest.Method := rmPost;

    if IsDebugHook = 0 then
      RESTRequest.Execute
    else
      Exit;

    if Pos('200', RESTResponse.StatusText) = 0 then
      Result := 'Ошибка отправки запроса на сервер. Детали: ' + RESTResponse.StatusText + ': ' +
        RESTResponse.Content

    else
      Result := RESTResponse.JSONText;

  except
    on E : Exception do begin
      Result := 'Ошибка при отправке на сервер моб. приложения. Блок Except. Детали: ' + E.Message;
    end;
  end;
end;

function ConfirmLoadFromMobile(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Token : String) : String;
var str : string;
begin
  Result := '';

  try
    RESTClient.BaseURL := 'https://api.shopuchet.kz/api/approve';
    RESTRequest.Params.AddHeader('X-Auth-Token', Token);
    RESTRequest.Params.AddHeader('security-hash', CalculateHMACSHA256(Token,'target'));

    RESTRequest.Method := rmPost;

    if IsDebugHook = 0 then
      RESTRequest.Execute
    else
      Exit;

    if Pos('200', RESTResponse.StatusText) = 0 then
      Result := 'Ошибка при отправке подтверждения на сервер. Детали: ' + RESTResponse.StatusText + ': ' +
        RESTResponse.Content;

  except
    on E : Exception do begin
      Result := 'Ошибка при подтверждении загрузки с сервера моб. приложения. Блок Except. Детали: ' + E.Message;
    end;
  end;
end;

end.
