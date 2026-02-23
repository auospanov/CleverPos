unit frmDBMultiPageList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frmDBMultiPageListRO, Db, ExtCtrls, Menus, ActnList, dxBar,
  dxBarExtDBItems, dxBarExtItems,
  cxPC, frmDBEdit, unCommonFunc, cxControls, FIB, FIBQuery,
  pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet,
  pFIBDataSet, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, dxSkinsdxBarPainter, cxClasses, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, System.UITypes, dxBarBuiltInMenu, cxNavigator, System.Actions,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TDBMultiPageListForm = class(TDBMultiPageListROForm)
    aView: TAction;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    dxBarButtonView: TdxBarButton;
    dxBarButtonIns: TdxBarButton;
    dxBarButtonUpd: TdxBarButton;
    dxBarButtonDel: TdxBarButton;
    aInsLike: TAction;
    dxBarButton1: TdxBarButton;
    tranWrite: TpFIBTransaction;
    spDel: TpFIBStoredProc;
    aHelp: TAction;
    dxBarButton2: TdxBarButton;
    procedure aViewExecute(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aInsLikeExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
  private
    FKeyFieldIsStr: Boolean;
    FClassForm: TDBEditForm;
    FKeyFieldList : String;
    FKeyFieldClass : String;
    FHelpC : Integer;
    procedure WMViewRec(var Message: TMessage); message WM_VIEWREC;
    procedure WMInsRec(var Message: TMessage); message WM_INSREC;
    procedure WMInsLikeRec(var Message: TMessage); message WM_INSLIKEREC;
    procedure WMUpdRec(var Message: TMessage); message WM_UPDREC;
    procedure WMDelRec(var Message: TMessage); message WM_DELREC;
    procedure WMHelp(var Message: TMessage); message WM_HELPME;
  protected
    procedure ViewData; virtual;
    procedure InsData; virtual;
    procedure InsLikeData; virtual;
    procedure UpdData; virtual;
    procedure DelData; virtual;
  public
    property ClassForm: TDBEditForm read FClassForm write FClassForm;
    property KeyFieldList: String read FKeyFieldList write FKeyFieldList;
    property KeyFieldClass: String read FKeyFieldClass write FKeyFieldClass;
    property HelpC : integer read FHelpC write FHelpC default 0;
  end;

implementation

uses dmMain, unErrorHandlers;

{$R *.DFM}

procedure TDBMultiPageListForm.ViewData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  FClassForm.KeyField := FKeyFieldClass;
  if FKeyFieldIsStr then begin
    FClassForm.KeyFieldIsStr := True;
    FClassForm.RecIDStr := ActiveDataSet.FieldByName(FKeyFieldList).AsString;
    FClassForm.RecID := 0;
  end
  else begin
    FClassForm.KeyFieldIsStr := False;
    FClassForm.RecID := ActiveDataSet.FieldByName(FKeyFieldList).AsInteger;
    FClassForm.RecIDStr := '';
  end;

  FClassForm.OpenMode := omView;
  FClassForm.ShowModal;
end;

procedure TDBMultiPageListForm.InsData;
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
        ActiveDataSet.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        ActiveDataSet.Locate(FKeyFieldList, FClassForm.RecID, []);

      if ActiveTVControl.Controller.FocusedRow <> Nil then begin
        if ActiveTVControl.Controller.SelectedRowCount > 0 then
          ActiveTVControl.Controller.SelectedRows[0].Selected := False;
        ActiveTVControl.Controller.FocusedRow.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageListForm.InsData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageListForm.InsLikeData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then begin
      FClassForm.KeyFieldIsStr := True;
      FClassForm.RecIDStr := ActiveDataSet.FieldByName(FKeyFieldList).AsString;
      FClassForm.RecID := 0;
    end
    else begin
      FClassForm.KeyFieldIsStr := False;
      FClassForm.RecID := ActiveDataSet.FieldByName(FKeyFieldList).AsInteger;
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
        ActiveDataSet.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        ActiveDataSet.Locate(FKeyFieldList, FClassForm.RecID, []);

      if ActiveTVControl.Controller.FocusedRow <> Nil then begin
        if ActiveTVControl.Controller.SelectedRowCount > 0 then
          ActiveTVControl.Controller.SelectedRows[0].Selected := False;
        ActiveTVControl.Controller.FocusedRow.Selected := True;
      end;
    end;  
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageListForm.InsLikeData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageListForm.UpdData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then begin
      FClassForm.KeyFieldIsStr := True;
      FClassForm.RecIDStr := ActiveDataSet.FieldByName(FKeyFieldList).AsString;
      FClassForm.RecID := 0;
    end
    else begin
      FClassForm.KeyFieldIsStr := False;
      FClassForm.RecID := ActiveDataSet.FieldByName(FKeyFieldList).AsInteger;
      FClassForm.RecIDStr := '';
    end;

    FClassForm.OpenMode := omUpdate;
    if FClassForm.ShowModal = mrOk then begin
      aRefresh.Execute;
      if ActiveTVControl.Controller.FocusedRow <> Nil then begin
        if ActiveTVControl.Controller.SelectedRowCount > 0 then
          ActiveTVControl.Controller.SelectedRows[0].Selected := False;
        ActiveTVControl.Controller.FocusedRow.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageListForm.UpdData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageListForm.DelData;
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
               + #13#10'(occured in TDBMultiPageListForm.DelData)', mtInformation, [mbOK], 0);
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
        DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBMultiPageListForm.DelData)');
    end;
    on E: Exception do begin
      if spDel.Transaction.InTransaction then
        spDel.Transaction.Rollback;
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageListForm.DelData)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDBMultiPageListForm.aViewExecute(Sender: TObject);
begin
  if not aView.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_VIEWREC, 0, 0);
end;

procedure TDBMultiPageListForm.WMViewRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  ViewData;
end;

procedure TDBMultiPageListForm.aInsExecute(Sender: TObject);
begin
  if not aIns.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_INSREC, 0, 0);
end;

procedure TDBMultiPageListForm.WMInsRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  InsData;
end;

procedure TDBMultiPageListForm.aInsLikeExecute(Sender: TObject);
begin
  if not aInsLike.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_INSLIKEREC, 0, 0);
end;

procedure TDBMultiPageListForm.WMInsLikeRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  InsLikeData;
end;

procedure TDBMultiPageListForm.aUpdExecute(Sender: TObject);
begin
  if not aUpd.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_UPDREC, 0, 0);
end;

procedure TDBMultiPageListForm.WMUpdRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  UpdData;
end;

procedure TDBMultiPageListForm.aDelExecute(Sender: TObject);
begin
  if not aDel.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_DELREC, 0, 0);
end;

procedure TDBMultiPageListForm.WMDelRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;

  DelData;
end;

procedure TDBMultiPageListForm.aHelpExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_HELPME, 0, 0);
end;

procedure TDBMultiPageListForm.WMHelp(var Message: TMessage);
begin
  Application.HelpContext(FHelpC);
end;

end.
