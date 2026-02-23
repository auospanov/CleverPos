unit frmUpgradeDBLast;

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
  cxMemo, Grids, ValEdit, FIBDatabase, pFIBDatabase, DB, FIBDataSet, pFIBDataSet, FIB, System.UITypes,
  cxClasses, Vcl.Menus, cxButtons, cxEditRepositoryItems, pFIBScripter,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TUpgradeDBLastForm = class(TDlgForm)
    Panel2: TPanel;
    Panel3: TPanel;
    mLog: TcxMemo;
    Label1: TLabel;
    Timer: TTimer;
    Panel4: TPanel;
    ProgressBar: TProgressBar;
    mScript: TcxMemo;
    spUpdateDb: TpFIBDataSet;
    tranMainWrite: TpFIBTransaction;
    spUpdateData: TpFIBDataSet;
    lstUpdateData: TValueListEditor;
    lstUpdateDbOld: TValueListEditor;
    scriptUpdate: TpFIBScripter;
    lstUpdateDb: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure scriptUpdateBeforeStatementExecute(Sender: TObject; Line,
      StatementNo: Integer; Desc: TStatementDesc; Statement: TStrings);
    procedure scriptUpdateExecuteError(Sender: TObject; StatementNo,
      Line: Integer; Statement: TStrings; SQLCode: Integer; const Msg: string;
      var doRollBack, Stop: Boolean);
  private
  public
    SuccessUpd : Boolean;
    FLastVers : Integer;
  end;

var
  UpgradeDBLastForm: TUpgradeDBLastForm;

implementation

uses frmMain, unCommonFunc, dmMain, unDBSupport;

{$R *.dfm}

procedure TUpgradeDBLastForm.FormCreate(Sender: TObject);
begin
  inherited;
  SuccessUpd := False;
end;

procedure TUpgradeDBLastForm.TimerTimer(Sender: TObject);
var
  Reg: TRegistry;
  FZip: TZipForge;
  FFileName, FFileZipName, RemoteDir : string;
  i, J, k, FLastVersLoc : integer;

  procedure SetIsUpdate(val : string);
  begin
    MainDm.spWriteUniversal.SelectSQL.Text := 'update SYSTEM_SETUP set s_value = ' + val + ' where SYSTEM_SETUP = 7';
    OpenSp(MainDm.spWriteUniversal, false);
    MainDm.spWriteUniversal.Transaction.Commit;
    MainDm.spWriteUniversal.Close;
  end;
begin
  Timer.Enabled := False;
  btnOk.Enabled := False;
  mLog.Lines.Clear;

  btnCancel.Enabled := False;
  Screen.Cursor := crHourGlass;

  //============================================================
  //СДЕЛАЮ БЭКАП, БЭКАП ДЕЛАЕТСЯ ТОЛЬКО НА СЕРВЕРЕ В СЛУЧАЕ СЕТЕВОГО РЕЖИМА
  //на Win8 есть такой нюанс по поводу безопасности - надо запускать приложение от имени Администратора
  //иначе просто файлы бэкапа не создаются, поэтому я проверяю - создался ли файл
  // если не создался - значит прав нет, выдаю ошибку и ничего не делаю
  //============================================================
  mLog.Lines.Add('Запущено резервное копирование БД...');
  IF (IsDebugHook = 0) and (YesNetwork = 0) THEN BEGIN
    try

      FFileZipName := BackupDir;  //ExtractFilePath(Application.exename) + 'Backup';
      if not DirectoryExists(FFileZipName) then
        CreateDir(FFileZipName);
      GetDir(0, FFileName);
      FFileName := FFileName + '\Shopuchet.FDB';

      // проверяю есть ли уже архивы за сегодня, если есть - СТАВЛЮ В КОНЦЕ ПОРЯДКОВЫЙ НОМЕР.
      // ТО ЕСТЬ ПРИ ОБНОВЛЕНИИ СОХРАНЯЮ НА ВСЯКИЙ СЛУЧАЙ СТАРУЮ КОПИЮ БД ЗА СЕГОДНЯ И СОЗДАЮ НОВУЮ
      // И СТАВЛЮ ПРЕФИКС UPD ЧТОБЫ БЫЛО ВИДНО ЧТО ЭТО КОПИЯ ПРИ ОБНОВЛЕНИИ СОЗДАЛАСЬ
      I := 1;
      FFileZipName := FFileZipName + 'UPD_' + FormatDateTime('YYYYMMDD', Date);
      WHILE I > 0 DO BEGIN
        if FileExists(FFileZipName + '.zip') then
          FFileZipName := FFileZipName + '_' + IntToStr(I)
        ELSE
          break;
        I := I + 1;
      END;
      FFileZipName := FFileZipName + '.zip';
      FZip := TZipForge.Create(nil);
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
  unDBSupport.ConnectToFB(MainDM.dbMain, '');

  // В САМОМ НАЧАЛЕ ОБРУБАЮ ВСЕ КОННЕКТЫ, КРОМЕ СВОЕГО, И СТАВЛЮ ПРИЗНАК, ЧТО ИДЕТ ОБНОВЛЕНИЕ БД
  // ЧТОБ ДРУГИЕ НЕ МОГЛИ ЗАЙТИ
  SetIsUpdate('1');
  MainDm.spWriteUniversal.SelectSQL.Text := 'DELETE FROM MON$ATTACHMENTS WHERE MON$ATTACHMENT_ID <> CURRENT_CONNECTION';
  OpenSp(MainDm.spWriteUniversal, false);
  MainDm.spWriteUniversal.Transaction.Commit;
  MainDm.spWriteUniversal.Close;

  Sleep(200);

  mLog.Lines.Add('Процесс создания скрипта обновления до последней версии ...');

  FLastVersLoc := FLastVers;

  if FLastVers < 11023 then
    lstUpdateDbOld.FindRow('11023' + '0' , I)
  else
    lstUpdateDbOld.FindRow(IntToStr(FLastVers+1) + '0' , I);

  //СТАРАЯ ВЕРСИЯ ОБНОВЛЕНИЯ ДО 11058
  IF FLastVers < 11058 THEN BEGIN
      J := 1;
      if I <> -1 then begin
        try
          SuccessUpd := True;
          ProgressBar.Max := lstUpdateDbOld.RowCount;
          ProgressBar.Position := 0;
          while i <= lstUpdateDbOld.RowCount-1 do begin
            spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + lstUpdateDbOld.Cells[1, i];

            if Pos('--END_EXECUTE_BLOCK', lstUpdateDbOld.Cells[1, i]) > 0 then begin
              SuccessUpd := False;
              mLog.Lines.Add('Обновление базы данных. Этап ' + Inttostr(J) + '...');
              with spUpdateDb do begin
                try
                  Open;

                  SuccessUpd := True;
                except
                  on E: EFIBError do begin
                    if Transaction.InTransaction then
                      Transaction.Rollback;
                    mLog.Text := spUpdateDb.SelectSQL.Text;
                    mLog.Lines.Add('Ошибка. Код: ' + IntToStr(E.SQLCode) + '. Детали: ' + E.Message);
                    SuccessUpd := False;
                  end;
                  on E: Exception do begin
                    if Transaction.InTransaction then
                      Transaction.Rollback;
                    mLog.Text := spUpdateDb.SelectSQL.Text;
                    mLog.Lines.Add('Ошибка: ' + E.Message);
                    SuccessUpd := False;
                  end;
                end;
              end;

              if not SuccessUpd then
                Break
              else begin
                spUpdateDb.SelectSQL.Clear;
                spUpdateDb.Close;
                J := J + 1;
                ProgressBar.Position := I;
              end;
            end;

            i := i + 1;
          end;
        except
          on E: EFIBError do begin
            SuccessUpd := False;
            if spUpdateDb.Transaction.InTransaction then
              spUpdateDb.Transaction.Rollback;

            mLog.Text := spUpdateDb.SelectSQL.Text;
            mLog.Lines.Add('Ошибка. Код: ' + IntToStr(E.SQLCode) + '. Детали: ' + E.Message);
          end;
          on E: Exception do begin
            SuccessUpd := False;
            if spUpdateDb.Transaction.InTransaction then
              spUpdateDb.Transaction.Rollback;
            mLog.Lines.Add('Ошибка: ' + E.Message);
          end;
        end;

        if SuccessUpd then begin
            SuccessUpd := False;
            spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + 'UPDATE RDB$PROCEDURES SET RDB$PROCEDURE_SOURCE=NULL, RDB$DESCRIPTION=NULL;' + #10#13;
            spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + 'UPDATE rdb$relation_fields SET RDB$DESCRIPTION=NULL;' + #10#13;
            spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + 'END';

            mLog.Lines.Add('Обновление базы данных. Этап ' + Inttostr(J) + '...');

            with spUpdateDb do begin
              try

                Open;

                if Transaction.InTransaction then
                  Transaction.Commit;

                SuccessUpd := True;
                ProgressBar.Position := ProgressBar.Max;
              except
                on E: EFIBError do begin
                  if Transaction.InTransaction then
                    Transaction.Rollback;
                  mLog.Text := spUpdateDb.SelectSQL.Text;
                  mLog.Lines.Add('Ошибка. Код: ' + IntToStr(E.SQLCode) + '. Детали: ' + E.Message);
                end;
                on E: Exception do begin
                  if Transaction.InTransaction then
                    Transaction.Rollback;
                  mLog.Lines.Add('Ошибка: ' + E.Message);
                end;
              end;
            end;
        end;
      end else
        SuccessUpd := True;

      if SuccessUpd then begin
        SuccessUpd := False;

        if FLastVers < 11023 then
          lstUpdateData.FindRow('11023' + '0' , I)
        else
        // т.к. обновление данных происходит не всегда, то буду тут идти в цикле
        // пока не поймаю версию, которая тут есть
        begin
          while FLastVers < CurrAppVers do begin
            lstUpdateData.FindRow(IntToStr(FLastVers+1) + '0' , I);
            if I = -1 then
              FLastVers := FLastVers + 1
            else
              Break;
          end;
        end;

        if (I <> -1) and (I < 210) then begin // 210 - последняя строка по старой версии обновления
          spUpdateDb.SelectSQL.Text := 'EXECUTE BLOCK' + #10#13;
          spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + 'AS BEGIN' + #10#13;
          while i <= lstUpdateData.RowCount-1 do begin
            spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + lstUpdateData.Cells[1, i] + #10#13;
            i := i + 1;
          end;
          spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + 'END';

          mLog.Lines.Add('Создание скрипта завершено успешно...');
          mLog.Lines.Add('Обновление базы данных. Этап 1...');

          with spUpdateDb do begin
            try
              if Transaction.InTransaction then
                Transaction.Commit;
              Open;
              if Transaction.InTransaction then
                Transaction.Commit;

              SuccessUpd := True;
            except
              on E: EFIBError do begin
                if Transaction.InTransaction then
                  Transaction.Rollback;
                mLog.Lines.Add('Ошибка. Код: ' + IntToStr(E.SQLCode) + '. Детали: ' + E.Message);
              end;
              on E: Exception do begin
                if Transaction.InTransaction then
                  Transaction.Rollback;
                mLog.Lines.Add('Ошибка: ' + E.Message);
              end;
            end;
          end;
        end else
          SuccessUpd := True;
      end;
  END;

  //НОВАЯ ВЕРСИЯ ОБНОВЛЕНИЯ, ПОСЛЕ 11058
  FLastVers := FLastVersLoc;
  if FLastVers < 11058 then
    lstUpdateDb.FindRow('11058' + '0' , K)
  else begin
    if FLastVers = 11099 then
      lstUpdateDb.FindRow('1101000' , K)
    else
      lstUpdateDb.FindRow(IntToStr(FLastVers+1) + '0' , K);
  end;

  if K <> -1 then begin
    try
      SuccessUpd := True;
      ProgressBar.Position := 0;
      while k <= lstUpdateDb.RowCount-1 do begin
        scriptUpdate.Script.Add(lstUpdateDb.Cells[1, k]);

        k := k + 1;
      end;

      scriptUpdate.ExecuteScript;

      if scriptUpdate.Transaction.Active then
        scriptUpdate.Transaction.Commit;

      scriptUpdate.Script.Clear;

      // пересоздаю триггеры, если необходимо, это проверяется в самой процедуре
      // триггеры пересоздаю именно после scriptUpdate.Transaction.Commit, потому что только
      // сейчас изменения закрепятся
      scriptUpdate.Script.Text := 'EXECUTE PROCEDURE RECREATE_TRGS';
      scriptUpdate.ExecuteScript;

      if scriptUpdate.Transaction.Active then
        scriptUpdate.Transaction.Commit;

      scriptUpdate.Script.Clear;

      // теперь обновляю данные
      while FLastVers < CurrAppVers do begin
        lstUpdateData.FindRow(IntToStr(FLastVers+1) + '0' , k);
        if k = -1 then
          FLastVers := FLastVers + 1
        else
          Break;
      end;

      if (k <> -1) AND (K >= 210) then begin // 210 - последняя строка по старой версии обновления
        scriptUpdate.Script.Add('SELECT RDB$SET_CONTEXT (''USER_SESSION'', ''REPLICAT'', ''1'') '+
          'FROM RDB$DATABASE;');
        while k <= lstUpdateData.RowCount-1 do begin
          scriptUpdate.Script.Add(lstUpdateData.Cells[1, k]);

          k := k + 1;
        end;

        scriptUpdate.ExecuteScript;

        if scriptUpdate.Transaction.Active then
          scriptUpdate.Transaction.Commit;
      end;

      scriptUpdate.Script.Text := 'EXECUTE PROCEDURE RECREATE_TRGS';
      scriptUpdate.ExecuteScript;

      if scriptUpdate.Transaction.Active then
        scriptUpdate.Transaction.Commit;

    except
      on E: EFIBError do begin
        SuccessUpd := False;
        if scriptUpdate.Transaction.InTransaction then
          scriptUpdate.Transaction.Rollback;
        mLog.Lines.Add(scriptUpdate.Script.Text);
        mLog.Lines.Add('Ошибка. Код: ' + IntToStr(E.SQLCode) + '. Детали: ' + E.Message);
      end;
      on E: Exception do begin
        SuccessUpd := False;
        if scriptUpdate.Transaction.InTransaction then
          scriptUpdate.Transaction.Rollback;
        mLog.Lines.Add(scriptUpdate.Script.Text);
        mLog.Lines.Add('Ошибка: ' + E.Message);
      end;
    end;
  end;

  SetIsUpdate('0');
  DisconnectFromFB(MainDM.dbMain);

  Screen.Cursor := crDefault;

  if SuccessUpd = False then begin
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО НЕУСПЕШНО --------');
    btnCancel.Enabled := True;
  end else begin
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО УСПЕШНО --------');
    ProgressBar.Position := ProgressBar.Max;

    unDBSupport.ConnectToFB(MainDM.dbMain, '');

    btnOk.Enabled := True;
    btnCancel.Enabled := True;
    Sleep(400);
    Close;
  end;
end;

procedure TUpgradeDBLastForm.FormShow(Sender: TObject);
begin
  inherited;
  Timer.Enabled := True;
end;

procedure TUpgradeDBLastForm.scriptUpdateBeforeStatementExecute(Sender: TObject;
  Line, StatementNo: Integer; Desc: TStatementDesc; Statement: TStrings);
begin
  mLog.Lines.Add('Обновление базы данных. Этап ' + Inttostr(StatementNo) + '...');
  ProgressBar.Max := scriptUpdate.StatementsCount;
  ProgressBar.Position := StatementNo;
  Application.ProcessMessages;
end;

procedure TUpgradeDBLastForm.scriptUpdateExecuteError(Sender: TObject;
  StatementNo, Line: Integer; Statement: TStrings; SQLCode: Integer;
  const Msg: string; var doRollBack, Stop: Boolean);
begin
  mLog.Lines.Add('Ошибка. Выражение №' + IntToStr(StatementNo) +
                 ', строка №' + IntToStr(Line) + '. Детали: ' + Msg
                 + ' Statement ' + Statement.Text
                 + ' SQLCode ' + IntToStr(SQLCode)
                 );
  SuccessUpd := False;
  Stop := True;
  doRollBack := True;
end;

end.
