unit unGetLicenceThread;

interface

uses
  Classes, SyncObjs, DateUtils, SysUtils, Dialogs, Windows,
  unCommonFunc, TurboActivateUnit, Controls, ActiveX, unInfo, ComObj,
  unSupport, Vcl.Forms, DCPcrypt2, DCPrc4, DCPsha1;

type
  TGetLicenceThread = class(TThread)
  private
    destructor Destroy; override;
  protected
    procedure Execute; override;
  public
  end;

var
  DaysBetweenChecks: LongWord;
  GracePeriodLength: LongWord;

implementation

uses
  ReVerifyNow, dmMain;

function GetNum : boolean;
var
  F: TextFile;
  V, FileS, ZNACH: String;
begin

  ZNUM := FillNumForLicense;

  ZNACH := UDDDigestToStr(UDDString(ZNUM));
  ZNACH := UDDDigestToStr(UDDString(ZNACH));
  ZNACH := MainDM.IdEncoderMIME1.Encode(ZNACH);
  ZNACH := UDDDigestToStr(UDDString(ZNACH));

  try
    FileS := LicenseKeyPath;
    AssignFile(F, FileS);
    Reset(F);
    Readln(F, V);

    if ZNACH <> V then
      Result := False
    else
      Result := True;
  finally
    CloseFile(F);
  end;
end;

destructor TGetLicenceThread.Destroy;
begin
  inherited;
  ;
end;

//Вычисляю - работает ли данное приложение в терминальной сессии
function IsRemoteDesktopSession(): boolean;
const
   SM_REMOTESESSION  = $1000;
   ss = 'jm84%fg2d1b28_';
var res : Boolean;
  F: TextFile;
  V, FileS: String;
  Cipher: TDCP_rc4;
begin
  res := (GetSystemMetrics(SM_REMOTESESSION)<>0);

  if res then begin
    try
      FileS := ExtractFilePath(Application.exename) + 'Terminal.dat';
      if FileExists(FileS) then begin
        try
          AssignFile(F, FileS);
          Reset(F);
          Readln(F, V);

          Cipher:= TDCP_rc4.Create(Application);
          Cipher.InitStr(ss, TDCP_sha1);
          if Cipher.DecryptString(V) = 'granted to use mother fucker'  then
            Result := False
          else
            Result := True;
        finally
          Cipher.Burn;
          Cipher.Free;
        end;        
      end else 
        Result := True;
    finally
      CloseFile(F);
    end;
  end else
    Result := False;
end;

procedure TGetLicenceThread.Execute;
var
  gr : IsGenuineResult;
  Exp_date : WideString;
  frmReverify : TfrmReVerifyNow;
  MySettings: TFormatSettings;
  d : TDateTime;
  cnt : integer;
  isProStr, isMainKeyStr, isConstKeyStr : string;
begin
  // ЕСЛИ В РЕЖИМЕ ДЕБАГ, ТО СРАЗУ СТАВЛЮ БУДТО ЛИЦЕНЗИЯ ДАНА
  IF IsDebugHook <> 0 then begin
    IsActivated := 1;
    isProKey := True;

  // ЕСЛИ ЗАПУЩЕН В ТЕРМИНАЛЬНОЙ СЕССИИ - ТО СТАВЛЮ НЕЛИЦЕНЗИРОВАН
  END ELSE if IsRemoteDesktopSession = TRUE then BEGIN
    MessageBox(GetDesktopWindow, PChar('Программа запущена в терминальной сессии. Наложены ограничения.'#13#10 +
    'Для полноценной работы в терминальной сессии, пожалуйста, свяжитесь с разработчиком!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
    IsActivated := 0;
    GotLicenceInfo := True;
    Terminate;
    exit;
  end ELSE BEGIN
    //если клиент старый, то у него старая лицензия, которую надо использовать
    if FileExists(LicenseKeyPath) then begin
      if GetNum = True then begin
        IsActivated := 1;
        isConstKey := True;
        isProKey  := True;
      end else
        IsActivated := 0;
    end else begin
        DaysBetweenChecks := 365;
        GracePeriodLength := 14;
        Try
          // Check if we're activated, and every 90 days verify it with the activation servers
          // In this example we won't show an error if the activation was done offline
          // (see the 3rd parameter of the IsGenuine() function) -- http://wyday.com/limelm/help/offline-activation/
          ta := TurboActivate.Create('5a22f5c8597039fad88934.00488650');
          gr := ta.IsGenuine(DaysBetweenChecks, GracePeriodLength, true);
          isGenuine := (gr = Genuine) or (gr = GenuineFeaturesChanged) or (gr = InternetError);   // an internet error means the user is activated but TurboActivate failed to contact the LimeLM servers
          // If IsGenuineEx() is telling us we're not activated
          // but the IsActivated() function is telling us that the activation
          // data on the computer is valid (i.e. the crypto-signed-fingerprint matches the computer)
          // then that means that the customer has passed the grace period and they must re-verify
          // with the servers to continue to use your app.
          //Note: DO NOT allow the customer to just continue to use your app indefinitely with absolutely
          //      no reverification with the servers. If you want to do that then don't use IsGenuine() or
          //      IsGenuineEx() at all -- just use IsActivated().
          if (not isGenuine) And ta.IsActivated then
          begin
             // We're treating the customer as is if they aren't activated, so they can't use your app.
             // However, we show them a dialog where they can reverify with the servers immediately.
             frmReverify := TfrmReVerifyNow.Create(nil, ta, DaysBetweenChecks, GracePeriodLength);
             if frmReverify.ShowModal = mrOk then begin
                isGenuine := true;
             end
             else if (not frmReverify.noLongerActivated) then begin // the user clicked cancel and the user is still activated
                // Just bail out of your app
                IsActivated := 0;
                GotLicenceInfo := True;
                Terminate;
                exit;
             end;
          end;
        except
          on E : ETurboActivateException do
            begin
              MessageBox(GetDesktopWindow, PChar('Не удалось проверить активацию программы. Ошибка: ' + E.Message), PChar('Внимание'), MB_OK + MB_ICONSTOP);
              // Exit the app, and exit the function immediately
              IsActivated := 0;
              GotLicenceInfo := True;
              Terminate;
              exit;
          end;
        end;

         // If this app is activated then you can get custom license fields.
        // See: https://wyday.com/limelm/help/license-features/
        IF (isGenuine) THEN BEGIN
          Exp_date := ta.GetFeatureValue('licence_expired', '');
          if (Exp_date = '') or (not ta.IsDateValid(Exp_date, TA_HAS_NOT_EXPIRED)) then begin
            IsActivated := 0;
          end else begin
            try
              IsActivated := 1;
              GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, MySettings);
              MySettings.DateSeparator := '-';
              MySettings.TimeSeparator := ':';
              MySettings.ShortDateFormat := 'yyyy-mm-dd';
              MySettings.ShortTimeFormat := 'hh:nn:ss';
              d := StrToDateTime(Exp_date, MySettings);
              cnt := DaysBetween(Trunc(Now), Trunc(d));
              if cnt < 4 then
                MessageBox(GetDesktopWindow, PChar('Ваша лицензия закончится через ' + IntToStr(cnt) + ' дня!'), PChar('Внимание!'), MB_OK + MB_ICONSTOP);
            except
              on E : Exception do
                MessageBox(GetDesktopWindow, PChar('Ошибка при запуске демо-версии. Свяжитесь, пожалуйста, с разработчиком (info@shopuchet.kz): ' + E.Message), PChar('Внимание'), MB_OK + MB_ICONSTOP);
            end;
          end;

          isProStr := ta.GetFeatureValue('is_pro', '');
          if (isProStr = '') then
            isProKey := True
          else begin
            isProKey := isProStr = '1';
          end;

          isMainKeyStr := ta.GetFeatureValue('is_main_key', '');
          if (isMainKeyStr = '') then
            isMainKey := False
          else begin
            isMainKey := isMainKeyStr = '1';
          end;

          isConstKeyStr := ta.GetFeatureValue('is_const', '');
          if (isConstKeyStr = '') then
            isConstKey := False
          else begin
            isConstKey := isConstKeyStr = '1';
          end;

        END ELSE BEGIN
          // сначала попытаюсь зарегистрировать программу, если не получится, то запускаю UNVERIFIED_VERS
          trialFlags := TA_SYSTEM or TA_VERIFIED_TRIAL;
          trialDaysRemaining := 0;
          Try
            ta.UseTrial(trialFlags);
            // get the number of remaining trial days
            trialDaysRemaining := ta.TrialDaysRemaining(trialFlags);
          except
            on E : EAlreadyVerifiedTrialException do
              trialDaysRemaining := ta.TrialDaysRemaining(trialFlags);

            on E : ETrialExpiredException do
              trialDaysRemaining := 0;

            on E : ETurboActivateException do begin
              try
                trialFlags := TA_SYSTEM or TA_UNVERIFIED_TRIAL;
                ta.UseTrial(trialFlags);
                trialDaysRemaining := ta.TrialDaysRemaining(trialFlags);
              except
                on E : ETurboActivateException do begin
                  MessageBox(GetDesktopWindow, PChar('Ошибка при запуске демо-версии. Свяжитесь, пожалуйста, с разработчиком (info@shopuchet.kz): ' + E.Message), PChar('Внимание'), MB_OK + MB_ICONSTOP);
                  IsActivated := 0;
                end;
              end;
            end;
          end;

          if trialDaysRemaining = 0 then
            IsActivated := 0
          else begin
            IsActivated := 1;
            isProKey  := True;
            isMainKey := True;
          end;
        END;
    end;
  END;

  GotLicenceInfo := True;
end;

end.
 