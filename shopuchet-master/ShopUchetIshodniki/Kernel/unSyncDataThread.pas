unit unSyncDataThread;

interface

uses
  Classes, unCommonFunc, unDBSupport, dmMain, dmReportsThread, SyncObjs, pFIBDatabase,
  DateUtils, SysUtils, Dialogs, Windows, dmReports, FIB, Data.DB, unInitApp;

type
  TSyncDataThread = class(TThread)
  private
    FSleepEvent: TSimpleEvent;
  protected
    procedure Execute; override;
    procedure DoImport(firstExecute : boolean);
    procedure DoExport;
    procedure DeleteOlds;
    procedure ImportWithErrs;
    procedure DoRecalcKassa;
    procedure DoRecalcReminders;
    procedure WriteLog(str : string);
  public
    FirstStart : boolean;   // это значит, что поток был запущен при старте программы
    TerminateImmediate : boolean;   // это значит поток был запущен перед закрытием программы
    ProcessingNow : boolean; // флаг, что в данный момент идет загрузка в базу
    constructor Create;
    destructor Destroy; override;
  end;

implementation


constructor TSyncDataThread.Create;
var FLogName : string;
begin
  FSleepEvent := TSimpleEvent.Create;
  inherited Create( False );
  Priority := tpLower;

  ProcessingNow := False;

  DateTimeToString(FLogName, 'YYYYMMDD', date);
  FLogName := ExtractFilePath(ProductName + '.exe') + 'Log\' + FLogName + '.log';
  AssignFile(SyncLogFile, FLogName);
  if not (FileExists(FLogName)) then
    Rewrite(SyncLogFile);

  if not (DirectoryExists('Log\ArchErr\')) then
    CreateDir('Log\ArchErr\');
end;

destructor TSyncDataThread.Destroy;
begin
  if TTextRec(SyncLogFile).Mode <> fmClosed then
    CloseFile(SyncLogFile);

  Terminate;
  FSleepEvent.SetEvent;
  inherited;
  FSleepEvent.Free;
end;

procedure TSyncDataThread.DoExport;
var
  Tmp, nowMask, res : string;
begin
  try
      {
      ПЕРЕДЕЛАЛ НА КЛАССИКУ:
      1) АПДЕЙТ ЗАПИСЕЙ НА ПРИЗНАК IS_TRANSFERED = 3
      2) ИХ СЕЛЕКТ
      3) ПОТОМ ИХ АПДЕЙТ НА IS_TRANSFERED = 1
      }
      try
        if not (MainDM.scriptSync.Transaction.InTransaction) then
          MainDM.scriptSync.Transaction.StartTransaction;

        MainDM.scriptSync.SCRIPT.Text := 'UPDATE LOGS L SET L.IS_TRANSFERED = 3 WHERE L.IS_TRANSFERED = 0 AND USR <> ''REPLICAT'';';
        res := ExecScript(MainDm.scriptSync, false);
        if res <> '' then begin
          WriteLog('Ошибка при экспорте SYNC PNT 1: ' + res);
        end;
      except
        on E: EFIBError do begin
          if MainDM.scriptSync.Transaction.InTransaction then
            MainDM.scriptSync.Transaction.Rollback;
          WriteLog('Ошибка при экспорте SYNC PNT 1: ' + IntToStr(E.SQLCode) + ':'#13#10 + E.Message);
        end;
        on E: Exception do begin
          if MainDM.scriptSync.Transaction.InTransaction then
            MainDM.scriptSync.Transaction.Rollback;
          WriteLog('Ошибка при экспорте SYNC PNT 1: ' + E.Message);
        end;
      end;

      try
        if MainDM.spSyncLogOut.Active then
          MainDM.spSyncLogOut.Close;
        MainDM.spSyncLogOut.SelectSQL.Text := 'SELECT ID, SQLSTMT, TTABLE, USR, RR, DAT '+
                                              'FROM LOGS '+
                                              'WHERE IS_TRANSFERED = 3 '+
                                              'AND USR <> ''REPLICAT'' '+
                                              'ORDER BY ID';
        MainDM.spSyncLogOut.Open;
      except
        on E: EFIBError do begin
          if MainDM.spSyncLogOut.Transaction.InTransaction then
            MainDM.spSyncLogOut.Transaction.Rollback;
          WriteLog('Ошибка при экспорте SYNC PNT 2: ' + IntToStr(E.SQLCode) + ':'#13#10 + E.Message);
        end;
        on E: Exception do begin
          if MainDM.spSyncLogOut.Transaction.InTransaction then
            MainDM.spSyncLogOut.Transaction.Rollback;
          WriteLog('Ошибка при экспорте SYNC PNT 2: ' + E.Message);
        end;
      end;

      if MainDM.spSyncLogOut.RecordCount > 0 then begin
        MainDM.mdSyncout.CopyFromDataSet(MainDM.spSyncLogOut);

        //MainDM.spSyncLogOut.Transaction.CommitRetaining;

        DateTimeToString(nowMask, 'YYYYMMDDHHNNSSZZZ', Now);

        try
          with MainDM.spSyncReadComps do begin
            ParamByName('CUR_COMP').AsFloat := SyncCurCompId;
            Open;
            First;
            while not eof do begin
              if SyncId <> '' then
                Tmp := FieldByName('SYNC_COMPS').AsString + '-' + SyncId + '-' + nowMask
              else
                Tmp := FieldByName('SYNC_COMPS').AsString + '-' + nowMask;

              MainDM.mdSyncout.SaveToBinaryFile(SyncFolder + Tmp + '.cdat');
              WriteLog('Файл ' + Tmp + '.cdat' + ' выгружен успешно.');
              Next;
            end;
          end;
        except
          on E: Exception do begin
            if MainDM.spSyncReadComps.Transaction.InTransaction then
              MainDM.spSyncReadComps.Transaction.Rollback;
            WriteLog('Ошибка при экспорте файла SYNC PNT 3: ' + E.Message);
          end;
        end;

        //удаляю выгруженные записи из
        {if not spDelLogOut.Transaction.InTransaction then
          spDelLogOut.Transaction.StartTransaction;

        try
          spDelLogOut.ExecQuery;
          spDelLogOut.Transaction.Commit;
        except
          on E: EFIBError do begin
            if spDelLogOut.Transaction.InTransaction then
              spDelLogOut.Transaction.CommitRetaining;
            WriteLog('Ошибка при экспорте: ' + IntToStr(E.SQLCode) + ':'#13#10 + E.Message);
          end;
          on E: Exception do begin
            if spDelLogOut.Transaction.InTransaction then
              spDelLogOut.Transaction.CommitRetaining;
            WriteLog('Ошибка при экспорте: ' + E.Message);
          end;
        end; }

        try
          MainDM.scriptSync.SCRIPT.Text := 'UPDATE LOGS L SET L.IS_TRANSFERED = 1 WHERE L.IS_TRANSFERED = 3 AND USR <> ''REPLICAT'';';
          res := ExecScript(MainDm.scriptSync, false);
          if res <> '' then begin
            WriteLog('Ошибка при экспорте SYNC PNT 4: ' + res);
          end;

          if MainDM.scriptSync.Transaction.InTransaction then
            MainDM.scriptSync.Transaction.CommitRetaining;
        except
          on E: EFIBError do begin
            if MainDM.scriptSync.Transaction.InTransaction then
              MainDM.scriptSync.Transaction.Rollback;
            WriteLog('Ошибка при экспорте SYNC PNT 4: ' + IntToStr(E.SQLCode) + ':'#13#10 + E.Message);
          end;
          on E: Exception do begin
            if MainDM.scriptSync.Transaction.InTransaction then
              MainDM.scriptSync.Transaction.Rollback;
            WriteLog('Ошибка при экспорте SYNC PNT 4: ' + E.Message);
          end;
        end;
      end;
  finally
    if MainDM.spSyncReadComps.Active then
      MainDM.spSyncReadComps.Close;

    if MainDM.spSyncLogOut.Active then
      MainDM.spSyncLogOut.Close;
  end;
end;

procedure TSyncDataThread.DoImport(firstExecute : boolean);
var
  SR: TSearchRec;
  pos1, pos2 : integer;
  ImportPath : string;
  StrStream: TMemoryStream;
  str, errBody : string;
  needToLoad, successLoad : Boolean;
begin
  needToLoad := False;
  ImportPath := SyncFolder;

  if FindFirst(ImportPath + '*.cdat', faAnyFile, SR) = 0 then begin
    try
      StrStream := TMemoryStream.Create;
      try
        repeat
          if (SR.Attr <> faDirectory) then begin
            if RenameFile(ImportPath + SR.Name, ImportPath + SR.Name) then begin      //значит файл до конца скопирован
              // добавился ключ синхронизации, но у многих его нет, поэтому сначала проверяю название
              // файла, если там нет ключа, то работаю без него
              // структура файла такая 12-{021C2233-E46F-4038-9989-788D9BDAD1C9}-20200721131048783.cdat
              // или 12-20200721131048783.cdat
              // нахожу файл с именем компа и гружу с него
              pos1 := Pos('-', SR.Name);
              str := Copy(SR.Name, 1, Pos1 - 1);

              if StrToInt(str) = SyncCurCompId then begin
                pos1 := Pos('{', SR.Name);
                if pos1 > 0 then begin
                  pos2 := Pos('}', SR.Name);
                  str := Copy(SR.Name, Pos1, pos2 - Pos1 + 1);
                  if str <> SyncId then
                    Continue;
                end;

                successLoad := False;
                MainDm.mdSyncIn.LoadFromBinaryFile(ImportPath + SR.Name);
                MainDm.mdSyncIn.First;
                with MainDm.spImportSyncIn do begin
                  if not Transaction.InTransaction then
                    Transaction.StartTransaction;

                  while NOT MainDm.mdSyncIn.Eof do BEGIN
                    ParamByName('ID_ORIGINAL_').AsInt64 := StrToInt64(MainDm.mdSyncIn.FieldByName('ID').AsString);
                    MainDm.spImportSyncIn.ParamByName('TTABLE_').AsString := MainDm.mdSyncIn.FieldByName('TTABLE').AsString;
                    ParamByName('SQLSTMT_').AsString := MainDm.mdSyncIn.FieldByName('SQLSTMT').AsString;

                    // проверю что текст не пустой
                    if (MainDm.spImportSyncIn.ParamByName('SQLSTMT_').AsString = '') and
                    (MainDm.mdSyncIn.FieldByName('TTABLE').AsString <> 'SYNC_COMPS') then begin
                      successLoad := False;
                      WriteLog('Файл ' + SR.Name + '. ' + 'Ошибка загрузки: текст SQL пустой.');
                      if Transaction.InTransaction then
                        Transaction.Rollback;
                    end
                    else begin
                      IF MainDm.mdSyncIn.FieldByName('DAT').IsNull THEN BEGIN
                        ParamByName('DAT_').Clear;
                        ParamByName('RR_').Clear;
                      END ELSE BEGIN
                        TBlobField(MainDm.mdSyncIn.FieldByName('DAT')).SaveToStream(StrStream);
                        ParamByName('DAT_').LoadFromStream(StrStream);
                        ParamByName('RR_').AsString := MainDm.mdSyncIn.FieldByName('RR').AsString;
                      END;

                      try
                        ExecQuery;

                        needToLoad := true;
                        successLoad := true;
                      except
                        on E: EFIBError do begin
                          case E.SQLCode of
                            -902: WriteLog('Файл ' + SR.Name + '. ' + E.Message + #13#10' + В доступе отказано');
                            -904: WriteLog('Файл ' + SR.Name + '. ' + 'Недоступная база данных'#13#10 +
                                    '(возможно, сервер FireBird остановлен).'#13#10 +
                                    'В доступе отказано');
                          else
                            WriteLog('Файл ' + SR.Name + '. ' + 'Ошибка № ' + IntToStr(E.SQLCode) + ':'#13#10 + E.Message);
                          end;
                          successLoad := False;
                          if Transaction.InTransaction then
                            Transaction.Rollback;
                        end;
                        on E: Exception do begin
                          successLoad := False;
                          WriteLog('Файл ' + SR.Name + '. ' + 'Ошибка загрузки: ' + E.Message);
                          if Transaction.InTransaction then
                            Transaction.Rollback;
                        end;
                      end;
                    end;

                    MainDm.mdSyncIn.Next;
                    StrStream.Clear;
                  END;

                  if Transaction.InTransaction then
                    Transaction.Commit;
                end;

                // переместил теперь это ниже, после загрузки всех файлов, т.к. увидел, что файлы могут грузиться
                // в базу в беспорядке, есть файлы в 10-06, потом в 10-07 и потом в 10-06 и они вот так будут грузиться
                {if needToLoad then begin
                  with MainDm.spSync do begin
                    if not Transaction.InTransaction then
                      Transaction.StartTransaction;

                    try
                      ExecProc;

                      errBody := ParamByName('ERR_BODY').AsString;

                      Transaction.Commit;

                      if errBody <> '' then
                        WriteLog('Файл ' + SR.Name + '. ' + errBody)
                      else
                        successLoad := True;
                    except
                      on E: EFIBError do begin
                        case E.SQLCode of
                          -902: WriteLog('Файл ' + SR.Name + '. ' + E.Message + #13#10'В доступе отказано');
                          -904: WriteLog('Файл ' + SR.Name + '. ' + 'Недоступная база данных'#13#10 +
                                  '(возможно, сервер FireBird остановлен).'#13#10 +
                                  'В доступе отказано');
                        else
                          WriteLog('Файл ' + SR.Name + '. ' + 'Ошибка № ' + IntToStr(E.SQLCode) + ':'#13#10 + E.Message);
                        end;
                        if Transaction.InTransaction then
                          Transaction.Rollback;
                      end;
                      on E: Exception do begin
                        WriteLog('Файл ' + SR.Name + '. ' + 'Ошибка загрузки: ' + E.Message);
                        if Transaction.InTransaction then
                          Transaction.Rollback;
                      end;
                    end;
                  end;
                end;

                if successLoad then
                  WriteLog('Файл ' + SR.Name + ' загружен успешно.')
                else begin
                  //оказывается MoveFile не работает между сетевыми дисками, придется делать CopyFile
                  //а затем DeleteFile
                  CopyFile(PChar(ImportPath + SR.Name), PChar('Log\ArchErr\' + SR.Name), True);
                end;
                }

                if successLoad then
                  WriteLog('Файл ' + SR.Name + ' загружен успешно.')
                else begin
                  //оказывается MoveFile не работает между сетевыми дисками, придется делать CopyFile
                  //а затем DeleteFile
                  CopyFile(PChar(ImportPath + SR.Name), PChar('Log\ArchErr\' + SR.Name), True);
                end;
                DeleteFile(PChar(ImportPath + SR.Name));
              end;
            end;
          end;
        until FindNext(SR) <> 0;
      except
        on E: Exception do begin
          WriteLog('Ошибка при загрузке файлов. Файл ' + SR.Name + '. Ошибка загрузки: ' + E.Message);
          if MainDm.spImportSyncIn.Transaction.InTransaction then
            MainDm.spImportSyncIn.Transaction.Rollback;
        end;
      end;
    finally
      SysUtils.FindClose(SR);
      StrStream.Free;
    end;
  end;

  // переместил теперь это сюда, после загрузки всех файлов, т.к. увидел, что файлы могут грузиться
  // в базу в беспорядке, есть файлы в 10-06, потом в 10-07 и потом в 10-06 и они вот так будут грузиться
  // теперь в базе они упорядочиваются по ID_ORIGINAL и грузятся по порядку
  // НО ТЕПЕРЬ ВОПРОС ВОЗМОЖНО ОДИН ФАЙЛ, ГДЕ ИМЕЕТСЯ ДОЧЕРНИЙ КЛЮЧ, ЗАГРУЗИЛСЯ РАНЬШЕ ДРУГОГО, ГДЕ РОДИТЕЛЬ
  // НАДО ПОЛУЧАЕТСЯ ГРУЗИТЬ КАК-ТО ПАЧКАМИ И ОБРАБАТЫВАТЬ ПАЧКАМИ
  if (needToLoad) or (firstExecute) then begin
    with MainDm.spSync do begin
      if not Transaction.InTransaction then
        Transaction.StartTransaction;

      try
        ExecProc;

        errBody := ParamByName('ERR_BODY').AsString;

        Transaction.Commit;    //??? может не делать тут коммит, а делать в самом конце?

        if errBody <> '' then
          WriteLog('Ошибка FIBError при загрузке изменений. ' + errBody);
      except
        on E: EFIBError do begin
          case E.SQLCode of
            -902: WriteLog('Ошибка FIBError при загрузке изменений. В доступе отказано');
            -904: WriteLog('Ошибка FIBError при загрузке изменений. Недоступная база данных. ' +
                    '(возможно, сервер FireBird остановлен).' +
                    'В доступе отказано');
          else
            WriteLog('Ошибка FIBError при загрузке изменений. Ошибка № ' + IntToStr(E.SQLCode) + ':' + E.Message);
          end;
          if Transaction.InTransaction then
            Transaction.Rollback;
        end;
        on E: Exception do begin
          WriteLog('Ошибка Exception при загрузке изменений. Ошибка загрузки: ' + E.Message);
          if Transaction.InTransaction then
            Transaction.Rollback;
        end;
      end;
    end;
  end;

  // РЕШИЛ ДЕЛАТЬ ПЕРЕСЧЕТ ОСТАТКОВ И КАССЫ ЗА ПОСЛЕДНИЕ 30 ДНЕЙ
  IF (firstExecute) THEN BEGIN
    DoRecalcReminders;
    DoRecalcKassa;
  END;
end;

procedure TSyncDataThread.DoRecalcKassa;
var errBody : string;
begin
  with MainDm.spRecalcKassaForToday do begin
    try
      ParamByName('ACTION_DATE_').AsDate := Date - 30;
      ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := Integer(UploadToMobile);

      if not Transaction.InTransaction then
        Transaction.StartTransaction;

      ExecProc;

      errBody := ParamByName('ERR_MSG').AsString;

      if errBody <> '' then begin
        Transaction.Rollback;
        WriteLog('Ошибка FIBError при пересчете кассы за месяц. ' + errBody);
      end
      else
        Transaction.Commit;

    except
      on E: EFIBError do begin
        case E.SQLCode of
          -902: WriteLog('Ошибка FIBError при пересчете кассы за месяц. В доступе отказано');
          -904: WriteLog('Ошибка FIBError при пересчете кассы за месяц. Недоступная база данных. ' +
                  '(возможно, сервер FireBird остановлен).' +
                  'В доступе отказано');
        else
          WriteLog('Ошибка FIBError при пересчете кассы за месяц. Ошибка № ' + IntToStr(E.SQLCode) + ':' + E.Message);
        end;
        if Transaction.InTransaction then
          Transaction.Rollback;
      end;
      on E: Exception do begin
        WriteLog('Ошибка Exception при пересчете кассы за месяц. Ошибка : ' + E.Message);
        if Transaction.InTransaction then
          Transaction.Rollback;
      end;
    end;
  end;
end;

procedure TSyncDataThread.DoRecalcReminders;
var errBody : string;
begin
  with MainDm.spRecalcReminders do begin
    try
      if not Transaction.InTransaction then
        Transaction.StartTransaction;

      ExecProc;

      errBody := ParamByName('ERR_MSG').AsString;

      if errBody <> '' then begin
        Transaction.Rollback;
        WriteLog('Ошибка FIBError при пересчете остатков товаров. ' + errBody);
      end
      else
        Transaction.Commit;

    except
      on E: EFIBError do begin
        case E.SQLCode of
          -902: WriteLog('Ошибка FIBError при пересчете остатков товаров. В доступе отказано');
          -904: WriteLog('Ошибка FIBError при пересчете остатков товаров. Недоступная база данных. ' +
                  '(возможно, сервер FireBird остановлен).' +
                  'В доступе отказано');
        else
          WriteLog('Ошибка FIBError при пересчете остатков товаров. Ошибка № ' + IntToStr(E.SQLCode) + ':' + E.Message);
        end;
        if Transaction.InTransaction then
          Transaction.Rollback;
      end;
      on E: Exception do begin
        WriteLog('Ошибка Exception при пересчете остатков товаров. Ошибка : ' + E.Message);
        if Transaction.InTransaction then
          Transaction.Rollback;
      end;
    end;
  end;
end;

procedure TSyncDataThread.DeleteOlds;
begin
  MainDm.spDelOlds.SelectSQL.Text := 'DELETE FROM logs WHERE SYSDATE < DATEADD(DAY, -30, CURRENT_DATE) AND IS_TRANSFERED = 1 AND (ERR_CODE IS NULL OR ERR_CODE = 0)';
  OpenSp(MainDm.spDelOlds, False);
  MainDm.spDelOlds.Transaction.Commit;
  MainDm.spDelOlds.Close;
end;

//дозагружаю старые ошибочные
procedure TSyncDataThread.ImportWithErrs;
var res : string;
begin
  MainDM.scriptSync.SCRIPT.Text := 'UPDATE LOGS '+
                                   ' SET IS_TRANSFERED = 0, '+
                                   '     ERR_CODE = 0, '+
                                   '     TRY_CNT = TRY_CNT + 1 '+
                                   ' WHERE IS_TRANSFERED = -1 '+
                                   ' AND ERR_CODE <> 0 '+
                                   ' AND TRY_CNT < 3 '+   // ДОГРУЖАЮ ТОЛЬКО ТЕ, У КОТОРЫХ КОЛ-ВО ПОПЫТОК НЕ БОЛЬШЕ 3
                                   ' AND USR = ''REPLICAT'';';
  res := ExecScript(MainDm.scriptSync, false);
  if res <> '' then begin
    WriteLog('Ошибка при дозагрузке ошибочных записей: ' + res);
  end;
end;

procedure TSyncDataThread.Execute;
var
  Connected : Boolean;
  db: TpFIBDatabase;
begin
  while not Terminated do begin
    if not DirectoryExists(SyncFolder) then begin
      MessageBox(GetDesktopWindow, PChar('Включен сервис "Синхронизация", но папки "' + SyncFolder + '" для обмена '+
      'файлами не существует!' + #10#13 + 'Переопределите папку для синхронизации '+
      'в меню "Настройки приложения - Синхронизация"!' + #10#13 + 'Сервис будет временно ОТКЛЮЧЕН!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
      Terminate;
      Exit;
    end;

    if isActivated = 0 then begin
      MessageBox(GetDesktopWindow, PChar('Включен сервис "Синхронизация", но программа НЕ АКТИВИРОВАНА.'+ #10#13 +
      #10#13 + 'Активируйте лицензионный ключ.'+
      #10#13 + 'Сервис будет временно ОТКЛЮЧЕН!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
      Terminate;
      Exit;
    end;

    if isProKey = False then begin
      MessageBox(GetDesktopWindow, PChar('Включен сервис "Синхронизация", но версия программы БАЗОВАЯ.'+ #10#13 +
      'Базовая версия не имеет доступа к синхронизации.' + #10#13 +
      'Для работы синхронизации смените тариф на PRO.' + #10#13 + 'Сервис будет временно ОТКЛЮЧЕН!'), PChar('Внимание'), MB_OK + MB_ICONSTOP);
      Terminate;
      Exit;
    end;

    if ProcessingNow = false then begin
      try
        db := MainDM.dbMainSyncData;
        Connected := unDBSupport.ConnectToFB(db, '');

        if not Connected then begin
          WriteLog('Невозможно подключиться к базе данных!');
          Exit;
        end;

        ProcessingNow := True;

        // тут же выставляю переменную, что это сессия для репликации
        MainDM.spSyncLogOut.SelectSQL.Text := 'SELECT RDB$SET_CONTEXT (''USER_SESSION'', ''REPLICAT'', ''1'') '+
          'FROM RDB$DATABASE';
        MainDM.spSyncLogOut.Open;
        if MainDM.spSyncLogOut.Transaction.InTransaction then
          MainDM.spSyncLogOut.Transaction.Commit;

        if FirstStart = true then begin
          DeleteOlds;
          ImportWithErrs;
        end;

        DoImport(FirstStart);
        DoExport;

        FirstStart := false;

      finally
        DisconnectFromFB(db);
        ProcessingNow := false;
      end;
    end;

    if TerminateImmediate = true then
      Break;

    FSleepEvent.WaitFor(SyncInterval); // Ждем N минут
  end;
end;

procedure TSyncDataThread.WriteLog;
var formattedDateTime : string;
begin
  DateTimeToString(formattedDateTime, 'c', Now);

  Append(SyncLogFile);
  WriteLn(SyncLogFile, formattedDateTime + ' : ' + str);
end;

end.
