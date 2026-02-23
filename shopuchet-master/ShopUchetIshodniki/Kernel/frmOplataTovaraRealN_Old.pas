unit frmOplataTovaraRealN_Old;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ExtCtrls,
  DB, ActnList, frmDBEdit, unCommonFunc, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase, FIB,
  AppEvnts, cxSpinEdit, cxTimeEdit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxMemo, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, System.UITypes,
  cxNavigator, Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  //TOpenMode = (omView, omInsert, omUpdate, omInsertLike, omInsertChild);

  TOplataTovaraRealNForm_old = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    dsPostavshik: TDataSource;
    dsPaymentType: TDataSource;
    dsZakazTemp: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    BitBtn12: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    ActionList: TActionList;
    aRefreshOfficialRights: TAction;
    aShowWhoLockRecord: TAction;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    tranRead: TpFIBTransaction;
    spPostavshik: TpFIBDataSet;
    spPaymentType: TpFIBDataSet;
    spZakazTemp: TpFIBDataSet;
    spDel: TpFIBStoredProc;
    spGetData: TpFIBStoredProc;
    spIns: TpFIBStoredProc;
    spUpd: TpFIBStoredProc;
    tranWrite: TpFIBTransaction;
    Panel3: TPanel;
    spUpdLock: TpFIBStoredProc;
    btHelp: TBitBtn;
    pnRowCnt: TPanel;
    pn1: TPanel;
    lb1: TLabel;
    sh1: TShape;
    lb2: TLabel;
    sh2: TShape;
    sh3: TShape;
    lb3: TLabel;
    sh4: TShape;
    lb4: TLabel;
    sh5: TShape;
    lb5: TLabel;
    edDate: TcxDateEdit;
    sh6: TShape;
    sh7: TShape;
    sh8: TShape;
    sh9: TShape;
    sh10: TShape;
    lb6: TLabel;
    sh11: TShape;
    sh12: TShape;
    edTime: TcxTimeEdit;
    grProduct: TcxGrid;
    tvMain: TcxGridDBTableView;
    clmMainPRODUCT_NAME: TcxGridDBColumn;
    clmMainAMOUNT: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainSUMM: TcxGridDBColumn;
    clmMainDISCOUNT_PERC: TcxGridDBColumn;
    clmMainDISCOUNT_SUMM: TcxGridDBColumn;
    clmMainNDS: TcxGridDBColumn;
    clmMainNDS_SUMM: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    edOsnovanie: TcxTextEdit;
    lePostavshik: TcxLookupComboBox;
    lePAYMENT_TYPE: TcxLookupComboBox;
    mNote: TcxMemo;
    procedure FormShow(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    //procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btHelpClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    FRecID      : Int64;
    FOpenMode   : TOpenMode;
    FSuccess    : Boolean;
    FClient     : Int64;
    FMode       : Integer;   //Режим. 0 - оплата товара, 1 - возврат товара
    function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean;
    function ExecSP(SP: TpFIBStoredProc): Boolean;
    function CheckParams(var ErrControl: TWinControl): Boolean;
    procedure SetParams(SP: TpFIBStoredProc);
  protected
    function CallSP(SP: TpFIBStoredProc): Boolean;
    function InsData: Boolean;
    function UpdData: Boolean;
    procedure GetData;
    procedure ClearTempTable;
  public
    property OpenMode: TOpenMode read FOpenmode write FOpenMode default omView;
    property Success: Boolean read FSuccess write FSuccess default False;
    property RecID: Int64 read FRecID write FRecID default 0;
    property Client: Int64 read FClient write FClient default 0;
    property Mode: Integer read FMode write FMode default 0;    //Режим. 0 - оплата товара, 1 - возврат товара
    procedure Readlist;
  end;

var
  OplataTovaraRealNForm_old: TOplataTovaraRealNForm_old;

implementation

uses unErrorHandlers, frmOplataTovaraReal, frmZakupkaTovara;

{$R *.dfm}
function TOplataTovaraRealNForm_old.OpenSP(SP: TpFIBDataSet;
  UseBookmark: Boolean): Boolean;
{Открывает хр. процедуру (Open). С try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
  BM: TBookmark;
begin
  {Параметры процедуры должны задаваться до вызова этого метода}
  Result := False;
  try
    with SP do begin
      BM := GetBookmark;
      try
        Close;
        if SP.Transaction.InTransaction then
          SP.Transaction.CommitRetaining;
        Open;

        if Fields.FindField('ERR_CODE') <> Nil then begin
          if VarIsNull(FieldByName('ERR_CODE').Value) or (FieldByName('ERR_CODE').AsString = '') then
            ErrCode := 0
          else
            ErrCode := FieldByName('ERR_CODE').AsInteger;
          if ErrCode <> 0 then begin
            if SP.Transaction.InTransaction then
              SP.Transaction.CommitRetaining;
            if Fields.FindField('ERR_MSG').Index >= 0 then begin
              ErrMsg := FieldByName('ERR_MSG').AsString;
              DBErrorHandler(ErrCode, ErrMsg);
            end
            else
              MessageDlg('Error code: ' + IntToStr(ErrCode)
                 + #13#10'(occured in TDBDlgForm.OpenSP)', mtInformation, [mbOK], 0);
            Exit;
          end;
        end;

        if UseBookmark then
          if BM <> Nil then
            if BookmarkValid(BM) then
              try
                GotoBookmark(BM);
              except
              end;
      finally;
        FreeBookmark(BM);
      end;
      Result := True;
    end;
  except
    on E: EFIBError do begin
      if SP.Transaction.InTransaction then
        SP.Transaction.CommitRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBDlgForm.OpenSP)');
    end;
    on E: Exception do begin
      if SP.Transaction.InTransaction then
        SP.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBDlgForm.OpenSP)', mtError, [mbOk], 0);
    end;
  end;
end;

function TOplataTovaraRealNForm_old.ExecSP(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;

  with SP do begin
    try
      ExecProc;
    except
      on E: EFIBError do begin
        if SP.Transaction.InTransaction then
          SP.Transaction.Rollback;
        if (POS('deadlock', LowerCase(E.Message)) > 0) or (POS('update conflicts with concurrent update', LowerCase(E.Message)) > 0) then
          MessageDlg('Запись в данный момент редактируется другим пользователем и доступна только для просмотра!', mtInformation, [mbOk], 0)
        else if POS('nol_exception', LowerCase(E.Message)) > 0 then BEGIN
          ErrMsg := Copy(E.Message, Pos('/R\', E.Message), Pos('/RR\', E.Message) - Pos('/R\', E.Message));
          DBErrorHandler(-20500, ErrMsg);
        end else
          MessageDlg('Ошибка № ' + IntToStr(E.SQLCode) + ':' + E.Message +  #13#10 + 'Ошибка при блокировке записи', mtError, [mbOk], 0);
        Exit;
      end
    end;

    if FieldIndex['ERR_CODE'] >= 0 then begin
      ErrCode := ParamByName('ERR_CODE').AsInteger;
      if ErrCode <> 0 then begin
        if SP.Transaction.InTransaction then
          SP.Transaction.Rollback;
        if FieldIndex['ERR_MSG'] >= 0 then begin
          ErrMsg := ParamByName('ERR_MSG').AsString;
          DBErrorHandler(ErrCode, ErrMsg);
        end
        else
          MessageDlg('Error code: ' + IntToStr(ErrCode)
             + #13#10'(occured in TDlgForm.CallSP)', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

function TOplataTovaraRealNForm_old.CallSP(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrControl: TWinControl;
begin
  Result := False;

  if not CheckParams(ErrControl) then begin
    if ErrControl <> Nil then
      ErrControl.SetFocus;
    Exit;
  end;

  if not SP.Transaction.InTransaction then  
    SP.Transaction.StartTransaction;

  SetParams(SP);

  Result := ExecSP(SP);

  if SP.Transaction.InTransaction then
    SP.Transaction.Commit;
end;

function TOplataTovaraRealNForm_old.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := False;

  if NOT CheckDate(edDate.Date, '01.01.2000', '01.01.2099') then begin
    ErrControl := edDate;
    MessageDlg('Введена некорректная дата', mtInformation, [mbOK], 0);
    Exit;
  end;

  if NOT CheckTime(edTime.Time) then begin
    ErrControl := edTime;
    MessageDlg('Введено некорректное время', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TOplataTovaraRealNForm_old.GetData;
begin
  try
    spGetData.ParamByName('zakaz_').AsInt64 := FRecID;
    spGetData.ParamByName('IS_VOZVRAT_').AsInteger := FMode;
    if not spGetData.Transaction.InTransaction then
      spGetData.Transaction.StartTransaction;

    ExecSP(spGetData);

    if spGetData.Transaction.InTransaction then
      spGetData.Transaction.CommitRetaining;
  except
    on E: EFIBError do
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBEditForm.GetData)');
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBEditForm.GetData)', mtInformation, [mbOk], 0);
  end;

  if FOpenMode <> omInsert then BEGIN
    with spGetData do begin
      edDate.Date := ParamByName('Z_DATE_').AsDate;
      edTime.Time := ParamByName('Z_Time_').AsTime;
      lePostavshik.EditValue := ParamByName('G_CLIENT_').AsInt64;
      lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsInt64;
      edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
      mNote.Text := ParamByName('note_').AsString;
      Readlist;
    end;
  END;

  if FOpenMode = omView then
    PostMessage(Self.Handle, WM_READONLYCONTROLS, 0, 0)

  else begin
    if FOpenMode = omUpdate then begin
      spUpdLock.ParamByName('id_').AsInt64 := RecId;
      if FMode = 1 then
        spUpdLock.ParamByName('TABLE_NAME_').AsString := 'sklad_parent'
      else
        spUpdLock.ParamByName('TABLE_NAME_').AsString := 'zakaz';

      if not spUpdLock.Transaction.InTransaction then
        spUpdLock.Transaction.StartTransaction;
      if not ExecSP(spUpdLock) then begin
        aIns.Enabled := False;
        aUpd.Enabled := False;
        aDel.Enabled := False;
        edDate.ENABLED := FALSE;
        edTime.ENABLED := FALSE;
        edOsnovanie.ENABLED := FALSE;
        mNote.Enabled := FALSE;
        lePostavshik.ENABLED := FALSE;
        lePAYMENT_TYPE.ENABLED := FALSE;
        btnOk.Enabled := FALSE;
        EXIT;
      end;
    end;
  end;
end;

procedure TOplataTovaraRealNForm_old.SetParams(SP: TpFIBStoredProc);
var AIndex : Integer;
begin
  with SP do begin
    if lePostavshik.EditValue > 0 then
      ParamByName('G_CLIENT_').AsInt64 := lePostavshik.EditValue;
    if lePostavshik.EditValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInt64 := lePAYMENT_TYPE.EditValue;
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    with tvMain.DataController.Summary do
    begin
      AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSUMM);
      ParamByName('SUMM_').AsFloat := FooterSummaryValues[AIndex];
      ParamByName('SUMM_FACT_').AsFloat := FooterSummaryValues[AIndex];
    end;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('Z_DATE_').AsDate := edDate.Date;
    ParamByName('Z_Time_').AsTime := edTime.Time;
    if FMode = 1 then
      ParamByName('is_spisanie_').AsInteger := 3    //ВОЗВРАТ ТОВАРА
    else
      ParamByName('is_spisanie_').AsInteger := 0;  //как обычная продажа
  end;
end;

procedure TOplataTovaraRealNForm_old.Readlist;
begin
  OpenSP(spZakazTemp, True);
  pnRowCnt.Caption := IntToStr(spZakazTemp.RecordCount);
  aUpd.Enabled := False;//spZakazTemp.RecordCount > 0;
  aDel.Enabled := spZakazTemp.RecordCount > 0;
  btnOk.Enabled := spZakazTemp.RecordCount > 0;
end;

procedure TOplataTovaraRealNForm_old.FormShow(Sender: TObject);
begin
  ClearTempTable;      //ОЧИЩАЮ ВРЕМЯНКУ

  CAPTION := 'Оформление оплаты за товар, выданный под реализацию';
  OpenSp(spPostavshik, False);
  lePostavshik.EditValue := FClient;
  lePostavshik.Enabled := False;

  OpenSp(spPaymentType, False);
  lePAYMENT_TYPE.EditValue := 1;   // по умолчанию поставлю наличный расчет

  GetData;
  Readlist;

  //ЕСЛИ ЭТО ВОЗВРАТ ТОВАРА, ТО СТАВЛЮ В spIns ДРУГУЮ ПРОЦЕДУРУ
  IF FMode = 1 THEN BEGIN
    Caption := 'Оформить возврат';
    lb1.Caption := 'Дата возврата';
  END;

  IF FOpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
    btnOk.Enabled := spZakazTemp.RecordCount > 0;
  end;
  {
  with grProduct do
    ShowSummaryFooter := True;  }
end;

procedure TOplataTovaraRealNForm_old.aInsExecute(Sender: TObject);
var OplataTovaraRealForm : TOplataTovaraRealForm;
begin
  OplataTovaraRealForm := TOplataTovaraRealForm.Create(Self);
  try
    OplataTovaraRealForm.OpenMode := omInsert;
    OplataTovaraRealForm.Client := FClient;
    OplataTovaraRealForm.ModeZ := FMode;
    IF OplataTovaraRealForm.ShowModal = mrOK THEN begin
      Readlist;
    END;
  finally
    OplataTovaraRealForm.Free;
  end;
end;

procedure TOplataTovaraRealNForm_old.BitBtn9Click(Sender: TObject);
begin

end;

{procedure TOplataTovaraRealNForm.aUpdExecute(Sender: TObject);
begin
  UpdOplataTovaraRealForm := TUpdOplataTovaraRealForm.Create(Self);
  with UpdOplataTovaraRealForm do begin
    OpenMode := omUpdate;
    RecID := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsInteger;
    Is_spisanie := FIs_spisanie;
    try
      if UpdOplataTovaraRealForm.ShowModal = mrOK then begin
        Readlist;
        edOsnovanie.Modified := True;
      end;
    finally
      UpdOplataTovaraRealForm.Free;
    end;
  end;
end; }

procedure TOplataTovaraRealNForm_old.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить продажу товара "%s" ?',
    [spZakazTemp.FieldByName('PRODUCT_NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  spDel.ParamByName('ZAKAZ_DETAILS_').AsInt64 := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsLargeInt;
  if ExecSP(spDel) then BEGIN
    if spDel.Transaction.InTransaction then
      spDel.Transaction.Commit;
    Readlist;
    edOsnovanie.ModifiedAfterEnter := TRUE;
  END;
end;

procedure TOplataTovaraRealNForm_old.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult <> mrOk THEN BEGIN
    ClearTempTable;      // ПО НАЖАТИЮ НА КНОПКУ ОТМЕНА ТОЖЕ ОЧИЩАЮ ВРЕМЯНКУ
    if spUpdLock.Transaction.InTransaction then spUpdLock.Transaction.Commit;  //а также снимаю блокировку с записи
    Exit;
  END;

  CanClose := False;

  if (OpenMode = omUpdate) and (not CheckRequizChanged(Self)) then
  begin
    {Возможно, OK просто нажата после утверждения или для закрытия окна. Изменений не было}
    FSuccess := True;
    CanClose := True;
    Exit;
  end;

  if FOpenMode in [omInsert, omInsertLike, omInsertChild] then
    FSuccess := InsData
  else if FOpenMode = omUpdate then
    FSuccess := UpdData;

  IF FSuccess THEN    // ОЧИЩАЮИ ВРЕМЕННУЮ ТАБЛИЧКУ ТОЛЬКО ЕСЛИ БЫЛО УСПЕШНОЕ СОХРАНЕНИЕ
    ClearTempTable;

  CanClose := FSuccess;
end;

function TOplataTovaraRealNForm_old.InsData: Boolean;
begin
  Result := False;
  try
    if CallSP(spIns) then
    begin
      Result := True;
    end
    else
      Exit;
  except
    on E: EFIBError do
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBEditForm.InsData)');
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBEditForm.InsData)', mtInformation, [mbOk], 0);
  end;
end;

function TOplataTovaraRealNForm_old.UpdData: Boolean;
begin
  Result := False;
  try
    spUpd.ParamByName('ZAKAZ_').AsInt64 := FRecId;

    if CallSP(spUpd) then
    begin
      Result := True;
    end
    else
      Exit;
  except
    on E: EFIBError do
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TOplataTovaraRealNForm.UpdData)');
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TOplataTovaraRealNForm.UpdData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TOplataTovaraRealNForm_old.ClearTempTable;
begin
  spDel.Params[0].Clear;
  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  ExecSP(spDel);

  if spDel.Transaction.InTransaction then
    spDel.Transaction.Commit;
end;

procedure TOplataTovaraRealNForm_old.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  if FMode = 1 then
    Helpc := 60
  else
    HELPC := 59;

  Application.HelpContext(HELPC);
end;

end.
