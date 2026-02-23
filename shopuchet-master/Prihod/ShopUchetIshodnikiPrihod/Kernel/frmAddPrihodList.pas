unit frmAddPrihodList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, DB, ExtCtrls, Menus, frmDBEdit,
  ActnList, dxBar, dxBarExtItems, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, dxSkinsdxBarPainter, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridLevel, cxGridCustomView, cxGrid,
  cxContainer, cxTextEdit, System.UITypes, cxNavigator, System.Actions,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, Vcl.ComCtrls, dxCore, cxDateUtils, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxMemo, cxSpinEdit,
  cxTimeEdit, cxMaskEdit, cxCalendar, Vcl.StdCtrls, cxCalc, cxCurrencyEdit,
  Vcl.Buttons, cxButtons, FIB, IniFiles, Math, cxCheckBox, frmPrihodTovaraList,
  Vcl.AppEvnts, System.DateUtils;

type
  TRecOplata = record
    Id: Integer;
    Date: TDate;
    Summ  : Double;
    Payment: Integer;
  end;
  TArrOplata = Array of TRecOplata;

  TAddPrihodListForm = class(TDBListForm)
    Panel1: TPanel;
    spPostavshik: TpFIBDataSet;
    dsPostavshik: TDataSource;
    spPaymentType: TpFIBDataSet;
    dsPaymentType: TDataSource;
    Label7: TLabel;
    Shape12: TShape;
    edDate: TcxDateEdit;
    Shape13: TShape;
    Shape11: TShape;
    Label10: TLabel;
    Shape15: TShape;
    edTime: TcxTimeEdit;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    mNote: TcxMemo;
    Label9: TLabel;
    Label13: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    lePostavshik: TcxLookupComboBox;
    Shape25: TShape;
    lePAYMENT_TYPE: TcxLookupComboBox;
    Shape26: TShape;
    clmMainSKLAD: TcxGridDBColumn;
    clmMainG_PRODUCT: TcxGridDBColumn;
    clmMainBARCODE: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    clmMainAMOUNT: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainSUMM: TcxGridDBColumn;
    clmMainOSTATOK: TcxGridDBColumn;
    spProduct: TpFIBDataSet;
    dsProduct: TDataSource;
    clmMainCHARGE_ROZN_PROC: TcxGridDBColumn;
    clmMainCHARGE_ROZN_SUM: TcxGridDBColumn;
    clmMainCHARGE_OPT_PROC: TcxGridDBColumn;
    clmMainCHARGE_OPT_SUM: TcxGridDBColumn;
    Panel2: TPanel;
    btHelp: TcxButton;
    cxButton1: TcxButton;
    btnCancel: TcxButton;
    lb1: TLabel;
    sh3: TShape;
    sh4: TShape;
    edSumm: TcxCurrencyEdit;
    lb2: TLabel;
    sh2: TShape;
    sh5: TShape;
    edSummFact: TcxCurrencyEdit;
    lb3: TLabel;
    sh1: TShape;
    sh6: TShape;
    edSummDolg: TcxCurrencyEdit;
    lbSummCurrency: TLabel;
    shpCurrency: TShape;
    shpCurrency1: TShape;
    edSummCurrency: TcxCurrencyEdit;
    sbEqualSumm: TSpeedButton;
    btnOplata: TBitBtn;
    spGetData: TpFIBStoredProc;
    spIns: TpFIBStoredProc;
    spUpd: TpFIBStoredProc;
    spUpdPrices: TpFIBStoredProc;
    aOplata: TAction;
    aPrint: TAction;
    spDoReturn: TpFIBStoredProc;
    spUpdLock: TpFIBStoredProc;
    cxStyleRepository1: TcxStyleRepository;
    stlNewRecord: TcxStyle;
    aSaveAndExit: TAction;
    btnSaveAndExit: TcxButton;
    ApplicationEvents: TApplicationEvents;
    spFindProduct: TpFIBStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spReadAfterInsert(DataSet: TDataSet);
    procedure spReadAfterPost(DataSet: TDataSet);
    procedure tvMainEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure tvMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure clmMainG_PRODUCTPropertiesEditValueChanged(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tvMainDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
    procedure edDatePropertiesChange(Sender: TObject);
    procedure lePostavshikPropertiesChange(Sender: TObject);
    procedure lePAYMENT_TYPEPropertiesChange(Sender: TObject);
    procedure edSummFactPropertiesChange(Sender: TObject);
    procedure aPrintExecute(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure aOplataExecute(Sender: TObject);
    procedure clmMainG_PRODUCTGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure clmMainG_PRODUCTStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure aCloseExecute(Sender: TObject);
    procedure sbEqualSummClick(Sender: TObject);
    procedure spReadApplyDefaultValue(DataSet: TDataSet; Field: TField;
      var Applied: Boolean);
    procedure spReadBeforeDelete(DataSet: TDataSet);
    procedure edSummPropertiesChange(Sender: TObject);
    procedure aSaveAndExitExecute(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure clmMainBARCODEPropertiesEditValueChanged(Sender: TObject);
    procedure tvMainEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FId : integer;    // id sklad_parent
    FNaklId : integer;
    FOpenmode : TOpenMode;
    isInsert : Boolean;
    isOk     : Boolean;       //закрыта по кнопке Сохранить
    FArrOplata  : TArrOplata;
    FIS_Vozvrat : Integer; // 0 - обычный приход, 1 - возврат товара
    FZakaz      : Integer; // если больше 0, то значит форма вызвана для возврата, надо делать возврат
    FPrihodTovaraList : TPrihodTovaraListForm;
    function AddNewRecord(Aview : TcxGridDBTableView; Key: Word; DoNullKey : Boolean) : Word;
  protected
    function  CheckParams(var ErrControl: TWinControl): Boolean;
    function  CallSP(SP: TpFIBStoredProc): Boolean;
    function  InsData: Boolean;
    function  UpdData: Boolean;
    procedure FindAndIns;
    procedure ClearTempTable;
    procedure DisableControls;
    procedure SetArrOplataSumm;
    procedure EnableSummFact;
    procedure SetPaymentType;
    procedure SetParams(SP: TpFIBStoredProc);
    procedure GetData;
    procedure ReadOnlyControls;
  public
    property Id : Integer read FId write FId;
    constructor CreateIt(AOwner: TComponent; Id : integer; IS_Vozvrat: Integer; OpenMode : TOpenMode; Zakaz : Integer);
    procedure ReadList; override;
  end;

var
  AddPrihodListForm: TAddPrihodListForm;

implementation

uses frmGUnit, dmMain, unCommonFunc, unErrorHandlers, frmOplata, dmReports;

{$R *.dfm}

constructor TAddPrihodListForm.CreateIt(AOwner: TComponent; Id : integer; IS_Vozvrat: Integer; OpenMode : TOpenMode; Zakaz : Integer);
var Caption_ : String;
begin
  IF IS_Vozvrat = 0 THEN begin
    Caption_ := 'Приход товара';
    Helpc := 17;
  end else if IS_Vozvrat = 1 THEN begin
    Caption_ := 'Возврат товара';
    Helpc := 20;
  end else begin
    Caption_ := 'Приход товара с другого склада';
    Helpc := 52;
  end;

  FId := Id;
  FOpenmode := OpenMode;
  FIS_Vozvrat := IS_Vozvrat;
  FZakaz := Zakaz;
  FPrihodTovaraList := (AOwner as TPrihodTovaraListForm);

  inherited Create(AOwner, Caption_, '');
end;

function TAddPrihodListForm.CallSP(SP: TpFIBStoredProc): Boolean;
{Выполняет процедуру, вызывая методы проверки и установки параметров.
 Без try..except}
var
  ErrControl: TWinControl;
begin
  Result := False;

  if not CheckParams(ErrControl) then begin
    if ErrControl <> Nil then
      ErrControl.SetFocus;
    Exit;
  end;

  if not SP.Transaction.InTransaction then
    SP.Transaction.StartTransaction;

  SetParams(SP);

  Result := ExecSP(SP);

  if SP.Transaction.InTransaction then
    SP.Transaction.Commit;
end;

function TAddPrihodListForm.InsData: Boolean;
begin
  Result := False;
  spIns.ParamByName('Is_VOZVRAT_').AsInteger := FIs_vozvrat;
  spIns.ParamByName('SKLAD_NAKL_ID_').AsInteger := FNaklId;
  try
    if CallSP(spIns) then
    begin
      FId := spIns.ParamByName('sklad_').AsInteger;
      Result := True;
    end
    else
      Exit;
  except
    on E: EFIBError do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.RollbackRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TPrihodTovaraNForm.InsData)');
    end;
    on E: Exception do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.RollbackRetaining;
      MessageDlg(E.Message + #13#10'(occured in TPrihodTovaraNForm.InsData)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TAddPrihodListForm.lePAYMENT_TYPEPropertiesChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Payment := lePAYMENT_TYPE.EditValue;
end;

procedure TAddPrihodListForm.lePostavshikPropertiesChange(Sender: TObject);
begin
  // ставлю автоматом наличный или безналичный расчет
  if spPostavshik.FieldByName('is_beznal').AsInteger = 1 then
    lePAYMENT_TYPE.EditValue := 2
  else
    lePAYMENT_TYPE.EditValue := 1;
end;

function TAddPrihodListForm.UpdData: Boolean;
begin
  Result := False;
  try
    spUpd.ParamByName('SKLAD_PARENT_').AsInteger := FId;

    if CallSP(spUpd) then
    begin
      Result := True;
    end
    else
      Exit;
  except
    on E: EFIBError do begin
      if spUpd.Transaction.InTransaction then
        spUpd.Transaction.RollbackRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TPrihodTovaraNForm.UpdData)');
    end;
    on E: Exception do begin
      if spUpd.Transaction.InTransaction then
        spUpd.Transaction.RollbackRetaining;
      MessageDlg(E.Message + #13#10'(occured in TPrihodTovaraNForm.UpdData)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TAddPrihodListForm.DisableControls;
begin
  aIns.Enabled := False;
  aUpd.Enabled := False;
  aDel.Enabled := False;
  aOplata.Enabled := False;
  edDate.ENABLED := FALSE;
  edTime.ENABLED := FALSE;
  edSummFact.ENABLED := FALSE;

  mNote.Enabled := FALSE;
  lePostavshik.ENABLED := FALSE;
  lePAYMENT_TYPE.ENABLED := FALSE;
  aSaveAndExit.Enabled := FALSE;
  gr1.Enabled := False;
end;

procedure TAddPrihodListForm.edDatePropertiesChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Date := edDate.Date;
end;

procedure TAddPrihodListForm.edSummFactPropertiesChange(Sender: TObject);
begin
  edSummFact.Text := StringReplace(edSummFact.Text, ',', '.', [rfReplaceAll]);

  edSummDolg.Value := edSumm.Value - edSummFact.Value;
  if High(FArrOplata) = 0 then
    FArrOplata[0].Summ := edSummFact.Value;
end;

procedure TAddPrihodListForm.edSummPropertiesChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    edSummFact.Value := edSumm.Value
  else begin
    edSummDolg.Value := edSumm.Value - edSummFact.Value;
  end;
end;

procedure TAddPrihodListForm.SetArrOplataSumm;
begin
  if High(FArrOplata) = 0 then begin
    FArrOplata[0].Date := edDate.Date;
    FArrOplata[0].Payment := lePAYMENT_TYPE.EditValue;
    FArrOplata[0].Summ := edSummFact.Value;
  end;
end;

procedure TAddPrihodListForm.EnableSummFact;
begin
  edSummFact.Enabled := High(FArrOplata) = 0;
  sbEqualSumm.Enabled := High(FArrOplata) = 0;
end;

procedure TAddPrihodListForm.SetPaymentType;
var NalPyament, BeznalPayment, i : integer;
begin
  // если платеж один, то ставлю накладной его способ оплаты, также если платежей несколько, и все они одного способа платежа, то тоже ставлю их способ
  if High(FArrOplata) = 0 then
    lePAYMENT_TYPE.EditValue := FArrOplata[0].Payment
  else begin
    for i := 0 to High(FArrOplata) do begin
      if FArrOplata[i].Payment = 1 then
        NalPyament := 1
      else if FArrOplata[i].Payment = 2 then
        BeznalPayment := 1
    end;

    if (NalPyament = 1) and (BeznalPayment = 0) then
      lePAYMENT_TYPE.EditValue := 1
    else if (NalPyament = 0) and (BeznalPayment = 1) then
      lePAYMENT_TYPE.EditValue := 2;
  end;
end;

function TAddPrihodListForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := False;

  if NOT CheckDate(edDate.Date, '01.01.2000', '01.01.2099') then begin
    ErrControl := edDate;
    MessageDlg('Введена некорректная дата', mtInformation, [mbOK], 0);
    Exit;
  end;

  if NOT CheckTime(edTime.Time) then begin
    ErrControl := edTime;
    MessageDlg('Введено некорректное время', mtInformation, [mbOK], 0);
    Exit;
  end;

  if edSummFact.Value > edSumm.Value then begin
    MessageDlg('Оплачиваемая сумма не может быть больше суммы прихода. Измените ее' + #13#10 +
               'либо в поле "Оплачено", либо нажав на кнопку "Список платежей".', mtInformation, [mbOK], 0);
    if edSummFact.Enabled then
      ErrControl := edSummFact
    else
      ErrControl := btnOplata;
    Exit;
  end;

  Result := True;
end;

procedure TAddPrihodListForm.ReadList;
var
  OnAfterSummaryEvent : TcxAfterSummaryEvent;
begin
  OnAfterSummaryEvent := tvMain.DataController.Summary.OnAfterSummary;
  tvMain.DataController.Summary.OnAfterSummary := nil;

  inherited;

  // добавляю пустую строку автоматом
  //if spRead.RecordCount = 0 then begin
    gr1.SetFocus;
    spRead.Append;
    tvMain.VisibleColumns[0].Focused := True;
  //end;

  aSaveAndExit.Enabled := spRead.RecordCount > 0;
  tvMain.DataController.Summary.OnAfterSummary := OnAfterSummaryEvent;
end;

procedure TAddPrihodListForm.spReadAfterInsert(DataSet: TDataSet);
begin
  isInsert := True;
end;

procedure TAddPrihodListForm.spReadAfterPost(DataSet: TDataSet);
begin
  if isInsert then begin
    isInsert := False;
    spRead.Locate('sklad', MainDM.dbMain.Gen_Id('GEN_DETAILS_TMP', 0), []);
  end;

  aSaveAndExit.Enabled := spRead.RecordCount > 0;
  mNote.ModifiedAfterEnter := True;
end;

procedure TAddPrihodListForm.spReadApplyDefaultValue(DataSet: TDataSet;
  Field: TField; var Applied: Boolean);
begin
  inherited;
  ShowMessage('asdf');
end;

procedure TAddPrihodListForm.spReadBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ShowMessage('delete');
end;

procedure TAddPrihodListForm.tvMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
var
  AIndex : integer;
begin
  with tvMain.DataController.Summary do begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      edSumm.Value := FooterSummaryValues[AIndex]
    else
      edSumm.Value := 0;

    {if UseCurrency then begin
      AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSummCurrency);
      if not VarIsNull(FooterSummaryValues[AIndex]) then
        edSummCurrency.Value := FooterSummaryValues[AIndex]
      else
        edSummCurrency.Value := 0;
    end;}
  end;
end;

procedure TAddPrihodListForm.tvMainEditing(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; var AAllow: Boolean);
begin
  with Sender.DataController do
    if (VarToStr(Values[FocusedRecordIndex,clmMainG_PRODUCT.Index]) <> '') and (AItem.Index = clmMainBARCODE.Index) then
      AAllow := False
    else
      AAllow := True;
end;

procedure TAddPrihodListForm.tvMainEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
var AView : TcxGridDBTableView;
begin
  AView := Sender as TcxGridDBTableView;
  Key := AddNewRecord(AView, Key, False);
end;

procedure TAddPrihodListForm.tvMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AGridSite: TcxGridSite;
  AView: TcxGridDBTableView;
begin
  AGridSite := Sender as TcxGridSite;
  AView := AGridSite.GridView as TcxGridDBTableView;
  Key := AddNewRecord(AView, Key, True);
end;

procedure TAddPrihodListForm.aCloseExecute(Sender: TObject);
begin
  Close;
end;

function TAddPrihodListForm.AddNewRecord(Aview: TcxGridDBTableView; Key: Word; DoNullKey : Boolean) : Word;
var ACol : integer;
begin
  Result := Key;

  if Key = VK_RETURN then begin
    if Aview.Controller.FocusedRecord.IsLast then begin
      spRead.Append;
      AView.VisibleColumns[0].Focused := True;
    end else
      Aview.Controller.FocusNextRecord(Aview.Controller.FocusedRecordIndex, true, true, false, false);
    Result := 0;
  end else if Key = VK_TAB then begin
    ACol := AView.Controller.FocusedColumn.Index;
    if (Acol = AView.VisibleColumns[AView.VisibleColumnCount-1].Index) then begin
      if Aview.Controller.FocusedRecord.IsLast then begin
        spRead.Append;
        AView.VisibleColumns[0].Focused := True;
      end else
        AView.Controller.FocusNextRecord(AView.Controller.FocusedRecordIndex, true, true, false, false);
      AView.VisibleColumns[0].Focused := True;

      if DoNullKey then
        Result := 0;
    end;
  end;
end;

procedure TAddPrihodListForm.aDelExecute(Sender: TObject);
begin
  if tvMain.VisibleColumns[0].Editing = False then begin
    if MessageDlg('Удалить товар из накладной?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    spRead.Delete;
  end;
end;

procedure TAddPrihodListForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var FSuccess : Boolean;
begin
  inherited;

  if isOk then begin
    CanClose := False;

    if (FOpenMode = omUpdate) and (not CheckRequizChanged(Self)) then
    begin
      //Возможно, OK просто нажата после утверждения или для закрытия окна. Изменений не было
      ClearTempTable;
      CanClose := True;
      Exit;
    end;

    if FOpenMode in [omInsert, omInsertLike, omInsertChild] then
      FSuccess := InsData
    else if FOpenMode = omUpdate then
      FSuccess := UpdData;

    IF FSuccess THEN BEGIN   // ОЧИЩАЮИ ВРЕМЕННУЮ ТАБЛИЧКУ ТОЛЬКО ЕСЛИ БЫЛО УСПЕШНОЕ СОХРАНЕНИЕ
      // при успешном выполнении обновляю цены товарам
      FSuccess := ExecSPTR(spUpdPrices);

      if FSuccess then
        ClearTempTable;
    END;

    if FSuccess and (FOpenmode in [omInsert, omInsertLike, omUpdate]) then
      FPrihodTovaraList.ReadlistAfterEdit(FId);

    CanClose := True;
  end else
    ClearTempTable      // ПО НАЖАТИЮ НА КНОПКУ ОТМЕНА ТОЖЕ ОЧИЩАЮ ВРЕМЯНКУ
end;

procedure TAddPrihodListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'g_unit';
  KeyFieldClass := 'g_unit_';
end;

procedure TAddPrihodListForm.FormShow(Sender: TObject);
begin
  // генерю ID, по которой буду идентифицировать данную накладную, пока человек с ней работает
  // т.к. юзер может создать сразу несколько накладных
  if FOpenmode in [omInsert, omInsertLike] then
    FNaklId := MainDM.dbMain.Gen_Id('GEN_DETAILS_TMP', 1)
  else
    FNaklId := FId;

  spRead.ParamByName('sklad_id_').AsInteger := FNaklId;
  inherited;

  GetData;

  IF FOpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
  end;

  OpenSp(spPostavshik, False);
  spPostavshik.Locate('by_default', 1, []);
  lePostavshik.EditValue := spPostavshik.FieldByName('g_client').AsInteger;
  OpenSp(spPaymentType, False);
  lePAYMENT_TYPE.EditValue := 1;   // по умолчанию поставлю наличный расчет

  OpenSP(spProduct, False);

  aIns.Enabled := False;
  aView.Enabled := False;
  aUpd.Enabled := False;
  aInsLike.Enabled := False;
end;

procedure TAddPrihodListForm.GetData;
var p, i : integer;
  str, str1 : string;
begin

  // прописываю, что ни один компонент еще не был отредактирован
  for i := 0 to Self.ComponentCount - 1 do
    if (Self.Components[i] is TCustomEdit) then
      (Self.Components[i] as TCustomEdit).Modified := False
    else
      if (Self.Components[i] is TcxTextEdit) then
        (Self.Components[i] as TcxTextEdit).ModifiedAfterEnter := False;

  // если возврат на основе продажи
  if FZakaz <> 0 then begin
    with spDoReturn do begin
      ParamByName('zakaz_').AsInteger := FZakaz;
      try
        if not spDoReturn.Transaction.InTransaction then
          spDoReturn.Transaction.StartTransaction;
        spDoReturn.ExecQuery;
        spDoReturn.Transaction.Commit;

        Readlist;
      except
        on E: EFIBError do begin
          if Transaction.InTransaction then
            Transaction.CommitRetaining;
          DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in unCommonFunc.OpenSP)');
        end;
        on E: Exception do begin
          if Transaction.InTransaction then
            Transaction.CommitRetaining;
          MessageDlg(E.Message + #13#10'(occured in unCommonFunc.OpenSP)', mtError, [mbOk], 0);
        end;
      end;
    end;
  end;

  try
    spGetData.ParamByName('sklad_').AsInteger := FID;
    if not spGetData.Transaction.InTransaction then
      spGetData.Transaction.StartTransaction;

    if FOpenMode = omInsertLike then begin
      spGetData.ParamByName('mode_').AsInteger := 1;
      spGetData.ParamByName('sklad_parent_').AsInteger := FNaklId;
    end else
      spGetData.ParamByName('mode_').AsInteger := 0;

    if not ExecSP(spGetData) then begin
      DisableControls;
      Exit;
    end;

    if spGetData.Transaction.InTransaction then
      spGetData.Transaction.CommitRetaining;
  except
    on E: EFIBError do begin
      if spGetData.Transaction.InTransaction then
        spGetData.Transaction.RollbackRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TPrihodTovaraNForm.GetData)');
      DisableControls;
      Exit;
    end;
    on E: Exception do begin
      if spGetData.Transaction.InTransaction then
        spGetData.Transaction.RollbackRetaining;
      MessageDlg(E.Message + #13#10'(occured in TPrihodTovaraNForm.GetData)', mtError, [mbOk], 0);
      DisableControls;
      Exit;
    end;
  end;

  if FOpenMode <> omInsert then BEGIN
    with spGetData do begin
      edDate.Date := ParamByName('DATE_RECEIPT_').AsDate;
      edTIME.TIME := ParamByName('TIME_RECEIPT_').AsTIME;
      lePostavshik.EditValue := ParamByName('G_CLIENT_').AsInteger;
      lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsInteger;
      mNote.Text := ParamByName('note_').AsString;

      Readlist;
      edSumm.Value := ParamByName('summ_').AsFloat;
      edSummFact.Value := ParamByName('summ_fact_').AsFloat;
      edSummCurrency.Value := ParamByName('summ_currency_').AsFloat;
      edSummDolg.Value := edSumm.Value - edSummFact.Value;

      // ЗАПОЛНЯЮ МАССИВ ПЛАТЕЖЕЙ
      i := 0;
      Str := ParamByName('PAYMENTS_').AsString;
      while Length(Str) > 1 do begin
        SetLength(FArrOplata, High(FArrOplata) + 2);
        p := pos('-', Str);
        str1 := Copy(Str, 1, p-1);
        if str1 <> '' then
          FArrOplata[i].Id := StrToInt(str1);

        // дата
        Delete(str, 1, p);
        p := pos('-', Str);
        str1 := Copy(Str, 1, p-1);
        if str1 <> '' then
          FArrOplata[i].Date := StrToDate(str1);

        // сумма
        Delete(str, 1, p);
        p := pos('-', Str);
        str1 := Copy(Str, 1, p-1);
        if str1 <> '' then
          FArrOplata[i].Summ := StrToFloat(str1);

        // способ расчета
        Delete(str, 1, p);
        p := pos('~', Str);
        str1 := Copy(Str, 1, p-1);
        if str1 <> '' then
          FArrOplata[i].Payment := StrToInt(str1);

        Delete(str, 1, p);
        i := i + 1;
      end;
    end;
  end;

  if High(FArrOplata) = -1 then begin
    SetLength(FArrOplata, 1);
    FArrOplata[0].Date := edDate.Date;
    FArrOplata[0].Payment := 1;
  end;
  EnableSummFact;  // выключаю edSummFact, если есть больше одного платежа

  if FOpenmode = omView then
    ReadOnlyControls

  else if FOpenMode = omUpdate then begin
    if (HaveRightUpdPrihod = False) and (FIs_vozvrat = 0) {AND (FOpenMode = omUpdate)} then begin
      MessageDlg('У Вас нет прав на редактирование накладных"!', mtInformation, [mbOk], 0);
      DisableControls;
      Exit;
    end;

    //ПРОВЕРЯЮ ЕСТЬ ЛИ ПРАВО НА РЕДАКТИРОВАНИЕ НАКЛАДНОЙ ЗА ПРОШЛЫЕ ДАТЫ
    //НЕВАЖНО КАКАЯ ДАТА У НАКЛАДНОЙ, МНЕ ПРОЦЕДУРА УЖЕ ВОЗВРАЩАЕТ 1, ЕСЛИ НАКЛАДНАЯ ЗА ТЕКУЩУЮ ДАТУ
    IF (spGetData.ParamByName('HaveRight_').AsInteger = 0) {AND (FOpenMode = omUpdate)} THEN BEGIN
      MessageDlg('Вы не обладаете правом для редактирования накладных за прошлые даты!', mtWarning, [mbOk], 0);
      DisableControls;
      EXIT;
    END;

    //ПРОВЕРЯЮ ЛИЦЕНЗИЮ
    IF (IsActivated = 0) THEN BEGIN
      MessageDlg('Лицензия истекла либо не зарегистрирована. ' + #10#13 + 'Включены ограничения на количество поступлений товара!', mtWarning, [mbOk], 0);
      DisableControls;
      EXIT;
    END;

    //if FOpenMode = omUpdate then begin
      spUpdLock.ParamByName('id_').AsInteger := FId;
      spUpdLock.ParamByName('TABLE_NAME_').AsString := 'sklad_parent';

      if not spUpdLock.Transaction.InTransaction then   //ТРАНЗАКЦИЯ ЗАКОММИТИТЬСЯ, ЕСЛИ КЛИЕНТ НАЖМЕТ КНОПКУ ОК, ИЛИ ОТРОЛЛБАЧИТЬСЯ, ЕСЛИ БУДЕТ ОШИБКА ИЛИ НАЖМУТ КНОПКУ ОТМЕНА
        spUpdLock.Transaction.StartTransaction;
      if not ExecSP(spUpdLock) then begin
        DisableControls;
        EXIT;
      end;
    //end;
  end;
end;

procedure TAddPrihodListForm.ReadOnlyControls;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
    begin
      if Components[i].ClassType = tcxTextEdit then begin
        (Components[i] as tcxTextEdit).Properties.ReadOnly := True;
        (Components[i] as tcxTextEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tcxCurrencyEdit then begin
        (Components[i] as tcxCurrencyEdit).Properties.ReadOnly := True;
        (Components[i] as tcxCurrencyEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tcxMemo then begin
        (Components[i] as tcxMemo).Properties.ReadOnly := True;
        (Components[i] as tcxMemo).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tMemo then begin
        (Components[i] as tMemo).ReadOnly := True;
        (Components[i] as tMemo).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxDateEdit then begin
        (Components[i] as TcxDateEdit).Properties.ReadOnly := True;
        (Components[i] as TcxDateEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TCxDateEdit then begin
        (Components[i] as TCxDateEdit).Enabled := False;
      end
      else if Components[i].ClassType = TcxCheckBox then begin
        (Components[i] as TcxCheckBox).Properties.ReadOnly := True;
        (Components[i] as TcxCheckBox).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxComboBox then begin
        (Components[i] as TcxComboBox).Properties.ReadOnly := True;
        (Components[i] as TcxComboBox).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxPopupEdit then begin
        (Components[i] as TcxPopupEdit).Properties.ReadOnly := True;
        (Components[i] as TcxPopupEdit).Enabled := False;
        (Components[i] as TcxPopupEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxLookupComboBox then begin
        (Components[i] as TcxLookupComboBox).Properties.ReadOnly := True;
        (Components[i] as TcxLookupComboBox).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TSpeedButton then
        (Components[i] as TSpeedButton).Enabled := False
      else if Components[i].ClassType = TRadioButton then
        (Components[i] as TRadioButton).Enabled := False;
    end;
end;

procedure TAddPrihodListForm.sbEqualSummClick(Sender: TObject);
begin
  edSummFact.Value := edSumm.Value;
  edSummFact.ModifiedAfterEnter := True;
end;

procedure TAddPrihodListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

procedure TAddPrihodListForm.aOplataExecute(Sender: TObject);
var OplataForm : TOplataForm;
    i: integer;
begin
  OplataForm := TOplataForm.Create(Self);

  with OplataForm do begin
    try
      SummZakaz := edSumm.Value;
      PaymentType := lePAYMENT_TYPE.EditValue;
      Helpcc := 84;    // раздел справки
      mdRead.Open;
      for i := 0 to High(FArrOplata) do begin
        mdRead.Insert;
        mdRead.FieldByName('id').asInteger := FArrOplata[i].Id;
        mdRead.FieldByName('Date_Pay').AsDateTime := FArrOplata[i].Date;
        mdRead.FieldByName('Summ_Pay').asFloat := FArrOplata[i].Summ;
        mdRead.FieldByName('Payment_Type').asFloat := FArrOplata[i].Payment;
        if FArrOplata[i].Payment = 1 then
          mdRead.FieldByName('Payment_type_str').AsString := 'Наличный'
        else
          mdRead.FieldByName('Payment_type_str').AsString := 'Безналичный'
      end;

      if ShowModal = mrOk then begin
        SetLength(FArrOplata, 0);
        SetLength(FArrOplata, mdRead.RecordCount);
        i := 0;
        mdRead.First;
        while not mdRead.Eof do begin
          FArrOplata[i].Id := mdRead.FieldByName('id').asInteger;
          FArrOplata[i].Date := mdRead.FieldByName('Date_Pay').AsDateTime;
          FArrOplata[i].Payment := mdRead.FieldByName('payment_type').asInteger;
          FArrOplata[i].Summ := mdRead.FieldByName('summ_pay').AsFloat;

          i := i + 1;
          mdRead.Next;
        end;

        edSummFact.Value := Summ;
        EnableSummFact;

        // если платеж один, то ставлю накладной способ расчета этого платежа, либо если платежей несколько, и все они одного способа - тоже меняю
        SetPaymentType;

        mNote.ModifiedAfterEnter := true;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TAddPrihodListForm.FindAndIns;
begin
  //ищу и вставляю товар, если не было
  spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
  if UseScales = 1 then
    spFindProduct.ParamByName('PREFIX_').AsString := ScalesPrefix
  else
    spFindProduct.ParamByName('PREFIX_').AsString := '';

  try
    if not spFindProduct.Transaction.InTransaction then
      spFindProduct.Transaction.StartTransaction;

    IF ExecSPTR(spFindProduct) THEN begin
      if spRead.Locate('g_product', spFindProduct.ParamByName('G_PRODUCT_').AsInteger, []) then begin
        spRead.Edit;
        spRead.FieldByName('amount').AsFloat := spRead.FieldByName('amount').AsFloat + 1;
        spRead.Post;
      end else begin
        spRead.Append;
        spRead.FieldByName('g_product').AsInteger := spFindProduct.ParamByName('G_PRODUCT_').AsInteger;
        spRead.FieldByName('AMOUNT').AsFloat := 1;
        spRead.Post;
        spRead.Append;
      end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TAddPrihodListForm.FindAndIns)', mtInformation, [mbOk], 0);
  end;
end;

procedure TAddPrihodListForm.ApplicationEventsMessage(var Msg: tagMSG;
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
  {IF Screen.ActiveForm <> Nil THEN BEGIN
    IF Screen.ActiveForm.Name = Self.Name THEN BEGIN
      if Msg.message = WM_KEYDOWN then
      begin
        if (Msg.wParam = 13) or (Msg.wParam = 10) then
        begin
          ClearBuffer;
          if KeysBuffer <> '' then begin
            // при сканировании нажатие энтера передавать никуда не надо
            Handled := True;

            FindAndIns;

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
    END;
  END; }
end;

procedure TAddPrihodListForm.aPrintExecute(Sender: TObject);
var
  cbPrinters, edSlogan : STRING;
  cbChooseLentWidth, cbPrintPrice, cbPriceBold, PrinterEtiketok: Integer;
  sePriceSize, cbPrintSlogan, cbSloganBold, seSloganSize : Integer;
  cbNameBold, seNameSize : integer;
  Ini : TMemIniFile;
  sql_str : string;
begin

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    cbPrinters := Ini.ReadString('Printetiket', 'PrinterName', '');
    PrinterEtiketok := Ini.ReadInteger('Printetiket', 'PrinterEtiket', 0);
    if PrinterEtiketok = 1 then
      cbChooseLentWidth := Ini.ReadInteger('Printetiket', 'LentaWidth', 0)
    else
      cbChooseLentWidth := Ini.ReadInteger('Printetiket', 'A4Size', 0);
    edSlogan := Ini.ReadString('Printetiket', 'Slogan', '');
    cbPrintPrice := Ini.ReadInteger('Printetiket', 'PrintPrice', 1);
    cbPrintSlogan := Ini.ReadInteger('Printetiket', 'PrintSlogan', 1);
    cbPriceBold := Ini.ReadInteger('Printetiket', 'PriceBold', 1);
    cbSloganBold := Ini.ReadInteger('Printetiket', 'SloganBold', 1);
    sePriceSize := Ini.ReadInteger('Printetiket', 'PriceSize', 0);
    seSloganSize := Ini.ReadInteger('Printetiket', 'SloganSize', 0);
    seNameSize := Ini.ReadInteger('Printetiket', 'NameSize', 0);
    cbNameBold := Ini.ReadInteger('Printetiket', 'NameBold', 1);
  finally
    Ini.Free;
  end;

  if cbPrinters = '' then begin
    MessageDlg('Принтер для печати этикеток не задан!', mtError, [mbOK], 0);
    Exit;
  end;

  if PrinterEtiketok = 1 then begin
    with spRead do begin
      First;
      while not eof do begin
        ReportsDM.PrintLabel(cbPrinters,
                            PrinterEtiketok,
                            '',
                            cbChooseLentWidth,
                            cbPrintPrice,
                            cbPriceBold,
                            sePriceSize,
                            cbPrintSlogan,
                            cbSloganBold,
                            seSloganSize,
                            edSlogan,
                            Trunc(SimpleRoundTo(FieldByName('amount').asFloat, 0)),
                            0,  //SloganOrPrice,
                            FieldByName('Barcode').AsString,
                            FieldByName('NAME').AsString,
                            FieldByName('PRODUCT_PRICE').AsString,
                            cbNameBold,
                            seNameSize);
        Next;
      end;
    end;
  end else begin
    sql_str := 'WITH RECURSIVE TREE AS (SELECT g.name, g.barcode, TRUNC(g.price) PRICE, 1 levl, G.G_PRODUCT' +
                          ' FROM G_PRODUCT g' +
                         ' WHERE EXISTS (SELECT 1' +
                                         ' FROM SKLAD SD' +
                                        ' WHERE SD.sklad_PARENT = ' + IntToStr(FId) +
                                          ' AND SD.g_product = g.g_product)' +
                        ' UNION ALL' +
                        ' SELECT g.name, g.barcode, TRUNC(g.price) PRICE, gg.levl + 1 levl, G.G_PRODUCT' +
                          ' FROM G_PRODUCT g INNER JOIN TREE GG ON GG.name = g.name' +
                         ' WHERE G.g_product = GG.G_PRODUCT' +
                           ' AND gg.levl < (SELECT SUM(AMOUNT) FROM sklad SDD' +
                                            ' WHERE SDD.sklad_parent = ' + IntToStr(FId) +
                                            ' AND SDD.g_product = G.g_product)' +
                        ' )'+
               ' SELECT * FROM TREE';
      ReportsDM.PrintLabel(cbPrinters,
                            PrinterEtiketok,
                            sql_str,
                            cbChooseLentWidth,
                            cbPrintPrice,
                            cbPriceBold,
                            sePriceSize,
                            cbPrintSlogan,
                            cbSloganBold,
                            seSloganSize,
                            edSlogan,
                            0,  //Amount
                            0,  //SloganOrPrice,
                            '',
                            '',
                            '',
                            cbNameBold,
                            seNameSize);
  end;
end;

procedure TAddPrihodListForm.aSaveAndExitExecute(Sender: TObject);
begin
  isOk := True;
  Close;
end;

procedure TAddPrihodListForm.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  if FIs_vozvrat = 0 then
    HELPC := 17
  else if FIs_vozvrat = 1 then
    HELPC := 20;

  Application.HelpContext(HELPC);
end;

procedure TAddPrihodListForm.SetParams(SP: TpFIBStoredProc);
var i : Integer; StrArr : string;
begin
  with SP do begin
    ParamByName('DATE_RECEIPT_').AsDate := edDate.Date;
    ParamByName('TIME_RECEIPT_').AsTIME := edTIME.TIME;
    if lePostavshik.EditValue > 0 then
      ParamByName('G_CLIENT_').AsInteger := lePostavshik.EditValue;
    if lePAYMENT_TYPE.EditValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInteger := lePAYMENT_TYPE.EditValue
    else
      ParamByName('G_PAYMENT_TYPE_').AsInteger := 1;  // по умолчанию поставлю наличный расчет, если клиент вдруг ничего не выбрал
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('summ_').AsFloat := edSumm.Value;
    ParamByName('summ_currency_').AsFloat := edSummCurrency.Value;
    ParamByName('summ_fact_').AsFloat := edSummFact.Value;

    IF (High(FArrOplata) > 0) or (FOpenMode = omUpdate) then begin
      for i := 0 to High(FArrOplata) do
        StrArr := StrArr + IntToStr(FArrOplata[i].Id) + '-' + DateToStr(FArrOplata[i].Date) + '-' + FloatToStr(FArrOplata[i].Summ) + '-' + IntToStr(FArrOplata[i].Payment)+ '~';

      StrArr := StringReplace(StrArr, ',', '.', [rfReplaceAll, rfIgnoreCase]);   //заменяю на всякий случай запятые на точки
      ParamByName('PAYMENTS_').AsString := StrArr;
    end;
  end;
end;

procedure TAddPrihodListForm.clmMainBARCODEPropertiesEditValueChanged(
  Sender: TObject);
begin
  if tvMain.Controller.FocusedRecord.IsLast then begin
    spRead.Append;
  end;
end;

procedure TAddPrihodListForm.clmMainG_PRODUCTGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if (AText = '') then
    AText := '  Введите название товара';
end;

procedure TAddPrihodListForm.clmMainG_PRODUCTPropertiesEditValueChanged(
  Sender: TObject);
begin
  if tvMain.Controller.FocusedRecord.IsLast then begin
    spRead.Append;
  end;
end;

procedure TAddPrihodListForm.clmMainG_PRODUCTStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarToStr(ARecord.Values[clmMainG_PRODUCT.Index]) = '' then
    AStyle := stlNewRecord;
end;

procedure TAddPrihodListForm.ClearTempTable;
begin
  spDel.Params[0].Clear;
  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  spDel.ParamByName('SKLAD_PARENT_').AsInteger := FNaklId;
  ExecSP(spDel);

  if spDel.Transaction.InTransaction then
    spDel.Transaction.Commit;
end;

end.
