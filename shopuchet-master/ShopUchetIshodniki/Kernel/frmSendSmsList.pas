unit frmSendSmsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBMultiPageList, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, dxSkinsdxBarPainter,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet,
  pFIBDataSet, ExtCtrls, Menus, ActnList, dxBar, dxBarExtItems, cxClasses,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxPC, cxContainer, StdCtrls, cxButtons, cxTextEdit,
  cxMemo, cxCheckBox, cxCurrencyEdit, Math, Buttons, dxmdaset, Types,
  dxBarBuiltInMenu, cxNavigator, cxEditRepositoryItems, System.Actions;

type
  TSendSmsListForm = class(TDBMultiPageListForm)
    tsClients: TcxTabSheet;
    aInsField: TAction;
    Panel1: TPanel;
    dxEditStyleController: TcxEditStyleController;
    lbNote: TLabel;
    shpNote: TShape;
    shpNote1: TShape;
    mText: TcxMemo;
    ceTranslit: TcxCheckBox;
    lbl2: TLabel;
    shp3: TShape;
    shp4: TShape;
    edSymbols: TcxCurrencyEdit;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    edParts: TcxCurrencyEdit;
    lbDesc: TLabel;
    Panel2: TPanel;
    gr2: TcxGrid;
    tvClient: TcxGridDBTableView;
    lvClient: TcxGridLevel;
    Panel3: TPanel;
    lbBalance: TLabel;
    cxButton1: TcxButton;
    aGetBalance: TAction;
    tvClientRecId: TcxGridDBColumn;
    tvClientg_client: TcxGridDBColumn;
    tvClientname: TcxGridDBColumn;
    tvClientphone: TcxGridDBColumn;
    tvClienttext: TcxGridDBColumn;
    tvClientstatus: TcxGridDBColumn;
    Panel4: TPanel;
    btnInsLike: TBitBtn;
    btnDelChd: TBitBtn;
    Panel5: TPanel;
    BitBtn1: TBitBtn;
    btnUpdChd: TBitBtn;
    aSendNow: TAction;
    aSendSchedule: TAction;
    aUpdSend: TAction;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    aDelAll: TAction;
    mdClient: TdxMemData;
    mdClientID: TIntegerField;
    mdClientName: TStringField;
    mdClientPhone: TStringField;
    mdClientText: TStringField;
    mdClientSmsId: TIntegerField;
    mdClientStatus: TStringField;
    procedure aInsFieldExecute(Sender: TObject);
    procedure mTextPropertiesChange(Sender: TObject);
    procedure ceTranslitPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aRefreshExecute(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aDelAllExecute(Sender: TObject);
    procedure aSendNowExecute(Sender: TObject);
  private
    FCyrText : String;
  public
    { Public declarations }
  end;

var
  SendSmsListForm: TSendSmsListForm;

implementation

uses
  unCommonFunc, smsc_api, frmSmsRecips;

{$R *.dfm}

procedure TSendSmsListForm.aDelAllExecute(Sender: TObject);
begin
  mdClient.Close;
  aRefresh.Execute;
end;

procedure TSendSmsListForm.aDelExecute(Sender: TObject);
begin
  mdClient.Delete;
  if mdClient.RecordCount = 0 then
    aRefresh.Execute;
end;

procedure TSendSmsListForm.aInsExecute(Sender: TObject);
var SmsRecipsForm : TSmsRecipsForm;
  sqlStr : string;
begin
  SmsRecipsForm := TSmsRecipsForm.Create(Self);
  with SmsRecipsForm do begin
    if ShowModal = mrOk then begin
      sqlStr := 'SELECT G.G_CLIENT ID, ' +
                 'G.NAME, ' +
                 'G.PHONE, ' +
                 'REPLACE(''' + StringReplace(mText.text, '''', '''''', []) + ''', ''@name@'', G.NAME) SmsText ' +
                 ',0 SmsId, ' +
                 'null Status ' +
                'FROM G_CLIENT G ' +
              'WHERE IS_CATEGORY = 0 ' +
              'AND IS_SUPPLIER = 0 ';

      if ClientCatArr <> '' then
        sqlStr := sqlStr + 'AND ''' + ClientCatArr + ''' CONTAINING ''~''||G.G_CLIENT_PARENT||''~''';

      if ClientArr <> '' then
        sqlStr := sqlStr + 'AND ''' + ClientArr + ''' CONTAINING ''~''||G.G_CLIENT||''~''';

      if spRead.active then
        spRead.Close;

      // если записей еще нет, т.е. заполн€етс€ в первый раз, то обычный селект
      if mdClient.RecordCount = 0 then
        spRead.SelectSQL.Text := sqlStr
      // если же заполн€етс€ второй раз и далее, то добавл€ю записи через UNION
      else
        spRead.SelectSQL.Text := spRead.SelectSQL.Text + 'UNION ALL ' + sqlStr;

      spRead.SelectSQL.Text := spRead.SelectSQL.Text + ' order by 2, 3';

      OpenSP(spRead, False);
      mdClient.CopyFromDataSet(spRead);
      mdClient.Open;
      aRefresh.Execute;
    end;
  end;
end;

procedure TSendSmsListForm.aInsFieldExecute(Sender: TObject);
begin
  mText.Text := Copy(mText.Text, 0, mText.SelStart) + ' @name@ ' + Copy(mText.Text, mText.SelStart + 1);
end;

procedure TSendSmsListForm.aRefreshExecute(Sender: TObject);
begin
  aDel.Enabled := mdClient.RecordCount > 0;
  aDelAll.Enabled := mdClient.RecordCount > 0;
  aSendNow.Enabled := mdClient.RecordCount > 0;
  aSendSchedule.Enabled := mdClient.RecordCount > 0;
  aUpdSend.Enabled := mdClient.RecordCount > 0;
end;

procedure TSendSmsListForm.aSendNowExecute(Sender: TObject);
var sms : SMSC;
  ret: TStringDynArray;
  ErrorCode, SmsId: integer;
  ErrMsg: string;
begin
  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageDlg('ќтправка SMS невозможна, т.к. не заполнен логин/пароль' + #10#13 +
      'к сервису SMSC.RU. «адайте логин/пароль в настройках программы!', mtWarning, [mbOK], 0);
    Exit;
  end;

  try
    smsc.Create;
    sms.SMSC_LOGIN := SmsLogin;
    sms.SMSC_PASSWORD := SmsPassword;

    with mdClient do begin
      First;
      while not EOF do begin
        try
          ret := sms.send_sms(mdClient.FieldByName('phone').AsString,
                              mdClient.FieldByName('SmsText').AsString,
                              0,  //translit,
                              ''  //time
                              );

          if ret[0] = '-999' then begin
            ErrorCode := -999;
            ErrMsg    := 'Ќет св€зи с сервисом SMSC.RU. ѕроверьте интернет-соединение и попробуйте снова!';
            Exit;
          end;

          if StrToInt(ret[1]) > 0 then
            SmsId := StrToInt(Ret[0])
          else begin
            SmsId := 0;
            ErrorCode := StrToInt(ret[1][2]);
            case ErrorCode of
              1 : ErrMsg := 'ќшибка в параметрах.';
              2 : ErrMsg := 'Ќеверный логин или пароль.';
              3 : ErrMsg := 'Ќедостаточно средств на ¬ашем счете.';
              4 : ErrMsg := 'IP-адрес временно заблокирован из-за частых ошибок в запросах. ѕодробнее.';
              5 : ErrMsg := 'Ќеверный формат даты.';
              6 : ErrMsg := '—ообщение запрещено (по тексту или по имени отправител€).';
              7 : ErrMsg := 'Ќеверный формат номера телефона.';
              8 : ErrMsg := '—ообщение на указанный номер не может быть доставлено.';
              9 : ErrMsg := 'ќтправка более одного одинакового запроса на передачу SMS-сообщени€ либо более п€ти одинаковых запросов на получение стоимости сообщени€ в течение минуты.';
            end;
          end;
        except
          on E : Exception do begin
            ErrorCode := -20500;
            ErrMsg    := 'ќшибка: ' + E.Message;
            Exit;
          end;
        end;

        mdClient.Edit;
        if SmsId > 0 then begin
          mdClient.FieldByName('SmsId').AsInteger := SmsId;
          mdClient.FieldByName('Status').AsString := '”спешно';
        end else
          mdClient.FieldByName('Status').AsString := ErrMsg;

        mdClient.Next;
      end;
    end;
  finally
    sms.Destroy;
  end;
end;

procedure TSendSmsListForm.ceTranslitPropertiesChange(Sender: TObject);
begin
  // транслит работает только в одну сторону - в литиницу, потому что обратно по-любасу получитьс€
  // абракадабра. ѕотому тут буду запоминать старый русский текст, будет конечно немного кор€во
  // если вдруг окно открыли, а текст уже на латинице

  if ceTranslit.Checked then begin
    FCyrText := mText.Text;
    mText.Text := TranslitRus(mText.Text);
  end else
    mText.Text := FCyrText;
end;

procedure TSendSmsListForm.cxButton1Click(Sender: TObject);
var sms : SMSC;
  balance : string;
begin
  if (Trim(SmsLogin) = '') OR (Trim(SmsPassword) = '') then begin
    MessageDlg('ѕроверка баланса невозможна, т.к. не заполнен логин/пароль' + #10#13 +
      'к сервису SMSC.RU. «адайте логин/пароль в настройках программы!', mtWarning, [mbOK], 0);
    Exit;
  end;

  try
    sms := SMSC.Create;
    sms.SMSC_LOGIN := SmsLogin;
    sms.SMSC_PASSWORD := SmsPassword;
    balance := sms.get_balance;

    if balance <> '' then
      lbBalance.Caption := 'Ѕаланс - balance';
  finally
    sms.Destroy;
  end;
end;

procedure TSendSmsListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  SaveSettingsIni('SendSmsList', 'SmsText', Null, mText.Text);
end;

procedure TSendSmsListForm.FormShow(Sender: TObject);
begin
  dxPageControl1.ActivePage := ts1;
  inherited;

  mText.Text := ReadStrSettingsIni('SendSmsList', 'SmsText', ', салон "Beauty" объ€вл€ет о скидке 15% на все!');
end;

procedure TSendSmsListForm.mTextPropertiesChange(Sender: TObject);
begin
  edSymbols.Value := Length(mText.Text);

  edParts.Value := 1;

  if (HaveCrSymbol(mText.Text)) and (Length(mText.Text) > 70) then
    edParts.Value := Ceil(Length(mText.Text)/67)
  else if not (HaveCrSymbol(mText.Text)) and (Length(mText.Text) > 160) then
    edParts.Value := Ceil(Length(mText.Text)/153);
end;

end.
