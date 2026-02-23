unit frmPrihodTovaraN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, dxExEdtr, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, dxEdLib, dxCntner,
  dxEditor, dxDBEdtr, dxDBELib, dxTL, dxDBCtrl, dxDBGrid, ExtCtrls,
  DB, ActnList, frmDBEdit, unCommonFunc, FIBDataSet,
  pFIBDataSet, FIBQuery, pFIBQuery, pFIBStoredProc, FIB, FIBDatabase,
  pFIBDatabase, AppEvnts, cxSpinEdit, cxTimeEdit, cxPC,
  cxLookAndFeelPainters, cxButtons;

type
  TRecPrice = record
    Id: Integer;
    ProductId: Integer;
    Price  : Double;
    PriceOpt: Double;
  end;

  TRecOplata = record
    Id: Integer;
    Date: TDate;
    Summ  : Double;
    Payment: Integer;
  end;

  TArrPrice = Array of TRecPrice;
  TArrOplata = Array of TRecOplata;

  TPrihodTovaraNForm = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    dsPostavshik: TDataSource;
    dsPaymentType: TDataSource;
    dsZakazTemp: TDataSource;
    Panel1: TPanel;
    ActionList: TActionList;
    aRefreshOfficialRights: TAction;
    aShowWhoLockRecord: TAction;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    spGetData: TpFIBStoredProc;
    spIns: TpFIBStoredProc;
    spUpd: TpFIBStoredProc;
    spZakazTemp: TpFIBDataSet;
    spDel: TpFIBStoredProc;
    spPostavshik: TpFIBDataSet;
    spPaymentType: TpFIBDataSet;
    tranRead: TpFIBTransaction;
    tranWrite: TpFIBTransaction;
    spReadStatya: TpFIBDataSet;
    dsReadStatya: TDataSource;
    spUpdLock: TpFIBStoredProc;
    btHelp: TBitBtn;
    spUpdPrices: TpFIBStoredProc;
    Panel3: TPanel;
    Label7: TLabel;
    Shape12: TShape;
    Label8: TLabel;
    Shape14: TShape;
    Label9: TLabel;
    Shape17: TShape;
    Label13: TLabel;
    Shape25: TShape;
    Label2: TLabel;
    Shape1: TShape;
    edDate: TcxDateEdit;
    Shape13: TShape;
    Label10: TLabel;
    Shape11: TShape;
    Shape15: TShape;
    edTime: TcxTimeEdit;
    edOsnovanie: TdxEdit;
    Shape16: TShape;
    lePostavshik: TdxLookupEdit;
    Shape18: TShape;
    lePAYMENT_TYPE: TdxLookupEdit;
    Shape26: TShape;
    mNote: TMemo;
    Shape2: TShape;
    pcMain: TcxPageControl;
    tsCommon: TcxTabSheet;
    pn1: TPanel;
    grProduct: TdxDBGrid;
    grProductPRODUCT_NAME: TdxDBGridMaskColumn;
    grProductG_PRODUCT: TdxDBGridMaskColumn;
    grProductAMOUNT: TdxDBGridMaskColumn;
    grProductPRICE: TdxDBGridMaskColumn;
    grProductSUMM: TdxDBGridMaskColumn;
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
    edSumm: TdxCurrencyEdit;
    edSummFact: TdxCurrencyEdit;
    edSummDolg: TdxCurrencyEdit;
    tsRashod: TcxTabSheet;
    lbStatya: TLabel;
    leStatya: TdxLookupEdit;
    sbClear: TSpeedButton;
    edSummPrihod: TdxCurrencyEdit;
    aOplata: TAction;
    btnOplata: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grProductDblClick(Sender: TObject);
    procedure lePostavshikChange(Sender: TObject);
    procedure sbEqualSummClick(Sender: TObject);
    procedure edSummFactChange(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aOplataExecute(Sender: TObject);
    procedure edDatePropertiesChange(Sender: TObject);
    procedure lePAYMENT_TYPEChange(Sender: TObject);
  private
    FArrPrice   : TArrPrice;
    FArrOplata  : TArrOplata;
    FRecID      : Integer;
    FOpenMode   : TOpenMode;
    FSuccess    : Boolean;
    FIs_vozvrat : Integer; // 0 - обычный приход, 1 - возврат товара
    function OpenSP(SP: TpFIBDataSet; UseBookmark: Boolean): Boolean;
    function ExecSP(SP: TpFIBStoredProc): Boolean;
    function CheckParams(var ErrControl: TWinControl): Boolean;
    procedure SetParams(SP: TpFIBStoredProc);
  protected
    //function IsRecLocked: Boolean;
    //procedure ShowWhoLockRec;
    function CallSP(SP: TpFIBStoredProc): Boolean;
    function InsData: Boolean;
    function UpdData: Boolean;
    procedure GetData;
    procedure ClearTempTable;
    procedure DisableControls;
    procedure SetArrOplataSumm;
    procedure EnableSummFact;
    procedure SetPaymentType;
  public
    property OpenMode: TOpenMode read FOpenmode write FOpenMode default omView;
    property Success: Boolean read FSuccess write FSuccess default False;
    property RecID: Integer read FRecID write FRecID default 0;
    property Is_vozvrat: Integer read FIs_vozvrat write FIs_vozvrat default 0;
    procedure Readlist;
  end;

var
  PrihodTovaraNForm: TPrihodTovaraNForm;

implementation

uses unErrorHandlers, frmZakupkaTovara, frmUpdZakupkaTovara, frmOplata;

{$R *.dfm}
function TPrihodTovaraNForm.OpenSP(SP: TpFIBDataSet;
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

function TPrihodTovaraNForm.ExecSP(SP: TpFIBStoredProc): Boolean;
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
        end else
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
    ErrControl := edSummFact;
    MessageDlg('Оплачиваемая сумма не может быть больше суммы прихода.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if FOpenMode = omInsert then begin
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
  end;

  Result := True;
end;

procedure TPrihodTovaraNForm.SetParams(SP: TpFIBStoredProc);
var i : Integer; StrArr : string;
begin
  with SP do begin
    ParamByName('DATE_RECEIPT_').AsDate := edDate.Date;
    ParamByName('TIME_RECEIPT_').AsTIME := edTIME.TIME;
    if lePostavshik.LookupKeyValue > 0 then
      ParamByName('G_CLIENT_').AsInteger := lePostavshik.LookupKeyValue;
    if lePAYMENT_TYPE.LookupKeyValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInteger := lePAYMENT_TYPE.LookupKeyValue
    else
      ParamByName('G_PAYMENT_TYPE_').AsInteger := 1;  // по умолчанию поставлю наличный расчет, если клиент вдруг ничего не выбрал
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('summ_').AsFloat := edSumm.Value;
    ParamByName('summ_fact_').AsFloat := edSummFact.Value;
    IF (leStatya.LookupKeyValue <> 0) and (leStatya.LookupKeyValue <> null) THEN
      ParamByName('g_prihod_').AsInteger := leStatya.LookupKeyValue;
    ParamByName('summ_prihod_').AsFloat := edSummPrihod.Value;

    IF (High(FArrOplata) > 0) or (OpenMode = omUpdate) then begin
      for i := 0 to High(FArrOplata) do
        StrArr := StrArr + IntToStr(FArrOplata[i].Id) + '-' + DateToStr(FArrOplata[i].Date) + '-' + FloatToStr(FArrOplata[i].Summ) + '-' + IntToStr(FArrOplata[i].Payment)+ '~';

      StrArr := StringReplace(StrArr, ',', '.', [rfReplaceAll, rfIgnoreCase]);   //заменяю на всякий случай запятые на точки
      ParamByName('PAYMENTS_').AsString := StrArr;
    end;
  end;
end;

procedure TPrihodTovaraNForm.Readlist;
begin
  OpenSP(spZakazTemp, True);
  pnRowCnt.Caption := IntToStr(spZakazTemp.RecordCount);
  aUpd.Enabled := spZakazTemp.RecordCount > 0;
  aDel.Enabled := spZakazTemp.RecordCount > 0;
  aOplata.Enabled := (spZakazTemp.RecordCount > 0) or (High(FArrOplata) > 0);
  btnOk.Enabled := spZakazTemp.RecordCount > 0;

  edSumm.Value := StrToFloat(grProduct.ColumnByFieldName('summ').SummaryFooterText);

  if High(FArrOplata) = 0 then
    edSummFact.Value := edSumm.Value
  else begin
    edSummDolg.Value := edSumm.Value - edSummFact.Value;
  end;
end;

procedure TPrihodTovaraNForm.DisableControls;
begin
  aIns.Enabled := False;
  aUpd.Enabled := False;
  aDel.Enabled := False;
  aOplata.Enabled := False;
  edDate.ENABLED := FALSE;
  edTime.ENABLED := FALSE;
  edOsnovanie.ENABLED := FALSE;
  edSummFact.ENABLED := FALSE;

  mNote.Enabled := FALSE;
  lePostavshik.ENABLED := FALSE;
  lePAYMENT_TYPE.ENABLED := FALSE;
  btnOk.Enabled := FALSE;
end;

procedure TPrihodTovaraNForm.GetData;
var p, i : integer;
  str, str1 : string;
begin
  begin
    try
      spGetData.ParamByName('sklad_').AsInteger := FRecID;
      if not spGetData.Transaction.InTransaction then
        spGetData.Transaction.StartTransaction;

      if FOpenMode = omInsertLike then
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
  end;

  if FOpenMode <> omInsert then BEGIN
    with spGetData do begin
      edDate.Date := ParamByName('DATE_RECEIPT_').AsDate;
      edTIME.TIME := ParamByName('TIME_RECEIPT_').AsTIME;
      lePostavshik.LookupKeyValue := ParamByName('G_CLIENT_').AsInteger;
      lePAYMENT_TYPE.LookupKeyValue := ParamByName('G_PAYMENT_TYPE_').AsInteger;
      edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
      mNote.Text := ParamByName('note_').AsString;
      edSumm.Value := ParamByName('summ_').AsFloat;
      leStatya.LookupKeyValue := ParamByName('G_PRIHOD_').AsInteger;
      edSummPrihod.Value := ParamByName('SUMM_PRIHOD_').AsFloat;
      Readlist;
      edSummFact.Value := ParamByName('summ_fact_').AsFloat;

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
    FArrOplata[0].Date := Date;
    FArrOplata[0].Payment := 1;
  end;
  EnableSummFact;  // выключаю edSummFact, если есть больше одного платежа

  if (HaveRightUpdPrihod = False) and (FIs_vozvrat = 0) AND (OpenMode = omUpdate) then begin
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
    MessageDlg('Программа не зарегистрирована. ' + #10#13 + 'Включены ограничения на количество поступлений товара!', mtWarning, [mbOk], 0);
    DisableControls;
    EXIT;
  END;

  if FOpenMode = omUpdate then begin
    spUpdLock.ParamByName('id_').AsInteger := RecId;
    spUpdLock.ParamByName('TABLE_NAME_').AsString := 'sklad_parent';

    if not spUpdLock.Transaction.InTransaction then   //ТРАНЗАКЦИЯ ЗАКОММИТИТЬСЯ, ЕСЛИ КЛИЕНТ НАЖМЕТ КНОПКУ ОК, ИЛИ ОТРОЛЛБАЧИТЬСЯ, ЕСЛИ БУДЕТ ОШИБКА ИЛИ НАЖМУТ КНОПКУ ОТМЕНА
      spUpdLock.Transaction.StartTransaction;
    if not ExecSP(spUpdLock) then begin
      DisableControls;
      EXIT;
    end;
  end;
end;

procedure TPrihodTovaraNForm.FormShow(Sender: TObject);
begin
  // на некоторых английских виндоусах коряво прописываются кнопочки, поэтому тут на русском пропишу
  tsCommon.Caption := 'Детали';
  tsRashod.Caption := 'Сопутствующая статья расхода';
  aIns.Caption := 'Добавить товар';
  aUpd.Caption := 'Изменить';
  aDel.Caption := 'Удалить';
  grProductPRODUCT_NAME.Caption := 'Товар';
  grProductAMOUNT.Caption := 'Кол-во';
  grProductPRICE.Caption := 'Цена';
  grProductSUMM.Caption := 'Сумма';

  // ОЧИЩАЮ И ВРЕМЕННУЮ ТАБЛИЧКУ
  ClearTempTable;

  if FIs_vozvrat in [0, 1] then begin
    if FIs_vozvrat = 1 then begin
      Caption := 'Возврат товара';
      Label7.Caption := 'Дата возврата';
      Label9.Caption := 'Клиент';
      spPostavshik.Filter := 'is_supplier = 0';  // ПРИ ВОЗВРАТЕ ВЫТАСКИВАЮ КЛИЕНТОВ
    end else
      spPostavshik.Filter := 'is_supplier = 1';  // ПРИ ОБЫЧНОМ ПРИХОДЕ ВЫТАСКИВАЮ ПОСТАВЩИКОВ

    spPostavshik.Filtered := True;
  end else begin
    spPostavshik.ParamByName('G_CLIENT_PARENT_').AsInteger := -1000;
    aOplata.Enabled := False;
    aOplata.Visible := False;
  end;

  OpenSp(spPostavshik, False);
  spPostavshik.Locate('by_default', 1, []);
  lePostavshik.LookupKeyValue := spPostavshik.FieldByName('g_client').AsInteger;
  spReadStatya.ParamByName('action_').AsInteger := 1;
  OpenSp(spReadStatya, False);

  OpenSp(spPaymentType, False);
  lePAYMENT_TYPE.LookupKeyValue := 1;   // по умолчанию поставлю наличный расчет

  
  lbStatya.Width := ScaleDimension(603);

  GetData;

  IF FOpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
  end else if FOpenMode = omView then
    DisableControls;

  with grProduct do
    ShowSummaryFooter := True;
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
  finally
    ZakupkaTovaraForm.Free;
  end;
end;

procedure TPrihodTovaraNForm.aUpdExecute(Sender: TObject);
begin
  UpdZakupkaTovaraForm := TUpdZakupkaTovaraForm.Create(Self);
  with UpdZakupkaTovaraForm do begin
    OpenMode := omUpdate;
    RecID := spZakazTemp.FieldByName('sklad').AsInteger;
    try
      if UpdZakupkaTovaraForm.ShowModal = mrOK then BEGIN
        Readlist;
        edOsnovanie.Modified := True;
      end;
    finally
      UpdZakupkaTovaraForm.Free;
    end;
  end;
end;

procedure TPrihodTovaraNForm.aDelExecute(Sender: TObject);
var ALength, Sklad, i, j : integer;
begin
  if MessageDlg(Format('Удалить приход товара "%s" ?',
    [spZakazTemp.FieldByName('PRODUCT_NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Sklad := spZakazTemp.FieldByName('SKLAD').AsInteger;
  spDel.ParamByName('SKLAD_').AsInteger := Sklad;
  spDel.ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;

  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  if ExecSP(spDel) then BEGIN
    if spDel.Transaction.InTransaction then
      spDel.Transaction.Commit;
    Readlist;
    edOsnovanie.Modified := TRUE;

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

procedure TPrihodTovaraNForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var StrArr : string;
  i : integer;
begin
  if ModalResult <> mrOk THEN BEGIN
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

  IF FSuccess THEN BEGIN   // ОЧИЩАЮИ ВРЕМЕННУЮ ТАБЛИЧКУ ТОЛЬКО ЕСЛИ БЫЛО УСПЕШНОЕ СОХРАНЕНИЕ
    ClearTempTable;

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
end;

function TPrihodTovaraNForm.InsData: Boolean;
begin
  Result := False;
  spIns.ParamByName('Is_VOZVRAT_').AsInteger := FIs_vozvrat;
  try
    if CallSP(spIns) then
    begin
      FRecId := spIns.ParamByName('sklad_').AsInteger;
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

function TPrihodTovaraNForm.UpdData: Boolean;
begin
  Result := False;
  try
    spUpd.ParamByName('SKLAD_PARENT_').AsInteger := FRecId;

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

procedure TPrihodTovaraNForm.lePostavshikChange(Sender: TObject);
begin
  // ставлю автоматом наличный или безналичный расчет
  if spPostavshik.FieldByName('is_beznal').AsInteger = 1 then
    lePAYMENT_TYPE.LookupKeyValue := 2
  else
    lePAYMENT_TYPE.LookupKeyValue := 1;
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
  edSummFact.Modified := True;
end;

procedure TPrihodTovaraNForm.edSummFactChange(Sender: TObject);
begin
  edSummFact.Text := StringReplace(edSummFact.Text, ',', '.', [rfReplaceAll]);

  edSummDolg.Value := edSumm.Value - edSummFact.Value;
  if High(FArrOplata) = 0 then
    FArrOplata[0].Summ := edSummFact.Value;
end;

procedure TPrihodTovaraNForm.sbClearClick(Sender: TObject);
begin
  leStatya.LookupKeyValue := null;
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
  if ReadIntSettingsIni('PrihodTovaraNaklad', 'WindowState', 0) = 1 then
    WindowState := wsMaximized;
end;

procedure TPrihodTovaraNForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if WindowState = wsMaximized then
    SaveSettingsIni('PrihodTovaraNaklad', 'WindowState', 1, '')
  else
    SaveSettingsIni('PrihodTovaraNaklad', 'WindowState', 0, '');
end;

procedure TPrihodTovaraNForm.aOplataExecute(Sender: TObject);
var OplataForm : TOplataForm;
    i : integer;
begin
  OplataForm := TOplataForm.Create(Self);

  with OplataForm do begin
    SummZakaz := edSumm.Value;
    PaymentType := lePAYMENT_TYPE.LookupKeyValue;
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
      edSummFact.Value := StrToFloat(grOplata.ColumnByFieldName('summ_pay').SummaryFooterText);
      EnableSummFact;

      // если платеж один, то ставлю накладной способ расчета этого платежа, либо если платежей несколько, и все они одного способа - тоже меняю 
      SetPaymentType;

      mNote.Modified := true;
    end;
  end;
end;

procedure TPrihodTovaraNForm.SetArrOplataSumm;
begin
  if High(FArrOplata) = 0 then begin
    FArrOplata[0].Date := edDate.Date;
    FArrOplata[0].Payment := lePAYMENT_TYPE.LookupKeyValue;
    FArrOplata[0].Summ := edSummFact.Value;
  end;
end;

procedure TPrihodTovaraNForm.edDatePropertiesChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Date := edDate.Date;
end;

procedure TPrihodTovaraNForm.EnableSummFact;
begin
  edSummFact.Enabled := High(FArrOplata) = 0;
  sbEqualSumm.Enabled := High(FArrOplata) = 0;
end;

procedure TPrihodTovaraNForm.lePAYMENT_TYPEChange(Sender: TObject);
begin
  if High(FArrOplata) = 0 then
    FArrOplata[0].Payment := lePAYMENT_TYPE.LookupKeyValue;
end;

procedure TPrihodTovaraNForm.SetPaymentType;
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
