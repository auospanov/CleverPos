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
  cxClasses;

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
    procedure btHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExtendTrialClick(Sender: TObject);
    procedure btnActivateClick(Sender: TObject);
    procedure btnLoadLicenseClick(Sender: TObject);
    procedure aShowOldLicExecute(Sender: TObject);
  public
  private
    function CheckKey(Filename : string) : boolean;
    //procedure SaveKeyPath(Filename : string);
    procedure GetOldLicenseData;
  protected
    Exp_date : WideString;
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

procedure TLicenseForm.FormShow(Sender: TObject);
begin
  //если клиент старый, то у него старая лицензия, которую надо использовать
  IF FileExists('License.dat') THEN BEGIN
      pnlNew.Visible := False;
      pnlOld.Visible := True;
      GetOldLicenseData;
  END ELSE BEGIN
      pnlNew.Visible := True;
      pnlOld.Visible := False;

      IF NOT GotLicenceInfo THEN BEGIN
        lbLicenseStatus.Caption := 'Информация о лицензии еще не получена. Откройте окно через 3-5 минут.';
        btnActivate.Enabled := False;
        btnExtendTrial.Enabled := False;
        btnActivate.Caption := 'Активировать';
        btnActivate.Hint := 'Выполнить активацию программы';
      END ELSE BEGIN
        Exp_date := ta.GetFeatureValue('licence_expired', '');

        if (IsActivated = 1) and (trialDaysRemaining > 0) then begin
          lbLicenseStatus.Caption := 'Ваша демо-версия закончится через ' + IntToStr(trialDaysRemaining) + ' дней.';
          btnActivate.Caption := 'Активировать';
          btnActivate.Hint := 'Выполнить активацию программы';
        end else if (IsActivated = 1) and (trialDaysRemaining = 0) then begin
          lbLicenseStatus.Caption := 'Программма успешно активирована. Срок лицензии до ' + Exp_date;
          btnActivate.Caption := 'Деактивировать';
          btnActivate.Hint := 'Выполнить деактивацию программы, чтобы перенести лицензию на другой компьютер.';
          btnExtendTrial.Visible := False;
          btnExtendTrial.Enabled := False;
        end else if (IsActivated = 0) and (isGenuine) and  (trialDaysRemaining = 0) then begin
          lbLicenseStatus.Caption := 'Срок лицензионного ключа (' + Exp_date + ') истек. Обновите ключ.';
          btnActivate.Caption := 'Обновить';
          btnActivate.Hint := 'Обновить лицензионный ключ';
          btnExtendTrial.Visible := True;
          btnExtendTrial.Enabled := True;
        end else begin
          lbLicenseStatus.Caption := 'Требуется активация программы.';
          btnActivate.Caption := 'Активировать';
          btnActivate.Hint := 'Выполнить активацию программы';
        end;
      END;
  END;

  if Screen.PixelsPerInch = 120 then begin
    lbLicenseStatus.Font.Size := 14;
  end;

  lbLicenseStatus.Width := ScaleDimension(520);
end;

procedure TLicenseForm.GetOldLicenseData;
begin
  if (IsActivated = 1) AND (trialDaysRemaining = 0) AND FileExists('License.dat') then begin
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
       lbLicenseStatus.Caption := 'Ваша демо-версия закончится через ' + IntToStr(trialDaysRemaining) + ' дней.';
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
      GetOldLicenseData;
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
begin
  inherited;

  TRY
    Screen.Cursor := crHourGlass;

    if (isGenuine) and (IsActivated = 0) and (trialDaysRemaining = 0) then begin
      Try
        case ta.IsGenuine() of
          Genuine, GenuineFeaturesChanged:
          begin
              Exp_date := ta.GetFeatureValue('licence_expired', '');
              if (Exp_date = '') or (not ta.IsDateValid(Exp_date, TA_HAS_NOT_EXPIRED)) then begin
                IsActivated := 0;
                lbLicenseStatus.Caption := 'Новый срок лицензионного ключа (' + Exp_date + ') истек. Обновите снова.';
                btnActivate.Caption := 'Обновить';
                btnActivate.Hint := 'Обновить лицензионный ключ';
              end else begin
                IsActivated := 1;
                lbLicenseStatus.Caption := 'Программма успешно активирована. Срок лицензии до ' + Exp_date;
                btnActivate.Caption := 'Деактивировать';
                btnActivate.Hint := 'Выполнить деактивацию программы, чтобы перенести лицензию на другой компьютер.';
              end;
              exit;
          end;

          NotGenuine, NotGenuineInVM:
          begin
              IsActivated := 0;
              lbLicenseStatus.Caption := 'Требуется активация программы.';
              btnActivate.Caption := 'Активировать';
              btnActivate.Hint := 'Выполнить активацию программы';
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
    end else if (isGenuine) and (IsActivated = 1) then begin
      // deactivate product without deleting the product key
      // allows the user to easily reactivate
      ta.Deactivate(false);
      isGenuine := false;
      IsActivated := 0;
      btnActivate.Caption := 'Активировать';
      btnActivate.Hint := 'Выполнить активацию программы';

      // сначала попытаюсь зарегистрировать программу, если не получится, то запускаю UNVERIFIED_VERS
      trialFlags := TA_SYSTEM or TA_VERIFIED_TRIAL;
      trialDaysRemaining := 0;
      Try
        ta.UseTrial(trialFlags);
        trialDaysRemaining := ta.TrialDaysRemaining(trialFlags);
      except
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
         lbLicenseStatus.Caption := 'Ваша демо-версия закончится через ' + IntToStr(trialDaysRemaining) + ' дней.';
    end
    else // this app isn't activated - launch TurboActivate and wait for it to exit
    begin
      //Note: you can launch the TurboActivate wizard or you can create you own interface

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
              lbLicenseStatus.Caption := 'Программма успешно активирована.';
              btnActivate.Caption := 'Деактивировать';
              btnActivate.Hint := 'Выполнить деактивацию программы, чтобы перенести лицензию на другой компьютер.';
              isGenuine := true;
              IsActivated := 1;
              btnExtendTrial.Visible := False;
              btnExtendTrial.Enabled := False;
          end;
        end
      else ShowMessage('Невозможно запустить приложение TurboActivate.exe');

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
    end;
  FINALLY
    Screen.Cursor := crDefault;
  END;
end;

end.
