unit unGetLicenceThread;

interface

uses
  Classes, SyncObjs, DateUtils, SysUtils, Dialogs, Windows,
  unCommonFunc, TurboActivateUnit, Controls, ActiveX, unInfo, ComObj,
  unSupport;

type
  TGetLicenceThread = class(TThread)
  private
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
    FileS := 'License.dat'; //LicenseKeyPath
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

procedure TGetLicenceThread.Execute;
var
  gr : IsGenuineResult;
  Exp_date : WideString;
  frmReverify : TfrmReVerifyNow;
  MySettings: TFormatSettings;
  d : TDateTime;
  cnt : integer;
begin
  // ЕСЛИ В РЕЖИМЕ ДЕБАГ, ТО СРАЗУ СТАВЛЮ БУДТО ЛИЦЕНЗИЯ ДАНА
  IF IsDebugHook <> 0 then
    IsActivated := 1

  ELSE BEGIN

    //если клиент старый, то у него старая лицензия, которую надо использовать
    if FileExists('License.dat') then begin
      if GetNum = True then
        IsActivated := 1
      else
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
            IsActivated := 1;

            try
              MySettings := TFormatSettings.Create(GetUserDefaultLCID);
              MySettings.DateSeparator := '-';
              MySettings.TimeSeparator := ':';
              MySettings.ShortDateFormat := 'yyyy-mm-dd';
              MySettings.ShortTimeFormat := 'hh:nn:ss';
              d := StrToDateTime(Exp_date, MySettings);
              cnt := DaysBetween(Trunc(Now), Trunc(d));
              if cnt < 4 then
                MessageBox(GetDesktopWindow, PChar('Ваша лицензия закончится через ' + IntToStr(cnt) + ' дня!'), PChar('Внимание!'), MB_OK + MB_ICONSTOP);
            finally
              FreeAndNil(MySettings);
            end;
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
          else
            IsActivated := 1;
        END;
    end;
  END;

  GotLicenceInfo := True;
end;

end.
 