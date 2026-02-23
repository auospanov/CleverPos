unit frmZakazNaRealList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, FIBQuery, pFIBQuery, pFIBStoredProc, DB, FIBDataSet,
  pFIBDataSet, ExtCtrls, Menus, FIBDatabase, pFIBDatabase, ActnList, dxBar,
  dxBarExtItems, frmDBEdit, unCommonFunc, cxControls, cxSplitter,
  StdCtrls, Buttons, frmDBDlg, IniFiles, cxGraphics, cxLookAndFeels,
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
  cxContainer, cxClasses, cxGridLevel, cxGridCustomView, cxGrid, cxTextEdit,
  System.UITypes, cxNavigator, System.Actions;

type
  TZakazNaRealListForm = class(TDBListForm)
    bcFilter: TdxBarCombo;
    aPay: TAction;
    splOplataReal: TcxSplitter;
    Panel1: TPanel;
    stDetailsCount: TStaticText;
    Panel2: TPanel;
    splOplataReal2: TcxSplitter;
    spReadOplata: TpFIBDataSet;
    dsReadOplata: TDataSource;
    spZakazDetails: TpFIBDataSet;
    dsZakazDetails: TDataSource;
    aRefreshChild: TAction;
    stZakazCount: TStaticText;
    btnUpdChd: TBitBtn;
    btnDelChd: TBitBtn;
    aUpdZakaz: TAction;
    aDelZakaz: TAction;
    spDelOplata: TpFIBStoredProc;
    aUpdParent: TAction;
    aDelParent: TAction;
    aViewParent: TAction;
    spDelNakl: TpFIBStoredProc;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    aReturn: TAction;
    dxBarButton2: TdxBarButton;
    spDelVozvrat: TpFIBStoredProc;
    dxBarButton3: TdxBarButton;
    grOplata: TcxGrid;
    tvOplata: TcxGridDBTableView;
    lv2: TcxGridLevel;
    clmMainZAKAZ_NA_REAL: TcxGridDBColumn;
    clmMainG_CLIENT: TcxGridDBColumn;
    clmMainCLIENT_NAME: TcxGridDBColumn;
    clmMainZAKAZ_NUM: TcxGridDBColumn;
    clmMainZAKAZ_DATE: TcxGridDBColumn;
    clmMainPRODUCT_NAME: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainAMOUNT_ALL: TcxGridDBColumn;
    clmMainSUMM_ALL: TcxGridDBColumn;
    clmMainAMOUNT_PAYED: TcxGridDBColumn;
    clmMainSUMM_PAYED: TcxGridDBColumn;
    clmMainAMOUNT_RETURNED: TcxGridDBColumn;
    clmMainSUMM_RETURNED: TcxGridDBColumn;
    clmMainAMOUNT_LEFT: TcxGridDBColumn;
    clmMainSUMM_LEFT: TcxGridDBColumn;
    clmMainIS_PAYED_ALL: TcxGridDBColumn;
    clmMainPRODCAT_NAME: TcxGridDBColumn;
    clmtv2ZAKAZ: TcxGridDBColumn;
    clmtv2Z_NUM: TcxGridDBColumn;
    clmtv2Z_DATE: TcxGridDBColumn;
    clmtv2OSNOVANIE: TcxGridDBColumn;
    clmtv2NOTE: TcxGridDBColumn;
    clmtv2CLIENT_NAME: TcxGridDBColumn;
    clmtv2PAYMENT_NAME: TcxGridDBColumn;
    clmtv2SUM_ZAKAZ: TcxGridDBColumn;
    clmtv2TYPE_STR: TcxGridDBColumn;
    gr2: TcxGrid;
    tvDetailsNew: TcxGridDBTableView;
    clmtv1TOVAR_NAME: TcxGridDBColumn;
    clmtv1AMOUNT: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    clmtv1SUMM: TcxGridDBColumn;
    clmtv1DISCOUNT_PERC: TcxGridDBColumn;
    clmtv1DISCOUNT_SUMM: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1ED_NAME: TcxGridDBColumn;
    lv1: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure bcFilterChange(Sender: TObject);
    procedure aPayExecute(Sender: TObject);
    procedure aRefreshChildExecute(Sender: TObject);
    procedure aUpdZakazExecute(Sender: TObject);
    procedure aDelZakazExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aViewParentExecute(Sender: TObject);
    procedure aUpdParentExecute(Sender: TObject);
    procedure aDelParentExecute(Sender: TObject);
    procedure aReturnExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvOplataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure tvMainCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    procedure WMPayForReal(var Message: TMessage); message WM_PAYFORREAL;
    procedure WMReturnForReal(var Message: TMessage); message WM_RETURNFORREAL;
  public
    procedure ViewData; override;
    procedure DelData; override;
    procedure InsData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  protected
    procedure PayForReal;
    procedure ReturnForReal;
  end;

var
  ZakazNaRealListForm: TZakazNaRealListForm;

implementation

uses frmProdazhaTovaraN, frmZakazNaReal, frmOplataTovaraRealN,
  frmZakazRealParent;

{$R *.dfm}

procedure TZakazNaRealListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'zakaz_na_real';
  KeyFieldClass := 'zakaz_na_real_';
end;

procedure TZakazNaRealListForm.ViewData;
begin
  ClassForm := TZakazNaRealForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TZakazNaRealListForm.InsData;
begin
  ProdazhaTovaraNForm := TProdazhaTovaraNForm.Create(Self);
  try
    ProdazhaTovaraNForm.OpenMode := omInsert;
    ProdazhaTovaraNForm.Is_spisanie := 2;    // РЕЖИМ ВЫДАЧИ ТОВАРА ПОД РЕАЛИЗАЦИЮ
    ProdazhaTovaraNForm.Client := spRead.FieldByname('g_client').AsInteger;
    if ProdazhaTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate(KeyFieldList, ProdazhaTovaraNForm.RecID, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    ProdazhaTovaraNForm.Free;
  end;
end;

procedure TZakazNaRealListForm.UpdData;
begin
  ClassForm := TZakazNaRealForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
    spRead.Locate(KeyFieldList, (ClassForm as TZakazNaRealForm).RecID, []);
  finally
    ClassForm.Free;
  end;
end;

procedure TZakazNaRealListForm.DelData;
begin
  if MessageDlg(Format('Удалить товар "%s" ?',
    [spRead.FieldByName('PRODUCT_NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  inherited;
end;

procedure TZakazNaRealListForm.ReadList;
begin
  spRead.ParamByName('MODE_').AsInteger := bcFilter.ItemIndex;

  inherited;

  aPay.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('IS_PAYED_ALL').AsInteger = 0);
  aReturn.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('IS_PAYED_ALL').AsInteger = 0);
  aRefreshChild.Execute;
end;

procedure TZakazNaRealListForm.bcFilterChange(Sender: TObject);
begin
  inherited;
  Readlist;
end;

procedure TZakazNaRealListForm.aPayExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_PAYFORREAL, 0, 0);
end;

procedure TZakazNaRealListForm.aReturnExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_RETURNFORREAL, 0, 0);
end;

procedure TZakazNaRealListForm.WMPayForReal(var Message: TMessage);
begin
  PayForReal;
end;

procedure TZakazNaRealListForm.WMReturnForReal(var Message: TMessage);
begin
  ReturnForReal;
end;

procedure TZakazNaRealListForm.PayForReal;
begin

  OplataTovaraRealNForm := TOplataTovaraRealNForm.Create(Self);
  try
    OplataTovaraRealNForm.Client := spRead.FieldByname('g_client').AsInteger;
    OplataTovaraRealNForm.OpenMode := omInsert;
    if OplataTovaraRealNForm.Showmodal = mrOK then BEGIN
      Readlist;
      spReadOplata.Locate('ZAKAZ', OplataTovaraRealNForm.RecId, []);
    END;
  finally
    OplataTovaraRealNForm.free;
  end;
end;


procedure TZakazNaRealListForm.ReturnForReal;
begin
  OplataTovaraRealNForm := TOplataTovaraRealNForm.Create(Self);
  try
    OplataTovaraRealNForm.Client := spRead.FieldByname('g_client').AsInteger;
    OplataTovaraRealNForm.OpenMode := omInsert;
    OplataTovaraRealNForm.Mode := 1;   // укажу что идет возврат товара
    if OplataTovaraRealNForm.Showmodal = mrOK then
      Readlist;
  finally
    OplataTovaraRealNForm.free;
  end;
end;

procedure TZakazNaRealListForm.tvOplataFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  spZakazDetails.PARAMByName('zakaz_').AsInteger := spReadOplata.FieldByName('zakaz').AsInteger;
  spZakazDetails.PARAMByName('IS_VOZVRAT_').AsInteger := spReadOplata.FieldByName('IS_VOZVRAT').AsInteger;
  OpenSp(spZakazDetails, True);
  stDetailsCount.Caption := Format('%.5d', [spZakazDetails.AllRecordCount]);
end;

procedure TZakazNaRealListForm.tvMainCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  IF bcFilter.ItemIndex = 3 THEN BEGIN
    if (AViewInfo.GridRecord.Values[clmMainIS_PAYED_ALL.index] = 0) then begin
      if AViewInfo.Selected then begin
        ACanvas.Brush.Color:= clRed;
        ACanvas.Font.Color:= clWhite;
      end else begin
        ACanvas.Brush.Color:= clWindow;
        ACanvas.Font.Color:= clRed;
      end;
    end;




    {if AViewInfo.Selected then
    begin
      // ОПЛАЧЕННЫЕ выделяются цветом
      if AViewInfo.GridRecord.Values[clmMainIS_PAYED_ALL.index] = 1 then
      begin
        if AViewInfo.Selected then begin
          ACanvas.Brush.Color:= clWhite;
          ACanvas.Font.Color:= clTeal;
        end else begin
          ACanvas.Brush.Color:= clWindow;
          ACanvas.Font.Color:= clRed;
        end;

        AColor := clWhite;
        AFont.Color := clTeal;
      end;
    end else begin
      // ОПЛАЧЕННЫЕ выделяются цветом
      if AViewInfo.Values[TdxDBGrid(Sender).ColumnByFieldName('IS_PAYED_ALL').Index] = '1' then
      begin
        AColor := clTeal;
        AViewInfo.Color := clWhite;
      end;
    end;}
  END;
end;

procedure TZakazNaRealListForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  aPay.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('IS_PAYED_ALL').AsInteger = 0);
  aRefreshChild.Execute;
end;

procedure TZakazNaRealListForm.aRefreshChildExecute(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;

  spReadOplata.ParamByName('G_CLIENT_').AsInteger := spRead.FieldByName('G_CLIENT').AsInteger;
  OpenSp(spReadOplata, True);
  spZakazDetails.PARAMByName('zakaz_').AsInteger := spReadOplata.FieldByName('zakaz').AsInteger;
  spZakazDetails.PARAMByName('IS_VOZVRAT_').AsInteger := spReadOplata.FieldByName('IS_VOZVRAT').AsInteger;
  OpenSp(spZakazDetails, True);

  stZakazCount.Caption := Format('%.5d', [spReadOplata.AllRecordCount]);
  stDetailsCount.Caption := Format('%.5d', [spZakazDetails.AllRecordCount]);

  Screen.Cursor := crDefault;
end;

procedure TZakazNaRealListForm.aUpdZakazExecute(Sender: TObject);
begin
  OplataTovaraRealNForm := TOplataTovaraRealNForm.Create(Self);
  try
    OplataTovaraRealNForm.Client := spRead.FieldByname('g_client').AsInteger;
    OplataTovaraRealNForm.RecID := spReadOplata.FieldByName('zakaz').AsInteger;
    OplataTovaraRealNForm.Mode  := spReadOplata.FieldByName('IS_VOZVRAT').AsInteger;
    OplataTovaraRealNForm.OpenMode := omUpdate;
    if OplataTovaraRealNForm.Showmodal = mrOK then
      Readlist;
  finally
    OplataTovaraRealNForm.free;
  end;
end;

procedure TZakazNaRealListForm.aDelZakazExecute(Sender: TObject);
begin
  if spReadOplata.FieldByName('is_vozvrat').AsInteger = 0 then begin
    if MessageDlg(Format('Удалить оплату № "%s" ?',
      [spReadOplata.FieldByName('z_num').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;
    spDelOplata.ParamByName('zakaz_').AsInteger := spReadOplata.FieldByName('zakaz').AsInteger;
    if ExecSPTR(spDelOplata) then begin
      ShowMessage('Удалено успешно!');
      Readlist;
    end

  end else begin
    if MessageDlg(Format('Удалить возврат № "%s" ?',
      [spReadOplata.FieldByName('z_num').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;
    spDelVozvrat.ParamByName('sklad_').AsInteger := spReadOplata.FieldByName('zakaz').AsInteger;
    spDelVozvrat.ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
    if ExecSPTR(spDelVozvrat) then begin
      ShowMessage('Удалено успешно!');
      Readlist;
    end
  end;
end;

procedure TZakazNaRealListForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  //выставляю положения сплиттеров
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    if Ini.ReadInteger('Splitters', 'splOplataReal', 0) = 0 then
      Panel2.Height := Screen.Height div 3                               //почему-то положение Splitter.PositionAfterOpen не работает, поэтому пришлось так делать, ширину и длину панелей ставить
    else
      Panel2.Height := Ini.ReadInteger('Splitters', 'splOplataReal', 0);

    if Ini.ReadInteger('Splitters', 'splOplataReal2', 0) = 0 then
      grOplata.width := Screen.Width div 2
    else
      grOplata.width := Ini.ReadInteger('Splitters', 'splOplataReal2', 0);
  finally
    Ini.Free;
  end;
end;

procedure TZakazNaRealListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  // сохраняю позиции сплиттеров
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    Ini.WriteInteger('Splitters', 'splOplataReal', Panel2.Height);      //почему-то положение Splitter.PositionAfterOpen не работает, поэтому пришлось так делать, ширину и длину панелей ставить
    Ini.WriteInteger('Splitters', 'splOplataReal2', grOplata.width);
  finally
    Ini.Free;
  end;

  tvOplata.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvOplata.name);
  tvDetailsNew.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvDetailsNew.name);
end;

procedure TZakazNaRealListForm.aViewParentExecute(Sender: TObject);
begin
  ZakazRealParentForm := TZakazRealParentForm.Create(Self);
  try
    ZakazRealParentForm.RecID := spRead.FieldByName('zakaz_real_parent').AsInteger;
    ZakazRealParentForm.OpenMode := omView;
    ZakazRealParentForm.Showmodal;
  finally
    ZakazRealParentForm.free;
  end;
end;

procedure TZakazNaRealListForm.aUpdParentExecute(Sender: TObject);
begin
  ZakazRealParentForm := TZakazRealParentForm.Create(Self);
  try
    ZakazRealParentForm.RecID := spRead.FieldByName('zakaz_real_parent').AsInteger;
    ZakazRealParentForm.OpenMode := omUpdate;
    if ZakazRealParentForm.Showmodal = mrOK then
      Readlist;
  finally
    ZakazRealParentForm.free;
  end;
end;

procedure TZakazNaRealListForm.aDelParentExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить накладную № "%s" ?',
    [spRead.FieldByName('zakaz_num').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spDelNakl.ParamByName('ZAKAZ_REAL_PARENT_').AsInteger := spRead.FieldByName('ZAKAZ_REAL_PARENT').AsInteger;
  if ExecSPTR(spDelNakl) then begin
    ShowMessage('Удалено успешно!');
    Readlist;
  end
end;

procedure TZakazNaRealListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 21;
  inherited;
end;

end.
