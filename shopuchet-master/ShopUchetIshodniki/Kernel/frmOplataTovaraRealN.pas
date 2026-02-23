unit frmOplataTovaraRealN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, FIB,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxMemo,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit,
  cxSpinEdit, cxTimeEdit, cxMaskEdit, cxCalendar, StdCtrls, ExtCtrls, FIBQuery,
  pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, ActnList, AppEvnts,
  Buttons, FIBDataSet, pFIBDataSet, System.UITypes, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxNavigator, System.Actions, Vcl.Menus, cxButtons,
  cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TOplataTovaraRealNForm = class(TDBEditForm)
    pnlpn1: TPanel;
    shpsh9: TShape;
    shpsh11: TShape;
    shpsh2: TShape;
    shpsh1: TShape;
    lb1: TLabel;
    lb2: TLabel;
    shpsh3: TShape;
    lb3: TLabel;
    shpsh4: TShape;
    lb4: TLabel;
    shpsh5: TShape;
    lb5: TLabel;
    shpsh6: TShape;
    shpsh7: TShape;
    shpsh8: TShape;
    shpsh10: TShape;
    shpsh12: TShape;
    lb6: TLabel;
    edDate: TcxDateEdit;
    edTime: TcxTimeEdit;
    edOsnovanie: TcxTextEdit;
    lePostavshik: TcxLookupComboBox;
    lePAYMENT_TYPE: TcxLookupComboBox;
    mNote: TcxMemo;
    pnl1: TPanel;
    pnl2: TPanel;
    btnIns: TBitBtn;
    btnDel: TBitBtn;
    pnRowCnt: TPanel;
    pnl3: TPanel;
    grProduct: TcxGrid;
    tvMain: TcxGridDBTableView;
    clmMainPRODUCT_NAME: TcxGridDBColumn;
    clmMainAMOUNT: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainSUMM: TcxGridDBColumn;
    clmMainDISCOUNT_PERC: TcxGridDBColumn;
    clmMainDISCOUNT_SUMM: TcxGridDBColumn;
    clmMainNDS: TcxGridDBColumn;
    clmMainNDS_SUMM: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    spUpdLock: TpFIBStoredProc;
    spPostavshik: TpFIBDataSet;
    dsPostavshik: TDataSource;
    spPaymentType: TpFIBDataSet;
    dsPaymentType: TDataSource;
    spZakazTemp: TpFIBDataSet;
    dsZakazTemp: TDataSource;
    spDel: TpFIBStoredProc;
    procedure aInsExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FClient     : Int64;
    FMode       : Integer;   //Режим. 0 - оплата товара, 1 - возврат товара
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure ClearTempTable;
  public
    property Client: Int64 read FClient write FClient default 0;
    property Mode: Integer read FMode write FMode default 0;    //Режим. 0 - оплата товара, 1 - возврат товара
    procedure Readlist;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  end;

var
  OplataTovaraRealNForm: TOplataTovaraRealNForm;

implementation

uses
  frmOplataTovaraReal, unErrorHandlers, unCommonFunc;

{$R *.dfm}

procedure TOplataTovaraRealNForm.GetData;
begin
  spGetData.ParamByName('IS_VOZVRAT_').AsInteger := FMode;
  inherited;

  if OpenMode <> omInsert then BEGIN
    with spGetData do begin
      edDate.Date := ParamByName('Z_DATE_').AsDate;
      edTime.Time := ParamByName('Z_Time_').AsTime;
      lePostavshik.EditValue := ParamByName('G_CLIENT_').AsInt64;
      lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsInt64;
      edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
      mNote.Text := ParamByName('note_').AsString;
      Readlist;
    end;
  END;

  if OpenMode = omUpdate then begin
    spUpdLock.ParamByName('id_').AsInt64 := RecId;
    if FMode = 1 then
      spUpdLock.ParamByName('TABLE_NAME_').AsString := 'sklad_parent'
    else
      spUpdLock.ParamByName('TABLE_NAME_').AsString := 'zakaz';

    if not spUpdLock.Transaction.InTransaction then
      spUpdLock.Transaction.StartTransaction;
    if not ExecSP(spUpdLock) then begin
      aIns.Enabled := False;
      aUpd.Enabled := False;
      aDel.Enabled := False;
      edDate.ENABLED := FALSE;
      edTime.ENABLED := FALSE;
      edOsnovanie.ENABLED := FALSE;
      mNote.Enabled := FALSE;
      lePostavshik.ENABLED := FALSE;
      lePAYMENT_TYPE.ENABLED := FALSE;
      btnOk.Enabled := FALSE;
      EXIT;
    end;
  end;
end;

function TOplataTovaraRealNForm.CheckParams(var ErrControl: TWinControl): Boolean;
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

  Result := True;
end;

procedure TOplataTovaraRealNForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить продажу товара "%s" ?',
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
  END;
end;

procedure TOplataTovaraRealNForm.aInsExecute(Sender: TObject);
var OplataTovaraRealForm : TOplataTovaraRealForm;
begin
  OplataTovaraRealForm := TOplataTovaraRealForm.Create(Self);
  try
    OplataTovaraRealForm.OpenMode := omInsert;
    OplataTovaraRealForm.Client := FClient;
    OplataTovaraRealForm.ModeZ := FMode;
    IF OplataTovaraRealForm.ShowModal = mrOK THEN begin
      Readlist;
    END;
  finally
    OplataTovaraRealForm.Free;
  end;
end;

procedure TOplataTovaraRealNForm.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  if FMode = 1 then
    Helpc := 60
  else
    HELPC := 59;

  Application.HelpContext(HELPC);
end;

procedure TOplataTovaraRealNForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if Success then
    ClearTempTable;
end;

procedure TOplataTovaraRealNForm.FormShow(Sender: TObject);
begin
  inherited;
  KeyField := 'zakaz_';
  ClearTempTable;      //ОЧИЩАЮ ВРЕМЯНКУ

  CAPTION := 'Оформление оплаты за товар, выданный под реализацию';
  OpenSp(spPostavshik, False);
  lePostavshik.EditValue := FClient;
  lePostavshik.Enabled := False;

  OpenSp(spPaymentType, False);
  lePAYMENT_TYPE.EditValue := 1;   // по умолчанию поставлю наличный расчет

  Readlist;

  //ЕСЛИ ЭТО ВОЗВРАТ ТОВАРА, ТО СТАВЛЮ В spIns ДРУГУЮ ПРОЦЕДУРУ
  IF FMode = 1 THEN BEGIN
    Caption := 'Оформить возврат';
    lb1.Caption := 'Дата возврата';
  END;

  IF OpenMode = omInsert then begin
    edDate.Date := Date;
    edTime.Time := Time;
    btnOk.Enabled := spZakazTemp.RecordCount > 0;
  end;
end;

{procedure TOplataTovaraRealNForm.aUpdExecute(Sender: TObject);
begin
  UpdOplataTovaraRealForm := TUpdOplataTovaraRealForm.Create(Self);
  with UpdOplataTovaraRealForm do begin
    OpenMode := omUpdate;
    RecID := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsInteger;
    Is_spisanie := FIs_spisanie;
    try
      if UpdOplataTovaraRealForm.ShowModal = mrOK then begin
        Readlist;
        edOsnovanie.Modified := True;
      end;
    finally
      UpdOplataTovaraRealForm.Free;
    end;
  end;
end; }

procedure TOplataTovaraRealNForm.ClearTempTable;
begin
  spDel.Params[0].Clear;
  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  ExecSP(spDel);

  if spDel.Transaction.InTransaction then
    spDel.Transaction.Commit;
end;

procedure TOplataTovaraRealNForm.Readlist;
begin
  OpenSP(spZakazTemp, True);
  pnRowCnt.Caption := IntToStr(spZakazTemp.RecordCount);
  aUpd.Enabled := False;//spZakazTemp.RecordCount > 0;
  aDel.Enabled := spZakazTemp.RecordCount > 0;
  btnOk.Enabled := spZakazTemp.RecordCount > 0;
end;

procedure TOplataTovaraRealNForm.SetParams(SP: TpFIBStoredProc);
var AIndex : Integer;
begin
  with SP do begin
    if lePostavshik.EditValue > 0 then
      ParamByName('G_CLIENT_').AsInt64 := lePostavshik.EditValue;
    if lePostavshik.EditValue > 0 then
      ParamByName('G_PAYMENT_TYPE_').AsInt64 := lePAYMENT_TYPE.EditValue;
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    with tvMain.DataController.Summary do
    begin
      AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSUMM);
      ParamByName('SUMM_').AsFloat := FooterSummaryValues[AIndex];
      ParamByName('SUMM_FACT_').AsFloat := FooterSummaryValues[AIndex];
    end;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('Z_DATE_').AsDate := edDate.Date;
    ParamByName('Z_Time_').AsTime := edTime.Time;
    if FMode = 1 then
      ParamByName('is_spisanie_').AsInteger := 3    //ВОЗВРАТ ТОВАРА
    else
      ParamByName('is_spisanie_').AsInteger := 0;  //как обычная продажа

    if (StrToInt(Copy(ExportDataType, 5, 1)) = 1) or (UploadToMobile) then
      ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 1
    else
      ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := 0;
  end;
end;

end.
