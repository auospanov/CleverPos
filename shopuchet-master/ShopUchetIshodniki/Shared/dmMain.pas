unit dmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Db, FIBDatabase, pFIBDatabase,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDataSet, pFIBDataSet, IB_Services,
  pFIBErrorHandler, FIB, VLLogFile, cxStyles, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME, xmldom, XMLIntf, msxmldom, XMLDoc, cxClasses,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  dxmdaset, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, pFIBScripter, JvThread, JvThreadDialog,
  JvComponentBase;

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
    MainLogFile: TVLLogFile;
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
    dbMainSyncSetup: TpFIBDatabase;
    tranMainSyncSetupRead: TpFIBTransaction;
    tranMainSyncSetupWrite: TpFIBTransaction;
    spReadUniversal: TpFIBDataSet;
    spUniversal: TpFIBStoredProc;
    imMain32: TImageList;
    imMainDisabled32: TImageList;
    dbMainSyncData: TpFIBDatabase;
    tranMainSyncDataRead: TpFIBTransaction;
    tranMainSyncDataWrite: TpFIBTransaction;
    mdSyncOut: TdxMemData;
    mdSyncIn: TdxMemData;
    mdSyncInDAT: TBlobField;
    mdSyncInUSR: TStringField;
    mdSyncInRR: TStringField;
    mdSyncInSYNC_COMPS: TStringField;
    spImportSyncIn: TpFIBQuery;
    spSync: TpFIBStoredProc;
    spSyncLogOut: TpFIBDataSet;
    spSyncReadComps: TpFIBDataSet;
    spWriteUniversal: TpFIBDataSet;
    IdFTP: TIdFTP;
    spClearBase: TpFIBStoredProc;
    pFibErrorHandler1: TpFibErrorHandler;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    spDelOlds: TpFIBDataSet;
    spCheckConnect: TpFIBDataSet;
    bcdfldSyncInID: TBCDField;
    strngfldSyncInTTABLE: TStringField;
    scriptUniversal: TpFIBScripter;
    scriptSync: TpFIBScripter;
    dxECWID: TdxMemData;
    strngfldECWIDID: TStringField;
    strngfldECWIDNAME: TStringField;
    dxMemDataTIS: TdxMemData;
    smlntfldMemDataTISKaspiID: TSmallintField;
    strngfldMemDataTISNAME: TStringField;
    SQLTMP: TpFIBDataSet;
    blbfldSyncInSQLSTMT: TBlobField;
    spRecalcKassaForToday: TpFIBStoredProc;
    spRecalcReminders: TpFIBStoredProc;
    procedure spThreadReadSmsRecipientsCalcFields(DataSet: TDataSet);
    procedure pFibErrorHandler1FIBErrorEvent(Sender: TObject;
      ErrorValue: EFIBError; KindIBError: TKindIBError; var DoRaise: Boolean);
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

procedure TMainDM.pFibErrorHandler1FIBErrorEvent(Sender: TObject;
  ErrorValue: EFIBError; KindIBError: TKindIBError; var DoRaise: Boolean);
begin
  if KindIBError = keLostConnect then
  begin
    MessageDlg(GetServerConnectError(ErrorValue.Message), mtError, [mbOk], 0);

    dbMain.Connected := false;
  end;
end;

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
