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
  cxCurrencyEdit;

type
  TPrihodTovaraListForm = class(TDBMultiPageListForm)
    tsPoTovaram: TcxTabSheet;
    splMenu: TcxSplitter;
    spSkladDetails: TpFIBDataSet;
    dsSkladDetails: TDataSource;
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
    tvPrihodAll: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    clmGridDBDATE_RECEIPT: TcxGridDBColumn;
    clmGridDBCLIENT_NAME: TcxGridDBColumn;
    clmGridDBPAYMENT_NAME: TcxGridDBColumn;
    clmMainColumnSKLAD: TcxGridDBColumn;
    clmtv1PRICE_CURRENCY: TcxGridDBColumn;
    clmtv1SUMM_CURRENCY: TcxGridDBColumn;
    clmPrihodAllPriceCurrency: TcxGridDBColumn;
    clmPrihodAllSummCurrency: TcxGridDBColumn;
    clmMainG_OFFICIAL_FIO: TcxGridDBColumn;
    clmtv1G_UNIT_NAME: TcxGridDBColumn;
    procedure dxPageControl1Change(Sender: TObject);
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
  private
    FIsVozvrat : Integer;
  public
    constructor CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String = '');
    procedure ReadlistAfterEdit(id : Integer);
    procedure RefreshChild;
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

uses frmPrihodTovaraN, dmReports, unInitApp, frmAddPrihodList;

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
  END ELSE IF FIsVozvrat = 1 then
    clmMainCLIENT_NAME.Caption := 'Клиент';

  if (FIsVozvrat <> 0) or (UseCurrency = False) then begin
    clmtv1PRICE_CURRENCY.Destroy;
    clmtv1SUMM_CURRENCY.Destroy;
    clmPrihodAllPriceCurrency.Destroy;
    clmPrihodAllSummCurrency.Destroy;
  end;

  if AppName = 'ShopUchet' then
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
  aUpd.Enabled := spRead.RecordCount > 0;
  aDel.Enabled := spRead.RecordCount > 0;
  aPrintExcel.Enabled := spRead.RecordCount > 0;

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

procedure TPrihodTovaraListForm.ReadlistAfterEdit(id: Integer);
begin
  Readlist;
  spRead.Locate('sklad', id, []);
  if tvMain.Controller.FocusedRow <> Nil then begin
    if tvMain.Controller.SelectedRowCount > 0 then
      tvMain.Controller.SelectedRows[0].Selected := False;
    tvMain.Controller.FocusedRow.Selected := True;
  end;
end;

procedure TPrihodTovaraListForm.RefreshChild;
begin
  IF dxPageControl1.ActivePageIndex = 0 THEN
    spSkladDetails.PARAMByName('sklad_parent_').AsInteger := spRead.FieldByName('sklad').AsInteger
  ELSE
    spSkladDetails.PARAMByName('sklad_parent_').Clear;

  spSkladDetails.PARAMByName('DATE_BEGIN_').AsDate := dcBegin.Date;
  spSkladDetails.PARAMByName('DATE_END_').AsDate := dcEnd.Date;
  spSkladDetails.PARAMByName('IS_VOZVRAT_').AsInteger := FIsVozvrat;

  Screen.Cursor := crSQLWait;
  OpenSp(spSkladDetails, False);
  Screen.Cursor := crDefault;

  IF dxPageControl1.ActivePageIndex = 0 THEN
    stDetailsCount.Caption := Format('%d', [spSkladDetails.RecordCount])
  else
    dxBarStaticRecCnt.Caption := Format('%d', [spSkladDetails.RecordCount]);
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
  if (spRead.Active) and (APrevFocusedRecord <> nil) then
    RefreshChild;
end;

procedure TPrihodTovaraListForm.tvMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ActiveListControl := TcxGrid(Sender as TcxGridSite);
  ActiveTVControl := ((Sender as TcxGridSite).GridView as TcxGridDBTableView);
end;

procedure TPrihodTovaraListForm.InsData;
begin
  if (HaveRightInsPrihod = False) and (FIsVozvrat = 0)  then begin
    MessageDlg('У Вас нет прав на создание накладных"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if OldAddPrihod then begin
    PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
    try
      PrihodTovaraNForm.OpenMode := omInsert;
      PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
      if PrihodTovaraNForm.ShowModal = mrOK then
        ReadlistAfterEdit(PrihodTovaraNForm.RecID);
    finally
      PrihodTovaraNForm.Free;
    end;
  end
  // приход по новому варианту
  else begin
    TAddPrihodListForm.CreateIt(Self, 0, FIsVozvrat, omInsert, 0);
  end;
end;

procedure TPrihodTovaraListForm.InsLikeData;
begin
  if (HaveRightInsPrihod = False) and (FIsVozvrat = 0)  then begin
    MessageDlg('У Вас нет прав на создание накладных"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if OldAddPrihod then begin
    PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
    try
      PrihodTovaraNForm.OpenMode := omInsertLike;
      PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
      {if dxPageControl1.ActivePageIndex = 0 then
        PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger
      else
        PrihodTovaraNForm.RecId := spSkladDetails.FieldByName('sklad_parent').AsInteger;}
      PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger;

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
  end else
    TAddPrihodListForm.CreateIt(Self, spRead.FieldByName('sklad').AsInteger, FIsVozvrat, omInsertLike, 0);
end;

procedure TPrihodTovaraListForm.UpdData;
begin
  if spRead.FieldByName('is_vozvrat').AsInteger = 2 then begin
    MessageDlg('Данный возврат является возвратом товара, выданного под реализацию.' + #10#13 +  'Доступно для редактирования в режиме "Выдача под реализацию"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if OldAddPrihod then begin
    PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
    try
      PrihodTovaraNForm.OpenMode := omUpdate;
      PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
      {if dxPageControl1.ActivePageIndex = 0 then
        PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger
      else
        PrihodTovaraNForm.RecId := spSkladDetails.FieldByName('sklad_parent').AsInteger;}
      PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger;

      if PrihodTovaraNForm.ShowModal = mrOK then begin
        Readlist;
        spRead.Locate('sklad', PrihodTovaraNForm.RecID, []);
      end;
    finally
      PrihodTovaraNForm.Free;
    end;
  end else
    TAddPrihodListForm.CreateIt(Self, spRead.FieldByName('sklad').AsInteger, FIsVozvrat, omUpdate, 0);
end;

procedure TPrihodTovaraListForm.ViewData;
begin
  if OldAddPrihod then begin
    PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
    try
      PrihodTovaraNForm.OpenMode := omView;
      PrihodTovaraNForm.Is_vozvrat := FIsVozvrat;
      {if dxPageControl1.ActivePageIndex = 0 then
        PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger
      else
        PrihodTovaraNForm.RecId := spSkladDetails.FieldByName('sklad_parent').AsInteger; }
      PrihodTovaraNForm.RecId := spRead.FieldByName('sklad').AsInteger;

      PrihodTovaraNForm.ShowModal;
    finally
      PrihodTovaraNForm.Free;
    end;
  end else
    TAddPrihodListForm.CreateIt(Self, spRead.FieldByName('sklad').AsInteger, FIsVozvrat, omView, 0);
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

procedure TPrihodTovaraListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'sklad';
  KeyFieldClass := 'sklad_';
  ActiveListControl := grSklad;
  inherited;
end;

procedure TPrihodTovaraListForm.aDelExecute(Sender: TObject);
begin
  if (HaveRightDelPrihod = False) and (FIsVozvrat = 0)  then begin
    MessageDlg('У Вас нет прав на удаление накладных"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if MessageDlg(Format('Удалить накладную от "%s" ?',
    [spRead.FieldByName('date_receipt').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
    
  spDel.ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
  inherited;
end;

procedure TPrihodTovaraListForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  dxPageControl1.ActivePage := ts1;

  inherited;
  IF FIsVozvrat = 1 THEN begin
    tsPoTovaram.Enabled := False;
    tsPoTovaram.Visible := False;
  end;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
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

procedure TPrihodTovaraListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    Ini.WriteInteger('PrihodTovaraList', 'SplitterPos', grSklad.Height);
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;

  tvMain.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvMain.name);
  tv1.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tv1.name);
  tvPrihodAll.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvPrihodAll.name);
end;

procedure TPrihodTovaraListForm.aPrintExcelExecute(Sender: TObject);
begin
  if FIsVozvrat = 1 then
    ReportsDM.PrepareReport(53)
  else
    ReportsDM.PrepareReport(40);
  ReportsDM.spReport.ParamByName('SKLAD_PARENT_').AsInteger := spRead.FieldByName('sklad').AsInteger;
  ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
  ReportsDM.ShowReport(1, '');
end;

end.
