unit frmDBListRO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ToolWin, ComCtrls, ExtCtrls, ActnList, Menus,
  dxBar, dxBarExtItems,
  Db, Registry, Variants, dxBarExtDBItems,
  FIB, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase,
  FIBQuery, pFIBQuery, pFIBStoredProc, frmMDIChild, unCommonFunc,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxBarPainter, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxContainer, cxGridExportLink, cxNavigator,
  System.Actions, UITypes, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TDBListROForm = class(TMDIChildForm)
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
    dxBarButtonEnableAutoRefresh: TdxBarButton;
    aEnableAutoRefresh: TAction;
    dxBarSpinEditHeaderHeight: TdxBarSpinEdit;
    spRead: TpFIBDataSet;
    tranRead: TpFIBTransaction;
    tvMain: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    gr1: TcxGrid;
    dxEditStyleController: TcxEditStyleController;
    procedure aRefreshExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure aSaveAllToXLSExecute(Sender: TObject);
    procedure aSaveSelectedToXLSExecute(Sender: TObject);
    procedure aEnableAutoRefreshExecute(Sender: TObject);
    procedure dxBarSpinEditHeaderHeightButtonClick(Sender: TdxBarSpinEdit;
      Button: TdxBarSpinEditButton);
    procedure dxBarSpinEditHeaderHeightCurChange(Sender: TObject);
    procedure dxBarSpinEditHeaderHeightKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure tAutoRefreshTimer(Sender: TObject);
    procedure a1Execute(Sender: TObject);
  private
    FtbButtonsStyle: TtbButtonsStyle;
    FAutoRefresh: Integer;
    FActiveListControl  : TcxGrid;
    FActiveTVControl : TcxGridDBTableView;
    procedure GetButtonsStyle;
    procedure WMSetupChanged(var Message: TMessage); message WM_SETUPCHANGED;
    procedure WMRefresh(var Message: TMessage); message WM_REFRESH;
  protected
    procedure ReadList; virtual;
    procedure SetButtonsStyle; virtual;
    function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean; virtual;
    function ExecSP(SP: TpFIBStoredProc): Boolean; virtual;
    function ExecSPTR(SP: TpFIBStoredProc): Boolean; virtual;
  public
    property AutoRefresh: Integer read FAutoRefresh;
    property ActiveListControl  : TcxGrid read FActiveListControl write FActiveListControl default nil;
    property ActiveTVControl  : TcxGridDBTableView read FActiveTVControl write FActiveTVControl default nil;
  end;

implementation

uses dmMain, unErrorHandlers, unInitApp;

{$R *.DFM}

procedure TDBListROForm.FormCreate(Sender: TObject);
begin
  inherited;
  dxBarSpinEditHeaderHeight.IntValue := tvMain.OptionsView.HeaderHeight;
  FActiveListControl := gr1;
  FActiveTVControl := tvMain;
end;

procedure TDBListROForm.FormShow(Sender: TObject);
begin
  inherited;

  //прописываем русский язык
  dxBarSpinEditHeaderHeight.Caption := 'Высота заголовка';
  dxBarSpinEditHeaderHeight.Hint    := 'Высота заголовка';

  aRefresh.Caption := 'Обновить';
  aRefresh.Hint := 'Обновить|Обновление списка';
  aClose.Caption := 'Закрыть';
  aClose.Hint := 'Закрыть|Закрытие текущего (активного) окна';
  aCustomizeColumns.Caption := '&Настройка столбцов';
  aCustomizeColumns.Hint := 'Настройка столбцов';
  aSaveAllToXLS.Caption := '&Сохранить все';
  aSaveAllToXLS.Hint := '&Сохранить все';
  aSaveSelectedToXLS.Caption := 'Сохранить &выделенное';
  aSaveSelectedToXLS.Hint := 'Сохранить выделенное';
  aEnableAutoRefresh.Caption := 'Автообновление';
  aEnableAutoRefresh.Hint := 'Включить/выключить автообновление списка';
  //-----------------------------------

  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;

  dxBarButtonEnableAutoRefresh.Down := True;
  aRefresh.Execute;
end;

procedure TDBListROForm.aEnableAutoRefreshExecute(Sender: TObject);
begin
  inherited;
  tAutoRefresh.Enabled := not tAutoRefresh.Enabled;
end;

procedure TDBListROForm.WMSetupChanged(var Message: TMessage);
begin
  {Изменяем стиль кнопок в соответствии с настройками пользователя}
  GetButtonsStyle;
  SetButtonsStyle;
  inherited;
end;

procedure TDBListROForm.GetButtonsStyle;
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
      MessageDlg(E.Message + #13#10'(occured in TDBListROForm.GetButtonsStyle)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDBListROForm.SetButtonsStyle;
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

procedure TDBListROForm.ReadList;
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
                 + #13#10'(occured in TDBListROForm.ReadList)', mtInformation, [mbOK], 0);
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBListROForm.ReadList)');
    end;
    on E: Exception do begin
      if spRead.Transaction.InTransaction then
        spRead.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBListROForm.ReadList)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDBListROForm.tAutoRefreshTimer(Sender: TObject);
begin
  inherited;
  if Self.Active then {Обновляем только активную в данный момент форму}
    aRefresh.Execute;

end;

procedure TDBListROForm.aRefreshExecute(Sender: TObject);
begin
  inherited;

  {Здесь и далее используем PostMessage вместо непосредственного выполнения кода,
   необходимого для данной операции, т.к. иначе постоянно возникают AccessViolation
   в TdxBar}
  PostMessage(Self.Handle, WM_REFRESH, 0, 0);
end;

procedure TDBListROForm.WMRefresh(var Message: TMessage);
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

function TDBListROForm.OpenSP(SP: TpFIBDataSet;
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
                 + #13#10'(occured in TDBListROForm.OpenSP)', mtInformation, [mbOK], 0);
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBListROForm.OpenSP)');
    end;
    on E: Exception do begin
      if SP.Transaction.InTransaction then
        SP.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBListROForm.OpenSP)', mtError, [mbOk], 0);
    end;
  end;
end;

function TDBListROForm.ExecSP(SP: TpFIBStoredProc): Boolean;
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
          MessageDlg('Ошибка № ' + IntToStr(E.SQLCode) + ':' + E.Message, mtError, [mbOk], 0);
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
             + #13#10'(occured in TDBListForm.ExecSP)', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

function TDBListROForm.ExecSPTR(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, НЕ вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrCode: Integer;
  ErrMsg : String;
begin
  Result := False;

  with SP do begin
    if not Transaction.InTransaction then
      Transaction.StartTransaction;
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
             + #13#10'(occured in TDBListForm.ExecSP)', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;

    if Transaction.InTransaction then
      Transaction.Commit;
  end;

  Result := True;
end;


procedure TDBListROForm.a1Execute(Sender: TObject);
begin
  inherited;
ShowMessage('asd');
end;

procedure TDBListROForm.aCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TDBListROForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  spRead.Close;

  inherited;

  tvMain.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvMain.name);
end;

procedure TDBListROForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  inherited;
  FActiveTVControl.Controller.Customization := True;
end;

procedure TDBListROForm.aSaveAllToXLSExecute(Sender: TObject);
begin
  inherited;
  if dlgSave.Execute then
    ExportGridToExcel(dlgSave.FileName, FActiveListControl, True, True, True, 'xls');
end;

procedure TDBListROForm.aSaveSelectedToXLSExecute(Sender: TObject);
begin
  inherited;
  if dlgSave.Execute then
    ExportGridToExcel(dlgSave.FileName, FActiveListControl, True, False, True, 'xls');
end;

procedure TDBListROForm.dxBarSpinEditHeaderHeightButtonClick(Sender: TdxBarSpinEdit;
  Button: TdxBarSpinEditButton);
begin
  inherited;
  if dxBarSpinEditHeaderHeight.CurText <> '' then
    dxBarSpinEditHeaderHeight.Text := dxBarSpinEditHeaderHeight.CurText;

  if dxBarSpinEditHeaderHeight.Text <> '' then
    tvMain.OptionsView.HeaderHeight := dxBarSpinEditHeaderHeight.IntValue;
end;

procedure TDBListROForm.dxBarSpinEditHeaderHeightCurChange(Sender: TObject);
begin
  inherited;
  if dxBarSpinEditHeaderHeight.CurText <> '' then
    dxBarSpinEditHeaderHeight.Text := dxBarSpinEditHeaderHeight.CurText;

  if dxBarSpinEditHeaderHeight.Text <> '' then
    tvMain.OptionsView.HeaderHeight := dxBarSpinEditHeaderHeight.IntValue;
end;

procedure TDBListROForm.dxBarSpinEditHeaderHeightKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (key in ['1'..'3', #8]) then
    key := #0;
  dxBarSpinEditHeaderHeight.CurText := '';
end;

end.
