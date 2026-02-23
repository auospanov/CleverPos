unit frmSendSms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxContainer,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxCurrencyEdit,
  cxCheckBox, cxTextEdit, cxMemo, ExtCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, cxPC, FIBDatabase, pFIBDatabase, dxmdaset,
  FIBDataSet, pFIBDataSet, cxButtons, StdCtrls, ActnList, AppEvnts, Buttons,
  unCommonFunc, smsc_api, Types, DateUtils, frmDBEdit, IniFiles, Math,
  cxProgressBar, StrUtils, System.UITypes, dxBarBuiltInMenu, cxNavigator,
  System.Actions, Winapi.ShellAPI, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TSendSmsForm = class(TDlgForm)
    actlstChild: TActionList;
    aDel: TAction;
    aInsLike: TAction;
    aHelp: TAction;
    aInsField: TAction;
    aGetBalance: TAction;
    aSendNow: TAction;
    aSendSchedule: TAction;
    aUpdSend: TAction;
    aDelAll: TAction;
    pn1: TPanel;
    lbBalance: TLabel;
    btnGetBalance: TcxButton;
    spRead: TpFIBDataSet;
    spReadName: TStringField;
    spReadPhone: TStringField;
    intgrfldReadSmsId: TIntegerField;
    spReadStatus: TStringField;
    spReadSmsText: TStringField;
    dsRead: TDataSource;
    mdClient: TdxMemData;
    tranRead: TpFIBTransaction;
    pcPageControl: TcxPageControl;
    ts1: TcxTabSheet;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    pn2: TPanel;
    shp1: TShape;
    shp3: TShape;
    shpNote: TShape;
    lbNote: TLabel;
    shpNote1: TShape;
    lbl2: TLabel;
    shp4: TShape;
    lb1: TLabel;
    shp2: TShape;
    lbDesc: TLabel;
    mText: TcxMemo;
    cbTranslit: TcxCheckBox;
    edSymbols: TcxCurrencyEdit;
    edParts: TcxCurrencyEdit;
    btnInsField: TcxButton;
    tsClients: TcxTabSheet;
    pn3: TPanel;
    gr2: TcxGrid;
    tvClient: TcxGridDBTableView;
    clmClientRecId: TcxGridDBColumn;
    clmClientg_client: TcxGridDBColumn;
    clmClientname: TcxGridDBColumn;
    clmClientphone: TcxGridDBColumn;
    clmClienttext: TcxGridDBColumn;
    clmClientstatus: TcxGridDBColumn;
    lvClient: TcxGridLevel;
    aIns: TAction;
    aRefresh: TAction;
    pn6: TPanel;
    pbMain: TcxProgressBar;
    pn5: TPanel;
    btnSendNow: TBitBtn;
    btnUpdChd: TBitBtn;
    btnUpdSend: TBitBtn;
    btnInsLike: TBitBtn;
    btnDelChd: TBitBtn;
    btnDelAll: TBitBtn;
    btnUpdSend1: TBitBtn;
    aRefreshStatusAll: TAction;
    aRefreshStatus: TAction;
    pm1: TPopupMenu;
    SMS1: TMenuItem;
    clmClientColumn1: TcxGridDBColumn;
    lb42: TLabel;
    lb44: TLabel;
    spReadID: TBCDField;
    mdClientName: TStringField;
    mdClientPhone: TStringField;
    mdClientSmsId: TIntegerField;
    mdClientStatus: TIntegerField;
    mdClientSmsText: TStringField;
    mdClientID: TBCDField;
    procedure aGetBalanceExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aInsFieldExecute(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aDelAllExecute(Sender: TObject);
    procedure aSendScheduleExecute(Sender: TObject);
    procedure aSendNowExecute(Sender: TObject);
    procedure aUpdSendExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mTextPropertiesChange(Sender: TObject);
    procedure cbTranslitPropertiesChange(Sender: TObject);
    procedure aRefreshStatusAllExecute(Sender: TObject);
    procedure aRefreshStatusExecute(Sender: TObject);
    procedure lb44Click(Sender: TObject);
    procedure lb44MouseLeave(Sender: TObject);
    procedure lb44MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure mdClientCalcFields(DataSet: TDataSet);
  private
    FCyrText : String;
    FSms : SMSC;
    procedure SmsSend(time : string = '');
  public
    { Public declarations }
  end;

var
  SendSmsForm: TSendSmsForm;

implementation

uses
  frmSmsRecips, frmSendTimeAndDate, frmUpdSmsNotifyHistory;

{$R *.dfm}

procedure TSendSmsForm.aDelAllExecute(Sender: TObject);
begin
  mdClient.Close;
  aRefresh.Execute;
end;

procedure TSendSmsForm.aDelExecute(Sender: TObject);
begin
  mdClient.Delete;
  if mdClient.RecordCount = 0 then
    aRefresh.Execute;
end;

procedure TSendSmsForm.aGetBalanceExecute(Sender: TObject);
var balance : string;
begin
  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageDlg('Проверка баланса невозможна, т.к. не заполнен логин/пароль' +
      'к сервису SMSC.RU. Задайте логин/пароль в настройках программы!', mtWarning, [mbOK], 0);
    Exit;
  end;

  balance := Fsms.get_balance;
  if balance <> '' then
    lbBalance.Caption := 'Баланс ' + balance;
end;

procedure TSendSmsForm.aInsExecute(Sender: TObject);
var SmsRecipsForm : TSmsRecipsForm;
  sqlStr : string;
begin
  SmsRecipsForm := TSmsRecipsForm.Create(Self);
  with SmsRecipsForm do begin
    if ShowModal = mrOk then begin
      sqlStr := 'SELECT G.G_CLIENT ID, ' +
                 'G.NAME, ' +
                 'G.PHONE, ' +
                 '0 SmsId, ' +
                 'Cast('''' as Varchar(200)) Status ' +
                'FROM G_CLIENT G ' +
              'WHERE IS_CATEGORY = 0 ' +
              'AND IS_SUPPLIER = 0 ';

      if cbChoice.ItemIndex = 0 then
        sqlStr := sqlStr + 'AND NOTIFY_SKIDKA = 1 AND CHAR_LENGTH(G.phone) > 0'

      else if cbChoice.ItemIndex = 1 then begin
        sqlStr := sqlStr + 'AND NOTIFY_DR = 1' +
                  'AND EXTRACT(DAY FROM G.dt) = EXTRACT(DAY FROM CURRENT_DATE) ' +
                  'AND EXTRACT(MONTH FROM G.dt) = EXTRACT(MONTH FROM CURRENT_DATE) ' +
                  'AND CHAR_LENGTH(G.phone) > 0 ';

      end else begin
        if ClientCatArr <> '' then
          sqlStr := sqlStr + 'AND ''' + ClientCatArr + ''' CONTAINING ''~''||G.G_CLIENT_PARENT||''~'' ';

        if ClientArr <> '' then
          sqlStr := sqlStr + 'AND ''' + ClientArr + ''' CONTAINING ''~''||G.G_CLIENT||''~'' ';
      end;

      if spRead.active then
        spRead.Close;

      // если записей еще нет, т.е. заполняется в первый раз, то обычный селект
      if mdClient.RecordCount = 0 then
        spRead.SelectSQL.Text := sqlStr
      // если же заполняется второй раз и далее, то добавляю записи через UNION
      // перед этим удаляю "order by"
      else begin
        spRead.SelectSQL.Text := Copy(spRead.SelectSQL.Text, 1, Pos('order', spRead.SelectSQL.Text)-2);
        spRead.SelectSQL.Text := spRead.SelectSQL.Text + 'UNION ALL ' + sqlStr;
      end;

      spRead.SelectSQL.Text := spRead.SelectSQL.Text + ' order by 2, 3';

      OpenSP(spRead, False);
      mdClient.CopyFromDataSet(spRead);
      mdClient.Open;
      aRefresh.Execute;
    end;
  end;
end;

procedure TSendSmsForm.aInsFieldExecute(Sender: TObject);
var str : string;
begin
  if mText.SelStart = 0 then
    str := '@name@'
  else
    str := ' @name@ ';

  mText.Text := Copy(mText.Text, 0, mText.SelStart) + str + Copy(mText.Text, mText.SelStart + 1);
end;

procedure TSendSmsForm.aRefreshExecute(Sender: TObject);
begin
  aDel.Enabled := mdClient.RecordCount > 0;
  aDelAll.Enabled := mdClient.RecordCount > 0;
  aSendNow.Enabled := mdClient.RecordCount > 0;
  aSendSchedule.Enabled := mdClient.RecordCount > 0;
  aUpdSend.Enabled := mdClient.RecordCount > 0;
  aRefreshStatusAll.Enabled := mdClient.RecordCount > 0;
  aRefreshStatus.Enabled := mdClient.RecordCount > 0;
end;

procedure TSendSmsForm.aRefreshStatusAllExecute(Sender: TObject);
var sms: SMSC;
    phones, id, str, str1 : string;
    i : integer;
begin
  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageDlg('Обновить статусы SMS невозможно, т.к. не заполнен логин/пароль' +
      'к сервису SMSC.RU. Задайте логин/пароль в настройках программы!', mtWarning, [mbOK], 0);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    sms := SMSC.Create;
    sms.SMSC_LOGIN := SmsLogin;
    sms.SMSC_PASSWORD := SmsPassword;
    with mdClient do begin
      First;
      while not EOF do begin
        phones := phones + FieldByName('PHONE').AsString + ',';
        id     := id + FieldByName('smsid').AsString + ',';
        Next;
        Repaint;
      end;

      sms.get_status(id, phones);
      for i := 0 to high(sms.D2Res) do begin
        Locate('SMSID', StrToInt(sms.D2Res[I][3]), []);
        str1 := FieldByName('SmsText').AsString;
        Edit;
        case StrToInt(sms.D2Res[I][0]) of
          -3:	str := 'Сообщение не найдено';
          -1:	str := 'Ожидает отправки';
          0:	str := 'Передано оператору';
          1:	str := 'Доставлено';
          2:	str := 'Прочитано';
          3:	str := 'Просрочено';
          20:	str := 'Невозможно доставить';
          22:	str := 'Неверный номер';
          23:	str := 'Запрещено (скорее всего нужно заключить договор с SMSC.RU. Подробнее в личном кабинете)';
          24:	str := 'Недостаточно средств';
          25:	str := 'Недоступный номер';
        end;
        FieldByName('STATUS').AsString := str;
        FieldByName('SmsText').AsString := str1;
      end;

      //ShowMessage('Обновление статусов закончено!');
    end;
  finally
    sms.Destroy;
    Screen.Cursor := crDefault;
  end;
end;

procedure TSendSmsForm.aRefreshStatusExecute(Sender: TObject);
var sms: SMSC;
    phones, id, str, str1 : string;
    i : integer;
begin
  if tvClient.Controller.SelectedRowCount = 0 then begin
    MessageDlg('Выберите запись!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageDlg('Обновить статусы SMS невозможно, т.к. не заполнен логин/пароль' +
      'к сервису SMSC.RU. Задайте логин/пароль в настройках программы!', mtWarning, [mbOK], 0);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    sms := SMSC.Create;
    sms.SMSC_LOGIN := SmsLogin;
    sms.SMSC_PASSWORD := SmsPassword;
    with mdClient do begin
      phones := FieldByName('PHONE').AsString + ',';
      id     := FieldByName('smsid').AsString + ',';

      sms.get_status(id, phones);
      for i := 0 to high(sms.D2Res) do begin
        Edit;
        str1 := FieldByName('SmsText').AsString;
        case StrToInt(sms.D2Res[I][0]) of
          -3:	str := 'Сообщение не найдено';
          -1:	str := 'Ожидает отправки';
          0:	str := 'Передано оператору';
          1:	str := 'Доставлено';
          2:	str := 'Прочитано';
          3:	str := 'Просрочено';
          20:	str := 'Невозможно доставить';
          22:	str := 'Неверный номер';
          23:	str := 'Запрещено (скорее всего нужно заключить договор с SMSC.RU. Подробнее в личном кабинете)';
          24:	str := 'Недостаточно средств';
          25:	str := 'Недоступный номер';
        end;
        FieldByName('STATUS').AsString := str;
        FieldByName('SmsText').AsString := str1;  //иначе теряется текст, наверно из-за CalcFields
      end;
    end;
  finally
    sms.Destroy;
    Screen.Cursor := crDefault;
  end;
end;

procedure TSendSmsForm.aSendNowExecute(Sender: TObject);
begin
  SmsSend;
end;

procedure TSendSmsForm.aSendScheduleExecute(Sender: TObject);
var SendTimeAndDateForm: TSendTimeAndDateForm;
  myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;
  time : string;
begin
  SendTimeAndDateForm := TSendTimeAndDateForm.Create(Self);
  with SendTimeAndDateForm do begin
    if ShowModal = mrOk then begin
      DecodeDateTime(edDate.Date + teTime.Time, myYear, myMonth, myDay,
                     myHour, myMin, mySec, myMilli);
      time := Format('%.*d',[2, myDay]) + Format('%.*d',[2, myMonth]) + Copy(IntToStr(myYear), 3, 2) +
                     Format('%.*d',[2, myHour]) + Format('%.*d',[2, myMin]);

      SmsSend(time);
    end;
  end;
end;

procedure TSendSmsForm.aUpdSendExecute(Sender: TObject);
var UpdSmsNotifyHistoryForm : TUpdSmsNotifyHistoryForm;
  Errmsg, bal : string;
  smsId, Errcode : integer;
begin
  if tvClient.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('Выберите запись для изменения!', mtWarning, [mbOK], 0);
    Exit;
  end;

  UpdSmsNotifyHistoryForm := TUpdSmsNotifyHistoryForm.Create(Self);
  with UpdSmsNotifyHistoryForm do begin
    Mode := 1;
    OpenMode := omUpdate;
    //убираю первую 8ку, если телефон в формате 8707...
    if (Length(mdClient.FieldByName('phone').AsString) = 11) and
    (Copy(mdClient.FieldByName('phone').AsString, 1, 1) = '8') then
      edPhone.Text := '7' + Copy(mdClient.FieldByName('phone').AsString, 2)
    else
      edPhone.Text := mdClient.FieldByName('phone').AsString;

    mSmsNotifyText.Text := mdClient.FieldByName('smsText').AsString;
    if ShowModal = mrOk then begin
      smsId := send_sms_one(edPhone.Text, mSmsNotifyText.Text, 0, SendTime, bal, Errcode, Errmsg);

      if errcode = -999 then begin
        MessageDlg(Errmsg, mtError, [mbOK], 0);
        Exit;
      end;

      if Errcode = 0 then
        errmsg := 'Передано оператору';

      mdClient.Edit;
      mdClient.FieldByName('phone').AsString := edPhone.Text;
      mdClient.FieldByName('smsid').AsInteger := smsId;
      mdClient.FieldByName('status').AsString := errmsg;
      mdClient.FieldByName('smsText').AsString := mSmsNotifyText.Text;

      if smsId > 0 then
        lbBalance.caption := 'Баланс ' + Bal;
    end;
  end;
end;

procedure TSendSmsForm.cbTranslitPropertiesChange(Sender: TObject);
begin
  // транслит работает только в одну сторону - в литиницу, потому что обратно по-любасу получиться
  // абракадабра. Потому тут буду запоминать старый русский текст, будет конечно немного коряво
  // если вдруг окно открыли, а текст уже на латинице
  if cbTranslit.Checked then begin
    FCyrText := mText.Text;
    mText.Text := TranslitRus(mText.Text);
  end else begin
    if FCyrText <> '' then
      mText.Text := FCyrText;
  end;
end;

procedure TSendSmsForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TMemIniFile;
begin
  inherited;
  tvClient.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvClient.name);

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    Ini.WriteString('SendSmsList', 'SmsText', mText.Text);
    Ini.WriteInteger('SendSmsList', 'SmsTranslit', Integer(cbTranslit.Checked));
    Ini.WriteInteger('SendSmsList', 'Height', ClientHeight);
    Ini.WriteInteger('SendSmsList', 'Width', ClientWidth);
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;

  FreeAndNil(FSms);
end;

procedure TSendSmsForm.FormCreate(Sender: TObject);
begin
  inherited;
  FSms := SMSC.Create;
  FSms.SMSC_LOGIN := SmsLogin;
  FSms.SMSC_PASSWORD := SmsPassword;
end;

procedure TSendSmsForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile;
  onChange : TNotifyEvent;
  balance : string;
  sms : SMSC;
begin
  pcPageControl.ActivePage := ts1;
  inherited;
  aRefresh.Execute;
  tvClient.RestoreFromIniFile('Settings_grid.ini', False, False, [], Self.Name + '-' + tvClient.Name);

  Ini := TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    mText.Text := Ini.ReadString('SendSmsList', 'SmsText', ', салон "Beauty" объявляет о скидке 15% на все!');
    Height := Ini.ReadInteger('SendSmsList', 'Height', Constraints.MinHeight);
    Width := Ini.ReadInteger('SendSmsList', 'Width', Constraints.MinWidth);

    onChange := cbTranslit.Properties.OnChange;
    cbTranslit.Properties.OnChange := nil;
    cbTranslit.Checked := Ini.ReadInteger('SendSmsList', 'SmsTranslit', 0) = 1;
    cbTranslit.Properties.OnChange := onChange;
  finally
    Ini.Free;
  end;

  // проверю баланс, если заполнены логин и пароль
  if (Trim(SmsLogin) <> '') AND (Trim(SmsPassword) <> '') then begin
    sms := SMSC.Create;
    try
      sms.SMSC_LOGIN := SmsLogin;
      sms.SMSC_PASSWORD := SmsPassword;
      balance := sms.get_balance;
      if balance <> '' then begin
        lbBalance.Caption := 'Баланс ' + balance;
        lbBalance.Alignment := taCenter;
      end;
    finally
      FreeAndNil(sms);
    end;
  end;
end;

procedure TSendSmsForm.lb44Click(Sender: TObject);
begin
  ShellExecute(handle,'open','https://smsc.ru/?ppshopuchet', nil, nil, SW_SHOW);
end;

procedure TSendSmsForm.lb44MouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TSendSmsForm.lb44MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TSendSmsForm.mdClientCalcFields(DataSet: TDataSet);
var str : string;
begin
  str := mdClient.FieldByName('name').AsString;

  if cbTranslit.Checked then
    str := TranslitRus(str);

  mdClient.FieldByName('smstext').AsString := StringREPLACE(mText.text, '@name@', str, []);
end;

procedure TSendSmsForm.mTextPropertiesChange(Sender: TObject);
begin
  edSymbols.Value := Length(mText.Text);

  edParts.Value := 1;

  if (HaveCrSymbol(mText.Text)) and (Length(mText.Text) > 70) then
    edParts.Value := Ceil(Length(mText.Text)/67)
  else if not (HaveCrSymbol(mText.Text)) and (Length(mText.Text) > 160) then
    edParts.Value := Ceil(Length(mText.Text)/153);
end;

procedure TSendSmsForm.SmsSend(time: string);
var ret: TStringDynArray;
  ErrorCode, SmsId: integer;
  ErrMsg, str: string;
begin
  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageDlg('Отправка SMS невозможна, т.к. не заполнен логин/пароль ' +
      'к сервису SMSC.RU. Задайте логин/пароль в настройках программы!', mtWarning, [mbOK], 0);
    Exit;
  end;

  {if DebugHook <> 0 then begin
    SetLength(ret, 4);
    ret[0] := '440';
    ret[1] := '1';
    ret[2] := '1';
    ret[3] := '440';
  end;}

  Screen.Cursor := crHourGlass;
  try
    pbMain.Properties.Min := 0;
    pbMain.Properties.Max := mdClient.RecordCount-1;
    pbMain.Position := 0;
    with mdClient do begin
      First;
      while not EOF do begin
        try
          //if DebugHook = 0 then
            ret := FSMS.send_sms(mdClient.FieldByName('phone').AsString,
                                mdClient.FieldByName('SmsText').AsString,
                                0,  //translit,
                                time
                                );

          if ret[0] = '-999' then begin
            MessageDlg('Нет связи с сервисом SMSC.RU. Проверьте интернет-соединение и попробуйте снова!', mtError, [mbOK], 0);
            Exit;
          end;

          SmsId := StrToInt(Ret[0]);
          if StrToInt(ret[1]) > 0 then
            lbBalance.Caption := 'Баланс ' + ret[3]
          else begin
            ErrorCode := StrToInt(ret[1][2]);
            case ErrorCode of
              1 : ErrMsg := 'Ошибка в параметрах.';
              2 : ErrMsg := 'Неверный логин или пароль.';
              3 : ErrMsg := 'Недостаточно средств на Вашем счете.';
              4 : ErrMsg := 'IP-адрес временно заблокирован из-за частых ошибок в запросах. Подробнее.';
              5 : ErrMsg := 'Неверный формат даты.';
              6 : ErrMsg := 'Сообщение запрещено (по тексту или по имени отправителя).';
              7 : ErrMsg := 'Неверный формат номера телефона.';
              8 : ErrMsg := 'Сообщение на указанный номер не может быть доставлено.';
              9 : ErrMsg := 'Отправка более одного одинакового запроса на передачу SMS-сообщения либо более пяти одинаковых запросов на получение стоимости сообщения в течение минуты.';
            end;
          end;
        except
          on E : Exception do begin
            ErrMsg    := 'Ошибка: ' + E.Message;
            Exit;
          end;
        end;

        mdClient.Edit;
        str  := mdClient.FieldByName('SmsText').AsString;   // если этого не делать, то почему-то пропадает значение FieldByName('SmsText'), наверное потому что это значение CalcFields
        mdClient.FieldByName('SmsId').AsInteger := SmsId;
        if StrToInt(ret[1]) > 0 then
          mdClient.FieldByName('Status').AsString := 'Передано оператору'
        else
          mdClient.FieldByName('Status').AsString := ErrMsg;
        mdClient.FieldByName('SmsText').AsString := str;    // если этого не делать, то почему-то пропадает значение FieldByName('SmsText'), наверное потому что это значение CalcFields
        mdClient.Next;

        pbMain.Position := pbMain.Position + 1;
        pbMain.Repaint;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
