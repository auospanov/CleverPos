unit frmProductionTovaraN;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, dxExEdtr, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, dxEdLib, dxCntner,
  dxEditor, dxDBEdtr, dxDBELib, dxTL, dxDBCtrl, dxDBGrid, ExtCtrls,
  DB, ActnList, frmDBEdit, unCommonFunc, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase, FIB,
  AppEvnts, cxSpinEdit, cxTimeEdit, Math, frmPopupTovList;

type
  //TOpenMode = (omView, omInsert, omUpdate, omInsertLike, omInsertChild);

  TProductionTovaraNForm = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Panel1: TPanel;
    Shape12: TShape;
    Label7: TLabel;
    Shape13: TShape;
    lbContent: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    edDate: TcxDateEdit;
    ActionList: TActionList;
    aRefreshOfficialRights: TAction;
    aShowWhoLockRecord: TAction;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    spGetData: TpFIBStoredProc;
    spIns: TpFIBStoredProc;
    spUpd: TpFIBStoredProc;
    ShapeNote: TShape;
    lbNote: TLabel;
    mNote: TMemo;
    ShapeNote1: TShape;
    Panel3: TPanel;
    aGetDCard: TAction;
    spUpdLock: TpFIBStoredProc;
    btHelp: TBitBtn;
    pnRowCnt: TPanel;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    peTovar: TdxPopupEdit;
    shp3: TShape;
    lb2: TLabel;
    shp4: TShape;
    edPrice: TdxCurrencyEdit;
    lst1: TListBox;
    spReadSost: TpFIBDataSet;
    tranRead: TpFIBTransaction;
    tranWrite: TpFIBTransaction;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btHelpClick(Sender: TObject);
    procedure peTovarCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure peTovarInitPopup(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FRecID      : Integer;
    FOpenMode   : TOpenMode;
    FSuccess    : Boolean;
    FPopupTovarForm : TPopupTovListForm;
    function CheckParams(var ErrControl: TWinControl): Boolean;
    function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean;
    function ExecSP(SP: TpFIBStoredProc): Boolean;
    procedure SetParams(SP: TpFIBStoredProc);
  protected
    //function IsRecLocked: Boolean;
    //procedure ShowWhoLockRec;
    function CallSP(SP: TpFIBStoredProc): Boolean;
    function InsData: Boolean;
    procedure DisableControls;
  public
    property OpenMode: TOpenMode read FOpenmode write FOpenMode default omView;
    property RecID: Integer read FRecID write FRecID default 0;
  end;

var
  ProductionTovaraNForm: TProductionTovaraNForm;

implementation

uses unErrorHandlers;

{$R *.dfm}
function TProductionTovaraNForm.OpenSP(SP: TpFIBDataSet;
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

function TProductionTovaraNForm.ExecSP(SP: TpFIBStoredProc): Boolean;
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
        END else
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

function TProductionTovaraNForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := False;

  if NOT CheckDate(edDate.Date, '01.01.2000', '01.01.2099') then begin
    ErrControl := edDate;
    MessageDlg('Введена некорректная дата', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

function TProductionTovaraNForm.CallSP(SP: TpFIBStoredProc): Boolean;
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

procedure TProductionTovaraNForm.DisableControls;
begin
  aIns.Enabled := False;
  aUpd.Enabled := False;
  aDel.Enabled := False;
  edDate.ENABLED := FALSE;
  mNote.Enabled := FALSE;
  btnOk.Enabled := FALSE;
end;

procedure TProductionTovaraNForm.SetParams(SP: TpFIBStoredProc);
begin
  with SP do begin
    ParamByName('G_TOCHKA_').AsInteger := CurSklad;
    ParamByName('DATE_').AsDate := edDate.Date;
    ParamByName('G_PRODUCT_').AsInteger := peTovar.Tag;
    ParamByName('AMOUNT_').AsFloat      := edPrice.Value;
    ParamByName('NOTE_').AsString       := mNote.Text;
  end;
end;


procedure TProductionTovaraNForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult <> mrOk then
    Exit;

  CanClose := False;

  if lst1.Items.Count > 0 then
    FSuccess := InsData
  else
    FSuccess := True;

  CanClose := FSuccess;
end;

function TProductionTovaraNForm.InsData: Boolean;
begin
  Result := False;
  try
    if CallSP(spIns) then
    begin
      FRecId := spIns.ParamByName('SKLAD_').AsInteger;
      Result := True;
    end
    else
      Exit;
  except
    on E: EFIBError do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.RollbackRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TProductionTovaraNForm.InsData)');
    end;
    on E: Exception do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.RollbackRetaining;
      MessageDlg(E.Message + #13#10'(occured in TProductionTovaraNForm.InsData)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TProductionTovaraNForm.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  HELPC := 71;
  Application.HelpContext(HELPC);
end;

procedure TProductionTovaraNForm.peTovarCloseUp(Sender: TObject;
  var Text: String; var Accept: Boolean);
begin
  if Accept then begin
    (Sender as TdxPopupEdit).Tag := FPopupTovarForm.spRead.FieldByName('ID').AsInteger;
    Text := FPopupTovarForm.spRead.FieldByName('name').AsString;

    lst1.Clear;
    spReadSost.ParamByName('g_product_').AsInteger := FPopupTovarForm.spRead.FieldByName('ID').AsInteger;
    OpenSP(spReadSost, False);
    pnRowCnt.Caption := IntToStr(spReadSost.RecordCount);
    spReadSost.First;
    while not spReadSost.Eof do begin
      lst1.Items.Add(spReadSost.FieldByName('Name').AsString);
      spReadSost.Next;
    end;

    if FPopupTovarForm.spRead.Active then
      FPopupTovarForm.spRead.Close;
  end;
end;

procedure TProductionTovaraNForm.FormCreate(Sender: TObject);
begin
  peTovar.Tag := 0;
  FPopupTovarForm := TPopupTovListForm.Create(Self);
end;

procedure TProductionTovaraNForm.peTovarInitPopup(Sender: TObject);
begin
  if FPopupTovarForm.spRead.Active then
    FPopupTovarForm.spRead.Close;
  FPopupTovarForm.spRead.SelectSQL.Text := 'select g_product id, name, articul, barcode from g_product where is_kit in (2,3)';
  FPopupTovarForm.arefresh.Execute;
end;

procedure TProductionTovaraNForm.FormShow(Sender: TObject);
begin
  edDate.Date := Now;
end;

end.
