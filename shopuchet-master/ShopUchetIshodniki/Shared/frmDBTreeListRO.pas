unit frmDBTreeListRO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, dxBar, Db,
  ExtCtrls, Registry, Variants, dxBarExtItems,
  Menus, FIB, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase,
  FIBQuery, pFIBQuery, pFIBStoredProc, frmMDIChild, unCommonFunc, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinsdxBarPainter, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxTLData, cxDBTL, cxClasses, cxImage, ImgList,
  System.Actions, System.UITypes, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TDBTreeListROForm = class(TMDIChildForm)
    aEnableAutoRefresh: TAction;
    dxBarButtonEnableAutoRefresh: TdxBarButton;
    tAutoRefresh: TTimer;
    dxBarStaticRecCnt: TdxBarStatic;
    aRefresh: TAction;
    aClose: TAction;
    dxBarButtonClose: TdxBarButton;
    dxBarButtonRefresh: TdxBarButton;
    aExpand: TAction;
    aCollapse: TAction;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    aCustomizeColumns: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    tranRead: TpFIBTransaction;
    tlMain: TcxDBTreeList;
    spRead: TpFIBDataSet;
    dsRead: TDataSource;
    procedure aEnableAutoRefreshExecute(Sender: TObject);
    procedure tAutoRefreshTimer(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aExpandExecute(Sender: TObject);
    procedure aCollapseExecute(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tlMainGetNodeImageIndex(Sender: TcxCustomTreeList;
      ANode: TcxTreeListNode; AIndexType: TcxTreeListImageIndexType;
      var AIndex: TImageIndex);
    procedure tlMainHotTrackNode(Sender: TcxCustomTreeList;
      ANode: TcxTreeListNode; AShift: TShiftState; var ACursor: TCursor);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
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
  end;

implementation

uses dmMain, unErrorHandlers, unInitApp;

{$R *.DFM}

procedure TDBTreeListROForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  tlMain.StoreToIniFile('Settings_grid.ini', False, Self.Name + '-' + tlMain.name);
end;

procedure TDBTreeListROForm.FormShow(Sender: TObject);
begin
  inherited;
  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;

  dxBarButtonEnableAutoRefresh.Down := True;
  aRefresh.Execute;
end;

procedure TDBTreeListROForm.aEnableAutoRefreshExecute(Sender: TObject);
begin
  inherited;
  tAutoRefresh.Enabled := not tAutoRefresh.Enabled;
end;

procedure TDBTreeListROForm.WMSetupChanged(var Message: TMessage);
begin
  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;
	inherited;
end;

procedure TDBTreeListROForm.GetButtonsStyle;
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
            else begin}
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
      MessageDlg(E.Message + #13#10'(occured in TDBTreeListROForm.GetButtonsStyle)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBTreeListROForm.SetButtonsStyle;
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

procedure TDBTreeListROForm.ReadList;
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
                 + #13#10'(occured in TDBTreeListROForm.ReadList)', mtInformation, [mbOK], 0);
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBTreeListROForm.ReadList)');
    end;
    on E: Exception do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBTreeListROForm.ReadList)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDBTreeListROForm.tAutoRefreshTimer(Sender: TObject);
begin
  inherited;
  {Здесь и далее используем PostMessage вместо непосредственного выполнения кода,
   необходимого для данной операции, т.к. иначе постоянно возникают AccessViolation
   в TdxBar}
  PostMessage(Self.Handle, WM_REFRESH, 0, 0);
end;

procedure TDBTreeListROForm.aRefreshExecute(Sender: TObject);
begin
  {Здесь и далее используем PostMessage вместо непосредственного выполнения кода,
   необходимого для данной операции, т.к. иначе постоянно возникают AccessViolation
   в TdxBar}
  PostMessage(Self.Handle, WM_REFRESH, 0, 0);
end;

procedure TDBTreeListROForm.tlMainGetNodeImageIndex(
  Sender: TcxCustomTreeList; ANode: TcxTreeListNode;
  AIndexType: TcxTreeListImageIndexType; var AIndex: TImageIndex);
const
  RootImageIndex  = 91;
  ChildImageIndex = 95;
begin
  inherited;

  if ANode.HasChildren then
  begin
    AIndex := RootImageIndex;
    if ANode.Expanded then
      Inc(AIndex);
  end
  else
    AIndex := ChildImageIndex;

  {if ANode.HotTrack in (Sender as TcxDBTreeList).op .OptionsEx then begin
    if ANode = (Sender as TcxDBTreeList).HotTrackInfo.Node then}
    if ANode.HotTrack then
      if ANode.HasChildren then
        Inc(AIndex, 2)
      else
        Inc(AIndex);
  //end;
end;

procedure TDBTreeListROForm.tlMainHotTrackNode(Sender: TcxCustomTreeList;
  ANode: TcxTreeListNode; AShift: TShiftState; var ACursor: TCursor);
begin
  inherited;
  if (ANode <> nil) and not (ANode.HasChildren) then
    ACursor := crHandPoint;
end;

procedure TDBTreeListROForm.WMRefresh(var Message: TMessage);
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

function TDBTreeListROForm.OpenSP(SP: TpFIBDataSet;
  UseBookmark: Boolean): Boolean;
{Открывает хр. процедуру (Open). С try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
  BM: TBookmark;
begin
  {Параметры процедуры должны задаваться до вызова этого метода}
  Result := False;
  with SP do begin
    try
      if SP.Database.Connected then begin
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
                   + #13#10'(occured in TDBTreeListROForm.OpenSP)', mtInformation, [mbOK], 0);
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
        if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
          if SP.Database.Connected then begin
            MessageDlg(GetServerConnectError(e.Message), mtError, [mbOk], 0);
            SP.Database.Connected := False;
          end;
        end
        else begin
          if SP.Transaction.InTransaction then
            SP.Transaction.CommitRetaining;
          DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBTreeListROForm.OpenSP)');
        end;
      end;
      on E: Exception do begin
        if SP.Transaction.InTransaction then
          SP.Transaction.CommitRetaining;
        MessageDlg(E.Message + #13#10'(occured in TDBTreeListROForm.OpenSP)', mtError, [mbOk], 0);
      end;
    end;
  end;
end;

function TDBTreeListROForm.ExecSP(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;

  with SP do begin
    if SP.Database.Connected then begin
      try
        ExecProc;
      except
        on E: EFIBError do begin
          if pos('Unable to complete network request', e.IBMessage) > 0 then begin   // обрыв связи с сервером
            if SP.Database.Connected then begin
              MessageDlg(GetServerConnectError(e.Message), mtError, [mbOk], 0);
              SP.Database.Connected := False;
            end;
          end
          else begin
            if SP.Transaction.InTransaction then
              SP.Transaction.Rollback;
            if (POS('deadlock', LowerCase(E.Message)) > 0) or (POS('update conflicts with concurrent update', LowerCase(E.Message)) > 0) then
              MessageDlg('Запись в данный момент редактируется другим пользователем и доступна только для просмотра!', mtInformation, [mbOk], 0)
            else if POS('nol_exception', LowerCase(E.Message)) > 0 then BEGIN
              ErrMsg := Copy(E.Message, Pos('/R\', E.Message), Pos('/Q\', E.Message) - Pos('/R\', E.Message));
              DBErrorHandler(-20500, ErrMsg);
            end else
              MessageDlg('Ошибка № ' + IntToStr(E.SQLCode) + ':' + E.Message, mtError, [mbOk], 0);
          end;
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
               + #13#10'(occured in TDBTreeListROForm.ExecSP)', mtInformation, [mbOK], 0);
          Exit;
        end;
      end;
    end;
  end;

  Result := True;
end;

procedure TDBTreeListROForm.aCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TDBTreeListROForm.aExpandExecute(Sender: TObject);
begin
  inherited;
  tlMain.FullExpand;
end;

procedure TDBTreeListROForm.aCollapseExecute(Sender: TObject);
begin
  inherited;
  tlMain.FullCollapse;
end;

procedure TDBTreeListROForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  inherited;
  tlMain.Customizing.Visible := True;
end;

end.
