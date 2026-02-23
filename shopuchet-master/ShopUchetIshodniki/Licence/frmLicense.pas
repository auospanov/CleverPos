unit frmLicense;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, ExtCtrls, StdCtrls, Buttons, unCommonFunc,
  AppEvnts, UnSupport, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME, cxPC, cxControls, Registry,
  cxLookAndFeelPainters, cxButtons, TurboActivateUnit, cxGraphics,
  cxLookAndFeels, Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxContainer, cxEdit, System.UITypes, System.Actions,
  cxClasses, cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TLicenseForm = class(TDBEditForm)
    odlg: TOpenDialog;
    SaveDialog: TSaveDialog;
    pnlNew: TPanel;
    lbLicenseStatus: TLabel;
    btnActivate: TcxButton;
    btnExtendTrial: TcxButton;
    pnlOld: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    edControlNum: TEdit;
    btnLoadLicense: TButton;
    aShowOldLic: TAction;
    btnDeactivate: TcxButton;
    btnExtend: TcxButton;
    procedure btHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExtendTrialClick(Sender: TObject);
    procedure btnActivateClick(Sender: TObject);
    procedure btnLoadLicenseClick(Sender: TObject);
    procedure aShowOldLicExecute(Sender: TObject);
    procedure btnDeactivateClick(Sender: TObject);
    procedure btnExtendClick(Sender: TObject);
  private
    FDoneAct : Boolean;
    function CheckKey(Filename : string) : boolean;
    function FormatDateStr(dt : string) : String;
    //procedure SaveKeyPath(Filename : string);
    procedure GetOldLicenseData;
    procedure SetButtonsEnabled(Exp_date : string);
  public
    property DoneAct: Boolean read FDoneAct write FDoneAct default False;
  end;

var
  LicenseForm: TLicenseForm;

implementation

uses
  unInitApp, TrialExtension, dmMain;

{$R *.dfm}

procedure TLicenseForm.aShowOldLicExecute(Sender: TObject);
begin
  if pnlOld.Visible = False then begin
    pnlNew.Visible := False;
    pnlOld.Visible := True;
    ZNUM := FillNumForLicense;
    GetOldLicenseData;
  end;
end;

procedure TLicenseForm.btHelpClick(Sender: TObject);
begin
  Helpc := 64;
  inherited;
end;

function TLicenseForm.FormatDateStr(dt: string): String;
var
  MySettings: TFormatSettings;
  tt : TDate;
begin
  if dt <> '' then begin
    try
      GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, MySettings);
      MySettings.DateSeparator := '-';
      MySettings.TimeSeparator := ':';
      MySettings.ShortDateFormat := 'yyyy-mm-dd';
      Result := DateToStr(StrToDateTime(dt, MySettings));
    except
      on E: Exception do
        Result := '';
    end;
  end else
    Result := '';
end;

procedure TLicenseForm.FormShow(Sender: TObject);
var Exp_date : WideString;
begin
  //если клиент старый, то у него старая лицензия, которую надо использовать
  IF FileExists(LicenseKeyPath) THEN BEGIN
      pnlNew.Visible := False;
      pnlOld.Visible := True;
      GetOldLicenseData;
  END ELSE BEGIN
      pnlNew.Visible := True;
      pnlOld.Visible := False;
      btnActivate.Enabled := False;
      btnDeactivate.Enabled := False;

      IF NOT GotLicenceInfo THEN BEGIN
        lbLicenseStatus.Caption := 'Информация о лицензии еще не получена. Откройте окно через 3-5 минут.';
        btnActivate.Enabled := False;
        btnExtendTrial.Enabled := False;
        btnActivate.Enabled := True;
      END ELSE BEGIN
        Exp_date := FormatDateStr(ta.GetFeatureValue('licence_expired', ''));

        SetButtonsEnabled(Exp_date);
      END;
  END;

  if Screen.PixelsPerInch = 120 then begin
    lbLicenseStatus.Font.Size := 14;
  end;

  lbLicenseStatus.Width := ScaleDimension(520);
end;

procedure TLicenseForm.GetOldLicenseData;
begin
  if (IsActivated = 1) AND (trialDaysRemaining = 0) AND FileExists(LicenseKeyPath) then begin
    Label3.Caption := 'Программа успешно зарегистрирована.';
    Label3.Font.Color := clNavy;
    edControlNum.Enabled := False;
    edControlNum.Clear;
    btnLoadLicense.Enabled := False;
  end else begin
    Label3.Font.Color := clRed;
    edControlNum.Text := ZNUM;
    edControlNum.ReadOnly := True;
    edControlNum.Font.Color := clGrayText;
  end;
end;

procedure TLicenseForm.SetButtonsEnabled(Exp_date : string);
begin
  btnActivate.Enabled    := False;
  btnActivate.Visible    := False;
  btnDeActivate.Enabled  := False;
  btnDeActivate.Visible  := False;
  btnExtendTrial.Visible := False;
  btnExtendTrial.Enabled := False;
  btnExtend.Enabled      := False;
  btnExtend.Visible      := False;

  if (IsActivated = 1) and (trialDaysRemaining > 0) then begin
    lbLicenseStatus.Alignment := taCenter;
    lbLicenseStatus.Caption := 'Ваша демо-версия закончится через ' + IntToStr(trialDaysRemaining) + ' дней.';
    btnActivate.Enabled     := True;
    btnActivate.Visible     := True;
  end
  else if (IsActivated = 1) and (trialDaysRemaining = 0) then begin
    lbLicenseStatus.Alignment := taLeftJustify;
    lbLicenseStatus.Caption := 'Ваш ключ: ' + ta.GetPKey + #13#10;
    lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Срок лицензионного ключа: ' + Exp_date + #13#10;
    lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Email лицензионного ключа: ' + ta.GetFeatureValue('email', '') + #13#10;

    if (ta.GetFeatureValue('is_pro', '') <> '') then begin
      if (ta.GetFeatureValue('is_pro', '') = '1') then
        lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Версия программы: PRO'
      else
        lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Версия программы: Базовая';
    end;

    btnExtend.Enabled      := True;
    btnExtend.Visible      := True;
    btnDeactivate.Enabled := True;
    btnDeActivate.Visible  := True;
  end
  else if (IsActivated = 0) and (isGenuine) and  (trialDaysRemaining = 0) then begin
    lbLicenseStatus.Alignment := taLeftJustify;
    lbLicenseStatus.Caption := 'Ваш ключ: ' + ta.GetPKey + #13#10;
    lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Срок лицензионного ключа: ' + Exp_date + #13#10;
    lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Email лицензионного ключа: ' + ta.GetFeatureValue('email', '') + #13#10;
    if (ta.GetFeatureValue('is_pro', '') <> '') then begin
      if (ta.GetFeatureValue('is_pro', '') = '1') then
        lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Версия программы: PRO' + #13#10
      else
        lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Версия программы: Базовая' + #13#10;
    end;

    lbLicenseStatus.Caption := lbLicenseStatus.Caption + 'Срок ИСТЕК. Обновите ключ.';
    btnDeactivate.Enabled := True;
    btnDeActivate.Visible  := True;
    btnExtend.Enabled      := True;
    btnExtend.Visible      := True;
  end
  else begin
    lbLicenseStatus.Alignment := taCenter;
    lbLicenseStatus.Caption := 'Требуется активация программы.';

    btnActivate.Enabled     := True;
    btnActivate.Visible     := True;
    btnExtendTrial.Visible  := True;
    btnExtendTrial.Enabled  := True;
  end;
end;

procedure TLicenseForm.btnExtendClick(Sender: TObject);
var Exp_date : WideString;
  isProStr, isMainKeyStr, isConstKeyStr : string;
begin
  if (isGenuine) and (trialDaysRemaining = 0) then begin
    try
      Screen.Cursor := crHourGlass;
      Try
        case ta.IsGenuine() of
          Genuine, GenuineFeaturesChanged:
          begin
              Exp_date := ta.GetFeatureValue('licence_expired', '');

              if (Exp_date = '') or (not ta.IsDateValid(Exp_date, TA_HAS_NOT_EXPIRED)) then
                IsActivated := 0
              else
                IsActivated := 1;

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

              SetButtonsEnabled(FormatDateStr(Exp_date));
              FDoneAct := True;
              exit;
          end;

          NotGenuine, NotGenuineInVM:
          begin
              IsActivated := 0;
              SetButtonsEnabled(FormatDateStr(Exp_date));
              FDoneAct := True;
          end;

          InternetError:
          begin
              ShowMessage('Не удалось установить соединение с сервером активации.');
              exit;
          end;
        end;
      except
        on E : Exception do begin
          ShowMessage('Не удалось обновить лицензию. Ошибка: ' + E.Message);
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end
  else
    MessageDlg('Программа не активирована. Продление ключа невозможно.', mtError, [mbOk], 0);
end;

procedure TLicenseForm.btnExtendTrialClick(Sender: TObject);
var
  trialExt : TfrmTrialExtension;
  trialDaysRemaining : LongWord;
begin
  trialExt := TfrmTrialExtension.Create(nil, ta, trialFlags);
  trialDaysRemaining := 0;

  if trialExt.ShowModal = mrOk then begin
    Try
      // get the number of remaining trial days
      trialDaysRemaining := ta.TrialDaysRemaining(trialFlags);
    except
     on E : ETurboActivateException do begin
       ShowMessage('Не удалось получить количество оставшихся дней демо-версии: ' + E.Message);
     end;
    end;

    // if more trial days then re-enable all app features
    if trialDaysRemaining > 0 then begin
       IsActivated := 1;
       IsProKey := True;      // в демо-версии по умолчанию все PRO
       lbLicenseStatus.Caption := 'Ваша демо-версия закончится через ' + IntToStr(trialDaysRemaining) + ' дней.';
       lbLicenseStatus.Alignment := taCenter;
       FDoneAct := True;
    end;
  end;

  trialExt.Release;
end;

function TLicenseForm.CheckKey(Filename: string) : boolean;
var
    F: TextFile;
    V, FileS, ZNACH: String;
begin
  Result := false;

  ZNACH := UDDDigestToStr(UDDString(ZNUM));
  ZNACH := UDDDigestToStr(UDDString(ZNACH));
  ZNACH := MainDM.IdEncoderMIME1.Encode(ZNACH);
  ZNACH := UDDDigestToStr(UDDString(ZNACH));

  FileS := FileName;
  AssignFile(F, FileS);
  Reset(F);
  Readln(F, V);
  CloseFile(F);

  if ZNACH <> V then begin
    IsActivated := 0;
    MessageDlg('Выбранный Вами ключ не подходит. Выберите другой!', mtWarning, [mbOK], 0);
    Exit;
  end;

  Result := true;
end;

procedure TLicenseForm.btnLoadLicenseClick(Sender: TObject);
var S : String;
  f : TStringList;
begin
  if InputQuery('Введите ключ', '', S) then begin
    try
      f := TStringList.Create();
      if FileExists(ExtractFilePath(Application.ExeName) + 'License.dat') then begin
        f.LoadFromFile(ExtractFilePath(Application.ExeName) + 'License.dat');
        f.Strings[0] := S;
      end else
        f.Add(S);
      f.SaveToFile(ExtractFilePath(Application.ExeName) + 'License.dat');
    finally
      f.Free;
    end;

    if CheckKey(ExtractFilePath(Application.ExeName) + 'License.dat') then begin
      IsActivated := 1;
      IsConstKey := True;
      IsProKey := False;
      GetOldLicenseData;
      FDoneAct := True;
    end;
  end;
end;

{procedure TLicenseForm.SaveKeyPath(Filename: string);
var
  Reg: TRegistry;
begin
  try
    Reg := TRegistry.Create;
    try
      with Reg do begin
        RootKey := RegSetupRoot;
        LazyWrite := False;
        if OpenKey(RegSetupKey, True) then
          try
            WriteString('LicenseKeyPath', Filename);
            LicenseKeyPath := Filename;
          finally
            CloseKey;
          end;
      end;
    finally
      Reg.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TLicenseForm.SaveKeyPath)', mtError, [mbOk], 0);
  end;
end; }

procedure TLicenseForm.btnActivateClick(Sender: TObject);
var
  StartInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
  CreateOK : Boolean;
  TurboActivateExe: string;
  S : AnsiString;
  Exp_date : WideString;
  isProStr, isMainKeyStr, isConstKeyStr : string;
begin
  inherited;

  TRY
    Screen.Cursor := crHourGlass;
    ZeroMemory(@StartInfo, sizeOf(TStartUpInfo));
    ZeroMemory(@ProcInfo, sizeOf(TProcessInformation));

    StartInfo.cb := SizeOf(TStartupInfo);

    S := '"' + ExtractFilePath(Application.exename) + 'Russian.xml"';
    TurboActivateExe := 'TurboActivate.exe ' + S;

    // make the reference count of the string at least 1 necessary for Delphi 2009 +
    UniqueString(TurboActivateExe);

    // launch TurboActivate
    CreateOK := CreateProcess(nil, PChar(TurboActivateExe), nil, nil,False,
                NORMAL_PRIORITY_CLASS,
                nil, nil, StartInfo, ProcInfo);

    if CreateOK then
      begin
        // if you don't want your main window to lockup, then wait on a separate thread
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
        if ta.IsActivated() then
        begin
            isGenuine := true;
            Exp_date  := ta.GetFeatureValue('licence_expired', '');
            if (Exp_date = '') or (not ta.IsDateValid(Exp_date, TA_HAS_NOT_EXPIRED)) then
              IsActivated := 0
            else
              IsActivated := 1;

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

            SetButtonsEnabled(FormatDateStr(ta.GetFeatureValue('licence_expired', '')));
            FDoneAct := True;
        end;
      end
    else ShowMessage('Невозможно запустить приложение TurboActivate.exe');

    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  FINALLY
    Screen.Cursor := crDefault;
  END;
end;

procedure TLicenseForm.btnDeactivateClick(Sender: TObject);
begin
  TRY
    if (isGenuine) {and (IsActivated = 1) }then begin
      Screen.Cursor := crHourGlass;
      // deactivate product without deleting the product key
      // allows the user to easily reactivate
      ta.Deactivate(false);
      isGenuine := false;

      // сначала попытаюсь зарегистрировать программу, если не получится, то запускаю UNVERIFIED_VERS
      trialFlags := TA_SYSTEM or TA_VERIFIED_TRIAL;
      trialDaysRemaining := 0;
      Try
        ta.UseTrial(trialFlags);
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
              MessageBox(GetDesktopWindow, PChar('Невозможно запустить тестовый период. Свяжитесь, пожалуйста, с разработчиком (info@shopuchet.kz): ' + E.Message), PChar('Внимание'), MB_OK + MB_ICONSTOP);
              IsActivated := 0;
            end;
          end;
        end;
      end;

      // if no more trial days then disable all app features
      if trialDaysRemaining = 0 then
         IsActivated := 0
      else
         IsActivated := 1;

      SetButtonsEnabled('');
    end else
      MessageDlg('Программа не активирована. Невозможно выполнить деактивацию.', mtError, [mbOK], 0);
  FINALLY
    Screen.Cursor := crDefault;
  END;
end;

end.
