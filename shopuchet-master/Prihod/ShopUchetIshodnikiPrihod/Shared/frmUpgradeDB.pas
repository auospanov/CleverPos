unit frmUpgradeDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, ExtCtrls, StdCtrls, Buttons, ZipForge, Registry, unInitApp,
  AppEvnts, ComCtrls, FIBQuery, pFIBQuery, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit,
  cxMemo, System.UITypes, cxClasses, Vcl.Menus, cxButtons;

type
  TUpgradeDBForm = class(TDlgForm)
    Panel2: TPanel;
    Panel3: TPanel;
    mLog: TcxMemo;
    Label1: TLabel;
    Timer: TTimer;
    mScriptIBEBlock28: TMemo;
    mScriptIBEBlock37: TMemo;
    mScriptIBEBlock50: TMemo;
    mScriptIBEBlock60: TMemo;
    mScriptiBEBlock: TMemo;
    Panel4: TPanel;
    ProgressBar: TProgressBar;
    mScriptIBEBlock104: TMemo;
    mScriptIBEBlockUpdCost: TMemo;
    mScriptIBEBlock136: TMemo;
    mScriptIBEBlock137GDB: TMemo;
    mScriptIBEBlockUpdKassaId: TMemo;
    mScriptIBEBlockUpdFirm: TMemo;
    mScriptCDisabled: TMemo;
    mScriptCEnabled: TMemo;
    mScriptIBEBlock137: TMemo;
    mScript: TcxMemo;
    mScriptIBEBlock11017: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FCannotClose : Boolean;    // нельзя закрыть во время обновления
  public
    SuccessUpd : Boolean;
    FGlobalUpd : Boolean;
    FLastUpdateVers : Integer;
  end;

var
  UpgradeDBForm: TUpgradeDBForm;

type
  TConnectErrorCallbackFunc = function (AErrorMessage : AnsiString) : integer;  stdcall;
  TScriptErrorCallbackFunc = function (AStmtText, AErrMessage : AnsiString) : integer; stdcall;
  TScriptBeforeExecStatementFunc = function (AStmtText, AText : AnsiString) : integer; stdcall;
  TScriptAfterExecStatementFunc = function (AStmtText : AnsiString; Success : integer) : integer; stdcall;
  TScriptIBEBlockProgressFunc = function (AProgressMessage : AnsiString) : integer; stdcall;

  TExecuteScriptProc = procedure (AScriptFile : AnsiString;
                                  AErrorCallbackFunc : TScriptErrorCallbackFunc;
                                  ABeforeCallbackFunc : TScriptBeforeExecStatementFunc;
                                  AAfterCallbackFunc : TScriptAfterExecStatementFunc); stdcall;

  TExecuteScriptProc2 = procedure (AScriptFile : AnsiString;
                                  AErrorCallbackFunc : TScriptErrorCallbackFunc;
                                  ABeforeCallbackFunc : TScriptBeforeExecStatementFunc;
                                  AAfterCallbackFunc : TScriptAfterExecStatementFunc;
                                  AIBEBlockProgressFunc : TScriptIBEBlockProgressFunc); stdcall;

  TConnectDBProc = function (AConnectParams : AnsiString;
                             AConnectErrorCallbacFunc : TConnectErrorCallbackFunc) : integer; stdcall;

  function HandleError(AStmtText, AErrMessage : AnsiString) : integer; stdcall;
  function BeforeExec(AStmtText, AText : AnsiString) : integer; stdcall;
  function AfterExec(AStmtText : AnsiString; Success : integer) : integer; stdcall;
  function CEH(AErrorMessage : AnsiString) : integer;  stdcall;

implementation

uses frmMain, unCommonFunc, dmMain, unDBSupport;

{$R *.dfm}

function HandleError(AStmtText, AErrMessage : AnsiString) : integer; stdcall;
begin
  Result := 0;
  UpgradeDBForm1.mLog.Lines.Add('------- STATEMENT --------');
  UpgradeDBForm1.mLog.Lines.Add(PAnsiChar(AStmtText));
  UpgradeDBForm1.mLog.Lines.Add('-------   ERROR   --------');
  UpgradeDBForm1.mLog.Lines.Add(PAnsiChar(AErrMessage));
end;

function BeforeExec(AStmtText, AText : AnsiString) : integer; stdcall;
begin
  Result := 0;
  if UpgradeDBForm1.FGlobalUpd then
    UpgradeDBForm1.ProgressBar.Position := UpgradeDBForm1.ProgressBar.Position + 1;
end;

function AfterExec(AStmtText : AnsiString; Success : integer) : integer; stdcall;
begin
  Result := 0;
  if Success = 1 then begin
    UpgradeDBForm1.SuccessUpd := True;
    if UpgradeDBForm1.FGlobalUpd then
      UpgradeDBForm1.ProgressBar.Position := UpgradeDBForm1.ProgressBar.Position + 1
    else
      UpgradeDBForm1.mLog.Lines.Add('Altering successfull...');
  end else begin
    Result := 1; // Abort script execution
    UpgradeDBForm1.SuccessUpd := False;
  end;
end;

function CEH(AErrorMessage : AnsiString) : integer;  stdcall;
begin
  UpgradeDBForm1.mLog.Lines.Add(PAnsiChar(AErrorMessage));
  UpgradeDBForm1.SuccessUpd := False;
end;

procedure TUpgradeDBForm.FormCreate(Sender: TObject);
begin
  inherited;
  SuccessUpd := False;
  FCannotClose := False;
end;

procedure TUpgradeDBForm.TimerTimer(Sender: TObject);
label Unsuccess;
var
  Hndl : THandle;
  Reg: TRegistry;
  ESP : TExecuteScriptProc;
  CP : TConnectDBProc;
  //s : String;
  Res: integer;
  FZip: TZipForge;
  FFileName, FFileNameEtalon, FFileZipName, ScrDis, ScrEn : string;
  i : integer;
  ConsDisSql, UpdSql, ConsEnSql: TStringList;
  fs: TFileStream;
  SS : AnsiString;
  R : Integer;
begin
  Timer.Enabled := False;

  // В САМОМ НАЧАЛЕ ПРОВЕРЮ, ЕСТЬ ЛИ ПОДКЛЮЧЕНИЯ К БАЗЕ, ЕСЛИ ЕСТЬ, ТО НИХУЯ ОБНОВЛЕНИЯ НЕ ЗАПУСКАЮ
  //в общем надо проверять количество коннектов, а это делается только в базе, поэтому надо сначала сконнектится на этот период, и потом расконнектится тут же
  //другого пути не нашел
  if ConnectToFB(MainDM.dbMain, '') then begin
    try
      R := GetConnectionsCount;
      if R > 1 then begin
        mLog.Lines.Add('Невозможно запустить обновление!');
        mLog.Lines.Add('К базе данных подключены другие пользователи. Попросите их отключиться от БД и перезапустите программу.');
        DisconnectFromFB(MainDM.dbMain);
        Exit;
      end;
    finally
      DisconnectFromFB(MainDM.dbMain);
      Sleep(200);   //дам время на отключение
    end;
  end;

  mLog.Lines.Clear;
  FCannotClose := True;
  FGlobalUpd := False;
  btnOk.Enabled := False;
  btnCancel.Enabled := False;
  Screen.Cursor := crHourGlass;

  //============================================================
  //СДЕЛАЮ БЭКАП
  //на Win8 есть такой нюанс по поводу безопасности - надо запускать приложение от имени Администратора
  //иначе просто файлы бэкапа не создаются, поэтому я проверяю - создался ли файл
  // если не создался - значит прав нет, выдаю ошибку и ничего не делаю
  //============================================================
  mLog.Lines.Add('Запущено резервное копирование БД...');
  IF IsDebugHook = 0 THEN BEGIN
    try
      FZip := TZipForge.Create(nil);
      FFileZipName := BackupDir;//ExtractFilePath(Application.exename) + 'Backup';
      if not DirectoryExists(FFileZipName) then
        CreateDir(FFileZipName);

      GetDir(0, FFileName);
      FFileNameEtalon := FFileName + '\' + DataBaseEtalonName;

      // раньше была база .GDB, а теперь .FDB, поэтому буду проверять если есть файл .GDB, то беру его
      if FileExists('SHOPUCHET.GDB') then
        FFileName := FFileName + '\SHOPUCHET.GDB'
      else
        FFileName := FFileName + '\' + DataBaseName;
      // проверяю есть ли уже архивы за сегодня, если есть - СТАВЛЮ В КОНЦЕ ПОРЯДКОВЫЙ НОМЕР.
      // ТО ЕСТЬ ПРИ ОБНОВЛЕНИИ СОХРАНЯЮ НА ВСЯКИЙ СЛУЧАЙ СТАРУЮ КОПИЮ БД ЗА СЕГОДНЯ И СОЗДАЮ НОВУЮ
      // И СТАВЛЮ ПРЕФИКС UPD ЧТОБЫ БЫЛО ВИДНО ЧТО ЭТО КОПИЯ ПРИ ОБНОВЛЕНИИ СОЗДАЛАСЬ
      I := 1;
      FFileZipName := FFileZipName + '\UPD_' + FormatDateTime('YYYYMMDD', Date);
      WHILE I > 0 DO BEGIN
        if FileExists(FFileZipName + '.zip') then
          FFileZipName := FFileZipName + '_' + IntToStr(I)
        ELSE
          break;
        I := I + 1;
      END;
      FFileZipName := FFileZipName + '.zip';
      FZip.FileName := FFileZipName;
      FZip.OpenArchive(fmCreate);
      if (Length(FFileName) > 0) then
        FZip.AddFiles(FFileName);
      FZip.CloseArchive;

      if not (FileExists(FFileZipName)) then begin
          MessageDlg('Невозможно создать резервную копию!' + #10#13 +
                     'Запустите приложение от имени Администратора или проверьте права'+ #10#13+
                     'пользователя под которым Вы вошли в систему.', mtError, [mbOk], 0);
          mLog.Lines.Add('------- НЕВОЗМОЖНО СОЗДАТЬ РЕЗЕРВНУЮ КОПИЮ БД --------');
          FCannotClose := False;
          btnOk.Enabled := False;
          btnCancel.Enabled := True;
          Screen.Cursor := crDefault;
          Exit;
      end;

      //ставлю запись о дате последнего копирования
      try
        Reg := TRegistry.Create;
        try
          with Reg do begin
            RootKey := RegSetupRoot;
            LazyWrite := False;  {Сохраняем ключи до закрытия}
            if OpenKey(RegSetupKey, True) then
              try
                WriteString('LastBackpDate', DateToStr(Date));

                // до 135 версии в конце выбора папок не проставлялся обратный слэш, затем я это поставил, но если бы оставил в таком состоянии
                // то перестанет создаваться резервная копия, т.к. там не было слэша, поэтому тут зайду в реестр и там поменяю, прибавлю слэш
                if FLastUpdateVers < 100135 then begin
                  if ValueExists('BackupDir') then
                    WriteString('BackupDir', IncludeTrailingPathDelimiter(ReadString('BackupDir')));
                end;
              finally
                CloseKey;
              end;
          end;
        finally
          Reg.Free;
        end;
      except
        on E: Exception do
          MessageDlg(E.Message + #13#10'(occured in unBackup.Execute)', mtError, [mbOk], 0);
      end;
      mLog.Lines.Add('Резервное копирование БД завершено успешно.');
      mLog.Lines.Add('');
    finally
      FZip.Free;
    end;
  END;
  //============================================================
  //КОНЕЦ СДЕЛАЮ БЭКАП
  //============================================================

  //============================================================
  // короче с обновлением целая жопа получилась.
  // к примеру такая ситуация - клиент скачал версию 1, затем пропустил версии 2-4, и скачал версию 5
  // необходимо обновить БД до актуального состояния, запускаю накопленный скрипт, который копился с 2-ой версии
  // этот клиент с версией 1 обновится успешно. Но что делать, если клиент с версией 3 решил обновиться на 5, а
  // в версии 2 было содание Генератора или столбца таблицы, в накопленном скрипте будет создание этих объектов.
  // И так как клиент уже обновлялся на версию 2, у него данные объекты уже будут, и скрипт обругается и обновление прервется
  // НАШЕЛ ТАКОЙ ВЫХОД: разделил на 2 скрипта - первая часть чисто создание процедур и функций, вторая часть - создание системных объектов.
  // Если ниже определенной версии в которой было создание объектов, например 1.0.0.9, то запускаю вторую часть скрипта,
  // если выше, то вторая часть скрипта не запускается. Если после версии 1.0.0.9 будут создаваться объекты, то придется прям
  // отсчитывать строки в зависимости от версии. К примеру, для версии 1.0.0.9 и ниже запускать скрипт с 1-ой строки,
  // а для версий 1.0.0.10 запускать с третьей строки.

  // теперь обновление будет так. В комплекте идет эталонная база. В нее копируются данные из старой базы, затем она удаляется, а на ее место становится
  // эталонная база. Если обновление БД не нужно, тогда эталонная база просто удаляется.
  // опять же надо быть аккуратнее с ГЕНЕРАТОРАМИ, вдруг появились новые, придется от версии к версии брать разные скрипты сравнений.
  //============================================================
  if not (FileExists(DataBaseEtalonName)) then begin
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО НЕУСПЕШНО --------');
    mLog.Lines.Add('ЭТАЛОННАЯ БАЗА ОБНОВЛЕНИЯ НЕ НАЙДЕНА');
    btnCancel.Enabled := True;
    Screen.Cursor := crDefault;
    FCannotClose := False;
    Exit;
  end;

  mLog.Lines.Add('Процесс создания скрипта обновления...');
  ProgressBar.Max := 0;

  ScrDis := mScriptCDisabled.Text;
  try
    Hndl := LoadLibrary(PChar('IBEScript.dll'));
    if (Hndl > HINSTANCE_ERROR) then
    begin
      ESP := GetProcAddress(Hndl, 'ExecScriptText');
      if @ESP <> nil then
      begin
        ESP(PChar(ScrDis), @HandleError, @BeforeExec, @AfterExec);
      end;
    end;
  finally
    if Hndl > HINSTANCE_ERROR then
      FreeLibrary(Hndl);
  end;

  // если была ошибка - выхожу
  if UpgradeDBForm1.SuccessUpd = False then
    goto UNSUCCESS;

  ScrEn  := mScriptCEnabled.Text;
  try
    Hndl := LoadLibrary(PChar('IBEScript.dll'));
    if (Hndl > HINSTANCE_ERROR) then
    begin
      ESP := GetProcAddress(Hndl, 'ExecScriptText');
      if @ESP <> nil then
      begin
        ESP(AnsiString(ScrEn), @HandleError, @BeforeExec, @AfterExec);
      end;
    end;
  finally
    if Hndl > HINSTANCE_ERROR then
      FreeLibrary(Hndl);
  end;

  // если была ошибка - выхожу
  if UpgradeDBForm1.SuccessUpd = False then
    goto UNSUCCESS;

  mLog.Lines.Add('Подготовка данных...');
  if Copy(IntToStr(FLastUpdateVers), 1, 2) <> '11' then BEGIN
    if FLastUpdateVers < 10028 then   //в 28-ой версии появились некоторые изменения в структуре БД
      mScript.Text := mScriptiBEBlock.Text
    else if FLastUpdateVers < 10037 then   //в 37-ой версии появились некоторые изменения в структуре БД
      mScript.Text := mScriptiBEBlock28.Text
    else if FLastUpdateVers < 10050 then  //в 50-ой версии появился генератор
      mScript.Text := mScriptiBEBlock37.Text
    else if FLastUpdateVers < 10060 then  //в 60-ой версии появилась таблица g_discont_card
      mScript.Text := mScriptiBEBlock50.Text
    else if FLastUpdateVers < 100105 then  //в 105-ой версии появилось разбиение на склады
      mScript.Text := mScriptiBEBlock60.Text
    else if FLastUpdateVers < 100136 then  //в 136-ой версии появилась таблица фотографий для товаров
      mScript.Text := mScriptiBEBlock104.Text
    else if FLastUpdateVers < 100137 then  //в 137-ой версии появилось 5 таблиц для составных товаров
      mScript.Text := mScriptiBEBlock136.Text
    else begin
      // раньше была база .GDB, а теперь .FDB, поэтому буду проверять если есть файл .GDB, то беру его
      if FileExists('SHOPUCHET.GDB') then
        mScript.Text := mScriptiBEBlock137GDB.Text
      else
        mScript.Text := mScriptiBEBlock137.Text
    end;
  END ELSE begin
    if FLastUpdateVers < 11017 then begin
      // раньше была база .GDB, а теперь .FDB, поэтому буду проверять если есть файл .GDB, то беру его
      if FileExists('SHOPUCHET.GDB') then
        mScript.Text := mScriptiBEBlock137GDB.Text
      else
        mScript.Text := mScriptiBEBlock137.Text;
    end else
      mScript.Text := mScriptiBEBlock11017.Text;
  end;

  try
    Hndl := LoadLibrary(PChar('IBEScript.dll'));
    if (Hndl > HINSTANCE_ERROR) then
    begin
      ESP := GetProcAddress(Hndl, 'ExecScriptText');
      if @ESP <> nil then
      begin
        ESP(AnsiString(mScript.Text), @HandleError, @BeforeExec, @AfterExec);
      end;
    end;
  finally
    if Hndl > HINSTANCE_ERROR then
      FreeLibrary(Hndl);
  end;

  Sleep(1000);  // задержка на всякий случай, чтобы файлы успели появится

  if not FileExists('1.sql') then begin
    mLog.Lines.Add('------- СКРИПТ1 ОБНОВЛЕНИЯ НЕ СОЗДАН --------');
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО НЕУСПЕШНО --------');
    btnCancel.Enabled := True;
    Screen.Cursor := crDefault;
    FCannotClose := False;
    SuccessUpd := False;
    Exit;
  end;

  if not FileExists('2.sql') then begin
    mLog.Lines.Add('------- СКРИПТ2 ОБНОВЛЕНИЯ НЕ СОЗДАН --------');
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО НЕУСПЕШНО --------');
    btnCancel.Enabled := True;
    Screen.Cursor := crDefault;
    FCannotClose := False;
    SuccessUpd := False;
    Exit;
  end;

  if not FileExists('ibe_comp.sql') then begin
    mLog.Lines.Add('------- СКРИПТ ОБНОВЛЕНИЯ НЕ СОЗДАН --------');
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО НЕУСПЕШНО --------');
    btnCancel.Enabled := True;
    Screen.Cursor := crDefault;
    FCannotClose := False;
    SuccessUpd := False;
    Exit;
  end;

  // Парсю скрипты
  ConsDisSql := TStringList.Create;
  UpdSql     := TStringList.Create;
  ConsEnSql  := TStringList.Create;
  try
    ConsDisSql.LoadFromFile('1.sql');
    ProgressBar.Max := ConsDisSql.Count;

    UpdSql.LoadFromFile('ibe_comp.sql');
    ProgressBar.Max := ProgressBar.Max + UpdSql.Count - Round(UpdSql.Count/3);   //1/3 всех строк данного скрипта - пустые

    ConsEnSql.LoadFromFile('2.sql');
    ProgressBar.Max := ProgressBar.Max + ConsEnSql.Count;

    mScript.Text := ConsDisSql.Text + #10#13 + UpdSql.Text + #10#13 + ConsEnSql.Text;
  finally
    FreeAndNil(ConsDisSql);
    FreeAndNil(UpdSql);
    FreeAndNil(ConsEnSql);
  end;

  if (FLastUpdateVers < 100105) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) <> '11') then BEGIN
    mScript.Text := mScript.Text + #10#13 + 'UPDATE KASSA K SET K.G_TOCHKA = 1;' + #10#13 +
         'UPDATE KASSA_BEZNAL SET G_TOCHKA = 1;' + #10#13 +
         'UPDATE KASSA_STATE SET G_TOCHKA = 1;' + #10#13 +
         'UPDATE LT_SKLAD_PRODUCT SET G_TOCHKA = 1;' + #10#13 +
         'UPDATE REVISION SET G_TOCHKA = 1;' + #10#13 +
         'UPDATE SKLAD SET G_TOCHKA = 1;' + #10#13 +
         'UPDATE SKLAD_PARENT SET G_TOCHKA = 1;' + #10#13 +
         'UPDATE ZAKAZ SET G_TOCHKA = 1;' + #10#13 +
         'UPDATE ZAKAZ_REAL_PARENT SET G_TOCHKA = 1;' + #10#13 +
         'COMMIT WORK;';
  end;

  // надо апдейтить новое поле IS_KIT в таблице товаров
  if (FLastUpdateVers < 100137) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) <> '11')  then
    mScript.Text := mScript.Text + 'UPDATE G_PRODUCT SET IS_KIT = 0 WHERE IS_CATEGORY = 0;' + #10#13 +
         'UPDATE G_FIRM_REKVIZIT SET IS_DEFAULT = 1;' + #10#13 +
         'COMMIT WORK;' + #10#13;

  // был косячок, G_TOCHKA при импорте был НУЛЛ, пришлось исправлять вот таким способом
  if (FLastUpdateVers <= 100140) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) <> '11')  then
    mScript.Text := mScript.Text + 'UPDATE LT_SKLAD_PRODUCT SET G_TOCHKA = 1 WHERE G_TOCHKA IS NULL;' + #10#13 +
         'COMMIT WORK;' + #10#13;

  mScript.Text := mScript.Text + 'EXECUTE IBEBLOCK' + #10#13 +
       'AS' + #10#13 +
       'BEGIN' + #10#13;

  //ЕСЛИ ТЕКУЩАЯ ВЕРСИЯ МЕНЬШЕ 114, ТО НАДО ПРОАПДЕЙТИТЬ НОВЫЕ ПОЛЯ COST_PRICE
  if (FLastUpdateVers < 100114) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) <> '11') then
    mScript.Text := mScript.Text + mScriptIBEBlockUpdCost.Text + #10#13;

  // ОБНОВЛЯЮ ID KASSA_BEZNAL_STATE И KASSA_BEZNAL, Т.К. БЫЛ УДАЛЕН ИХ ГЕНЕРАТОР
  if (FLastUpdateVers < 100155) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) <> '11') then
    mScript.Text := mScript.Text + mScriptIBEBlockUpdKassaId.Text + #10#13;

  if (FLastUpdateVers < 100160) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) <> '11') then
    mScript.Text := mScript.Text + mScriptIBEBlockUpdFirm.Text + #10#13;

  if ((FLastUpdateVers < 11011) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) = '11')) or
  (Copy(IntToStr(FLastUpdateVers), 1, 2) = '10') then
    mScript.Text := mScript.Text + 'UPDATE zakaz Z SET Z.summ_cash = DECODE(Z.g_payment_type, 1, Z.summ_FACT, 0),' +
     'Z.summ_noncash = DECODE(Z.g_payment_type, 2, Z.summ_FACT, 0) '+ #10#13 +
     'WHERE Z.is_spisanie = 0;'+ #10#13;

  if ((FLastUpdateVers < 11015) AND (Copy(IntToStr(FLastUpdateVers), 1, 2) = '11')) then
    mScript.Text := mScript.Text + 'INSERT INTO G_PRODUCT (G_PRODUCT, NAME, IS_ACTIVE, IS_CATEGORY) VALUES (-1, ''Все товары'', 1, 1);'+ #10#13;

  mScript.Text := mScript.Text + '  COMMIT;' + #10#13 + 'END;';
  mLog.Lines.Add('Создание скрипта завершено успешно...');
  //============================================================
  // конец создания скрипта
  //============================================================
  ProgressBar.Position := 0;
  ProgressBar.Max := ProgressBar.Max + 300;  // ВДРУГ ЧТО-ТО НЕ УЧЕЛ, КАКИЕ-ТО СТРОКИ МИМО ПРОШЛИ, РЕШИЛ ЧУТЬ БОЛЬШЕ ПОСТАВИТЬ

  if Trim(mScript.Text) = '' then
  begin
    ShowMessage('Скрипт обновления не заполнен!');
    Exit;
  end;

  mLog.Lines.Add('Загрузка данных...');
  FGlobalUpd := True;
  try
    Hndl := LoadLibrary(PChar('IBEScript.dll'));
    if (Hndl > HINSTANCE_ERROR) then
    begin
      ESP := GetProcAddress(Hndl, 'ExecScriptText');
      CP := GetProcAddress(Hndl, 'Connect');
      if (@ESP <> nil) and (@CP <> nil) then
      begin
       Res := CP(AnsiString('db_name='+ FFileNameEtalon + '; password=masterkey; user_name=sysdba;'+
                       'lc_ctype=win1251; sql_role_name=RDB$ADMIN; sql_dialect=3;' +
                       'clientlib="fbclient.dll"'), @CEH);
       if Res = 0 then
         ESP(AnsiString(mScript.Text), @HandleError, @BeforeExec, @AfterExec);
      end;
    end;
  finally
    if Hndl > HINSTANCE_ERROR then
      FreeLibrary(Hndl);
  end;

  UNSUCCESS:

  FCannotClose := False;
  Screen.Cursor := crDefault;
  IF SuccessUpd then BEGIN
    //удаляю старую базу
    if not (DeleteFile(FFileName)) then begin
      MessageDlg('Старую БД не удалось удалить!', mtError, [mbOk], 0);
      mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО НЕУСПЕШНО --------');
      mLog.Lines.Add('НОВАЯ БАЗА ОБНОВЛЕНА И НАХОДИТСЯ В ' + FFileNameEtalon);
      mLog.Lines.Add('СТАРУЮ БАЗУ УДАЛИТЬ НЕ УДАЛОСЬ, МОЖЕТЕ ЗАМЕНИТЬ ВРУЧНУЮ.');
      btnCancel.Enabled := True;
      Exit;
    end;

    // Т.К. СТАРАЯ БАЗА РАНЬШЕ БЫЛА БАЗА .GDB, А ТЕПЕРЬ .FDB, НАДО УДАЛЯТЬ ОБЕ НА ВСЯКИЙ
    if FileExists('SHOPUCHET.FDB') then
      DeleteFile('SHOPUCHET.FDB');

    //МЕНЯЮ НОВУЮ БАЗУ НА МЕСТО СТАРОЙ
    RenameFile(FFileNameEtalon, DataBaseName);
    DeleteFile('1.sql');
    DeleteFile('2.sql');
    DeleteFile('ibe_comp.sql');

    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО УСПЕШНО --------');
    ProgressBar.Position := ProgressBar.Max;

    btnOk.Enabled := True;
    btnCancel.Enabled := True;
    Sleep(400);
    Close;
  END ELSE BEGIN
    btnCancel.Enabled := True;
    // ПИШУ В ЛОГ ОШИБКУ ОБНОВЛЕНИЯ, Т.К. ДО MAINLOGFILE ЕЩЕ ДЕЛО НЕ ДОШЛО, ПРИДЕТСЯ ЕГО ВСКРЫВАТЬ И ТУДА ПИСАТЬ
    fs := TFileStream.Create('UpgradeErr.log', fmCreate or fmOpenWrite);
    try
      SS := mLog.TEXT;
      fs.WriteBuffer(SS[1], Length(SS));
    finally
      fs.Free;
    end;
  END;
end;

procedure TUpgradeDBForm.FormShow(Sender: TObject);
begin
  inherited;
  Timer.Enabled := True;
end;

procedure TUpgradeDBForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if FCannotClose = True then
    CanClose := False
  else
    CanClose := True;

  if FileExists('1.sql') then
    DeleteFile('1.sql');
  if FileExists('2.sql') then
    DeleteFile('2.sql');
  if FileExists('ibe_comp.sql') then
    DeleteFile('ibe_comp.sql');
end;

end.
