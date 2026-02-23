unit unSendSmsThread;

interface

uses
  Classes, unCommonFunc, unDBSupport, dmMain, dmReportsThread, SyncObjs, pFIBDatabase,
  DateUtils, SysUtils, Dialogs, Windows, dmReports, Types, StrUtils;

type
  TSendSmsThread = class(TThread)
  private
  protected
    procedure Execute; override;
  public
  end;

implementation

uses
  smsc_api;

procedure TSendSmsThread.Execute;
var
  Connected : Boolean;
  db: TpFIBDatabase;
  sms : SMSC;
  ret: TStringDynArray;
  error : Integer;
  MySettings: TFormatSettings;
  SmsId : integer;
begin

  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageBox(GetDesktopWindow, PChar('Автоматическая рассылка SMS невозможна, т.к. не заполнен логин/пароль' + #10#13 +
      'к сервису SMSC.RU. Задайте логин/пароль в настройках и перезапустите программу!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
    Exit;
  end;

  if (SmsNotifyEnabled > 0) and (trim(SmsNotifyText) = '') then begin
    MessageBox(GetDesktopWindow, PChar('Текст для автоматической рассылки напоминаний о записи не заполнен!' + #10#13 +
      'Заполните текст в настройках и перезапустите программу!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
    Exit;
  end;

  try
    db := MainDM.dbMainSmsThread;
    Connected := unDBSupport.ConnectToFB(db, '');

    if not Connected then
      Exit;

    sms := SMSC.Create;
    sms.SMSC_LOGIN := SmsLogin;
    sms.SMSC_PASSWORD := SmsPassword;

    try
      MainDM.spThreadReadSmsRecipients.ParamByName('DATE_').AsDate := Date;
      if SmsNotifyEnabled > 0 then
        MainDM.spThreadReadSmsRecipients.ParamByName('SMS_NOTIFY_ENABLED_').AsInteger := 1
      else
        MainDM.spThreadReadSmsRecipients.ParamByName('SMS_NOTIFY_ENABLED_').AsInteger := 0;
      MainDM.spThreadReadSmsRecipients.ParamByName('SMS_NOTIFY_TEXT_').AsString := SmsNotifyText;
      MainDM.spThreadReadSmsRecipients.ParamByName('SMS_HB_ENABLED_').AsInteger := SmsHBEnabled;
      MainDM.spThreadReadSmsRecipients.ParamByName('SMS_HB_TEXT_').AsString := SmsHBText;
      MainDM.spThreadReadSmsRecipients.ParamByName('SMS_TRANSLIT_').AsInteger := SmsTranslit;
      OpenSp(MainDM.spThreadReadSmsRecipients, False);
      with MainDM.spThreadReadSmsRecipients do begin
        while not EOF do begin
          if IsDebugHook = 0 then
            ret := sms.send_sms(FieldByName('phone').AsString , FieldByName('text').AsString, SmsTranslit, FieldByName('TIME_TO_SEND').AsString)
          else begin
            ret := StrUtils.SplitString('475, 2', ',');
            ret[0] := '440';
            ret[1] := '1';
          end;

          if ret[0] = '-999' then begin
            MessageBox(GetDesktopWindow, PChar('Нет связи с сервисом SMSC.RU. Проверьте' + #10#13 +
              'интернет-соединение и перезапустите программу!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
            Exit;
          end;

          try
            if StrToInt(ret[1]) > 0 then
              error := 0
            else
              error := StrToInt(ret[1][2]);

            MainDM.spThreadInsSmsHistory.ParamByName('DATETIME_').AsDateTime := EncodeDateTime(StrToInt('20' + Copy(FieldByName('TIME_TO_SEND').AsString, 5, 2)),
                                                                                         StrToInt(Copy(FieldByName('TIME_TO_SEND').AsString, 3, 2)),
                                                                                         StrToInt(Copy(FieldByName('TIME_TO_SEND').AsString, 1, 2)),
                                                                                         StrToInt(Copy(FieldByName('TIME_TO_SEND').AsString, 7, 2)),
                                                                                         StrToInt(Copy(FieldByName('TIME_TO_SEND').AsString, 9, 2)),
                                                                                         0,
                                                                                         0);
            MainDM.spThreadInsSmsHistory.ParamByName('g_client_').AsInteger := FieldByName('g_client').AsInteger;
            MainDM.spThreadInsSmsHistory.ParamByName('PHONE_NUMBER_').AsString := FieldByName('phone').AsString;
            if SmsTranslit = 1 then
              MainDM.spThreadInsSmsHistory.ParamByName('TEXT_').AsString := TranslitRus(FieldByName('TEXT').AsString)
            else
              MainDM.spThreadInsSmsHistory.ParamByName('TEXT_').AsString := FieldByName('TEXT').AsString;

            if error = 0 then begin
              MainDM.spThreadInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := -1;
              MainDM.spThreadInsSmsHistory.ParamByName('ERROR_').Clear;
            end else begin
              if error = 7 then
                MainDM.spThreadInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := 22
              else if error = 8 then
                MainDM.spThreadInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := 25
              else
                MainDM.spThreadInsSmsHistory.ParamByName('G_SMS_STATUS_').AsInteger := 100;
              MainDM.spThreadInsSmsHistory.ParamByName('ERROR_').AsInteger := error;
            end;

            MainDM.spThreadInsSmsHistory.ParamByName('SMS_ID_').AsInteger := StrToInt(ret[0]);

            ExecSP(MainDM.spThreadInsSmsHistory);
            Next;
          except
            on E : Exception do begin
              //MessageBox(GetDesktopWindow, PChar('Ошибка при рассылке SMS: ' + e.Message), PChar('Внимание'), MB_OK + MB_ICONSTOP);
              Next;  //хз че делать???
            end;
          end;
        end;
      end;
    finally
      sms.Destroy;
    end;
  finally
    DisconnectFromFB(db);
  end;
end;

end.
