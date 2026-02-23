unit frmRevision;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  FIBDataSet, pFIBDataSet, ExtCtrls, Menus, FIBDatabase, pFIBDatabase,
  ActnList, dxBar, dxBarExtItems, frmDBEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxTextEdit, cxCheckBox,
  cxContainer, Vcl.AppEvnts, cxProgressBar, Vcl.StdCtrls, cxButtons,
  frmMyCurrencyFrame, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxEditRepositoryItems, cxClasses, System.Actions, cxGridLevel,
  cxGridCustomView, cxGrid, cxSplitter, Buttons, cxMaskEdit, cxSpinEdit, DateUtils,
  unCommonFunc, dxBarExtDBItems, Math,
  dxSkinsCore, dxSkinscxPCPainter, System.Win.ComObj,
  dxSkinsdxBarPainter,
  System.UITypes,
  cxCurrencyEdit, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TTovarRek = record
    Barcode : String;
    Amount  : Double;
  end;
  TTovarRekArr = Array of TTovarRek;
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
	  tmrScanBarcodesComing: TTimer;
	  aFromHarvester: TAction;
    pbBarcodeArrUpdate: TcxProgressBar;
    clmMainPRICE: TcxGridDBColumn;
    aImportFromExcel: TAction;
    dxbrbtn1: TdxBarButton;
    odlg: TOpenDialog;
    spImport: TpFIBStoredProc;
    aClearTable: TAction;
    dxBarButton3: TdxBarButton;
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
    procedure tmrScanBarcodesComingTimer(Sender: TObject);
	procedure aFromHarvesterExecute(Sender: TObject);
    procedure tvMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dxBarButton3Click(Sender: TObject);
    procedure aClearTableExecute(Sender: TObject);
    procedure aImportFromExcelExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FIsChangeNode : Boolean;
    FOverSumm : Double;
    FLossSumm : Double;
    FTovarRekArr : TTovarRekArr;
    FLastBarcodeCame: TDateTime;   //когда приходил последний штрихкод с Barcode Harvester
    FBarcodeFromHarvester : Boolean; // штрихкод пришел с Barcode Harvester
    procedure WMFillList(var Message: TMessage); message WM_FILLLIST;
    procedure WMClearTable(var Message: TMessage); message WM_CLEARTABLE;
    procedure WMImport(var Message: TMessage); message WM_IMPORT;
	  procedure LoadBarcodeAmounts;
    procedure UpdAmountInBD(barcode : string; amount : double; DoRefresh : Boolean);
  protected
    procedure ReadList; override;
    procedure FillList;
    procedure ClearTable;
    procedure ImportExcel;
  public
  end;

var
  RevisionForm: TRevisionForm;

implementation

uses frmRevisionUnific, frmPriceListRepFilter, dmMain,
  frmTovarNaklForRevis, unInitApp, frmClientDateFilter, frmRevisionUpd, frmCommonLog, frmRevisionImportFillDlg;

{$R *.dfm}

procedure TRevisionForm.ReadList;
var
  AIndex : Integer;
begin
  FOverSumm := 0;
  FLossSumm := 0;

  spRead.ParamByName('g_tochka_').AsInt64 := CurSklad;
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

procedure TRevisionForm.Button1Click(Sender: TObject);
begin
  //UpdAmountInBD(Edit1.Text, -100, True);
end;

procedure TRevisionForm.aUpdAmountExecute(Sender: TObject);
begin
  UpdAmountInBD(KeysBuffer, -100, True);
end;

procedure TRevisionForm.UpdAmountInBD(barcode: string; amount: double; DoRefresh : Boolean);
var N : integer;
  str : string;
  amnt : double;
begin
  if (UseScales = 1) and (copy(barcode, 1, 2) = ScalesPrefix) then begin
    // т.к. поиск идет через Locate, то для весовых товаров придется тут вычислять
    // штрихкод в таком виде, в каком он сидит в Справочнике товаров
    amnt := StrToFloat(copy(BARCODE, 8, 5)) / 1000;
    str := copy(barcode, 1, 7) + '00000';
    N := (StrToInt(copy(str, 2, 1))+
         StrToInt(copy(str,4,1))+
         StrToInt(copy(str,6,1))+
         StrToInt(copy(str,8,1))+
         StrToInt(copy(str,10,1))+
         StrToInt(copy(str,12,1))
        ) * 3 +
         StrToInt(copy(str,1,1))+
         StrToInt(copy(str,3,1))+
         StrToInt(copy(str,5,1))+
         StrToInt(copy(str,7,1))+
         StrToInt(copy(str,9,1))+
         StrToInt(copy(str,11,1));
    N := N MOD 10;
    IF(N > 0)THEN N := 10 - N;

    barcode := str + IntToStr(N);
  end
  else
    amnt := 1;

  if spRead.Locate('barcode', barcode, []) then begin
    spUpdAmountReal.ParamByName('REVISION_').AsInt64 := spRead.FieldByName('revision').AsLargeInt;
    if amount = -100 then
      spUpdAmountReal.ParamByName('AMOUNT_REAL_').AsFloat := spRead.FieldByName('Amount_real').AsFloat + amnt
    else
      spUpdAmountReal.ParamByName('AMOUNT_REAL_').AsFloat := amount;
    if ExecSPTR(spUpdAmountReal) then
      if DoRefresh then
        Readlist;
  end else begin
    MessageDLG('Товар со штрихкодом ' + barcode + ' не найден!', mtWarning, [mbOk], 0);
    KeysBuffer := '';
  end;
end;

procedure TRevisionForm.aClearExecute(Sender: TObject);
begin
  edSearch.Clear;
  if Assigned(tvMain.Controller.FocusedRow) then
    tvMain.Controller.FocusedRow.Selected := True;
end;

procedure TRevisionForm.aClearTableExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLEARTABLE, 0, 0);
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

procedure TRevisionForm.aFromHarvesterExecute(Sender: TObject);
begin
  FBarcodeFromHarvester := True;
end;
procedure TRevisionForm.aRefillExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_FILLLIST, 0, 0);
end;

procedure TRevisionForm.WMClearTable(var Message: TMessage);
begin
  ClearTable;
end;

procedure TRevisionForm.WMFillList(var Message: TMessage);
begin
  if not MainDM.dbMain.Connected then
    Exit;
  FillList;
end;

procedure TRevisionForm.WMImport(var Message: TMessage);
begin
  ImportExcel;
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

          spFillRevision.ParamByName('sklad_').AsInt64 := 0;
          spFillRevision.ParamByName('type_').AsInteger := 0;

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
        spFillRevision.ParamByName('sklad_').AsInt64 := TovarNaklForRevisForm.Sklad
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
  i, outFoundIndex : integer;
  is_found : boolean;
procedure ClearBuffer;
  begin
    if MilliSecondsBetween(Now, LastDateForAddedKey) > 200 then
    begin
      // при медленном вводе буфер очищяется, т.к. скан идет "мгновенно"
      KeysBuffer := '';
    end;
  end;
begin
  // данные считываем на WM_CHAR
  // НО КЛАВИШУ ЭНТЕР на WM_KEYDOWN
  // заканчиваем ввод
  //IF Screen.ActiveForm <> Nil THEN BEGIN
    IF Screen.ActiveForm.Name = Self.Name THEN BEGIN
      if Msg.message = WM_KEYDOWN then begin
        if Msg.wParam = 13 then begin
          // при сканировании нажатие энтера передавать никуда не надо
          Handled := True;
          //если пришло с Barcode Harvester, то ищу в массиве, если такого щтрихка нет, то вставлю
          if FBarcodeFromHarvester then begin
            for I := 0 to High(FTovarRekArr) do
              if FTovarRekArr[i].Barcode = KeysBuffer then begin
                is_found := True;
                Break;
              end;

            if is_found then
              FTovarRekArr[i].Amount := FTovarRekArr[i].Amount + 1
            else begin
              SetLength(FTovarRekArr, High(FTovarRekArr) + 2);
              FTovarRekArr[High(FTovarRekArr)].Barcode := KeysBuffer;
              FTovarRekArr[High(FTovarRekArr)].Amount := 1;
            end;
            KeysBuffer := '';
            is_found   := false;
            FLastBarcodeCame := Now;
            FBarcodeFromHarvester := False;
            Screen.Cursor := crHourGlass;
            tmrScanBarcodesComing.Enabled := False;
            tmrScanBarcodesComing.Enabled := True;

          // если же пришло с обычного сканера, то по старому пути
          end else begin
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
  //END;
end;

procedure TRevisionForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'revision';
  KeyFieldClass := 'revision_';
  inherited;
  FIsChangeNode := False;
end;

procedure TRevisionForm.ImportExcel;
var ExcelInstalled : Boolean;
  AFileName: String;
  //Excel: Variant;
  WorkSheet: OLEVariant;
  FData    : OLEVariant;
  X, R, succ, unsucc: Integer;
  Log, str : string;
  CommonLogForm: TCommonLogForm;
  RevisionImportFillDlgForm: TRevisionImportFillDlgForm;
begin
  if odlg.Execute then begin
    if FileExists(odlg.FileName) then begin
      RevisionImportFillDlgForm := TRevisionImportFillDlgForm.Create(Self);
      try
        RevisionImportFillDlgForm.ShowModal;
        if RevisionImportFillDlgForm.ShowModal = mrOk then begin
            Screen.Cursor := crHourGlass;
            AFileName := odlg.FileName;
            ExcelInstalled := IsOLEObjectInstalled('Excel.Application');
            IF ExcelInstalled THEN BEGIN
              succ   := 0;
              unsucc := 0;
              Excel := CreateOleObject('Excel.Application');
              Excel.Workbooks.Open(AFileName);
              WorkSheet := Excel.ActiveWorkbook.ActiveSheet;
              FData := WorkSheet.UsedRange.Value;
              X := WorkSheet.UsedRange.Rows.Count;
              pbBarcodeArrUpdate.Visible := True;
              pbBarcodeArrUpdate.Position := 0;
              pbBarcodeArrUpdate.Properties.Max := X;
              Excel.Quit;
              Excel := Null;

              for R := 0 to X-1 do begin
                IF Trim(VarToStr(FData[R+1, 1])) <> '' THEN BEGIN
                  spImport.ParamByName('BARCODE_').AsString := FData[R+1, 1];
                  spImport.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
                  IF Trim(VarToStr(FData[R+1, 2])) <> '' THEN BEGIN
                    try
                      spImport.ParamByName('AMOUNT_').AsFloat := StrToFloat(FData[R+1, 2]);
                    except
                      on E: Exception do begin
                        Log := Log + VarToStr(FData[R+1, 1]) + '. Некорректное число в колонке "Остаток" = "' + VarToStr(FData[R+1, 2]) + '".'#13#10;
                        unsucc := unsucc + 1;
                        Continue;
                      end;
                    end;

                    ExecSPTR(spImport);
                    if spImport.ParamByName('ERR_MSG').AsString = '' then begin
                      succ := succ + 1;
                    end else begin
                      Log := Log + spImport.ParamByName('ERR_MSG').AsString + #13#10;
                      unsucc := unsucc + 1;
                    end;
                  END;
                END ELSE BEGIN
                  Log := Log + 'Штрихкод пуст. Строка №' + R.ToString + #13#10;
                  unsucc := unsucc + 1;
                END;

                pbBarcodeArrUpdate.Position := pbBarcodeArrUpdate.Position + 1;
                Application.ProcessMessages;
              end;

              str := 'Импорт завершен.'#13#10 +
                     'Успешно загружено ' + succ.ToString + '.' + #13#10 +
                     'Неуспешно загружено ' + unsucc.ToString + '.';

              if unsucc > 0 then
                str := str + #13#10 + 'Ошибки:'+ #13#10 + Log;

              CommonLogForm := TCommonLogForm.Create(Application);
              try
                CommonLogForm.mMain.Text := str;
                CommonLogForm.ShowModal;
              finally
                CommonLogForm.Free;
              end;

              Readlist;
            END else
              MessageDlg('Не установлен Microsoft Excel!', mtWarning, [mbOK], 0);

            pbBarcodeArrUpdate.Visible := False;

            // если поставили галочку дозаполнить - надо дозаполнить остальными товарами
            if RevisionImportFillDlgForm.cbFillRestProduct.Checked then begin
              spFillRevision.ParamByName('G_PRODUCT_PAR_').Clear;
              spFillRevision.ParamByName('G_PRODUCT_').Clear;

              spFillRevision.ParamByName('sklad_').AsInt64 := 0;
              spFillRevision.ParamByName('type_').AsInteger := 2;

              ExecSpTR(spFillRevision);
              ReadList;
            end;

            Screen.Cursor := crDefault;
        end;
      finally
        RevisionImportFillDlgForm.Free;
      end;
    end;
  end;
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

procedure TRevisionForm.tmrScanBarcodesComingTimer(Sender: TObject);
begin
  tmrScanBarcodesComing.Enabled := False;
  if MilliSecondsBetween(Now, FLastBarcodeCame) >= 1800 then
    LoadBarcodeAmounts
  else
    tmrScanBarcodesComing.Enabled := True;
end;

procedure TRevisionForm.LoadBarcodeAmounts;
var i : integer;
begin
  pbBarcodeArrUpdate.Visible := True;
  pbBarcodeArrUpdate.Position := 0;
  pbBarcodeArrUpdate.Properties.Max := High(FTovarRekArr);

  for I := 0 to High(FTovarRekArr) do begin
    UpdAmountInBD(FTovarRekArr[i].Barcode, FTovarRekArr[i].Amount, False);
    pbBarcodeArrUpdate.Position := I;
    Self.Repaint;
  end;

  Readlist;
  SetLength(FTovarRekArr, 0);
  Screen.Cursor := crDefault;
  pbBarcodeArrUpdate.Visible := False;
end;
procedure TRevisionForm.tvMainCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var RevisionUpdForm : TRevisionUpdForm;
begin
  RevisionUpdForm := TRevisionUpdForm.Create(Self);
  with RevisionUpdForm do begin
    try
      OpenMode := omUpdate;
      RecID := spRead.FieldByName('revision').AsLargeInt;
      AmountReal := spRead.FieldByName('Amount_real').AsFloat;

      if ShowModal = mrOk then
        Readlist;
    finally
      Free;
    end;
  end;
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

procedure TRevisionForm.ClearTable;
begin
  spDel.ParamByName('g_tochka_').AsInt64 := CurSklad;
  if ExecSPTR(spDel) then
    Readlist;
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

procedure TRevisionForm.dxBarButton3Click(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_FILLLIST, 0, 0);
end;

procedure TRevisionForm.Timer1Timer(Sender: TObject);
var i, AIndex : integer;
begin
  Timer1.Enabled := False;
  FOverSumm := 0;
  FLossSumm := 0;

  spUpdAmountReal.ParamByName('REVISION_').AsInt64 := spRead.FieldByName('revision').AsLargeInt;
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

procedure TRevisionForm.aImportFromExcelExecute(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_IMPORT, 0, 0);
end;

end.
