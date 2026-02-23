unit frmUpdSmsNotifyHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, cxContainer, cxEdit, AppEvnts, ExtCtrls, StdCtrls,
  Buttons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxSpinEdit, cxTimeEdit, cxDropDownEdit, cxCalendar,
  cxMemo, cxTextEdit, cxMaskEdit, DateUtils, Types, StrUtils, FIB, unCommonFunc, System.UITypes,
  Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions, cxClasses, Vcl.Menus,
  cxButtons;

type
  TUpdSmsNotifyHistoryForm = class(TDBEditForm)
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    edPhone: TcxMaskEdit;
    lb2: TLabel;
    shp3: TShape;
    shp4: TShape;
    mSmsNotifyText: TcxMemo;
    lb3: TLabel;
    shp5: TShape;
    cbHowSend: TcxComboBox;
    shp7: TShape;
    edDate: TcxDateEdit;
    edTime: TcxTimeEdit;
    procedure cbHowSendPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edPhonePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormShow(Sender: TObject);
  private
    FSendTime : String;
    FMode : Integer;
    FBalance : string;
  public
    function UpdData: Boolean; override;
    property Mode : Integer read FMode write FMode;
    property SendTime : string read FSendTime write FSendTime;
    property Balance : string read FBalance write FBalance;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  UpdSmsNotifyHistoryForm: TUpdSmsNotifyHistoryForm;

implementation

uses
  smsc_api, unErrorHandlers;

{$R *.dfm}

procedure TUpdSmsNotifyHistoryForm.cbHowSendPropertiesChange(Sender: TObject);
begin
  edDate.Enabled := cbHowSend.ItemIndex = 1;
  edTime.Enabled := cbHowSend.ItemIndex = 1;
end;

function TUpdSmsNotifyHistoryForm.CheckParams(
  var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(mSmsNotifyText.Text) = EmptyStr then begin
    ErrControl := mSmsNotifyText;
    MessageDlg('Текст SMS-сообщения пуст!', mtInformation, [mbOK], 0);
    Exit;
  end;

  if (edPhone.Text = '+7(   )   -    ') OR (edPhone.Text = '+7          ') then begin
    ErrControl := edPhone;
    MessageDlg('Введите номер телефона!', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TUpdSmsNotifyHistoryForm.edPhonePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if Error then begin
    MessageDlg('Некорректное значение номера телефона!', mtWarning, [mbOk], 0);
    edPhone.SetFocus;
    Error := False;
  end;
end;

procedure TUpdSmsNotifyHistoryForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'sms_history_';
end;

procedure TUpdSmsNotifyHistoryForm.FormShow(Sender: TObject);
begin
  inherited;
  edDate.Date := Date;
  edTime.Time := Time;
end;

procedure TUpdSmsNotifyHistoryForm.GetData;
begin
  // при вызове с "Журнал авто смс"
  if FMode = 0 then begin
    inherited;
    if OpenMode in [omView, omUpdate] then begin
      with spGetData do begin
        edPhone.Text := ParamByName('PHONE_').AsString;
        mSmsNotifyText.Text := ParamByName('TEXT_').AsString;
        edDate.Date := Trunc(ParamByName('DATETIME_').AsDate);
        edTime.Time := ParamByName('DATETIME_').AsTime;
      end;
    end;
  end;
end;

procedure TUpdSmsNotifyHistoryForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('TEXT_').AsString := mSmsNotifyText.Text;
    ParamByName('PHONE_').AsString := edPhone.Text;
  end;
end;

function TUpdSmsNotifyHistoryForm.UpdData: Boolean;
var
  myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;
  smsId, Errcode : integer;
  Errmsg: string;
begin
  Result := False;

  if cbHowSend.ItemIndex = 1 then begin
    DecodeDateTime(edDate.Date + edTime.Time, myYear, myMonth, myDay,
                   myHour, myMin, mySec, myMilli);
    FSendTime := Format('%.*d',[2, myDay]) + Format('%.*d',[2, myMonth]) + Copy(IntToStr(myYear), 3, 2) +
                 Format('%.*d',[2, myHour]) + Format('%.*d',[2, myMin]);
  end else
    FSendTime := '';

  // при вызове с Журнала смс
  if FMode = 0 then begin
    try
      smsId := send_sms_one(edPhone.Text, mSmsNotifyText.Text, 0, SendTime, FBalance, Errcode, Errmsg);

      if errcode = -999 then begin
        MessageDlg(Errmsg, mtError, [mbOK], 0);
        Exit;
      end;

      spUpd.ParamByName('SMS_ID_').AsInteger := smsId;
      spUpd.ParamByName('ERROR_').AsInteger := Errcode;

      if Errcode = 0 then begin
        if cbHowSend.ItemIndex = 1 then begin
          spUpd.ParamByName('DATETIME_').AsDateTime := edDate.Date + edTime.Time;
          spUpd.ParamByName('G_SMS_STATUS_').AsInteger := -1;
        end else begin
          spUpd.ParamByName('DATETIME_').clear;
          spUpd.ParamByName('G_SMS_STATUS_').AsInteger := 0;
        end;
      end else begin
        if Errcode = 7 then
          spUpd.ParamByName('G_SMS_STATUS_').AsInteger := 22
        else if Errcode = 8 then
          spUpd.ParamByName('G_SMS_STATUS_').AsInteger := 25
        else
          spUpd.ParamByName('G_SMS_STATUS_').AsInteger := 100;
      end;

      spUpd.ParamByName('sms_history_').AsInteger := RecId;

      if CallSP(spUpd) then
        Result := True;
    except
      on E: EFIBError do begin
        if spUpd.Transaction.InTransaction then
          spUpd.Transaction.Rollback;
        DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TUpdSmsNotifyHistoryForm.UpdData)');
      end;
      on E: Exception do begin
        if spUpd.Transaction.InTransaction then
          spUpd.Transaction.Rollback;
        MessageDlg(E.Message + #13#10'(occured in TUpdSmsNotifyHistoryForm.UpdData)', mtError, [mbOk], 0);
      end;
    end;
  end else
    Result := True;  // при вызове с "Рассылка СМС"
end;

end.
