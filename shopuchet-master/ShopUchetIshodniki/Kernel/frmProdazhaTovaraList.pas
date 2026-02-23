unit frmProdazhaTovaraList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, DB, ExtCtrls, Menus,
  ActnList, dxBar, dxBarExtItems, frmDBEdit, cxControls, cxSplitter, StdCtrls, Buttons,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, unCommonFunc, IniFiles, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, dxSkinsdxBarPainter,
  cxCheckBox, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridLevel, cxGridCustomView, cxGrid, cxContainer, cxTextEdit, FIB, System.UITypes,
  cxNavigator, System.Actions, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, cxCalc;

type
  TProdazhaTovaraListForm = class(TDBListForm)
    dsZakazDetails: TDataSource;
    aRefreshChild: TAction;
    aUpdDetail: TAction;
    aDelDetail: TAction;
    splMenu: TcxSplitter;
    dcBegin: TdxBarDateCombo;
    dcEnd: TdxBarDateCombo;
    dxBarSubItem: TdxBarSubItem;
    aInvoicePay: TAction;
    aInvoice: TAction;
    dxBarButton2: TdxBarButton;
    spZakazDetails: TpFIBDataSet;
    Panel1: TPanel;
    stDetailsCount: TStaticText;
    aWayBill: TAction;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton3: TdxBarButton;
    aBill: TAction;
    dxBarButton4: TdxBarButton;
    aBillSpec: TAction;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    aPko: TAction;
    aRko: TAction;
    aAkt: TAction;
    dxbrbtn1: TdxBarButton;
    dxbrbtn2: TdxBarButton;
    grZakazDetails: TcxGrid;
    tvDetails: TcxGridDBTableView;
    clmtv1AMOUNT: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    clmtv1SUMM: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    lv1: TcxGridLevel;
    clmMainZ_NUM: TcxGridDBColumn;
    clmMainZ_DATE: TcxGridDBColumn;
    clmMainZ_TIME: TcxGridDBColumn;
    clmMainOSNOVANIE: TcxGridDBColumn;
    clmMainNOTE: TcxGridDBColumn;
    clmMainCLIENT_NAME: TcxGridDBColumn;
    clmMainIS_PAYED_ALL: TcxGridDBColumn;
    clmMainSUM_ZAKAZ: TcxGridDBColumn;
    clmMainSUM_FACT: TcxGridDBColumn;
    clmMainSUMM_PAY_BONUS: TcxGridDBColumn;
    clmMainSUMM_BONUS_GOT: TcxGridDBColumn;
    clmtv1DISCOUNT_PERC: TcxGridDBColumn;
    clmtv1DISCOUNT_SUMM: TcxGridDBColumn;
    clmtv1TOVAR_NAME: TcxGridDBColumn;
    clmtv1ED_NAME: TcxGridDBColumn;
    clmMainBY_RECIPE: TcxGridDBColumn;
    clmMainIS_RESERVE: TcxGridDBColumn;
    clmMainSUMM_CASH: TcxGridDBColumn;
    clmMainSUMM_NONCASH: TcxGridDBColumn;
    aPrintSimple: TAction;
    dxBarSubItem2: TdxBarSubItem;
    dxbrbtn3: TdxBarButton;
    clmMainG_OFFICIAL_FIO: TcxGridDBColumn;
    aDoReturn: TAction;
    dxbrbtn4: TdxBarButton;
    clmMainDETAILS_STR: TcxGridDBColumn;
    tmrSearch: TTimer;
    spDoReturn: TpFIBStoredProc;
    clmOstatokSklad: TcxGridDBColumn;
    pmGridDetails: TPopupMenu;
    MenuItem1: TMenuItem;
    N1: TMenuItem;
    aClientOrder: TAction;
    dxbrbtn5: TdxBarButton;
    clmDetailsPRICE_ROZN: TcxGridDBColumn;
    clmDetailsPRICE_OPT: TcxGridDBColumn;
    clmMainG_NONCASH_PAY_TYPE_NAME: TcxGridDBColumn;
    sbiCheck: TdxBarSubItem;
    btnPrintOnPrinter: TdxBarButton;
    btnPrintOnFr: TdxBarButton;
    SQLTransaction: TpFIBDataSet;
    spPaymentTypes: TpFIBDataSet;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aRefreshChildExecute(Sender: TObject);
    procedure dcBeginChange(Sender: TObject);
    procedure aInvoicePayExecute(Sender: TObject);
    procedure aInvoiceExecute(Sender: TObject);
    procedure aWayBillExecute(Sender: TObject);
    procedure grZakazDetailsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure aBillExecute(Sender: TObject);
    procedure aBillSpecExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aPkoExecute(Sender: TObject);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvMainCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure aPrintSimpleExecute(Sender: TObject);
    procedure aDoReturnExecute(Sender: TObject);
    procedure tvMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tvDetailsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure aClientOrderExecute(Sender: TObject);
    procedure btnPrintOnPrinterClick(Sender: TObject);
    procedure btnPrintOnFrClick(Sender: TObject);
  private
    FMode : Integer;
    procedure RefreshChild;
    procedure PrintCheck(PrintOnPrintersLoc, PrintOnFrLoc : Boolean);
    function FillLog : string;
  public
    constructor CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String = '');
    procedure InsData; override;
    procedure UpdData; override;
    procedure ReadList; override;
    procedure InsLikeData; override;
  end;

var
  ProdazhaTovaraListForm: TProdazhaTovaraListForm;

implementation

uses frmProdazhaTovaraN, frmInvoicePay, frmInvoice, frmWayBill, dmReports,
frmDoc, frmPrihodTovaraN, unErrorHandlers, unLog, frmChooseFirmAndAddress, unFRPrinted;

{$R *.dfm}

constructor TProdazhaTovaraListForm.CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String);
var Caption_ : String;
  //onChangeEvent : TcxDBGridFilterChangedEvent;
begin
  FMode := Prizn;

  IF FMode = 0 THEN BEGIN
    Caption_ := 'Продажа товара';
    HELPC := 18;
  END ELSE if FMode = 1 THEN BEGIN
    Caption_ := 'Списание товара';
    HELPC := 19;
  END ELSE IF FMode = 3 THEN BEGIN
    Caption_ := 'Перемещение товара на другой склад';
    HELPC := 52;
  END ELSE IF FMode = 4 THEN BEGIN
    Caption_ := 'Возврат товара поставщику';
    HELPC := 52;
  END;

  inherited Create(AOwner, Caption_, ActionName);

  Self.Caption := Caption_;

  // кнопка Добавить копию доступна только при 'Перемещение товара на другой склад'
  aInsLike.Visible := False;

  IF FMode IN [1, 3, 4] THEN BEGIN
    //onChangeEvent := dxDBGrid.OnFilterChanged;
    //dxDBGrid.OnFilterChanged := nil;

    if FMode = 3 then begin
      clmMainCLIENT_NAME.Caption := 'Склад-получатель';
      aInsLike.Visible := True;
    end else if FMode = 4 then
      clmMainCLIENT_NAME.Caption := 'Поставщик'
    else
      clmMainCLIENT_NAME.Destroy;  // если списание то колонка не нужна

    if FMode IN [1, 3, 4] THEN BEGIN
      aBill.Visible := False;
      sbiCheck.Visible := ivNever;
      aInvoice.Visible := False;
      aInvoicePay.Visible := FALSE;
      aPko.Visible := False;
      aAkt.Visible := False;
      aDoReturn.Visible := False;
      aWayBill.Visible := False;
      aClientOrder.Visible := False;
    END;

    clmMainSUMM_PAY_BONUS.Destroy;
    clmMainSUMM_BONUS_GOT.Destroy;
    clmtv1DISCOUNT_PERC.Destroy;
    clmtv1DISCOUNT_SUMM.Destroy;
    clmMainIS_RESERVE.Destroy;
    clmMainG_NONCASH_PAY_TYPE_NAME.Destroy;

    if FMode <> 4 then begin
      clmMainIS_PAYED_ALL.Destroy;
      clmMainSUM_FACT.Destroy;
      clmMainSUMM_CASH.Destroy;
      clmMainSUMM_NONCASH.Destroy;
    end;

    //dxDBGrid.OnFilterChanged := onChangeEvent;
  END
  ELSE IF FMode = 0 THEN BEGIN
    clmDetailsPRICE_ROZN.Destroy;
    clmDetailsPRICE_OPT.Destroy;

    // логика:
    // 1) Если подключен ТОЛЬКО принтер или ТОЛЬКО ФР, то кнопка "Товарный чек" видима,
    //    а subitem "Товарный чек" - нет
    // 2) И наоборот, если подключен и принтер чеков и ФР, то subitem "Товарный чек" видимый, а
    //    кнопка "Товарный чек" - нет
    if (PrintOnPrinters) and (PrintOnFr) then begin
      aBill.Visible := False;
      sbiCheck.Visible := ivAlways;
    end else begin
      aBill.Visible := True;
      sbiCheck.Visible := ivNever;
    end
  END;

  // если конфигурация магазин, то эти колонки не нужны
  if (Config <> 1) or (FMode <> 0) then
    clmMainBY_RECIPE.Destroy;
end;

procedure TProdazhaTovaraListForm.ReadList;
begin
  spRead.PARAMByName('DATE_BEGIN_').AsDate := dcBegin.Date;
  spRead.PARAMByName('DATE_END_').AsDate := dcEnd.Date;
  spRead.PARAMByName('IS_SPISANIE_').AsInteger := FMode;
  spRead.PARAMByName('SALE_OF_GOODS_').AsInteger := SetSaleOfGoods;

  inherited;
  RefreshChild;
  dxBarSubItem.Enabled := spRead.RecordCount > 0;
end;

procedure TProdazhaTovaraListForm.tvDetailsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ActiveListControl := TcxGridLevel(tvDetails.Level).Control as TcxGrid;
  ActiveTVControl   := tvDetails;
end;

procedure TProdazhaTovaraListForm.tvMainCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  try
    //ADone := False;  {Надо прорисовать ячейку после задания цвета}
    IF FMode in [0, 2, 4] then begin    // т.к. для списания и перемещения колонка уничтожается, то и нет смысла ее тут анализировать
      if (AViewInfo.GridRecord.Values[clmMainIS_PAYED_ALL.index] = 0) then begin
        if AViewInfo.Selected then begin
          ACanvas.Brush.Color:= clRed;
          ACanvas.Font.Color:= clWhite;
        end else begin
          ACanvas.Brush.Color:= clWindow;
          ACanvas.Font.Color:= clRed;
        end;
      end;
      {Value1 := ANode.Values[TdxDBGrid(Sender).ColumnByFieldName('IS_PAYED_ALL').Index];
      if ANode.Selected then
      begin
        // ОПЛАЧЕННЫЕ выделяются цветом
        if Value1 = '0' then
        begin
          AColor := clWhite;
          AFont.Color := clRed;
        end;
      end else begin
        // ОПЛАЧЕННЫЕ выделяются цветом
        if Value1 = '0' then
        begin
          AColor := clRed;
          AFont.Color := clWhite;
        end;
      end;}
    end;
  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TProdazhaTovaraListForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  aRefreshChild.Execute;
end;

procedure TProdazhaTovaraListForm.tvMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ActiveListControl := TcxGridLevel(tvMain.Level).Control as TcxGrid;
  ActiveTVControl   := tvMain;
end;

procedure TProdazhaTovaraListForm.InsData;
begin
  if ((HaveRightInsSale = False) and (FMode = 0)) or
  ((HaveRightInsSpisanie = False) and (FMode = 1)) or
  ((HaveRightInsMove = False) and (FMode = 3)) then begin
    MessageDlg('У Вас нет прав на создание накладных!', mtInformation, [mbOk], 0);
    Exit;
  end;

  ProdazhaTovaraNForm := TProdazhaTovaraNForm.Create(Self);
  try
    ProdazhaTovaraNForm.OpenMode := omInsert;
    ProdazhaTovaraNForm.Is_spisanie := FMode;
    if ProdazhaTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('zakaz', ProdazhaTovaraNForm.RecID, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    FreeAndNil(ProdazhaTovaraNForm);
  end;
end;

procedure TProdazhaTovaraListForm.InsLikeData;
begin
  if ((HaveRightInsSale = False) and (FMode = 0)) or
  ((HaveRightInsSpisanie = False) and (FMode = 1)) or
  ((HaveRightInsMove = False) and (FMode = 3)) then begin
    MessageDlg('У Вас нет прав на создание накладных!', mtInformation, [mbOk], 0);
    Exit;
  end;

  ProdazhaTovaraNForm := TProdazhaTovaraNForm.Create(Self);
  try
    ProdazhaTovaraNForm.OpenMode := omInsertLike;
    ProdazhaTovaraNForm.Is_spisanie := FMode;
    ProdazhaTovaraNForm.RecId := spRead.FieldByName('zakaz').AsLargeInt;
    if ProdazhaTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('zakaz', ProdazhaTovaraNForm.RecID, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    FreeAndNil(ProdazhaTovaraNForm);
  end;
end;

procedure TProdazhaTovaraListForm.UpdData;
begin
  if spRead.FieldByName('is_spisanie').AsInteger = 2 then begin
    MessageDlg('Данная продажа является оплатой за товар, выданный под реализацию.' + #10#13 +  'Доступно для редактирования в режиме "Выдача под реализацию"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  ProdazhaTovaraNForm := TProdazhaTovaraNForm.Create(Self);
  try
    ProdazhaTovaraNForm.OpenMode := omUpdate;
    ProdazhaTovaraNForm.Is_spisanie := FMode;
    if spRead.FieldByName('INVOICE_PAY').AsString <> '' then
      ProdazhaTovaraNForm.InvoicePay := spRead.FieldByName('INVOICE_PAY').AsLargeInt;
    ProdazhaTovaraNForm.RecId := spRead.FieldByName('zakaz').AsLargeInt;
    if ProdazhaTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('zakaz', ProdazhaTovaraNForm.RecID, []);
    end;
  finally
    FreeAndNil(ProdazhaTovaraNForm);
  end;
end;

procedure TProdazhaTovaraListForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'zakaz';
  KeyFieldClass := 'zakaz_';
  inherited;
end;

procedure TProdazhaTovaraListForm.aDelExecute(Sender: TObject);
begin
  if ((HaveRightDelSale = False) and (FMode = 0)) or
  ((HaveRightDelSpisanie = False) and (FMode = 1)) or
  ((HaveRightDelMove = False) and (FMode = 3))  then begin
    MessageDlg('У Вас нет прав на удаление накладных"!', mtInformation, [mbOk], 0);
    Exit;
  end;

  if spRead.FieldByName('is_spisanie').AsInteger = 2 then begin
    MessageDlg('Данная продажа является оплатой за товар, выданный под реализацию.' + #10#13 +  'Доступно для редактирования в режиме "Выдача под реализацию"!', mtInformation, [mbOk], 0);
    Exit;
  end;
  
  if MessageDlg(Format('Удалить запись № "%s" ?',
    [spRead.FieldByName('z_num').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spDEl.ParamByName('IS_SPISANIE_').AsInteger := spRead.FieldByName('is_spisanie').AsInteger;
  spDEl.ParamByName('LOG_BODY_').AsString := FillLog;
  spDEl.ParamByName('USER_ID_').AsInt64 := CurrentOfficial;
  if (StrToInt(Copy(ExportDataType, 5, 1)) = 1) or (UploadToMobile) then
    spDEl.ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 1
  else
    spDEl.ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;

  inherited;
end;



procedure TProdazhaTovaraListForm.aDoReturnExecute(Sender: TObject);
begin
  PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
  try
    PrihodTovaraNForm.OpenMode := omInsert;
    PrihodTovaraNForm.Is_vozvrat := 1;
    PrihodTovaraNForm.Zakaz := spRead.FieldByName('zakaz').AsLargeInt;
    PrihodTovaraNForm.ZakazNote := 'Чек №' + spRead.FieldByName('zakaz').AsString + ' от ' +
      spRead.FieldByName('z_date').AsString + ' ' + spRead.FieldByName('z_time').AsString +
      ', на сумму ' + spRead.FieldByName('sum_zakaz').AsString;

    PrihodTovaraNForm.ClientLoc := spRead.FieldByName('g_client').AsLargeInt;
    if PrihodTovaraNForm.ShowModal = mrOK then begin
      ShowMessage('Возврат сохранен успешно!');
    end;
  finally
    FreeAndNil(PrihodTovaraNForm);
  end;
end;

procedure TProdazhaTovaraListForm.aRefreshChildExecute(Sender: TObject);
begin
  RefreshChild;
end;

procedure TProdazhaTovaraListForm.RefreshChild;
begin
  spZakazDetails.PARAMByName('zakaz_').AsInt64 := spRead.FieldByName('zakaz').AsLargeInt;
  spZakazDetails.PARAMByName('IS_SPISANIE_').AsInteger := FMode;
  spZakazDetails.PARAMByName('HAVE_RIGHT_TO_SEE_COST_PRICE_').AsInteger := Integer(HaveRightToSeeCostPrice);

  Screen.Cursor := crSQLWait;
  OpenSp(spZakazDetails, False);
  Screen.Cursor := crDefault;

  stDetailsCount.Caption := Format('%.5d', [spZakazDetails.AllRecordCount]);
end;

procedure TProdazhaTovaraListForm.dcBeginChange(Sender: TObject);
begin
  inherited;
  Readlist;
end;

procedure TProdazhaTovaraListForm.aInvoicePayExecute(Sender: TObject);
begin
  inherited;
  ClassForm := TInvoicePayForm.Create(Self);
  try
    if spRead.FieldByName('INVOICE_PAY').AsString <> '' then
      ClassForm.RecID := spRead.FieldByName('INVOICE_PAY').AsLargeInt
    else
      (ClassForm as TInvoicePayForm).NotSaved := 1;

    (ClassForm as TInvoicePayForm).Zakaz := spRead.FieldByName('zakaz').AsLargeInt;
    ClassForm.OpenMode := omUpdate;
    ClassForm.ShowModal;
    ReadList;
  finally
    ClassForm.Free;
  end;
end;

procedure TProdazhaTovaraListForm.aInvoiceExecute(Sender: TObject);
begin
  inherited;
  ClassForm := TInvoiceForm.Create(Self);
  try
    if spRead.FieldByName('INVOICE').AsString <> '' then
      ClassForm.RecID := spRead.FieldByName('INVOICE').AsLargeInt
    else
      (ClassForm as TInvoiceForm).NotSaved := 1;

    (ClassForm as TInvoiceForm).Zakaz    := spRead.FieldByName('zakaz').AsLargeInt;
    ClassForm.OpenMode := omUpdate;
    ClassForm.ShowModal;
    ReadList;
  finally
    ClassForm.Free;
  end;
end;

procedure TProdazhaTovaraListForm.aWayBillExecute(Sender: TObject);
begin
  ClassForm := TWayBillForm.Create(Self);
  try
    if spRead.FieldByName('WAYBILL').AsString <> '' then
      ClassForm.RecID := spRead.FieldByName('WAYBILL').AsLargeInt
    else
      (ClassForm as TWayBillForm).NotSaved := 1;

    (ClassForm as TWayBillForm).Zakaz := spRead.FieldByName('zakaz').AsLargeInt;
    (ClassForm as TWayBillForm).Is_spisanie := spRead.FieldByName('is_spisanie').AsInteger;
    ClassForm.OpenMode := omUpdate;
    ClassForm.ShowModal;
    ReadList;
  finally
    ClassForm.Free;
  end;
end;

procedure TProdazhaTovaraListForm.aPkoExecute(Sender: TObject);
begin
  ClassForm := TDocForm.Create(Self);
  try
    (ClassForm as TDocForm).Zakaz := spRead.FieldByName('zakaz').AsLargeInt;
    IF (Sender AS tAction).Name = 'aPko' then
      (ClassForm as TDocForm).DocType := 0
    else
      (ClassForm as TDocForm).DocType := 1;
    ClassForm.OpenMode := omUpdate;
    ClassForm.ShowModal;
    ReadList;
  finally
    ClassForm.Free;
  end;
end;

procedure TProdazhaTovaraListForm.aPrintSimpleExecute(Sender: TObject);
begin
  if FMode = 1 then
    ReportsDM.PrepareReport(52)
  else if FMode = 4 then
    ReportsDM.PrepareReport(54)
  else if FMode = 3 then
    ReportsDM.PrepareReport(53)
  else
    ReportsDM.PrepareReport(44);

  if FMode = 3 then
    ReportsDM.spReport.ParamByName('SKLAD_PARENT_').AsInt64 := spRead.FieldByName('ZAKAZ').AsLargeInt
  else
    ReportsDM.spReport.ParamByName('ZAKAZ_').AsInt64 := spRead.FieldByName('ZAKAZ').AsLargeInt;
  ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
  ReportsDM.ShowReport(1, '');
end;

procedure TProdazhaTovaraListForm.grZakazDetailsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ActiveListControl := grZakazDetails;
end;

procedure TProdazhaTovaraListForm.aBillExecute(Sender: TObject);
begin
  if not HaveRightPrintCheck then begin
    MessageDlg('Вы не обладаете правом печатать чеки.', mtWarning, [mbOk], 0);
    Exit;
  end;

  {
  Перенесено в dmReports
  if (CheckPrintDeviceFr > 0) and (PrintOnFr) then
    if MessageDlg('Скорее всего чек уже был распечатан и отправлен в ОФД. Вы уверены, что хотите повторно распечатать чек '+
    'на фискальном регистраторе?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
      Exit;
  }

  PrintCheck(PrintOnPrinters, PrintOnFr);
end;

procedure TProdazhaTovaraListForm.btnPrintOnFrClick(Sender: TObject);
begin
  PrintCheck(False, True);
end;

procedure TProdazhaTovaraListForm.btnPrintOnPrinterClick(Sender: TObject);
begin
  PrintCheck(True, False);
end;

procedure TProdazhaTovaraListForm.PrintCheck(PrintOnPrintersLoc, PrintOnFrLoc : Boolean);
var
  NonCashPayType, BillWidth: Integer;
begin
  if (PrintOnPrintersLoc = false) and (PrintOnFrLoc = false) then begin
    MessageDlg('Не задано устройство для печати чеков! Укажите принтер в настройках программы.', mtError, [mbOk], 0);
    Exit;
  end;
  {SQLTransaction.Close;
                  SQLTransaction.SQLs.SelectSQL.Clear;
                  SQLTransaction.SQLs.SelectSQL.Add('SELECT G_NONCASH_PAY_TYPE FROM ZAKAZ WHERE ZAKAZ='+IntToStr(spRead.FieldByName('zakaz').AsLargeInt)+
                  ' AND POS_TERMINAL='+IntToStr(Terminal));
                  SQLTransaction.Open;
                  if SQLTransaction.FieldByName('G_NONCASH_PAY_TYPE').IsNull then
                  begin
                    NonCashPayType := 0;
                  end
                  else
                  begin
                    NonCashPayType := spRead.FieldByName('G_NONCASH_PAY_TYPE').AsInteger;
                  end;}

  if CheckPrintDeviceFr = 6 then
  begin
    OpenSP(spPaymentTypes, False);
    spPaymentTypes.Locate('G_NONCASH_PAY_TYPE', spRead.FieldByName('G_NONCASH_PAY_TYPE').AsInteger, [loCaseInsensitive]);
    NonCashPayType := spPaymentTypes.FieldByName('IS_TIS_TYPE').AsInteger;
  end
  else
    NonCashPayType := 0;

  if PrintOnFrLoc then
  begin
    if not PrintBillAll(spRead.FieldByName('zakaz').AsLargeInt, spRead.FieldByName('SUM_ZAKAZ').AsFloat,
                      spRead.FieldByName('SUMM_CASH').AsFloat, spRead.FieldByName('SUMM_NONCASH').AsFloat,
                      0, 0, FormatSettings.CurrencyDecimals, spRead.FieldByName('SUMM_BONUS_GOT').AsFloat,
                      spRead.FieldByName('SUMM_PAY_BONUS').AsFloat,
                      spRead.FieldByName('ADDRESS').AsString, True,
                      PrintOnPrintersLoc,
                      PrintOnFrLoc,
                      '', NonCashPayType, spRead.FieldByName('BONUSALL').AsFloat, True, spRead.FieldByName('REQUEST_NUMBER').AsString)
    then
    begin
      ReportsDM.PrintBill(spRead.FieldByName('zakaz').AsLargeInt, spRead.FieldByName('SUM_ZAKAZ').AsFloat,
                      spRead.FieldByName('SUMM_CASH').AsFloat, spRead.FieldByName('SUMM_NONCASH').AsFloat, 0, 0,
                      FormatSettings.CurrencyDecimals, spRead.FieldByName('SUMM_BONUS_GOT').AsFloat,
                      spRead.FieldByName('ADDRESS').AsString, True, PrintOnPrintersLoc, PrintOnFrLoc, spRead.FieldByName('BONUSALL').AsFloat, NonCashPayType);
    end;
  end
  else
    ReportsDM.PrintBill(spRead.FieldByName('zakaz').AsLargeInt, spRead.FieldByName('SUM_ZAKAZ').AsFloat,
                      spRead.FieldByName('SUMM_CASH').AsFloat, spRead.FieldByName('SUMM_NONCASH').AsFloat, 0, 0,
                      FormatSettings.CurrencyDecimals, spRead.FieldByName('SUMM_BONUS_GOT').AsFloat,
                      spRead.FieldByName('ADDRESS').AsString, True, PrintOnPrintersLoc, PrintOnFrLoc, spRead.FieldByName('BONUSALL').AsFloat, NonCashPayType);
end;

procedure TProdazhaTovaraListForm.aBillSpecExecute(Sender: TObject);
begin
  PrintCheck(PrintOnPrinters, PrintOnFr);
end;

procedure TProdazhaTovaraListForm.aClientOrderExecute(Sender: TObject);
var
  ChooseFirmAndAddressForm: TChooseFirmAndAddressForm;
begin
  ChooseFirmAndAddressForm := TChooseFirmAndAddressForm.Create(Self);
  try
    if (ChooseFirmAndAddressForm.spFirm.RecordCount > 1) then
      ChooseFirmAndAddressForm.ShowModal;

    ReportsDM.PrepareReport(70);

    ReportsDM.spReport.ParamByName('ZAKAZ_').AsInt64 := spRead.FieldByName('ZAKAZ').AsLargeInt;
    ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
    ReportsDM.spReport.ParamByName('G_OFFICIAL_').AsInt64 := CurrentOfficial;
    ReportsDM.spReport.ParamByName('G_FIRM_REKVIZIT_').AsInt64 := ChooseFirmAndAddressForm.leFirm.EditValue;
    ReportsDM.spReport.ParamByName('G_FIRM_ADDRESS_').AsInt64 := ChooseFirmAndAddressForm.leAddress.EditValue;
    ReportsDM.ShowReport(1, '');
  finally
    FreeAndNil(ChooseFirmAndAddressForm);
  end;
end;

procedure TProdazhaTovaraListForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  // aBillSpec делался специально для Артема Тихомирова, поэтому он будет виден только для него, изначально выслал ему настройку в INI файл
  // и только он его видит
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings_grid.ini');
  try
    //aBillSpec.Visible := Ini.ReadInteger('ProdazhaTovaraList', 'BillSpec', 0) = 1;
    grZakazDetails.Height := Ini.ReadInteger('ProdazhaTovaraList', 'SplitterPos', 150);   //у сплиттера не работает положение из ИНИ, приходится выкручиваться высотой cxdvZakazDetails
  finally
    Ini.Free;
  end;
end;

function TProdazhaTovaraListForm.FillLog: string;
var str : string;
  mode : integer;
begin
  if FMode = 1 then begin
    str  := '';
    mode := 2;
  end else begin
    str := spRead.FieldByName('CLIENT_NAME').AsString;
    case FMode of
      0 : mode := 1;
      2 : mode := 3;
      3 : mode := 6;
      4 : mode := 7;
    end;
  end;

  Result := FillInsWayBill(mode, spRead.FieldByName('Z_DATE').AsDateTime, spRead.FieldByName('Z_TIME').AsDateTime,
    str, spRead.FieldByName('SUM_ZAKAZ').AsFloat, spRead.FieldByName('SUM_FACT').AsFloat,
    spRead.FieldByName('SUMM_BONUS_GOT').AsFloat, spRead.FieldByName('SUMM_PAY_BONUS').AsFloat,
    spZakazDetails);
end;

procedure TProdazhaTovaraListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;

  // aBillSpec делался специально для Артема Тихомирова, поэтому он будет виден только для него, изначально выслал ему настройку в INI файл
  // и только он его видит
  //if aBillSpec.Visible then begin
    Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings_grid.ini');
    try
      //Ini.WriteInteger('ProdazhaTovaraList', 'BillSpec', 1);
      Ini.WriteInteger('ProdazhaTovaraList', 'SplitterPos', grZakazDetails.Height);
    finally
      Ini.Free;
    end;
  //end;

  tvMain.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvMain.name);
  tvDetails.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvDetails.name);
end;

end.
