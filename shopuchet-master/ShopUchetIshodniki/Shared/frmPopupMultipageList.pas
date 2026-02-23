unit frmPopupMultipageList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ImgList, Variants,
  ActnList, Menus, StdCtrls, Buttons, ExtCtrls, frmdbEdit,
  cxPC, cxControls, FIB, FIBDataSet, pFIBDataSet, FIBDatabase,
  pFIBDatabase, unCommonFunc, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxDropDownEdit, System.UITypes, dxBarBuiltInMenu, cxNavigator,
  System.Actions, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TPopupMultipageListForm = class(TForm)
    dsRead: TDataSource;
    PopupMenu: TPopupMenu;
    ActionList: TActionList;
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
    btnInsLike: TBitBtn;
    dxPageControl: TcxPageControl;
    ts1: TcxTabSheet;
    aCustomizeColumns: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    tranRead: TpFIBTransaction;
    spRead: TpFIBDataSet;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aInsLikeExecute(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure tvMainDblClick(Sender: TObject);
    procedure tvMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FRecID: Int64;
    FRecIDStr: String;
    FClassForm: TDBEditForm;
    FKeyFieldList : String;
    FKeyFieldClass : String;
    FKeyFieldIsStr: Boolean;
    FSelectedFieldName: String;
    FSelectedID: Int64;
    FSelectedIDStr: String;
    FSelectedFieldIsStr: Boolean;
    FAcceptRes : Boolean;
    procedure WMBestAlign(var Message: TMessage); message WM_BESTALIGN;
  protected
    procedure ClosePopupForm(Sender : TObject);
    procedure ReadList; virtual;
    procedure InsData; virtual;
    procedure InsLikeData; virtual;
  public
    property RecID: Int64 read FRecID write FRecID default 0;
    property RecIDStr: String read FRecIDStr write FRecIDStr;
    property ClassForm: TDBEditForm read FClassForm write FClassForm;
    property KeyFieldList: String read FKeyFieldList write FKeyFieldList;
    property KeyFieldClass: String read FKeyFieldClass write FKeyFieldClass;
    property KeyFieldIsStr: Boolean read FKeyFieldIsStr write FKeyFieldIsStr default False;
    property SelectedFieldName: String read FSelectedFieldName write FSelectedFieldName;
    property SelectedID: Int64 read FSelectedID write FSelectedID;
    property SelectedIDStr: String read FSelectedIDStr write FSelectedIDStr;
    property SelectedFieldIsStr: Boolean read FSelectedFieldIsStr write FSelectedFieldIsStr default false;
    property AcceptRes: Boolean read FAcceptRes write FAcceptRes default false;
  end;

implementation

uses dmMain, unErrorHandlers;

{$R *.DFM}

procedure TPopupMultipageListForm.ClosePopupForm(Sender : TObject);
var
  PopupForm: TCustomForm;
begin
  PopupForm := GetParentForm(TControl(Sender));
  if PopupForm is TcxCustomEditPopupWindow then
    (PopupForm as TcxCustomEditPopupWindow).Edit.DroppedDown := False;
end;

procedure TPopupMultipageListForm.btnOkClick(Sender: TObject);
begin
  //if dxPageControl.ActivePageIndex = 0 then begin
    if KeyFieldIsStr then begin
      if spRead.FieldByName(KeyFieldList).AsString = '' then
        Exit;
    end
    else begin
      if spRead.FieldByName(KeyFieldList).AsLargeInt < 1 then
        Exit;
    end;

    if (tvMain.Controller.FocusedRow <> Nil) then begin
      if FSelectedFieldIsStr then
        FSelectedIDStr := spRead.FieldByName('ID').AsString
      else
        FSelectedID := spRead.FieldByName('ID').AsLargeInt;
      AcceptRes := True;
    end;

    ClosePopupForm(Sender);
  //end;
end;

procedure TPopupMultipageListForm.btnCancelClick(Sender: TObject);
begin
  AcceptRes := False;
  ClosePopupForm(Sender);
end;

procedure TPopupMultipageListForm.WMBestAlign(var Message: TMessage);
//var
  //PopupEditForm: TdxPopupEditForm;
  //PopupEditFormOwnerControl: TdxInplaceEdit;
  //DeltaY: Integer;
  //Rect : PRect;
  //Ret  : BOOL;
begin
  {if pnlMain.Parent is TdxPopupEditForm then begin
    PopupEditForm := pnlMain.Parent as TdxPopupEditForm;

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

      //Определяем, куда выпали
      PopupEditFormOwnerControl := PopupEditForm.OwnerControl;
      if PopupEditForm.Top < PopupEditFormOwnerControl.Top then begin
        //Выпали вверх
        if PopupEditForm.Top < Rect^.Top then begin
          DeltaY := -PopupEditForm.Top;
          PopupEditForm.Top := Rect^.Top;
          PopupEditForm.Height := PopupEditForm.Height - DeltaY;
        end
      end
      else begin
        //Выпали вниз
        if PopupEditForm.Top + PopupEditForm.Height > (Rect^.Bottom - Rect^.Top) then begin
          PopupEditForm.Height := (Rect^.Bottom - Rect^.Top) - PopupEditForm.Top;
        end;
      end;
    finally
      dispose(Rect);
    end;
    dxDBGrid.SetFocus;  {Для удобства работы клавиатурой
  end; }
end;

procedure TPopupMultipageListForm.ReadList;
var
  ErrCode: Integer;
  ErrMsg : String;
  BM : TBookMark;
begin
//  dxDBGrid.HighlightColor := dxDBGrid.Color;
//  dxDBGrid.HighlightTextColor := dxDBGrid.Font.Color;

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
                 + #13#10'(occured in TPopupMultipageListForm.ReadList)', mtInformation, [mbOK], 0);
            Exit;
          end;
        end;

        if BM <> Nil then
          if BookmarkValid(BM) then
            try
              GotoBookmark(BM);
            except
            end;

        if Assigned(tvMain.Controller.FocusedRow) then
          tvMain.Controller.FocusedRow.Selected := True;
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TPopupMultipageListForm.ReadList)');
    end;
    on E: Exception do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TPopupMultipageListForm.ReadList)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TPopupMultipageListForm.tvMainDblClick(Sender: TObject);
begin
  btnOkClick(btnOk);
end;

procedure TPopupMultipageListForm.tvMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ClosePopupForm(Sender);
  if Key = VK_RETURN then
    btnOkClick(nil);
end;

procedure TPopupMultipageListForm.InsData;
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
      ReadList;

{----}
      {Курсор на новую запись}
      if FKeyFieldIsStr then
        spRead.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
      else
        spRead.Locate(FKeyFieldList, FClassForm.RecID, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TPopupMultipageListForm.InsData)', mtInformation, [mbOk], 0);
  end;
end;

procedure TPopupMultipageListForm.InsLikeData;
begin
  {Вначале должен вызываться метод потомка, создающий форму класса,
   затем потомок должен вызвать этот метод (inherited)}
  if dxPageControl.ActivePageIndex = 0 then begin
    try
      FClassForm.KeyField := FKeyFieldClass;
      if FKeyFieldIsStr then begin
        FClassForm.KeyFieldIsStr := True;
        FClassForm.RecIDStr := spRead.FieldByName(FKeyFieldList).AsString;
        FClassForm.RecID := 0;
      end
      else begin
        FClassForm.KeyFieldIsStr := False;
        FClassForm.RecID := spRead.FieldByName(FKeyFieldList).AsLargeInt;
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

        ReadList;

  {----}
        {Курсор на новую запись}
        if FKeyFieldIsStr then
          spRead.Locate(FKeyFieldList, FClassForm.RecIDStr, [])
        else
          spRead.Locate(FKeyFieldList, FClassForm.RecID, []);
        if tvMain.Controller.FocusedRow <> Nil then begin
          if tvMain.Controller.SelectedRowCount > 0 then
            tvMain.Controller.SelectedRows[0].Selected := False;
          tvMain.Controller.FocusedRow.Selected := True;
        end;
      end;
    except
      on E: Exception do
        MessageDlg(E.Message + #13#10'(occured in TPopupMultipageListForm.InsLikeData)', mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TPopupMultipageListForm.aRefreshExecute(Sender: TObject);
begin
  ReadList;
end;

procedure TPopupMultipageListForm.aInsExecute(Sender: TObject);
begin
  InsData;
end;

procedure TPopupMultipageListForm.aInsLikeExecute(Sender: TObject);
begin
  InsLikeData;
end;

procedure TPopupMultipageListForm.aCustomizeColumnsExecute(
  Sender: TObject);
begin
  tvMain.Controller.Customization := True;
end;

end.
