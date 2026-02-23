unit frmProdazhaTovaraN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxMemo,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxSpinEdit,
  cxTimeEdit, cxMaskEdit, cxCalendar, cxCheckBox, Buttons, StdCtrls, ExtCtrls,
  cxPC, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase,
  ActnList, AppEvnts, FIBDataSet, pFIBDataSet, FIB, unCommonFunc, IniFiles, Math,
  Menus, cxButtons, System.UITypes, dxBarBuiltInMenu, cxNavigator, Vcl.ComCtrls,
  dxCore, cxDateUtils, System.Actions, cxGridExportLink,
  frmDostavshikPopup, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  dxmdaset, unLog, System.DateUtils;

type

  TRecOplata = record
    Id: Int64;
    Date: TDate;
    Summ  : Double;
    Payment: Int64;
  end;

  TArrOplata = Array of TRecOplata;

  TTovarRec = record
    Id   : Int64;
    Name : String;
    Amount : Double;
    Price  : Double;
    Summ   : Double;
  end;

  TRecItem = record
    Id   : Int64;
    Note : String;
  end;

  TInsArrRecItem = array of TRecItem;

  TProdazhaTovaraNForm = class(TDBEditForm)
    Panel2: TPanel;
    pcMain: TcxPageControl;
    tsCommon: TcxTabSheet;
    Panel4: TPanel;
    BitBtn10: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn9: TBitBtn;
    pnRowCnt: TPanel;
    Panel5: TPanel;
    pnlOplata: TPanel;
    Shape5: TShape;
    Shape3: TShape;
    Label3: TLabel;
    Label5: TLabel;
    Shape6: TShape;
    Shape4: TShape;
    sbEqualSumm: TSpeedButton;
    cbByRecipe: TcxCheckBox;
    btnOplata: TBitBtn;
    pnlBonus: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    lb1: TLabel;
    cbPayBonus: TcxCheckBox;
    Panel3: TPanel;
    Shape7: TShape;
    Label4: TLabel;
    Shape8: TShape;
    tsPrihod: TcxTabSheet;
    lbStatya: TLabel;
    sbClear: TSpeedButton;
    tsReserv: TcxTabSheet;
    lbReserv: TLabel;
    cbReserv: TcxCheckBox;
    tsRecalc: TcxTabSheet;
    lbRecalc: TLabel;
    btnIns: TBitBtn;
    pnlTop: TPanel;
    shTime: TShape;
    ShapeNote: TShape;
    ShapePayment: TShape;
    ShapeClient: TShape;
    Shape12: TShape;
    Shape14: TShape;
    Label7: TLabel;
    LabelDoc: TLabel;
    lbClient: TLabel;
    lbPayment: TLabel;
    lbNote: TLabel;
    Shape13: TShape;
    Shape15: TShape;
    Shape16: TShape;
    ShapeClient1: TShape;
    ShapePayment1: TShape;
    ShapeNote1: TShape;
    lbTime: TLabel;
    edDate: TcxDateEdit;
    edTime: TcxTimeEdit;
    btDiscCard: TBitBtn;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    clmMainPRODUCT_NAME: TcxGridDBColumn;
    clmMainAMOUNT: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainSUMM: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    edSumm: TcxCurrencyEdit;
    edSummFact: TcxCurrencyEdit;
    edSummDolg: TcxCurrencyEdit;
    edOsnovanie: TcxTextEdit;
    lePostavshik: TcxLookupComboBox;
    lePAYMENT_TYPE: TcxLookupComboBox;
    mNote: TcxMemo;
    edBonus: TcxCurrencyEdit;
    edBonusAll: TcxCurrencyEdit;
    edBonusPayed: TcxCurrencyEdit;
    leStatya: TcxLookupComboBox;
    edSummPrihod: TcxCurrencyEdit;
    spZakazTemp: TpFIBDataSet;
    dsZakazTemp: TDataSource;
    spDel: TpFIBStoredProc;
    spReadStatya: TpFIBDataSet;
    dsReadStatya: TDataSource;
    spRecalcPrices: TpFIBStoredProc;
    dsPaymentType: TDataSource;
    spPaymentType: TpFIBDataSet;
    spPostavshik: TpFIBDataSet;
    dsPostavshik: TDataSource;
    spUpdLock: TpFIBStoredProc;
    clmMainDISCOUNT_PERC: TcxGridDBColumn;
    clmMainDISCOUNT_SUMM: TcxGridDBColumn;
    clmMainNDS: TcxGridDBColumn;
    clmMainNDS_SUMM: TcxGridDBColumn;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    aGetDCard: TAction;
    aOplata: TAction;
    aRecalcPrices: TAction;
    aPrintInvoicePay: TAction;
    btnPrintInvoicePay: TcxButton;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    aCustomizeColumns: TAction;
    aSaveAllToXLS: TAction;
    aSaveSelectedToXLS: TAction;
    dlgSave: TSaveDialog;
    clmMainBARCODE: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    tsMebelDelivery: TcxTabSheet;
    Label1: TLabel;
    deDeliveryDate: TcxDateEdit;
    Label2: TLabel;
    mAddress1: TcxMemo;
    Label6: TLabel;
    peDostavshik: TcxPopupEdit;
    Label8: TLabel;
    edPrice: TcxCurrencyEdit;
    spUpdZakazDetailsTmpPrices: TpFIBStoredProc;
    pmEtiket: TPopupMenu;
    mniPrintCur: TMenuItem;
    N2: TMenuItem;
    aPrintAll: TAction;
    aPrintCur: TAction;
    btnPrintEtiket: TcxButton;
    tsDop: TcxTabSheet;
    cbNotMinusOstatok: TcxCheckBox;
    lbTovarVPuti: TLabel;
    lbDraft: TLabel;
    mdOldTovar: TdxMemData;
    mdNewTovar: TdxMemData;
    pnlAddress: TPanel;
    Label9: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    mAddress: TcxMemo;
    lbNonCashPayType: TLabel;
    shpNonCashPayType: TShape;
    shpNonCashPayType1: TShape;
    leNonCashPayType: TcxLookupComboBox;
    spNonCashPayTypes: TpFIBDataSet;
    dsNonCashPayTypes: TDataSource;
    spDoMove: TpFIBStoredProc;
    ApplicationEvents: TApplicationEvents;
    aFindAndIns: TAction;
    spFindProduct: TpFIBStoredProc;
    spInsTmpByBarcode: TpFIBStoredProc;
    spGetLastPrice: TpFIBStoredProc;
    procedure FormShow(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grProductDblClick(Sender: TObject);
    procedure sbEqualSummClick(Sender: TObject);
    procedure aGetDCardExecute(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure ceReservChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cb1PropertiesChange(Sender: TObject);
    procedure aRecalcPricesExecute(Sender: TObject);
    procedure aOplataExecute(Sender: TObject);
    procedure edDatePropertiesChange(Sender: TObject);
    procedure cbPayBonusPropertiesChange(Sender: TObject);
    procedure edSummFactPropertiesChange(Sender: TObject);
    procedure lePostavshikPropertiesChange(Sender: TObject);
    procedure lePAYMENT_TYPEPropertiesChange(Sender: TObject);
    procedure tvMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure aPrintInvoicePayExecute(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure aSaveAllToXLSExecute(Sender: TObject);
    procedure aSaveSelectedToXLSExecute(Sender: TObject);
    procedure peDostavshikPropertiesCloseUp(Sender: TObject);
    procedure peDostavshikPropertiesInitPopup(Sender: TObject);
    procedure aPrintAllExecute(Sender: TObject);
    procedure aPrintCurExecute(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure aFindAndInsExecute(Sender: TObject);
    procedure edTimePropertiesChange(Sender: TObject);
  private
    FNotGetDataProcess : Boolean;  // признак, что НЕ идет процесс GetData
    FArrOplata  : TArrOplata;
    FArrOplataOld  : TArrOplata;
    FSuccess    : Boolean;
    FClient     : Int64;   // при добавлении товара на реал в TZakazNaRealListForm, если стоят на каком-то клиенте, он подставляется автоматом
    FIs_spisanie : Integer; // 0 - обычный заказ, 1 - списание товара, 2 - выдача под реализацию, 3 - перемещение между складами
    FSkidka  : Double;       // скидка клиента при покупке
    FSummZakaz : Double;       // сумма заказа
    FBonusPercent : Double;    // процент бонуса от суммы заказа
    FSummBonus : Double;       // сумма накопленного бонуса за все время
    FSummBonusPay : Double;       // сумма бонуса, оплачеваемого за данный заказ
    FSummBonusPayed : Double;     // сумма оплаченная бонусом, в уже сохраненном заказе
    FSummBonusGot : Double;       // сумма полученных бонусов, в уже сохраненном заказе
    FInvoicePay, peDostavshikTag : Int64;
    FMaxBonusPaySumm : Double;   // максимальная сумма, которую может оплатить клиент бонусами
    FRecOld : TRec;
    FRecInsRec : TInsArrRecItem;
    FLogOplata : String;
    FTovarWasChanged : Boolean;
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FSkladParent  : Int64; // если больше 0, то значит форма вызвана дл€ перемещени€, надо делать перемещение
    FCOST_PRICE : Double;   // себестоимость товара
    FedDate     : TDate;
    FedTime     : TDate;
    procedure SetArrOplataSumm;
    procedure EnableSummFact;
    procedure SetPaymentType;
    procedure SetNonCashPayTypeVisible;
    function  FillLog : string;
    function  FuncGetLastPrice(GProduct : Int64) : Boolean;
  protected
    FPopupForm : TDostavshikPopupForm;
    function InsData: Boolean;
    function UpdData: Boolean;
    procedure ClearTempTable;
    procedure DisableControls;
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure PrintEtickets(printAll : boolean);
  public
    property Success: Boolean read FSuccess write FSuccess default False;
    property Client: Int64 read FClient write FClient default 0;
    property Is_spisanie: Integer read FIs_spisanie write FIs_spisanie default 0;  // 0 - ќЅџ„Ќјя ѕ–ќƒј∆ј, 1 - —ѕ»—јЌ»≈, 2 - ¬џƒј„ј “ќ¬ј–ј ѕќƒ –≈јЋ»«ј÷»ё
    property InvoicePay : Int64 read FInvoicePay write FInvoicePay;
    property SkladParent : Int64 read FSkladParent write FSkladParent;
    procedure Readlist;
  end;

var
  ProdazhaTovaraNForm: TProdazhaTovaraNForm;

implementation

uses unErrorHandlers, frmZakupkaTovara, frmUpdZakupkaTovara,
  frmProdazhaTovara, frmUpdProdazhaTovara, frmGetDCard, frmOplata, dmReports, frmInvoicePay;

{$R *.dfm}

procedure TProdazhaTovaraNForm.DisableControls;
begin
  aIns.Enabled := False;
  aUpd.Enabled := False;
  aDel.Enabled := False;
  aOplata.Enabled := False;
  aGetDCard.Enabled := False;
  edDate.ENABLED := FALSE;
  edTime.ENABLED := FALSE;
  edOsnovanie.ENABLED := FALSE;
  edSummFact.ENABLED := FALSE;
  mNote.Enabled := FALSE;
  lePostavshik.ENABLED := FALSE;
  lePAYMENT_TYPE.ENABLED := FALSE;
  btnIns.Enabled := FALSE;
  btnOk.Enabled := FALSE;
end;

procedure TProdazhaTovaraNForm.GetData;
var OnChange, OnClick : TNotifyEvent;
    p, i : integer;
    str, str1 : string;
begin
  FNotGetDataProcess := False;
  TRY
    //if FOpenMode in [omView, omUpdate, omInsertLike] then    теперь Getdata вызывается всегда
    begin
      // если перемещение на основе прихода
      if FSkladParent <> 0 then begin
        with spDoMove do begin
          ParamByName('SKLAD_PARENT_').AsInt64 := FSkladParent;
          ParamByName('ROZN_OR_COST_PRICE_').AsInteger := UseSelfPriceOnTransfer;
          ExecSpTr(spDoMove);
        end;
      end;

      try
        spGetData.ParamByName('zakaz_').AsInt64 := RecID;
        spGetData.ParamByName('IS_SPISANIE_').AsInteger := FIs_spisanie;
        if not spGetData.Transaction.InTransaction then
          spGetData.Transaction.StartTransaction;

        ExecSP(spGetData);

        if spGetData.Transaction.InTransaction then
          spGetData.Transaction.CommitRetaining;
      except
        on E: EFIBError do begin
          if spGetData.Transaction.InTransaction then
            spGetData.Transaction.RollbackRetaining;
          DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TProdazhaTovaraNForm.GetData)');
        end;
        on E: Exception do begin
          if spGetData.Transaction.InTransaction then
            spGetData.Transaction.RollbackRetaining;
          MessageDlg(E.Message + #13#10'(occured in TProdazhaTovaraNForm.GetData)', mtError, [mbOk], 0);
        end;
      end;
    end;

    if OpenMode <> omInsert then BEGIN
      with spGetData do begin
        edDate.Date      := ParamByName('Z_DATE_').AsDate;
        edTime.Time      := ParamByName('Z_time_').AsTime;

        if OpenMode = omInsertLike then begin
          edDate.Date    := Date;
          edTime.Time    := Now;
        end;

        FRecOld.ZDate    := ParamByName('Z_DATE_').AsDate;

        FRecOld.ZTime    := ParamByName('Z_time_').AsTime;

        lePostavshik.EditValue := ParamByName('G_CLIENT_').AsInt64;
        //lePostavshikChange(Self);
        FRecOld.Postavshik     := ParamByName('G_CLIENT_').AsInt64;
        FRecOld.PostavshikName := lePostavshik.Text;

        lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsInt64;

        edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
        FRecOld.Osnovanie := ParamByName('OSNOVANIE_').AsString;

        mNote.Text := ParamByName('note_').AsString;
        FRecOld.Note := ParamByName('note_').AsString;

        mAddress.Text := ParamByName('ADDRESS_').AsString;
        FRecOld.Address := ParamByName('ADDRESS_').AsString;

        if spNonCashPayTypes.Active then
          leNonCashPayType.EditValue := ParamByName('G_NONCASH_PAY_TYPE_').AsInt64;
        FRecOld.GNonCashPayType := ParamByName('G_NONCASH_PAY_TYPE_').AsInt64;
        if FRecOld.GNonCashPayType = 0 then
          FRecOld.GNonCashPayTypeName := 'наличный'
        else
          FRecOld.GNonCashPayTypeName := leNonCashPayType.Text;

        edSumm.Value := ParamByName('summ_').AsFloat;
        FRecOld.Summ := ParamByName('summ_').AsFloat;

        leStatya.EditValue := ParamByName('G_PRIHOD_').AsInt64;
        FRecOld.Statya := ParamByName('G_PRIHOD_').AsInt64;
        FRecOld.StatyaName := leStatya.Text;

        edSummPrihod.Value := ParamByName('SUMM_PRIHOD_').AsFloat;
        FRecOld.StatyaSumm := ParamByName('SUMM_PRIHOD_').AsFloat;

        OnChange := edSummFact.Properties.OnChange;
        edSummFact.Properties.OnChange := nil;
        Readlist;
        FSummBonusPayed := ParamByName('SUMM_PAY_BONUS_').AsFloat;
        FSummBonusGot := ParamByName('SUMM_GOT_BONUS_').AsFloat;
        edBonus.Value := FSummBonusGot;
        FRecOld.Bonus := FSummBonusGot;

        if FSummBonusPayed > 0 then begin
          OnClick := cbPayBonus.Properties.OnChange;
          cbPayBonus.Properties.OnChange := nil;
          cbPayBonus.Checked := True;
          cbPayBonus.Properties.OnChange := OnClick;
          FSummBonusPay := FSummBonusPayed;
          edBonusPayed.Value := FSummBonusPay;
          FRecOld.BonusPayed := FSummBonusPay;
        end;
        edSummFact.Value := ParamByName('summ_fact_').AsFloat;
        FRecOld.SummFact := ParamByName('summ_fact_').AsFloat;

        edSummDolg.Value := (edSummFact.Value + FSummBonusPayed) - edSumm.Value;
        edSummFact.Properties.OnChange := OnChange;

        cbByRecipe.checked := ParamByName('by_recipe_').AsInteger = 1;
        FRecOld.ByRecipe := cbByRecipe.checked;

        cbReserv.checked   := ParamByName('IS_RESERVE_').AsInteger = 1;
        FRecOld.Reserv := cbReserv.checked;

        cbNotMinusOstatok.checked := ParamByName('NOT_MINUS_OSTATOK_').AsInteger = 1;
        FRecOld.NotAddMinusOstatok := cbNotMinusOstatok.checked;

        // «јѕќЋЌяё ћј——»¬ ѕЋј“≈∆≈…
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
    END
    ELSE BEGIN
      // если перемещение на основе прихода
      IF (OpenMode = omInsert) AND (FSkladParent <> 0) THEN
        Readlist;
    END;

    if High(FArrOplata) = -1 then begin
      SetLength(FArrOplata, 1);
      FArrOplata[0].Date := edDate.Date;
      FArrOplata[0].Payment := lePAYMENT_TYPE.EditValue;
    end;
    EnableSummFact;  // выключаю edSummFact, если есть больше одного платежа

    if (OpenMode = omUpdate) and (
    ((HaveRightUpdSale = False) and (FIs_spisanie = 0)) OR
    ((HaveRightUpdSpisanie = False) and (FIs_spisanie = 1)) OR
    ((HaveRightUpdMove = False) and (FIs_spisanie = 3))
    )  then begin
      MessageDlg('” вас нет прав на редактирование накладных!', mtInformation, [mbOk], 0);
      DisableControls;
      Exit;
    end;

    //ѕ–ќ¬≈–яё ≈—“№ Ћ» ѕ–ј¬ќ Ќј –≈ƒј “»–ќ¬јЌ»≈ Ќј ЋјƒЌќ… «ј ѕ–ќЎЋџ≈ ƒј“џ
    //Ќ≈¬ј∆Ќќ  ј јя ƒј“ј ” Ќј ЋјƒЌќ…, ћЌ≈ ѕ–ќ÷≈ƒ”–ј ”∆≈ ¬ќ«¬–јўј≈“ 1, ≈—Ћ» Ќј ЋјƒЌјя «ј “≈ ”ў”ё ƒј“”
    IF (spGetData.ParamByName('HaveRight_').AsInteger = 0) AND (OpenMode = omUpdate) THEN BEGIN
      // короче не было времени делать в базе и наворачивать проверки
      // если есть такой файл, то за вчера можно редактировать
      if not ((FileExists(ExtractFilePath(Application.exename) + 'is_can_update_yesterday.txt')) and
      ((Date - edDate.Date) <=1 )) then begin
        MessageDlg('¬ы не обладаете правом дл€ редактировани€ накладных за прошлые даты!', mtWarning, [mbOk], 0);
        DisableControls;
        EXIT;
      end;
    END;

    //ѕ–ќ¬≈–яё Ћ»÷≈Ќ«»ё
    IF (IsActivated = 0) THEN BEGIN
      MessageDlg('Ћицензи€ истекла либо не зарегистрирована.' + #10#13 + '¬ключены ограничени€ на количество продаж!', mtWarning, [mbOk], 0);
      DisableControls;
      EXIT;
    END;

    if OpenMode = omView then
      PostMessage(Self.Handle, WM_READONLYCONTROLS, 0, 0)

    // блокирую запись
    else if (OpenMode = omUpdate) and (SyncCurCompId = 0) then begin
      spUpdLock.ParamByName('id_').AsInt64 := RecId;
      spUpdLock.ParamByName('TABLE_NAME_').AsString := 'zakaz';

      if not spUpdLock.Transaction.InTransaction then   //“–јЌ«ј ÷»я «ј ќћћ»“»“№—я, ≈—Ћ»  Ћ»≈Ќ“ Ќј∆ћ≈“  Ќќѕ ” ќ , »Ћ» ќ“–ќЋЋЅј„»“№—я, ≈—Ћ» Ѕ”ƒ≈“ ќЎ»Ѕ ј »Ћ» Ќј∆ћ”“  Ќќѕ ” ќ“ћ≈Ќј
        spUpdLock.Transaction.StartTransaction;
      if not ExecSP(spUpdLock) then begin
        DisableControls;
        EXIT;
      end;
    end;

    // заполн€ю старые значени€ по оплатам и товарам
    if (OpenMode = omUpdate) then begin
      mdOldTovar.CopyFromDataSet(spZakazTemp);
    end;

  FINALLY
    FNotGetDataProcess := True;
  END;
end;

function TProdazhaTovaraNForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := False;

  if isCredit then
  begin
    if edSummFact.Value + edBonusPayed.Value < edSumm.Value then
    begin
      MessageDlg('—умма оплаты меньше суммы чека! ”становлен запрет продажи в долг.', mtError, [mbOk], 0);
      Exit;
    end;
  end;

  if NOT CheckDate(edDate.Date, '01.01.2000', '01.01.2099') then begin
    ErrControl := edDate;
    MessageDlg('¬ведена некорректная дата', mtInformation, [mbOK], 0);
    Exit;
  end;

  if NOT CheckTime(edTime.Time) then begin
    ErrControl := edTime;
    MessageDlg('¬ведено некорректное время', mtInformation, [mbOK], 0);
    Exit;
  end;

  if (edSummFact.Value > edSumm.Value) and (High(FArrOplata) > 0) then begin
    MessageDlg('ќплачиваема€ сумма не может быть больше суммы продажи. »змените ее' + #13#10 +
               'либо в поле "ќплачено", либо нажав на кнопку "—писок платежей".', mtInformation, [mbOK], 0);
    if edSummFact.Enabled then
      ErrControl := edSummFact
    else
      ErrControl := btnOplata;
    Exit;
  end;

  if OpenMode = omInsert then begin
    if (edSummPrihod.Value > 0) and (leStatya.Text = '') then begin
      pcMain.ActivePage := tsPrihod;
      ErrControl := leStatya;
      MessageDlg('—тать€ прихода не указана.', mtInformation, [mbOK], 0);
      Exit;
    end;

    if (edSummPrihod.Value = 0) and (leStatya.Text <> '') then begin
      pcMain.ActivePage := tsPrihod;
      ErrControl := edSummPrihod;
      MessageDlg('—умма прихода не указана.', mtInformation, [mbOK], 0);
      Exit;
    end;
  end;

  IF (FIs_spisanie = 2) AND (lePostavshik.EditValue = 0) then begin
    ErrControl := lePostavshik;
    MessageDlg(' лиент не выбран!', mtInformation, [mbOK], 0);
    Exit;
  end;

  IF (FIs_spisanie = 2) AND (lePostavshik.EditValue = 0) then begin
    ErrControl := lePostavshik;
    MessageDlg(' лиент не выбран!', mtInformation, [mbOK], 0);
    Exit;
  end;

  IF (FIs_spisanie = 0) AND (lePAYMENT_TYPE.EditValue = 2) AND (leNonCashPayType.Text = '') then begin
    ErrControl := leNonCashPayType;
    MessageDlg('“ип расчета не указан!', mtError, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TProdazhaTovaraNForm.SetParams(SP: TpFIBStoredProc);
var
  i : integer;
  StrArr : string;
  Summcash, summnoncash : double;
  log, logTovar : string;
begin
  Summcash := 0;
  summnoncash := 0;

  with SP do begin
    ParamByName('Z_DATE_').AsDate := edDate.Date;
    ParamByName('Z_TIME_').AsTime := edTime.Time;
    if lePostavshik.EditValue > 0 then
      ParamByName('G_CLIENT_').AsInt64 := lePostavshik.EditValue
    else
      ParamByName('G_CLIENT_').AsInt64 := 10;
    if lePAYMENT_TYPE.EditValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInt64 := lePAYMENT_TYPE.EditValue
    else
      ParamByName('G_PAYMENT_TYPE_').AsInt64 := 1;  // по умолчанию поставлю наличный расчет, если клиент вдруг ничего не выбрал
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('summ_').AsFloat := edSumm.Value;
    ParamByName('summ_fact_').AsFloat := edSummFact.Value;
    ParamByName('by_recipe_').AsInteger := Integer(cbByRecipe.checked);
    ParamByName('IS_RESERVE_').AsInteger := Integer(cbReserv.checked);
    IF (leStatya.EditValue <> 0) and (leStatya.EditValue <> null) THEN
      ParamByName('g_prihod_').AsInt64 := leStatya.EditValue;
    ParamByName('summ_prihod_').AsFloat := edSummPrihod.Value;
    IF cbPayBonus.Checked THEN
      ParamByName('summ_bonus_').AsFloat := FSummBonusPay  //≈—Ћ» ЅќЌ”—ќ¬ ЅќЋ№Ў≈ „≈ћ —”ћћј «ј ј«ј, “ќ ѕќƒ—“ј¬Ћяё —”ћћ” «ј ј«ј, »Ќј„≈ - ѕќƒ—“ј¬Ћяё —”ћћ” ЅќЌ”—ќ¬
    else
      ParamByName('summ_bonus_').AsFloat := 0;
    ParamByName('summ_bonus_got_').AsFloat := edBonus.Value;    //ѕ≈–≈ƒјё —”ћћ” Ќј„»—Ћ≈ЌЌџ’ ЅќЌ”—ќ¬ «ј «ј ј«

    ParamByName('IS_SPISANIE_').AsInteger := FIs_spisanie;

    if FIs_spisanie in [0,4] then begin  // только если обычна€ продажа или возврат товара поставщику
      for i := 0 to High(FArrOplata) do begin
        if FArrOplata[i].Payment = 1 then
          Summcash := Summcash + FArrOplata[i].Summ
        else
          summnoncash := summnoncash + FArrOplata[i].Summ;

        StrArr := StrArr + IntToStr(FArrOplata[i].Id) + '-' + DateToStr(FArrOplata[i].Date) + '-' + FloatToStr(FArrOplata[i].Summ) + '-' + IntToStr(FArrOplata[i].Payment)+ '~';
      end;
    end;
    if Summcash > edSumm.Value then
      Summcash := edSumm.Value;
    if summnoncash > edSumm.Value then
      summnoncash := edSumm.Value;

    StrArr := StringReplace(StrArr, ',', '.', [rfReplaceAll, rfIgnoreCase]);   //заменяю на всякий случай запятые на точки
    ParamByName('PAYMENTS_').AsString := StrArr;
    ParamByName('SUMM_CASH_').AsFloat := Summcash;
    ParamByName('SUMM_NONCASH_').AsFloat := summnoncash;

    // если мебельный магазин, то сразу делаю вставку в журнал доставки
    if (Config = 4) and (OpenMode = omInsert) and (FIs_spisanie = 0) then begin
      ParamByName('IS_MEBEL_').AsFloat := 1;
      if deDeliveryDate.Date > 0 then
        ParamByName('DELIVERY_DATE_').AsDate := edDate.Date;
      ParamByName('ADDRESS_').asString := mAddress.Text;
      if peDostavshikTag <> 0 then
        ParamByName('DOSTAVSHIK_').AsInt64 := peDostavshikTag;
      ParamByName('PRICE_').asFloat := edPrice.Value;
    end;

    // надо ли заносить продажу в отдельную таблицу для выгрузки в XML
    if (StrToInt(Copy(ExportDataType, 5, 1)) = 1) or (UploadToMobile) then
      ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 1
    else
      ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;

    ParamByName('NOT_MINUS_OSTATOK_').AsInteger := Integer(cbNotMinusOstatok.Checked);
    ParamByName('USER_ID_').AsInt64 := CurrentOfficial;
    ParamByName('ADDRESS_').AsString := mAddress.Text;
    IF lePAYMENT_TYPE.EditValue = 2 THEN
      ParamByName('G_NONCASH_PAY_TYPE_').AsInt64 := leNonCashPayType.EditValue
    else
      ParamByName('G_NONCASH_PAY_TYPE_').Clear;

    ParamByName('LOG_BODY_').AsString := FillLog;
  end;
end;

function TProdazhaTovaraNForm.FillLog;
var logTovar, logOplata : string;
  i, j, mode : integer;
  str, str1, str2: string;
  paymentFound : boolean;
  nonCashPayTypeVal : Int64;
begin
  Result := '';
  Screen.Cursor := crHourGlass;

  try
    if FIs_spisanie = 1 then begin
      str  := '';
      mode := 2;
    end else begin
      str := lePostavshik.Text;
      case FIs_spisanie of
        0 : mode := 1;
        2 : mode := 3;
        3 : mode := 6;
        4 : mode := 7;
      end;
    end;

    if OpenMode = omInsert then begin
      Result := FillInsWayBill(mode, edDate.Date, edTime.Time, str, edSumm.Value,
        edSummFact.Value, edBonus.Value, edBonusPayed.Value, spZakazTemp);

      if not (FIs_spisanie in [1,3]) then begin
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

      if lePAYMENT_TYPE.EditValue <> 2 then begin
        str2 := lePAYMENT_TYPE.Text;
        nonCashPayTypeVal := 0;
      end else begin
        str2 := leNonCashPayType.Text;
        nonCashPayTypeVal := leNonCashPayType.EditValue;
      end;

      Result := FillUpdWayBill(mode, FRecOld, edDate.Date, edTime.Time, edOsnovanie.Text, lePostavshik.Text, mNote.Text, mAddress.Text,
        edSumm.Value, edSummFact.Value, edBonus.Value, edBonusPayed.Value, edSummPrihod.Value,
        cbByRecipe.Checked, cbReserv.Checked, cbNotMinusOstatok.Checked,
        lePostavshik.EditValue, leStatya.EditValue, nonCashPayTypeVal,
        cbNotMinusOstatok.Caption, leStatya.Text, str2,
        mdNewTovar, mdOldTovar);

      if not (FIs_spisanie in [1,3]) then begin
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

                    logOplata := logOplata + '»зменен "' + str +
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
            logOplata := logOplata + '”дален "' + str +
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
            logOplata := logOplata + 'ƒобавлен "' + str +
              '" платеж от "' + DateToStr(FArrOplata[i].Date) + '" на сумму "' + FloatToStr(FArrOplata[i].Summ) + '".' + CRLF;
        end;

        if logOplata <> '' then begin
          logOplata := 'ѕлатежи.' + CRLF + logOplata;

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

procedure TProdazhaTovaraNForm.Readlist;
var
  AIndex : integer;
begin
  OpenSP(spZakazTemp, True);
  pnRowCnt.Caption := IntToStr(spZakazTemp.RecordCount);
  aUpd.Enabled := spZakazTemp.RecordCount > 0;
  aDel.Enabled := spZakazTemp.RecordCount > 0;
  aOplata.Enabled := (spZakazTemp.RecordCount > 0) or (High(FArrOplata) > 0);
  btnOk.Enabled := spZakazTemp.RecordCount > 0;
  aPrintInvoicePay.Enabled := spZakazTemp.RecordCount > 0;
  aPrintAll.Enabled := spZakazTemp.RecordCount > 0;
  aPrintCur.Enabled := spZakazTemp.RecordCount > 0;

  with tvMain.DataController.Summary do begin
    AIndex := FooterSummaryItems.IndexOfItemLink(clmMainSUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      FSummZakaz := FooterSummaryValues[AIndex]
    else
      FSummZakaz     := 0;
  end;

  edSumm.Value := FSummZakaz;

  if FNotGetDataProcess then begin
    cbPayBonus.checked := False;
    edBonus.Value := spZakazTemp.FieldByName('SUM_TO_CHARGE_BONUS').AsFloat * FBonusPercent;
  end;

  if High(FArrOplata) = 0 then
    edSummFact.Value := edSumm.Value
  else begin
    edSummDolg.Value := edSummFact.Value - edSumm.Value;
  end;
end;


procedure TProdazhaTovaraNForm.FormShow(Sender: TObject);
begin
  riEditRepositoryCurrencyItem := SetColumnDecimalPlaceCur(riEditRepositoryCurrencyItem);
  riEditRepositoryCalcItem := SetColumnDecimalPlace(riEditRepositoryCalcItem);
  tvMain.RestoreFromIniFile('Settings_grid.ini', False, False, [], Self.Name + '-' + tvMain.Name);

  // ќ„»ўјё » ¬–≈ћ≈ЌЌ”ё “јЅЋ»„ ”
  ClearTempTable;
  tsMebelDelivery.TabVisible := False;

  // ставлю невидимыми пол€ св€занные с типом безналичной оплаты
  //SetNonCashPayTypeVisible;

  if (DeliveryService = 0) or (FIs_spisanie <> 0) then
    pnlAddress.Visible := False;

  if FIs_spisanie = 3 then begin
    spPostavshik.ParamByName('G_CLIENT_PARENT_').AsInt64 := -1000
  end else if FIs_spisanie = 4 then begin
    lbClient.Caption := 'ѕоставщик';
    spPostavshik.Filtered := False;
    spPostavshik.Filter := 'is_supplier = 1';
    spPostavshik.Filtered := True;
  end;
  OpenSp(spPaymentType, False);
  OpenSp(spPostavshik, False);
  spPostavshik.Locate('by_default', 1, []);
  lePostavshik.EditValue := spPostavshik.FieldByName('g_client').AsLargeInt;
  //lePostavshikChange(Self);

  // кнопка "ѕлатежи" доступна только при оформлении обычного заказа и возврата товара поставщику
  aOplata.Enabled := False;
  aOplata.Visible := False;
  aPrintInvoicePay.Enabled := False;
  aPrintInvoicePay.Visible := False;
  //кнопка Печать этикеток доступна только при перемещении между складами
  btnPrintEtiket.Enabled := False;
  btnPrintEtiket.Visible := False;

  if Screen.PixelsPerInch = 120 then begin
    lbStatya.Font.Size := 9;
    lbRecalc.Font.Size := 9;
    lbReserv.Font.Size := 9;
  end;

  FedDate := 0;
  FedTime := 0;

  lbReserv.Width := ScaleDimension(398);
  lbRecalc.Width := ScaleDimension(453);
  lbStatya.Width := ScaleDimension(411);

  IF FIs_spisanie = 4 THEN BEGIN
    clmMainDISCOUNT_PERC.Visible := False;
    clmMainDISCOUNT_SUMM.Visible := False;
    pnlBonus.Visible := False;
    tsPrihod.TabVisible := False;
    tsReserv.TabVisible := False;
    tsDop.TabVisible := False;
    btDiscCard.Visible := False;
    Caption := '¬озврат товара поставщику';
    cbByRecipe.Visible := False;
    aOplata.Enabled := True;
    aOplata.Visible := True;
    tsRecalc.TabVisible := False;
    lePAYMENT_TYPE.EditValue := 1;

  END else IF FIs_spisanie in [1,3] THEN BEGIN
    lbPayment.Visible := False;
    ShapePayment.Visible := False;
    ShapePayment1.Visible := False;
    lePAYMENT_TYPE.Visible := False;
    lePAYMENT_TYPE.EditValue := 1;
    clmMainDISCOUNT_PERC.Visible := False;
    clmMainNDS.Visible := False;
    clmMainNDS_SUMM.Visible := False;
    clmMainDISCOUNT_SUMM.Visible := False;
    pnlOplata.Visible := False;
    pnlBonus.Visible := False;
    tsPrihod.TabVisible := False;
    tsReserv.TabVisible := False;
    btDiscCard.Visible := False;
    Panel5.Height := ScaleDimension(50);

    if FIs_spisanie = 1 then begin
      tsDop.TabVisible := False;
      lePostavshik.EditValue := 10;
      CAPTION := '—писание товара';
      lbClient.Visible := False;
      ShapeClient.Visible := False;
      ShapeClient1.Visible := False;
      lePostavshik.Visible := False;
      Height := ScaleDimension(600);
    end else begin
      lbClient.Caption := '—клад-получатель';
      CAPTION := 'ѕеремещение товара';
      Height := ScaleDimension(650);
      btnPrintEtiket.Enabled := True;
      btnPrintEtiket.Visible := True;
      tsRecalc.TabVisible := False;
      lbDraft.Visible := False;
    end;
  end
  else begin
    CAPTION := 'ќформление заказа';
    // при добавлении товара на реал, подставляю клиента на котором стояли в TZakazNaRealListForm
    if FClient <> 0 then begin
      lePostavshik.EditValue := FClient;
      //lePostavshikChange(Self);
    end;

    FSkidka := spPostavshik.FieldByName('skidka').AsFloat;
    spReadStatya.ParamByName('action_').AsInteger := 0;
    OpenSp(spReadStatya, False);

    // если конфигурация аптека, то отражаю специфичную кнопку
    cbByRecipe.Visible := Config = 1;

    //  если конфигурация "Мебельный магазин", то отражаю специфичную вкладку
    tsMebelDelivery.TabVisible := Config = 4;
    if tsMebelDelivery.TabVisible then
      deDeliveryDate.Date := Date;

    aOplata.Enabled := True;
    aOplata.Visible := True;
    aPrintInvoicePay.Enabled := True;
    aPrintInvoicePay.Visible := True;

    lbTovarVPuti.Visible := False;
    cbNotMinusOstatok.Caption := 'Ќе вычитать товары со склада';
  end;

  if FIs_spisanie = 0 then
    tsReserv.TabVisible := True;

  // при реализации нет смысла в этих полях, они нужны для выдачи товара в долг
  if FIs_spisanie = 2 THEN begin
    LabelDoc.Caption := 'Ќомер накладной';
    Panel5.Height := 0;
  end;

  IF OpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
    tsRecalc.TabVisible := False;
    aPrintAll.Enabled := False;
    aPrintCur.Enabled := False;
    btnOk.Enabled := spZakazTemp.RecordCount > 0;
  end {else
    cbPayBonus.Enabled := False};

  GetData;

  if Screen.Height <= 600 then begin
    Height := ScaleDimension(560);
    Panel1.Height := ScaleDimension(490);
    //pcMain.Height := ScaleDimension(270);
    btHelp.Top := ScaleDimension(499);
    btnOk.Top := ScaleDimension(499);
    btnCancel.Top := ScaleDimension(499);
    btnPrintInvoicePay.Top := ScaleDimension(499);
    btnPrintEtiket.Top := ScaleDimension(499);
  end;

  if (CheckPrintDeviceFr = 6) and (PrintOnFr and PrintOnFr) then
  begin
    case Terminal of
      1:
      begin
        spNonCashPayTypes.Filtered := False;
        spNonCashPayTypes.Filter := 'IS_TIS_TYPE>0 AND IS_TIS_TYPE<3';
        spNonCashPayTypes.Filtered := True;
      end;
      2:
      begin
        spNonCashPayTypes.Filtered := False;
        spNonCashPayTypes.Filter := 'IS_TIS_TYPE>=3';
        spNonCashPayTypes.Filtered := True;
      end;
    end;
  end
  else
  begin
    spNonCashPayTypes.Filtered := False;
    spNonCashPayTypes.Filter := '';
  end;
end;

function TProdazhaTovaraNForm.FuncGetLastPrice(GProduct: Int64): Boolean;
begin
  Result := True;

  spGetLastPrice.ParamByName('MODE_').AsIntEGER := 1;
  spGetLastPrice.ParamByName('G_PRODUCT_').AsInt64 := GProduct;
  spGetLastPrice.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
  IF ExecSPTR(spGetLastPrice) THEN
    FCOST_PRICE := spGetLastPrice.ParamByName('price_').AsFloat
  ELSE
    Result := False;
end;

procedure TProdazhaTovaraNForm.aInsExecute(Sender: TObject);
begin
  ProdazhaTovaraForm := TProdazhaTovaraForm.Create(Self);
  try
    ProdazhaTovaraForm.OpenMode := omInsert;
    ProdazhaTovaraForm.Is_spisanie := FIs_spisanie;
    ProdazhaTovaraForm.Skidka := FSkidka;
    ProdazhaTovaraForm.NotMinusOstatok := Integer(cbNotMinusOstatok.Checked);
    IF ProdazhaTovaraForm.ShowModal = mrOK THEN begin
      Readlist;
    END;
    FTovarWasChanged := ProdazhaTovaraForm.TovarInserted;

  finally
    ProdazhaTovaraForm.Free;
  end;
end;

procedure TProdazhaTovaraNForm.aUpdExecute(Sender: TObject);
begin
  if tvMain.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('¬ыберите запись дл€ изменени€!', mtWarning, [mbOK], 0);
    Exit;
  end;

  UpdProdazhaTovaraForm := TUpdProdazhaTovaraForm.Create(Self);
  with UpdProdazhaTovaraForm do begin
    OpenMode := omUpdate;
    RecID := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsLargeInt;
    NotMinusOstatok := Integer(cbNotMinusOstatok.Checked);
    Is_spisanie := FIs_spisanie;
    if (spZakazTemp.FieldByName('is_marked').AsInteger = 1) and (FIs_spisanie = 0) then begin
      UpdProdazhaTovaraForm.MyCurrencyFrameForm.edAmount.Enabled := False;
      UpdProdazhaTovaraForm.MyCurrencyFrameForm.Enabled := False;
    end;

    try
      if UpdProdazhaTovaraForm.ShowModal = mrOK then begin
        Readlist;
        edOsnovanie.ModifiedAfterEnter := True;
        FTovarWasChanged := True;
      end;
    finally
      UpdProdazhaTovaraForm.Free;
    end;
  end;
end;

procedure TProdazhaTovaraNForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  tvMain.Controller.Customization := True;
end;

procedure TProdazhaTovaraNForm.aDelExecute(Sender: TObject);
begin
  if tvMain.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('¬ыберите запись дл€ удалени€!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if MessageDlg(Format('”далить продажу товара "%s" ?',
    [spZakazTemp.FieldByName('PRODUCT_NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  spDel.ParamByName('ZAKAZ_DETAILS_').AsInt64 := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsLargeInt;
  if ExecSP(spDel) then BEGIN
    if spDel.Transaction.InTransaction then
      spDel.Transaction.Commit;
    Readlist;
    edOsnovanie.ModifiedAfterEnter := TRUE;
    FTovarWasChanged := True;
  END;
end;

procedure TProdazhaTovaraNForm.aFindAndInsExecute(Sender: TObject);
var
  ErrCode: Integer;
  ErrMsg : String;
begin

  // –аботает только при перемещении, при продаже надо заморачиватьс€ на маркировку
  if FIs_spisanie = 3 then begin
    spFindProduct.ParamByName('BARCODE_').AsString := KeysBuffer;
    if UseScales = 1 then
      spFindProduct.ParamByName('PREFIX_').AsString := ScalesPrefix
    else
      spFindProduct.ParamByName('PREFIX_').AsString := '';

    try
      if not spFindProduct.Transaction.InTransaction then
        spFindProduct.Transaction.StartTransaction;

      IF ExecSPTR(spFindProduct) THEN begin
        if FuncGetLastPrice(spFindProduct.ParamByName('G_PRODUCT_').AsInt64) = False then begin
          ShowMessage('ѕроизошла ошибка при расчете стоимости товара!');
          Exit;
        end;
        with spInsTmpByBarcode do begin
          ParamByName('G_PRODUCT_').AsInt64 := spFindProduct.ParamByName('G_PRODUCT_').AsInt64;
          ParamByName('AMOUNT_').AsFloat := 1;
          IF UseSelfPriceOnTransfer = 0 THEN BEGIN
            ParamByName('PRICE_').AsFloat := FCOST_PRICE;
            ParamByName('SUMM_').AsFloat := FCOST_PRICE;
          END ELSE BEGIN
            ParamByName('PRICE_').AsFloat := spFindProduct.ParamByName('price_').AsFloat;
            ParamByName('SUMM_').AsFloat := spFindProduct.ParamByName('price_').AsFloat;
          END;

          ParamByName('DISCOUNT_PERC_').AsFloat := 0;
          ParamByName('DISCOUNT_TENGE_').AsFloat := 0;
          ParamByName('DISCOUNT_SUMM_').AsFloat := 0;
          ParamByName('IS_SPISANIE_').AsInteger := FIs_spisanie;
          ParamByName('NEW_LINE_SALE_').AsInteger := NewLineSale;
          ParamByName('COST_PRICE_').AsFloat := FCOST_PRICE;
          ParamByName('MODE_').AsFloat := 1;
          ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
          ParamByName('NOT_MINUS_OSTATOK_').AsInteger := 0;
          ParamByName('USE_SELF_PRICE_ONTRANSFER_').AsInteger := UseSelfPriceOnTransfer;
          ParamByName('mark_code_').AsString := '';
        end;

        if ExecSPTR(spInsTmpByBarcode) then
          Readlist;
      end;
    except
      on E: Exception do
        MessageDlg(E.Message + #13#10'(occured in TSaleModeForm.aFindAndInsExecute)', mtInformation, [mbOk], 0);
    end;

    spFindProduct.ParamByName('BARCODE_').AsString := '';
  end;
end;

procedure TProdazhaTovaraNForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  if ModalResult <> mrOk then
  BEGIN
    if spZakazTemp.RecordCount > 0 then begin
      if MessageDlg('¬ы хотите закрыть окно, не сохранив изменени€.'#13#10'¬ы уверены, что хотите продолжить?',
      mtWarning, [mbYes, mbNo], 0) = mrNo then begin
        CanClose := False;
        Exit;
      end;
    end;

    ClearTempTable;      // ѕќ Ќј∆ј“»ё Ќј  Ќќѕ ” ќ“ћ≈Ќј “ќ∆≈ ќ„»ўјё ¬–≈ћяЌ ”
    if spUpdLock.Transaction.InTransaction then spUpdLock.Transaction.Commit;  //а также снимаю блокировку с записи
    Exit;
  END;
  CanClose := False;

  if (OpenMode = omUpdate) and (not CheckRequizChanged(Self)) then
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

  IF FSuccess THEN    // ќ„»ўјё» ¬–≈ћ≈ЌЌ”ё “јЅЋ»„ ” “ќЋ№ ќ ≈—Ћ» ЅџЋќ ”—ѕ≈ЎЌќ≈ —ќ’–јЌ≈Ќ»≈
    ClearTempTable;

  CanClose := FSuccess;
end;

function TProdazhaTovaraNForm.InsData: Boolean;
begin
  Result := False;
  spIns.ParamByName('is_spisanie_').AsInteger := FIs_spisanie;
  try
    if CallSP(spIns) then
    begin
      RecId := spIns.ParamByName('ZAKAZ_').AsInt64;
      Result := True;
    end
    else
      Exit;
  except
    on E: EFIBError do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.RollbackRetaining;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TProdazhaTovaraNForm.InsData)');
    end;
    on E: Exception do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.RollbackRetaining;
      MessageDlg(E.Message + #13#10'(occured in TProdazhaTovaraNForm.InsData)', mtError, [mbOk], 0);
    end;
  end;
end;

function TProdazhaTovaraNForm.UpdData: Boolean;
begin
  Result := False;
  try
    spUpd.ParamByName('ZAKAZ_').AsInt64 := RecId;

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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TProdazhaTovaraNForm.UpdData)');
    end;
    on E: Exception do begin
      if spUpd.Transaction.InTransaction then
        spUpd.Transaction.RollbackRetaining;
      MessageDlg(E.Message + #13#10'(occured in TProdazhaTovaraNForm.UpdData)', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TProdazhaTovaraNForm.lePostavshikPropertiesChange(Sender: TObject);
begin
  FSkidka := spPostavshik.FieldByName('skidka').AsFloat;
  FSummBonus := spPostavshik.FieldByName('SUMM').AsFloat;
  FBonusPercent := spPostavshik.FieldByName('N_PERCENT').AsFloat/100;
  FMaxBonusPaySumm := spPostavshik.FieldByName('MAX_BONUS_PAY_SUMM').AsFloat;
  edBonusAll.Value := FSummBonus;
  cbPayBonus.Enabled := edBonusAll.Value > 0;

  // ставлю автоматом наличный или безналичный расчет
  if spPostavshik.FieldByName('is_beznal').AsInteger = 1 then
    lePAYMENT_TYPE.EditValue := 2
  else
    lePAYMENT_TYPE.EditValue := 1;

  if FNotGetDataProcess then begin

    //«јѕќЋЌяё —¬≈ƒ≈Ќ»я ѕќ ЅќЌ”—јћ
    cbPayBonus.Checked := False;
    IF FIs_spisanie = 0 THEN begin    //при списании бонусы нафиг не нужны
      edBonus.Value := FSummZakaz * FBonusPercent;
      spUpdZakazDetailsTmpPrices.ParamByName('CLIENT_SKIDKA_').AsFloat := FSkidka;
      spUpdZakazDetailsTmpPrices.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
      ExecSPTR(spUpdZakazDetailsTmpPrices);
      Readlist;
    end;

  end;
end;

procedure TProdazhaTovaraNForm.peDostavshikPropertiesCloseUp(Sender: TObject);
begin
  if FPopupForm.AcceptRes then begin
    peDostavshikTag := FPopupForm.spRead.FieldByName('ID').AsLargeInt;
    (Sender as TcxPopupEdit).Text := FPopupForm.spRead.FieldByName('name').AsString;
    mNote.ModifiedAfterEnter := True;
  end;
end;

procedure TProdazhaTovaraNForm.peDostavshikPropertiesInitPopup(Sender: TObject);
begin
  peDostavshik.DroppedDown := True;
  FPopupForm.arefresh.Execute;
end;

procedure TProdazhaTovaraNForm.aPrintAllExecute(Sender: TObject);
begin
  PrintEtickets(true);
end;

procedure TProdazhaTovaraNForm.aPrintCurExecute(Sender: TObject);
begin
  PrintEtickets(false);
end;

procedure TProdazhaTovaraNForm.PrintEtickets(printAll: boolean);
var
  cbPrinters, edSlogan : STRING;
  cbChooseLentWidth, cbPrintPrice, cbPriceBold, PrinterEtiketok: Integer;
  sePriceSize, cbPrintSlogan, cbSloganBold, seSloganSize : Integer;
  cbNameBold, seNameSize, Sdvig,
  cbPrintArticul, cbArticulBold, seArticulSize : integer;
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
    Sdvig := Ini.ReadInteger('Printetiket', 'Sdvig', 0);
  finally
    Ini.Free;
  end;

  if cbPrinters = '' then begin
    MessageDlg('ѕринтер дл€ печати этикеток не задан!', mtError, [mbOK], 0);
    Exit;
  end;

  if PrinterEtiketok = 1 then begin
    if printAll then begin
        with spZakazTemp do begin
          First;
          while not eof do begin
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
                                Trunc(SimpleRoundTo(FieldByName('amount').asFloat, 0)),
                                0,  //SloganOrPrice,
                                FieldByName('Barcode').AsString,
                                FieldByName('Articul').AsString,
                                FieldByName('NOMENCLATUR').AsString,
                                FieldByName('BRAND').AsString,
                                FieldByName('PRODUCT_NAME').AsString,
                                FieldByName('PRODUCT_PRICE').AsString,
                                FieldByName('G_PRODUCT').AsLargeInt,
                                cbNameBold,
                                seNameSize,
                                Sdvig);
            Next;
          end;
        end;
    end else begin
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
                            Trunc(SimpleRoundTo(spZakazTemp.FieldByName('amount').asFloat, 0)),
                            0,  //SloganOrPrice,
                            spZakazTemp.FieldByName('Barcode').AsString,
                            spZakazTemp.FieldByName('Articul').AsString,
                            spZakazTemp.FieldByName('NOMENCLATUR').AsString,
                            spZakazTemp.FieldByName('BRAND').AsString,
                            spZakazTemp.FieldByName('PRODUCT_NAME').AsString,
                            spZakazTemp.FieldByName('PRODUCT_PRICE').AsString,
                            spZakazTemp.FieldByName('G_PRODUCT').AsLargeInt,
                            cbNameBold,
                            seNameSize,
                            Sdvig);
    end
  end else begin
    // такой навороченный селект пришлось написать, чтобы вытащить именно столько строк, сколько количество
    // товара, столько строк, потому что печать на страницу так работает
    sql_str := 'WITH RECURSIVE TREE AS (SELECT g.name, g.barcode, TRUNC(g.price) PRICE, 1 levl, G.G_PRODUCT' +
                          ' FROM G_PRODUCT g' +
                         ' WHERE EXISTS (SELECT 1' +
                                         ' FROM ZAKAZ_DETAILS_TMP SD' +
                                        ' WHERE SD.g_product = g.g_product)';
    if printAll = False then
      sql_str := sql_str + ' and g.G_PRODUCT = ' + spZakazTemp.FieldByName('g_product').AsString;

    sql_str := sql_str +' UNION ALL' +
                        ' SELECT g.name, g.barcode, TRUNC(g.price) PRICE, gg.levl + 1 levl, G.G_PRODUCT' +
                          ' FROM G_PRODUCT g INNER JOIN TREE GG ON GG.name = g.name' +
                         ' WHERE G.g_product = GG.G_PRODUCT' +
                           ' AND gg.levl < MINVALUE(1000, (SELECT SUM(AMOUNT) FROM ZAKAZ_DETAILS_TMP SDD' + //ћј —»ћ”ћ 1000 Ў“”  «ј –ј«, ¬ »≈–ј–’»„≈— »’ «јѕ–ќ—ј’ ≈—“№ ќ√–јЌ»„≈Ќ»≈ Ќј √Ћ”Ѕ»Ќ” ¬ 1024
                                            ' WHERE SDD.g_product = G.g_product))';
    if printAll = False then
      sql_str := sql_str + ' and g.G_PRODUCT = ' + spZakazTemp.FieldByName('g_product').AsString;

    sql_str := sql_str + ' )'+ ' SELECT * FROM TREE';

    ReportsDM.PrintLabel(cbPrinters,
                          PrinterEtiketok,
                          sql_str,
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
                          0,  //Amount
                          0,  //SloganOrPrice,
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          0,
                          cbNameBold,
                          seNameSize,
                          Sdvig);
  end;
end;

procedure TProdazhaTovaraNForm.grProductDblClick(Sender: TObject);
begin
  aUpd.Execute;
end;

procedure TProdazhaTovaraNForm.ClearTempTable;
begin
  spDel.Params[0].Clear;
  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  ExecSP(spDel);

  if spDel.Transaction.InTransaction then
    spDel.Transaction.Commit;
end;

procedure TProdazhaTovaraNForm.edSummFactPropertiesChange(Sender: TObject);
begin
  edSummFact.Text := StringReplace(edSummFact.Text, ',', '.', [rfReplaceAll]);

  edSummDolg.Value := edSummFact.Value - edSumm.Value + edBonusPayed.Value;

  if High(FArrOplata) = 0 then
    FArrOplata[0].Summ := Min(edSummFact.Value, edSumm.Value);
end;

procedure TProdazhaTovaraNForm.edTimePropertiesChange(Sender: TObject);
begin
  FedTime := edTime.Time;
end;

procedure TProdazhaTovaraNForm.sbEqualSummClick(Sender: TObject);
begin
  edSummFact.Value := edSumm.Value - FSummBonusPayed;
  edSummFact.ModifiedAfterEnter := True;
end;

procedure TProdazhaTovaraNForm.aGetDCardExecute(Sender: TObject);
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

procedure TProdazhaTovaraNForm.cbPayBonusPropertiesChange(Sender: TObject);
var FSummBonusLocal : Double;
begin
  mNote.ModifiedAfterEnter := True;
  IF cbPayBonus.Checked THEN BEGIN
    if FMaxBonusPaySumm <> 100 then begin
      FSummBonusPay      := Min(Round(FSummZakaz * FMaxBonusPaySumm / 100), FSummBonus);
      edBonusPayed.Value := FSummBonusPay;
      edBonusAll.Value   := FSummBonus + FSummBonusPayed - edBonusPayed.Value;
      //edSummFact.Value   := FSummZakaz - edBonusPayed.Value;
    end else begin
      FSummBonusPay    := MIN(FSummBonus + FSummBonusPayed - FSummBonusGot, FSummZakaz); //сумма оплачиваема€ бонусами
      edBonusPayed.Value := FSummBonusPay;
      edBonusAll.Value := MAX(FSummBonus + FSummBonusPayed - FSummZakaz, 0);  //бонусы уже полученные в сохр. заказе € не могу использовать при редактировании этого же заказа
      //edSummFact.Value := Max(FSummZakaz - (FSummBonus + FSummBonusPayed - FSummBonusGot), 0);
    end;
    edSummFact.Value   := FSummZakaz - edBonusPayed.Value;
  END ELSE BEGIN
    FSummBonusPay := 0;
    edBonusPayed.Value := 0;
    edSummFact.Value := FSummZakaz;
    edBonusAll.Value := FSummBonus + FSummBonusPayed;
  end;
end;

procedure TProdazhaTovaraNForm.sbClearClick(Sender: TObject);
begin
  leStatya.EditValue := null;
end;

procedure TProdazhaTovaraNForm.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  if FIs_spisanie = 0 then
    HELPC := 18
  else if FIs_spisanie = 1 then
    HELPC := 19
  else if FIs_spisanie = 2 then
    HELPC := 58
  else
    HELPC := 52;

  Application.HelpContext(HELPC);
end;

procedure TProdazhaTovaraNForm.ceReservChange(Sender: TObject);
begin
  if (cbReserv.Checked = False) then begin
    edSummFact.Value := edSumm.Value - FSummBonusPayed;
    edSummFact.ModifiedAfterEnter := True;
  end;
end;

procedure TProdazhaTovaraNForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if WindowState = wsMaximized then
    SaveSettingsIni('ProdazhaTovaraNaklad', 'WindowState', 1, '')
  else
    SaveSettingsIni('ProdazhaTovaraNaklad', 'WindowState', 0, '');

  tvMain.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvMain.name);
end;

procedure TProdazhaTovaraNForm.FormCreate(Sender: TObject);
//var hSysMenu : HMENU;
begin
  //добавлю свои пункты меню в окно
  {hSysMenu := GetSystemMenu(Handle, False);
  AppendMenu(hSysMenu, MF_SEPARATOR, 0, '');
  AppendMenu(hSysMenu, MF_STRING, 10001, 'Увеличить окно на 20%');
  AppendMenu(hSysMenu, MF_STRING, 10002, 'Уменьшить окно на 20%');}

  //ищу масштаб формы
  if ReadIntSettingsIni('ProdazhaTovaraNaklad', 'WindowState', 0) = 1 then
    WindowState := wsMaximized;//ShowWindowAsync(Handle, SW_MAXIMIZE);
  {
  if FScale = 120 then
    ScaleBigger;}

  // если конфигурация "Мебельный магазин", то создаю попап-форму
  if Config = 4 then
    FPopupForm := TDostavshikPopupForm.Create(Self);
end;

{
если вместе работают wsMaximized и ScaleBigger, то почему-то wsMaximized не работает, уже устал выяснять почему, поэтому пока оставил толко wsMaximized
procedure TProdazhaTovaraNForm.WmSysCommand(var Message: TWMSysCommand);
begin
  if Message.CmdType = 10001 then begin
    // даю масштабировать только на 120 процентов и обратно ибо дальше съезжает все нафиг
    if FScale < 120 then begin
      FScale := FScale + 20;
      ScaleBigger;
    end;
  end else if Message.CmdType = 10002 then begin
    if FScale > 100 then begin
      FScale := FScale - 20;          //чтобы вернуться обратно надо от текуших 100 отнять 20, а текущие 100 это по идее 120 после увеличения
      ScaleSmaller;
    end;
  end else  //обработчик по умолчанию
    DefWindowProc(Handle, Message.Msg, Message.CmdType, 65536 * Message.YPos + Message.XPos);
end;

procedure TProdazhaTovaraNForm.ScaleBigger;
begin
  ChangeScale(FScale, 100);
  edSummFact.Width := edSummDolg.Width; //поле edSummFact становится размером с юпитер, хотя остальные не ведут себя так, поэтому ставлю ей длину соседних полей
  lbTime.Left := shTime.Left + 10;  // а Label8 куда-то улетает, поэтому ставлю ему координату опять же от соседних контролов
end;

procedure TProdazhaTovaraNForm.ScaleSmaller;
begin
  ChangeScale(FScale - 20, 100);
  // а Label8 куда-то улетает, поэтому ставлю ему координату опять же от соседних контролов
  lbTime.Caption := 'Время    ';
  lbTime.Left := edTime.Left-60;
end;
}

procedure TProdazhaTovaraNForm.cb1PropertiesChange(Sender: TObject);
begin
  if (cbReserv.Checked = False) then begin
    edSummFact.Value := edSumm.Value - FSummBonusPayed;
    edSummFact.ModifiedAfterEnter := True;
  end;
end;

procedure TProdazhaTovaraNForm.aRecalcPricesExecute(Sender: TObject);
begin
  spRecalcPrices.ParamByName('date_').AsDate := edDate.Date;
  if ExecSP(spRecalcPrices) then begin
    ShowMessage('ѕересчет цен выполнен успешно!' + #13#10 + 'Ќе забудьте нажать кнопку "—охранить".');
    mNote.ModifiedAfterEnter := true;
  end;
end;

procedure TProdazhaTovaraNForm.aSaveAllToXLSExecute(Sender: TObject);
begin
  if dlgSave.Execute then
    ExportGridToExcel(dlgSave.FileName, gr1, True, True, True, 'xls');
end;

procedure TProdazhaTovaraNForm.aSaveSelectedToXLSExecute(Sender: TObject);
begin
  if dlgSave.Execute then
    ExportGridToExcel(dlgSave.FileName, gr1, True, False, True, 'xls');
end;

procedure TProdazhaTovaraNForm.aOplataExecute(Sender: TObject);
var OplataForm : TOplataForm;
  i: integer;
  mdOldOplata, mdNewOplata: TdxMemData;
begin
  OplataForm := TOplataForm.Create(Self);

  with OplataForm do begin
    try
      SummZakaz := edSumm.Value;
      SummBonusPayed := edBonusPayed.Value;
      PaymentType := lePAYMENT_TYPE.EditValue;
      Helpcc := 82;    // раздел справки
      mdRead.Open;
      for i := 0 to High(FArrOplata) do begin
        mdRead.Insert;
        mdRead.FieldByName('id').AsLargeInt := FArrOplata[i].Id;
        mdRead.FieldByName('Date_Pay').AsDateTime := FArrOplata[i].Date;
        mdRead.FieldByName('Summ_Pay').asFloat := FArrOplata[i].Summ;
        mdRead.FieldByName('Payment_Type').AsLargeInt := FArrOplata[i].Payment;
        if FArrOplata[i].Payment = 1 then
          mdRead.FieldByName('Payment_type_str').AsString := 'Ќаличный'
        else
          mdRead.FieldByName('Payment_type_str').AsString := 'Ѕезналичный'
      end;

      mdOldOplata := TdxMemData.Create(Self);
      mdNewOplata := TdxMemData.Create(Self);
      mdOldOplata.CopyFromDataSet(mdRead);

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

        // если платеж один, то ставлю накладной его способ оплаты, также если платежей несколько, и все они одного способа платежа, то тоже ставлю их способ
        SetPaymentType;

        //вношу изменения в лог, только если были изменения в платежах
        {if (OplataWasChanged) and (OpenMode = omUpdate) then begin
          mdNewOplata.CopyFromDataSet(mdRead);
          mdNewOplata.Open;
          mdOldOplata.Open;
          mdNewOplata.First;
          while not mdNewOplata.Eof do begin
            if mdOldOplata.Locate('Id', mdNewOplata.FieldByName('Id').AsLargeInt, []) = false then
              FLogOplata := FLogOplata + 'Добавлен платеж "' + mdNewOplata.FieldByName('Payment_type_str').AsString + '", дата "' +
                mdNewOplata.FieldByName('Date_Pay').AsString + '", сумма "' + mdNewOplata.FieldByName('summ_pay').AsString + '".' + CRLF

            else begin
              if (mdNewOplata.FieldByName('Payment_type_str').AsString <> mdOldOplata.FieldByName('Payment_type_str').AsString) or
              (mdNewOplata.FieldByName('Date_Pay').AsDateTime <> mdOldOplata.FieldByName('Date_Pay').AsDateTime) or
              (mdNewOplata.FieldByName('summ_pay').AsFloat <> mdOldOplata.FieldByName('summ_pay').AsFloat) then begin
                FLogOplata := FLogOplata + 'Изменен "' + mdOldOplata.FieldByName('Payment_type_str').AsString +
                  '" платеж от "' + mdOldOplata.FieldByName('Date_Pay').AsString + '":' + CRLF;

                if mdNewOplata.FieldByName('Payment_type_str').AsString <> mdOldOplata.FieldByName('Payment_type_str').AsString then
                  FLogOplata := FLogOplata + '- способ c "' + mdOldOplata.FieldByName('Payment_type_str').AsString + '" на "' + mdNewOplata.FieldByName('Payment_type_str').AsString + '";' + CRLF;
                if mdNewOplata.FieldByName('Date_Pay').AsDateTime <> mdOldOplata.FieldByName('Date_Pay').AsDateTime then
                  FLogOplata := FLogOplata + '- дата c "' + mdOldOplata.FieldByName('Date_Pay').AsString + '" на "' + mdNewOplata.FieldByName('Date_Pay').AsString + '";' + CRLF;
                if mdNewOplata.FieldByName('summ_pay').AsFloat <> mdOldOplata.FieldByName('summ_pay').AsFloat then
                  FLogOplata := FLogOplata + '- сумма c "' + mdOldOplata.FieldByName('summ_pay').AsString + '" на "' + mdNewOplata.FieldByName('summ_pay').AsString + '";' + CRLF;
              end;
            end;
            mdNewOplata.Next;
          end;

          mdOldOplata.First;
          while not mdOldOplata.Eof do begin
            if mdNewOplata.Locate('id', mdOldOplata.FieldByName('id').AsLargeInt, []) = false then
              FLogOplata := FLogOplata + 'Удален платеж "' + mdNewOplata.FieldByName('Payment_type_str').AsString + '", дата "' +
                mdNewOplata.FieldByName('Date_Pay').AsString + '", сумма "' + mdNewOplata.FieldByName('summ_pay').AsString + '".' + CRLF;

            mdOldOplata.Next;
          end;
          mdNewOplata.Close;
          mdNewOplata.Close;

          if FLogOplata <> ' ' then
            FLogOplata := CRLF + 'Платежи.' + CRLF + FLogOplata;
        end;}

        mNote.ModifiedAfterEnter := true;
      end;
    finally
      Free;
      mdOldOplata.Free;
      mdNewOplata.Free;
    end;
  end;
end;

procedure TProdazhaTovaraNForm.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
  procedure ClearBuffer;
  begin
    if MilliSecondsBetween(Now, LastDateForAddedKey) > 200 then
    begin
      // при медленном вводе буфер очищ€етс€, т.к. скан идет "мгновенно"
      KeysBuffer := '';
    end;
  end;
begin
  // обработка штрих-кодов
  // автор: jaydi85@gmail.com

  // данные считываем на WM_CHAR
  // Ќќ  Ћј¬»Ў” ЁЌ“≈– на WM_KEYDOWN
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
            KeysBuffer := '';
          end;
        end
      end;

      // сохран€ем ввод
      if Msg.message = WM_CHAR then
      begin
        ClearBuffer;
        if Msg.wParam <> 13 then
        begin
          // нажали что-то другое (надо отбросить вс€кие шифты и контролы)
          KeysBuffer := KeysBuffer + Chr(Msg.wParam);
          LastDateForAddedKey := Now;
        end;
      end;
    END;
  END;
end;

procedure TProdazhaTovaraNForm.aPrintInvoicePayExecute(Sender: TObject);
var
  AIndex : integer;
begin
  if OpenMode = omInsert then begin
    ReportsDM.PrepareReport(50);
    ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
    ReportsDM.spReport.ParamByName('G_CLIENT_').AsInt64 := lePostavshik.EditValue;
    ReportsDM.spReport.ParamByName('AGREEMENT_IN_').AsString := edOsnovanie.Text;
    ReportsDM.spReport.ParamByName('summ_in_').AsFloat := edSumm.Value;
    ReportsDM.spReport.ParamByName('DATE_').AsDate := edDate.Date;
    ReportsDM.spReport.ParamByName('AMOUNT_IN_').AsInteger := tvMain.ViewData.RowCount;

    with tvMain.DataController.Summary do begin
      AIndex := FooterSummaryItems.IndexOfItemLink(clmMainNDS_SUMM);
      if not VarIsNull(FooterSummaryValues[AIndex]) then
        ReportsDM.spReport.ParamByName('NDS_SUMM_IN_').AsFloat := FooterSummaryValues[AIndex]
      else
        ReportsDM.spReport.ParamByName('NDS_SUMM_IN_').AsFloat := 0;
    end;

    ReportsDM.ShowReport(1, '');
  end else begin
    InvoicePayForm := TInvoicePayForm.Create(Self);
    try
      if FInvoicePay <> 0 then
        InvoicePayForm.RecID := FInvoicePay
      else
        InvoicePayForm.NotSaved := 1;

      InvoicePayForm.Zakaz := RecId;
      InvoicePayForm.OpenMode := omUpdate;
      InvoicePayForm.ShowModal;

      // не помню зачем сюда доабвил Readlist, но в следствие этого станов€тс€ доступны кнопки
      // даже если у пользовател€ нет прав
      ReadList;

      if (OpenMode = omUpdate) and (
      ((HaveRightUpdSale = False) and (FIs_spisanie = 0)) OR
      ((HaveRightUpdSpisanie = False) and (FIs_spisanie = 1)) OR
      ((HaveRightUpdMove = False) and (FIs_spisanie = 3))
      ) then begin
        DisableControls;
      end;
    finally
      InvoicePayForm.Free;
    end;
  end;
end;

procedure TProdazhaTovaraNForm.EnableSummFact;
begin
  edSummFact.Enabled := High(FArrOplata) = 0;
  sbEqualSumm.Enabled := High(FArrOplata) = 0;
end;

procedure TProdazhaTovaraNForm.SetArrOplataSumm;
begin
  if High(FArrOplata) = 0 then begin
    FArrOplata[0].Date := edDate.Date;
    FArrOplata[0].Payment := lePAYMENT_TYPE.EditValue;
    FArrOplata[0].Summ := edSummFact.Value;
  end;
end;

procedure TProdazhaTovaraNForm.SetNonCashPayTypeVisible;
begin
  if lePAYMENT_TYPE.EditValue = 2 then begin
    if spNonCashPayTypes.Active = False then begin
      OpenSp(spNonCashPayTypes, False);
      leNonCashPayType.EditValue := 1;
    end;
  end;

  lbNonCashPayType.Visible := lePAYMENT_TYPE.EditValue = 2;
  shpNonCashPayType.Visible := lePAYMENT_TYPE.EditValue = 2;
  shpNonCashPayType1.Visible := lePAYMENT_TYPE.EditValue = 2;
  leNonCashPayType.Visible := lePAYMENT_TYPE.EditValue = 2;

  if leNonCashPayType.Visible = false then begin
    lbNote.Top := lbNote.Top - shpNonCashPayType.Height;
    ShapeNote.Top := shpNonCashPayType.Top;
    ShapeNote1.Top := shpNonCashPayType1.Top;
    mNote.Top := leNonCashPayType.Top;

    pnlTop.Height := pnlTop.Height - shpNonCashPayType.Height;
  end
  else begin
    lbNote.Top := lbNote.Top + (lbNonCashPayType.Top - lbPayment.Top);
    ShapeNote.Top := ShapeNote.Top + (lbNonCashPayType.Top - lbPayment.Top);
    ShapeNote1.Top := ShapeNote1.Top + (lbNonCashPayType.Top - lbPayment.Top);
    mNote.Top := mNote.Top + (lbNonCashPayType.Top - lbPayment.Top);

    pnlTop.Height := pnlTop.Height + shpNonCashPayType.Height;
  end;

end;

procedure TProdazhaTovaraNForm.edDatePropertiesChange(Sender: TObject);
begin
  FedDate := edDate.Date;

  if High(FArrOplata) = 0 then
    FArrOplata[0].Date := edDate.Date;
end;

procedure TProdazhaTovaraNForm.lePAYMENT_TYPEPropertiesChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Payment := lePAYMENT_TYPE.EditValue;

  SetNonCashPayTypeVisible;
end;

procedure TProdazhaTovaraNForm.SetPaymentType;
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

procedure TProdazhaTovaraNForm.tvMainCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  aUpd.Execute;
end;

end.