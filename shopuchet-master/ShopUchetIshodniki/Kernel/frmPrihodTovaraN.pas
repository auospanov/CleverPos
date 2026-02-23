unit frmPrihodTovaraN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, DB, FIBDataSet, pFIBDataSet, Buttons, cxPC, StdCtrls,
  cxSpinEdit, cxTimeEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  ExtCtrls, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase,
  ActnList, AppEvnts, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxCurrencyEdit, cxMemo,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, unCommonFunc, FIB, Math,
  IniFiles, System.UITypes, Vcl.ComCtrls, dxCore, cxDateUtils, dxBarBuiltInMenu,
  cxNavigator, System.Actions, Vcl.Menus, cxButtons, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, cxGridExportLink,
  cxCheckBox, cxEditRepositoryItems, System.DateUtils, dxmdaset, unLog,
  frmPopupClientMultList, unFRPrinted;

type
  TRecPrice = record
    Id: Int64;
    ProductId: Int64;
    Price  : Double;
    PriceOpt: Double;
  end;

  TRecOplata = record
    Id: Int64;
    Date: TDate;
    Summ  : Double;
    Payment: Int64;
  end;

  TArrPrice = Array of TRecPrice;
  TArrOplata = Array of TRecOplata;

  TPrihodTovaraNForm = class(TDBEditForm)
    pnlTop: TPanel;
    Shape11: TShape;
    shpNote: TShape;
    shpPayType: TShape;
    Shape17: TShape;
    Shape14: TShape;
    Shape12: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbPayment: TLabel;
    lbNote: TLabel;
    Shape13: TShape;
    Label10: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Shape18: TShape;
    Shape26: TShape;
    shpNote1: TShape;
    edDate: TcxDateEdit;
    edTime: TcxTimeEdit;
    pcMain: TcxPageControl;
    tsCommon: TcxTabSheet;
    pn1: TPanel;
    pn2: TPanel;
    btnIns: TBitBtn;
    btnUpd: TBitBtn;
    btnDel: TBitBtn;
    pnRowCnt: TPanel;
    pn3: TPanel;
    sh1: TShape;
    sh2: TShape;
    sh3: TShape;
    lb1: TLabel;
    sh4: TShape;
    lb2: TLabel;
    sh5: TShape;
    lb3: TLabel;
    sh6: TShape;
    sbEqualSumm: TSpeedButton;
    btnOplata: TBitBtn;
    tsRashod: TcxTabSheet;
    lbStatya: TLabel;
    sbClear: TSpeedButton;
    spUpdLock: TpFIBStoredProc;
    spUpdPrices: TpFIBStoredProc;
    spReadStatya: TpFIBDataSet;
    dsReadStatya: TDataSource;
    spDel: TpFIBStoredProc;
    dsZakazTemp: TDataSource;
    spZakazTemp: TpFIBDataSet;
    spPaymentType: TpFIBDataSet;
    dsPaymentType: TDataSource;
    spPostavshik: TpFIBDataSet;
    dsPostavshik: TDataSource;
    edOsnovanie: TcxTextEdit;
    lePostavshik: TcxLookupComboBox;
    lePAYMENT_TYPE: TcxLookupComboBox;
    mNote: TcxMemo;
    edSumm: TcxCurrencyEdit;
    edSummFact: TcxCurrencyEdit;
    edSummDolg: TcxCurrencyEdit;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    clmMainAMOUNT: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainSUMM: TcxGridDBColumn;
    clmMainPRODUCT_NAME: TcxGridDBColumn;
    edSummPrihod: TcxCurrencyEdit;
    leStatya: TcxLookupComboBox;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    aOplata: TAction;
    aPrint: TAction;
    lbSummCurrency: TLabel;
    shpCurrency: TShape;
    shpCurrency1: TShape;
    edSummCurrency: TcxCurrencyEdit;
    clmMainSummCurrency: TcxGridDBColumn;
    spDoReturn: TpFIBStoredProc;
    clmMainG_UNIT_NAME: TcxGridDBColumn;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    dlgSave: TSaveDialog;
    aCustomizeColumns: TAction;
    aSaveAllToXLS: TAction;
    aSaveSelectedToXLS: TAction;
    clmMainBARCODE: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    tsExpected: TcxTabSheet;
    lbRecalc: TLabel;
    cbIsExpected: TcxCheckBox;
    cxButton2: TcxButton;
    pmEtiket: TPopupMenu;
    N1: TMenuItem;
    aPrintCur: TAction;
    N2: TMenuItem;
    aFindAndIns: TAction;
    spFindAndInsProduct: TpFIBStoredProc;
    ApplicationEvents: TApplicationEvents;
    clmMainSALE_PRICE: TcxGridDBColumn;
    lbSklad: TLabel;
    shpSklad: TShape;
    shpSklad1: TShape;
    leSklad: TcxLookupComboBox;
    spReadSklad: TpFIBDataSet;
    dsReadSklad: TDataSource;
    clmMARGIN_PERCENT: TcxGridDBColumn;
    btnNacenka: TcxButton;
    pmNakrutka: TPopupMenu;
    aNacenka: TAction;
    aRound: TAction;
    aRoundTen: TAction;
    aRoundHundred: TAction;
    aRoundThousand: TAction;
    spUpdateTmpAll: TpFIBStoredProc;
    mniNacenka: TMenuItem;
    mniN4: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    mniRoundHundred: TMenuItem;
    mniRoundThousand: TMenuItem;
    aRoundDrob: TAction;
    mniRoundDrob: TMenuItem;
    N3: TMenuItem;
    N11: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    mdOldTovar: TdxMemData;
    mdNewTovar: TdxMemData;
    spFindProduct: TpFIBStoredProc;
    spInsByScaner: TpFIBStoredProc;
    btnSearchClient: TcxButton;
    aSearchClient: TAction;
    clmVES_GRAMM: TcxGridDBColumn;
    clmVES_GRAMM_PRICE: TcxGridDBColumn;
    lbNonCashPayType: TLabel;
    shpNonCashPayType: TShape;
    shpNonCashPayType1: TShape;
    leNonCashPayType: TcxLookupComboBox;
    spNonCashPayTypes: TpFIBDataSet;
    dsNonCashPayTypes: TDataSource;
    btnIns1: TBitBtn;
    aInsNewTovar: TAction;
    cbFiscalMode: TcxCheckBox;
    SQLTransaction: TpFIBDataSet;
    procedure FormShow(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grProductDblClick(Sender: TObject);
    procedure sbEqualSummClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aOplataExecute(Sender: TObject);
    procedure edDatePropertiesChange(Sender: TObject);
    procedure edSummFactPropertiesChange(Sender: TObject);
    procedure lePAYMENT_TYPEPropertiesChange(Sender: TObject);
    procedure lePostavshikPropertiesChange(Sender: TObject);
    procedure tvMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure aPrintExecute(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure aSaveAllToXLSExecute(Sender: TObject);
    procedure aSaveSelectedToXLSExecute(Sender: TObject);
    procedure aPrintCurExecute(Sender: TObject);
    procedure aFindAndInsExecute(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure spZakazTempAfterPost(DataSet: TDataSet);
    procedure tvMainDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
    procedure aNacenkaExecute(Sender: TObject);
    procedure aRoundExecute(Sender: TObject);
    procedure aRoundTenExecute(Sender: TObject);
    procedure aRoundHundredExecute(Sender: TObject);
    procedure aRoundThousandExecute(Sender: TObject);
    procedure aRoundDrobExecute(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure aSearchClientExecute(Sender: TObject);
    procedure aInsNewTovarExecute(Sender: TObject);
    procedure edTimePropertiesChange(Sender: TObject);
  private
    FPopupPostavshikForm : TPopupClientMultListForm;
    pePostavshikTag : Int64;
    FIsGetDataNow : Boolean;  //флаг, что сейчас происходит GetData
    FIsClosingNow : Boolean;  //флаг, что сейчас происходит закрытие
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FArrPrice   : TArrPrice;
    FArrOplata  : TArrOplata;
    FArrOplataOld : TArrOplata;
    FSuccess    : Boolean;
    FIs_vozvrat : Integer; // 0 - обычный приход, 1 - возврат товара
    FZakaz      : Int64; // если больше 0, то значит форма вызвана для возврата, надо делать возврат
    FZakazNonCashPayType : Int64;
    FZakazNote  : String;
    FClientLoc  : Int64; // пока будет заполнятся при возврате на основе продажи
    FedDate     : TDate;
    FedTime     : TDate;
    FChargeProc : Double;   // процент накрутки
    FRoundVal   : Integer;  // округление 0 - до целых, 1 - десятки, 2 - сотни, 2 - тысячи
    FTovarWasChanged : Boolean;
    FRecOld : TRec;
    FPos_Pay_method, FPos_transaction_id : string;
    FNoteVozvrat : String;
    insUpd: Boolean;
    function FillLog : string;
  protected
    function CallSP(SP: TpFIBStoredProc): Boolean;
    function InsData: Boolean;
    function UpdData: Boolean;
    procedure ClearTempTable;
    procedure DisableControls;
    procedure SetArrOplataSumm;
    procedure EnableSummFact;
    procedure SetPaymentType;
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure InsTmpTovar;
    procedure DoNacenka(ChargeProc : Double = -1; RoundMode : integer = 0);
    procedure SetNonCashPayTypeVisible;
  public
    function CheckParams(var ErrControl: TWinControl): Boolean; override;
    property Success: Boolean read FSuccess write FSuccess default False;
    property Is_vozvrat: Integer read FIs_vozvrat write FIs_vozvrat default 0;
    property Zakaz : Int64 read FZakaz write FZakaz;
    property ZakazNote : String read FZakazNote write FZakazNote;
    property ClientLoc : Int64 read FClientLoc write FClientLoc;
    property NoteVozvrat : String read FNoteVozvrat write FNoteVozvrat;

    procedure Readlist;
    procedure PrintEtickets(printAll : boolean; mode : integer = 0);
  public
    { Public declarations }
  end;

var
  PrihodTovaraNForm: TPrihodTovaraNForm;

implementation

uses unErrorHandlers, frmZakupkaTovara, frmUpdZakupkaTovara, frmOplata, unInitApp,
  dmReports, unkkm, frmPriceListUn, frmNacenka, frmUpdProdazhaTovara,
  frmSaleMarkCodeInput, frmGetDCard, frmPosTerminalProcess, dmMain;

{$R *.dfm}

function TPrihodTovaraNForm.CallSP(SP: TpFIBStoredProc): Boolean;
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

function TPrihodTovaraNForm.CheckParams(var ErrControl: TWinControl): Boolean;
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

  if OpenMode in [omInsert, omInsertLike] then begin
    if (edSummPrihod.Value > 0) and (leStatya.Text = '') then begin
      ErrControl := leStatya;
      MessageDlg('Статья расхода не указана.', mtInformation, [mbOK], 0);
      Exit;
    end;

    if (edSummPrihod.Value = 0) and (leStatya.Text <> '') then begin
      ErrControl := edSummPrihod;
      MessageDlg('Сумма расхода не указана.', mtInformation, [mbOK], 0);
      Exit;
    end;

    // если подключен ФР, то не даю продавать заказ, где сумма оплаты меньше суммы заказа
    if CheckPrintDeviceFr in [1,2] then
      if edSumm.Value > edSummFact.Value then begin
        MessageDlg('Сумма оплаты меньше суммы чека! Такой чек не будет принят фиск. регистратором (онлайн-кассой).' + CRLF +
        'Уменьшите стоимость товаров.', mtWarning, [mbOk], 0);
        if edSummFact.Enabled then
          ErrControl := edSummFact;
        Exit;
      end;
  end;

  Result := True;
end;

procedure TPrihodTovaraNForm.SetParams(SP: TpFIBStoredProc);
var i : Integer; StrArr : string;
begin
  with SP do begin
    if SP.Name = 'spIns' then
      ParamByName('G_TOCHKA_').AsInt64 := leSklad.EditValue;
    ParamByName('DATE_RECEIPT_').AsDate := edDate.Date;
    ParamByName('TIME_RECEIPT_').AsTIME := edTIME.TIME;
    if lePostavshik.EditValue > 0 then
      ParamByName('G_CLIENT_').AsInt64 := lePostavshik.EditValue;
    if lePAYMENT_TYPE.EditValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInt64 := lePAYMENT_TYPE.EditValue
    else
      ParamByName('G_PAYMENT_TYPE_').AsInt64 := 1;  // по умолчанию поставлю наличный расчет, если клиент вдруг ничего не выбрал
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    ParamByName('is_expected_').AsInteger := Integer(cbIsExpected.Checked);
    ParamByName('summ_').AsFloat := edSumm.Value;
    ParamByName('summ_currency_').AsFloat := edSummCurrency.Value;
    ParamByName('summ_fact_').AsFloat := edSummFact.Value;
    IF (leStatya.EditValue <> 0) and (leStatya.EditValue <> null) THEN
      ParamByName('g_prihod_').AsInt64 := leStatya.EditValue;
    ParamByName('summ_prihod_').AsFloat := edSummPrihod.Value;

    IF (High(FArrOplata) > 0) or (OpenMode = omUpdate) then begin
      for i := 0 to High(FArrOplata) do
        StrArr := StrArr + IntToStr(FArrOplata[i].Id) + '-' + DateToStr(FArrOplata[i].Date) + '-' + FloatToStr(FArrOplata[i].Summ) + '-' + IntToStr(FArrOplata[i].Payment)+ '~';

      StrArr := StringReplace(StrArr, ',', '.', [rfReplaceAll, rfIgnoreCase]);   //заменяю на всякий случай запятые на точки
      ParamByName('PAYMENTS_').AsString := StrArr;
    end;

    if (FIs_vozvrat = 1) and (lePAYMENT_TYPE.EditValue = 2) then
      ParamByName('G_NONCASH_PAY_TYPE_').AsInt64 := leNonCashPayType.EditValue
    else
      ParamByName('G_NONCASH_PAY_TYPE_').Clear;

    // надо ли заносить продажу в отдельную таблицу для выгрузки в XML
    if (FIs_vozvrat in [0, 1]) and ((Copy(ExportDataType, 6, 1) = '1') or (UploadToMobile)) then
      ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 1
    else
      ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;

    ParamByName('USER_ID_').AsInt64 := CurrentOfficial;
    ParamByName('LOG_BODY_').AsString := FillLog;

    if (FIs_vozvrat = 1) and (FZakaz <> 0) then begin
      ParamByName('zakaz_').AsInt64 := FZakaz;
    end;

    ParamByName('NOTE_').AsString := mNote.Text;
  end;
end;

procedure TPrihodTovaraNForm.Readlist;
var
  AIndex : integer;
begin
  OpenSP(spZakazTemp, True);
  pnRowCnt.Caption := IntToStr(spZakazTemp.RecordCount);
  aUpd.Enabled := spZakazTemp.RecordCount > 0;
  aDel.Enabled := spZakazTemp.RecordCount > 0;
  aOplata.Enabled := (spZakazTemp.RecordCount > 0) or (High(FArrOplata) > 0);
  btnOk.Enabled := spZakazTemp.RecordCount > 0;
  aPrint.Enabled := spZakazTemp.RecordCount > 0;
  aPrintCur.Enabled := spZakazTemp.RecordCount > 0;

  btnNacenka.Enabled := spZakazTemp.RecordCount > 0;

  {
  //пришлось перенести это все в tvMainDataControllerSummaryAfterSummary
  //потому что здесь редактируется cxGrid и сумма после изменения в нем - не считается

  with tvMain.DataController.Summary do begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      edSumm.Value := FooterSummaryValues[AIndex]
    else
      edSumm.Value := 0;

    if UseCurrency then begin
      AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSummCurrency);
      if not VarIsNull(FooterSummaryValues[AIndex]) then
        edSummCurrency.Value := FooterSummaryValues[AIndex]
      else
        edSummCurrency.Value := 0;
    end;
  end;

  if High(FArrOplata) = 0 then
    edSummFact.Value := edSumm.Value
  else begin
    edSummDolg.Value := edSumm.Value - edSummFact.Value;
  end;}
end;

procedure TPrihodTovaraNForm.DisableControls;
begin
  aIns.Enabled := False;
  aUpd.Enabled := False;
  aDel.Enabled := False;
  aOplata.Enabled := False;
  aFindAndIns.Enabled := False;
  edDate.ENABLED := FALSE;
  edTime.ENABLED := FALSE;
  edOsnovanie.ENABLED := FALSE;
  edSummFact.ENABLED := FALSE;
  aSearchClient.ENABLED := FALSE;

  mNote.Enabled := FALSE;
  lePostavshik.ENABLED := FALSE;
  lePAYMENT_TYPE.ENABLED := FALSE;
  btnOk.Enabled := FALSE;
end;

procedure TPrihodTovaraNForm.GetData;
var p, i : integer;
  str, str1 : string;
  nonCashPayType, G_PAYMENT_TYPE, GClient : Int64;
begin
  try
    FIsGetDataNow  := true;

    // если возврат на основе продажи
    if FZakaz <> 0 then begin
      with spDoReturn do begin
        ParamByName('zakaz_').AsInt64 := FZakaz;
        ExecSpTr(spDoReturn);

        G_PAYMENT_TYPE := spDoReturn.ParamByName('G_PAYMENT_TYPE_').AsInt64;
        nonCashPayType := spDoReturn.ParamByName('G_NON_CASH_PAY_TYPE_').AsInt64;

        GClient := spDoReturn.ParamByName('G_CLIENT_').AsInt64;
        FPos_Pay_method := spDoReturn.ParamByName('POS_PAY_METHOD_').AsString;
        FPos_transaction_id := spDoReturn.ParamByName('POS_PAY_TRANSACTION_ID_').AsString;
      end;

      if FClientLoc <> 0 then
        lePostavshik.EditValue := FClientLoc;
    end;

    try
      spGetData.ParamByName('sklad_').AsInt64 := RecID;
      if not spGetData.Transaction.InTransaction then
        spGetData.Transaction.StartTransaction;

      if OpenMode = omInsertLike then
        spGetData.ParamByName('mode_').AsInteger := 1
      else
        spGetData.ParamByName('mode_').AsInteger := 0;

      ExecSP(spGetData);

      if spGetData.Transaction.InTransaction then
        spGetData.Transaction.CommitRetaining;
    except
      on E: EFIBError do begin
        if spGetData.Transaction.InTransaction then
          spGetData.Transaction.RollbackRetaining;
        DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TPrihodTovaraNForm.GetData)');
      end;
      on E: Exception do begin
        if spGetData.Transaction.InTransaction then
          spGetData.Transaction.RollbackRetaining;
        MessageDlg(E.Message + #13#10'(occured in TPrihodTovaraNForm.GetData)', mtError, [mbOk], 0);
      end;
    end;

    if OpenMode <> omInsert then BEGIN
      with spGetData do begin
        edDate.Date := ParamByName('DATE_RECEIPT_').AsDate;
        FRecOld.ZDate  := ParamByName('DATE_RECEIPT_').AsDate;
        edTIME.TIME    := ParamByName('TIME_RECEIPT_').AsTIME;
        FRecOld.ZTime  := ParamByName('TIME_RECEIPT_').AsTime;

        lePostavshik.EditValue := ParamByName('G_CLIENT_').AsInt64;
        FRecOld.Postavshik     := ParamByName('G_CLIENT_').AsInt64;
        FRecOld.PostavshikName := lePostavshik.Text;

        lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsInt64;

        if FIs_vozvrat = 1 then begin
          if spNonCashPayTypes.Active then
            leNonCashPayType.EditValue := spGetData.ParamByName('G_NONCASH_PAY_TYPE_').AsInt64;
        end;

        {FRecOld.GNonCashPayType := ParamByName('G_NONCASH_PAY_TYPE_').AsInt64;
        if FRecOld.GNonCashPayType = 0 then
          FRecOld.GNonCashPayTypeName := 'наличный'
        else
          FRecOld.GNonCashPayTypeName := leNonCashPayType.Text;}

        edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
        FRecOld.Osnovanie := ParamByName('OSNOVANIE_').AsString;

        mNote.Text := ParamByName('note_').AsString;
        FRecOld.Note := ParamByName('note_').AsString;

        Readlist;    //он тут стоит потому что ниже заполняется edSummFact.Value

        edSumm.Value := ParamByName('summ_').AsFloat;
        FRecOld.Summ := ParamByName('summ_').AsFloat;

        // по идее 0 - это Инкассация, но кто будет выбирать инкассацию при приходе
        leStatya.EditValue := ParamByName('G_PRIHOD_').AsInt64;
        FRecOld.Statya := ParamByName('G_PRIHOD_').AsInt64;
        FRecOld.StatyaName := leStatya.Text;

        edSummPrihod.Value := ParamByName('SUMM_PRIHOD_').AsFloat;
        FRecOld.StatyaSumm := ParamByName('SUMM_PRIHOD_').AsFloat;

        edSummFact.Value := ParamByName('summ_fact_').AsFloat;
        edSummDolg.Value := edSumm.Value - edSummFact.Value;
        FRecOld.SummFact := ParamByName('summ_fact_').AsFloat;

        edSummCurrency.Value := ParamByName('summ_currency_').AsFloat;
        FRecOld.SummCurrency := ParamByName('summ_currency_').AsFloat;

        cbIsExpected.Checked := ParamByName('is_expected_').AsInteger = 1;
        FRecOld.NotAddMinusOstatok := cbIsExpected.Checked;

        // ЗАПОЛНЯЮ МАССИВ ПЛАТЕЖЕЙ
        i := 0;
        Str := ParamByName('PAYMENTS_').AsString;
        while Length(Str) > 1 do begin
          SetLength(FArrOplata, High(FArrOplata) + 2);
          p := pos('-', Str);
          str1 := Copy(Str, 1, p-1);
          if str1 <> '' then
            FArrOplata[i].Id := StrToInt64(str1);

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
            FArrOplata[i].Payment := StrToInt64(str1);

          Delete(str, 1, p);
          i := i + 1;
        end;
        //переношу все в массив для хранения старых значений
        FArrOplataOld := Copy(FArrOplata, 0, MaxInt);
      end;
    end
    else if OpenMode in [omInsert] then begin
      if FIs_vozvrat = 1 then begin

        if G_PAYMENT_TYPE <> 0 then
          lePAYMENT_TYPE.EditValue := G_PAYMENT_TYPE;

        if spNonCashPayTypes.Active then
          leNonCashPayType.EditValue := nonCashPayType;

        if GClient <> 0 then
          lePostavshik.EditValue := GClient;

        if FZakaz <> 0 then
          mNote.Text := FZakazNote;
      end;
    end;

    if High(FArrOplata) = -1 then begin
      SetLength(FArrOplata, 1);
      FArrOplata[0].Date := edDate.Date;
      FArrOplata[0].Payment := 1;
    end;
    EnableSummFact;  // выключаю edSummFact, если есть больше одного платежа

    if (OpenMode = omUpdate) AND (
    ((HaveRightUpdPrihod = False) and (FIs_vozvrat = 0)) or
    ((HaveRightUpdReturnClient = False) and (FIs_vozvrat = 1))
    ) then begin
      MessageDlg('У Вас нет прав на редактирование накладных"!', mtInformation, [mbOk], 0);
      DisableControls;
      Exit;
    end;

    //ПРОВЕРЯЮ ЕСТЬ ЛИ ПРАВО НА РЕДАКТИРОВАНИЕ НАКЛАДНОЙ ЗА ПРОШЛЫЕ ДАТЫ
    //НЕВАЖНО КАКАЯ ДАТА У НАКЛАДНОЙ, МНЕ ПРОЦЕДУРА УЖЕ ВОЗВРАЩАЕТ 1, ЕСЛИ НАКЛАДНАЯ ЗА ТЕКУЩУЮ ДАТУ
    IF (spGetData.ParamByName('HaveRight_').AsInteger = 0) AND (OpenMode = omUpdate) THEN BEGIN
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

    if (OpenMode = omUpdate) and (SyncCurCompId = 0) then begin
      spUpdLock.ParamByName('id_').AsInt64 := RecId;
      spUpdLock.ParamByName('TABLE_NAME_').AsString := 'sklad_parent';

      if not spUpdLock.Transaction.InTransaction then   //ТРАНЗАКЦИЯ ЗАКОММИТИТЬСЯ, ЕСЛИ КЛИЕНТ НАЖМЕТ КНОПКУ ОК, ИЛИ ОТРОЛЛБАЧИТЬСЯ, ЕСЛИ БУДЕТ ОШИБКА ИЛИ НАЖМУТ КНОПКУ ОТМЕНА
        spUpdLock.Transaction.StartTransaction;
      if not ExecSP(spUpdLock) then begin
        DisableControls;
        EXIT;
      end;
    end;

    //Readlist;

    // заполняю старые значения по оплатам и товарам
    if (OpenMode = omUpdate) then begin
      mdOldTovar.CopyFromDataSet(spZakazTemp);
    end;

    Readlist;

  finally
    FIsGetDataNow := False;
  end;
end;

procedure TPrihodTovaraNForm.FormShow(Sender: TObject);
var OnChangeVal : TNotifyEvent;
begin
  // на некоторых английских виндоусах коряво прописываются кнопочки, поэтому тут на русском пропишу
  {tsCommon.Caption := 'Детали';
  tsRashod.Caption := 'Сопутствующая статья расхода';
  aIns.Caption := 'Добавить товар';
  aUpd.Caption := 'Изменить';
  aDel.Caption := 'Удалить';
  clmMainPRODUCT_NAME.Caption := 'Товар';
  grProductAMOUNT.Caption := 'Кол-во';
  grProductPRICE.Caption := 'Цена';
  grProductSUMM.Caption := 'Сумма';}
  tvMain.RestoreFromIniFile('Settings_grid.ini', False, False, [], Self.Name + '-' + tvMain.Name);
  FRoundVal := ReadIntSettingsIni('PrihodTovaraNaklad', 'NacenkaRound', 1);
  aInsNewTovar.Visible := False;

  // ОЧИЩАЮ И ВРЕМЕННУЮ ТАБЛИЧКУ
  ClearTempTable;

  if FIs_vozvrat in [0, 1] then begin
    if FIs_vozvrat = 1 then begin
      Caption := 'Возврат товара';
      Label7.Caption := 'Дата возврата';
      Label9.Caption := 'Клиент';
      spPostavshik.ParamByName('IS_SUPPLIER_').AsInteger := 0;  // ПРИ ВОЗВРАТЕ ВЫТАСКИВАЮ КЛИЕНТОВ
      tsExpected.TabVisible := False;

      btnNacenka.visible := False;
      clmMARGIN_PERCENT.Destroy;
      clmMainSALE_PRICE.Destroy;

      aSearchClient.Visible := True;
      lePostavshik.Properties.ListFieldNames := 'NAME_PHONE_';
    end else begin
      spPostavshik.ParamByName('IS_SUPPLIER_').AsInteger := 1;  // ПРИ ОБЫЧНОМ ПРИХОДЕ ВЫТАСКИВАЮ ПОСТАВЩИКОВ
      lePostavshik.Width := edOsnovanie.Width;
      lePostavshik.Properties.ListFieldNames := 'NAME';
      aInsNewTovar.Visible := True;
    end;

    spPostavshik.Filtered := True;
  end else begin
    spPostavshik.ParamByName('G_CLIENT_PARENT_').AsInt64 := -1000;
    aOplata.Enabled := False;
    aOplata.Visible := False;
  end;

  //spPostavshik.ParamByName('IS_SUPPLIER_').AsInteger := 1;
  OpenSp(spPostavshik, False);
  if spPostavshik.Locate('by_default', 1, []) then
    lePostavshik.EditValue := spPostavshik.FieldByName('g_client').AsLargeInt;
  spReadStatya.ParamByName('action_').AsInteger := 1;
  OpenSp(spReadStatya, False);

  OnChangeVal := lePAYMENT_TYPE.Properties.OnChange;
  lePAYMENT_TYPE.Properties.OnChange := nil;
  OpenSp(spPaymentType, False);
  lePAYMENT_TYPE.EditValue := 1;   // по умолчанию поставлю наличный расчет
  lePAYMENT_TYPE.Properties.OnChange := OnChangeVal;

  if Screen.PixelsPerInch = 120 then
    lbStatya.Font.Size := 9;

  lbStatya.Width := ScaleDimension(450);

  IF OpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
    btnOk.Enabled := False;
    aPrint.Enabled := False;
    aPrintCur.Enabled := False;
  end else if OpenMode = omView then
    DisableControls;

  inherited;

  if (FIs_Vozvrat <> 0) or (UseCurrency = False) then begin
    lbSummCurrency.visible := False;
    shpCurrency.Visible := False;
    shpCurrency1.visible := False;
    edSummCurrency.visible := False;
    clmMainSummCurrency.Destroy;
  end;

  if (AppName = 'shopuchet') or (AppName = 'starshop') then
    clmMainG_UNIT_NAME.Destroy
  else begin
    tsExpected.TabVisible := False;
    clmMARGIN_PERCENT.Destroy;
    clmMainSALE_PRICE.Destroy;
    btnNacenka.Visible := False;
    btnNacenka.Enabled := False;
    tvMain.OptionsSelection.CellSelect := False;

    if AppName = 'serviceuchet' then begin
      aOplata.Enabled := False;
      btnOplata.Visible := False;
    end;
  end;

  FedDate := 0;
  FedTime := 0;

  lbSklad.Visible := False;
  shpSklad.Visible := False;
  shpSklad1.Visible := False;
  leSklad.Visible := False;

  if (High(SkladArr) > 0) and (OpenMode in [omInsert, omInsertLike]) and (FIs_Vozvrat <> 1) then begin
    lbSklad.Visible := True;
    shpSklad.Visible := True;
    shpSklad1.Visible := True;
    leSklad.Visible := True;
  end;

  if not ((FIs_Vozvrat = 0) and (Config = 4)) then begin
    clmVES_GRAMM.Destroy;
    clmVES_GRAMM_PRICE.Destroy;
  end
  else
    clmMainPRICE.Caption := 'Цена за шт.';

  cbFiscalMode.Visible := PrintOnFr and (FIs_vozvrat = 1);
  cbFiscalMode.Checked := (cbFiscalMode.Visible) and (ReadIntSettingsIni( 'SaleMode', 'FiscalMode', 1) = 1);

  OpenSp(spReadSklad, False);
  leSklad.EditValue := CurSklad;

  SetNonCashPayTypeVisible;

  if Screen.Height <= 600 then begin
    Height := ScaleDimension(560);
    Panel1.Height := ScaleDimension(490);
    //pcMain.Height := ScaleDimension(270);
    btHelp.Top := ScaleDimension(499);
    cbFiscalMode.Top := ScaleDimension(500);
    cxButton2.Top := ScaleDimension(499);
    btnOk.Top := ScaleDimension(499);
    btnCancel.Top := ScaleDimension(499);
  end;
end;

procedure TPrihodTovaraNForm.aInsExecute(Sender: TObject);
begin
  ZakupkaTovaraForm := TZakupkaTovaraForm.Create(Self);
  try
    ZakupkaTovaraForm.OpenMode := omInsert;
    ZakupkaTovaraForm.Is_vozvrat := FIs_vozvrat;
    ZakupkaTovaraForm.ArrPrice := FArrPrice;
    if ZakupkaTovaraForm.ShowModal = mrOK then
      OpenSP(spZakazTemp, True);

    FArrPrice := ZakupkaTovaraForm.ArrPrice;
    FTovarWasChanged := ZakupkaTovaraForm.TovarInserted;
  finally
    ZakupkaTovaraForm.Free;
  end;
end;

procedure TPrihodTovaraNForm.aInsNewTovarExecute(Sender: TObject);
var PriceListUnForm : TPriceListUnForm;
  find: Boolean;
begin
  PriceListUnForm := TPriceListUnForm.Create(Self);
  try
    PriceListUnForm.OpenMode := omInsert;
    PriceListUnForm.Id_Category := -1;
    find := False;
    if PriceListUnForm.ShowModal = mrOk then begin
      spFindAndInsProduct.ParamByName('BARCODE_').AsString := PriceListUnForm.edBarcode.Text;
      spFindAndInsProduct.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;

      find := ExecSPTR(spFindAndInsProduct);
      insUpd := True;
    end;
  finally
    FreeAndNil(PriceListUnForm);
  end;

  Readlist;
  if find then
  begin
    spZakazTemp.Locate('sklad', spFindAndInsProduct.ParamByName('SKLAD_').AsInt64, []);
    if tvMain.Controller.FocusedRow <> Nil then begin
      if tvMain.Controller.SelectedRowCount > 0 then
        tvMain.Controller.SelectedRows[0].Selected := False;
      tvMain.Controller.FocusedRow.Selected := True;
    end;
  end;
end;

procedure TPrihodTovaraNForm.aNacenkaExecute(Sender: TObject);
var NacenkaForm: TNacenkaForm;
begin
  NacenkaForm := TNacenkaForm.Create(Self);
  try
    if NacenkaForm.ShowModal = mrOk then begin
      //FChargeProc := NacenkaForm.edNacenka.value;
      DoNacenka(NacenkaForm.edNacenka.value, FRoundVal);
    end;
  finally
    NacenkaForm.Free;
  end;
end;

procedure TPrihodTovaraNForm.DoNacenka(ChargeProc: Double = -1; RoundMode: integer = 0);
begin
  spUpdateTmpAll.ParamByName('CHARGE_ROZN_PROC_').AsFloat := ChargeProc;
  spUpdateTmpAll.ParamByName('ROUND_MODE_').AsInteger := RoundMode;
  spUpdateTmpAll.ParamByName('MODE_').AsInteger := 0;
  if ExecSPTR(spUpdateTmpAll) then begin
    Readlist;
    mNote.ModifiedAfterEnter := true;
  end;
end;

procedure TPrihodTovaraNForm.aUpdExecute(Sender: TObject);
begin
  if tvMain.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('Выберите запись для изменения!', mtWarning, [mbOK], 0);
    Exit;
  end;

  UpdZakupkaTovaraForm := TUpdZakupkaTovaraForm.Create(Self);
  with UpdZakupkaTovaraForm do begin
    OpenMode := omUpdate;
    RecID := spZakazTemp.FieldByName('sklad').AsLargeInt;
    IsVozvratUpd := FIs_vozvrat;
    if (spZakazTemp.FieldByName('is_marked').AsInteger = 1) and (FIs_vozvrat = 1) then begin
      UpdZakupkaTovaraForm.MyCurrencyFrameForm.edAmount.Enabled := False;
      UpdZakupkaTovaraForm.MyCurrencyFrameForm.Enabled := False;
    end;
    try
      if UpdZakupkaTovaraForm.ShowModal = mrOK then BEGIN
        Readlist;
        edOsnovanie.ModifiedAfterEnter := True;
        FTovarWasChanged := True;
      end;
    finally
      UpdZakupkaTovaraForm.Free;
    end;
  end;
end;

procedure TPrihodTovaraNForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  tvMain.Controller.Customization := True;
end;

procedure TPrihodTovaraNForm.aDelExecute(Sender: TObject);
var ALength, i, j : integer;
  Sklad : Int64;
begin
  if tvMain.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('Выберите запись для удаления!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if MessageDlg(Format('Удалить приход товара "%s" ?',
    [spZakazTemp.FieldByName('PRODUCT_NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Sklad := spZakazTemp.FieldByName('SKLAD').AsLargeInt;
  spDel.ParamByName('SKLAD_').AsInt64 := Sklad;
  spDel.ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;

  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  if ExecSP(spDel) then BEGIN
    if spDel.Transaction.InTransaction then
      spDel.Transaction.Commit;
    Readlist;
    edOsnovanie.ModifiedAfterEnter := TRUE;
    FTovarWasChanged := True;

    // удалю из массива по изменению цен тоже, если массив не пустой конечно
    // вначале нахожу индекс элемента, который мне нужно удалить, для этого придется идти перебором до того SKLAD, который удаляется, а потом на его место сдвинуть все элементы
    ALength := Length(FArrPrice);
    if ALength > 0 then begin
      for i := 0 to ALength - 1 do
        if FArrPrice[i].Id = Sklad then begin
          for j := i + 1 to ALength - 1 do
            FArrPrice[j-1] := FArrPrice[j];
          SetLength(FArrPrice, ALength - 1);
          break;
        end;
    end;
  END;
end;

procedure TPrihodTovaraNForm.aFindAndInsExecute(Sender: TObject);
var
  ErrCode: Integer;
  ErrMsg : String;
  PriceListUnForm: TPriceListUnForm;
  MarkCode : String;
begin
  // все кроме возвратов
  if FIs_vozvrat <> 1 then begin
    spFindAndInsProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
    spFindAndInsProduct.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
    spFindAndInsProduct.ParamByName('IS_VOZVRAT_').AsInteger := FIs_vozvrat;

    try
      with spFindAndInsProduct do begin
        if not Transaction.InTransaction then
          Transaction.StartTransaction;

        ExecProc;

        if FieldIndex['ERR_CODE'] >= 0 then begin
          ErrCode := ParamByName('ERR_CODE').AsInteger;
          if (ErrCode <> 0) then begin
            if spFindAndInsProduct.Transaction.InTransaction then
              spFindAndInsProduct.Transaction.Rollback;

            ErrMsg := ParamByName('ERR_MSG').AsString;

            // если ошибка "Штрихкод не найден", то вывожу окно для создания товара
            if Pos('не найден', ErrMsg) = 0 then begin
              DBErrorHandler(ErrCode, ErrMsg);
              Exit;
            end
            else begin
              PriceListUnForm := TPriceListUnForm.Create(Self);
              try
                PriceListUnForm.BARCODE := KeysBuffer;
                PriceListUnForm.OpenMode := omInsert;
                PriceListUnForm.Id_Category := -1;

                if PriceListUnForm.ShowModal = mrOk then begin
                  spFindAndInsProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
                  spFindAndInsProduct.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;

                  ExecSPTR(spFindAndInsProduct);
                end;
              finally
                PriceListUnForm.Free;
              end;
            end;
          end;
        end;

        if Transaction.InTransaction then
          Transaction.Commit;
      end;

      Readlist;
      spZakazTemp.Locate('sklad', spFindAndInsProduct.ParamByName('SKLAD_').AsInt64, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    except
      on E: Exception do
        MessageDlg(E.Message + #13#10'(occured in TPrihodTovaraNForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
    end;
  end
  // только возвраты
  else begin
    spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;

    try
      IF ExecSPTR(spFindProduct) THEN begin
        if spFindProduct.ParamByName('is_marked_').AsInteger <> 0 then begin
          SaleMarkCodeInputForm := TSaleMarkCodeInputForm.Create(Self);
          with SaleMarkCodeInputForm do begin
            try
              if (ShowModal = mrOk) and (length(edMarkCode.Text) > 0) then
                MarkCode := edMarkCode.Text

              else
                Exit;
            finally
              Free;
            end;
          end;
        end;

        with spInsByScaner do begin
          ParamByName('G_PRODUCT_').AsInt64 := spFindProduct.ParamByName('G_PRODUCT_').AsInt64;
          ParamByName('PRICE_').AsFloat := spFindProduct.ParamByName('price_').AsFloat;
          ParamByName('AMOUNT_').AsFloat := 1;
          ParamByName('SUMM_').AsFloat := spFindProduct.ParamByName('price_').AsFloat;
          ParamByName('PRICE_ROZN_').AsFloat := spFindProduct.ParamByName('price_').AsFloat;
          ParamByName('CHANGE_SALE_PRICE_').AsFloat := 0;
          ParamByName('mark_code_').AsString := MarkCode;
        end;

        if ExecSPTR(spInsByScaner) then begin
          Readlist;
          spZakazTemp.Locate('sklad', spInsByScaner.ParamByName('SKLAD_').AsInt64, []);
          if tvMain.Controller.FocusedRow <> Nil then begin
            if tvMain.Controller.SelectedRowCount > 0 then
              tvMain.Controller.SelectedRows[0].Selected := False;
            tvMain.Controller.FocusedRow.Selected := True;
          end;
        end;
      end;
    except
      on E: Exception do
        MessageDlg(E.Message + #13#10'(occured in TSaleModeForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
    end;
  end;

  spFindAndInsProduct.ParamByName('BARCODE_').AsString := '';
  spFindProduct.ParamByName('BARCODE_').AsString := '';
end;

procedure TPrihodTovaraNForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var StrArr : string;
  i, NDS : integer;
  SummCash, SummNonCash, PosRefundSumm, PersSkidka, Skidka, NDSSUM : Double;
  str : string;
  cutMarkCode : integer;
  PosTerminalProcessForm: TPosTerminalProcessForm;
  SuccessLoc : Boolean;
  TransID: string;
  TOpl: Integer;
begin
  FIsClosingNow := True;
  PosRefundSumm := 0;

  TRY
    if ModalResult <> mrOk THEN
    BEGIN
      if spZakazTemp.RecordCount > 0 then
      begin
        if MessageDlg('Вы хотите закрыть окно, не сохранив изменения.'#13#10'Вы уверены, что хотите продолжить?',
        mtWarning, [mbYes, mbNo], 0) = mrNo then
        begin
          CanClose := False;
          Exit;
        end;
      end;

      ClearTempTable;      // ПО НАЖАТИЮ НА КНОПКУ ОТМЕНА ТОЖЕ ОЧИЩАЮ ВРЕМЯНКУ
      if spUpdLock.Transaction.InTransaction then
        spUpdLock.Transaction.Commit;  //а также снимаю блокировку с записи
      Exit;
    END;

    CanClose := False;

    if (OpenMode = omUpdate) and (not CheckRequizChanged(Self)) and (not insUpd) then
    begin
      {Возможно, OK просто нажата после утверждения или для закрытия окна. Изменений не было}
      FSuccess := True;
      CanClose := True;
      Exit;
    end;

    if OpenMode in [omInsert, omInsertLike, omInsertChild] then
      FSuccess := InsData
    else if OpenMode = omUpdate then
      FSuccess := UpdData;

    IF FSuccess THEN
    BEGIN   // ОЧИЩАЮИ ВРЕМЕННУЮ ТАБЛИЧКУ ТОЛЬКО ЕСЛИ БЫЛО УСПЕШНОЕ СОХРАНЕНИЕ
      if (FIs_vozvrat = 1) and (OpenMode in [omInsert, omInsertLike]) then
      begin
        //=================================================
        // ЗАПУСКАЮ ОБРАБОТКУ ТЕРМИНАЛОВ (ПОКА ТОЛЬКО КАСПИ)
        // РЕШИЛ ТУТ ДЕЛАТЬ ДО СОХРАНЕНИЯ
        //=================================================
        if (UsePosTerminal =  1) and (lePAYMENT_TYPE.EditValue = 2) and
        {(leNonCashPayType.EditValue = 0PosTerminalNonCashPayType) and} (FPos_transaction_id <> '') and
        (FPos_Pay_method <> '') then
        begin

          IF (High(FArrOplata) > 0) then
          begin
            for i := 0 to High(FArrOplata) do
            begin
              if FArrOplata[i].Payment = 2 then
                PosRefundSumm := PosRefundSumm + FArrOplata[i].Summ;
            end;
          end
          else
            PosRefundSumm := edSummFact.Value;

          spNonCashPayTypes.Locate('G_NONCASH_PAY_TYPE', leNonCashPayType.EditValue, []);

          for i := 0 to High(PosTerminalArr) do begin
            if PosTerminalArr[i].Model = spNonCashPayTypes.FieldByName('POS_TERMINAL_TYPE').AsInteger then
            begin
              PosTerminalProcessForm := TPosTerminalProcessForm.Create(Self);
              try
                PosTerminalProcessForm.IsRefund := True;
                PosTerminalProcessForm.Url := PosTerminalArr[i].IP {PosTerminalIp};
                PosTerminalProcessForm.Amount := MathRound(PosRefundSumm, 0);
                PosTerminalProcessForm.Method := FPos_Pay_method;
                PosTerminalProcessForm.TransactionID := FPos_transaction_id;
                PosTerminalProcessForm.TypePosTerminal := PosTerminalArr[i].Model;

                if PosTerminalProcessForm.ShowModal <> mrOk then
                begin
                  if PosTerminalProcessForm.StayOnParentForm then
                  begin
                    CanClose := False;
                    Exit;
                  end;
                end;
                //if PosTerminalProcessForm.Success = False then
                //  Exit;

                // ПОКА ЗАПИСЫВАТЬ НЕ БУДУ TRANSACTION_ID
                // теперь надо записать метод и транзакцию в продажу
                {if SuccessLoc then begin
                  // MethodLoc, TransactionIDLoc
                  MainDm.scriptUniversal.Transaction := tranWrite;
                  MainDm.scriptUniversal.Script.Text := 'UPDATE ZAKAZ Z ' +
                                                        ' SET POS_PAY_METHOD = ' + PosTerminalProcessForm.Method +
                                                        ' , POS_PAY_TRANSACTION_ID = ' + PosTerminalProcessForm.TransactionID +
                                                        ' WHERE ZAKAZ = ' + IntToStr(LastCheck);

                  res := ExecScript(MainDm.scriptUniversal, false);
                  if res <> '' then begin
                    MessageDlg(res, mtError, [mbOk], 0);
                    Exit;
                  end;
                end;}
              finally
                FreeAndNil(PosTerminalProcessForm);
              end;
            end;
          end;
        end;

        // если включен фискальник, то надо отправить данные на него
        // отправлять буду ТОЛЬКО, если при создании документа, вся сумма сразу оплачена
        // нефиг там всякими дробными платежами путать
        // драйвер Атол
        IF (cbFiscalMode.Checked) THEN 
		    BEGIN
          if (CheckPrintDeviceFr = 1) and Assigned(KKMPrinter) then 
		      begin
            KKMPrinter.NewDocument;
            with spZakazTemp do
            begin
              spZakazTemp.First;
              while not spZakazTemp.Eof do begin
                KKMPrinter.ReturnGoods(FieldByName('PRODUCT_NAME').AsString, FieldByName('AMOUNT').AsFloat, FieldByName('price').AsFloat);
                Next;
              end;
            end;

            SummCash := 0;
            SummNonCash := 0;
            // подсчитываю сумму наличными и безналичными
            for i := 0 to High(FArrOplata) do
            begin
              if FArrOplata[i].Payment = 1 then
                SummCash := SummCash + FArrOplata[i].Summ
              else
                SummNonCash := SummNonCash + FArrOplata[i].Summ;
            end;

            str := KKMPrinter.CloseCheckSumm(SummCash, SummNonCash, edSumm.Value, 0,  '');
            if str <> '' then
            begin
              MessageDlg(str + ' Чек не отправлен в ОФД!', mtWarning, [mbOk], 0);
              Exit;
            end;
          end
          // драйвер Штрих
          else
          if (CheckPrintDeviceFr in [2,3,4]) and Assigned(KKMPrinterStrih) then
          begin
            if CheckPrintDeviceFr in [2,3] then
              cutMarkCode := 1
            else
              cutMarkCode := 0;
            if NdsValue>0 then
              NDS := 1
            else
              NDS := 0;
            KKMPrinterStrih.CancelCheckIf;
            with spZakazTemp do
            begin
              spZakazTemp.First;
              while not spZakazTemp.Eof do
				      begin
                KKMPrinterStrih.ReturnGoods(FieldByName('PRODUCT_NAME').AsString,
                  FieldByName('AMOUNT').AsFloat,
                  FieldByName('price').AsFloat,
                  NDS, 0,
                  FieldByName('MARK_CODE').AsString,
                  cutMarkCode);
				        spZakazTemp.Next;
              end;
            end;

            SummCash := 0;
            SummNonCash := 0;
            // подсчитываю сумму наличными и безналичными
            for i := 0 to High(FArrOplata) do begin
              if FArrOplata[i].Payment = 1 then
                SummCash := SummCash + FArrOplata[i].Summ
              else
                SummNonCash := SummNonCash + FArrOplata[i].Summ;
            end;

            str := KKMPrinterStrih.CloseCheckSumm(SummCash, SummNonCash, edSumm.Value, 0, 0, 0, 0, '', '');
            if str <> '' then begin
              MessageDlg(str + ' Чек не отправлен в ОФД!', mtWarning, [mbOk], 0);
              Exit;
            end;
          end
          else
          begin
            if (CheckPrintDeviceFr = 5) and Assigned(KKMReKassa) then
            begin
              KKMReKassa.JsonItems := '';
              if not spZakazTemp.Active then
                spZakazTemp.Open;
              with spZakazTemp do begin
                spZakazTemp.First;
                //, Skidka
                while not spZakazTemp.Eof do
                begin
                  if FieldByName('PRICE_CURRENCY').AsFloat <> 0 then
                  begin
                    PersSkidka := (FieldByName('price').AsFloat-FieldByName('PRICE_CURRENCY').AsFloat)/FieldByName('price').AsFloat*100;
                    Skidka := FieldByName('price').AsFloat-FieldByName('PRICE_CURRENCY').AsFloat;
                  end
                  else
                  begin
                    PersSkidka := 0;
                    Skidka := 0;
                  end;
                  if NdsValue>0 then
                  begin
                    NDSSUM := RoundTo(FieldByName('SUMM').AsFloat * NdsValue / (100 + NdsValue) , -2);
                  end
                  else
                    NDSSUM := 0;
                  KKMReKassa.Itemsadd(FieldByName('PRODUCT_NAME').AsWideString,
                    FieldByName('price').AsFloat,
                    FieldByName('SUMM').AsFloat,
                    FieldByName('AMOUNT').AsFloat,
                    PersSkidka, Skidka, NdsValue, NDSSUM);
                  Next;
                end;
              end;

              SummCash := 0;
              SummNonCash := 0;
              // подсчитываю сумму наличными и безналичными
              if lePAYMENT_TYPE.EditValue = 1 then
                SummCash := edSumm.Value
              else
                SummNonCash := edSumm.Value;



              str := ReturnSellReKassa(SummCash, SummNonCash, '');
              if str <> '' then begin
                MessageDlg(str + ' Чек не отправлен в ОФД!', mtWarning, [mbOk], 0);
                Exit;
              end;
            end
            else
            begin
              if (CheckPrintDeviceFr = 6) and Assigned(KKMTIS) then
              begin
                KKMTIS.JsonItems := '';
                if not spZakazTemp.Active then
                  spZakazTemp.Open;
                with spZakazTemp do begin
                  spZakazTemp.First;

                  while not spZakazTemp.Eof do
                  begin
                    if FieldByName('PRICE_CURRENCY').AsFloat <> 0 then
                    begin
                      Skidka := FieldByName('price').AsFloat-FieldByName('PRICE_CURRENCY').AsFloat;
                    end
                    else
                    begin
                      Skidka := 0;
                    end;
                    if NdsValue>0 then
                    begin
                      NDSSUM := RoundTo(FieldByName('SUMM').AsFloat * NdsValue / (100 + NdsValue) , -2);
                    end
                    else
                      NDSSUM := 0;
                    KKMTIS.Itemsadd(FieldByName('PRODUCT_NAME').AsWideString,
                      FieldByName('price').AsFloat,
                      FieldByName('SUMM').AsFloat,
                      FieldByName('AMOUNT').AsFloat,
                      Skidka, NdsValue, NDSSUM, FieldByName('MARK_CODE').AsWideString);
                    Next;
                  end;
                end;

                SummCash := 0;
                SummNonCash := 0;
                // подсчитываю сумму наличными и безналичными
                if lePAYMENT_TYPE.EditValue = 1 then
                  SummCash := edSumm.Value
                else
                  SummNonCash := edSumm.Value;
                try
                  SQLTransaction.Close;
                  SQLTransaction.SQLs.SelectSQL.Clear;
                  SQLTransaction.SQLs.SelectSQL.Add('SELECT POS_PAY_METHOD, POS_PAY_TRANSACTION_ID FROM ZAKAZ WHERE ZAKAZ='+IntToStr(Zakaz)+
                  ' AND POS_TERMINAL='+IntToStr(Terminal));
                  SQLTransaction.Open;
                  if SQLTransaction.FieldByName('POS_PAY_TRANSACTION_ID').IsNull then
                  begin
                    TransID := '';
                    TOpl := 0;
                  end
                  else
                  begin
                    TransID := SQLTransaction.FieldByName('POS_PAY_TRANSACTION_ID').AsWideString;
                    TOpl := SQLTransaction.FieldByName('POS_PAY_METHOD').AsInteger;
                  end;
                except
                end;
                str := ReturnSellTIS(SummCash, SummNonCash, '', TransID, RecId, NdsValue, NDSSUM, TOpl, '');
                if str <> '' then begin
                  MessageDlg(str + #13#10 + ' Чек не отправлен в ОФД!', mtWarning, [mbOk], 0);
                  Exit;
                end;
              end;
            end;
          end;

        END;

      end;
      ClearTempTable;
      SaveSettingsIni('PrihodTovaraNaklad', 'NacenkaRound', FRoundVal ,'');
      SaveSettingsIni('SaleMode', 'FiscalMode', Integer(cbFiscalMode.Checked), '');

      // при успешном выполнении обновляю цены товарам
      if High(FArrPrice) >= 0 then begin
        for i := 0 to High(FArrPrice) do
          StrArr := StrArr + IntToStr(FArrPrice[i].ProductId) + '-' + FloatToStr(FArrPrice[i].Price) + '+' + FloatToStr(FArrPrice[i].PriceOpt) + '~';
        StrArr := StringReplace(StrArr, ',', '.', [rfReplaceAll, rfIgnoreCase]);   //заменяю на всякий случай запятые на точки
        spUpdPrices.ParamByName('ARR_').AsString := StrArr;
        if not ExecSPTR(spUpdPrices) then
          Exit;
      end;
    END;

    CanClose := FSuccess;
  FINALLY
    FIsClosingNow := False;
  END;
end;

function TPrihodTovaraNForm.InsData: Boolean;
begin
  Result := False;
  spIns.ParamByName('Is_VOZVRAT_').AsInteger := FIs_vozvrat;
  try
    if CallSP(spIns) then
    begin
      RecId := spIns.ParamByName('sklad_').AsInt64;
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

procedure TPrihodTovaraNForm.InsTmpTovar;
begin

end;

function TPrihodTovaraNForm.UpdData: Boolean;
begin
  Result := False;
  try
    spUpd.ParamByName('SKLAD_PARENT_').AsInt64 := RecId;

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

procedure TPrihodTovaraNForm.grProductDblClick(Sender: TObject);
begin
  aUpd.Execute;
end;

procedure TPrihodTovaraNForm.lePostavshikPropertiesChange(Sender: TObject);
begin
  // ставлю автоматом наличный или безналичный расчет
  if spPostavshik.FieldByName('is_beznal').AsInteger = 1 then
    lePAYMENT_TYPE.EditValue := 2
  else
    lePAYMENT_TYPE.EditValue := 1;

end;

procedure TPrihodTovaraNForm.N7Click(Sender: TObject);
begin
  PrintEtickets(false, (Sender as TMenuItem).Tag);
end;

procedure TPrihodTovaraNForm.ClearTempTable;
begin
  spDel.Params[0].Clear;
  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  ExecSP(spDel);

  if spDel.Transaction.InTransaction then
    spDel.Transaction.Commit;
end;

procedure TPrihodTovaraNForm.sbEqualSummClick(Sender: TObject);
begin
  edSummFact.Value := edSumm.Value;
  edSummFact.ModifiedAfterEnter := True;
end;

procedure TPrihodTovaraNForm.edSummFactPropertiesChange(Sender: TObject);
begin
  edSummFact.Text := StringReplace(edSummFact.Text, ',', '.', [rfReplaceAll]);

  edSummDolg.Value := edSumm.Value - edSummFact.Value;
  if High(FArrOplata) = 0 then
    FArrOplata[0].Summ := edSummFact.Value;



  {if High(FArrOplata) = 0 then
    FArrOplata[0].Summ := Min(edSummFact.Value, edSumm.Value);}
end;

procedure TPrihodTovaraNForm.edTimePropertiesChange(Sender: TObject);
begin
  FedTime := edTime.Time;
end;

procedure TPrihodTovaraNForm.sbClearClick(Sender: TObject);
begin
  leStatya.EditValue := null;
end;

procedure TPrihodTovaraNForm.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  if FIs_vozvrat = 0 then
    HELPC := 17
  else if FIs_vozvrat = 1 then
    HELPC := 20;

  Application.HelpContext(HELPC);
end;

procedure TPrihodTovaraNForm.FormCreate(Sender: TObject);
begin
  insUpd := False;
  if ReadIntSettingsIni('PrihodTovaraNaklad', 'WindowState', 0) = 1 then
    WindowState := wsMaximized;

  FPopupPostavshikForm    := TPopupClientMultListForm.Create(Self);
end;

function TPrihodTovaraNForm.FillLog: string;
var logTovar, logOplata : string;
  i, j, mode : integer;
  str, str1: string;
  paymentFound : boolean;
begin
  Result := '';
  Screen.Cursor := crHourGlass;
  
  try
    if FIs_Vozvrat = 4 then begin
      str  := '';
      mode := 9;
    end else begin
      str := lePostavshik.Text;
      case FIs_Vozvrat of
        0 : mode := 4;
        1 : mode := 5;
        2 : mode := 8;
      end;
    end;

    if OpenMode in [omInsert, omInsertLike] then begin
      Result := FillInsWayBill(mode, edDate.Date, edTime.Time, str, edSumm.Value,
        edSummFact.Value, 0, 0, spZakazTemp);

      if FIs_Vozvrat <> 3 then begin
        Result := Result + CRLF + 'Платежи.' + CRLF;
        for I := 0 to High(FArrOplata) do begin
          if FArrOplata[i].Payment = 1 then
            str := '"наличный"'
          else
            str := '"безналичный"';

          Result := Result + '-' + str + ', дата "' + DateToStr(FArrOplata[i].Date) + '", сумма "' + FloatToStr(FArrOplata[i].Summ) + '".' + CRLF;
        end;
      end;

    //сравниваю старую и новую запись
    end else if OpenMode = omUpdate then begin
      if FTovarWasChanged then
        mdNewTovar.CopyFromDataSet(spZakazTemp);

      Result := FillUpdWayBill(mode, FRecOld, edDate.Date, edTime.Time, edOsnovanie.Text, lePostavshik.Text, mNote.Text, '',
        edSumm.Value, edSummFact.Value, 0, 0, edSummPrihod.Value,
        false, false, cbIsExpected.Checked,
        lePostavshik.EditValue, leStatya.EditValue, 0,
        cbIsExpected.Caption, leStatya.Text, '',
        mdNewTovar, mdOldTovar);

      if FIs_Vozvrat <> 3 then begin
        for I := 0 to High(FArrOplataOld) do begin
          paymentFound := false;
          if FArrOplataOld[i].Payment = 1 then
            str := 'наличный'
          else
            str := 'безналичный';

          for j := 0 to High(FArrOplata) do begin
              if FArrOplataOld[i].Id = FArrOplata[j].Id then begin
                  paymentFound := true;
                  if (FArrOplataOld[i].Payment <> FArrOplata[j].Payment) or
                  (FArrOplataOld[i].Date <> FArrOplata[j].Date) or
                  (FArrOplataOld[i].Summ <> FArrOplata[j].Summ) then begin

                    logOplata := logOplata + 'Изменен "' + str +
                      '" платеж от "' + DateToStr(FArrOplataOld[i].Date) + '" на сумму "' +
                      FloatToStr(FArrOplataOld[i].Summ) + '":' + CRLF;

                    if FArrOplataOld[i].Payment <> FArrOplata[j].Payment then begin
                      if FArrOplata[j].Payment = 1 then
                        str1 := 'наличный'
                      else
                        str1 := 'безналичный';

                      logOplata := logOplata + '- способ c "' + str + '" на "' + str1 + '";' + CRLF;
                    end;

                    if FArrOplataOld[i].Date <> FArrOplata[j].Date then
                      logOplata := logOplata + '- дата c "' + DateToStr(FArrOplataOld[i].Date) + '" на "' + DateToStr(FArrOplata[j].Date) + '";' + CRLF;
                    if FArrOplataOld[i].Summ <> FArrOplata[j].Summ then
                      logOplata := logOplata + '- сумма c "' + FloatToStr(FArrOplataOld[i].Summ) + '" на "' + FloatToStr(FArrOplata[j].Summ) + '";' + CRLF;
                  end;
                  Break;
              end;
          end;

          if paymentFound = false then
            logOplata := logOplata + 'Удален "' + str +
              '" платеж от "' + DateToStr(FArrOplataOld[i].Date) + '" на сумму "' + FloatToStr(FArrOplataOld[i].Summ) + '".' + CRLF;
        end;

        for I := 0 to High(FArrOplata) do begin
          paymentFound := false;
          if FArrOplata[i].Payment = 1 then
            str := 'наличный'
          else
            str := 'безналичный';

          for j := 0 to High(FArrOplataOld) do begin
              if FArrOplataOld[j].Id = FArrOplata[i].Id then begin
                  paymentFound := true;
                  break;
              end;
          end;

          if paymentFound = false then
            logOplata := logOplata + 'Добавлен "' + str +
              '" платеж от "' + DateToStr(FArrOplata[i].Date) + '" на сумму "' + FloatToStr(FArrOplata[i].Summ) + '".' + CRLF;
        end;

        if logOplata <> '' then begin
          logOplata := 'Платежи.' + CRLF + logOplata;

          if Result <> '' then
            logOplata := CRLF + logOplata;
        end;
      end;
    end;

    Result := Result + logTovar + logOplata;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TPrihodTovaraNForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if WindowState = wsMaximized then
    SaveSettingsIni('PrihodTovaraNaklad', 'WindowState', 1, '')
  else
    SaveSettingsIni('PrihodTovaraNaklad', 'WindowState', 0, '');

  tvMain.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvMain.name);
end;

procedure TPrihodTovaraNForm.aOplataExecute(Sender: TObject);
var OplataForm : TOplataForm;
    i: integer;
begin
  OplataForm := TOplataForm.Create(Self);

  with OplataForm do begin
    try
      SummZakaz := edSumm.Value;
      PaymentType := lePAYMENT_TYPE.EditValue;
      Helpcc := 84;    // раздел справки
      IsZakaz := 0;
      mdRead.Open;
      for i := 0 to High(FArrOplata) do begin
        mdRead.Insert;
        mdRead.FieldByName('id').AsLargeInt := FArrOplata[i].Id;
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
          FArrOplata[i].Id := mdRead.FieldByName('id').AsLargeInt;
          FArrOplata[i].Date := mdRead.FieldByName('Date_Pay').AsDateTime;
          FArrOplata[i].Payment := mdRead.FieldByName('payment_type').AsLargeInt;
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

procedure TPrihodTovaraNForm.ApplicationEventsMessage(var Msg: tagMSG;
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
      if Msg.message = WM_KEYDOWN then
      begin
        if (Msg.wParam = 13) or (Msg.wParam = 10) then
        begin
          ClearBuffer;
          if KeysBuffer <> '' then begin
            // при сканировании нажатие энтера передавать никуда не надо
            Handled := True;
            aFindAndIns.Execute;
            KeysBuffer := '';
            if DateToStr(FedDate) <> '30.12.1899' then begin
              edDate.Date := FedDate;
              gr1.SetFocus;
              FedDate := 0;
            end;
            if DateToStr(FedTime) <> '00:00:00' then begin
              edTime.Time := FedTime;
              gr1.SetFocus;
              FedTime := 0;
            end;
            edOsnovanie.ModifiedAfterEnter := True;
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

procedure TPrihodTovaraNForm.PrintEtickets(printAll : boolean; mode : integer);
var
  cbPrinters, edSlogan, CennikSlogan : STRING;
  cbChooseLentWidth, cbPrintPrice, cbPriceBold, PrinterEtiketok: Integer;
  sePriceSize, cbPrintSlogan, cbSloganBold, seSloganSize : Integer;
  cbNameBold, seNameSize, Sdvig,
  cbPrintArticul, cbArticulBold, seArticulSize : integer;
  CennikPrintPrice, CennikPriceBold, CennikPriceSize, CennikPrintSlogan, CennikSloganBold,
  CennikSloganSize, CennikNameBold, CennikNameSize : integer;

  Ini : TMemIniFile;
  sql_str, amount_str : string;
  printMode, amount : Integer;
begin

  if mode in [0,1,2,3] then
    printMode := 0
  else
    printMode := 1;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    cbPrinters := Ini.ReadString('Printetiket', 'PrinterName', '');
    PrinterEtiketok := Ini.ReadInteger('Printetiket', 'PrinterEtiket', 0);
    if printMode = 0 then
    begin
      if PrinterEtiketok = 1 then
        cbChooseLentWidth := Ini.ReadInteger('Printetiket', 'LentaWidth', 0)
      else
        cbChooseLentWidth := Ini.ReadInteger('Printetiket', 'A4Size', 0);
      edSlogan := Ini.ReadString('Printetiket', 'Slogan', '');

      cbPrintPrice := Ini.ReadInteger('Printetiket', 'PrintPrice', 1);
      cbPrintArticul := Ini.ReadInteger('Printetiket', 'PrintArticul', 1);
      cbPrintSlogan := Ini.ReadInteger('Printetiket', 'PrintSlogan', 1);
      cbPriceBold := Ini.ReadInteger('Printetiket', 'PriceBold', 1);
      cbArticulBold := Ini.ReadInteger('Printetiket', 'ArticulBold', 1);
      cbSloganBold := Ini.ReadInteger('Printetiket', 'SloganBold', 1);
      sePriceSize := Ini.ReadInteger('Printetiket', 'PriceSize', 0);
      seArticulSize := Ini.ReadInteger('Printetiket', 'ArticulSize', 0);
      seSloganSize := Ini.ReadInteger('Printetiket', 'SloganSize', 0);
      seNameSize := Ini.ReadInteger('Printetiket', 'NameSize', 0);
      cbNameBold := Ini.ReadInteger('Printetiket', 'NameBold', 1);

      //ИСПРАВИЛ НА СКОРЯХ, НАДО ПО ИДЕЕ СДЕЛАТЬ ОДИНАКОВЫЕ ПЕРЕМЕННЫЕ!!!!!!!
      cbChooseLentWidth := cbChooseLentWidth;
      CennikSlogan := edSlogan;
      CennikPrintPrice := cbPrintPrice;
      CennikPrintSlogan := cbPrintSlogan;
      CennikPriceBold := cbPriceBold;
      CennikSloganBold :=cbSloganBold;
      CennikPriceSize := sePriceSize;
      CennikSloganSize := seSloganSize;
      CennikNameSize := seNameSize;
      CennikNameBold := cbNameBold;
    end
    else begin
      cbChooseLentWidth := Ini.ReadInteger('Printetiket', 'CennikSize', 0);
      CennikSlogan := Ini.ReadString('Printetiket', 'CennikSlogan', '');
      CennikPrintPrice := Ini.ReadInteger('Printetiket', 'CennikPrintPrice', 1);
      CennikPrintSlogan := Ini.ReadInteger('Printetiket', 'CennikPrintSlogan', 1);
      CennikPriceBold := Ini.ReadInteger('Printetiket', 'CennikPriceBold', 1);
      CennikSloganBold := Ini.ReadInteger('Printetiket', 'CennikSloganBold', 1);
      CennikPriceSize := Ini.ReadInteger('Printetiket', 'CennikPriceSize', 0);
      CennikSloganSize := Ini.ReadInteger('Printetiket', 'CennikSloganSize', 0);
      CennikNameSize := Ini.ReadInteger('Printetiket', 'CennikNameSize', 0);
      CennikNameBold := Ini.ReadInteger('Printetiket', 'CennikNameBold', 1);
    end;

    Sdvig := Ini.ReadInteger('Printetiket', 'Sdvig', 0);
  finally
    Ini.Free;
  end;

  if cbPrinters = '' then begin
    MessageDlg('Принтер для печати этикеток не задан!', mtError, [mbOK], 0);
    Exit;
  end;

  if (PrinterEtiketok = 1) and (mode in [0, 1, 2, 3]) then
  begin
    if mode in [0, 1] then
    begin

        with spZakazTemp do begin
          First;
          while not eof do begin
            if mode = 0 then
              amount := Trunc(SimpleRoundTo(FieldByName('amount').asFloat, 0))
            else
              amount := 1;
            ReportsDM.PrintLabel(cbPrinters,
                                PrinterEtiketok,
                                '',
                                cbChooseLentWidth,
                                cbPrintPrice,
                                cbPriceBold,
                                sePriceSize,
                                cbPrintArticul,
                                cbArticulBold,
                                seArticulSize,
                                cbPrintSlogan,
                                cbSloganBold,
                                seSloganSize,
                                edSlogan,
                                amount,
                                0,  //SloganOrPrice,
                                FieldByName('Barcode').AsString,
                                FieldByName('Articul').AsString,
                                FieldByName('Nomenclatur').AsString,
                                FieldByName('Brand').AsString,
                                FieldByName('PRODUCT_NAME').AsString,
                                FieldByName('SALE_PRICE').AsString,
                                FieldByName('G_PRODUCT').AsLargeInt,
                                cbNameBold,
                                seNameSize,
                                Sdvig,
                                printMode);
            Next;
          end;
        end;
    end
    else
    begin

        if mode = 2 then
          amount := Trunc(SimpleRoundTo(spZakazTemp.FieldByName('amount').asFloat, 0))
        else
          amount := 1;

        ReportsDM.PrintLabel(cbPrinters,
                            PrinterEtiketok,
                            '',
                            cbChooseLentWidth,
                            cbPrintPrice,
                            cbPriceBold,
                            sePriceSize,
                            cbPrintArticul,
                            cbArticulBold,
                            seArticulSize,
                            cbPrintSlogan,
                            cbSloganBold,
                            seSloganSize,
                            edSlogan,
                            amount,
                            0,  //SloganOrPrice,
                            spZakazTemp.FieldByName('Barcode').AsString,
                            spZakazTemp.FieldByName('Articul').AsString,
                            spZakazTemp.FieldByName('Nomenclatur').AsString,
                            spZakazTemp.FieldByName('Brand').AsString,
                            spZakazTemp.FieldByName('PRODUCT_NAME').AsString,
                            spZakazTemp.FieldByName('SALE_PRICE').AsString,
                            spZakazTemp.FieldByName('G_PRODUCT').AsLargeInt,
                            cbNameBold,
                            seNameSize,
                            Sdvig,
                            printMode);
    end
  end else begin

    PrinterEtiketok := 0;
    if mode in [0, 2, 4, 6] then
      amount_str := 'SUM(AMOUNT)'
    else
      amount_str := 'SUM(1)';

    // такой навороченный селект пришлось написать, чтобы вытащить именно столько строк, сколько количество
    // товара, столько строк, потому что печать на страницу так работает
    sql_str := 'WITH RECURSIVE TREE AS (SELECT g.name, g.barcode, g.articul, g.NOMENCLATUR_NUM, g.BRAND, TRUNC(g.price) PRICE, 1 levl, G.G_PRODUCT, ''Цена за: ''||U.SHORT_NAME UNIT' +
                          ' FROM G_PRODUCT g, G_UNIT U' +
                         ' WHERE EXISTS (SELECT 1' +
                                         ' FROM SKLAD_TMP SD' +
                                        ' WHERE SD.g_product = g.g_product)' +
                         '   AND G.G_UNIT = U.G_UNIT ';

    if mode in [2, 3, 6, 7] then
      sql_str := sql_str + ' and g.G_PRODUCT = ' + spZakazTemp.FieldByName('g_product').AsString;

    sql_str := sql_str +' UNION ALL' +
                        ' SELECT g.name, g.barcode, g.articul, g.NOMENCLATUR_NUM, g.BRAND, TRUNC(g.price) PRICE, gg.levl + 1 levl, G.G_PRODUCT, ''Цена за: ''||U.SHORT_NAME UNIT' +
                          ' FROM G_PRODUCT g INNER JOIN TREE GG ON GG.name = g.name, G_UNIT U' +
                         ' WHERE G.g_product = GG.G_PRODUCT' +
                         '   AND G.G_UNIT = U.G_UNIT ' +
                           ' AND gg.levl < MINVALUE(1000, (SELECT ' + amount_str + ' FROM SKLAD_TMP SDD' +  //МАКСИМУМ 1000 ШТУК ЗА РАЗ, В ИЕРАРХИЧЕСКИХ ЗАПРОСАХ ЕСТЬ ОГРАНИЧЕНИЕ НА ГЛУБИНУ В 1024
                                            ' WHERE SDD.g_product = G.g_product))';
    if mode in [2, 3, 6, 7] then
      sql_str := sql_str + ' and g.G_PRODUCT = ' + spZakazTemp.FieldByName('g_product').AsString;

    sql_str := sql_str + ' )'+ ' SELECT * FROM TREE';

    ReportsDM.PrintLabel(cbPrinters,
                          PrinterEtiketok,
                          sql_str,
                          cbChooseLentWidth,
                          CennikPrintPrice,
                          CennikPriceBold,
                          CennikPriceSize,
                          0, //cbPrintArticul,
                          0, //cbArticulBold,
                          0, //seArticulSize,
                          CennikPrintSlogan,
                          CennikSloganBold,
                          CennikSloganSize,
                          CennikSlogan,
                          0,  //Amount
                          0,  //SloganOrPrice,
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          0,
                          CennikNameBold,
                          CennikNameSize,
                          Sdvig,
                          printMode);
  end;
end;

// распечатать этикетки по одному товару
procedure TPrihodTovaraNForm.aPrintCurExecute(Sender: TObject);
begin
  PrintEtickets(false);
end;

// распечатать все этикетки
procedure TPrihodTovaraNForm.aPrintExecute(Sender: TObject);
begin
  PrintEtickets(true);
end;

procedure TPrihodTovaraNForm.aRoundDrobExecute(Sender: TObject);
begin
  DoNacenka(-1, 0);
end;

procedure TPrihodTovaraNForm.aRoundExecute(Sender: TObject);
begin
  FRoundVal := 1;
  DoNacenka(-1, FRoundVal);
end;

procedure TPrihodTovaraNForm.aRoundHundredExecute(Sender: TObject);
begin
  FRoundVal := 3;
  DoNacenka(-1, FRoundVal);
end;

procedure TPrihodTovaraNForm.aRoundTenExecute(Sender: TObject);
begin
  FRoundVal := 2;
  DoNacenka(-1, FRoundVal);
end;

procedure TPrihodTovaraNForm.aRoundThousandExecute(Sender: TObject);
begin
  FRoundVal := 4;
  DoNacenka(-1, FRoundVal);
end;

//распечатать этикетку одного товара
procedure TPrihodTovaraNForm.aSaveAllToXLSExecute(Sender: TObject);
begin
  if dlgSave.Execute then
    ExportGridToExcel(dlgSave.FileName, gr1, True, True, True, 'xls');
end;

procedure TPrihodTovaraNForm.aSaveSelectedToXLSExecute(Sender: TObject);
begin
  if dlgSave.Execute then
    ExportGridToExcel(dlgSave.FileName, gr1, True, False, True, 'xls');
end;

procedure TPrihodTovaraNForm.aSearchClientExecute(Sender: TObject);
var GetDCardForm: TGetDCardForm;
begin
  GetDCardForm := TGetDCardForm.Create(Self);
  with GetDCardForm do begin
    try
      GetDCardForm.Discont_card := spPostavshik.FieldByName('g_discont_card').AsLargeInt;
      if Showmodal = mrOK then begin
        if Client <> 0 then begin
          lePostavshik.EditValue := Client;
          //lePostavshikChange(Self);
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TPrihodTovaraNForm.SetArrOplataSumm;
begin
  if High(FArrOplata) = 0 then begin
    FArrOplata[0].Date := edDate.Date;
    FArrOplata[0].Payment := lePAYMENT_TYPE.EditValue;
    FArrOplata[0].Summ := edSummFact.Value;
  end;
end;

procedure TPrihodTovaraNForm.edDatePropertiesChange(Sender: TObject);
begin
  FedDate := edDate.Date;

  if High(FArrOplata) = 0 then
    FArrOplata[0].Date := edDate.Date;
end;

procedure TPrihodTovaraNForm.EnableSummFact;
begin
  edSummFact.Enabled := High(FArrOplata) = 0;
  sbEqualSumm.Enabled := High(FArrOplata) = 0;
end;

procedure TPrihodTovaraNForm.lePAYMENT_TYPEPropertiesChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Payment := lePAYMENT_TYPE.EditValue;

  if (FIs_vozvrat <> 0) then
    SetNonCashPayTypeVisible;
end;

procedure TPrihodTovaraNForm.SetPaymentType;
var NalPyament, BeznalPayment, i : integer;
begin
  NalPyament := 0;
  BeznalPayment := 0;

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

procedure TPrihodTovaraNForm.spZakazTempAfterPost(DataSet: TDataSet);
var Oldsklad : Int64;
begin
  inherited;

  Oldsklad := spZakazTemp.FieldByName('sklad').AsLargeInt;
  Readlist;
  spZakazTemp.Locate('sklad', Oldsklad, []);
  edOsnovanie.ModifiedAfterEnter := True;
  FTovarWasChanged := True;
end;

procedure TPrihodTovaraNForm.tvMainCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aUpd.Execute;
end;

procedure TPrihodTovaraNForm.tvMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
var
  AIndex : integer;
begin
  inherited;

  //пришлось перенести это все в сюда из Readlist
  //потому что здесь редактируется cxGrid и сумма после изменения в нем - не считается

  if FIsClosingNow = false then begin
    with tvMain.DataController.Summary do begin
      AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSUMM);
      if not VarIsNull(FooterSummaryValues[AIndex]) then
        edSumm.Value := FooterSummaryValues[AIndex]
      else
        edSumm.Value := 0;

      if UseCurrency then begin
        AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSummCurrency);
        if not VarIsNull(FooterSummaryValues[AIndex]) then
          edSummCurrency.Value := FooterSummaryValues[AIndex]
        else
          edSummCurrency.Value := 0;
      end;
    end;

    if FIsGetDataNow = false then begin
      if High(FArrOplata) = 0 then
        edSummFact.Value := edSumm.Value
      else begin
        edSummDolg.Value := edSumm.Value - edSummFact.Value;
      end;
    end;
  end;
end;

procedure TPrihodTovaraNForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;

  if (spZakazTemp.FieldByName('is_marked').AsInteger = 1) and (FIs_vozvrat = 1) then
    clmMainAmount.Options.Editing := False
  else
    clmMainAmount.Options.Editing := True;

end;

procedure TPrihodTovaraNForm.SetNonCashPayTypeVisible;
var needToShow : boolean;
begin

  needToShow := false;

  needToShow := (lePAYMENT_TYPE.EditValue = 2) and (FIs_vozvrat = 1);

  if needToShow then begin
    if spNonCashPayTypes.Active = False then begin
      OpenSp(spNonCashPayTypes, False);
      leNonCashPayType.EditValue := 1;
    end;
  end;

  lbNonCashPayType.Visible := needToShow;
  shpNonCashPayType.Visible := needToShow;
  shpNonCashPayType1.Visible := needToShow;
  leNonCashPayType.Visible := needToShow;

  if leNonCashPayType.Visible = false then begin
    if FIs_vozvrat = 0 then begin
      lbSklad.Top := lbSklad.Top - (shpNonCashPayType.Top - shpPayType.Top);
      shpSklad.Top := shpSklad.Top - (shpNonCashPayType.Top - shpPayType.Top);
      shpSklad1.Top := shpSklad1.Top - (shpNonCashPayType.Top - shpPayType.Top);
      leSklad.Top := leSklad.Top - (shpNonCashPayType.Top - shpPayType.Top);

    end;

    lbNote.Top := lbNote.Top - shpNonCashPayType.Height;
    shpNote.Top := shpNonCashPayType.Top;
    shpNote1.Top := shpNonCashPayType1.Top;
    mNote.Top := leNonCashPayType.Top;

    pnlTop.Height := pnlTop.Height - shpNonCashPayType.Height;
  end
  else begin
    lbNote.Top := lbNote.Top + (lbNonCashPayType.Top - lbPayment.Top);
    shpNote.Top := shpNote.Top + (shpNonCashPayType.Top - shpPayType.Top);  //(lbNonCashPayType.Top - lbPayment.Top);
    shpNote1.Top := shpNote1.Top + (shpNonCashPayType.Top - shpPayType.Top);  //(lbNonCashPayType.Top - lbPayment.Top);
    mNote.Top := mNote.Top + (shpNonCashPayType.Top - shpPayType.Top);

    pnlTop.Height := pnlTop.Height + shpNonCashPayType.Height;
  end;

  // если это обычный приход, то
  // нужно запустить только один раз при запуске формы, а затем не запускать более
  //if FIs_vozvrat = 0 then begin
  //  lePAYMENT_TYPE.Properties.OnChange := nil;
  //end;

end;

end.
