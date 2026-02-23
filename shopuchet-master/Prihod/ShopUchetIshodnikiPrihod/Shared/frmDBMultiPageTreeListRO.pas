unit frmDBMultiPageTreeListRO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, dxBar, Menus, ExtCtrls, Db,
  dxBarExtItems, Registry, Variants, cxPC, cxControls, FIB, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery,
  pFIBStoredProc, frmMDIChild, unCommonFunc, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinsdxBarPainter, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxTLData, cxDBTL, cxClasses, dxBarBuiltInMenu,
  System.Actions, System.UITypes, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TDBMultiPageTreeListROForm = class(TMDIChildForm)
    dxPageControl: TcxPageControl;
    ts1: TcxTabSheet;
    dxBarButtonEnableAutoRefresh: TdxBarButton;
    dxBarStaticRecCnt: TdxBarStatic;
    dxBarButtonClose: TdxBarButton;
    dxBarButtonRefresh: TdxBarButton;
    aEnableAutoRefresh: TAction;
    aRefresh: TAction;
    aClose: TAction;
    aExpand: TAction;
    aCollapse: TAction;
    aCustomizeColumns: TAction;
    dsRead: TDataSource;
    tAutoRefresh: TTimer;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    tranRead: TpFIBTransaction;
    spRead: TpFIBDataSet;
    tlMain: TcxDBTreeList;
    procedure aEnableAutoRefreshExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aExpandExecute(Sender: TObject);
    procedure aCollapseExecute(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tAutoRefreshTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FActiveDataset      : TpFIBDataSet;
    FActiveListControl  : TcxDBTreeList;

    FtbButtonsStyle: TtbButtonsStyle;
    FAutoRefresh: Integer;
    procedure GetButtonsStyle;
    procedure WMSetupChanged(var Message: TMessage); message WM_SETUPCHANGED;
    procedure WMRefresh(var Message: TMessage); message WM_REFRESH;
  protected
    procedure ReadList; virtual;
    procedure SetButtonsStyle; virtual;
    function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean; virtual;
    function ExecSP(SP: TpFIBStoredProc): Boolean; virtual;
  public
    property AutoRefresh: Integer read FAutoRefresh;
    property ActiveDataset  : TpFIBDataSet read FActiveDataset write FActiveDataset default nil;
    property ActiveListControl  : TcxDBTreeList read FActiveListControl write FActiveListControl default nil;
  end;

var
  DBMultiPageTreeListROForm: TDBMultiPageTreeListROForm;

implementation

uses dmMain, unErrorHandlers, unInitApp;

{$R *.DFM}

procedure TDBMultiPageTreeListROForm.FormCreate(Sender: TObject);
begin
  inherited;
  FActiveDataset      := spRead; {Эти два поля должны изменяться в OnChange потомка}
  FActiveListControl  := tlMain;
end;

procedure TDBMultiPageTreeListROForm.FormShow(Sender: TObject);
begin
  inherited;
  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;

  dxBarButtonEnableAutoRefresh.Down := True;
  aRefresh.Execute;
end;

procedure TDBMultiPageTreeListROForm.aEnableAutoRefreshExecute(Sender: TObject);
begin
  inherited;
  tAutoRefresh.Enabled := not tAutoRefresh.Enabled;
end;

procedure TDBMultiPageTreeListROForm.WMSetupChanged(var Message: TMessage);
begin
  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;
  inherited;
end;

procedure TDBMultiPageTreeListROForm.GetButtonsStyle;
var
  Reg: TRegistry;
begin
  try
    Reg := TRegistry.Create;
    try
      with Reg do begin
        RootKey := RegSetupRoot;
        LazyWrite := False;  {Сохраняем ключи до закрытия}
        if OpenKey(RegSetupKey, True) then
          try
            {if ValueExists('tbButtonsStyle') then
              FtbButtonsStyle := TtbButtonsStyle(ReadInteger('tbButtonsStyle'))
            else begin }
              FtbButtonsStyle := bsGlyphText;
            {  WriteInteger('tbButtonsStyle', Integer(FtbButtonsStyle));
            end; }
            {----------------------------}
            if ValueExists('AutoRefresh') then
              FAutoRefresh := ReadInteger('AutoRefresh')
            else begin
              FAutoRefresh := 5;
              WriteInteger('AutoRefresh', FAutoRefresh);
            end;
            {----------------------------}
          finally
            CloseKey;
          end;
      end;
    finally
      Reg.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListROForm.GetButtonsStyle)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageTreeListROForm.SetButtonsStyle;
var
  i: Integer;
begin
  with dxBarManagerChild do
    for i := 0 to ItemCount - 1 do
      if Items[i] is TdxBarButton then
        case FtbButtonsStyle of
          bsText: (Items[i] as TdxBarButton).PaintStyle := psCaption;
          bsGlyphText: (Items[i] as TdxBarButton).PaintStyle := psCaptionGlyph;
          bsGlyph: (Items[i] as TdxBarButton).PaintStyle := dxBar.psStandard;
        end;
end;

procedure TDBMultiPageTreeListROForm.ReadList;
var
  ErrCode: Integer;
  ErrMsg : String;
  BM : TBookMark;
begin
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
                 + #13#10'(occured in TDBMultiPageTreeListROForm.ReadList)', mtInformation, [mbOK], 0);
            Exit;
          end;
        end;

        if BM <> Nil then
          if BookmarkValid(BM) then
            try
              GotoBookmark(BM);
            except
            end;

        if Assigned(tlMain.FocusedNode) then
          tlMain.FocusedNode.Selected := True;
      finally
        if BM <> Nil then
          FreeBookmark(BM);
        Screen.Cursor := crDefault;
      end;

      dxBarStaticRecCnt.Caption := Format('%d', [AllRecordCount]);
    end;
  except
    on E: EFIBError do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBMultiPageTreeListROForm.ReadList)');
    end;
    on E: Exception do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListROForm.ReadList)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDBMultiPageTreeListROForm.tAutoRefreshTimer(Sender: TObject);
begin
  inherited;
  if Self.Active then {Обновляем только активную в данный момент форму}
    aRefresh.Execute;
end;

procedure TDBMultiPageTreeListROForm.aRefreshExecute(Sender: TObject);
begin
  {Здесь и далее используем PostMessage вместо непосредственного выполнения кода,
   необходимого для данной операции, т.к. иначе постоянно возникают AccessViolation
   в TdxBar}
  PostMessage(Self.Handle, WM_REFRESH, 0, 0);
end;

procedure TDBMultiPageTreeListROForm.WMRefresh(var Message: TMessage);
begin
  Screen.Cursor := crHourGlass;
  try
    Repaint;

    if not MainDM.dbMain.Connected then
      Exit;

    tAutoRefresh.Enabled := False;

    ReadList;

    if FAutoRefresh > 0 then
    begin
      tAutoRefresh.Interval := FAutoRefresh * 1000 * 60;
      if dxBarButtonEnableAutoRefresh.Down then
        tAutoRefresh.Enabled := True
      else
        tAutoRefresh.Enabled := False;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TDBMultiPageTreeListROForm.OpenSP(SP: TpFIBDataSet;
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
                 + #13#10'(occured in TDBMultiPageTreeListROForm.OpenSP)', mtInformation, [mbOK], 0);
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBMultiPageTreeListROForm.OpenSP)');
    end;
    on E: Exception do begin
      if SP.Transaction.InTransaction then
        SP.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageTreeListROForm.OpenSP)', mtError, [mbOk], 0);
    end;
  end;
end;

function TDBMultiPageTreeListROForm.ExecSP(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;

  with SP do begin
    ExecProc;

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
             + #13#10'(occured in TDBMultiPageTreeListROForm.ExecSP)', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

{procedure TDBMultiPageTreeListROForm.dxDBTreeListGetImageIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
const
  RootImageIndex  = 91;
  ChildImageIndex = 95;
begin
  inherited;

  if Node.HasChildren then
  begin
    Index := RootImageIndex;
    if Node.Expanded then
      Inc(Index);
  end
  else
    Index := ChildImageIndex;

  if aoHotTrack in (Sender as TdxDBTreeList).OptionsEx then begin
    if Node = (Sender as TdxDBTreeList).HotTrackInfo.Node then
      if Node.HasChildren then
        Inc(Index, 2)
      else
        Inc(Index);
  end;
end;

procedure TDBMultiPageTreeListROForm.dxDBTreeListGetSelectedIndex(Sender: TObject;
  Node: TdxTreeListNode; var Index: Integer);
const
  RootImageIndex  = 91;
  ChildImageIndex = 95;
begin
  inherited;
  if Node.HasChildren then
  begin
    Index := RootImageIndex;
    if Node.Expanded then
      Inc(Index);
  end
  else
    Index := ChildImageIndex;

  if aoHotTrack in (Sender as TdxDBTreeList).OptionsEx then begin
    if Node = (Sender as TdxDBTreeList).HotTrackInfo.Node then
      if Node.HasChildren then
        Inc(Index, 2)
      else
        Inc(Index);
  end;
end;

procedure TDBMultiPageTreeListROForm.dxDBTreeListHotTrackNode(Sender: TObject;
  AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor);
begin
  inherited;
  if (AHotTrackInfo.Node <> nil) and not (AHotTrackInfo.Node.HasChildren) then
    ACursor := crdxHandPointCursor;
end;}

procedure TDBMultiPageTreeListROForm.aCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TDBMultiPageTreeListROForm.aExpandExecute(Sender: TObject);
begin
  inherited;
  ActiveListControl.FullExpand;
end;

procedure TDBMultiPageTreeListROForm.aCollapseExecute(Sender: TObject);
begin
  inherited;
  ActiveListControl.FullCollapse;
end;

procedure TDBMultiPageTreeListROForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  inherited;
  ActiveListControl.Customizing.Visible := True;
end;

end.
