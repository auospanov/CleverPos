unit frmDBMultiPageTreeList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, ActnList, dxBar, dxBarExtItems,
  Menus, cxPC, frmDBEdit, cxControls, FIBQuery, FIB, pFIBQuery,
  pFIBStoredProc, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase,
  frmDBMultiPageTreeListRO, frmDBTreeEdit, unCommonFunc, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu, dxSkinsdxBarPainter,
  cxClasses, cxInplaceContainer, cxTLData, cxDBTL, System.UITypes,
  dxBarBuiltInMenu, System.Actions;

type
  TDBMultiPageTreeListForm = class(TDBMultiPageTreeListROForm)
    aView: TAction;
    aIns: TAction;
    aInsLike: TAction;
    aUpd: TAction;
    aDel: TAction;
    dxBarButtonDel: TdxBarButton;
    dxBarButtonIns: TdxBarButton;
    dxBarButtonInsLike: TdxBarButton;
    dxBarButtonUpd: TdxBarButton;
    dxBarButtonView: TdxBarButton;
    aInsChild: TAction;
    dxBarButtonInsChild: TdxBarButton;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    tranWrite: TpFIBTransaction;
    spDel: TpFIBStoredProc;
    procedure aViewExecute(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aInsLikeExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aInsChildExecute(Sender: TObject);
  private
    FClassForm: TDBEditForm;
    FParentKeyFieldList : String;
    FParentKeyFieldClass : String;
    FParentKeyFieldIsStr: Boolean;
    FKeyFieldList : String;
    FKeyFieldClass : String;
    FKeyFieldIsStr: Boolean;
    procedure WMViewRec(var Message: TMessage); message WM_VIEWREC;
    procedure WMInsRec(var Message: TMessage); message WM_INSREC;
    procedure WMInsLikeRec(var Message: TMessage); message WM_INSLIKEREC;
    procedure WMInsChild(var Message: TMessage); message WM_INSCHILD;
    procedure WMUpdRec(var Message: TMessage); message WM_UPDREC;
    procedure WMDelRec(var Message: TMessage); message WM_DELREC;
  protected
    procedure ViewData; virtual;
    procedure InsData; virtual;
    procedure InsLikeData; virtual;
    procedure InsChildData; virtual;
    procedure UpdData; virtual;
    procedure DelData; virtual;
  public
    property ClassForm: TDBEditForm read FClassForm write FClassForm;
    property KeyFieldList: String read FKeyFieldList write FKeyFieldList;
    property KeyFieldClass: String read FKeyFieldClass write FKeyFieldClass;
    property KeyFieldIsStr: Boolean read FKeyFieldIsStr write FKeyFieldIsStr default False;
    property ParentKeyFieldList: String read FParentKeyFieldList write FParentKeyFieldList;
    property ParentKeyFieldClass: String read FParentKeyFieldClass write FParentKeyFieldClass;
    property ParentKeyFieldIsStr: Boolean read FParentKeyFieldIsStr write FParentKeyFieldIsStr default False;
  end;

implementation

uses dmMain, unErrorHandlers;

{$R *.DFM}

procedure TDBMultiPageTreeListForm.aViewExecute(Sender: TObject);
begin
  if not aView.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_VIEWREC, 0, 0);
end;

procedure TDBMultiPageTreeListForm.WMViewRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  ViewData;
end;

procedure TDBMultiPageTreeListForm.ViewData;
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

  (FClassForm as TDBTreeEditForm).ParentKeyField := FParentKeyFieldClass;
  if FParentKeyFieldIsStr then begin
    (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := True;
    (FClassForm as TDBTreeEditForm).ParentRecIDStr := ActiveDataSet.FieldByName(FParentKeyFieldList).AsString;
    (FClassForm as TDBTreeEditForm).ParentRecID := 0;
  end
  else begin
    (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := False;
    (FClassForm as TDBTreeEditForm).ParentRecID := ActiveDataSet.FieldByName(FParentKeyFieldList).AsInteger;
    (FClassForm as TDBTreeEditForm).ParentRecIDStr := '';
  end;

  FClassForm.OpenMode := omView;
  FClassForm.ShowModal;
end;

procedure TDBMultiPageTreeListForm.InsData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then
      FClassForm.KeyFieldIsStr := True
    else
      FClassForm.KeyFieldIsStr := False;

    (FClassForm as TDBTreeEditForm).ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := True;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := ActiveDataSet.FieldByName(FParentKeyFieldList).AsString;
      (FClassForm as TDBTreeEditForm).ParentRecID := 0;
    end
    else begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := False;
      (FClassForm as TDBTreeEditForm).ParentRecID := ActiveDataSet.FieldByName(FParentKeyFieldList).AsInteger;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := '';
    end;

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

      if tlMain.FocusedNode <> Nil then begin
        if tlMain.SelectionCount > 0 then
          tlMain.Selections[0].Selected := False;
        tlMain.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListForm.InsData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageTreeListForm.InsLikeData;
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

    (FClassForm as TDBTreeEditForm).ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := True;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := ActiveDataSet.FieldByName(FParentKeyFieldList).AsString;
      (FClassForm as TDBTreeEditForm).ParentRecID := 0;
    end
    else begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := False;
      (FClassForm as TDBTreeEditForm).ParentRecID := ActiveDataSet.FieldByName(FParentKeyFieldList).AsInteger;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := '';
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

      if tlMain.FocusedNode <> Nil then begin
        if tlMain.SelectionCount > 0 then
          tlMain.Selections[0].Selected := False;
        tlMain.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListForm.InsLikeData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageTreeListForm.InsChildData;
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

    (FClassForm as TDBTreeEditForm).ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := True;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := ActiveDataSet.FieldByName(FKeyFieldList).AsString;
      (FClassForm as TDBTreeEditForm).ParentRecID := 0;
    end
    else begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := False;
      (FClassForm as TDBTreeEditForm).ParentRecID := ActiveDataSet.FieldByName(FKeyFieldList).AsInteger;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := '';
    end;

    FClassForm.OpenMode := omInsertChild;
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

      if tlMain.FocusedNode <> Nil then begin
        if tlMain.SelectionCount > 0 then
          tlMain.Selections[0].Selected := False;
        tlMain.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListForm.InsChildData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageTreeListForm.UpdData;
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

    (FClassForm as TDBTreeEditForm).ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := True;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := ActiveDataSet.FieldByName(FParentKeyFieldList).AsString;
      (FClassForm as TDBTreeEditForm).ParentRecID := 0;
    end
    else begin
      (FClassForm as TDBTreeEditForm).ParentKeyFieldIsStr := False;
      (FClassForm as TDBTreeEditForm).ParentRecID := ActiveDataSet.FieldByName(FParentKeyFieldList).AsInteger;
      (FClassForm as TDBTreeEditForm).ParentRecIDStr := '';
    end;

    FClassForm.OpenMode := omUpdate;
    if FClassForm.ShowModal = mrOk then begin
      aRefresh.Execute;
      if tlMain.FocusedNode <> Nil then begin
        if tlMain.SelectionCount > 0 then
          tlMain.Selections[0].Selected := False;
        tlMain.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListForm.UpdData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageTreeListForm.DelData;
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
               + #13#10'(occured in TDBMultiPageTreeListForm.DelData)', mtInformation, [mbOK], 0);
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBMultiPageTreeListForm.DelData)');
    end;
    on E: Exception do begin
      if spDel.Transaction.InTransaction then
        spDel.Transaction.Rollback;
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListForm.DelData)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDBMultiPageTreeListForm.aInsExecute(Sender: TObject);
begin
  if not aIns.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_INSREC, 0, 0);
end;

procedure TDBMultiPageTreeListForm.WMInsRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  InsData;
end;

procedure TDBMultiPageTreeListForm.aInsLikeExecute(Sender: TObject);
begin
  if not aInsLike.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_INSLIKEREC, 0, 0);
end;

procedure TDBMultiPageTreeListForm.WMInsLikeRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  InsLikeData;
end;

procedure TDBMultiPageTreeListForm.aInsChildExecute(Sender: TObject);
begin
  inherited;
  if not aInsChild.Enabled then
    Exit;

  PostMessage(Self.Handle, WM_INSCHILD, 0, 0);
end;

procedure TDBMultiPageTreeListForm.WMInsChild(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  InsChildData;
end;

procedure TDBMultiPageTreeListForm.aUpdExecute(Sender: TObject);
begin
  if not aUpd.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_UPDREC, 0, 0);
end;

procedure TDBMultiPageTreeListForm.WMUpdRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  UpdData;
end;

procedure TDBMultiPageTreeListForm.aDelExecute(Sender: TObject);
begin
  if not aDel.Enabled then
    Exit;
  inherited;
  PostMessage(Self.Handle, WM_DELREC, 0, 0);
end;

procedure TDBMultiPageTreeListForm.WMDelRec(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;

  DelData;
end;

end.
