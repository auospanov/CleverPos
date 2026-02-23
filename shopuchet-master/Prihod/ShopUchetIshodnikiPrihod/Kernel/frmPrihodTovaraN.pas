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
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, cxGridExportLink;

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

  TPrihodTovaraNForm = class(TDBEditForm)
    Panel3: TPanel;
    Shape11: TShape;
    Shape1: TShape;
    Shape25: TShape;
    Shape17: TShape;
    Shape14: TShape;
    Shape12: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Shape13: TShape;
    Label10: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Shape18: TShape;
    Shape26: TShape;
    Shape2: TShape;
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
    cxButton1: TcxButton;
    clmMainG_UNIT_NAME: TcxGridDBColumn;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    dlgSave: TSaveDialog;
    aCustomizeColumns: TAction;
    aSaveAllToXLS: TAction;
    aSaveSelectedToXLS: TAction;
    clmMainBARCODE: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
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
  private
    FArrPrice   : TArrPrice;
    FArrOplata  : TArrOplata;
    FSuccess    : Boolean;
    FIs_vozvrat : Integer; // 0 - обычный приход, 1 - возврат товара
    FZakaz      : Integer; // если больше 0, то значит форма вызвана для возврата, надо делать возврат
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
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  public
    property Success: Boolean read FSuccess write FSuccess default False;
    property Is_vozvrat: Integer read FIs_vozvrat write FIs_vozvrat default 0;
    property Zakaz : Integer read FZakaz write FZakaz;
    procedure Readlist;
  end;

var
  PrihodTovaraNForm: TPrihodTovaraNForm;

implementation

uses unErrorHandlers, frmZakupkaTovara, frmUpdZakupkaTovara, frmOplata, unInitApp, dmReports;

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

  if OpenMode = omInsert then begin
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
    if lePostavshik.EditValue > 0 then
      ParamByName('G_CLIENT_').AsInteger := lePostavshik.EditValue;
    if lePAYMENT_TYPE.EditValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInteger := lePAYMENT_TYPE.EditValue
    else
      ParamByName('G_PAYMENT_TYPE_').AsInteger := 1;  // по умолчанию поставлю наличный расчет, если клиент вдруг ничего не выбрал
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('summ_').AsFloat := edSumm.Value;
    ParamByName('summ_currency_').AsFloat := edSummCurrency.Value;
    ParamByName('summ_fact_').AsFloat := edSummFact.Value;
    IF (leStatya.EditValue <> 0) and (leStatya.EditValue <> null) THEN
      ParamByName('g_prihod_').AsInteger := leStatya.EditValue;
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
    spGetData.ParamByName('sklad_').AsInteger := RecID;
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
      edTIME.TIME := ParamByName('TIME_RECEIPT_').AsTIME;
      lePostavshik.EditValue := ParamByName('G_CLIENT_').AsInteger;
      lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsInteger;
      edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
      mNote.Text := ParamByName('note_').AsString;
      Readlist;    //он тут стоит потому что ниже заполняется edSummFact.Value

      edSumm.Value := ParamByName('summ_').AsFloat;
      leStatya.EditValue := ParamByName('G_PRIHOD_').AsInteger;
      edSummPrihod.Value := ParamByName('SUMM_PRIHOD_').AsFloat;
      edSummFact.Value := ParamByName('summ_fact_').AsFloat;
      edSummCurrency.Value := ParamByName('summ_currency_').AsFloat;

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
    MessageDlg('Лицензия истекла либо не зарегистрирована. ' + #10#13 + 'Включены ограничения на количество поступлений товара!', mtWarning, [mbOk], 0);
    DisableControls;
    EXIT;
  END;

  if OpenMode = omUpdate then begin
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
  {tsCommon.Caption := 'Детали';
  tsRashod.Caption := 'Сопутствующая статья расхода';
  aIns.Caption := 'Добавить товар';
  aUpd.Caption := 'Изменить';
  aDel.Caption := 'Удалить';
  clmMainPRODUCT_NAME.Caption := 'Товар';
  grProductAMOUNT.Caption := 'Кол-во';
  grProductPRICE.Caption := 'Цена';
  grProductSUMM.Caption := 'Сумма';}
  tvMain.RestoreFromIniFile('Settings.ini', False, False, [], Self.Name + '-' + tvMain.Name);

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
  lePostavshik.EditValue := spPostavshik.FieldByName('g_client').AsInteger;
  spReadStatya.ParamByName('action_').AsInteger := 1;
  OpenSp(spReadStatya, False);

  OpenSp(spPaymentType, False);
  lePAYMENT_TYPE.EditValue := 1;   // по умолчанию поставлю наличный расчет

  if Screen.PixelsPerInch = 120 then
    lbStatya.Font.Size := 9;

  lbStatya.Width := ScaleDimension(450);

  IF OpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
    btnOk.Enabled := False;
    aPrint.Enabled := False;
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

  if AppName = 'ShopUchet' then
    clmMainG_UNIT_NAME.Destroy;
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
  if tvMain.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('Выберите запись для изменения!', mtWarning, [mbOK], 0);
    Exit;
  end;

  UpdZakupkaTovaraForm := TUpdZakupkaTovaraForm.Create(Self);
  with UpdZakupkaTovaraForm do begin
    OpenMode := omUpdate;
    RecID := spZakazTemp.FieldByName('sklad').AsInteger;
    IsVozvratUpd := FIs_vozvrat;
    try
      if UpdZakupkaTovaraForm.ShowModal = mrOK then BEGIN
        Readlist;
        edOsnovanie.ModifiedAfterEnter := True;
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
var ALength, Sklad, i, j : integer;
begin
  if tvMain.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('Выберите запись для удаления!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if MessageDlg(Format('Удалить приход товара "%s" ?',
    [spZakazTemp.FieldByName('NAME').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
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
    edOsnovanie.ModifiedAfterEnter := TRUE;

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
    if spZakazTemp.RecordCount > 0 then begin
      if MessageDlg('Вы хотите закрыть окно, не сохранив изменения.'#13#10'Вы уверены, что хотите продолжить?',
      mtWarning, [mbYes, mbNo], 0) = mrNo then begin
        CanClose := False;
        Exit;
      end;
    end;

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

  if OpenMode in [omInsert, omInsertLike, omInsertChild] then
    FSuccess := InsData
  else if OpenMode = omUpdate then
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
      RecId := spIns.ParamByName('sklad_').AsInteger;
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
    spUpd.ParamByName('SKLAD_PARENT_').AsInteger := RecId;

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
  if ReadIntSettingsIni('PrihodTovaraNaklad', 'WindowState', 0) = 1 then
    WindowState := wsMaximized;

  if not UseCurrency then
    clmMainSummCurrency.Destroy;
end;

procedure TPrihodTovaraNForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if WindowState = wsMaximized then
    SaveSettingsIni('PrihodTovaraNaklad', 'WindowState', 1, '')
  else
    SaveSettingsIni('PrihodTovaraNaklad', 'WindowState', 0, '');

  tvMain.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvMain.name);
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

procedure TPrihodTovaraNForm.aPrintExecute(Sender: TObject);
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
                                        ' WHERE SD.sklad_PARENT = ' + IntToStr(RecId) +
                                          ' AND SD.g_product = g.g_product)' +
                        ' UNION ALL' +
                        ' SELECT g.name, g.barcode, TRUNC(g.price) PRICE, gg.levl + 1 levl, G.G_PRODUCT' +
                          ' FROM G_PRODUCT g INNER JOIN TREE GG ON GG.name = g.name' +
                         ' WHERE G.g_product = GG.G_PRODUCT' +
                           ' AND gg.levl < (SELECT SUM(AMOUNT) FROM sklad SDD' +
                                            ' WHERE SDD.sklad_parent = ' + IntToStr(RecId) +
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
end;

procedure TPrihodTovaraNForm.SetPaymentType;
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

procedure TPrihodTovaraNForm.tvMainCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aUpd.Execute;
end;

end.
