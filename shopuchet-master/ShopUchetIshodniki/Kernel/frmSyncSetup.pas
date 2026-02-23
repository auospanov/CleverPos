unit frmSyncSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxCheckBox, cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.ExtCtrls,
  Vcl.StdCtrls, dxmdaset, System.Actions, Vcl.ActnList, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, Vcl.Buttons, cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons,
  FIB, System.UITypes, FileCtrl, cxDropDownEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCalc, Registry;

type
  TSyncSetupForm = class(TDlgForm)
    alChild: TActionList;
    aCompIns: TAction;
    aCompDel: TAction;
    aCreateDatabases: TAction;
    mdComps: TdxMemData;
    mdCompsName: TStringField;
    dsRead: TDataSource;
    btBack: TcxButton;
    pnlSecond: TPanel;
    pnlFirst: TPanel;
    bedtFileName: TcxButtonEdit;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    tvMainColumn1: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    Label1: TLabel;
    lb9: TLabel;
    pn3: TPanel;
    btnIns: TBitBtn;
    btnDel: TBitBtn;
    shp15: TShape;
    shp18: TShape;
    cbInterval: TcxComboBox;
    btnSyncFileName: TcxButtonEdit;
    lb4: TLabel;
    shp7: TShape;
    shp8: TShape;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    mdCompsid: TIntegerField;
    procedure aCompInsExecute(Sender: TObject);
    procedure aCompDelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bedtFileNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btBackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSyncFileNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cbIntervalPropertiesChange(Sender: TObject);
  private
    FGlyph : TBitMap;
    FSyncEnabled : Boolean;
    FAddNewComp : Boolean;
    FSyncIdTmp : String;
    function SyncRoutine : Boolean;
  public
    property SyncEnabled : Boolean read FSyncEnabled write FSyncEnabled;
    property AddNewComp : Boolean read FAddNewComp write FAddNewComp;
    property SyncId : String read FSyncIdTmp write FSyncIdTmp;
  end;

var
  SyncSetupForm: TSyncSetupForm;

implementation

uses
  unInitApp, dmMain, unCommonFunc;

{$R *.dfm}

procedure TSyncSetupForm.aCompDelExecute(Sender: TObject);
begin
  mdComps.Delete;
  aCompDel.Enabled := mdComps.RecordCount > 0;
  aCreateDatabases.Enabled := mdComps.RecordCount > 1;
end;

procedure TSyncSetupForm.aCompInsExecute(Sender: TObject);
var s : string;
begin
  if InputQuery('Компьютер', 'Введите название компьютера', s) then begin
    if not mdComps.Active then
      mdComps.Open;
    mdComps.Insert;
    mdComps.FieldByName('NAME').AsString := s;
    mdComps.Refresh;
    aCompDel.Enabled := mdComps.RecordCount > 0;
    aCreateDatabases.Enabled := mdComps.RecordCount > 1;
  end;
end;

procedure TSyncSetupForm.bedtFileNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  sDir : String;
begin
  if FileCtrl.SelectDirectory('Выберите папку', '', sDir) then
    bedtFileName.Text := IncludeTrailingPathDelimiter(sDir);
end;

procedure TSyncSetupForm.btBackClick(Sender: TObject);
begin
  IF pnlSecond.Visible THEN BEGIN
    btBack.Enabled := False;
    pnlSecond.Visible := False;
    pnlFirst.Visible  := True;
    FGlyph := btnOk.Glyph;
    btnOk.Glyph     := nil;
    btnOk.Caption   := 'Далее >';
  END
end;

procedure TSyncSetupForm.btnSyncFileNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  sDir : String;
begin
  if FileCtrl.SelectDirectory('Выберите папку', '', sDir) then
    btnSyncFileName.Text := IncludeTrailingPathDelimiter(sDir);
end;

procedure TSyncSetupForm.cbIntervalPropertiesChange(Sender: TObject);
begin
  bedtFileName.ModifiedAfterEnter := True;
end;

procedure TSyncSetupForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var curBasePath, path, basePath, curCompId : string;
  Reg: TRegistry;
begin
  inherited;

  IF ModalResult = mrOk THEN BEGIN
    // если активна первая панель
    if pnlFirst.Visible then begin
      if (mdComps.RecordCount < 2) and (bedtFileName.Text <> '') and (AddNewComp = false) then begin
        MessageDlg('Недостаточное количество компьютеров для синхронизации!', mtError, [mbOk], 0);
        btnIns.SetFocus;
        CanClose := False;
        Exit;
      end;

      if (mdComps.RecordCount >= 2) and (bedtFileName.Text = '') then begin
        MessageDlg('Папка для сохранения баз данных не указана!', mtError, [mbOk], 0);
        bedtFileName.SetFocus;
        CanClose := False;
        Exit;
      end;

      if not System.SysUtils.DirectoryExists(bedtFileName.Text) then begin
        MessageDlg('Папка для сохранения баз данных не существует!', mtError, [mbOk], 0);
        bedtFileName.SetFocus;
        CanClose := False;
        Exit;
      end;

      if AddNewComp then
        CanClose := SyncRoutine
      else begin
        CanClose         := False;
        pnlFirst.Visible := False;
        pnlSecond.Visible := True;
        btnOk.Glyph      := FGlyph;
        btnOk.Caption    := 'Сохранить';
        btBack.Enabled   := True;
      end;
    end
    // если активна вторая панель
    else begin
      if btnSyncFileName.Text = '' then begin
        MessageDlg('Не указана папка для обмена файлами!', mtError, [mbOk], 0);
        btnSyncFileName.SetFocus;
        CanClose := False;
        Exit;
      end;

      //решил сохранять теперь не в INI, а в реестр, с INI-файла все время куда-то пропадает
      //SaveSettingsIni('Sync', 'SyncFolder', null, btnSyncFileName.Text);
      //SaveSettingsIni('Sync', 'SyncInterval', cbInterval.ItemIndex, '');
      try
        Reg := TRegistry.Create;
        try
          with Reg do begin
            RootKey := RegSetupRoot;
            LazyWrite := False;  {Сохраняем ключи до закрытия}
            if OpenKey(RegSetupKey, True) then
              try
                WriteString('SyncFolder', btnSyncFileName.Text);
                WriteInteger('SyncInterval', cbInterval.ItemIndex);
              finally
                CloseKey;
              end;
          end;
        finally
          Reg.Free;
        end;
      except
        on E: Exception do
          MessageDlg(E.Message, mtError, [mbOk], 0);
      end;

      IF (SyncEnabled) and (AddNewComp = False) THEN BEGIN
        SyncFolder := btnSyncFileName.Text;
        case cbInterval.ItemIndex of
          0 : SyncInterval := 300000;  // 5 min
          1 : SyncInterval := 600000;  // 10 min
          2 : SyncInterval := 900000;  // 15 min
          3 : SyncInterval := 1800000; // 30 min
          4 : SyncInterval := 3600000; // 60 min
          5 : SyncInterval := 7200000; // 2 hour
          6 : SyncInterval := 14400000; // 4 hour
          7 : SyncInterval := 28800000; // 8 hour
        end;
      END
      ELSE BEGIN
        CanClose := SyncRoutine;
      END;
    end;
  END;
end;

procedure TSyncSetupForm.FormShow(Sender: TObject);
var MyGUID : TGUID;
begin
  inherited;

  if (FSyncEnabled) and (FAddNewComp = False) then begin
    pnlFirst.Visible  := False;
    pnlSecond.Visible := True;
    btnOk.Caption     := 'Сохранить';
    btnSyncFileName.Text := SyncFolder;
    case SyncInterval of
      300000 : cbInterval.ItemIndex := 0;  // 5 min
      600000 : cbInterval.ItemIndex := 1;  // 10 min
      900000 : cbInterval.ItemIndex := 2;  // 15 min
      1800000 : cbInterval.ItemIndex := 3; // 30 min
      3600000 : cbInterval.ItemIndex := 4; // 60 min
      7200000 : cbInterval.ItemIndex := 5; // 2 hour
      14400000 : cbInterval.ItemIndex := 6; // 4 hour
      28800000 : cbInterval.ItemIndex := 7; // 8 hour
    end;
  end else begin
    if FAddNewComp = False then begin
      CreateGUID(MyGUID);
      FSyncIdTmp := GUIDToString(MyGUID);
      FGlyph := btnOk.Glyph;
      btnOk.Glyph := nil;
    end
    else begin
      btnOk.Caption := 'Сохранить';
      btBack.Visible := False;
    end;
  end;
end;

function TSyncSetupForm.SyncRoutine: Boolean;
var curBasePath, path, basePath, curCompId : string;
begin
  TRY
    Result := true;

    Screen.Cursor := crHourGlass;
    // заполняю таблицу со списком компьютеров SYNC_COMPS, а потом размножу базу с уже заполненной таблицей
    // перед началом почищу табличку
    with MainDm.spReadUniversal do begin
      Transaction := MainDm.tranMainWrite;

      if AddNewComp = false then begin
        SelectSQL.Text := 'DELETE FROM SYNC_COMPS';
        if not OpenSp(MainDm.spReadUniversal, False) then Exit;
        if Transaction.InTransaction then
          Transaction.CommitRetaining;
        Close;
      end;

      try
        SelectSQL.Text := 'SELECT SYNC_COMPS, NAME FROM SYNC_COMPS';
        InsertSQL.Text := 'INSERT INTO SYNC_COMPS (SYNC_COMPS, NAME) '#13#10 +
          'VALUES (GEN_ID(GEN_SYNC_COMPS, 1), :Name)' +
          'RETURNING SYNC_COMPS';

        mdComps.First;
        Open;
        while not mdComps.Eof do begin
          try
            Insert;
            FieldByName('Name').AsString := mdComps.FieldByName('name').AsString;
            Post;

            if Transaction.InTransaction then
              Transaction.CommitRetaining;

            mdComps.Edit;
            mdComps.FieldByName('Id').AsInteger := FieldByName('Sync_comps').AsInteger;
            mdComps.Next;
          except
            on E: EFIBError do begin
              if Transaction.InTransaction then
                Transaction.CommitRetaining;
              MessageDlg(IntToStr(E.SQLCode) + ' ' + E.Message + #13#10'(occured in unCommonFunc.OpenSP)', mtError, [mbOk], 0);
              Result := False;
              Exit;
            end;
            on E: Exception do begin
              if Transaction.InTransaction then
                Transaction.CommitRetaining;
              MessageDlg(E.Message + #13#10'(occured in unCommonFunc.OpenSP)', mtError, [mbOk], 0);
              Result := False;
              Exit;
            end;
          end;
        end;
      finally
        Close;
      end;
    end;

    // размножаю базу
    MainDm.spReadUniversal.Database    := MainDm.dbMainSyncSetup;
    MainDm.spReadUniversal.Transaction := MainDm.tranMainSyncSetupWrite;
    MainDm.spUniversal.Database        := MainDm.dbMainSyncSetup;
    MainDm.spUniversal.Transaction     := MainDm.tranMainSyncSetupWrite;

    mdComps.First;
    with mdComps do begin
      curBasePath := ExtractFilePath(Application.exename) + DataBaseName;
      while not eof do begin
        curCompId   := mdComps.FieldByName('id').AsString;

        path := bedtFileName.Text + curCompId + '-' + mdComps.FieldByName('name').AsString;
        if not Createdir(path) then begin
          MessageDlg('Не удалось создать папку для ' + mdComps.FieldByName('name').AsString, mtError, [mbOk], 0);
          Result := False;
          Exit;
        end;

        basePath := path + '\' + DataBaseName;
        CopyFile(PChar(curBasePath), PChar(basePath), false);
        MainDm.dbMainSyncSetup.DBName := basePath;
        MainDm.dbMainSyncSetup.ConnectParams.Username := 'sysdba';//UserName;
        MainDm.dbMainSyncSetup.ConnectParams.Password := 'masterkey';//Password;
        with MainDm.dbMainSyncSetup do begin
          try
            Open;
          except
            on E: EFIBError do begin
              case E.SQLCode of
                -902: MessageDlg(E.Message + #13#10'В доступе отказано', mtInformation, [mbOk], 0);
                        {Unsuccessfull execution caused by an unavailable resource. Unavailable database}
                -904: MessageDlg('Недоступная база данных'#13#10 +
                        '(возможно, сервер FireBird остановлен).'#13#10 +
                        'В доступе отказано', mtError, [mbOk], 0);
              else
                MessageDlg('Ошибка № ' + IntToStr(E.SQLCode) + ':'#13#10 +
                           'В доступе отказано', mtError, [mbOk], 0);
              end;
              Result := False;
              Exit;
            end;
            on E: Exception do begin
              MessageDlg('Ошибка ' + E.Message + #13#10'В доступе отказано', mtError, [mbOk], 0);
              Result := False;
              Exit;
            end;
          end;

          try
            //запускаю создание триггеров
            with MainDm.spUniversal do begin
              StoredProcName := 'LOG_INIT';
              if not ExecSP(MainDm.spUniversal) then begin
                Result := False;
                Exit;
              end;
            end;

            with MainDm.spReadUniversal do begin
              // обновляю ID генераторов
              SelectSQL.Text := 'EXECUTE BLOCK AS DECLARE VARIABLE STR VARCHAR(1000); DECLARE VARIABLE SS BIGINT; '#13#10 +
                                                 'BEGIN '#13#10 +
                                                 '   SS = ' + curCompId + ' * 1000000000;'#13#10 +
                                                 '   FOR SELECT ''SET GENERATOR ''||TRIM(RDB$GENERATOR_NAME)||'' TO ''||:SS '#13#10+
                                                 '         FROM RDB$GENERATORS '#13#10+
                                                 '        WHERE NOT RDB$GENERATOR_NAME CONTAINING ''$'' '#13#10+
                                                 '          AND RDB$GENERATOR_NAME NOT IN (''GEN_ARTICUL'', ''GEN_BARCODE'', ''GEN_BARCODE_SCALE'', ''GEN_P_REP_PRICE_LIST_TABLE'', ''GEN_P_REP_PROFIT_TABLE'', ''GEN_P_REP_TOVAR_MOVE_TABLE'', ''GEN_P_REP_TREE'', ''GEN_P_REP_ZAKAZ_NA_REAL'', ''GEN_SYNC_COMPS'') '#13#10+
                                                 '         INTO :STR '#13#10+
                                                 '   DO '#13#10+
                                                 '     EXECUTE STATEMENT STR; '#13#10+
                                                 '   SS = ' + curCompId + ' * 300000;'#13#10 +
                                                 '   FOR SELECT ''SET GENERATOR ''||TRIM(RDB$GENERATOR_NAME)||'' TO ''||:SS '#13#10+
                                                 '         FROM RDB$GENERATORS '#13#10+
                                                 '        WHERE NOT RDB$GENERATOR_NAME CONTAINING ''$'' '#13#10+
                                                 '          AND RDB$GENERATOR_NAME IN (''GEN_ARTICUL'', ''GEN_BARCODE'') '#13#10+
                                                 '         INTO :STR '#13#10+
                                                 '   DO '#13#10+
                                                 '     EXECUTE STATEMENT STR; '#13#10+
                                                 '   SS = ' + curCompId + ' * 3000;'#13#10 +
                                                 '   FOR SELECT ''SET GENERATOR ''||TRIM(RDB$GENERATOR_NAME)||'' TO ''||:SS '#13#10+
                                                 '         FROM RDB$GENERATORS '#13#10+
                                                 '        WHERE NOT RDB$GENERATOR_NAME CONTAINING ''$'' '#13#10+
                                                 '          AND RDB$GENERATOR_NAME IN (''GEN_BARCODE_SCALE'') '#13#10+
                                                 '         INTO :STR '#13#10+
                                                 '   DO '#13#10+
                                                 '     EXECUTE STATEMENT STR; '#13#10+
                                                 ' END';
              OpenSp(MainDm.spReadUniversal, False);
              Close;

              //обновляю ID текущего компа в SYSTEM_SETUP
              SelectSQL.Text := 'UPDATE SYSTEM_SETUP SET S_VALUE = '+curCompId+' WHERE (SYSTEM_SETUP = 5)';
              OpenSp(MainDm.spReadUniversal, False);
              if Transaction.InTransaction then
                Transaction.CommitRetaining;
              Close;

              //обновляю SyncID в SYSTEM_SETUP
              SelectSQL.Text := 'UPDATE SYSTEM_SETUP SET STR_VALUE = '''+FSyncIdTmp+''' WHERE (SYSTEM_SETUP = 6)';
              OpenSp(MainDm.spReadUniversal, False);
              if Transaction.InTransaction then
                Transaction.CommitRetaining;
              Close;
            end;
          finally
            MainDm.dbMainSyncSetup.Close;
          end;
        end;

        Next;
      end;
    end;
  FINALLY
    Screen.Cursor := crDefault;
    MainDm.spReadUniversal.Database    := MainDm.dbMain;
    MainDm.spReadUniversal.Transaction := MainDm.tranMainRead;
    MainDm.spUniversal.Database        := MainDm.dbMain;
    MainDm.spUniversal.Transaction     := MainDm.tranMainRead;
  END;
end;

end.
