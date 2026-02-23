unit UnNews;

interface
  uses
    Vcl.Controls, Vcl.Forms, Winapi.Windows, Vcl.Dialogs, System.IniFiles,
    IdIOHandler, System.Classes, System.SysUtils, Winapi.ShellAPI,
    IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdComponent,
    IdTCPConnection, IdTCPClient, IdHTTP, idGlobal;

  var
    StartUpdated: Boolean;

  function GetNEWS(forcibly: Boolean; CurrAppVers: Integer): Boolean;
  procedure UpdatePo(FileName: string);

implementation

uses
  uNews, frmMain, unCommonFunc;

procedure UpdatePo(FileName: string);
begin
  try
    ShellExecute(Application.Handle, 'open', pWideChar(FileName), nil, nil, SW_SHOW);
    MainForm.dxBarButtonExit.Click;
  except

  end;
end;

//Процедура проверки новостей
function GetNEWS(forcibly: Boolean; CurrAppVers: Integer): Boolean;
var
  IdHTTP1: TIdHTTP;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  ini: TMemIniFile;
  MemStr, SetupStream: TMemoryStream;
  NewFile: Boolean;
  MSG, MSG_tmp: string;
  UPDATE: Boolean;
  LINK: string;
  VERSION: string;
  VERSIONLocal: string;
  i: Integer;
const
  URLFile: string = 'https://shopuchet.kz/files/NEWS.ini';
begin
  try
    Result := False;
    //Создаем компоненты для https запросов
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
        log('[Новости] - Ошибка при создании OpenSSL с сообщением: ' + e.Message);
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
        log('[Новости] - Ошибка при создании idHTTP с сообщением: ' + e.Message);
    end;

    try
      //проверяем доступность Интернета
      IdHTTP1.Get('https://google.com');

      //Скачиваем файл ini с новостями
      try
        MemStr := TMemoryStream.Create;
        IdHTTP1.Get(URLFile, MemStr);
        MemStr.SaveToFile(ExtractFilePath(Application.ExeName) + 'NEWS_tmp.ini');
        if not FileExists(ExtractFilePath(Application.ExeName) + 'NEWS.ini') then
        begin
          MemStr.SaveToFile(ExtractFilePath(Application.ExeName) + 'NEWS.ini');
          NewFile := True;
        end
        else
          NewFile := False;

        try
          ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + '\NEWS_tmp.ini', TEncoding.UTF8);
          if ini.ValueExists('NEWS', 'MSG') then
          begin
            MSG_tmp := ini.ReadString('NEWS', 'MSG', '');
            for i := 0 to MaxInt do
            begin
              if ini.ValueExists('NEWS', 'MSG' + IntToStr(i)) then
                MSG_tmp := MSG_tmp + #13#10 + ini.ReadString('NEWS', 'MSG' + IntToStr(i), '')
              else
                Break;
            end;
          end
          else
            MSG_tmp := '';

          UPDATE := ini.ReadBool('NEWS', 'UPDATE', False);
          LINK := ini.ReadString('NEWS', 'LINK', '');
          VERSION := ini.ReadString('NEWS', 'VERSION', '');
          VERSION := Trim(StringReplace(VERSION, '.', '', [rfReplaceAll]));
        finally
          FreeAndNil(ini);
        end;
      except
        on E: Exception do
          log('[Новости] - Ошибка при получении новостей с сообщением: ' + e.Message);
      end;
      //Проверяем необходимо ли обновление программы
      try
        ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + '\NEWS.ini', TEncoding.UTF8);
        VERSIONLocal := ini.ReadString('NEWS', 'VERSION', '');
        VERSIONLocal := Trim(StringReplace(VERSIONLocal, '.', '', [rfReplaceAll]));

        if ini.ValueExists('NEWS', 'MSG') then
        begin
          MSG := ini.ReadString('NEWS', 'MSG', '');
          for i := 0 to MaxInt do
          begin
            if ini.ValueExists('NEWS', 'MSG' + IntToStr(i)) then
              MSG := MSG + #13#10 + ini.ReadString('NEWS', 'MSG' + IntToStr(i), '')
            else
              Break;
          end;
        end
        else
          MSG := '';

        if forcibly then //Принудительное обновление программы
        begin
          try
            if StrToInt(VERSION)=CurrAppVers then
              ShowMessage('У вас уже установлена последняя версия программы')
            else
            begin

              if FileExists(GetTempWindows + 'setup.exe') then
                DeleteFile(GetTempWindows + 'setup.exe');
              SetupStream := TMemoryStream.Create;
              IdHTTP1.Get(LINK, SetupStream);
              SetupStream.SaveToFile(GetTempWindows + 'setup.exe');
              Result := True;
              UpdatePo(GetTempWindows + 'setup.exe');
            end;
          except
            on E: Exception do
              log('[Обновление] - Ошибка при обновлении. Детали: ' + e.Message);
          end;
        end
        else
        begin
          StartUpdated := False;
          if CurrAppVers<StrToInt(VERSION) then
            if UPDATE then
            begin
              if NewFile then  //На всякий случай здесь такую проверку сделаю, можно запариться в тэге SKIP
              begin
                Application.CreateForm(TFrmNews, FrmNews);
                FrmNews.mmo1.Lines.Add(MSG_tmp);
                FrmNews.btn1.Visible := True;
                FrmNews.mUpdate.Visible := True;
                FrmNews.msUpdate.Visible := True;
                FrmNews.ShowModal;
                Result := StartUpdated;
              end
              else
              begin
                if (VERSIONLocal=VERSION) and (ini.ReadBool('NEWS', 'SKIP', False)) then
                begin
                  if (Date <> ini.ReadDate('NEWS', 'HOLD_OVER', 0)) and (ini.ReadDate('NEWS', 'HOLD_OVER', 0)<>0) then
                    Exit;
                end
                else
                begin
                  if VERSIONLocal<>VERSION then
                  begin
                    if Assigned(ini) then
                      FreeAndNil(ini);
                    //ExtractFilePath(Application.ExeName) + '\NEWS.ini'
                    if FileExists(ExtractFilePath(Application.ExeName) + '\NEWS.ini') then
                    begin
                      DeleteFile(ExtractFilePath(Application.ExeName) + '\NEWS.ini');
                      CopyFile(PWideChar(ExtractFilePath(Application.ExeName) + '\NEWS_tmp.ini'), PWideChar(ExtractFilePath(Application.ExeName) + '\NEWS.ini'), False);
                    end;
                  end;

                end;

                Application.CreateForm(TFrmNews, FrmNews);
                FrmNews.mmo1.Lines.Add(MSG_tmp);
                FrmNews.btn1.Visible := True;
                FrmNews.mUpdate.Visible := True;
                FrmNews.msUpdate.Visible := True;
                FrmNews.ShowModal;
                Result := StartUpdated;
              end;
            end
            else
            begin
              if NewFile then
              begin
                Application.CreateForm(TFrmNews, FrmNews);
                FrmNews.mmo1.Lines.Add(MSG_tmp);
                FrmNews.mUpdate.Visible := False;
                FrmNews.msUpdate.Visible := False;
                FrmNews.btn1.Visible := False;
                FrmNews.ShowModal;
              end
              else
                if MSG<>MSG_tmp then
                begin
                  Application.CreateForm(TFrmNews, FrmNews);
                  FrmNews.mmo1.Lines.Add(MSG_tmp);
                  FrmNews.mUpdate.Visible := False;
                  FrmNews.msUpdate.Visible := False;
                  FrmNews.btn1.Visible := False;
                  FrmNews.ShowModal;
                end;
            end;
        end;
      except
        on E: Exception do
          log('[Новости] - Ошибка при выполнении. Детали: ' + e.Message);
      end;
    except
      on E: Exception do
        log('[Новости] - Ошибка при получении новостей с сообщением: ' + e.Message);
    end;
  finally
    if Assigned(ini) then
      FreeAndNil(ini);
    FreeAndNil(IdHTTP1);
    FreeAndNil(IdSSLIOHandlerSocketOpenSSL1);
    FreeAndNil(MemStr);
    FreeAndNil(SetupStream);
    if Assigned(FrmNews) then
      FreeAndNil(FrmNews);
  end;
end;

end.
