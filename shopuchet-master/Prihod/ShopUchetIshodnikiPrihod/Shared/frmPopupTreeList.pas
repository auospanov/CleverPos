unit frmPopupTreeList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ImgList, Variants,
  ActnList, Menus, StdCtrls, Buttons, ExtCtrls, frmdbTreeEdit, FIB,
  FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase, unCommonFunc, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles,
  cxTL, cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxInplaceContainer, cxTLData, cxDBTL, cxDropDownEdit, System.UITypes,
  System.Actions, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TPopupTreeListForm = class(TForm)
    dsRead: TDataSource;
    PopupMenu: TPopupMenu;
    ActionList: TActionList;
    aExpandAll: TAction;
    aCollapseAll: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    pnlMain: TPanel;
    pnlTop: TPanel;
    btnIns: TBitBtn;
    btnRefresh: TBitBtn;
    pnlBottom: TPanel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    aRefresh: TAction;
    aIns: TAction;
    stRecCnt: TStaticText;
    aInsLike: TAction;
    aInsChild: TAction;
    btnInsLike: TBitBtn;
    btnInsChild: TBitBtn;
    tranRead: TpFIBTransaction;
    spRead: TpFIBDataSet;
    btnUpd: TBitBtn;
    aUpd: TAction;
    dxDBTreeList: TcxDBTreeList;
    procedure dxDBTreeListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aExpandAllExecute(Sender: TObject);
    procedure aCollapseAllExecute(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aInsLikeExecute(Sender: TObject);
    procedure aInsChildExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
  private
    FRecID: Integer;
    FRecIDStr: String;
    FClassForm: TDBTreeEditForm;
    FParentKeyFieldList : String;
    FParentKeyFieldClass : String;
    FParentKeyFieldIsStr: Boolean;
    FKeyFieldList : String;
    FKeyFieldClass : String;
    FKeyFieldIsStr: Boolean;
    FSelectedFieldName: String;
    FSelectedID: Integer;
    FSelectedIDStr: String;
    FSelectedFieldIsStr: Boolean;
    FAllowSelectHasChildren: Boolean;
    //procedure WMBestAlign(var Message: TMessage); message WM_BESTALIGN;
  protected
    procedure ClosePopupForm(AControl: TControl; AAccept: Boolean);
    procedure ReadList; virtual;
    procedure InsData; virtual;
    procedure InsLikeData; virtual;
    procedure InsChildData; virtual;
    procedure UpdData; virtual;
  public
    property RecID: Integer read FRecID write FRecID default 0;
    property RecIDStr: String read FRecIDStr write FRecIDStr;
    property ClassForm: TDBTreeEditForm read FClassForm write FClassForm;
    property KeyFieldList: String read FKeyFieldList write FKeyFieldList;
    property KeyFieldClass: String read FKeyFieldClass write FKeyFieldClass;
    property KeyFieldIsStr: Boolean read FKeyFieldIsStr write FKeyFieldIsStr default False;
    property SelectedFieldName: String read FSelectedFieldName write FSelectedFieldName;
    property SelectedID: Integer read FSelectedID write FSelectedID;
    property SelectedIDStr: String read FSelectedIDStr write FSelectedIDStr;
    property SelectedFieldIsStr: Boolean read FSelectedFieldIsStr write FSelectedFieldIsStr default false;
    property ParentKeyFieldList: String read FParentKeyFieldList write FParentKeyFieldList;
    property ParentKeyFieldClass: String read FParentKeyFieldClass write FParentKeyFieldClass;
    property ParentKeyFieldIsStr: Boolean read FParentKeyFieldIsStr write FParentKeyFieldIsStr default False;
    property AllowSelectHasChildren: Boolean read FAllowSelectHasChildren write FAllowSelectHasChildren default False;
  end;

implementation

uses dmMain, unErrorHandlers, frmDBEdit;

{$R *.DFM}

procedure TPopupTreeListForm.ClosePopupForm(AControl: TControl;
  AAccept: Boolean);
begin
  if Assigned(dxDBTreeList.FocusedNode) then
    if FAllowSelectHasChildren then begin
      if FSelectedFieldIsStr then
        FSelectedIDStr := dxDBTreeList.FocusedNode.Values[dxDBTreeList.ColumnByName(FSelectedFieldName).ItemIndex]
      else
        FSelectedID := dxDBTreeList.FocusedNode.Values[dxDBTreeList.ColumnByName(FSelectedFieldName).ItemIndex];
    end
    else begin
      if not dxDBTreeList.FocusedNode.HasChildren then
        if FSelectedFieldIsStr then
          FSelectedIDStr := dxDBTreeList.FocusedNode.Values[dxDBTreeList.ColumnByName(FSelectedFieldName).ItemIndex]
        else
          FSelectedID := dxDBTreeList.FocusedNode.Values[dxDBTreeList.ColumnByName(FSelectedFieldName).ItemIndex];
    end;
{
  if (dxDBTreeList.FocusedNode <> nil) and (not dxDBTreeList.FocusedNode.HasChildren) then
    if FSelectedFieldIsStr then
      FSelectedIDStr := dxDBTreeList.FocusedNode.Strings[dxDBTreeList.ColumnByFieldName(FSelectedFieldName).Index]
    else
      FSelectedID := dxDBTreeList.FocusedNode.Values[dxDBTreeList.ColumnByFieldName(FSelectedFieldName).Index];
}
  {if GetParentForm(AControl) is TcxCustomEditPopupWindow then
    TcxCustomEditPopupWindow(GetParentForm(AControl)).ClosePopup(AAccept); }
end;

procedure TPopupTreeListForm.dxDBTreeListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ClosePopupForm(dxDBTreeList, False);
  if Key = VK_RETURN then
    btnOkClick(nil);
end;

procedure TPopupTreeListForm.btnOkClick(Sender: TObject);
begin
  if KeyFieldIsStr then begin
    if spRead.FieldByName(KeyFieldList).AsString = '' then
      Exit;
  end
  else begin
    if spRead.FieldByName(KeyFieldList).AsInteger < 1 then 
      Exit;
  end;

  if Assigned(dxDBTreeList.FocusedNode) then
    if FAllowSelectHasChildren then begin
      ClosePopupForm(dxDBTreeList, True);
    end
    else begin
      if not dxDBTreeList.FocusedNode.HasChildren then
        ClosePopupForm(dxDBTreeList, True);
    end;
{
  if (dxDBTreeList.FocusedNode <> nil)
    and not (dxDBTreeList.FocusedNode.HasChildren) then
    ClosePopupForm(dxDBTreeList, True);
}
end;

procedure TPopupTreeListForm.btnCancelClick(Sender: TObject);
begin
  ClosePopupForm(dxDBTreeList, False);
end;

procedure TPopupTreeListForm.aExpandAllExecute(Sender: TObject);
begin
  dxDBTreeList.FullExpand;
end;

procedure TPopupTreeListForm.aCollapseAllExecute(Sender: TObject);
begin
  dxDBTreeList.FullCollapse;
end;

{procedure TPopupTreeListForm.WMBestAlign(var Message: TMessage);
var
  PopupEditForm: TcxPopupEdit;
  PopupEditFormOwnerControl: TdxInplaceEdit;
  DeltaY: Integer;
  Rect : PRect;
  Ret  : BOOL;
begin
  if pnlMain.Parent is TcxPopupEdit then begin
    PopupEditForm := pnlMain.Parent as TcxPopupEdit;

    new(Rect);
    try
      Ret := SystemParametersInfo(SPI_GETWORKAREA, 0, Rect, 0);

      if not Ret then
        with Rect^ do begin
          Left   := 0;
          Top    := 0;
          Right  := Screen.Width;
          Bottom := Screen.Height;
        end;

      {Определяем, куда выпали}
    {  PopupEditFormOwnerControl := PopupEditForm.pa .OwnerControl;
      if PopupEditForm.Top < PopupEditFormOwnerControl.Top then begin
        {Выпали вверх}
    {    if PopupEditForm.Top < Rect^.Top then begin
          DeltaY := -PopupEditForm.Top;
          PopupEditForm.Top := Rect^.Top;
          PopupEditForm.Height := PopupEditForm.Height - DeltaY;
        end
      end
      else begin
        {Выпали вниз}
    {    if PopupEditForm.Top + PopupEditForm.Height > (Rect^.Bottom - Rect^.Top) then begin
          PopupEditForm.Height := (Rect^.Bottom - Rect^.Top) - PopupEditForm.Top;
        end;
      end;
    finally
      dispose(Rect);
    end;
    dxDBTreeList.SetFocus;  {Для удобства работы клавиатурой}
{  end;
end;}

procedure TPopupTreeListForm.ReadList;
var
  ErrCode: Integer;
  ErrMsg : String;
  BM : TBookMark;
begin
//  dxDBTreeList.HighlightColor := dxDBTreeList.Color;
//  dxDBTreeList.HighlightTextColor := dxDBTreeList.Font.Color;

  {В потомке при необходимости задаются параметры вызова хранимой процедуры,
  затем потомок должен вызвать этот метод (inherited)}
  try
    with spRead do begin
      BM := GetBookmark;
      Screen.Cursor := crSQLWait;  {Property SQLScreenCursor почему-то не работает}
      try
        Close;
        if spRead.Transaction.InTransaction then
          spRead.Transaction.CommitRetaining;
        Open;

        if Fields.FindField('ERR_CODE') <> Nil then begin
          if VarIsNull(FieldByName('ERR_CODE').Value) or (FieldByName('ERR_CODE').AsString = '') then
            ErrCode := 0
          else
            ErrCode := FieldByName('ERR_CODE').AsInteger;
          if ErrCode <> 0 then begin
            if spRead.Transaction.InTransaction then
              spRead.Transaction.CommitRetaining;
            if Fields.FindField('ERR_MSG').Index >= 0 then begin
              ErrMsg := FieldByName('ERR_MSG').AsString;
              DBErrorHandler(ErrCode, ErrMsg);
            end
            else
              MessageDlg('Error code: ' + IntToStr(ErrCode)
                 + #13#10'(occured in TPopupTreeListForm.ReadList)', mtInformation, [mbOK], 0);
            Exit;
          end;
        end;

        if BM <> Nil then
          if BookmarkValid(BM) then
            try
              GotoBookmark(BM);
            except
            end;

        if Assigned(dxDBTreeList.FocusedNode) then
          dxDBTreeList.FocusedNode.Selected := True;

        if FRecID > 0 then begin
          if FKeyFieldIsStr then
            spRead.Locate(FKeyFieldList, RecIDStr, [])
          else
            spRead.Locate(FKeyFieldList, RecID, []);
          if dxDBTreeList.FocusedNode <> Nil then begin
            if dxDBTreeList.SelectionCount > 0 then
              dxDBTreeList.Selections[0].Selected := False;
            dxDBTreeList.FocusedNode.Selected := True;
          end;
        end;
      finally
        if BM <> Nil then
          FreeBookmark(BM);
        Screen.Cursor := crDefault;
      end;

      stRecCnt.Caption := Format('%d', [AllRecordCount]);
    end;

    PostMessage(Self.Handle, WM_BESTALIGN, 0, 0);
  except
    on E: EFIBError do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TPopupTreeListForm.ReadList)');
    end;
    on E: Exception do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TPopupTreeListForm.ReadList)', mtError, [mbOk], 0);
    end;
  end;
end;

{procedure TPopupTreeListForm.dxDBTreeListGetImageIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
const
  RootImageIndex  = 91;
  ChildImageIndex = 95;
begin
  if Node.HasChildren then
  begin
    Index := RootImageIndex;
    if Node.Expanded then
      Inc(Index);
  end
  else
    Index := ChildImageIndex;

  if aoHotTrack in dxDBTreeList.OptionsEx then begin
    if Node = dxDBTreeList.HotTrackInfo.Node then
      if Node.HasChildren then
        Inc(Index, 2)
      else
        Inc(Index);
  end;
end;

procedure TPopupTreeListForm.dxDBTreeListGetSelectedIndex(
  Sender: TObject; Node: TdxTreeListNode; var Index: Integer);
const
  RootImageIndex  = 91;
  ChildImageIndex = 95;
begin
  if Node.HasChildren then
  begin
    Index := RootImageIndex;
    if Node.Expanded then
      Inc(Index);
  end
  else
    Index := ChildImageIndex;

  if aoHotTrack in dxDBTreeList.OptionsEx then begin
    if Node = dxDBTreeList.HotTrackInfo.Node then
      if Node.HasChildren then
        Inc(Index, 2)
      else
        Inc(Index);
  end;
end;

procedure TPopupTreeListForm.dxDBTreeListHotTrackNode(Sender: TObject;
  AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor);
begin
  if Assigned(AHotTrackInfo.Node) then
    if FAllowSelectHasChildren then begin
      ACursor := crdxHandPointCursor;
    end
    else begin
      if not AHotTrackInfo.Node.HasChildren then
        ACursor := crdxHandPointCursor;
    end;
{
  if (AHotTrackInfo.Node <> nil) and not (AHotTrackInfo.Node.HasChildren) then
    ACursor := crdxHandPointCursor;
}
//end;

procedure TPopupTreeListForm.InsData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then
      FClassForm.KeyFieldIsStr := True
    else
      FClassForm.KeyFieldIsStr := False;

    FClassForm.ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      FClassForm.ParentKeyFieldIsStr := True;
      FClassForm.ParentRecIDStr := spRead.FieldByName(FParentKeyFieldList).AsString;
      FClassForm.ParentRecID := 0;
    end
    else begin
      FClassForm.ParentKeyFieldIsStr := False;
      FClassForm.ParentRecID := spRead.FieldByName(FParentKeyFieldList).AsInteger;
      FClassForm.ParentRecIDStr := '';
    end;

    FClassForm.OpenMode := omInsert;
    if FClassForm.ShowModal = mrOk then begin
{----}
(*
      aRefresh.Execute;  {aRefresh здесь не подходит, т.к. WM_REFRESH
                          произойдет после Locate и курсор опять встанет на
                          строку, где был раньше}
*)
      ReadList;

{----}
      {Курсор на новую запись}
      if FKeyFieldIsStr then
        spRead.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        spRead.Locate(FKeyFieldList, FClassForm.RecID, []);
      if dxDBTreeList.FocusedNode <> Nil then begin
        if dxDBTreeList.SelectionCount > 0 then
          dxDBTreeList.Selections[0].Selected := False;
        dxDBTreeList.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TPopupTreeListForm.InsData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TPopupTreeListForm.InsLikeData;
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

    FClassForm.ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      FClassForm.ParentKeyFieldIsStr := True;
      FClassForm.ParentRecIDStr := spRead.FieldByName(FParentKeyFieldList).AsString;
      FClassForm.ParentRecID := 0;
    end
    else begin
      FClassForm.ParentKeyFieldIsStr := False;
      FClassForm.ParentRecID := spRead.FieldByName(FParentKeyFieldList).AsInteger;
      FClassForm.ParentRecIDStr := '';
    end;

    FClassForm.OpenMode := omInsertLike;
    if FClassForm.ShowModal = mrOk then begin
{----}
(*
      aRefresh.Execute;  {aRefresh здесь не подходит, т.к. WM_REFRESH
                          произойдет после Locate и курсор опять встанет на
                          строку, где был раньше}
*)

      ReadList;

{----}
      {Курсор на новую запись}
      if FKeyFieldIsStr then
        spRead.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        spRead.Locate(FKeyFieldList, FClassForm.RecID, []);
      if dxDBTreeList.FocusedNode <> Nil then begin
        if dxDBTreeList.SelectionCount > 0 then
          dxDBTreeList.Selections[0].Selected := False;
        dxDBTreeList.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TPopupTreeListForm.InsLikeData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TPopupTreeListForm.InsChildData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  try
    FClassForm.KeyField := FKeyFieldClass;
    if FKeyFieldIsStr then
      FClassForm.KeyFieldIsStr := True
    else
      FClassForm.KeyFieldIsStr := False;

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

    FClassForm.ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then
      FClassForm.ParentKeyFieldIsStr := True
    else
      FClassForm.ParentKeyFieldIsStr := False;

    FClassForm.ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      FClassForm.ParentKeyFieldIsStr := True;
      FClassForm.ParentRecIDStr := spRead.FieldByName(FKeyFieldList).AsString;
      FClassForm.ParentRecID := 0;
    end
    else begin
      FClassForm.ParentKeyFieldIsStr := False;
      FClassForm.ParentRecID := spRead.FieldByName(FKeyFieldList).AsInteger;
      FClassForm.ParentRecIDStr := '';
    end;

    FClassForm.OpenMode := omInsertChild;
    if FClassForm.ShowModal = mrOk then begin
{----}
(*
      aRefresh.Execute;  {aRefresh здесь не подходит, т.к. WM_REFRESH
                          произойдет после Locate и курсор опять встанет на
                          строку, где был раньше}
*)

      ReadList;

{----}
      {Курсор на новую запись}
      if FKeyFieldIsStr then
        spRead.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        spRead.Locate(FKeyFieldList, FClassForm.RecID, []);
      if dxDBTreeList.FocusedNode <> Nil then begin
        if dxDBTreeList.SelectionCount > 0 then
          dxDBTreeList.Selections[0].Selected := False;
        dxDBTreeList.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TPopupTreeListForm.InsChildData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TPopupTreeListForm.UpdData;
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

    FClassForm.ParentKeyField := FParentKeyFieldClass;
    if FParentKeyFieldIsStr then begin
      FClassForm.ParentKeyFieldIsStr := True;
      FClassForm.ParentRecIDStr := spRead.FieldByName(FParentKeyFieldList).AsString;
      FClassForm.ParentRecID := 0;
    end
    else begin
      FClassForm.ParentKeyFieldIsStr := False;
      FClassForm.ParentRecID := spRead.FieldByName(FParentKeyFieldList).AsInteger;
      FClassForm.ParentRecIDStr := '';
    end;

    FClassForm.OpenMode := omUpdate;
    if FClassForm.ShowModal = mrOk then
    begin
      aRefresh.Execute;
      if dxDBTreeList.FocusedNode <> Nil then
      begin
        if dxDBTreeList.SelectionCount > 0 then
          dxDBTreeList.Selections[0].Selected := False;
        dxDBTreeList.FocusedNode.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TPopupTreeListForm.UpdData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TPopupTreeListForm.aRefreshExecute(Sender: TObject);
begin
  ReadList;
end;

procedure TPopupTreeListForm.aInsExecute(Sender: TObject);
begin
  InsData;
end;

procedure TPopupTreeListForm.aInsLikeExecute(Sender: TObject);
begin
  InsLikeData;
end;

procedure TPopupTreeListForm.aInsChildExecute(Sender: TObject);
begin
  InsChildData;
end;

procedure TPopupTreeListForm.aUpdExecute(Sender: TObject);
begin
  UpdData;
end;

end.
