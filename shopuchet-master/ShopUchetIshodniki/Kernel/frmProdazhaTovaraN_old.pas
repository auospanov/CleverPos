unit frmProdazhaTovaraN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, dxExEdtr, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, dxEdLib, dxCntner,
  dxEditor, dxDBEdtr, dxDBELib, dxTL, dxDBCtrl, dxDBGrid, ExtCtrls,
  DB, ActnList, frmDBEdit, unCommonFunc, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase, FIB,
  AppEvnts, cxSpinEdit, cxTimeEdit, Math, IniFiles, cxPC, cxCheckBox;

type
  TRecOplata = record
    Id: Integer;
    Date: TDate;
    Summ  : Double;
    Payment: Integer;
  end;
  TArrOplata = Array of TRecOplata;

  TProdazhaTovaraNForm = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    dsPostavshik: TDataSource;
    dsPaymentType: TDataSource;
    dsZakazTemp: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    ActionList: TActionList;
    aRefreshOfficialRights: TAction;
    aShowWhoLockRecord: TAction;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    tranRead: TpFIBTransaction;
    spPostavshik: TpFIBDataSet;
    spPaymentType: TpFIBDataSet;
    spZakazTemp: TpFIBDataSet;
    spDel: TpFIBStoredProc;
    spGetData: TpFIBStoredProc;
    spIns: TpFIBStoredProc;
    spUpd: TpFIBStoredProc;
    tranWrite: TpFIBTransaction;
    spReadStatya: TpFIBDataSet;
    dsReadStatya: TDataSource;
    aGetDCard: TAction;
    spUpdLock: TpFIBStoredProc;
    btHelp: TBitBtn;
    pn1: TPanel;
    Label7: TLabel;
    Shape12: TShape;
    LabelDoc: TLabel;
    Shape14: TShape;
    lbClient: TLabel;
    ShapeClient: TShape;
    lbPayment: TLabel;
    ShapePayment: TShape;
    lbNote: TLabel;
    ShapeNote: TShape;
    edDate: TcxDateEdit;
    Shape13: TShape;
    lbTime: TLabel;
    shTime: TShape;
    edTime: TcxTimeEdit;
    Shape15: TShape;
    Shape16: TShape;
    edOsnovanie: TdxEdit;
    ShapeClient1: TShape;
    lePostavshik: TdxLookupEdit;
    btDiscCard: TBitBtn;
    lePAYMENT_TYPE: TdxLookupEdit;
    ShapePayment1: TShape;
    mNote: TMemo;
    ShapeNote1: TShape;
    aBiggerScale: TAction;
    aSmallerScale: TAction;
    pcMain: TcxPageControl;
    tsCommon: TcxTabSheet;
    Panel4: TPanel;
    BitBtn10: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn9: TBitBtn;
    pnRowCnt: TPanel;
    grProduct: TdxDBGrid;
    grProductPRODUCT_NAME: TdxDBGridMaskColumn;
    grProductSKLAD: TdxDBGridMaskColumn;
    grProductG_PRODUCT: TdxDBGridMaskColumn;
    grProductAMOUNT: TdxDBGridMaskColumn;
    grProductPRICE: TdxDBGridMaskColumn;
    grProductDISCOUNT_PERC: TdxDBGridColumn;
    grProductSUMM: TdxDBGridMaskColumn;
    grProductNDS: TdxDBGridMaskColumn;
    grProductNDS_SUMM: TdxDBGridMaskColumn;
    grProductDISCOUNT_SUMM: TdxDBGridColumn;
    Panel5: TPanel;
    pnlOplata: TPanel;
    Shape5: TShape;
    Shape3: TShape;
    Label3: TLabel;
    Label5: TLabel;
    Shape6: TShape;
    Shape4: TShape;
    sbEqualSumm: TSpeedButton;
    edSummDolg: TdxCurrencyEdit;
    edSummFact: TdxCurrencyEdit;
    pnlBonus: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    lb1: TLabel;
    edBonus: TdxCurrencyEdit;
    edBonusAll: TdxCurrencyEdit;
    edBonusPayed: TdxCurrencyEdit;
    Panel3: TPanel;
    Shape7: TShape;
    Label4: TLabel;
    Shape8: TShape;
    edSumm: TdxCurrencyEdit;
    tsPrihod: TcxTabSheet;
    lbStatya: TLabel;
    leStatya: TdxLookupEdit;
    sbClear: TSpeedButton;
    edSummPrihod: TdxCurrencyEdit;
    cbByRecipe: TcxCheckBox;
    tsReserv: TcxTabSheet;
    cbReserv: TcxCheckBox;
    lbReserv: TLabel;
    aRecalcPrices: TAction;
    spRecalcPrices: TpFIBStoredProc;
    aOplata: TAction;
    btnOplata: TBitBtn;
    cbPayBonus: TcxCheckBox;
    tsRecalc: TcxTabSheet;
    btnIns: TBitBtn;
    lbRecalc: TLabel;
    procedure FormShow(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lePostavshikChange(Sender: TObject);
    procedure grProductDblClick(Sender: TObject);
    procedure edSummFactChange(Sender: TObject);
    procedure sbEqualSummClick(Sender: TObject);
    procedure aGetDCardExecute(Sender: TObject);
    procedure cbPayBonusClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure ceReservChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cb1PropertiesChange(Sender: TObject);
    procedure aRecalcPricesExecute(Sender: TObject);
    procedure aOplataExecute(Sender: TObject);
    procedure edDatePropertiesChange(Sender: TObject);
    procedure lePAYMENT_TYPEChange(Sender: TObject);
  private
    FArrOplata  : TArrOplata;
    FRecID      : Integer;
    FOpenMode   : TOpenMode;
    FSuccess    : Boolean;
    FClient     : Integer;   // при добавлении товара на реал в TZakazNaRealListForm, если стоят на каком-то клиенте, он подставляется автоматом
    FIs_spisanie : Integer; // 0 - обычный заказ, 1 - списание товара, 2 - выдача под реализацию
    FSkidka  : Double;       // скидка клиента при покупке
    FSummZakaz : Double;       // сумма заказа
    FBonusPercent : Double;    // процент бонуса от суммы заказа
    FSummBonus : Double;       // сумма накопленного бонуса за все время
    FSummBonusPay : Double;       // сумма бонуса, оплачеваемого за данный заказ
    FSummBonusPayed : Double;     // сумма оплаченная бонусом, в уже сохраненном заказе
    FSummBonusGot : Double;       // сумма полученных бонусов, в уже сохраненном заказе
    FScale : Integer;         //масштаб формы
    function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean;
    function ExecSP(SP: TpFIBStoredProc): Boolean;
    function CheckParams(var ErrControl: TWinControl): Boolean;
    procedure SetParams(SP: TpFIBStoredProc);
    procedure SetArrOplataSumm;
    procedure EnableSummFact;
    procedure SetPaymentType;
  protected
    //function IsRecLocked: Boolean;
    //procedure ShowWhoLockRec;
    function CallSP(SP: TpFIBStoredProc): Boolean;
    function InsData: Boolean;
    function UpdData: Boolean;
    procedure GetData;
    procedure ClearTempTable;
    procedure DisableControls;
    {если вместе работают wsMaximized и ScaleBigger, то почему-то wsMaximized не работает, уже устал выяснять почему, поэтому пока оставил толко wsMaximized
    procedure WmSysCommand(var Message: TWMSysCommand); message WM_SysCommand;
    procedure ScaleBigger;
    procedure ScaleSmaller;}
  public
    property OpenMode: TOpenMode read FOpenmode write FOpenMode default omView;
    property Success: Boolean read FSuccess write FSuccess default False;
    property Client: Integer read FClient write FClient default 0;
    property RecID: Integer read FRecID write FRecID default 0;
    property Is_spisanie: Integer read FIs_spisanie write FIs_spisanie default 0;  // 0 - ОБЫЧНАЯ ПРОДАЖА, 1 - СПИСАНИЕ, 2 - ВЫДАЧА ТОВАРА ПОД РЕАЛИЗАЦИЮ
    procedure Readlist;
  end;

var
  ProdazhaTovaraNForm: TProdazhaTovaraNForm;

implementation

uses unErrorHandlers, frmZakupkaTovara, frmUpdZakupkaTovara,
  frmProdazhaTovara, frmUpdProdazhaTovara, frmGetDCard, frmOplata;

{$R *.dfm}
function TProdazhaTovaraNForm.OpenSP(SP: TpFIBDataSet;
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
                 + #13#10'(occured in TDBDlgForm.OpenSP)', mtInformation, [mbOK], 0);
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
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBDlgForm.OpenSP)');
    end;
    on E: Exception do begin
      if SP.Transaction.InTransaction then
        SP.Transaction.CommitRetaining;
      MessageDlg(E.Message + #13#10'(occured in TDBDlgForm.OpenSP)', mtError, [mbOk], 0);
    end;
  end;
end;

function TProdazhaTovaraNForm.ExecSP(SP: TpFIBStoredProc): Boolean;
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
        END else
          MessageDlg('Ошибка № ' + IntToStr(E.SQLCode) + ':' + E.Message +  #13#10 + 'Ошибка при блокировке записи', mtError, [mbOk], 0);
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
             + #13#10'(occured in TDlgForm.CallSP)', mtInformation, [mbOK], 0);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

function TProdazhaTovaraNForm.CallSP(SP: TpFIBStoredProc): Boolean;
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
  btnOk.Enabled := FALSE;
end;

procedure TProdazhaTovaraNForm.GetData;
var OnChange, OnClick : TNotifyEvent;
    p, i : integer;
    str, str1 : string;
begin
  //if FOpenMode in [omView, omUpdate, omInsertLike] then    теперь Getdata вызывается всегда
  begin
    try
      spGetData.ParamByName('zakaz_').AsInteger := FRecID;
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

  if FOpenMode <> omInsert then BEGIN
    with spGetData do begin
      edDate.Date := ParamByName('Z_DATE_').AsDate;
      edTime.Time := ParamByName('Z_time_').AsTime;
      lePostavshik.LookupKeyValue := ParamByName('G_CLIENT_').AsInteger;
      lePostavshikChange(Self);
      lePAYMENT_TYPE.LookupKeyValue := ParamByName('G_PAYMENT_TYPE_').AsInteger;
      edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
      mNote.Text := ParamByName('note_').AsString;
      edSumm.Value := ParamByName('summ_').AsFloat;
      leStatya.LookupKeyValue := ParamByName('G_PRIHOD_').AsInteger;
      edSummPrihod.Value := ParamByName('SUMM_PRIHOD_').AsFloat;
      OnChange := edSummFact.OnChange;
      edSummFact.OnChange := nil;
      Readlist;
      FSummBonusPayed := ParamByName('SUMM_PAY_BONUS_').AsFloat;
      FSummBonusGot := ParamByName('SUMM_GOT_BONUS_').AsFloat;

      if FSummBonusPayed > 0 then begin
        OnClick := cbPayBonus.OnClick;
        cbPayBonus.OnClick := nil;
        cbPayBonus.Checked := True;
        cbPayBonus.OnClick := OnClick;
        FSummBonusPay := FSummBonusPayed;
        edBonusPayed.Value := FSummBonusPay;
      end;
      edSummFact.Value := ParamByName('summ_fact_').AsFloat;
      edSummDolg.Value := (edSummFact.Value + FSummBonusPayed) - edSumm.Value;
      edSummFact.OnChange := OnChange;

      cbByRecipe.checked := ParamByName('by_recipe_').AsInteger = 1;
      cbReserv.checked   := ParamByName('IS_RESERVE_').AsInteger = 1;

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
  END;

  if High(FArrOplata) = -1 then begin
    SetLength(FArrOplata, 1);
    FArrOplata[0].Date := Date;
    FArrOplata[0].Payment := 1;
  end;
  EnableSummFact;  // выключаю edSummFact, если есть больше одного платежа

  if (HaveRightUpdSale = False) and (FIs_spisanie = 0) AND (OpenMode = omUpdate) then begin
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
    MessageDlg('Программа не зарегистрирована.' + #10#13 + 'Включены ограничения на количество продаж!', mtWarning, [mbOk], 0);
    DisableControls;
    EXIT;
  END;

  if FOpenMode = omView then
    PostMessage(Self.Handle, WM_READONLYCONTROLS, 0, 0)

  // блокирую запись
  else if FOpenMode = omUpdate then begin
    spUpdLock.ParamByName('id_').AsInteger := RecId;
    spUpdLock.ParamByName('TABLE_NAME_').AsString := 'zakaz';

    if not spUpdLock.Transaction.InTransaction then   //ТРАНЗАКЦИЯ ЗАКОММИТИТЬСЯ, ЕСЛИ КЛИЕНТ НАЖМЕТ КНОПКУ ОК, ИЛИ ОТРОЛЛБАЧИТЬСЯ, ЕСЛИ БУДЕТ ОШИБКА ИЛИ НАЖМУТ КНОПКУ ОТМЕНА
      spUpdLock.Transaction.StartTransaction;
    if not ExecSP(spUpdLock) then begin
      DisableControls;
      EXIT;
    end;
  end;
end;

function TProdazhaTovaraNForm.CheckParams(var ErrControl: TWinControl): Boolean;
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

  if FOpenMode = omInsert then begin
    if (edSummPrihod.Value > 0) and (leStatya.Text = '') then begin
      pcMain.ActivePage := tsPrihod;
      ErrControl := leStatya;
      MessageDlg('Статья прихода не указана.', mtInformation, [mbOK], 0);
      Exit;
    end;

    if (edSummPrihod.Value = 0) and (leStatya.Text <> '') then begin
      pcMain.ActivePage := tsPrihod;
      ErrControl := edSummPrihod;
      MessageDlg('Сумма прихода не указана.', mtInformation, [mbOK], 0);
      Exit;
    end;
  end;

  IF (FIs_spisanie = 2) AND (lePostavshik.LookupKeyValue = 0) then begin
    ErrControl := lePostavshik;
    MessageDlg('Клиент не выбран!', mtInformation, [mbOK], 0);
    Exit;
  end;

  IF (FIs_spisanie = 2) AND (lePostavshik.LookupKeyValue = 0) then begin
    ErrControl := lePostavshik;
    MessageDlg('Клиент не выбран!', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TProdazhaTovaraNForm.SetParams(SP: TpFIBStoredProc);
var
  i : integer;
  StrArr : string;
begin
  with SP do begin
    ParamByName('Z_DATE_').AsDate := edDate.Date;
    ParamByName('Z_TIME_').AsTime := edTime.Time;
    if lePostavshik.LookupKeyValue > 0 then
      ParamByName('G_CLIENT_').AsInteger := lePostavshik.LookupKeyValue
    else
      ParamByName('G_CLIENT_').AsInteger := 10;
    if lePAYMENT_TYPE.LookupKeyValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInteger := lePAYMENT_TYPE.LookupKeyValue
    else
      ParamByName('G_PAYMENT_TYPE_').AsInteger := 1;  // по умолчанию поставлю наличный расчет, если клиент вдруг ничего не выбрал
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('summ_').AsFloat := edSumm.Value;
    ParamByName('summ_fact_').AsFloat := edSummFact.Value;
    ParamByName('by_recipe_').AsInteger := Integer(cbByRecipe.checked);
    ParamByName('IS_RESERVE_').AsInteger := Integer(cbReserv.checked);
    IF (leStatya.LookupKeyValue <> 0) and (leStatya.LookupKeyValue <> null) THEN
      ParamByName('g_prihod_').AsInteger := leStatya.LookupKeyValue;
    ParamByName('summ_prihod_').AsFloat := edSummPrihod.Value;
    IF cbPayBonus.Checked THEN
      ParamByName('summ_bonus_').AsFloat := FSummBonusPay  //ЕСЛИ БОНУСОВ БОЛЬШЕ ЧЕМ СУММА ЗАКАЗА, ТО ПОДСТАВЛЯЮ СУММУ ЗАКАЗА, ИНАЧЕ - ПОДСТАВЛЯЮ СУММУ БОНУСОВ
    else
      ParamByName('summ_bonus_').AsFloat := 0;
    ParamByName('summ_bonus_got_').AsFloat := edBonus.Value;            //ПЕРЕДАЮ СУММУ НАЧИСЛЕННЫХ БОНУСОВ ЗА ЗАКАЗ

    ParamByName('IS_SPISANIE_').AsInteger := FIs_spisanie;

    IF (High(FArrOplata) > 0) or (OpenMode = omUpdate) then begin
      for i := 0 to High(FArrOplata) do
        StrArr := StrArr + IntToStr(FArrOplata[i].Id) + '-' + DateToStr(FArrOplata[i].Date) + '-' + FloatToStr(FArrOplata[i].Summ) + '-' + IntToStr(FArrOplata[i].Payment)+ '~';

      StrArr := StringReplace(StrArr, ',', '.', [rfReplaceAll, rfIgnoreCase]);   //заменяю на всякий случай запятые на точки
      ParamByName('PAYMENTS_').AsString := StrArr;
    end;
  end;
end;

procedure TProdazhaTovaraNForm.Readlist;
begin
  OpenSP(spZakazTemp, True);
  pnRowCnt.Caption := IntToStr(spZakazTemp.RecordCount);
  aUpd.Enabled := spZakazTemp.RecordCount > 0;
  aDel.Enabled := spZakazTemp.RecordCount > 0;
  aOplata.Enabled := (spZakazTemp.RecordCount > 0) or (High(FArrOplata) > 0);
  btnOk.Enabled := spZakazTemp.RecordCount > 0;
  FSummZakaz := StrToFloat(grProduct.ColumnByFieldName('summ').SummaryFooterText);
  edSumm.Value := FSummZakaz;
  cbPayBonus.checked := False;
  edBonus.Value := FSummZakaz * FBonusPercent;

  if High(FArrOplata) = 0 then
    edSummFact.Value := edSumm.Value
  else begin
    edSummDolg.Value := edSumm.Value - edSummFact.Value;
  end;
end;


procedure TProdazhaTovaraNForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
  windowSt : integer;
begin
  if FIs_spisanie in [1,3] then
    grProduct.RegistryPath := '\Software\ShopUchet\ProdazhaTovaraSpis'
  else
    grProduct.RegistryPath := '\Software\ShopUchet\ProdazhaTovaraNakl';

  // ОЧИЩАЮ И ВРЕМЕННУЮ ТАБЛИЧКУ
  ClearTempTable;

  if FIs_spisanie = 3 then
    spPostavshik.ParamByName('G_CLIENT_PARENT_').AsInteger := -1000
  else if FIs_spisanie = 4 then begin
    spPostavshik.Filtered := False;
    spPostavshik.Filter := 'is_supplier = 1';
    spPostavshik.Filtered := True;
  end;
  OpenSp(spPaymentType, False);
  OpenSp(spPostavshik, False);
  spPostavshik.Locate('by_default', 1, []);
  lePostavshik.LookupKeyValue := spPostavshik.FieldByName('g_client').AsInteger;
  lePostavshikChange(Self);

  // кнопка "Платежи" доступна только при оформлении обычного заказа и возврата товара поставщику
  aOplata.Enabled := False;
  aOplata.Visible := False;

  lbReserv.Width := ScaleDimension(573);
  lbRecalc.Width := ScaleDimension(588);
  lbStatya.Width := ScaleDimension(540);

  IF FIs_spisanie = 4 THEN BEGIN
    grProductDISCOUNT_PERC.Visible := False;
    grProductDISCOUNT_SUMM.Visible := False;
    pnlBonus.Visible := False;
    tsPrihod.TabVisible := False;
    tsReserv.TabVisible := False;
    btDiscCard.Visible := False;
    Caption := 'Возврат товара поставщику';
    cbByRecipe.Visible := False;
    aOplata.Enabled := True;
    aOplata.Visible := True;

  END else IF FIs_spisanie in [1,3] THEN BEGIN
    lbPayment.Visible := False;
    ShapePayment.Visible := False;
    ShapePayment1.Visible := False;
    lePAYMENT_TYPE.Visible := False;
    lePAYMENT_TYPE.LookupKeyValue := 1;
    grProductDISCOUNT_PERC.Visible := False;
    grProductNDS.Visible := False;
    grProductNDS_SUMM.Visible := False;
    grProductDISCOUNT_SUMM.Visible := False;
    pnlOplata.Visible := False;
    pnlBonus.Visible := False;
    tsPrihod.TabVisible := False;
    tsReserv.TabVisible := False;
    btDiscCard.Visible := False;
    Panel5.Height := ScaleDimension(50);

    if FIs_spisanie = 1 then begin
      lePostavshik.LookupKeyValue := 10;
      CAPTION := 'Списание товара';
      lbClient.Visible := False;
      ShapeClient.Visible := False;
      ShapeClient1.Visible := False;
      lePostavshik.Visible := False;
      Height := ScaleDimension(600);
    end else begin
      lbClient.Caption := 'Склад-получатель';
      Height := ScaleDimension(650);
    end;
  end
  else begin
    CAPTION := 'Оформление заказа';
    // при добавлении товара на реал, подставляю клиента на котором стояли в TZakazNaRealListForm
    if FClient <> 0 then begin
      lePostavshik.LookupKeyValue := FClient;
      lePostavshikChange(Self);
    end;

    FSkidka := spPostavshik.FieldByName('skidka').AsFloat;
    spReadStatya.ParamByName('action_').AsInteger := 0;
    OpenSp(spReadStatya, False);

    // если конфигурация аптека, то отражаю специфичную кнопку
    if Config = 1 then
      cbByRecipe.Visible := True
    else
      cbByRecipe.Visible := False;

    aOplata.Enabled := True;
    aOplata.Visible := True;
  end;

  // при реализации нет смысла в этих полях, они нужны для выдачи товара в долг
  if FIs_spisanie = 2 THEN begin
    LabelDoc.Caption := 'Номер накладной';
    Panel5.Height := 0;
  end;

  GetData;

  IF FOpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
    tsRecalc.TabVisible := False;
    btnOk.Enabled := spZakazTemp.RecordCount > 0;
  end {else
    cbPayBonus.Enabled := False};

  with grProduct do
    ShowSummaryFooter := True;
end;

procedure TProdazhaTovaraNForm.aInsExecute(Sender: TObject);
begin
  ProdazhaTovaraForm := TProdazhaTovaraForm.Create(Self);
  try
    ProdazhaTovaraForm.OpenMode := omInsert;
    ProdazhaTovaraForm.Is_spisanie := FIs_spisanie;
    ProdazhaTovaraForm.Skidka := FSkidka;
    IF ProdazhaTovaraForm.ShowModal = mrOK THEN begin
      Readlist;
    END;
  finally
    ProdazhaTovaraForm.Free;
  end;
end;

procedure TProdazhaTovaraNForm.aUpdExecute(Sender: TObject);
begin
  UpdProdazhaTovaraForm := TUpdProdazhaTovaraForm.Create(Self);
  with UpdProdazhaTovaraForm do begin
    OpenMode := omUpdate;
    RecID := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsInteger;
    Is_spisanie := FIs_spisanie;
    try
      if UpdProdazhaTovaraForm.ShowModal = mrOK then begin
        Readlist;
        edOsnovanie.Modified := True;
      end;
    finally
      UpdProdazhaTovaraForm.Free;
    end;
  end;
end;

procedure TProdazhaTovaraNForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить продажу товара "%s" ?',
    [spZakazTemp.FieldByName('PRODUCT_NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  spDel.ParamByName('ZAKAZ_DETAILS_').AsInteger := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsInteger;
  if ExecSP(spDel) then BEGIN
    if spDel.Transaction.InTransaction then
      spDel.Transaction.Commit;
    Readlist;
    edOsnovanie.Modified := TRUE;
  END;
end;

procedure TProdazhaTovaraNForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  if ModalResult <> mrOk then BEGIN
    ClearTempTable;      // ПО НАЖАТИЮ НА КНОПКУ ОТМЕНА ТОЖЕ ОЧИЩАЮ ВРЕМЯНКУ
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

  if FOpenMode in [omInsert, omInsertLike, omInsertChild] then
    FSuccess := InsData
  else if FOpenMode = omUpdate then
    FSuccess := UpdData;

  IF FSuccess THEN    // ОЧИЩАЮИ ВРЕМЕННУЮ ТАБЛИЧКУ ТОЛЬКО ЕСЛИ БЫЛО УСПЕШНОЕ СОХРАНЕНИЕ
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
      FRecId := spIns.ParamByName('ZAKAZ_').AsInteger;
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
    spUpd.ParamByName('ZAKAZ_').AsInteger := FRecId;

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

procedure TProdazhaTovaraNForm.lePostavshikChange(Sender: TObject);
begin
  FSkidka := spPostavshik.FieldByName('skidka').AsFloat;
  // ставлю автоматом наличный или безналичный расчет
  if spPostavshik.FieldByName('is_beznal').AsInteger = 1 then
    lePAYMENT_TYPE.LookupKeyValue := 2
  else
    lePAYMENT_TYPE.LookupKeyValue := 1;

  //ЗАПОЛНЯЮ СВЕДЕНИЯ ПО БОНУСАМ
  cbPayBonus.Checked := False;
  IF FIs_spisanie = 0 THEN begin    //при списании бонусы нафиг не нужны
    FSummBonus := spPostavshik.FieldByName('SUMM').AsFloat;
    FBonusPercent := spPostavshik.FieldByName('N_PERCENT').AsFloat/100;
    edBonus.Value := FSummZakaz * FBonusPercent;
    edBonusAll.Value := FSummBonus;
    cbPayBonus.Enabled := edBonusAll.Value > 0;
  end;

  //Readlist;
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

procedure TProdazhaTovaraNForm.edSummFactChange(Sender: TObject);
begin
  edSummFact.Text := StringReplace(edSummFact.Text, ',', '.', [rfReplaceAll]);

  edSummDolg.Value := edSummFact.Value - edSumm.Value;

  if High(FArrOplata) = 0 then
    FArrOplata[0].Summ := edSummFact.Value;

  if cbPayBonus.Checked then
    edSummDolg.Value := edSummDolg.Value + MIN(FSummZakaz, FSummBonus + FSummBonusPayed - FSummBonusGot);
end;

procedure TProdazhaTovaraNForm.sbEqualSummClick(Sender: TObject);
begin
  edSummFact.Value := edSumm.Value - FSummBonusPayed;
  edSummFact.Modified := True;
end;

procedure TProdazhaTovaraNForm.aGetDCardExecute(Sender: TObject);
var GetDCardForm: TGetDCardForm;
begin
  GetDCardForm := TGetDCardForm.Create(Self);
  with GetDCardForm do begin
    try
      GetDCardForm.Discont_card := spPostavshik.FieldByName('g_discont_card').AsInteger;
      if Showmodal = mrOK then begin
        if Client <> 0 then begin
          lePostavshik.LookupKeyValue := Client;
          lePostavshikChange(Self);
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TProdazhaTovaraNForm.cbPayBonusClick(Sender: TObject);
begin
  mNote.Modified := True;
  IF cbPayBonus.Checked THEN BEGIN
    FSummBonusPay    := MIN(FSummBonus + FSummBonusPayed - FSummBonusGot, FSummZakaz); //сумма оплачиваемая бонусами
    edBonusPayed.Value := FSummBonusPay;
    edBonusAll.Value := MAX(FSummBonus + FSummBonusPayed - FSummZakaz, 0);  //бонусы уже полученные в сохр. заказе я не могу использовать при редактировании этого же заказа
    edSummFact.Value := Max(FSummZakaz - (FSummBonus + FSummBonusPayed - FSummBonusGot), 0);
  END ELSE BEGIN
    FSummBonusPay := 0;
    edBonusPayed.Value := 0;
    edSummFact.Value := FSummZakaz;
    edBonusAll.Value := FSummBonus + FSummBonusPayed;
  end;
end;

procedure TProdazhaTovaraNForm.sbClearClick(Sender: TObject);
begin
  leStatya.LookupKeyValue := null;
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
    edSummFact.Modified := True;
  end;
end;

procedure TProdazhaTovaraNForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if WindowState = wsMaximized then
    SaveSettingsIni('ProdazhaTovaraNaklad', 'WindowState', 1, '')
  else
    SaveSettingsIni('ProdazhaTovaraNaklad', 'WindowState', 0, '');
end;

procedure TProdazhaTovaraNForm.FormCreate(Sender: TObject);
var hSysMenu : HMENU;
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
    edSummFact.Modified := True;
  end;
end;

procedure TProdazhaTovaraNForm.aRecalcPricesExecute(Sender: TObject);
begin
  spRecalcPrices.ParamByName('date_').AsDate := edDate.Date;
  if ExecSP(spRecalcPrices) then begin
    ShowMessage('Пересчет цен выполнен успешно!' + #13#10 + 'Не забудьте нажать кнопку "Сохранить".');
    mNote.Modified := true;
  end;
end;

procedure TProdazhaTovaraNForm.aOplataExecute(Sender: TObject);
var OplataForm : TOplataForm;
    i : integer;
begin
  OplataForm := TOplataForm.Create(Self);

  with OplataForm do begin
    SummZakaz := edSumm.Value;
    PaymentType := lePAYMENT_TYPE.LookupKeyValue;
    Helpcc := 82;    // раздел справки
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
      edSummFact.Value := StrToFloat(grOplata.ColumnByFieldName('summ_pay').SummaryFooterText);
      EnableSummFact;

      // если платеж один, то ставлю накладной его способ оплаты, также если платежей несколько, и все они одного способа платежа, то тоже ставлю их способ 
      SetPaymentType;
      
      mNote.Modified := true;
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
    FArrOplata[0].Payment := lePAYMENT_TYPE.LookupKeyValue;
    FArrOplata[0].Summ := edSummFact.Value;
  end;
end;

procedure TProdazhaTovaraNForm.edDatePropertiesChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Date := edDate.Date;
end;

procedure TProdazhaTovaraNForm.lePAYMENT_TYPEChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Payment := lePAYMENT_TYPE.LookupKeyValue;
end;

procedure TProdazhaTovaraNForm.SetPaymentType;
var NalPyament, BeznalPayment, i : integer;
begin
  // если платеж один, то ставлю накладной его способ оплаты, также если платежей несколько, и все они одного способа платежа, то тоже ставлю их способ
  if High(FArrOplata) = 0 then
    lePAYMENT_TYPE.LookupKeyValue := FArrOplata[0].Payment
  else begin
    for i := 0 to High(FArrOplata) do begin
      if FArrOplata[i].Payment = 1 then
        NalPyament := 1
      else if FArrOplata[i].Payment = 2 then
        BeznalPayment := 1
    end;

    if (NalPyament = 1) and (BeznalPayment = 0) then
      lePAYMENT_TYPE.LookupKeyValue := 1
    else if (NalPyament = 0) and (BeznalPayment = 1) then
      lePAYMENT_TYPE.LookupKeyValue := 2;
  end;
end;

end.
