unit dmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Db, FIBDatabase, pFIBDatabase,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDataSet, pFIBDataSet, IB_Services,
  pFIBErrorHandler, FIB, VLLogFile, cxStyles, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME, xmldom, XMLIntf, msxmldom, XMLDoc, cxClasses;

type
  TMainDM = class(TDataModule)
    imMain: TImageList;
    dbMain: TpFIBDatabase;
    tranMainRead: TpFIBTransaction;
    tranMainWrite: TpFIBTransaction;
    spGetServerTime: TpFIBStoredProc;
    spGetSettings: TpFIBStoredProc;
    imMainDisabled: TImageList;
    spReadCurrOfficRights: TpFIBDataSet;
    spReadCurrOfficRightsRIGHTS_ITEM: TFIBIntegerField;
    spGetSysParamCount: TpFIBStoredProc;
    spFillCurParams: TpFIBStoredProc;
    spGetConnectCount: TpFIBDataSet;
    spTochka: TpFIBDataSet;
    spSetSklad: TpFIBStoredProc;
    spGetSystemSetup: TpFIBStoredProc;
    spSetSystemSetup: TpFIBStoredProc;
    spClearDatabase: TpFIBStoredProc;
    dbMainThread: TpFIBDatabase;
    tranMainThreadRead: TpFIBTransaction;
    tranMainThreadWrite: TpFIBTransaction;
    spSetNewPrices: TpFIBStoredProc;
    spPredzakazTovar: TpFIBStoredProc;
    VLLogFile1: TVLLogFile;
    cxStyleRepository: TcxStyleRepository;
    stGridSelectedRow: TcxStyle;
    stBandStyle: TcxStyle;
    stHeaderStyle: TcxStyle;
    stColumnHeaderStyle: TcxStyle;
    stGridSelectedRow11: TcxStyle;
    spFillSchedule: TpFIBStoredProc;
    IdEncoderMIME1: TIdEncoderMIME;
    stIncSearchStyle: TcxStyle;
    spReadSmsRecipients: TpFIBDataSet;
    spInsSmsHistory: TpFIBStoredProc;
    dbMainSmsThread: TpFIBDatabase;
    tranMainSmsThreadRead: TpFIBTransaction;
    tranMainSmsThreadWrite: TpFIBTransaction;
    spThreadReadSmsRecipients: TpFIBDataSet;
    fbstrngfldThreadReadSmsRecipientsPHONE: TFIBStringField;
    fbntgrfldThreadReadSmsRecipientsG_CLIENT: TFIBIntegerField;
    fbstrngfldThreadReadSmsRecipientsTEXT: TFIBStringField;
    fbstrngfldThreadReadSmsRecipientsTIME_TO_SEND: TFIBStringField;
    spThreadReadSmsRecipientsSmstext: TStringField;
    fbstrngfldThreadReadSmsRecipientsNAME: TFIBStringField;
    spThreadInsSmsHistory: TpFIBStoredProc;
    procedure spThreadReadSmsRecipientsCalcFields(DataSet: TDataSet);
  private
  public
  end;

var
  MainDM: TMainDM;

implementation

uses
  unCommonFunc;

{$R *.DFM}

{procedure TMainDM.pFibErrorHandlerFIBErrorEvent(Sender: TObject;
  ErrorValue: EFIBError; KindIBError: TKindIBError; var DoRaise: Boolean);
var S: String;
begin
  if (POS('deadlock', LowerCase(ErrorValue.IBMessage)) > 0) or (POS('update conflicts with concurrent update', LowerCase(ErrorValue.IBMessage)) > 0) then
    MessageDlg('Запись в данный момент редактируется другим пользователем и доступна только для просмотра!', mtInformation, [mbOk], 0)
  else begin
    S := S + 'SQLCode = ' + IntToStr(ErrorValue.SQLCode) + #10#13;
    S := S + 'IBErrorCode = ' + IntToStr(ErrorValue.IBErrorCode) + #10#13;
    S := S + 'IBMessage = ' + ErrorValue.IBMessage + #10#13;
    Application.MessageBox(PAnsiChar(S), 'Ошибка БД', MB_OK + MB_ICONSTOP);
    DoRaise := False;
  end;
end;}

procedure TMainDM.spThreadReadSmsRecipientsCalcFields(DataSet: TDataSet);
var str : string;
begin
  str := spThreadReadSmsRecipients.FieldByName('name').AsString;

  if SmsTranslit = 1 then
    str := TranslitRus(str);

  spThreadReadSmsRecipients.FieldByName('smstext').AsString :=
    StringREPLACE(spThreadReadSmsRecipients.FieldByName('Text').AsString, '@name@', str, []);
end;

end.
