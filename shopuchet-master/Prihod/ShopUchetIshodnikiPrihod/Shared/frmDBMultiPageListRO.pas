unit frmDBMultiPageListRO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ToolWin, ComCtrls, ExtCtrls, ActnList, Menus,
  dxBar, dxBarExtItems,
  Db, Registry, Variants, dxBarExtDBItems, cxPC, cxControls,
  FIB, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery,
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
  cxLookAndFeelPainters, cxClasses, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridExportLink, cxDBTL,
  dxBarBuiltInMenu, cxNavigator, System.Actions, System.UITypes,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TDBMultiPageListROForm = class(TMDIChildForm)
    dxPageControl1: TcxPageControl;
    ts1: TcxTabSheet;
    dsRead: TDataSource;
    dxBarStaticRecCnt: TdxBarStatic;
    dxBarButtonRefresh: TdxBarButton;
    aRefresh: TAction;
    aClose: TAction;
    dxBarButtonClose: TdxBarButton;
    pmGrid: TPopupMenu;
    dlgSave: TSaveDialog;
    aCustomizeColumns: TAction;
    aSaveAllToXLS: TAction;
    aSaveSelectedToXLS: TAction;
    pmCustomizeColumns: TMenuItem;
    pmDivider1: TMenuItem;
    pmSaveAllToXLS: TMenuItem;
    pmSaveSelectedToXLS: TMenuItem;
    tAutoRefresh: TTimer;
    aEnableAutoRefresh: TAction;
    dxBarButtonEnableAutoRefresh: TdxBarButton;
    dxBarSpinEditHeaderHeight: TdxBarSpinEdit;
    spRead: TpFIBDataSet;
    tranRead: TpFIBTransaction;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    procedure aRefreshExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure aSaveAllToXLSExecute(Sender: TObject);
    procedure aSaveSelectedToXLSExecute(Sender: TObject);
    procedure aEnableAutoRefreshExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dxBarSpinEditHeaderHeightButtonClick(Sender: TdxBarSpinEdit;
      Button: TdxBarSpinEditButton);
    procedure dxBarSpinEditHeaderHeightCurChange(Sender: TObject);
    procedure dxBarSpinEditHeaderHeightKeyPress(Sender: TObject;
      var Key: Char);
    procedure tAutoRefreshTimer(Sender: TObject);
  private
    FActiveDataset      : TpFIBDataSet;
    FActiveListControl  : TcxGrid;
    FActiveTVControl    : TcxGridDBTableView;

    FtbButtonsStyle: TtbButtonsStyle;
    FAutoRefresh: Integer;
    procedure GetButtonsStyle;
    procedure WMSetupChanged(var Message: TMessage); message WM_SETUPCHANGED;
    procedure WMRefresh(var Message: TMessage); message WM_REFRESH;
  protected
    function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean; virtual;
    function ExecSP(SP: TpFIBStoredProc): Boolean; virtual;
    procedure ReadList; virtual;
    procedure SetButtonsStyle; virtual;
  public
    property AutoRefresh: Integer read FAutoRefresh;
    property ActiveDataset  : TpFIBDataSet read FActiveDataset write FActiveDataset default nil;
    property ActiveListControl  : TcxGrid read FActiveListControl write FActiveListControl default nil;
    property ActiveTVControl  : TcxGridDBTableView read FActiveTVControl write FActiveTVControl default nil;
  end;

implementation

uses dmMain, unErrorHandlers, unInitApp;

{$R *.DFM}

{ TDBMultiPageListROForm }

procedure TDBMultiPageListROForm.FormCreate(Sender: TObject);
begin
  inherited;
  FActiveDataset      := spRead; {Эти два поля должны изменяться в OnChange потомка}
  FActiveListControl  := gr1;
  FActiveTVControl    := tvMain;
  dxBarSpinEditHeaderHeight.IntValue := tvMain.OptionsView.HeaderHeight;
end;

procedure TDBMultiPageListROForm.FormShow(Sender: TObject);
begin
  inherited;
  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;

  dxBarButtonEnableAutoRefresh.Down := True;
  aRefresh.Execute;
end;

procedure TDBMultiPageListROForm.aEnableAutoRefreshExecute(
  Sender: TObject);
begin
  inherited;
  tAutoRefresh.Enabled := not tAutoRefresh.Enabled;
end;

procedure TDBMultiPageListROForm.WMSetupChanged(var Message: TMessage);
begin
  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;
  inherited;
end;

procedure TDBMultiPageListROForm.GetButtonsStyle;
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
            end;}
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
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageListROForm.GetButtonsStyle)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBMultiPageListROForm.SetButtonsStyle;
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

procedure TDBMultiPageListROForm.ReadList;
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
                 + #13#10'(occured in TDBMultiPageListROForm.ReadList)', mtInformation, [mbOK], 0);
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

      dxBarStaticRecCnt.Caption := Format('%d', [AllRecordCount]);
    end;
  except
    on E: EFIBError do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBMultiPageListROForm.ReadList)');
    end;
    on E: Exception do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageListROForm.ReadList)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDBMultiPageListROForm.tAutoRefreshTimer(Sender: TObject);
begin
  inherited;
  if Self.Active then {Обновляем только активную в данный момент форму}
    aRefresh.Execute;
end;

procedure TDBMultiPageListROForm.aRefreshExecute(Sender: TObject);
begin
  inherited;

  {Здесь и далее используем PostMessage вместо непосредственного выполнения кода,
   необходимого для данной операции, т.к. иначе постоянно возникают AccessViolation
   в TdxBar}
  PostMessage(Self.Handle, WM_REFRESH, 0, 0);
end;

procedure TDBMultiPageListROForm.WMRefresh(var Message: TMessage);
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

function TDBMultiPageListROForm.OpenSP(SP: TpFIBDataSet;
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
                 + #13#10'(occured in TDBMultiPageListROForm.OpenSP)', mtInformation, [mbOK], 0);
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBMultiPageListROForm.OpenSP)');
    end;
    on E: Exception do begin
      if SP.Transaction.InTransaction then
        SP.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBMultiPageListROForm.OpenSP)', mtError, [mbOk], 0);
    end;
  end;
end;

function TDBMultiPageListROForm.ExecSP(SP: TpFIBStoredProc): Boolean;
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
             + #13#10'(occured in TDBMultiPageListROForm.ExecSP)', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

procedure TDBMultiPageListROForm.aCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TDBMultiPageListROForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  inherited;
  FActiveTVControl.Controller.Customization := True;
end;

procedure TDBMultiPageListROForm.aSaveAllToXLSExecute(Sender: TObject);
begin
  inherited;
  if ActiveListControl is TcxGrid then
    if dlgSave.Execute then
      ExportGridToExcel(dlgSave.FileName, (ActiveListControl as TcxGrid), True, True, True, 'xls');
end;

procedure TDBMultiPageListROForm.aSaveSelectedToXLSExecute(Sender: TObject);
begin
  inherited;
  if ActiveListControl is TcxGrid then
    if dlgSave.Execute then
      ExportGridToExcel(dlgSave.FileName, (ActiveListControl as TcxGrid), True, False, True, 'xls');
end;

procedure TDBMultiPageListROForm.dxBarSpinEditHeaderHeightButtonClick(
  Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
var
  i : Integer;
begin
  inherited;
  if dxBarSpinEditHeaderHeight.CurText <> '' then
    dxBarSpinEditHeaderHeight.Text := dxBarSpinEditHeaderHeight.CurText;

  if dxBarSpinEditHeaderHeight.Text <> '' then
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TcxGrid then
        (Components[i] as TcxGridDBTableView).OptionsView.HeaderHeight := dxBarSpinEditHeaderHeight.IntValue;
end;

procedure TDBMultiPageListROForm.dxBarSpinEditHeaderHeightCurChange(
  Sender: TObject);
var
  i : Integer;
begin
  inherited;
  if dxBarSpinEditHeaderHeight.CurText <> '' then
    dxBarSpinEditHeaderHeight.Text := dxBarSpinEditHeaderHeight.CurText;

  if dxBarSpinEditHeaderHeight.Text <> '' then
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TcxGrid then
        (Components[i] as TcxGridDBTableView).OptionsView.HeaderHeight := dxBarSpinEditHeaderHeight.IntValue;
end;

procedure TDBMultiPageListROForm.dxBarSpinEditHeaderHeightKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['1'..'3', #8]) then
    key := #0;
  dxBarSpinEditHeaderHeight.CurText := '';
end;

end.
