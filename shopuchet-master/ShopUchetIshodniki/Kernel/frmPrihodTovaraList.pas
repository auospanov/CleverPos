unit frmPrihodTovaraList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBMultiPageList, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, DB, FIBDataSet, pFIBDataSet,
  ExtCtrls, Menus, ActnList, dxBar, dxBarExtItems, cxPC, cxControls, cxSplitter, frmDBEdit,
  StdCtrls, unCommonFunc, IniFiles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, dxSkinsdxBarPainter, cxCheckBox,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridLevel, cxGridCustomView, cxGrid, cxCalendar, cxTextEdit, System.UITypes,
  dxBarBuiltInMenu, cxNavigator, System.Actions, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxCurrencyEdit, cxEditRepositoryItems, cxContainer, cxButtons, cxCalc,
  Vcl.AppEvnts, System.DateUtils;

type
  TPrihodTovaraListForm = class(TDBMultiPageListForm)
    tsPoTovaram: TcxTabSheet;
    splMenu: TcxSplitter;
    spSkladDetails: TpFIBDataSet;
    dsSkladDetails: TDataSource;
    aRefreshChild: TAction;
    Panel1: TPanel;
    stDetailsCount: TStaticText;
    dcBegin: TdxBarDateCombo;
    dcEnd: TdxBarDateCombo;
    dxBarSubItem: TdxBarSubItem;
    aPrintExcel: TAction;
    dxbrbtn1: TdxBarButton;
    grSklad: TcxGrid;
    tv1: TcxGridDBTableView;
    lv1: TcxGridLevel;
    clmMainDATE_RECEIPT: TcxGridDBColumn;
    clmMainCLIENT_NAME: TcxGridDBColumn;
    clmMainPAYMENT_NAME: TcxGridDBColumn;
    clmMainOSNOVANIE: TcxGridDBColumn;
    clmMainNOTE: TcxGridDBColumn;
    clmMainSUMM: TcxGridDBColumn;
    clmMainSUMM_FACT: TcxGridDBColumn;
    clmMainIS_PAYED_ALL: TcxGridDBColumn;
    clmMainDETAILS_STR: TcxGridDBColumn;
    clmtv1AMOUNT: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    clmtv1SUMM: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1PRODUCT_NAME: TcxGridDBColumn;
    grPrihod: TcxGrid;
    tvPrihodAllcxGridDBColumn1: TcxGridDBColumn;
    tvPrihodAllcxGridDBAMOUNT: TcxGridDBColumn;
    tvPrihodAllcxGridDBColumn3: TcxGridDBColumn;
    tvPrihodAllcxGridDBColumn4: TcxGridDBColumn;
    tvPrihodAllcxGridDBColumn5: TcxGridDBColumn;
    tvPrihodAllcxGridDBColumn6: TcxGridDBColumn;
    tvPrihodAllcxGridDBColumn7: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    tvPrihodAllclmGridDBDATE_RECEIPT: TcxGridDBColumn;
    tvPrihodAllclmGridDBCLIENT_NAME: TcxGridDBColumn;
    tvPrihodAllclmGridDBPAYMENT_NAME: TcxGridDBColumn;
    clmMainColumnSKLAD: TcxGridDBColumn;
    clmtv1PRICE_CURRENCY: TcxGridDBColumn;
    clmtv1SUMM_CURRENCY: TcxGridDBColumn;
    clmPrihodAllPriceCurrency: TcxGridDBColumn;
    clmPrihodAllSummCurrency: TcxGridDBColumn;
    clmMainG_OFFICIAL_FIO: TcxGridDBColumn;
    clmtv1G_UNIT_NAME: TcxGridDBColumn;
    Panel2: TPanel;
    Label10: TLabel;
    edBarcode: TcxTextEdit;
    btClear: TcxButton;
    TimerChangeEd: TTimer;
    tvPrihodAll: TcxGridDBTableView;
    clmPRICE_ROZN: TcxGridDBColumn;
    clmPRICE_OPT: TcxGridDBColumn;
    clmMainG_NONCASH_PAY_TYPE_NAME: TcxGridDBColumn;
    clmSUMM_SALE: TcxGridDBColumn;
    aDoMove: TAction;
    btn1: TdxBarButton;
    N1: TMenuItem;
    NDoMove: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    spFindZakazByBarcode: TpFIBDataSet;
    procedure dxPageControl1Change(Sender: TObject);
    procedure aRefreshChildExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grSkladMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dxDBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dcBeginChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aPrintExcelExecute(Sender: TObject);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvMainCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure tvMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tvMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tv1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure edBarcodePropertiesChange(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure aDoMoveExecute(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure tvPrihodAllMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FIsVozvrat : Integer;
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FZakaz : Int64;
    FZakazNote : String;
    procedure RefreshChild;
    function FillLog : string;
  public
    constructor CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String = '');
  protected
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ViewData; override;
    procedure ReadList; override;
  end;

var
  PrihodTovaraListForm: TPrihodTovaraListForm;

implementation

uses frmPrihodTovaraN, frmProdazhaTovaraN, dmReports, unInitApp, unLog;

{$R *.dfm}

constructor TPrihodTovaraListForm.CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String);
var Caption_ : String;
    Event : TNotifyEvent;
begin
  FIsVozvrat := Prizn;

  IF FIsVozvrat = 0 THEN begin
    Caption_ := 'Приход товара';
    Helpc := 17;
  end else if FIsVozvrat = 1 THEN begin
    Caption_ := 'Возврат товара';
    Helpc := 20;
  end else begin
    Caption_ := 'Приход товара с другого склада';
    Helpc := 52;
  end;

  inherited Create(AOwner, Caption_, ActionName);

  Self.Caption := Caption_;

  //в режиме "Приход с другого склада", нельзя добавлять или удалять или изменять приходы, пусть мутят это на том складе, откуда был приход.
  IF FIsVozvrat = 3 THEN BEGIN
    clmMainCLIENT_NAME.Caption := 'Склад-поставщик';
    clmMainPAYMENT_NAME.Destroy;
    clmMainIS_PAYED_ALL.Destroy;
    clmMainSUMM_FACT.Destroy;
    aIns.Visible := False;
    aInsLike.Visible := False;
    aUpd.Visible := False;
  END ELSE IF FIsVozvrat = 1 then begin
    clmMainCLIENT_NAME.Caption := 'Клиент';
    clmPRICE_ROZN.Destroy;
    clmPRICE_OPT.Destroy;
  end;

  if (FIsVozvrat <> 0) then begin
    if (UseCurrency = False)  then begin
      clmtv1PRICE_CURRENCY.Destroy;
      clmtv1SUMM_CURRENCY.Destroy;
      clmPrihodAllPriceCurrency.Destroy;
      clmPrihodAllSummCurrency.Destroy;
    end;
    clmSUMM_SALE.Destroy;
  end;

  if (AppName = 'shopuchet') or (AppName = 'starshop') then
    clmtv1G_UNIT_NAME.Destroy;
end;

procedure TPrihodTovaraListForm.ReadList;
var
  OnChangeEvent : TcxGridFocusedRecordChangedEvent;
begin
  OnChangeEvent := tvMain.OnFocusedRecordChanged;
  tvMain.OnFocusedRecordChanged := nil;

  spRead.PARAMByName('DATE_BEGIN_').AsDate := dcBegin.Date;
  spRead.PARAMByName('DATE_END_').AsDate := dcEnd.Date;
  spRead.PARAMByName('IS_VOZVRAT_').AsInteger := FIsVozvrat;

  inherited;
  aInsLike.Enabled := spRead.RecordCount > 0;
  aUpd.Enabled := spRead.RecordCount > 0;
  aDel.Enabled := spRead.RecordCount > 0;
  aPrintExcel.Enabled := spRead.RecordCount > 0;
  aDoMove.Enabled := (aDoMove.Visible) and (spRead.RecordCount > 0) and (High(SkladArr) > 0);

  //if dxPageControl1.ActivePageIndex = 0 then begin
  RefreshChild;
  {end else begin
    spSkladDetails.PARAMByName('DATE_BEGIN_').AsDate := dcBegin.Date;
    spSkladDetails.PARAMByName('DATE_END_').AsDate := dcEnd.Date;
    spSkladDetails.PARAMByName('sklad_parent_').AsInteger := 0;
    spSkladDetails.PARAMByName('IS_VOZVRAT_').AsInteger := FIsVozvrat;
    OpenSp(spSkladDetails, False);
  end;}
  tvMain.OnFocusedRecordChanged := OnChangeEvent;
end;

procedure TPrihodTovaraListForm.TimerChangeEdTimer(Sender: TObject);
var s: string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spSkladDetails do begin
      s := '(PRODUCT_NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (NOMENCLATUR_NUM CONTAINING ''' + edBarcode.text +
           ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;

    if tvPrihodAll.Controller.FocusedRow <> Nil then begin
      if tvPrihodAll.Controller.SelectedRowCount > 0 then
        tvPrihodAll.Controller.SelectedRows[0].Selected := False;
      tvPrihodAll.Controller.FocusedRow.Selected := True;
    end;
  END;
end;

procedure TPrihodTovaraListForm.tv1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ActiveListControl := TcxGridLevel(tv1.Level).Control as TcxGrid;
  ActiveTVControl   := tv1;
end;

procedure TPrihodTovaraListForm.tvMainCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if FIsVozvrat = 3 THEN
    aView.Execute
  else
    aUpd.Execute;
end;

procedure TPrihodTovaraListForm.tvMainCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  IF FIsVozvrat <> 3 then begin    // т.к. для списания и перемещения колонка уничтожается, то и нет смысла ее тут анализировать
    if (AViewInfo.GridRecord.Values[clmMainIS_PAYED_ALL.index] = 0) then begin
      if AViewInfo.Selected then begin
        ACanvas.Brush.Color:= clRed;
        ACanvas.Font.Color:= clWhite;
      end else begin
        ACanvas.Brush.Color:= clWindow;
        ACanvas.Font.Color:= clRed;
      end;
    end;

    {if ANode.Selected then
    begin
      // ОПЛАЧЕННЫЕ выделяются цветом
      if ANode.Values[TdxDBGrid(Sender).ColumnByFieldName('IS_PAYED_ALL').Index] = '0' then
      begin
        AColor := clWhite;
        AFont.Color := clRed;
      end;
    end else begin
      // ОПЛАЧЕННЫЕ выделяются цветом
      if ANode.Values[TdxDBGrid(Sender).ColumnByFieldName('IS_PAYED_ALL').Index] = '0' then
      begin
        AColor := clRed;
        AFont.Color := clWhite;
      end;
    end;}
  END;
end;

procedure TPrihodTovaraListForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  aRefreshChild.Execute;
end;

procedure TPrihodTovaraListForm.tvMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ActiveListControl := TcxGridLevel(tvMain.Level).Control as TcxGrid;
  ActiveTVControl   := tvMain;
end;

procedure TPrihodTovaraListForm.tvPrihodAllMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ActiveListControl := TcxGridLevel(tvPrihodAll.Level).Control as TcxGrid;
  ActiveTVControl   := tvPrihodAll;
end;

procedure TPrihodTovaraListForm.InsData;
begin
  if ((HaveRightInsPrihod = False) and (FIsVozvrat = 0)) or
  ((HaveRightInsReturnClient = False) and (FIsVozvrat = 1)) then begin
    MessageDlg('У Вас нет прав на создание накладных"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if (LetDoReturnWithoutSale = 0) and (FIsVozvrat = 1)  then begin
    MessageDlg('Запрещено создавать возврат без выбора накладной продажи!'+#10#13+'Вы можете оформить возврат на "Рабочем месте кассира" либо '+
    'через меню "Торговля - Продажи".', mtWarning, [mbOk], 0);
    Exit;
  end;

  PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
  try
    PrihodTovaraNForm.OpenMode := omInsert;
    PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
    if FIsVozvrat = 1 then begin
      PrihodTovaraNForm.Zakaz := FZakaz;
      PrihodTovaraNForm.ZakazNote := FZakazNote;
    end;

    if PrihodTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('sklad', PrihodTovaraNForm.RecID, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    PrihodTovaraNForm.Free;
  end;
end;

procedure TPrihodTovaraListForm.InsLikeData;
begin
  if ((HaveRightInsPrihod = False) and (FIsVozvrat = 0)) or
  ((HaveRightInsReturnClient = False) and (FIsVozvrat = 1)) then begin
    MessageDlg('У Вас нет прав на создание накладных"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
  try
    PrihodTovaraNForm.OpenMode := omInsertLike;
    PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
    {if dxPageControl1.ActivePageIndex = 0 then
      PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger
    else
      PrihodTovaraNForm.RecId := spSkladDetails.FieldByName('sklad_parent').AsInteger;}
    PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsLargeInt;

    if PrihodTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('sklad', PrihodTovaraNForm.RecID, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    PrihodTovaraNForm.Free;
  end;
end;

procedure TPrihodTovaraListForm.UpdData;
begin
  if spRead.FieldByName('is_vozvrat').AsInteger = 2 then begin
    MessageDlg('Данный возврат является возвратом товара, выданного под реализацию.' + #10#13 +  'Доступно для редактирования в режиме "Выдача под реализацию"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
  try
    PrihodTovaraNForm.OpenMode := omUpdate;
    PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
    if dxPageControl1.ActivePageIndex = 0 then
      PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsLargeInt
    else
      PrihodTovaraNForm.RecId := spSkladDetails.FieldByName('sklad_parent').AsLargeInt;
    //PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger;

    if PrihodTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('sklad', PrihodTovaraNForm.RecID, []);
    end;
  finally
    PrihodTovaraNForm.Free;
  end;
end;

procedure TPrihodTovaraListForm.ViewData;
begin
  PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
  try
    PrihodTovaraNForm.OpenMode := omView;
    PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
    {if dxPageControl1.ActivePageIndex = 0 then
      PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger
    else
      PrihodTovaraNForm.RecId := spSkladDetails.FieldByName('sklad_parent').AsInteger; }
    PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsLargeInt;

    PrihodTovaraNForm.ShowModal;
  finally
    PrihodTovaraNForm.Free;
  end;
end;

{procedure TProdazhaTovaraListForm.dcBeginChange(Sender: TObject);
begin
  inherited;
  Readlist;
end; }

procedure TPrihodTovaraListForm.dxPageControl1Change(Sender: TObject);
begin
  inherited;
  Readlist;
  if dxPageControl1.ActivePageIndex = 0 then
    ActiveListControl := gr1
  else
    ActiveListControl := grPrihod
end;

procedure TPrihodTovaraListForm.edBarcodePropertiesChange(Sender: TObject);
begin
  TimerChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    TimerChangeEd.Enabled := True
  else BEGIN
    with spSkladDetails do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TPrihodTovaraListForm.aRefreshChildExecute(Sender: TObject);
begin
  RefreshChild;
end;

procedure TPrihodTovaraListForm.RefreshChild;
begin
  IF dxPageControl1.ActivePageIndex = 0 THEN
    spSkladDetails.PARAMByName('sklad_parent_').AsInt64 := spRead.FieldByName('sklad').AsLargeInt
  ELSE
    spSkladDetails.PARAMByName('sklad_parent_').Clear;

  spSkladDetails.PARAMByName('DATE_BEGIN_').AsDate := dcBegin.Date;
  spSkladDetails.PARAMByName('DATE_END_').AsDate := dcEnd.Date;
  spSkladDetails.PARAMByName('IS_VOZVRAT_').AsInteger := FIsVozvrat;
  spSkladDetails.PARAMByName('HAVE_RIGHT_TO_SEE_COST_PRICE_').AsInteger := Integer(HaveRightToSeeCostPrice);

  Screen.Cursor := crSQLWait;
  OpenSp(spSkladDetails, False);
  Screen.Cursor := crDefault;

  IF dxPageControl1.ActivePageIndex = 0 THEN
    stDetailsCount.Caption := Format('%d', [spSkladDetails.RecordCount])
  else
    dxBarStaticRecCnt.Caption := Format('%d', [spSkladDetails.RecordCount]);
end;

procedure TPrihodTovaraListForm.btClearClick(Sender: TObject);
begin
  edBarcode.Clear;
  if Assigned(tvPrihodAll.Controller.FocusedRow) then
    tvPrihodAll.Controller.FocusedRow.Selected := True;
end;

procedure TPrihodTovaraListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'sklad';
  KeyFieldClass := 'sklad_';
  ActiveListControl := grSklad;
  inherited;
end;

procedure TPrihodTovaraListForm.aDelExecute(Sender: TObject);
var
  OnChangeEvent : TcxGridFocusedRecordChangedEvent;
begin
  if ((HaveRightDelPrihod = False) and (FIsVozvrat = 0)) or
  ((HaveRightDelReturnClient = False) and (FIsVozvrat = 1)) or
  ((HaveRightDelMove = False) and (FIsVozvrat = 3)) then begin
    MessageDlg('У Вас нет прав на удаление накладных"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if dxPageControl1.ActivePage = tsPoTovaram then begin
    try
      OnChangeEvent := tvMain.OnFocusedRecordChanged;
      tvMain.OnFocusedRecordChanged := nil;
      Screen.Cursor := crHourGlass;
      spRead.Locate('sklad', spSkladDetails.FieldByName('SKLAD_PARENT').AsLargeInt, []);
    finally
      tvMain.OnFocusedRecordChanged := OnChangeEvent;
      Screen.Cursor := crDefault;
    end;
  end;

  if MessageDlg(Format('Удалить накладную от "%s" ?',
    [spRead.FieldByName('date_receipt').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spDel.ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
  spDEl.ParamByName('LOG_BODY_').AsString := FillLog;
  spDEl.ParamByName('USER_ID_').AsInt64 := CurrentOfficial;

  if (FIsVozvrat in [0, 1]) and ((Copy(ExportDataType, 6, 1) = '1') or (UploadToMobile)) then
    spDel.ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 1
  else
    spDel.ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;

  inherited;
end;

procedure TPrihodTovaraListForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  str : string;
begin
  dxPageControl1.ActivePage := ts1;

  inherited;
  IF FIsVozvrat = 1 THEN begin
    tsPoTovaram.Enabled := False;
    tsPoTovaram.Visible := False;
  end
  else
    clmMainG_NONCASH_PAY_TYPE_NAME.Destroy;

  aDoMove.Visible := (FIsVozvrat = 0) and (High(SkladArr) > 0);
  aDoMove.Enabled := aDoMove.Visible;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings_grid.ini', TEncoding.UTF8);
  try
    grSklad.Height := Ini.ReadInteger('PrihodTovaraList', 'SplitterPos', 150);   //у сплиттера не работает положение из ИНИ, приходится выкручиваться высотой cxdvZakazDetails
  finally
    Ini.Free;
  end;
end;

procedure TPrihodTovaraListForm.grSkladMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ActiveListControl := grSklad;
end;

procedure TPrihodTovaraListForm.dxDBGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ActiveListControl := grPrihod;
end;

procedure TPrihodTovaraListForm.dcBeginChange(Sender: TObject);
begin
  Readlist;
end;

function TPrihodTovaraListForm.FillLog: string;
var str : string;
  mode : integer;
begin

  if FIsVozvrat = 4 then begin
    str  := '';
    mode := 9;
  end else begin
    str := spRead.FieldByName('CLIENT_NAME').AsString;
    case FIsVozvrat of
      0 : mode := 4;
      1 : mode := 5;
      2 : mode := 8;
    end;
  end;

  Result := FillInsWayBill(mode, spRead.FieldByName('DATE_RECEIPT').AsDateTime, spRead.FieldByName('TIME_RECEIPT').AsDateTime,
    str, spRead.FieldByName('SUMM').AsFloat, spRead.FieldByName('SUMM_FACT').AsFloat,
    0, 0,
    spSkladDetails);
end;

procedure TPrihodTovaraListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings_grid.ini', TEncoding.UTF8);
  try
    Ini.WriteInteger('PrihodTovaraList', 'SplitterPos', grSklad.Height);
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;

  tvMain.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvMain.name);
  tv1.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tv1.name);
  tvPrihodAll.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvPrihodAll.name);
end;

procedure TPrihodTovaraListForm.aDoMoveExecute(Sender: TObject);
begin
  ProdazhaTovaraNForm := TProdazhaTovaraNForm.Create(Self);
  try
    ProdazhaTovaraNForm.OpenMode := omInsert;
    ProdazhaTovaraNForm.Is_spisanie := 3;
    if ActiveTVControl = tvPrihodAll then
      ProdazhaTovaraNForm.SkladParent := spSkladDetails.FieldByName('sklad_parent').AsLargeInt
    else
      ProdazhaTovaraNForm.SkladParent := spRead.FieldByName('sklad').AsLargeInt;

    if ProdazhaTovaraNForm.ShowModal = mrOK then begin
      ShowMessage('Перемещение сохранено успешно!');
    end;
  finally
    FreeAndNil(ProdazhaTovaraNForm);
  end;
end;

procedure TPrihodTovaraListForm.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
  procedure ClearBuffer;
  begin
    if MilliSecondsBetween(Now, LastDateForAddedKey) > 200 then
    begin
      // при медленном вводе буфер очищяется, т.к. скан идет "мгновенно"
      KeysBuffer := '';
    end;
  end;
begin
  // обработка штрих-кодов
  // автор: jaydi85@gmail.com

  // данные считываем на WM_CHAR
  // НО КЛАВИШУ ЭНТЕР на WM_KEYDOWN
  // заканчиваем ввод
  IF Screen.ActiveForm <> Nil THEN BEGIN
    IF Screen.ActiveForm.Name = Self.Name THEN BEGIN
      if FIsVozvrat = 1 then begin

        if Msg.message = WM_KEYDOWN then
        begin
          if (Msg.wParam = 13) or (Msg.wParam = 10) then
          begin
            ClearBuffer;
            if KeysBuffer <> '' then begin
              // при сканировании нажатие энтера передавать никуда не надо
              Handled := True;
              // поиск заказа для возврата
              IF (Length(KeysBuffer) = 15) and (Copy(KeysBuffer, 1, 3) = 'SHO') THEN BEGIN
                spFindZakazByBarcode.ParamByName('barcode_').AsString := KeysBuffer;
                OpenSp(spFindZakazByBarcode, False);
                FZakaz := spFindZakazByBarcode.FieldByName('Zakaz').AsLargeInt;
                FZakazNote := spFindZakazByBarcode.FieldByName('Note').AsString;
              END;
              KeysBuffer := '';
            end;
          end
        end;

        // сохраняем ввод
        if Msg.message = WM_CHAR then
        begin
          ClearBuffer;
          if Msg.wParam <> 13 then
          begin
            // нажали что-то другое (надо отбросить всякие шифты и контролы)
            KeysBuffer := KeysBuffer + Chr(Msg.wParam);
            LastDateForAddedKey := Now;
          end;
        end;
      end;
    END;
  END;
end;

procedure TPrihodTovaraListForm.aPrintExcelExecute(Sender: TObject);
begin
  if FIsVozvrat = 1 then
    ReportsDM.PrepareReport(53)
  else
    ReportsDM.PrepareReport(40);
  ReportsDM.spReport.ParamByName('SKLAD_PARENT_').AsInt64 := spRead.FieldByName('sklad').AsLargeInt;
  ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
  ReportsDM.ShowReport(1, '');
end;

end.
