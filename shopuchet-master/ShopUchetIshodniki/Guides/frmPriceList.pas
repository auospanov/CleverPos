unit frmPriceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  ExtCtrls, Menus, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  ActnList, dxBar, dxBarExtItems,
  cxControls, cxSplitter, StdCtrls, Buttons, cxContainer, cxEdit,
  cxCheckBox, AppEvnts, DateUtils, unCommonFunc, Math, FIB,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, dxSkinsdxBarPainter, cxTL, cxTLdxBarBuiltInMenu,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxInplaceContainer,
  cxTLData, cxDBTL, cxClasses, cxGridLevel, cxGridCustomView, cxGrid, cxMaskEdit,
  cxTextEdit, frxClass, frxDBSet, frxBarcode, System.UITypes, cxNavigator,
  System.Actions, cxButtons, cxEditRepositoryItems, cxCurrencyEdit, TerminalMassaK_TLB,
  AddIn_TLB, dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, unLog, JvComponentBase, JvThread, Winapi.ActiveX, SHDocVw,
  cxBlobEdit;

type
  TVesTovar =  record
    ID: Int64;
    Barcode: String;
    Name: String;
    Price: Double;
  end;

  TPriceListForm = class(TDBListForm)
    splMenu: TcxSplitter;
    Panel1: TPanel;
    Panel3: TPanel;
    btnRefreshChd: TBitBtn;
    btnInsChd: TBitBtn;
    btnUpdChd: TBitBtn;
    btnDelChd: TBitBtn;
    btnViewChd: TBitBtn;
    btnInsLike: TBitBtn;
    aViewChd: TAction;
    aInsChd: TAction;
    aInsLikeChd: TAction;
    aUpdChd: TAction;
    aDelChd: TAction;
    aRefreshChdTovar: TAction;
    aInsChild: TAction;
    spReadTovar: TpFIBDataSet;
    dsReadTovar: TDataSource;
    aSetNotActive: TAction;
    spSetNotActive: TpFIBStoredProc;
    bcActive: TdxBarCombo;
    aPrintLabel: TAction;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Label10: TLabel;
    ApplicationEvents: TApplicationEvents;
    TimerChangeEd: TTimer;
    aNewPrice: TAction;
    dxBarButton2: TdxBarButton;
    aDelChdAll: TAction;
    spFindProduct: TpFIBStoredProc;
    tlCategory: TcxDBTreeList;
    grProduct: TcxGrid;
    tvProduct: TcxGridDBTableView;
    lv1: TcxGridLevel;
    clmtv1G_PRODUCT: TcxGridDBColumn;
    clmtv1G_PRODUCT_PAR: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1PRICE: TcxGridDBColumn;
    clmtv1VOLUME_PRICE: TcxGridDBColumn;
    clmtv1MF_COUNTRY: TcxGridDBColumn;
    clmtv1AMOUNT: TcxGridDBColumn;
    clmtv1AMOUNT_RESERVE: TcxGridDBColumn;
    clmtv1AMOUNT_NA_REAL: TcxGridDBColumn;
    clmtv1PLACE: TcxGridDBColumn;
    clmtv1PackAmount: TcxGridDBColumn;
    clmnCategoryNAME: TcxDBTreeListColumn;
    edBarcode: TcxTextEdit;
    btClear: TcxButton;
    aTovarAmountBySklad: TAction;
    mniTovarAmountBySklad: TMenuItem;
    N1: TMenuItem;
    clmProductNOTE: TcxGridDBColumn;
    btnExportToScales: TBitBtn;
    aExportToScales: TAction;
    clmProductSALES_COMM: TcxGridDBColumn;
    BitBtn4: TBitBtn;
    aExportPluCodes: TAction;
    clmProductBRAND: TcxGridDBColumn;
    spDelChild: TpFIBStoredProc;
    btnSetNotActive: TBitBtn;
    clmId: TcxDBTreeListColumn;
    spScalesTovs: TpFIBDataSet;
    aExportAllTovsToScales: TAction;
    mniExportAllTovsToScales: TMenuItem;
    mniN2: TMenuItem;
    clmProductVES_GRAMM_PRICE: TcxGridDBColumn;
    clmProductVES_GRAMM: TcxGridDBColumn;
    clmProductBARCODE_DOP: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aRefreshChdTovarExecute(Sender: TObject);
    procedure aViewChdExecute(Sender: TObject);
    procedure aInsChdExecute(Sender: TObject);
    procedure aInsLikeChdExecute(Sender: TObject);
    procedure aUpdChdExecute(Sender: TObject);
    procedure aDelChdExecute(Sender: TObject);
    procedure aInsChildExecute(Sender: TObject);
    procedure aSetNotActiveExecute(Sender: TObject);
    procedure bcActiveChange(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure aPrintLabelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure aDelChdAllExecute(Sender: TObject);
    procedure tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvProductCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edBarcodePropertiesChange(Sender: TObject);
    procedure aTovarAmountBySkladExecute(Sender: TObject);
    procedure aExportToScalesExecute(Sender: TObject);
    procedure tvProductFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure aExportPluCodesExecute(Sender: TObject);
    procedure aExportAllTovsToScalesExecute(Sender: TObject);
    procedure DisableChildControls;
  private
    { Private declarations }
    ByScanner : Integer;   //инициация сканером
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FIns_Child : Integer;  //признак что вызывается INSDATA для создания дочерней записи
    FrefreshProdBook : boolean; // рефрешить товары с букмарком или нет, с букмарком надо только при нажатии на кнопку "Обновить"
    Is_closing : Boolean;       // форма закрывается в данный момент
    FIs_Creating : Boolean;     // форма создается
    FNewRec : TTovarRec;
    function CheckSelectedNode : Boolean;  //выбрана ли хоть одна запись
    procedure DelManyItems;
    procedure SelectGrProductNode;
    procedure UpdChild(Id : Int64);
    procedure WMInsChild(var Message: TMessage); message WM_INSCHILD;
    procedure ExportToScales(All : Boolean = False);
    function FillLog(i : integer): string;
    function FillLogDataSet : string;
  public
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ReadList; override;
    procedure RebuildGrid;
    procedure RefreshChild;
  end;

var
  PriceListForm: TPriceListForm;
  onChangeCat : TcxTreeListFocusedNodeChangedEvent;
  RLS1000Message: cardinal;

implementation

uses frmPriceListUn, frmCategory, frmDBEdit, frmPriceListRepFilter,
  dmReports, frmPrintEtiketSetup, unErrorHandlers, frmTovarAmountBySklad, frmLogCommonDlg,
  dmMain;

{$R *.dfm}
procedure TPriceListForm.ReadList;
begin
  onChangeCat := tlCategory.OnFocusedNodeChanged;
  tlCategory.OnFocusedNodeChanged := nil;

  inherited;
  aView.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aDel.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aUpd.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aInsChild.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aInsLike.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);

  RefreshChild; //aRefreshChdTovar.Execute;
  tlCategory.OnFocusedNodeChanged := onChangeCat;
end;

procedure TPriceListForm.ViewData;
begin
  ClassForm := TCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsLargeInt;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.InsData;
var id : Int64;
begin
  ClassForm := TCategoryForm.Create(Self);
  try

    if FIns_Child = 1 then
      (ClassForm as TCategoryForm).leCategory.EditValue := spRead.FieldByName('g_product').AsLargeInt
    else begin
      // вначале проверяю я создаю группу внутри какой-то группу или в корне
      if tlCategory.FocusedNode.Parent.Values[clmId.ItemIndex] > 0 then
        (ClassForm as TCategoryForm).leCategory.EditValue := tlCategory.FocusedNode.Parent.Values[clmId.ItemIndex]
      else
        (ClassForm as TCategoryForm).leCategory.Enabled := False;
    end;

    FIns_Child := 0;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.InsLikeData;
begin
  ClassForm := TCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.UpdData;
begin
  ClassForm := TCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPriceListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Is_closing := True;

  inherited;
  tvProduct.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvProduct.name);
end;

procedure TPriceListForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'G_PRODUCT';
  KeyFieldClass := 'G_PRODUCT_';
  inherited;
  FIns_Child := 0;
  FIs_Creating := True;

  SPLazyLoadEnable(spReadTovar, tvProduct);
end;

procedure TPriceListForm.aDelExecute(Sender: TObject);
var str : string;
  LogCommonDlgForm: TLogCommonDlgForm;
  oldRow : INt64;
begin

  if HaveRightDelPriceList = False then begin
    MessageDlg('У Вас нет прав на удаление товаров!', mtWarning, [mbOk], 0);
    Exit;
  end;

  spDEl.Params.ClearValues;

  if (tlCategory.FocusedNode.HasChildren) or (spReadTovar.RecordCount > 0) then
    str := ' Группа будет удалена со ВСЕМИ подгруппами и товарами!';

  if MessageDlg(Format('Удалить группу "%s" ?' + str,
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spDEl.ParamByName('USER_ID_').AsInt64 := CurrentOfficial;
  spDEl.ParamByName('g_product_').AsInt64 := spRead.FieldByName('g_product').AsLargeInt;
  spDEl.ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := Integer(UploadToMobile);

  //inherited;
  if ExecSp(spDEl) then begin
    if (spDEl.ParamByName('SUCCESS_CNT_').AsInteger + spDEl.ParamByName('FAIL_CNT_').AsInteger) > 1 then begin
      LogCommonDlgForm := TLogCommonDlgForm.Create(Self);
      LogCommonDlgForm.m1.Text := spDEl.ParamByName('LOG_').AsString;
      LogCommonDlgForm.btnOk.Visible := False;
      LogCommonDlgForm.btnCancel.Caption := 'Закрыть';
      LogCommonDlgForm.ShowModal;
    end;
    if spDEl.Transaction.InTransaction then
      spDEl.Transaction.Commit;

    // чтобы после удаления не прыгало по записям
    // тут надо сначала проверять не последняя ли запись в узле, если последняя в узле
    // или последняя вообще, то надо делать GotoPrev
    // еще проверяю - не удаляю ли я целый узел
    if (spDEl.ParamByName('SUCCESS_CNT_').AsInteger + spDEl.ParamByName('FAIL_CNT_').AsInteger) > 1 then begin

      if (tlCategory.FocusedNode.Parent <> nil) and
      (tlCategory.FocusedNode = tlCategory.FocusedNode.Parent.GetLastChild) then
        oldRow := tlCategory.FocusedNode.getPrevSibling.Values[clmId.ItemIndex]
      else if tlCategory.FocusedNode.getNextSibling <> nil then
        oldRow := tlCategory.FocusedNode.getNextSibling.Values[clmId.ItemIndex]
      else
        oldRow := tlCategory.FocusedNode.getPrevSibling.Values[clmId.ItemIndex];

    end else begin

      if (tlCategory.FocusedNode.Parent <> nil) and
      (tlCategory.FocusedNode = tlCategory.FocusedNode.Parent.GetLastChild) then
        oldRow := tlCategory.FocusedNode.getPrev.Values[clmId.ItemIndex]
      else if tlCategory.FocusedNode.GetNext <> nil then
        oldRow := tlCategory.FocusedNode.getNext.Values[clmId.ItemIndex]
      else
        oldRow := tlCategory.FocusedNode.getPrev.Values[clmId.ItemIndex];

    end;

    //oldRow := spRead.FieldByName('g_product').AsLargeInt;

    Readlist;

    spRead.Locate('g_product', oldRow, []);
  end;
end;

procedure TPriceListForm.aExportPluCodesExecute(Sender: TObject);
begin
  ReportsDM.PrepareReport(66);

  ReportsDM.spReport.ParamByName('scale_prefix_').AsString := ScalesPrefix;
  ReportsDM.ShowReport;
end;

procedure TPriceListForm.aExportToScalesExecute(Sender: TObject);
begin
  ExportToScales;
end;

procedure TPriceListForm.aExportAllTovsToScalesExecute(Sender: TObject);
begin
  ExportToScales(true);
end;

procedure TPriceListForm.ExportToScales(All: Boolean);
var Handle : HWND;
  TemplateTempFileName, TempFilePath : string;
  str, str1, hotkey, strPlu, prograFolder, txpFilePath : string;
  f   : TextFile;
  rows, s, i, J, k, posTab, m, q : integer;
  //strName : AnsiString;
  driver : TDriver;
  device : TDevice;
  res : integer;
  Goods : TGoods;
  n : integer;
  driverShtrih : TDrvLP;
  SL : TStringList;
  arr : array of String;
  pnt : string;
  tovarArr : array of TVesTovar;

  function StrAnsiToOem(const S: AnsiString): AnsiString;
  begin
    SetLength(Result, Length(S));
    AnsiToOemBuff(@S[1], @Result[1], Length(S));
  end;
begin
  {if tvProduct.Controller.SelectedRowCount = 0 then begin
    if MessageDlg('Вы не выбрали ни одного товара. Вы уверены, что хотите выгрузить все товары данной группы?', mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
      Exit;
  end;}

  Screen.Cursor := crHourGlass;

  TRY
    if All = TRUE then
    begin
      pnt := '00';

      spScalesTovs.ParamByName('SCALE_PREFIX_').AsString := ScalesPrefix;
      OpenSp(spScalesTovs, False);

      SetLength(tovarArr, spScalesTovs.RecordCount);
      m := 0;
      spScalesTovs.First;
      try
        while not spScalesTovs.Eof do
        begin
          tovarArr[m].ID := spScalesTovs.FieldByName('G_PRODUCT').AsInteger;
          tovarArr[m].Barcode := spScalesTovs.FieldByName('BARCODE').AsString;
          tovarArr[m].Name := spScalesTovs.FieldByName('NAME').AsString;
          tovarArr[m].Price := spScalesTovs.FieldByName('PRICE').AsFloat;

          m := m + 1;
          spScalesTovs.Next;
        end;
      except
        on E: Exception do begin
          MessageDlg('Ошибка выгрузки в весы. Ошибка: ' + E.Message + '. Pnt = ' + pnt, mtError, [mbOK], 0);
          with MainDM.MainLogFile do
            if Active then begin
              WriteLog('Ошибка выгрузки в весы. Ошибка: ' + E.Message + '. Pnt = ' + pnt, True);
            end;
          Exit;
        end;
      end;
      spScalesTovs.Close;

    end else begin
      rows := tvProduct.Controller.SelectedRowCount;

      pnt := '00A';
      SetLength(tovarArr, rows);
      try
        for m := 0 to rows-1 do begin
          if Copy(tvProduct.Controller.SelectedRecords[m].Values[clmtv1BARCODE.Index], 1, 2) = ScalesPrefix then begin
            tovarArr[m].ID := tvProduct.Controller.SelectedRecords[m].Values[clmtv1G_PRODUCT.Index];
            tovarArr[m].Barcode := tvProduct.Controller.SelectedRecords[m].Values[clmtv1BARCODE.Index];
            tovarArr[m].Name := tvProduct.Controller.SelectedRecords[m].Values[clmtv1NAME.Index];
            tovarArr[m].Price := tvProduct.Controller.SelectedRecords[m].Values[clmtv1PRICE.Index];
          end;
        end;
      except
        on E: Exception do begin
          MessageDlg('Ошибка выгрузки в весы. Ошибка: ' + E.Message + '. Pnt = ' + pnt, mtError, [mbOK], 0);
          with MainDM.MainLogFile do
            if Active then begin
              WriteLog('Ошибка выгрузки в весы. Ошибка: ' + E.Message + '. Pnt = ' + pnt, True);
            end;
          Exit;
        end;
      end;
    end;

    // ВЕСЫ МАССА-К
    FOR s := 0 to High(ScalesArr) DO BEGIN
      IF ScalesArr[s].ModelId = 0 THEN BEGIN
        //  for I := 0 to rows-1 do begin
        //    Showmessage(Copy(tvProduct.Controller.SelectedRecords[i].Values[clmtv1BARCODE.Index], 3, 5));
        //  end;

        Driver := TDriver.Create(Self);
        Driver.RaiseException := 0;
        Goods := TGoods.Create(Self);
        device := Tdevice.Create(Self);

        try
          try
            pnt := '01';
            device.Connection := ScalesArr[s].Ip + ':' + ScalesArr[s].Port;
            device.Name := 'Новые1';
            device.Mark := 1;
            device.WriteType := 1;
            device.Add;
            res := device.OpenConnection;

            pnt := '02';

            if res = 0 then begin
              pnt := '02.a';
              for q := 0 to High(tovarArr) do begin
                pnt := '02.b';
                //if Copy(tovarArr[q].Barcode, 1, 2) = ScalesPrefix then begin  -- теперь проверяется выше
                  pnt := '02.c';
                  // пришлось пихать туда ПЛУ-код, потому что при настройке синхронизации ID становится слишком большой
                  Goods.ID := StrToInt(Copy(tovarArr[q].Barcode, 3, 5)); //StrToInt(Copy(tvProduct.Controller.SelectedRecords[i].Values[clmtv1BARCODE.Index], 3, 5));
                  Goods.Code := IntToStr(tovarArr[q].ID); //tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index]);
                  Goods.Name := tovarArr[q].Name;//tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index];
                  Goods.Price := StrToInt(FloatToStr(tovarArr[q].Price)) * 100;//tvProduct.Controller.SelectedRecords[i].Values[clmtv1PRICE.Index] * 100;
                  pnt := '03';
                  Goods.PLU := StrToInt(Copy(tovarArr[q].Barcode, 3, 5));//tvProduct.Controller.SelectedRecords[i].Values[clmtv1BARCODE.Index], 3, 5));
                  pnt := '04';
                  Goods.BarcodePrefix := StrToInt(ScalesPrefix);
                  Goods.Add();
                  n := 1;
                //end;
              end;
              pnt := '05';
              res := device.WriteGoods();
              if res = 0 then
                MessageDlg('Товары выгружены успешно!', mtInformation, [mbOK], 0)
              else begin
                MessageDlg('Товар не выгружен! Код ошибки ' + IntToStr(res), mtError, [mbOK], 0);
                with MainDM.MainLogFile do
                if Active then begin
                  WriteLog('Товар не выгружен! Код ошибки ' + IntToStr(res) + '. PNT = ' + pnt, True);
                end;
              end;

              device.CloseConnection;

            end else begin
              MessageDlg('Ошибка подключения весов "Масса-К" ' + IntToStr(res), mtError, [mbOK], 0);
              with MainDM.MainLogFile do
                if Active then begin
                  WriteLog('Ошибка подключения весов "Масса-К" ' + IntToStr(res) + '. PNT = ' + pnt, True);
                end;
            end;
          except
            on E: Exception do begin
              MessageDlg('Ошибка выгрузки в весы "Масса-К". Ошибка: ' + E.Message + '. Pnt = ' + pnt, mtError, [mbOK], 0);
              with MainDM.MainLogFile do
                if Active then begin
                  WriteLog('Ошибка выгрузки в весы "Масса-К". Ошибка: ' + E.Message + '. Pnt = ' + pnt, True);
                end;
              Continue;
            end;
          end;
        finally
          FreeAndNil(device);
          FreeAndNil(Goods);
          FreeAndNil(Driver);
        end;

      // ВЕСЫ RONGTA RLS1000
      END ELSE IF ScalesArr[s].ModelId = 1 THEN BEGIN
        prograFolder := GetEnvironmentVariable('ProgramFiles');
        if not FileExists(prograFolder + '\RLS1000\RLS1000.exe') then begin
          MessageDlg('Ошибка выгрузки в весы "Rongta". Программа для загрузки товаров в весы не найдена!', mtError, [mbOK], 0);
          Continue;
        end;

        //формирую файл для экспорта
        //AssignFile (f, prograFolder + '\RLS1000\shopuchet.txp');
        //Rewrite (f);
        TRY
          pnt := '01';
          txpFilePath := prograFolder + '\RLS1000\shopuchet.txp';

          try
            SL := TStringList.Create;

            pnt := '02';
            if FileExists(txpFilePath) then
              SL.LoadFromFile(txpFilePath);

            for q := 0 to High(tovarArr) do begin
              // if Copy(tvProduct.Controller.SelectedRecords[i].Values[clmtv1BARCODE.Index], 1, 2) = ScalesPrefix then begin  теперь проверяется выше
                //strName := tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index];
                str := //IntToStr(0) + #9 +       //HotKey
                       //UTF8Encode(WideString(tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index])) + #9;    //Name
                       //IntToStr(tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index]) + #9 +       //HotKey
                       //tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index];
                       tovarArr[q].Name;

                // ищу LFCode и Code, буду брать с первого ненулевого символа
                str1 := Copy(tovarArr[q].Barcode, 3, 5);
                for J := 1 to str1.Length do begin
                  if str1[J] <> '0' then begin
                    str1 := Copy(str1, J, str1.Length);
                    Break;
                  end;
                end;

                pnt := '03';

                str := str1 + #9 +      //hotkey
                       str + #9 +       //name
                       str1 + #9 +   //LFCode
                       str1 + #9 +   //Code
                       '7' + #9 +   //Barcode Type
                       FloatToStr(tovarArr[q].Price * 100) + #9 +   //UnitPrice
                       '4' + #9 +   //UnitWeight
                       ScalesPrefix + #9 +   //Department
                       '     0' + #9 +   //PT Weight
                       '15' + #9 +  //Shelf Time
                       '0' + #9 +   //Pack Type
                       '     0' + #9 +   //Tare
                       '0' + #9 +   //Error
                       '0' + #9 +   //Message1
                       '0' + #9 +   //Message2
                       '0' + #9 +   //...
                       '0' + #9 +   //
                       '0' + #9 +   //
                       '0' + #9 +   //
                       '0' + #9 + #9 +//
                       '0' + #9 +   //
                       '0' + #9 +   //
                       '0,0';
                //WriteLn(f, str);

                pnt := '04';
                // сначала ищу товар в файле, если там есть, то удаляю строку с ним, и вставляю новую
                //Выполняем пока нет конца файла
                if SL.Count > 0 then begin
                  for k := 0 to SL.Count - 1 do begin
                    // нахожу второй Tab
                    posTab := pos(#9, SL.Strings[k]);
                    posTab := PosFrom(#9, SL.Strings[k], posTab+1);
                    strPlu := Copy(SL.Strings[k], posTab+1, PosFrom(#9, SL.Strings[k], posTab+1) - posTab-1);  // вырезаю PLU
                    if strPlu = str1 then begin
                      SL.Delete(k);
                      break;
                    end;
                  end;
                end;

                pnt := '05';
                SetLength(arr, High(arr)+2);
                arr[High(arr)] := str;
              //end;
            end;

            pnt := '06';
            for I := 0 to High(arr) do
              SL.Add(arr[i]);

            pnt := '07';
            SL.SaveToFile(txpFilePath);
          finally
            FreeAndNil(SL);
          end;
          //CloseFile (f);

          //формирую файл для RLS1000.exe
          pnt := '08';
          AssignFile(f, prograFolder + '\RLS1000\shopuchet.L32');
          Rewrite(f);
          str := 'Y	test	Y	test		' + ScalesArr[s].IP + '	rtlabel_en.scr		shopuchet.txp			1	0	15.01.2019 16:24:31	15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	';
          str := str + '15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	';
          str := str + '15.01.2019 16:24:31	0	0	' + prograFolder + '\RLS1000\DPLU192168187	 ' + prograFolder + '\RLS1000\UPLU192168187	 ' + prograFolder + '\RLS1000\HK192168187';
          WriteLn(f, str);

          //str := '2	0	15.01.2019 16:24:31	15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	';
          //str :=  str + '15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	15.01.2019 16:24:31	0	0	0	15.01.2019 16:24:31	15.01.2019 16:24:31	0	0	';
          //str :=  str + prograFolder + '\RLS1000\DPLU	' + prograFolder + '\RLS1000\UPLU	' + prograFolder + '\RLS1000\HK';
          //for i := 1 to 97 do
          //  WriteLn(f, str);
          CloseFile(f);

          pnt := '09';
          //RLS1000Message := RegisterWindowMessage('RLS1000');  пока решил это убрать
          prograFolder := prograFolder + '\RLS1000\RLS1000.exe shopuchet.L32';
          WinExec(PAnsiChar(AnsiString(prograFolder)), SW_SHOWNORMAL);
          Sleep(500);
          Handle := FindWindow(nil, 'RLS1000');
          PostMessage(Handle, WM_KeyDown, VK_F9, 1);
        EXCEPT
          on E: Exception do begin
            MessageDlg('Ошибка выгрузки в весы "Rongta". Ошибка: ' + E.Message + '. Pnt = ' + pnt, mtWarning, [mbOK], 0);
            Continue;
          end;
        END;
      END

      // ВЕСЫ ШТРИХ-ПРИНТ
      ELSE IF ScalesArr[s].ModelId = 2 THEN BEGIN
        {for I := 0 to rows-1 do begin
          Showmessage(Copy(tvProduct.Controller.SelectedRecords[i].Values[clmtv1BARCODE.Index], 3, 5));
        end;}
        pnt := '01';
        driverShtrih := TDrvLP.Create(nil);
        try
          TRY
            driverShtrih.GetActiveLD;

            pnt := '02';
            driverShtrih.LDInterface := 1;
            driverShtrih.LDRemoteHost := ScalesArr[s].IP;
            //driverShtrih.LDRemotePort := StrToInt(edPort.Text);
            //driverShtrih.LDLocalPort := 2050;
            pnt := '03';
            driverShtrih.SetParamLD;
            pnt := '04';
            driverShtrih.Connect;

            if driverShtrih.Connected then begin
              if driverShtrih.ResultCode = 0 then begin
                for q := 0 to High(tovarArr) do begin
                  pnt := '05';
                  driverShtrih.PLUNumber := StrToInt(Copy(tovarArr[q].Barcode, 3, 5));
                  driverShtrih.NameFirst := tovarArr[q].Name;
                  driverShtrih.Tare := 0;
                  driverShtrih.Price := StrToInt(FloatToStr(tovarArr[q].Price));
                  driverShtrih.GroupCode := StrToInt(ScalesPrefix);
                  driverShtrih.ItemCode := StrToInt(Copy(tovarArr[q].Barcode, 3, 5));//tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index];

                  pnt := '06';
                  driverShtrih.SetPLUDataEx;

                  if driverShtrih.ResultCode <> 0 then begin
                    ShowMessage('Ошибка при загрузке товара "' + tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index] +
                    '". Детали: ' + driverShtrih.ResultCodeDescription);
                    Break;
                  end;
                end;

              end;
              pnt := '07';
              driverShtrih.Disconnect;

              Showmessage('Товар(-ы) выгружен(-ы) успешно!');
            end else begin
              driverShtrih.GetLPStatus;
              ShowMessage(driverShtrih.ResultCodeDescription);
            end;

          EXCEPT
            on E: Exception do begin
              MessageDlg('Ошибка выгрузки в весы "Штрих-Принт". Ошибка: ' + E.Message + '. Pnt = ' + pnt, mtWarning, [mbOK], 0);
              Continue;
            end;
          END;

        finally
          FreeAndNil(driverShtrih);
        end;

      // ВЕСЫ METTLER TOLEDO ОДНОСТРОЧНЫЕ
      END ELSE IF ScalesArr[s].ModelId = 3 THEN BEGIN

        txpFilePath := 'C:\Scales\plu.txt';

        //формирую файл для экспорта
        //AssignFile (f, prograFolder + '\RLS1000\shopuchet.txp');
        //Rewrite (f);
        TRY
          try
            Screen.Cursor := crHourGlass;
            SL := TStringList.Create;

            for q := 0 to High(tovarArr) do begin
              pnt := '05.b';
              if Copy(tovarArr[q].Barcode, 1, 2) = ScalesPrefix then begin
                //24836,24836,1,325,0,0,0,0,0,0,0,0,0,ЂЎаЁЄ®б ўҐб

                str := Copy(tovarArr[q].Barcode, 3, 5);
                str := str + ',' + Copy(tovarArr[q].Barcode, 3, 5);
                str := str + ',1';
                str := str + ',' + FloatToStr(tovarArr[q].Price);
                str := str + ',0,0,0,0,0,0,0,0,0';
                str := str + ',' + StrAnsiToOem(tovarArr[q].name);

                SL.Add(str);
              end;
            end;
            pnt := '07';
            SL.SaveToFile(txpFilePath);
          finally
            FreeAndNil(SL);
            Screen.Cursor := crDefault;
          end;
        EXCEPT
          on E: Exception do begin
            MessageDlg('Ошибка выгрузки в весы "Mettler Toledo". Ошибка: ' + E.Message + '. Pnt = ' + pnt, mtWarning, [mbOK], 0);
            Continue;
          end;
        END;
      END
    END;
  FINALLY
    Screen.Cursor := crDefault;
  END
end;

{это обработка сообщения от весов, пока решил убрать
procedure WndProc(var Message: TMessage); override;
procedure TPriceListForm.WndProc(var Message: TMessage);
begin
  inherited;

  if Message.Msg = RLS1000Message then begin
    MessageDlg('Товары загружены в весы успешно!', mtInformation, [mbOK], 0);
  end;
end;}

procedure TPriceListForm.aRefreshChdTovarExecute(Sender: TObject);
begin
  RefreshChild;
end;

procedure TPriceListForm.RefreshChild;
begin
  spReadTovar.ParamByName('g_product_par_').AsInt64 := spRead.FieldByName('G_PRODUCT').AsLargeInt;
  spReadTovar.ParamByName('g_tochka_').AsInt64 := CurSklad;
  if bcActive.ItemIndex = 0 then
    spReadTovar.ParamByName('is_active_').AsInteger := 1
  else
    spReadTovar.ParamByName('is_active_').AsInteger := 0;

  Screen.Cursor := crSQLWait;
  OpenSP(spReadTovar, FrefreshProdBook);
  SelectGrProductNode;
  Screen.Cursor := crDefault;

  DisableChildControls;
end;

procedure TPriceListForm.aViewChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  if CheckSelectedNode = False then
    Exit;

  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omView;
    PriceListUnForm.RecID := spReadTovar.FieldByName('g_product').AsLargeInt;
    PriceListUnForm.ShowModal;
  finally
    PriceListUnForm.Free;
  end;
end;

procedure TPriceListForm.aInsChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  if HaveRightInsPriceList = False then begin
    MessageDlg('У Вас нет прав на создание товаров!', mtWarning, [mbOk], 0);
    Exit;
  end;

  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omInsert;
    PriceListUnForm.Id_Category := spRead.FieldByName('g_product').AsLargeInt;
    // если KeysBuffer не пустой, то значит процедура вызвана сканером штрихкода,
    // то передаю его в форму PriceListUnForm и подставляю как штрихкод
    if ByScanner = 1 then
    begin
      PriceListUnForm.BARCODE := KeysBuffer;
    end;

    if PriceListUnForm.ShowModal = mrOk then
    begin
      aRefreshChdTovar.Execute;
      spReadTovar.Locate('g_product', PriceListUnForm.RecID, []);
      if tvProduct.Controller.FocusedRow <> Nil then begin
        if tvProduct.Controller.SelectedRowCount > 0 then
          tvProduct.Controller.SelectedRows[0].Selected := False;
        tvProduct.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    PriceListUnForm.Free;
  end;
end;

procedure TPriceListForm.aInsLikeChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  if CheckSelectedNode = False then
    Exit;

  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omInsertLike;
    PriceListUnForm.RecID := spReadTovar.FieldByName('g_product').AsLargeInt;
    // если старому товару меняется цена, то создается новый товар, с новым артикулом и новой ценой
    if (Sender as TAction).Name = 'aNewPrice' then
      PriceListUnForm.G_PROD_FOR_NEW_PRICE := spReadTovar.FieldByName('g_product').AsLargeInt;
    if PriceListUnForm.ShowModal = mrOk then
    begin
      aRefreshChdTovar.Execute;
      spReadTovar.Locate('g_product', PriceListUnForm.RecID, []);
      if tvProduct.Controller.FocusedRow <> Nil then begin
        if tvProduct.Controller.SelectedRowCount > 0 then
          tvProduct.Controller.SelectedRows[0].Selected := False;
        tvProduct.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    PriceListUnForm.Free;
  end;
end;

procedure TPriceListForm.aUpdChdExecute(Sender: TObject);
var
  PriceListUnForm :TPriceListUnForm;
begin
  UpdChild(spReadTovar.FieldByName('g_product').AsLargeInt);
end;

procedure TPriceListForm.UpdChild(Id: Int64);
begin
  if HaveRightUpdPriceList = False then begin
    MessageDlg('У Вас нет прав на изменение товаров!', mtWarning, [mbOk], 0);
    Exit;
  end;

  // если грид пустой и поле edBarcode.Text не пустое то значит будет вызываться форма для добавления товара через сканер штрихкода
  if (tvProduct.Controller.SelectedRowCount = 0) and (edBarcode.Text <> '') then begin
    aInsChd.Execute;
    Exit;
  end;

  if CheckSelectedNode = False then
    Exit;

  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omUpdate;
    PriceListUnForm.RecID := Id;
    if PriceListUnForm.ShowModal = mrOk then
    begin
      aRefreshChdTovar.Execute;
      spReadTovar.Locate('g_product', PriceListUnForm.RecID, []);
      if tvProduct.Controller.FocusedRow <> Nil then begin
        if tvProduct.Controller.SelectedRowCount > 0 then
          tvProduct.Controller.SelectedRows[0].Selected := False;
        tvProduct.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    PriceListUnForm.Free;
  end;
end;

procedure TPriceListForm.aDelChdExecute(Sender: TObject);
var i : integer;
    str : string;
begin
  if HaveRightDelPriceList = False then begin
    MessageDlg('У Вас нет прав на удаление товаров!', mtWarning, [mbOk], 0);
    Exit;
  end;

  if edBarcode.Focused then begin
    edBarcode.ClearSelection;
    Exit;
  end;

  if CheckSelectedNode = False then
    Exit;

  if tvProduct.Controller.SelectedRowCount > 1 then
    str := 'группу товаров?'
  else
    str := 'товар "%s"?';

  if MessageDlg(Format('Удалить '+ str,
    [spReadTovar.FieldByName('NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  for i := 0 to tvProduct.Controller.SelectedRowCount - 1 do begin
    spDelChild.ParamByName('g_product_').AsInt64 := tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index];
    spDelChild.ParamByName('LOG_BODY_').AsString := FillLog(i);
    spDelChild.ParamByName('USER_ID_').AsInteger := CurrentOfficial;

    spDelChild.ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := Integer(UploadToMobile);

    if not ExecSPTR(spDelChild) then begin
      aRefreshChdTovar.Execute;
      Exit;
    end;
  end;

  aRefreshChdTovar.Execute;
end;

function TPriceListForm.FillLog(i : integer): string;
begin
  FNewRec.Name := tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index] + ' (ID ' +
    IntToStr(tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index]) + ')';
  FNewRec.Articul := tvProduct.Controller.SelectedRecords[i].Values[clmtv1ARTICUL.Index];
  Result := FillLogTovar(1, FNewRec, FNewRec, nil, nil);
end;

function TPriceListForm.FillLogDataset : string;
begin
  FNewRec.Name := spReadTovar.FieldByName('name').asString + ' (ID ' +
    IntToStr(spReadTovar.FieldByName('g_product').AsLargeInt) + ')';
  FNewRec.Articul := spReadTovar.FieldByName('articul').asString;
  Result := FillLogTovar(1, FNewRec, FNewRec, nil, nil);
end;

procedure TPriceListForm.aDelChdAllExecute(Sender: TObject);
begin
  if HaveRightDelPriceList = False then begin
    MessageDlg('У Вас нет прав на удаление товаров!', mtWarning, [mbOk], 0);
    Exit;
  end;

  if MessageDlg('Удалить все товары категории?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  DelManyItems;

  aRefreshChdTovar.Execute;
end;

procedure TPriceListForm.DelManyItems;
begin
  spReadTovar.First;
  while not spReadTovar.Eof do begin
    spDelChild.ParamByName('g_product_').AsInt64 := spReadTovar.FieldByName('g_product').AsLargeInt;
    spDelChild.ParamByName('LOG_BODY_').AsString := FillLogDataset;
    spDelChild.ParamByName('USER_ID_').AsInteger := CurrentOfficial;
    if not ExecSPTR(spDelChild) then begin
      aRefreshChdTovar.Execute;
      Exit;
    end;
    spReadTovar.Next;
  end;
end;

procedure TPriceListForm.DisableChildControls;
begin
  aViewChd.Enabled := spReadTovar.RecordCount > 0;
  //aInsChd.Enabled  := (spRead.RecordCount > 1) and (spRead.FieldByName('g_product').AsLargeInt <> -1);;      //кнопка добавить товар доступна, если есть хоть одна родительская категория, но это не "Все товары"
  aInsLikeChd.Enabled := (spReadTovar.RecordCount > 0);
  aUpdChd.Enabled := spReadTovar.RecordCount > 0;
  aDelChd.Enabled := spReadTovar.RecordCount > 0;
  aDelChdAll.Enabled := spReadTovar.RecordCount > 0;
  aSetNotActive.Enabled := spReadTovar.RecordCount > 0;
  aSetNotActive.Visible := bcActive.ItemIndex = 1;
  aPrintLabel.Enabled := spReadTovar.RecordCount > 0;
  aNewPrice.Enabled := spReadTovar.RecordCount > 0;
  aTovarAmountBySklad.Enabled := (spReadTovar.RecordCount > 0) and (High(SkladArr) > 0);

  if UseScales = 1 then begin
    aExportToScales.Enabled := (spReadTovar.RecordCount > 0) and (spReadTovar.FieldByName('g_product').AsLargeInt <> -1) and
    (copy(spReadTovar.FieldByName('Barcode').AsString, 1, 2) = ScalesPrefix);
    aExportPluCodes.Enabled := spReadTovar.RecordCount > 0;
  end;

  dxBarStaticRecCnt.Caption := IntToStr(spReadTovar.RecordCount);
end;

procedure TPriceListForm.aInsChildExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_INSCHILD, 0, 0);
end;

procedure TPriceListForm.WMInsChild(var Message: TMessage);
begin
  FIns_Child := 1;
  InsData;
end;

procedure TPriceListForm.aSetNotActiveExecute(Sender: TObject);
var str, str1, str2 : string;
  i : integer;
begin
  if edBarcode.Focused then begin
    edBarcode.ClearSelection;
    Exit;
  end;

  if CheckSelectedNode = False then
    Exit;

  if tvProduct.Controller.SelectedRowCount > 1 then
    str2 := 'группы товаров?'
  else
    str2 := 'товара "%s"?';

  if MessageDlg(Format('Изменить признак активности ' + str2,
    [spReadTovar.FieldByName('NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  for i := 0 to tvProduct.Controller.SelectedRowCount - 1 do begin
    spSetNotActive.ParamByName('g_product_').AsInt64 := tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index];
    IF spReadTovar.FieldByName('IS_ACTIVE').AsInteger = 0 THEN BEGIN
      spSetNotActive.ParamByName('IS_ACTIVE_').AsInteger := 1;
      str := 'Активен';
      str1 := 'Не активен';
    END ELSE BEGIN
      //НЕЛЬЗЯ СДЕЛАТЬ НЕАКТИВНЫМ, ЕСЛИ ЕСТЬ ТОВАР НА СКЛАДЕ ИЛИ НА РЕАЛИЗАЦИИ
      {
      зачем??? убрал
      if (spReadTovar.FieldByName('amount').AsFloat > 0) or (spReadTovar.FieldByName('AMOUNT_NA_REAL').AsFloat > 0) then begin
        MessageDlg('Товар еше есть на складе или отдан под реализацию. Сделать неактивным невозможно!', mtInformation, [mbOk], 0);
        Exit;
      end;}
      spSetNotActive.ParamByName('IS_ACTIVE_').AsInteger := 0;
      str := 'Не активен';
      str1 := 'Активен';
    END;

    spSetNotActive.ParamByName('LOG_BODY_').AsString := tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index] +
    '. Изменен признак активности с "' + str1 +
      '" на "' + str + '".';
    spSetNotActive.ParamByName('USER_ID_').AsInteger := CurrentOfficial;

    if not spSetNotActive.Transaction.InTransaction then
      spSetNotActive.Transaction.StartTransaction;

    if ExecSP(spSetNotActive) then begin
      if spSetNotActive.Transaction.InTransaction then
        spSetNotActive.Transaction.Commit;
    end;
  end;

  aRefreshChdTovar.Execute;
end;

procedure TPriceListForm.aTovarAmountBySkladExecute(Sender: TObject);
var TovarAmountBySkladForm: TTovarAmountBySkladForm;
begin
  TovarAmountBySkladForm := TTovarAmountBySkladForm.Create(Application);
  with TovarAmountBySkladForm do begin
    try
      GProduct := spReadTovar.FieldByName('g_product').AsLargeInt;
      Sklad := CurSklad;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TPriceListForm.bcActiveChange(Sender: TObject);
begin
  Readlist;
end;

procedure TPriceListForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  tvProduct.Controller.Customization := True;
end;

procedure TPriceListForm.aPrintLabelExecute(Sender: TObject);
var PrintEtiketSetupForm : TPrintEtiketSetupForm;
    SloganOrPrice : integer;
    sql_str, str_arr : string;
    size, i : integer;
    PrintA4 : Integer;
begin
  //если программа не активирована, то не буду давать делать этикетки
  if IsActivated = 0 then begin
    MessageDlg('Программа не активирована! Включены ограничения. Печать этикеток невозможна.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if CheckSelectedNode = False then
    Exit;
  try
    PrintEtiketSetupForm := TPrintEtiketSetupForm.Create(Application);
    if PrintEtiketSetupForm.ShowModal = mrOk then begin

      for i := 0 to tvProduct.Controller.SelectedRowCount - 1 do begin
        str_arr := str_arr + IntToStr(tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index]);
        if i <> tvProduct.Controller.SelectedRowCount - 1 then
          str_arr := str_arr + ',';
      end;

      sql_str := 'WITH RECURSIVE TREE AS (SELECT g.name, g.barcode, TRUNC(g.price) PRICE, 1 levl, ''Цена за: ''||U.SHORT_NAME UNIT' +
                    ' FROM G_PRODUCT g, G_UNIT U' +
                   ' WHERE g.g_product in (' + str_arr + ')' +
                  '    AND G.G_UNIT = U.G_UNIT ' +
                  ' UNION ALL' +
                  ' SELECT g.name, g.barcode, TRUNC(g.price) PRICE, gg.levl + 1 levl, ''Цена за: ''||U.SHORT_NAME UNIT' +
                    ' FROM G_PRODUCT g INNER JOIN TREE GG ON GG.name = g.name, G_UNIT U' +
                   ' WHERE g.g_product in (' + str_arr + ')' +
                   '   AND G.G_UNIT = U.G_UNIT ' +
                     ' AND gg.levl < ' + PrintEtiketSetupForm.edAmount.Text +
                    ' )' +
           ' SELECT * FROM TREE  ORDER BY 1';

      //короче такая тема - делалось все на скорях 20.09.2016, одному клиенту не нужна была цена на ценике,
      //поэтому просто добавил строку "Цена и слоган" третьим пунктом в cbSloganOrPrice
      //а в ReportsDM.PrintLabel как-раз печатается и цена и слоган, если SloganOrPrice = -1,
      //соответственно тут буду переводить, если cbSloganOrPrice.ItemIndex = 2, то SloganOrPrice = -1
      // ЭТИКЕТКИ
      if PrintEtiketSetupForm.pcPrintMode.ActivePageIndex = 0 then begin
        PrintA4 := Integer(PrintEtiketSetupForm.rbPrint.Checked);
        if PrintEtiketSetupForm.rbPrinterA4.Checked then
          size := PrintEtiketSetupForm.cbA4Size.ItemIndex
        else begin
          size := PrintEtiketSetupForm.cbChooseLentWidth.ItemIndex
        end;

        for i := 0 to tvProduct.Controller.SelectedRowCount - 1 do
        begin
          ReportsDM.PrintLabel(PrintEtiketSetupForm.cbPrinters.Text,
                              PrintA4,
                              sql_str,
                              size,
                              Integer(PrintEtiketSetupForm.cbPrintPrice.checked),
                              Integer(PrintEtiketSetupForm.cbPriceBold.checked),
                              Integer(PrintEtiketSetupForm.spnPriceSize.Value),
                              Integer(PrintEtiketSetupForm.cbPrintArticul.checked),
                              Integer(PrintEtiketSetupForm.cbArticulBold.checked),
                              Integer(PrintEtiketSetupForm.spnArticulSize.Value),
                              Integer(PrintEtiketSetupForm.cbPrintSlogan.checked),
                              Integer(PrintEtiketSetupForm.cbSloganBold.checked),
                              Integer(PrintEtiketSetupForm.spnSloganSize.Value),
                              PrintEtiketSetupForm.edSlogan.text,
                              StrToInt(PrintEtiketSetupForm.edAmount.text),
                              SloganOrPrice,
                              tvProduct.Controller.SelectedRecords[i].Values[clmtv1BARCODE.Index],
                              tvProduct.Controller.SelectedRecords[i].Values[clmtv1ARTICUL.Index],
                              VarToStr(tvProduct.Controller.SelectedRecords[i].Values[clmtv1NOMENCLATUR_NUM.Index]),
                              VarToStr(tvProduct.Controller.SelectedRecords[i].Values[clmProductBRAND.Index]),
                              tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index],
                              tvProduct.Controller.SelectedRecords[i].Values[clmtv1PRICE.Index],
                              tvProduct.Controller.SelectedRecords[i].Values[clmtv1G_PRODUCT.Index],
                              Integer(PrintEtiketSetupForm.cbNameBold.checked),
                              Integer(PrintEtiketSetupForm.spnNameSize.Value),
                              PrintEtiketSetupForm.seSdvig.Value,
                              PrintEtiketSetupForm.pcPrintMode.ActivePageIndex);
        end;
      end
      // ЦЕННИКИ
      else begin
        ReportsDM.PrintLabel(PrintEtiketSetupForm.cbPrinters.Text,
                            0,
                            sql_str,
                            PrintEtiketSetupForm.cbCennikSize.ItemIndex,
                            Integer(PrintEtiketSetupForm.cbCennikPrintPrice.checked),
                            Integer(PrintEtiketSetupForm.cbCennikPriceBold.checked),
                            Integer(PrintEtiketSetupForm.spnCennikPriceSize.Value),
                            0, //PrintArticul,
                            0, //ArticulBold
                            0, //ArticulSize,
                            Integer(PrintEtiketSetupForm.cbCennikPrintSlogan.checked),
                            Integer(PrintEtiketSetupForm.cbCennikSloganBold.checked),
                            Integer(PrintEtiketSetupForm.spnCennikSloganSize.Value),
                            PrintEtiketSetupForm.edCennikSlogan.text,
                            StrToInt(PrintEtiketSetupForm.edAmount.text),
                            0, //SloganOrPrice вообще там не используется нигде
                            '', //tvProduct.Controller.SelectedRecords[i].Values[clmtv1BARCODE.Index],
                            '', //Articul
                            '', //NNomer
                            '', //Brand
                            '', //tvProduct.Controller.SelectedRecords[i].Values[clmtv1NAME.Index],
                            '', //tvProduct.Controller.SelectedRecords[i].Values[clmtv1PRICE.Index],
                            0,
                            Integer(PrintEtiketSetupForm.cbCennikNameBold.checked),
                            Integer(PrintEtiketSetupForm.spnCennikNameSize.Value),
                            PrintEtiketSetupForm.seSdvig.Value,
                            PrintEtiketSetupForm.pcPrintMode.ActivePageIndex);
      end;
    end;
  finally
    PrintEtiketSetupForm.free;
  end;
end;

procedure TPriceListForm.edBarcodePropertiesChange(Sender: TObject);
begin
  TimerChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    TimerChangeEd.Enabled := True
  else BEGIN
    with spReadTovar do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TPriceListForm.SelectGrProductNode;
begin
  if tvProduct.Controller.FocusedRow <> Nil then begin
    if tvProduct.Controller.SelectedRowCount > 0 then
      tvProduct.Controller.SelectedRows[0].Selected := False;
    tvProduct.Controller.FocusedRow.Selected := True;
  end;
end;

function TPriceListForm.CheckSelectedNode : Boolean;
begin
  Result := False;

  if tvProduct.Controller.SelectedRowCount = 0 then begin
    MessageDlg('Вы не выбрали ни одного товара! Выберите товар!', mtWarning, [mbOk], 0);
    edBarcode.Clear;
    spReadTovar.Filter := '';
    spReadTovar.Filtered := False;
    Exit;
  end;

  Result := True;
end;

procedure TPriceListForm.RebuildGrid;
var i : Integer;
begin
  //если права на просмотр остатков по другим складам - нет, то и не нужно колонки строить
  if HaveRightToSeeAmountSklad then begin

    // в общем так, если складов несколько, то надо отразить остатки в гриде
    // т.к. я не знаю сколько складов, то пришлось делать через динамический запрос
    // вначале закрываю spReadTovar, т.к. эта процедура вызывается еще при переключении складов
    if spReadTovar.Active then
      spReadTovar.Close;

    spReadTovar.SelectSQL.Text := 'SELECT T.G_PRODUCT, '#13#10+
                                  '        T.G_PRODUCT_PAR,'#13#10+
                                  '        T.ARTICUL,'#13#10+
                                  '        T.NOMENCLATUR_NUM,'#13#10+
                                  '        T.BARCODE,'#13#10+
                                  '        T.NAME,'#13#10+
                                  '        T.PRICE,'#13#10+
                                  '        T.VOLUME_PRICE,'#13#10+
                                  '        T.PACK_AMOUNT,'#13#10+
                                  '        T.MF_COUNTRY,'#13#10+
                                  '        T.BRAND,'#13#10+
                                  '        COALESCE(P.AMOUNT, 0) AMOUNT,'#13#10+
                                  '        COALESCE(P.AMOUNT_RESERVE, 0) AMOUNT_RESERVE,';

    if High(SkladArr) > 0 then
    begin
      for I := 0 to High(SkladArr) do
        tvProduct.FindItemByName('tvProductAmount' + I.ToString).Free;

      for I := 0 to High(SkladArr) do
        if SkladArr[i].ID <> CurSklad then begin
          spReadTovar.SelectSQL.Text := spReadTovar.SelectSQL.Text + 'COALESCE((SELECT AMOUNT - AMOUNT_RESERVE FROM LT_SKLAD_PRODUCT ' +
          'WHERE G_PRODUCT = T.G_PRODUCT AND G_TOCHKA = ' + SkladArr[i].ID.ToString + '), 0) AMOUNT' + I.ToString + ',';

          with tvProduct.CreateColumn do begin
            DataBinding.FieldName := 'AMOUNT' + I.ToString;
            Name := 'tvProductAmount' + I.ToString;
            Caption := 'Остаток ' + SkladArr[i].Name;
            HeaderAlignmentHorz := taCenter;
            RepositoryItem := riEditRepositoryCurrencyItem;
            Index := tvProduct.VisibleColumns[tvProduct.VisibleColumnCount-1].Index + i + 1;
          end;
        end;
    end;
    spReadTovar.SelectSQL.Text := spReadTovar.SelectSQL.Text + 'COALESCE((SELECT SUM(Z.AMOUNT_ALL - Z.AMOUNT_PAYED - COALESCE(Z.AMOUNT_RETURNED, 0))'#13#10+
                                  '                    FROM ZAKAZ_NA_REAL Z, ZAKAZ_REAL_PARENT ZP'#13#10+
                                  '                   WHERE Z.G_PRODUCT = T.G_PRODUCT AND Z.IS_PAYED_ALL = 0'#13#10+
                                  '                     AND ZP.ZAKAZ_REAL_PARENT = Z.ZAKAZ_REAL_PARENT'#13#10+
                                  '                     AND ZP.G_TOCHKA = :G_TOCHKA_), 0) AMOUNT_NA_REAL,'#13#10+
                                  '        T.CROSSCODE'#13#10+
                                  '        ,T.IS_ACTIVE'#13#10+
                                  '        ,T.PLACE'#13#10+
                                  '        ,T.NOTE'#13#10+
                                  '        ,T.SALES_COMM'#13#10+
                                  '        ,T.VES_GRAMM_PRICE'#13#10+
                                  '        ,T.VES_GRAMM'#13#10+
                                  '        ,CAST(SUBSTRING(T.BARCODE_DOP FROM 1 FOR 50) AS VARCHAR(50)) BARCODE_DOP'#13#10+
                                  '    FROM  ('#13#10+
                                  'SELECT G.G_PRODUCT,'#13#10+
                                  'G.G_PRODUCT_PAR,'#13#10+
                                  ' G.ARTICUL,'#13#10+
                                  ' G.NOMENCLATUR_NUM,'#13#10+
                                  ' G.BARCODE,'#13#10+
                                  ' G.NAME,'#13#10+
                                  ' G.PRICE,'#13#10+
                                  ' G.VOLUME_PRICE,'#13#10+
                                  ' G.PACK_AMOUNT,'#13#10+
                                  ' G.MF_COUNTRY,'#13#10+
                                  ' G.BRAND,'#13#10+
                                  ' G.CROSSCODE'#13#10+
                                  ' ,G.IS_ACTIVE'#13#10+
                                  ' ,G.PLACE'#13#10+
                                  ' ,G.SALES_COMM'#13#10+
                                  ' ,G.NOTE'#13#10+
                                  ',G.VES_GRAMM_PRICE'#13#10+
                                  ' ,G.VES_GRAMM'#13#10+
                                  ' ,(SELECT LIST(B.BARCODE) from LT_BARCODE B WHERE B.G_PRODUCT = G.G_PRODUCT) AS BARCODE_DOP'#13#10+
                                  'FROM G_PRODUCT G'#13#10+
                                  'WHERE G.IS_CATEGORY = 0'#13#10+
                                  'AND G.IS_ACTIVE = :IS_ACTIVE_'#13#10+
                                  ') T LEFT OUTER JOIN LT_SKLAD_PRODUCT P ON T.G_PRODUCT = P.G_PRODUCT and P.G_TOCHKA = :G_TOCHKA_'#13#10+
                                  '    WHERE T.G_PRODUCT_PAR = DECODE(CAST(:G_PRODUCT_PAR_ AS BIGINT), -1, T.G_PRODUCT_PAR, CAST(:G_PRODUCT_PAR_ AS BIGINT))'#13#10+
                                  '   ORDER BY 6';
  end;
end;

procedure TPriceListForm.FormShow(Sender: TObject);
begin
  RebuildGrid;

  inherited;
  ActiveListControl := grProduct;
  FrefreshProdBook := True;  // не ставить Bookmark при обновлении по событию tlCategoryFocusedNodeChanged
  ByScanner := 0;
  tlCategory.SetFocus;

  // если конфигурация магазин, то эти колонки не нужны
  if Config <> 1 then begin
    if Assigned(clmtv1PackAmount) then
      clmtv1PackAmount.Destroy;
    if Assigned(clmtv1MF_COUNTRY) then
      clmtv1MF_COUNTRY.Destroy;
  end;
  if Config <> 4 then begin
    if Assigned(clmProductVES_GRAMM_PRICE) then
      clmProductVES_GRAMM_PRICE.Destroy;
    if Assigned(clmProductVES_GRAMM) then
      clmProductVES_GRAMM.Destroy;
  end;

  aIns.Caption := 'Добавить группу';
  aUpd.Caption := 'Изменить группу';
  aDel.Caption := 'Удалить группу';

  if High(SkladArr) > 0 then
    aTovarAmountBySklad.Visible := True
  else
    aTovarAmountBySklad.Visible := False;

  if UseScales = 1 then begin
    aExportToScales.Visible := True;
    aExportPluCodes.Visible := True;
  end else begin
    aExportToScales.Visible := False;
    aExportPluCodes.Visible := False;
  end;
end;

procedure TPriceListForm.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var
  N : integer;
  barcode : string;

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
      if Msg.message = WM_KEYDOWN then
      begin
        if (Msg.wParam = 13) or (Msg.wParam = 10) then
        begin
          ClearBuffer;
          if KeysBuffer <> '' then begin
            // при сканировании нажатие энтера передавать никуда не надо
            Handled := True;
            TimerChangeEd.Enabled := False;

            // если штрихкод начинается на ScalesPrefix, то надо очистить 5 цифр отвечающих за вес
            if Copy(KeysBuffer, 1, 2) = ScalesPrefix then begin
              barcode := Copy(KeysBuffer, 1, 7) + '00000';
              N := (StrToInt(Copy(KeysBuffer, 2, 1))+
                   StrToInt(Copy(KeysBuffer, 4, 1))+
                   StrToInt(Copy(KeysBuffer, 6, 1))+
                   StrToInt(Copy(KeysBuffer, 8, 1))+
                   StrToInt(Copy(KeysBuffer, 10, 1))+
                   StrToInt(Copy(KeysBuffer, 12, 1))
                  ) * 3+
                   StrToInt(Copy(KeysBuffer, 1, 1))+
                   StrToInt(Copy(KeysBuffer, 3, 1))+
                   StrToInt(Copy(KeysBuffer, 5, 1))+
                   StrToInt(Copy(KeysBuffer, 7, 1))+
                   StrToInt(Copy(KeysBuffer, 9, 1))+
                   StrToInt(Copy(KeysBuffer, 11, 1));

              N := N MOD 10;
              IF N > 0 THEN
                N := 10 - N;

              KeysBuffer := barcode + IntToStr(N);
            end;

            //проверяю, вдруг такой товар уже есть, тогда вызываю апдейт
            onChangeCat := tlCategory.OnFocusedNodeChanged;
            tlCategory.OnFocusedNodeChanged := nil;
            try
              try
                spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
                if not spFindProduct.Transaction.InTransaction then
                  spFindProduct.Transaction.StartTransaction;
                spFindProduct.ExecProc;
                if spFindProduct.Transaction.InTransaction then
                  spFindProduct.Transaction.Commit;
              except
                on E: EFIBError do begin
                  tlCategory.OnFocusedNodeChanged := onChangeCat;
                  if spFindProduct.Transaction.InTransaction then
                    spFindProduct.Transaction.Rollback;
                  DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBListForm.DelData)');
                end;
                on E: Exception do begin
                  tlCategory.OnFocusedNodeChanged := onChangeCat;
                  if spFindProduct.Transaction.InTransaction then
                    spFindProduct.Transaction.Rollback;
                  MessageDlg(E.Message + #13#10'(occured in TDBListForm.DelData)', mtError, [mbOk], 0);
                end;
              end;
              IF spFindProduct.ParamByName('g_product_').AsInt64 > 0 THEN BEGIN

                // устанавливаю курсор на товар
                if SetCursorOnTovar = 1 then begin
                  spRead.Locate('g_product', spFindProduct.ParamByName('g_product_category_').AsInt64, []);
                  spReadTovar.ParamByName('g_product_par_').AsInt64 := spRead.FieldByName('g_product').AsLargeInt;
                  spReadTovar.ParamByName('g_tochka_').AsInt64 := CurSklad;
                  OpenSp(spReadTovar, False);
                  spReadTovar.Locate('g_product', spFindProduct.ParamByName('G_PRODUCT_').AsInt64, []);
                  if tvProduct.Controller.FocusedRow <> Nil then begin
                    if tvProduct.Controller.SelectedRowCount > 0 then
                      tvProduct.Controller.SelectedRows[0].Selected := False;
                    tvProduct.Controller.FocusedRow.Selected := True;
                  end;
                end;

                UpdChild(spFindProduct.ParamByName('G_PRODUCT_').AsInt64);
              END else begin
                ByScanner := 1;
                aInsChd.execute;
                ByScanner := 0;
              end;
              tlCategory.OnFocusedNodeChanged := onChangeCat;
              KeysBuffer := '';

            finally
              // при презентации был случай, когда перестало работать перемещение по категориям
              // не смог смоделировать и поставил вот так
              tlCategory.OnFocusedNodeChanged := onChangeCat;
            end;
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
    END;
  END;
end;

procedure TPriceListForm.TimerChangeEdTimer(Sender: TObject);
var s: string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spReadTovar do begin
      s := '(BARCODE_DOP CONTAINING ''' + trim(edBarcode.text) + ''') OR (NAME CONTAINING ''' + trim(edBarcode.text) + ''') OR (ARTICUL CONTAINING ''' + trim(edBarcode.text) + ''') OR (NOMENCLATUR_NUM CONTAINING ''' + edBarcode.text +
           ''') OR (BARCODE CONTAINING '''+ trim(edBarcode.text) + ''') OR (CROSSCODE CONTAINING '''+ trim(edBarcode.text) + ''')';

      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + trim(edBarcode.text) + ''')';

      if UseTovarNoteInSearch = 1 then
        s := s + ' OR (NOTE CONTAINING ''' + trim(edBarcode.text) + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    SelectGrProductNode;

    DisableChildControls;
  END;
end;

procedure TPriceListForm.tlCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  inherited;
  aView.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aDel.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aUpd.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aInsChild.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);
  aInsLike.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('g_product').AsLargeInt <> -1);

  // если форма не открывается-закрывается, то вызываю
  if not Is_closing then begin
    FrefreshProdBook := False;
    aRefreshChdTovar.Execute;
    FrefreshProdBook := True;
  end;
end;

procedure TPriceListForm.tvProductCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aUpdChd.Execute;
end;

procedure TPriceListForm.tvProductFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if UseScales = 1 then begin
    aExportToScales.Enabled := (spReadTovar.RecordCount > 0) and (spReadTovar.FieldByName('g_product').AsLargeInt <> -1) and
    (copy(spReadTovar.FieldByName('Barcode').AsString, 1, 2) = ScalesPrefix);
  end;
end;

procedure TPriceListForm.btClearClick(Sender: TObject);
begin
  edBarcode.Clear;
  if Assigned(tvProduct.Controller.FocusedRow) then
    tvProduct.Controller.FocusedRow.Selected := True;
end;

procedure TPriceListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 5;
  Application.HelpContext(5);
  inherited;
end;

end.
