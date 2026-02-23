unit frmClientList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList,  FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  FIBDataSet, pFIBDataSet, ExtCtrls, Menus, FIBDatabase, pFIBDatabase,
  ActnList, dxBar, dxBarExtItems,
  cxPC, cxControls, cxSplitter, StdCtrls, Buttons,
  ActnMan, ToolWin, ActnCtrls, ActnMenus,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, dxSkinsdxBarPainter, cxTL, cxMaskEdit, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxDBTL, cxTLData, cxClasses, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCheckBox, cxContainer, cxTextEdit, cxCurrencyEdit, System.UITypes,
  cxNavigator, dxBarBuiltInMenu, System.Actions, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxEditRepositoryItems, unLog;

type
  TClientListForm = class(TDBListForm)
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
    aRefreshChd: TAction;
    cxSplitter1: TcxSplitter;
    pcClientRekv: TcxPageControl;
    tsContact: TcxTabSheet;
    tsBankRekv: TcxTabSheet;
    aInsContact: TAction;
    aUpdContact: TAction;
    aDelContact: TAction;
    Panel4: TPanel;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn12: TBitBtn;
    aInsChdCategory: TAction;
    spReadClient: TpFIBDataSet;
    dsReadClient: TDataSource;
    spReadContact: TpFIBDataSet;
    dsReadContact: TDataSource;
    spReadBankRekv: TpFIBDataSet;
    dsReadBankRekv: TDataSource;
    spDelContact: TpFIBStoredProc;
    spDelBankRekv: TpFIBStoredProc;
    dxBarButton2: TdxBarButton;
    pn1: TPanel;
    dxBarStatic1: TdxBarStatic;
    tvClient: TcxGridDBTableView;
    lvClient: TcxGridLevel;
    gr2: TcxGrid;
    gr3: TcxGrid;
    tvAddress: TcxGridDBTableView;
    lv1: TcxGridLevel;
    gr4: TcxGrid;
    tvBank: TcxGridDBTableView;
    lv2: TcxGridLevel;
    tlClientCategory: TcxDBTreeList;
    clmnGrp: TcxDBTreeListColumn;
    clmClientG_CLIENT: TcxGridDBColumn;
    clmClientNAME: TcxGridDBColumn;
    clmClientIDN: TcxGridDBColumn;
    clmClientSKIDKA: TcxGridDBColumn;
    clmClientIS_BEZNAL: TcxGridDBColumn;
    clmClientSUPPL_AGENT_NAME: TcxGridDBColumn;
    clmClientN_PERCENT: TcxGridDBColumn;
    clmClientSUMM: TcxGridDBColumn;
    clmClientSUMM_ALL: TcxGridDBColumn;
    clmClientBARCODE: TcxGridDBColumn;
    clmAddressG_ADDRESS: TcxGridDBColumn;
    clmAddressG_ADDRESS_TYPE: TcxGridDBColumn;
    clmAddressG_CLIENT: TcxGridDBColumn;
    clmAddressADDRESS: TcxGridDBColumn;
    clmAddressPHONE: TcxGridDBColumn;
    clmAddressFAX: TcxGridDBColumn;
    clmAddressEMAIL: TcxGridDBColumn;
    clmAddressWEBSITE: TcxGridDBColumn;
    clmAddressIS_DEFAULT: TcxGridDBColumn;
    clmAddressADDRESS_TYPE_STR: TcxGridDBColumn;
    clmBankG_BANK: TcxGridDBColumn;
    clmBankBIK: TcxGridDBColumn;
    clmBankNAME: TcxGridDBColumn;
    clmBankG_ACCOUNT: TcxGridDBColumn;
    clmBankACCOUNT: TcxGridDBColumn;
    clmBankIS_DEFAULT: TcxGridDBColumn;
    clmClientPHONE: TcxGridDBColumn;
    clmClientNOTE: TcxGridDBColumn;
    tsHistory: TcxTabSheet;
    grHis: TcxGrid;
    tvHis: TcxGridDBTableView;
    lv3: TcxGridLevel;
    spClientHis: TpFIBDataSet;
    dsClientHis: TDataSource;
    clmHisZ_DATE: TcxGridDBColumn;
    clmHisNAME: TcxGridDBColumn;
    clmHisFM: TcxGridDBColumn;
    clmClienSUMM_DOLG: TcxGridDBColumn;
    pn2: TPanel;
    lb1: TLabel;
    edBarcode: TEdit;
    btnClear: TButton;
    tmrChangeEd: TTimer;
    clmHisColumn1: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aRefreshChdExecute(Sender: TObject);
    procedure aViewChdExecute(Sender: TObject);
    procedure aInsChdExecute(Sender: TObject);
    procedure aInsLikeChdExecute(Sender: TObject);
    procedure aUpdChdExecute(Sender: TObject);
    procedure aDelChdExecute(Sender: TObject);
    procedure aInsContactExecute(Sender: TObject);
    procedure aUpdContactExecute(Sender: TObject);
    procedure aDelContactExecute(Sender: TObject);
    procedure pcClientRekvChange(Sender: TObject);
    procedure aInsChdCategoryExecute(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tlClientCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure tvClientFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvClientCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tvClientMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrChangeEdTimer(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    FIs_supplier: Integer; // 0 - Клиент, 1 - Поставщик
    FIns_Child : Integer;  //признак что вызывается INSDATA для создания дочерней записи
    Is_closing : Boolean;       // форма закрывается в данный момент
    FNewRec : TClientRec;
    function FillLog: string;
  public
    property Is_supplier: Integer read FIs_supplier write FIs_supplier;
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ReadList; override;
    procedure ReadClientContact;
    constructor CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String = '');
  end;

var
  ClientListForm: TClientListForm;

implementation

uses frmClient, frmClientCategory, frmDBEdit, frmClientAddress,
  frmClientBankRek, dmMain, unCommonFunc, unInitApp;

{$R *.dfm}

constructor TClientListForm.CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String);
var Caption_ : String;
  onChange : TNotifyEvent;
begin
  FIs_supplier := Prizn;

  inherited Create(AOwner, Caption_, ActionName);

  IF FIs_supplier = 0 THEN begin
    Caption_ := 'Клиенты';
    Helpc := 6;
  end ELSE begin
    Caption_ := 'Поставщики';
    Helpc := 7;
  end;

  onChange := pcClientRekv.OnChange;
  pcClientRekv.OnChange := nil;
  if AppName = 'salonuchet' then begin
    if FIs_supplier = 0 then
      tsHistory.TabVisible := True
    else
      tsHistory.TabVisible := False;
  end else
    tsHistory.TabVisible := False;

  pcClientRekv.OnChange := onChange;

  Self.Caption := Caption_;
  FIns_Child := 0;
end;

procedure TClientListForm.edBarcodeChange(Sender: TObject);
begin
  tmrChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    tmrChangeEd.Enabled := True
  else BEGIN
    with spReadClient do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;;
  END;
end;

procedure TClientListForm.ReadList;
var
  onChangeCat : TcxTreeListFocusedNodeChangedEvent;
begin
  onChangeCat := tlClientCategory.OnFocusedNodeChanged;
  tlClientCategory.OnFocusedNodeChanged := nil;

  spRead.ParamByName('is_supplier_').AsInteger := FIs_supplier;
  inherited;

  Screen.Cursor := crHourGlass;
  {if spRead.FieldByName('G_CLIENT').AsInteger = -1 then
    spReadClient.ParamByName('G_CLIENT_PARENT_').Clear
  else
    spReadClient.ParamByName('G_CLIENT_PARENT_').AsInteger := spRead.FieldByName('G_CLIENT').AsInteger;
  OpenSp(spReadClient, True);}
  aRefreshChd.Execute;
  Screen.Cursor := crDefault;

  aDel.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
  aView.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
  aInsChdCategory.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
  aUpd.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
  aInsLike.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);

  tlClientCategory.OnFocusedNodeChanged := onChangeCat;
end;

procedure TClientListForm.tvClientCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aUpdChd.Execute;
end;

procedure TClientListForm.tvClientFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  ReadClientContact;
end;

procedure TClientListForm.tvClientMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ActiveTVControl := ((Sender as TcxGridSite).GridView as TcxGridDBTableView);
end;

procedure TClientListForm.ReadClientContact;
begin
  if pcClientRekv.ActivePage = tsContact then begin
    spReadContact.ParamByName('g_client_').AsInt64 := spReadClient.FieldByName('G_client').AsLargeInt;
    OpenSP(spReadContact, True);
    aUpdContact.Enabled := spReadContact.RecordCount > 0;
    aDelContact.Enabled := spReadContact.RecordCount > 0;
  end else if pcClientRekv.ActivePage = tsBankRekv then  begin
    spReadBankRekv.ParamByName('g_client_').AsInt64 := spReadClient.FieldByName('G_client').AsLargeInt;
    OpenSP(spReadBankRekv, True);
    aUpdContact.Enabled := spReadBankRekv.RecordCount > 0;
    aDelContact.Enabled := spReadBankRekv.RecordCount > 0;
  end else if pcClientRekv.ActivePage = tsHistory then  begin
    spClientHis.ParamByName('g_client_').AsInt64 := spReadClient.FieldByName('G_client').AsLargeInt;
    spClientHis.ParamByName('DO_NOT_SHOW_RASHODNIKI_').AsInteger := Integer(DoNotShowRashodniki);
    OpenSP(spClientHis, True);
  end;
end;

procedure TClientListForm.ViewData;
begin
  ClassForm := TClientCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    //ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TClientListForm.InsData;
begin
  ClassForm := TClientCategoryForm.Create(Self);
  try
    if FIns_Child = 1 then
      (ClassForm as TClientCategoryForm).leClientCategory.EditValue := spRead.FieldByName('g_client').AsLargeInt
    else
      (ClassForm as TClientCategoryForm).leClientCategory.Enabled := False;

    FIns_Child := 0;
    (ClassForm as TClientCategoryForm).Is_supplier := FIs_supplier;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TClientListForm.InsLikeData;
begin
  ClassForm := TClientCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TClientCategoryForm).Is_supplier := FIs_supplier;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TClientListForm.tlClientCategoryFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  if not Is_closing then begin
    aDel.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
    aView.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
    aInsChdCategory.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
    aUpd.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);
    aInsLike.Enabled := (spRead.RecordCount > 0) and (spRead.FieldByName('G_CLIENT').AsLargeInt > 0);

    aRefreshChd.Execute;
  end;
end;

procedure TClientListForm.tmrChangeEdTimer(Sender: TObject);
var s: string;
begin
  tmrChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spReadClient do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (PHONE CONTAINING ''' + edBarcode.text + ''')'+
          ' OR (IDN CONTAINING ''' + edBarcode.text + ''')';
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if Assigned(tvMain.Controller.FocusedRow) then
      tvMain.Controller.FocusedRow.Selected := True;
  END;
end;

procedure TClientListForm.UpdData;
begin
  ClassForm := TClientCategoryForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TClientCategoryForm).Is_supplier := FIs_supplier;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TClientListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Is_closing := True;

  inherited;
  tvClient.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvClient.name);
  tvBank.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvBank.name);
  tvHis.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvHis.name);
  tvAddress.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvAddress.name);
  SaveSettingsIni('Settings_grid', 'SplitterPos', pcClientRekv.Height, '');
end;

procedure TClientListForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'G_client';
  KeyFieldClass := 'G_client_';
  inherited;
end;

procedure TClientListForm.aDelExecute(Sender: TObject);
begin
  // если курсор стоит на поле "Поиск", то выхожу
  if edBarcode.Focused then
    Exit;

  if MessageDlg(Format('Удалить категорию "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if spReadClient.RecordCount > 0 then begin
    MessageDlg('Есть дочерние записи. Удаление невозможно!', mtInformation, [mbOk], 0);
    Exit;
  end;

  inherited;

  {spDel.SetVariable('g_CLIENT_', spRead.FieldByName('g_CLIENT').AsInteger);
  if ExecSP(spDel) then
    Readlist;}
end;

procedure TClientListForm.aRefreshChdExecute(Sender: TObject);
begin
  aInsChd.Enabled := spRead.RecordCount > 0;
  if spRead.FieldByName('G_CLIENT').AsLargeInt = -1 then
    spReadClient.ParamByName('G_CLIENT_PARENT_').Clear
  else
    spReadClient.ParamByName('G_CLIENT_PARENT_').AsInt64 := spRead.FieldByName('G_CLIENT').AsLargeInt;
  spReadClient.ParamByName('IS_SUPPLIER_').AsInteger := FIs_supplier;
  OpenSP(spReadClient, True);
  aViewChd.Enabled := spReadClient.RecordCount > 0;
  aInsLikeChd.Enabled := spReadClient.RecordCount > 0;
  aUpdChd.Enabled := spReadClient.RecordCount > 0;
  aDelChd.Enabled := spReadClient.RecordCount > 0;
  dxBarStaticRecCnt.Caption := IntToStr(spReadClient.RecordCount);

  ReadClientContact;
end;

procedure TClientListForm.aViewChdExecute(Sender: TObject);
var
  ClientForm :TClientForm;
begin
  inherited;
  ClientForm := TClientForm.Create(Self);
  try
    ClientForm.OpenMode := omView;
    ClientForm.RecID := spReadClient.FieldByName('g_client').AsLargeInt;
    ClientForm.Is_supplier := FIs_supplier;
    ClientForm.ShowModal;
  finally
    ClientForm.Free;
  end;
end;

procedure TClientListForm.btnClearClick(Sender: TObject);
begin
  edBarcode.Clear;
end;

procedure TClientListForm.aInsChdExecute(Sender: TObject);
var
  ClientForm :TClientForm;
begin
  inherited;
  ClientForm := TClientForm.Create(Self);
  try
    ClientForm.OpenMode := omInsert;
    ClientForm.Id_Category := spRead.FieldByName('g_CLIENT').AsLargeInt;
    ClientForm.Is_supplier := FIs_supplier;
    if ClientForm.ShowModal = mrOk then BEGIN
      aRefreshChd.Execute;
      spReadClient.Locate('G_CLIENT', ClientForm.RecID, []);
      FocusRowAfterInscxGrid(tvClient);
    END;
  finally
    ClientForm.Free;
  end;
end;

procedure TClientListForm.aInsLikeChdExecute(Sender: TObject);
var
  ClientForm :TClientForm;
begin
  inherited;
  ClientForm := TClientForm.Create(Self);
  try
    ClientForm.OpenMode := omInsertLike;
    ClientForm.RecID := spReadClient.FieldByName('g_client').AsLargeInt;
    ClientForm.Is_supplier := FIs_supplier;
    if ClientForm.ShowModal = mrOk then begin
      aRefreshChd.Execute;
      spReadClient.Locate('G_CLIENT', ClientForm.RecID, []);
      FocusRowAfterInscxGrid(tvClient);
    end;
  finally
    ClientForm.Free;
  end;
end;

procedure TClientListForm.aUpdChdExecute(Sender: TObject);
var
  ClientForm :TClientForm;
begin
  inherited;
  ClientForm := TClientForm.Create(Self);
  try
    ClientForm.OpenMode := omUpdate;
    ClientForm.RecID := spReadClient.FieldByName('g_client').AsLargeInt;
    ClientForm.Is_supplier := FIs_supplier;    
    if ClientForm.ShowModal = mrOk then
    begin
      aRefreshChd.Execute;
      spReadClient.Locate('g_client', ClientForm.RecID, []);
    end;
  finally
    ClientForm.Free;
  end;
end;

procedure TClientListForm.aDelChdExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(Format('Удалить запись "%s" ?',
    [spReadClient.FieldByName('NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;
  spDel.ParamByName('g_client_').AsInt64 := spReadClient.FieldByName('g_client').AsLargeInt;
  spDEl.ParamByName('LOG_BODY_').AsString := FillLog;
  spDEl.ParamByName('USER_ID_').AsInteger := CurrentOfficial;

  if ExecSP(spDel) then begin
    if spDel.Transaction.InTransaction then
      spDel.Transaction.Commit;
    aRefreshChd.Execute;
  end;
end;

procedure TClientListForm.aInsContactExecute(Sender: TObject);
begin
  inherited;
  if pcClientRekv.ActivePage = tsContact then begin
    ClientAddressForm := TClientAddressForm.Create(Self);
    try
      ClientAddressForm.OpenMode := omInsert;
      ClientAddressForm.GClient := spReadClient.FieldByName('g_CLIENT').AsLargeInt;

      if ClientAddressForm.ShowModal = mrOk then begin
        ReadClientContact;
        spReadContact.Locate('G_ADDRESS', ClientAddressForm.RecID, []);
        FocusRowAfterInscxGrid(tvAddress);
      end;
    finally
      ClientAddressForm.Free;
    end;

  end else if pcClientRekv.ActivePage = tsBankRekv then begin
    ClientBankRekForm := TClientBankRekForm.Create(Self);
    try
      ClientBankRekForm.OpenMode := omInsert;
      ClientBankRekForm.GClient := spReadClient.FieldByName('g_CLIENT').AsLargeInt;

      if ClientBankRekForm.ShowModal = mrOk then begin
        ReadClientContact;
        spReadBankRekv.Locate('G_ACCOUNT', ClientBankRekForm.RecID, []);
        FocusRowAfterInscxGrid(tvBank);
      end;
    finally
      ClientBankRekForm.Free;
    end;
  end;
end;

procedure TClientListForm.aUpdContactExecute(Sender: TObject);
begin
  inherited;
  if pcClientRekv.ActivePage = tsContact then begin
    ClientAddressForm := TClientAddressForm.Create(Self);
    try
      ClientAddressForm.OpenMode := omUpdate;
      ClientAddressForm.RecID := spReadContact.FieldByName('g_address').AsLargeInt;
      ClientAddressForm.GClient := spReadClient.FieldByName('g_CLIENT').AsLargeInt;
      if ClientAddressForm.ShowModal = mrOk then
      begin
        ReadClientContact;
      end;
    finally
      ClientAddressForm.Free;
    end;

  end else if pcClientRekv.ActivePage = tsBankRekv then begin
    ClientBankRekForm := TClientBankRekForm.Create(Self);
    try
      ClientBankRekForm.OpenMode := omUpdate;
      ClientBankRekForm.RecID := spReadBankRekv.FieldByName('g_account').AsLargeInt;
      ClientBankRekForm.GClient := spReadClient.FieldByName('g_CLIENT').AsLargeInt;
      if ClientBankRekForm.ShowModal = mrOk then
      begin
        ReadClientContact;
      end;
    finally
      ClientBankRekForm.Free;
    end;
  end;
end;

procedure TClientListForm.aDelContactExecute(Sender: TObject);
var SP : TpFIBStoredProc;
begin
  if pcClientRekv.ActivePage <> tsHistory then begin
    if pcClientRekv.ActivePage = tsContact then begin
      if MessageDlg(Format('Удалить адрес "%s" ?',
        [spReadContact.FieldByName('Address').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

      SP := spDelContact;
      SP.ParamByName('G_ADDRESS_').AsInt64 := spReadContact.FieldByName('G_ADDRESS').AsLargeInt;

    end else if pcClientRekv.ActivePage = tsBankRekv then begin
      if MessageDlg(Format('Удалить счет "%s" ?',
        [spReadBankRekv.FieldByName('Account').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

      SP := spDelBankRekv;
      SP.ParamByName('G_account_').AsInt64 := spReadBankRekv.FieldByName('G_account').AsLargeInt;
    end;

    if not SP.Transaction.InTransaction then
      SP.Transaction.StartTransaction;

    if ExecSP(SP) then begin
      if SP.Transaction.InTransaction then
        SP.Transaction.Commit;
      ReadClientContact;
    end;
  end;
end;

procedure TClientListForm.pcClientRekvChange(Sender: TObject);
begin
  ReadClientContact;
end;

procedure TClientListForm.aInsChdCategoryExecute(Sender: TObject);
begin
  FIns_Child := 1;
  InsData;
end;

procedure TClientListForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  tvClient.Controller.Customization := True;
end;

procedure TClientListForm.FormShow(Sender: TObject);
begin
  inherited;
  ActiveListControl := gr2;
  if FIs_supplier = 1 then begin
    clmClientN_PERCENT.Destroy;
    clmClientBARCODE.Destroy;
    clmClientSKIDKA.Destroy;
    clmClientSUMM.Destroy;
    clmClientSUMM_ALL.Destroy;
    clmnGrp.Caption.Text := 'Группы поставщиков';
    clmClienSUMM_DOLG.Destroy;
  end;
  aIns.Hint := 'Добавить группу клиентов';
  aInsLike.Hint := 'Добавить копию группы клиентов';
  aView.Hint := 'Просмотреть группу клиентов';
  aUpd.Hint := 'Изменить группу клиентов';
  aDel.Hint := 'Удалить группу клиентов';

  pcClientRekv.Height := ReadIntSettingsIni('ClientList', 'SplitterPos', 170);
end;

function TClientListForm.FillLog: string;
begin
  FNewRec.Name := spReadClient.FieldByName('Name').AsString + ' (ID ' + spReadClient.FieldByName('G_CLIENT').AsString + ')';
  Result := FillLogClient(1, FNewRec, FNewRec);
end;

end.
