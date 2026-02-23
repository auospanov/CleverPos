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
  cxClasses, Vcl.Menus, cxButtons;

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
    lstUpdateDb: TValueListEditor;
    spUpdateDb: TpFIBDataSet;
    tranMainWrite: TpFIBTransaction;
    spUpdateData: TpFIBDataSet;
    lstUpdateData: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  FFileName, FFileZipName : string;
  i, J : integer;
begin
  Timer.Enabled := False;
  btnOk.Enabled := False;
  mLog.Lines.Clear;

  // В САМОМ НАЧАЛЕ ПРОВЕРЮ, ЕСТЬ ЛИ ПОДКЛЮЧЕНИЯ К БАЗЕ, ЕСЛИ ЕСТЬ, ТО НИХУЯ ОБНОВЛЕНИЯ НЕ ЗАПУСКАЮ
  //в общем надо проверять количество коннектов, а это делается только в базе, поэтому надо сначала сконнектится на этот период, и потом расконнектится тут же
  //другого пути не нашел
  if ConnectToFB(MainDM.dbMain, '') then begin
    if GetConnectionsCount > 1 then begin
      mLog.Lines.Add('Невозможно запустить обновление!');
      mLog.Lines.Add('К базе данных подключены другие пользователи. Попросите их отключиться от БД и перезапустите программу.');
      DisconnectFromFB(MainDM.dbMain);
      Exit;
    end;
    DisconnectFromFB(MainDM.dbMain);
    Sleep(200);   //дам время на отключение
  end;

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
      FFileZipName := BackupDir;//ExtractFilePath(Application.exename) + 'Backup';
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
  mLog.Lines.Add('Процесс создания скрипта обновления до последней версии ...');

  if FLastVers < 11023 then
    lstUpdateDb.FindRow('11023' + '0' , I)
  else
    lstUpdateDb.FindRow(IntToStr(FLastVers+1) + '0' , I);

  J := 1;
  if I <> -1 then begin
    try
      SuccessUpd := True;
      ProgressBar.Max := lstUpdateDb.RowCount;
      ProgressBar.Position := 0;
      while i <= lstUpdateDb.RowCount-1 do begin
        spUpdateDb.SelectSQL.Text := spUpdateDb.SelectSQL.Text + lstUpdateDb.Cells[1, i];

        if Pos('--END_EXECUTE_BLOCK', lstUpdateDb.Cells[1, i]) > 0 then begin
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
                mLog.Lines.Add('Ошибка. Код: ' + IntToStr(E.SQLCode) + '. Детали: ' + E.Message);
              end;
              on E: Exception do begin
                if Transaction.InTransaction then
                  Transaction.Rollback;
                mLog.Lines.Add('Ошибка: ' + E.Message);
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

        //mLog.Text := spUpdateDb.SelectSQL.Text;
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
              //mLog.Text := spUpdateDb.SelectSQL.Text;
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

    if I <> -1 then begin
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

  Screen.Cursor := crDefault;

  if SuccessUpd = False then begin
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО НЕУСПЕШНО --------');
    btnCancel.Enabled := True;
  end else begin
    mLog.Lines.Add('------- ОБНОВЛЕНИЕ ЗАВЕРШЕНО УСПЕШНО --------');
    ProgressBar.Position := ProgressBar.Max;

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

end.
