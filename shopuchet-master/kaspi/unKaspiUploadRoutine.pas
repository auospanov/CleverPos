unit unKaspiUploadRoutine;

interface
  uses Windows, SysUtils, Classes, pFIBDataSet, System.JSON, REST.Client, REST.Types,
  unExtPascalUtils, IdGlobal, IdHashSHA, IdHMAC, IdHMACSHA1, system.TypInfo, IdSSLOpenSSL,
  FIB, pFIBDatabase, Inifiles, VCL.Forms, IdHTTP, IdSSL;

function GetFromKaspi(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Url: String; Token : String) : String;

implementation

uses
  dmMain, unCommonFunc;


function GetFromKaspi(RESTClient : TRESTClient; RESTRequest : TRESTRequest;
  RESTResponse : TRESTResponse; Url: String; Token : String) : String;
var IdHTTP: TIdHTTP;
    SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    Response: TStringStream;
begin
  Result := '';
  IdHTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Response := TStringStream.Create('');
  try
    try
      // Настройка SSL/TLS
      SSLHandler.SSLOptions.Method := sslvTLSv1_2; // Включаем поддержку TLS 1.2
      SSLHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];

      IdHTTP.IOHandler := SSLHandler;
      IdHTTP.Request.ContentType := 'application/vnd.api+json';
      IdHTTP.Request.CustomHeaders.AddValue('X-Auth-Token', Token);

      // Выполнение запроса
      try
        IdHTTP.Get(Url, Response);

        Result := Response.DataString;
      except
        on E: EIdHTTPProtocolException do begin
          Result := 'Ошибка EIdHTTPProtocolException при запросе, ошибка - ' + E.ErrorMessage;
        end;
        on E: Exception do begin
          Result := 'Ошибка Exception при запросе, ошибка - ' + E.Message;
        end;
      end;
    except
      on E: Exception do
        Result := 'Ошибка при отправке запроса в Kaspi магазин. Детали: ' + E.Message;
    end;
  finally
    IdHTTP.Free;
    SSLHandler.Free;
    Response.Free;
  end;
end;
end.
