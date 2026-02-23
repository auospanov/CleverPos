unit frmRevision;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  FIBDataSet, pFIBDataSet, ExtCtrls, Menus, FIBDatabase, pFIBDatabase,
  ActnList, dxBar, dxBarExtItems,
  cxControls, cxSplitter, StdCtrls, Buttons, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, AppEvnts, DateUtils, unCommonFunc, dxBarExtDBItems, Math,
  frmMyCurrencyFrame, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, dxSkinsdxBarPainter, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridLevel, cxGridCustomView,
  cxGrid, cxCheckBox, System.UITypes, cxNavigator, System.Actions, cxButtons,
  cxCurrencyEdit;

type
  TRevisionForm = class(TDBListForm)
    spFillRevision: TpFIBStoredProc;
    Panel1: TPanel;
    Label8: TLabel;
    edSearch: TEdit;
    Label1: TLabel;
    spUpdAmountReal: TpFIBStoredProc;
    aUpdAmount: TAction;
    aClear: TAction;
    aPrint: TAction;
    aDoUnific: TAction;
    spUnific: TpFIBStoredProc;
    aRefill: TAction;
    ApplicationEvents: TApplicationEvents;
    bcOstatkiOrNakl: TdxBarCombo;
    TimerSearch: TTimer;
    cbScaner: TCheckBox;
    Timer1: TTimer;
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    dxBarButton2: TdxBarButton;
    clmMainNAME: TcxGridDBColumn;
    clmMainBARCODE: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    clmMainAMOUNT_BD: TcxGridDBColumn;
    clmMainAMOUNT_REAL: TcxGridDBColumn;
    clmMainIS_UNIFIED: TcxGridDBColumn;
    clmMainPLACE: TcxGridDBColumn;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    clmDIFF_SUMM: TcxGridDBColumn;
    Panel2: TPanel;
    lbOverSumm: TLabel;
    clmMainOVER_SUMM: TcxGridDBColumn;
    clmMainLOSS_SUMM: TcxGridDBColumn;
    procedure edSearchChange(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure aUpdAmountExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
    procedure aDoUnificExecute(Sender: TObject);
    procedure aRefillExecute(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure bcOstatkiOrNaklChange(Sender: TObject);
    procedure TimerSearchTimer(Sender: TObject);
    procedure cbScanerClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure clmDIFF_SUMMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FIsChangeNode : Boolean;
    FOverSumm : Double;
    FLossSumm : Double;
    procedure WMFillList(var Message: TMessage); message WM_FILLLIST;
  protected
    procedure ReadList; override;
    procedure FillList;
  public
  end;

var
  RevisionForm: TRevisionForm;

implementation

uses frmRevisionUnific, frmPriceListRepFilter, dmMain,
  frmTovarNaklForRevis, unInitApp, frmClientDateFilter;

{$R *.dfm}

procedure TRevisionForm.ReadList;
var
  AIndex : Integer;
begin
  FOverSumm := 0;
  FLossSumm := 0;

  spRead.ParamByName('g_tochka_').AsInteger := CurSklad;
  inherited;

  aUpdAmount.Enabled := spRead.RecordCount > 0;
  with tvMain.DataController.Summary do begin
    AIndex := FooterSummaryItems.IndexOfItemLink(clmMainOVER_SUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      FLossSumm := FLossSumm + FooterSummaryValues[AIndex];

    AIndex := FooterSummaryItems.IndexOfItemLink(clmMainLOSS_SUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      FOverSumm := FOverSumm + FooterSummaryValues[AIndex];
  end;

  lbOverSumm.Caption := 'Сумма излишков ' + FloatToStr(FLossSumm) + '. Сумма потерь ' + FloatToStr(FOverSumm) + '.';
end;

procedure TRevisionForm.edSearchChange(Sender: TObject);
begin
  TimerSearch.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edSearch.Text <> '' then
    TimerSearch.Enabled := True
  else BEGIN
    with spRead do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TRevisionForm.btClearClick(Sender: TObject);
begin
  inherited;
  edSearch.Clear;
end;

procedure TRevisionForm.aUpdAmountExecute(Sender: TObject);
begin
  if spRead.Locate('barcode', KeysBuffer, []) then begin
    spUpdAmountReal.ParamByName('REVISION_').AsInteger := spRead.FieldByName('revision').AsInteger;
    spUpdAmountReal.ParamByName('AMOUNT_REAL_').AsFloat := spRead.FieldByName('Amount_real').AsFloat + 1;
    if ExecSPTR(spUpdAmountReal) then
      Readlist;
  end else begin
    MessageDLG('Товар со штрихкодом ' + KeysBuffer + ' не найден!', mtWarning, [mbOk], 0);
    KeysBuffer := '';
  end;
end;

procedure TRevisionForm.aClearExecute(Sender: TObject);
begin
  edSearch.Clear;
  if Assigned(tvMain.Controller.FocusedRow) then
    tvMain.Controller.FocusedRow.Selected := True;
end;

procedure TRevisionForm.aDoUnificExecute(Sender: TObject);
var RevisionUnificForm : TRevisionUnificForm;
begin
  // если хоть на одном уже стоит галочка, то значит унификация уже произошла, надо спросить - уверен ли
  // пользователь, что хочет произвести унификацию еще раз
  if spRead.FieldByName('IS_UNIFIED').AsInteger = 1 then begin
    if MessageDlg('База данных уже приведена в соответствие. Вы уверены, что хотите' + #10#13 +
                  'провести эту операцию еще раз? Будет произведено списание/приход' + #10#13 +
                  'товара по второму разу.',
    mtInformation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  end;

  if MessageDlg('Вы уверены, что хотите провести серию автоматических списаний и приходов товара, для приведения БД в актуальное состояние?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  RevisionUnificForm := TRevisionUnificForm.Create(Self);
  try
    if RevisionUnificForm.ShowModal = mrOk then begin
      spUnific.ParamByName('MODE_').AsInteger := RevisionUnificForm.ComboBox.ItemIndex;
      if ExecSPTR(spUnific) then begin
        ShowMessage('Унификация выполнена успешно!' + #10#13 +
                    'Произведено приходов товара ' + IntToStr(spUnific.ParamByname('COUNT_PRIH_').AsInteger)+ #10#13 +
                    'Произведено списаний товара ' + IntToStr(spUnific.ParamByname('COUNT_SPIS_').AsInteger));
        Readlist;
      end;
    end
  finally
    RevisionUnificForm.Free;
  end;
  aDoUnific.Enabled := False;
end;

procedure TRevisionForm.aRefillExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_FILLLIST, 0, 0);
end;

procedure TRevisionForm.WMFillList(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  FillList;
end;

procedure TRevisionForm.FillList;
var TovarNaklForRevisForm: TTovarNaklForRevisForm;
    ClientDateFilterForm: TClientDateFilterForm;
begin
  if bcOstatkiOrNakl.ItemIndex = 0 then begin
    ClientDateFilterForm := TClientDateFilterForm.Create(Self);
    with ClientDateFilterForm do begin
      try
        ModeR := 8;
        Helpc := 42;
        IF ShowModal = mrOK then BEGIN
          if Category <> '' then
            spFillRevision.ParamByName('G_PRODUCT_PAR_').AsString := Category
          else
            spFillRevision.ParamByName('G_PRODUCT_PAR_').Clear;

          if Tovar <> '' then
            spFillRevision.ParamByName('G_PRODUCT_').AsString := Tovar
          else
            spFillRevision.ParamByName('G_PRODUCT_').Clear;

          spFillRevision.ParamByName('sklad_').AsInteger := 0;
          ExecSpTR(spFillRevision);
          ReadList;
        END;
      Finally
        Free;
      end;
    end;

  end else begin
    TovarNaklForRevisForm := TTovarNaklForRevisForm.Create(Self);
    try
      if TovarNaklForRevisForm.ShowModal = mrOk then
        spFillRevision.ParamByName('sklad_').AsInteger := TovarNaklForRevisForm.Sklad
      else
        Exit;

      spFillRevision.ParamByName('G_PRODUCT_PAR_').AsString := '';
    finally
      TovarNaklForRevisForm.Free;
    end;

    ExecSpTR(spFillRevision);
    ReadList;
  end;
end;

procedure TRevisionForm.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var OnChange : TNotifyEvent;
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
          // при сканировании нажатие энтера передавать никуда не надо
          Handled := True;
          onChange := MyCurrencyFrameForm.edAmount.OnChange;
          MyCurrencyFrameForm.edAmount.OnChange := nil;
          MyCurrencyFrameForm.edAmount.Text := '1.00';

          ClearBuffer;
          if KeysBuffer <> '' then begin
            TimerSearch.Enabled := False;
            aUpdAmount.Execute;
            KeysBuffer := '';
          end;
          MyCurrencyFrameForm.edAmount.OnChange := onChange;
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

procedure TRevisionForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'revision';
  KeyFieldClass := 'revision_';
  inherited;
  FIsChangeNode := False;
end;

procedure TRevisionForm.bcOstatkiOrNaklChange(Sender: TObject);
begin
  aDoUnific.Enabled := bcOstatkiOrNakl.ItemIndex = 0;
end;

procedure TRevisionForm.TimerSearchTimer(Sender: TObject);
var s : string;
begin
  TimerSearch.Enabled := False;
  if (edSearch.text<>'') then begin
    with spRead do begin
      s := '(NAME CONTAINING ''' + edSearch.text + ''') OR (ARTICUL CONTAINING ''' + edSearch.text + ''') OR (BARCODE CONTAINING '''+ edSearch.text + ''')';
      
      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edSearch.text + ''')';

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

procedure TRevisionForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  FIsChangeNode := True;  //чтобы не запускался таймер после смены строки
  MyCurrencyFrameForm.edAmount.Text := spRead.FieldByName('Amount_real').AsString;
end;

procedure TRevisionForm.cbScanerClick(Sender: TObject);
begin
  MyCurrencyFrameForm.sbCur.Enabled := Integer(cbScaner.Checked) = 0;
  MyCurrencyFrameForm.edAmount.Enabled := Integer(cbScaner.Checked) = 0;
end;

procedure TRevisionForm.clmDIFF_SUMMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Value < 0 then begin
    if AViewInfo.Selected then
      ACanvas.Font.Color:= clWhite
    else
      ACanvas.Font.Color:= clRed
  end;
end;

procedure TRevisionForm.Timer1Timer(Sender: TObject);
var i, AIndex : integer;
begin
  Timer1.Enabled := False;
  FOverSumm := 0;
  FLossSumm := 0;

  spUpdAmountReal.ParamByName('REVISION_').AsInteger := spRead.FieldByName('revision').AsInteger;
  spUpdAmountReal.ParamByName('AMOUNT_REAL_').AsFloat:= MyCurrencyFrameForm.Value;
  if ExecSPTR(spUpdAmountReal) THEN BEGIN
    Screen.Cursor := crHourGlass;
    //FIsChangeNode := TRUE;
    i := MyCurrencyFrameForm.edAmount.SelStart;
    spRead.ReopenLocate('revision');
    MyCurrencyFrameForm.edAmount.SelStart := i;  //иначе курсор смещается при переоткрытии spRead

    with tvMain.DataController.Summary do begin
      AIndex := FooterSummaryItems.IndexOfItemLink(clmMainOVER_SUMM);
      if not VarIsNull(FooterSummaryValues[AIndex]) then
        FLossSumm := FLossSumm + FooterSummaryValues[AIndex];

      AIndex := FooterSummaryItems.IndexOfItemLink(clmMainLOSS_SUMM);
      if not VarIsNull(FooterSummaryValues[AIndex]) then
        FOverSumm := FOverSumm + FooterSummaryValues[AIndex];
    end;

    lbOverSumm.Caption := 'Сумма излишков ' + FloatToStr(FLossSumm) + '. Сумма потерь ' + FloatToStr(FOverSumm) + '.';

    Screen.Cursor := crDefault;
  end;
end;

procedure TRevisionForm.MyCurrencyFrameFormedAmountChange(
  Sender: TObject);
begin
  inherited;
  IF Length(Copy(MyCurrencyFrameForm.edAmount.Text,1,Pos('.', MyCurrencyFrameForm.edAmount.Text)-1)) > 10 then begin
    MessageDlg('Вы ввели слишком большое число для количества товара!', mtWarning, [mbOK], 0);
    Exit;
  end;

  MyCurrencyFrameForm.edAmountChange(Sender);
  if not FIsChangeNode then begin
    Timer1.Enabled := False;
    Timer1.Enabled := true;
  end;

  FIsChangeNode := False;
end;

procedure TRevisionForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 42;
  inherited;
end;

end.
