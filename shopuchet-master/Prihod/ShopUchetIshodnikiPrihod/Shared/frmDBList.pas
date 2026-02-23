unit frmDBList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frmDBListRO, Db, ExtCtrls, Menus, ActnList, dxBar,
  dxBarExtItems, unCommonFunc, frmDBEdit,
  dxBarExtDBItems, FIB, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDataSet, pFIBDataSet, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, dxSkinsdxBarPainter, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxContainer,
  cxNavigator, System.Actions, UITypes, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TDBListForm = class(TDBListROForm)
    aView: TAction;
    aIns: TAction;
    aInsLike: TAction;
    aUpd: TAction;
    aDel: TAction;
    dxBarButtonView: TdxBarButton;
    dxBarButtonIns: TdxBarButton;
    dxBarButtonUpd: TdxBarButton;
    dxBarButtonDel: TdxBarButton;
    dxBarButtonInsLike: TdxBarButton;
    spDel: TpFIBStoredProc;
    tranWrite: TpFIBTransaction;
    aHelp: TAction;
    dxBarButton1: TdxBarButton;
    procedure aViewExecute(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aInsLikeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure atestExecute(Sender: TObject);
    procedure tvMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    FClassForm: TDBEditForm;
  //  FKeyField : String;
    FKeyFieldList : String;
    FKeyFieldClass : String;
    FKeyFieldIsStr: Boolean;
    FHelpC : Integer;
    procedure WMViewRec(var Message: TMessage); message WM_VIEWREC;
    procedure WMInsRec(var Message: TMessage); message WM_INSREC;
    procedure WMInsLikeRec(var Message: TMessage); message WM_INSLIKEREC;
    procedure WMUpdRec(var Message: TMessage); message WM_UPDREC;
    procedure WMDelRec(var Message: TMessage); message WM_DELREC;
    procedure WMHelpMe(var Message: TMessage); message WM_HELPME;
  protected
    procedure ReadList; override;
    procedure ViewData; virtual;
    procedure InsData; virtual;
    procedure InsLikeData; virtual;
    procedure UpdData; virtual;
    procedure DelData; virtual;
  public
   // property KeyField : String read FKeyField write FKeyField; //добавил
    property ClassForm: TDBEditForm read FClassForm write FClassForm;
    property KeyFieldList: String read FKeyFieldList write FKeyFieldList;
    property KeyFieldClass: String read FKeyFieldClass write FKeyFieldClass;
    property KeyFieldIsStr: Boolean read FKeyFieldIsStr write FKeyFieldIsStr default False;
    property HelpC : integer read FHelpC write FHelpC default 0;    
  end;

implementation

uses dmMain, unErrorHandlers;

{$R *.DFM}

procedure TDBListForm.ReadList;
begin
  {В потомке при необходимости задаются параметры вызова хранимой процедуры,
  затем потомок должен вызвать этот метод (inherited)}
  inherited;
  aView.Enabled := spRead.RecordCount > 0;
  aInsLike.Enabled := spRead.RecordCount > 0;
  aUpd.Enabled := spRead.RecordCount > 0;
  aDel.Enabled := spRead.RecordCount > 0;
end;

procedure TDBListForm.tvMainCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aUpd.Execute;
end;

procedure TDBListForm.ViewData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  FClassForm.KeyField := FKeyFieldClass;
  if FKeyFieldIsStr then begin
    FClassForm.KeyFieldIsStr := True;
    FClassForm.RecIDStr := spRead.FieldByName(FKeyFieldList).AsString;
    FClassForm.RecID := 0;
  end
  else begin
    FClassForm.KeyFieldIsStr := False;
    FClassForm.RecID := spRead.FieldByName(FKeyFieldList).AsInteger;
    FClassForm.RecIDStr := '';
  end;
  FClassForm.OpenMode := omView;
  FClassForm.ShowModal;
end;

procedure TDBListForm.InsData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then
      FClassForm.KeyFieldIsStr := True
    else
      FClassForm.KeyFieldIsStr := False;

    FClassForm.OpenMode := omInsert;
    if FClassForm.ShowModal = mrOk then begin
{----}
(*
      aRefresh.Execute;  {aRefresh здесь не подходит, т.к. WM_REFRESH
                          произойдет после Locate и курсор опять встанет на
                          строку, где был раньше}
*)
      tAutoRefresh.Enabled := False;

      ReadList;

      if AutoRefresh > 0 then begin
        tAutoRefresh.Interval := AutoRefresh * 1000 * 60;
        tAutoRefresh.Enabled := True;
      end;
{----}
      {Курсор на новую запись}
      if FKeyFieldIsStr then
        spRead.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        spRead.Locate(FKeyFieldList, FClassForm.RecID, []);

      if ActiveTVControl.Controller.FocusedRow <> Nil then begin
        if ActiveTVControl.Controller.SelectedRowCount > 0 then
          ActiveTVControl.Controller.SelectedRows[0].Selected := False;
        ActiveTVControl.Controller.FocusedRow.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBListForm.InsData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBListForm.InsLikeData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then begin
      FClassForm.KeyFieldIsStr := True;
      FClassForm.RecIDStr := spRead.FieldByName(FKeyFieldList).AsString;
      FClassForm.RecID := 0;
    end
    else begin
      FClassForm.KeyFieldIsStr := False;
      FClassForm.RecID := spRead.FieldByName(FKeyFieldList).AsInteger;
      FClassForm.RecIDStr := '';
    end;
    FClassForm.OpenMode := omInsertLike;
    if FClassForm.ShowModal = mrOk then begin
{----}
(*
      aRefresh.Execute;  {aRefresh здесь не подходит, т.к. WM_REFRESH
                          произойдет после Locate и курсор опять встанет на
                          строку, где был раньше}
*)
      tAutoRefresh.Enabled := False;

      ReadList;

      if AutoRefresh > 0 then begin
        tAutoRefresh.Interval := AutoRefresh * 1000 * 60;
        tAutoRefresh.Enabled := True;
      end;
{----}
      {Курсор на новую запись}
      if FKeyFieldIsStr then
        spRead.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        spRead.Locate(FKeyFieldList, FClassForm.RecID, []);

      if ActiveTVControl.Controller.FocusedRow <> Nil then begin
        if ActiveTVControl.Controller.SelectedRowCount > 0 then
          ActiveTVControl.Controller.SelectedRows[0].Selected := False;
        ActiveTVControl.Controller.FocusedRow.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBListForm.InsLikeData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBListForm.UpdData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then begin
      FClassForm.KeyFieldIsStr := True;
      FClassForm.RecIDStr := spRead.FieldByName(FKeyFieldList).AsString;
      FClassForm.RecID := 0;
    end
    else begin
      FClassForm.KeyFieldIsStr := False;
      FClassForm.RecID := spRead.FieldByName(FKeyFieldList).AsInteger;
      FClassForm.RecIDStr := '';
    end;
    FClassForm.OpenMode := omUpdate;
    if FClassForm.ShowModal = mrOk then
    begin
      aRefresh.Execute;
      if ActiveTVControl.Controller.FocusedRow <> Nil then begin
        if ActiveTVControl.Controller.SelectedRowCount > 0 then
          ActiveTVControl.Controller.SelectedRows[0].Selected := False;
        ActiveTVControl.Controller.FocusedRow.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBListForm.UpdData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBListForm.DelData;
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  {Вначале должен вызываться метод потомка, задающий вопрос об удалении,
   затем потомок должен вызвать этот (inherited)}
  try
    with spDel do begin
      if not spDel.Transaction.InTransaction then
        spDel.Transaction.StartTransaction;

      if FKeyFieldIsStr then
        ParamByName(FKeyFieldClass).AsString := spRead.FieldByName(FKeyFieldList).AsString
      else
        ParamByName(FKeyFieldClass).AsInteger := spRead.FieldByName(FKeyFieldList).AsInteger;

      ExecProc;

      if FieldIndex['ERR_CODE'] >= 0 then begin
        ErrCode := ParamByName('ERR_CODE').AsInteger;
        if ErrCode <> 0 then begin
          if spDel.Transaction.InTransaction then
            spDel.Transaction.Rollback;
          if FieldIndex['ERR_MSG'] >= 0 then begin
            ErrMsg := ParamByName('ERR_MSG').AsString;
            DBErrorHandler(ErrCode, ErrMsg);
          end
          else
            MessageDlg('Error code: ' + IntToStr(ErrCode)
               + #13#10'(occured in TDBListForm.DelData)', mtInformation, [mbOK], 0);
          Exit;
        end;
      end;

      if spDel.Transaction.InTransaction then
        spDel.Transaction.Commit;
    end;
    aRefresh.Execute;
  except
    on E: EFIBError do begin
      if spDel.Transaction.InTransaction then
        spDel.Transaction.Rollback;
      if (POS('deadlock', LowerCase(E.Message)) > 0) or (POS('update conflicts with concurrent update', LowerCase(E.Message)) > 0) then
        MessageDlg('Запись в данный момент редактируется другим пользователем и доступна только для просмотра!', mtInformation, [mbOk], 0)
      else
        DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBListForm.DelData)');
    end;
    on E: Exception do begin
      if spDel.Transaction.InTransaction then
        spDel.Transaction.Rollback;
      MessageDlg(E.Message + #13#10'(occured in TDBListForm.DelData)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDBListForm.aViewExecute(Sender: TObject);
begin
  if not aView.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_VIEWREC, 0, 0);
end;

procedure TDBListForm.WMViewRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  ViewData;
end;

procedure TDBListForm.aInsExecute(Sender: TObject);
begin
  if not aIns.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_INSREC, 0, 0);
end;

procedure TDBListForm.WMInsRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  InsData;
end;

procedure TDBListForm.aInsLikeExecute(Sender: TObject);
begin
  if not aInsLike.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_INSLIKEREC, 0, 0);
end;

procedure TDBListForm.atestExecute(Sender: TObject);
begin
  inherited;
  ShowMessage('asdfasdf');
end;

procedure TDBListForm.WMInsLikeRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  InsLikeData;
end;

procedure TDBListForm.aUpdExecute(Sender: TObject);
begin
  if not aUpd.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_UPDREC, 0, 0);
end;

procedure TDBListForm.WMUpdRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  UpdData;
end;

procedure TDBListForm.aDelExecute(Sender: TObject);
begin
  if not aDel.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_DELREC, 0, 0);
end;

procedure TDBListForm.WMDelRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;

  DelData;
end;

procedure TDBListForm.FormShow(Sender: TObject);
begin
  inherited;
  //прописываем русский язык
  aView.Caption := 'Просмотреть';
  aView.Hint  := 'Просмотреть|Просмотр записи';
  aIns.Caption  := 'Добавить';
  aIns.Hint := 'Добавить|Добавление записи';
  aInsLike.Caption := 'Добавить копию';
  aInsLike.Hint := 'Добавить копию|Добавление копии записи';
  aUpd.Caption := 'Изменить';
  aUpd.Hint := 'Изменить|Изменение записи';
  aDel.Caption := 'Удалить';
  aDel.Hint := 'Удалить|Удаление записи';
  aHelp.Hint := 'Помощь | Вызов справки';
end;

procedure TDBListForm.aHelpExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_HELPME, 0, 0);
end;

procedure TDBListForm.WMHelpMe(var Message: TMessage);
begin
  Application.HelpContext(FHelpC);
end;

end.
