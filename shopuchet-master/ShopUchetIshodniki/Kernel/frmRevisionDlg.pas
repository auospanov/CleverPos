unit frmRevisionDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDBEdit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDatabase, pFIBDatabase, System.Actions, Vcl.ActnList,
  cxEditRepositoryItems, cxEdit, cxClasses, cxContainer, Vcl.AppEvnts,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxControls, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxMemo, cxSpinEdit, cxTimeEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, DateUtils, frmPopupTovList, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, FIBDataSet, pFIBDataSet, cxCurrencyEdit, cxCalc,
  System.Win.ComObj, cxProgressBar, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TRevisionDlgForm = class(TDBEditForm)
    btnMadeRevision: TcxButton;
    tmrLabel: TTimer;
    pnl1: TPanel;
    lb1: TLabel;
    shp1: TShape;
    lb2: TLabel;
    shp4: TShape;
    lbNote: TLabel;
    shpNote: TShape;
    shp2: TShape;
    shp5: TShape;
    shpNote1: TShape;
    mNote: TcxMemo;
    deDateEnd: TcxDateEdit;
    deDateBegin: TcxDateEdit;
    shpTime: TShape;
    lbTime: TLabel;
    shp6: TShape;
    lb3: TLabel;
    shp3: TShape;
    edTimeBegin: TcxTimeEdit;
    shp7: TShape;
    edTimeEnd: TcxTimeEdit;
    lb4: TLabel;
    lb5: TLabel;
    lbHour: TLabel;
    lb8: TLabel;
    lbMin: TLabel;
    lb9: TLabel;
    lbSec: TLabel;
    pnl2: TPanel;
    dsRead: TDataSource;
    pnl3: TPanel;
    pnlActions: TPanel;
    peTovar: TcxPopupEdit;
    lb6: TLabel;
    spInsItem: TpFIBStoredProc;
    spInsHead: TpFIBStoredProc;
    spDel: TpFIBStoredProc;
    btnPrint: TcxButton;
    aPrint: TAction;
    aMadeRevision: TAction;
    aStartRevision: TAction;
    spMadeRevision: TpFIBStoredProc;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    clmMainPRODUCT_NAME: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainBARCODE: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    clmPLACE: TcxGridDBColumn;
    btnOptions: TcxButton;
    pmOptions: TPopupMenu;
    actAddGoodsMass: TAction;
    actAddGoodsFromFile: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    dlgOpenodlg: TOpenDialog;
    pbBarcodeArrUpdate: TcxProgressBar;
    spImport: TpFIBStoredProc;
    spFillRevisionMass: TpFIBStoredProc;
    clmMainOVER_SUMM: TcxGridDBColumn;
    clmMainLOSS_SUMM: TcxGridDBColumn;
    pnlResult: TPanel;
    lblSpisanoTovarovCount: TLabel;
    lblPrihodTovarovCount: TLabel;
    lblSpisanoTovarovSumm: TLabel;
    lblPrihodTovarovSumm: TLabel;
    actDelItem: TAction;
    pmMain: TPopupMenu;
    N3: TMenuItem;
    pnl4: TPanel;
    cxProgressBar1: TcxProgressBar;
    pnl5: TPanel;
    lbl3: TLabel;
    edSearch: TcxTextEdit;
    btnClearSearch: TcxButton;
    aClearSearch: TAction;
    tmrSearch: TTimer;
    lbOverSumm: TLabel;
    lblRevisionMark: TLabel;
    clmMainAMOUNT: TcxGridDBColumn;
    clmAMOUNT_BD: TcxGridDBColumn;
    clmDIFF_SUMM: TcxGridDBColumn;
    spRead: TpFIBDataSet;
    N4: TMenuItem;
    aInsTovarByScaner: TAction;
    NInsTovarByScaner: TMenuItem;
    procedure tmrLabelTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure peClientPropertiesCloseUp(Sender: TObject);
    procedure peClientPropertiesInitPopup(Sender: TObject);
    procedure peTovarKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure aStartRevisionExecute(Sender: TObject);
    procedure aMadeRevisionExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actAddGoodsFromFileExecute(Sender: TObject);
    procedure actAddGoodsMassExecute(Sender: TObject);
    procedure aPrintExecute(Sender: TObject);
    procedure tvMainDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
    procedure actDelItemExecute(Sender: TObject);
    procedure gr1Enter(Sender: TObject);
    procedure gr1Exit(Sender: TObject);
    procedure tvMainEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure tvMainFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure aClearSearchExecute(Sender: TObject);
    procedure edSearchPropertiesChange(Sender: TObject);
    procedure tmrSearchTimer(Sender: TObject);
    procedure spReadAfterPost(DataSet: TDataSet);
    procedure clmDIFF_SUMMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure aInsTovarByScanerExecute(Sender: TObject);
  private
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FRevisionParent : Int64;
    FPopupTovarForm : TPopupTovListForm;
    FTovarName : string;
    FIsMade : Integer;  // проведено, 1 - да, 0 - нет
    FIsFirstRowInserted : Boolean;
    peTovarTag : Int64;
    FDelShortCut : TShortCut;
    FAllowToClose : Boolean; //нельзя закрыть окно не кнопками Сохранить или Завершить
    FInsTovarByScaner : Boolean;  // добавлять товары (строки) сканером, 0 - нет, 1 - да
    procedure Readlist;
    procedure InsItem(Amount : Double; G_PRODUCT : Int64; Barcode : String = '');
    procedure TmrLabelChange;
    procedure ClearTempTable;
    procedure SetDates;
    procedure DisableBtns;
    function InsParent : Boolean;
  public
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  RevisionDlgForm: TRevisionDlgForm;

implementation

uses
  unCommonFunc, dmMain, frmCommonLog, frmClientDateFilter, dmReports;

{$R *.dfm}

procedure TRevisionDlgForm.GetData;
begin
  inherited;
  if spGetData.Transaction.InTransaction then
    spGetData.Transaction.CommitRetaining;

  if OpenMode in [omView, omUpdate] then begin
    with spGetData do begin
      deDateBegin.Date := ParamByName('date_begin_').AsDate;
      edTimeBegin.Time := ParamByName('time_begin_').AsTime;

      IF ParamByName('date_end_').AsDate <> 0 THEN BEGIN
        deDateEnd.Date := ParamByName('date_end_').AsDate;
        edTimeEnd.Time := ParamByName('time_end_').AsTime;
      END;

      mNote.Text := ParamByName('note_').AsString;
      FIsMade := ParamByName('is_made_').AsInteger;

      lblSpisanoTovarovCount.Caption := 'Списано товаров ' + ParamByName('SPIS_AMOUNT_').AsString;
      lblSpisanoTovarovSumm.Caption := 'На сумму ' + ParamByName('SPIS_SUMM_').AsString;
      lblPrihodTovarovCount.Caption := 'Оприходовано товаров ' + ParamByName('PRIHOD_AMOUNT_').AsString;
      lblPrihodTovarovSumm.Caption := 'На сумму ' + ParamByName('PRIHOD_SUMM_').AsString;
    end;
    TmrLabelChange;
  end;

  Readlist;

  if (FIsMade = 0) and (RecId > 0) then begin
    lblRevisionMark.Caption := 'Черновик';
    lblRevisionMark.Font.Color := clRed;
    //if OpenMode = omUpdate then
    //  aStartRevision.Enabled := True;  // непонятно, что это??
  end
  {else if (FIsMade = 0) and (OpenMode in [omView, omUpdate]) then begin
    lbRevisionMark.Caption := 'Ревизия проведена. Изменения невозможны.';
    lbRevisionMark.Font.Color := clTeal;
  end}
  else if (FIsMade = 0) and (OpenMode = omInsert) then begin
    lblRevisionMark.Visible := False;
    //aStartRevision.Enabled := True;
  end
  else if FIsMade = 1 then begin
    DisableBtns;
  end;
end;

//==============================================
// ЭТО СДЕЛАНО, ЧТОБЫ КЛАВИША DEL РАБОТАЛА ТОЛЬКО КОГДА ФОКУС НА ГРИДЕ
procedure TRevisionDlgForm.gr1Enter(Sender: TObject);
begin
  actDelItem.ShortCut := 46;
end;

procedure TRevisionDlgForm.gr1Exit(Sender: TObject);
begin
  actDelItem.ShortCut := 0;
end;

procedure TRevisionDlgForm.tvMainEditing(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; var AAllow: Boolean);
begin
  actDelItem.ShortCut := 0;
end;

procedure TRevisionDlgForm.tvMainFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  actDelItem.ShortCut := 46;
end;

procedure TRevisionDlgForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  actDelItem.ShortCut := 46;
end;
//==============================================

procedure TRevisionDlgForm.aClearSearchExecute(Sender: TObject);
begin
  edSearch.Clear;
  if Assigned(tvMain.Controller.FocusedRow) then
    tvMain.Controller.FocusedRow.Selected := True;
end;

procedure TRevisionDlgForm.actAddGoodsFromFileExecute(Sender: TObject);
var ExcelInstalled : Boolean;
  AFileName: String;
  //Excel: Variant;
  WorkSheet: OLEVariant;
  FData    : OLEVariant;
  X, R, succ, unsucc: Integer;
  Log, str : string;
  CommonLogForm: TCommonLogForm;
  amount : double;
begin
  if dlgOpenodlg.Execute then begin
    if FileExists(dlgOpenodlg.FileName) then begin
      Screen.Cursor := crHourGlass;
      AFileName := dlgOpenodlg.FileName;
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

        if not InsParent then
          Exit;

        for R := 0 to X-1 do begin
          IF Trim(VarToStr(FData[R+1, 1])) <> '' THEN BEGIN
            spInsItem.ParamByName('REVISION_PARENT_').AsInt64 := RecId;
            spInsItem.ParamByName('G_PRODUCT_').Clear;
            spInsItem.ParamByName('DATETIME_').AsDateTime := Now;
            spInsItem.ParamByName('G_TOCHKA_').AsInt64 := Cursklad;
            spInsItem.ParamByName('barcode_').AsString := FData[R+1, 1];
            IF Trim(VarToStr(FData[R+1, 2])) <> '' THEN BEGIN
              try
                spInsItem.ParamByName('AMOUNT_REAL_').AsFloat := StrToFloat(FData[R+1, 2]);
              except
                on E: Exception do begin
                  Log := Log + VarToStr(FData[R+1, 1]) + '. Некорректное число в колонке "Остаток" = "' + VarToStr(FData[R+1, 2]) + '".'#13#10;
                  unsucc := unsucc + 1;
                  Continue;
                end;
              end;

              ExecSPTR(spInsItem);
              if spInsItem.ParamByName('ERR_MSG').AsString = '' then begin
                succ := succ + 1;
              end else begin
                Log := Log + spInsItem.ParamByName('ERR_MSG').AsString + #13#10;
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
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TRevisionDlgForm.actAddGoodsMassExecute(Sender: TObject);
var //TovarNaklForRevisForm: TTovarNaklForRevisForm;
    ClientDateFilterForm: TClientDateFilterForm;
begin
  // никто все равно не юзает накладные в ревизии, пока уберу
  //if bcOstatkiOrNakl.ItemIndex = 0 then begin
    ClientDateFilterForm := TClientDateFilterForm.Create(Self);
    with ClientDateFilterForm do begin
      try
        ModeR := 8;
        Helpc := 42;
        IF ShowModal = mrOK then BEGIN
          if not InsParent then
            Exit;

          if Category <> '' then
            spFillRevisionMass.ParamByName('G_PRODUCT_PAR_').AsString := Category
          else
            spFillRevisionMass.ParamByName('G_PRODUCT_PAR_').Clear;

          if Tovar <> '' then
            spFillRevisionMass.ParamByName('G_PRODUCT_').AsString := Tovar
          else
            spFillRevisionMass.ParamByName('G_PRODUCT_').Clear;

          spFillRevisionMass.ParamByName('revision_parent_').AsInt64 := RecId;
          spFillRevisionMass.ParamByName('sklad_').AsInt64 := 0;
          spInsItem.ParamByName('G_TOCHKA_').AsInt64 := Cursklad;
          ExecSpTR(spFillRevisionMass);
          ReadList;
          spRead.Last;
          mNote.ModifiedAfterEnter := True;
        END;
      Finally
        Free;
      end;
    end;

  {end else begin
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
  end; }
end;

procedure TRevisionDlgForm.actDelItemExecute(Sender: TObject);
begin
  if spRead.RecordCount = 1 then begin
    MessageDlg('Нельзя удалить единственную запись!', mtInformation, [mbOK], 0);
    Exit;
  end;

  spDel.Params[0].Clear;
  spDel.ParamByName('REVISION_').AsInt64 := spRead.FieldByName('revision').AsLargeInt;
  ExecSPTR(spDel);
  Readlist;
  spDel.Params[1].Clear;  // очищаю spDel.ParamByName('REVISION_')
end;

procedure TRevisionDlgForm.aInsTovarByScanerExecute(Sender: TObject);
begin
  FInsTovarByScaner := not FInsTovarByScaner;
  NInsTovarByScaner.Checked := FInsTovarByScaner;
  SaveSettingsIni('RevisionDlg', 'InsTovarByScaner', Integer(FInsTovarByScaner), '');
end;

procedure TRevisionDlgForm.aMadeRevisionExecute(Sender: TObject);
begin
  if MessageDlg('Вы уверены, что закончили ревизию и хотите провести списания/приходы товаров?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  deDateEnd.Date := Date;
  edTimeEnd.Time := Now;

  with spMadeRevision do begin
    ParamByName('REVISION_PARENT_').AsInt64 := REcId;
    ParamByName('DATE_BEGIN_').AsDate := deDateBegin.Date;
    ParamByName('TIME_BEGIN_').AsTime := edTimeBegin.Time;
    ParamByName('DATE_END_').AsDate := deDateEnd.Date;
    ParamByName('TIME_END_').AsTime := edTimeEnd.Time;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('G_TOCHKA_').AsInt64 := Cursklad;

    if ExecSptr(spMadeRevision) then begin
      MessageDlg('Ревизия проведена успешно!' + #10#13 +
                'Произведено приходов товара ' + IntToStr(ParamByname('COUNT_PRIH_').AsInteger)+ #10#13 +
                'Произведено списаний товара ' + IntToStr(ParamByname('COUNT_SPIS_').AsInteger),
                mtInformation, [mbOk], 0);
      if RecId = 0 then
        RecId := ParamByName('REVISION_PARENT_OUT_').AsInt64;

      lblSpisanoTovarovCount.Caption := 'Списано товаров ' + ParamByName('COUNT_SPIS_').AsString;
      lblSpisanoTovarovSumm.Caption := 'На сумму ' + ParamByName('SUMM_SPIS_').AsString;
      lblPrihodTovarovCount.Caption := 'Оприходовано товаров ' + ParamByName('COUNT_PRIH_').AsString;
      lblPrihodTovarovSumm.Caption := 'На сумму ' + ParamByName('SUMM_PRIHOD_').AsString;

      FIsMade := 1;
      DisableBtns;
    end;
  end;
end;

procedure TRevisionDlgForm.ApplicationEvents1Message(var Msg: tagMSG;
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
  //IF Screen.ActiveForm.Name = Self.Name THEN BEGIN
    if Msg.message = WM_KEYDOWN then begin
      if Msg.wParam = 13 then begin
        ClearBuffer;
        // если слишком быстро вводить кол-во и нажать Enter, то получается будто сканером провел
        if (KeysBuffer <> '') and (Length(KeysBuffer) > 4) then begin
          // при сканировании нажатие энтера передавать никуда не надо
          Handled := True;

          if FIsMade = 0 then
            InsItem(1, 0, KeysBuffer);

          KeysBuffer := '';
          gr1.SetFocus;
        end;
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
  //END;
end;

procedure TRevisionDlgForm.aPrintExecute(Sender: TObject);
begin
  ReportsDM.PrepareReport(107);
  ReportsDM.spReport.ParamByName('REVISION_PARENT_').AsInt64 := RecId;
  ReportsDM.ShowReport;
end;

procedure TRevisionDlgForm.aStartRevisionExecute(Sender: TObject);
var dd : TDate; tt : TTIme;
  Res : Boolean;
begin
  {
  Screen.Cursor := crHourGlass;
  Res := False;

  try
    dd := Date;
    tt := Now;
    if RecId = 0 then begin
      spInsHead.ParamByName('DATE_BEGIN_').AsDate := dd;
      spInsHead.ParamByName('TIME_BEGIN_').AsTime := tt;
      spInsHead.ParamByName('NOTE_').AsString := mNote.Text;
      spInsHead.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
      spInsHead.ParamByName('IS_MADE_').AsInteger := 0;
      Res := ExecSPTR(spInsHead);
    end;

    if (Res) or (OpenMode = omUpdate) then begin
      deDateBegin.Date := dd;
      edTimeBegin.Time := tt;
      peTovar.Enabled  := True;
      tmrLabel.Enabled := True;
      lblRevisionMark.Caption := 'Ревизия в процессе';
      lblRevisionMark.Font.Color := clRed;
      aStartRevision.Enabled := False;
      btnOk.Enabled := True;
      btnOk.Visible := True;
      btnCancel.Enabled := not btnOk.Enabled;
      btnCancel.Visible := btnCancel.Enabled;

      if (RecId = 0) and (Res) then
        RecId := spInsHead.ParamByName('REVISION_PARENT_').AsInt64;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
  }
end;

procedure TRevisionDlgForm.btn1Click(Sender: TObject);
begin
  //KeysBuffer := edt1.Text;
  //InsItem(1, 0, KeysBuffer);
end;

procedure TRevisionDlgForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  tvMain.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvMain.name);

  if (FAllowToClose = False) and not (((OpenMode = omInsert) and (spRead.RecordCount = 0))
  or (FIsMade = 1))then
    Action := TCloseAction.caNone;
end;

procedure TRevisionDlgForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  { теперь это не нужно, все изменения сразу садятся в базу
  if ModalResult <> mrOk THEN BEGIN
    if (RecId = 0) and (OpenMode = omInsert) and (spRead.RecordCount > 0) then begin
      if MessageDlg('Вы нажали кнопку "Закрыть", не сохранив, все данные будут удалены.'#13#10'Вы уверены, что хотите продолжить?',
      mtWarning, [mbYes, mbNo], 0) = mrNo then begin
        CanClose := False;
        Exit;
      end;

      spDel.ParamByName('REVISION_PARENT_').AsInt64 := RecId;
      ExecSpTr(spDel);
    end
    else if (FIsMade = 0) and (OpenMode = omUpdate) and (mNote.ModifiedAfterEnter) then begin
      if MessageDlg('Вами были сделаны изменения. Вы уверены, что хотите выйти не сохранив их?',
      mtWarning, [mbYes, mbNo], 0) = mrNo then begin
        CanClose := False;
        Exit;
      end;
    end;
  END;
  }

  FAllowToClose := ModalResult = mrOk;

  inherited;

  //ClearTempTable;      // ПО НАЖАТИЮ НА КНОПКУ ОТМЕНА ТОЖЕ ОЧИЩАЮ ВРЕМЯНКУ
end;

procedure TRevisionDlgForm.ClearTempTable;
begin
  spDel.Params[0].Clear;
  ExecSPTR(spDel);
end;

procedure TRevisionDlgForm.clmDIFF_SUMMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Value < 0 then begin
    if AViewInfo.Selected then
      ACanvas.Font.Color:= clWhite
    else
      ACanvas.Font.Color:= clRed
  end;
end;

procedure TRevisionDlgForm.DisableBtns;
begin
  mNote.Enabled := False;
  aMadeRevision.Enabled := False;
  peTovar.Enabled := False;
  clmMainAmount.Options.Editing := False;
  lblRevisionMark.Caption := 'Ревизия завершена. Изменения невозможны.';
  lblRevisionMark.Font.Color := clTeal;
  btnOk.Enabled := False;
  btnOk.Visible := False;
  btnCancel.Enabled := not btnOk.Enabled;
  btnCancel.Visible := btnCancel.Enabled;
  btnOptions.Enabled := False;
  actAddGoodsMass.Enabled := False;
  actAddGoodsFromFile.Enabled := False;
  pnlActions.Visible := False;
  pnlResult.Visible := True;
  actDelItem.Enabled := False;
  aPrint.Enabled := True;
end;

procedure TRevisionDlgForm.edSearchPropertiesChange(Sender: TObject);
begin
  tmrSearch.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edSearch.Text <> '' then
    tmrSearch.Enabled := True
  else BEGIN
    with spRead do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

function TRevisionDlgForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if spRead.RecordCount = 0 then begin
    MessageDlg('Вы не добавили ни одного товара в ревизию! Сохранение невозможно.', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TRevisionDlgForm.SetDates;
begin
  if (FIsFirstRowInserted = false) and (OpenMode = omInsert) then begin
    deDateBegin.Date := Date;
    edTimeBegin.Time := Now;
    tmrLabel.Enabled := True;
    lblRevisionMark.Visible := True;
    FIsFirstRowInserted := True;
  end;
end;

procedure TRevisionDlgForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('DATE_BEGIN_').AsDate := deDateBegin.Date;
    ParamByName('TIME_BEGIN_').AsTime := edTimeBegin.Time;
    IF deDateEnd.CurrentDate > 0 THEN BEGIN
      ParamByName('DATE_END_').AsDate := deDateEnd.Date;
      ParamByName('TIME_END_').AsTime := edTimeEnd.Time;
    END;

    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
    ParamByName('IS_MADE_').AsInteger := FIsMade;
  end;
end;

procedure TRevisionDlgForm.spReadAfterPost(DataSet: TDataSet);
var Oldsklad : Int64;
begin
  inherited;
  Oldsklad := spRead.FieldByName('revision').AsLargeInt;
  Readlist;
  spRead.Locate('revision', Oldsklad, []);
  mNote.ModifiedAfterEnter := True;
end;

procedure TRevisionDlgForm.FormCreate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

  FPopupTovarForm := TPopupTovListForm.Create(Self);
  FPopupTovarForm.spRead.SQLs.SelectSQL.Text := 'select G.g_product as id, ' +
                                                '       G.name, ' +
                                                '       G.articul, ' +
                                                '       G.barcode, ' +
                                                '       G.price ' +
                                                '  from g_product G ' +
                                                'where G.is_active = 1 ' +
                                                'and G.is_category = 0 ' +
                                                'ORDER BY G.NAME, G.ARTICUL, G.G_PRODUCT';
end;

procedure TRevisionDlgForm.FormShow(Sender: TObject);
begin
  inherited;
  tvMain.RestoreFromIniFile('Settings_grid.ini', False, False, [], Self.Name + '-' + tvMain.Name);

  FIsFirstRowInserted := False;

  FInsTovarByScaner := ReadIntSettingsIni('RevisionDlg', 'InsTovarByScaner', 0) = 1;
  NInsTovarByScaner.Checked := FInsTovarByScaner;

  //if Screen.Height <= 600 then begin
  //  Height := ScaleDimension(570);
  //end;

  // чтобы клиент сразу мог вбивать сканером, поставлю выделенным cxGrid
  gr1.SetFocus;
end;

procedure TRevisionDlgForm.InsItem(Amount : Double; G_PRODUCT : Int64; Barcode : String = '');
begin
  if Barcode = '' then
    if spRead.Locate('g_product', G_PRODUCT, []) then
      Exit;

  if not InsParent then
    Exit;

  spInsItem.ParamByName('REVISION_PARENT_').AsInt64 := RecId;
  spInsItem.ParamByName('AMOUNT_REAL_').AsFloat := Amount;
  spInsItem.ParamByName('G_PRODUCT_').AsFloat := G_PRODUCT;
  spInsItem.ParamByName('DATETIME_').AsDateTime := Now;
  spInsItem.ParamByName('G_TOCHKA_').AsInt64 := Cursklad;
  spInsItem.ParamByName('BARCODE_').AsString := Barcode;
  spInsItem.ParamByName('PREFIX_').AsString := ScalesPrefix;
  spInsItem.ParamByName('INS_TOVAR_BY_SCANER_').AsInteger := Integer(FInsTovarByScaner);

  if ExecSPTR(spInsItem) then begin
    Readlist;
    if spRead.RecordCount > 0 then
      spRead.Locate('revision', spInsItem.ParamByName('revision_').AsInt64, []);
    mNote.ModifiedAfterEnter := True;
  end;
end;

function TRevisionDlgForm.InsParent : Boolean;
begin
  Result := false;

  if (OpenMode = omInsert) and (RecId = 0) then begin
    SetDates;
    SetParams(spIns);
    if not ExecSP(spIns) then
      Exit;

    RecId    := spIns.ParamByName('REVISION_PARENT_').AsInt64;
    OpenMode := omUpdate;
  end;

  Result := true;
end;

procedure TRevisionDlgForm.peClientPropertiesCloseUp(Sender: TObject);
begin
  if FPopupTovarForm.AcceptRes then begin
    InsItem(0, FPopupTovarForm.spRead.FieldByName('ID').AsLargeInt, '');
    FPopupTovarForm.edBarcode.Text := '';
  end;
end;

procedure TRevisionDlgForm.peClientPropertiesInitPopup(Sender: TObject);
begin
  peTovar.DroppedDown := True;
  FPopupTovarForm.arefresh.Execute;
end;

procedure TRevisionDlgForm.peTovarKeyPress(Sender: TObject; var Key: Char);
begin
  if peTovar.Text <> '' then begin
    FPopupTovarForm.edBarcode.Text := peTovar.Text;
    peClientPropertiesInitPopup(Sender);
  end;
end;

procedure TRevisionDlgForm.Readlist;
begin
  spRead.ParamByName('revision_parent_').AsInt64 := RecId;
  OpenSp(spRead, True);
  btnOk.Enabled  := spRead.RecordCount > 0;
  btnOk.Visible := btnOk.Enabled;
  btnCancel.Enabled := not btnOk.Enabled;
  btnCancel.Visible := btnCancel.Enabled;
  aPrint.Enabled := (spRead.RecordCount > 0) and (FIsMade = 1);  // доступна только если ревизия завершена
  aMadeRevision.Enabled := (spRead.RecordCount > 0) and (FIsMade = 0);
  actDelItem.Enabled := (spRead.RecordCount > 0) and (FIsMade = 0);

  if (OpenMode = omUpdate) and (FIsMade = 0) then
    tmrLabel.Enabled := True;
end;

procedure TRevisionDlgForm.tmrLabelTimer(Sender: TObject);
begin
  TmrLabelChange;
end;

procedure TRevisionDlgForm.tmrSearchTimer(Sender: TObject);
var s : string;
begin
  tmrSearch.Enabled := False;
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

procedure TRevisionDlgForm.tvMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
var
  AIndex : Integer;
  FOverSumm : Double;
  FLossSumm : Double;
begin
  with tvMain.DataController.Summary do begin
    AIndex := FooterSummaryItems.IndexOfItemLink(clmMainLOSS_SUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      FLossSumm := FooterSummaryValues[AIndex];

    AIndex := FooterSummaryItems.IndexOfItemLink(clmMainOVER_SUMM);
    if not VarIsNull(FooterSummaryValues[AIndex]) then
      FOverSumm := FooterSummaryValues[AIndex];
  end;

  lbOverSumm.Caption := 'Товаров ' + spRead.RecordCount.ToString() + '. Сумма излишков ' + FloatToStr(FOverSumm) + '. Сумма потерь ' + FloatToStr(FLossSumm) + '.';
end;

procedure TRevisionDlgForm.tvMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AGridSite: TcxGridSite;
  AGridView: TcxGridDBTableView;
begin
  if Key = VK_RETURN then
  begin
    AGridSite := Sender as TcxGridSite;
    AGridView := AGridSite.GridView as TcxGridDBTableView;
    AGridView.Controller.FocusNextRecord(AGridView.Controller.FocusedRecordIndex, not (ssShift in Shift), true, false, false);
    Key := 0;
  end;
end;

procedure TRevisionDlgForm.TmrLabelChange;
var t1, t2 : TDAteTime;
  secs : INt64;
begin
  t1 := deDateBegin.Date + edTimeBegin.Time;

  if deDateEnd.CurrentDate > 0 then
    t2 := deDateEnd.Date + edTimeEnd.Time
  else
    t2 := Now;

  secs := MinutesBetween(t1, t2);
  lbHour.Caption := LPad(IntToStr(secs div MinsPerDay), 2, '0');
  lbMin.Caption := LPad(IntToStr((secs div MinsPerHour) mod HoursPerDay), 2, '0');
  lbSec.Caption := LPad(IntToStr(secs mod MinsPerHour), 2, '0');
end;

end.
