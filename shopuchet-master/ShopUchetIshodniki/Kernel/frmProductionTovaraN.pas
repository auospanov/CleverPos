unit frmProductionTovaraN;

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
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxMemo, DB,
  FIBDataSet, pFIBDataSet, cxDropDownEdit, cxCurrencyEdit, ExtCtrls, StdCtrls,
  cxTextEdit, cxMaskEdit, cxCalendar, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDatabase, pFIBDatabase, ActnList, AppEvnts, Buttons, unCommonFunc, frmPopupTovList, System.UITypes,
  Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions, cxClasses, Vcl.Menus,
  cxButtons, cxEditRepositoryItems, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, FIB,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinscxPCPainter, unLog;

type
  TProductionTovaraNForm = class(TDBEditForm)
    edDate: TcxDateEdit;
    Label7: TLabel;
    lbContent: TLabel;
    lbNote: TLabel;
    Panel2: TPanel;
    Shape12: TShape;
    Shape13: TShape;
    ShapeNote: TShape;
    ShapeNote1: TShape;
    spReadSost: TpFIBDataSet;
    spUpdLock: TpFIBStoredProc;
    mNote: TcxMemo;
    aIns: TAction;
    aDel: TAction;
    aUpd: TAction;
    dsReadSost: TDataSource;
    Panel5: TPanel;
    gr1: TcxGrid;
    tvMain: TcxGridDBTableView;
    clmMainG_PRODUCT_ITEM: TcxGridDBColumn;
    clmMainNAME: TcxGridDBColumn;
    clmMainAMOUNT: TcxGridDBColumn;
    clmMainOSTATOK: TcxGridDBColumn;
    clmMainOSTATOK_AFTER: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    Panel4: TPanel;
    BitBtn12: TBitBtn;
    pnRowCnt: TPanel;
    btnDel: TBitBtn;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    clmMainPRODUCT_NAME: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    cxGridDBColumn1: TcxGridDBColumn;
    clmMainBARCODE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    spZakazTemp: TpFIBDataSet;
    dsZakazTemp: TDataSource;
    spInsTmp: TpFIBDataSet;
    spDel: TpFIBStoredProc;
    clmGridDBSebes: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure peTovarKeyPress(Sender: TObject; var Key: Char);
    procedure spReadSostCalcFields(DataSet: TDataSet);
    procedure edAmountPropertiesChange(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure aDelExecute(Sender: TObject);
  private
    function FillLog : string;
  protected
    procedure Readlist;
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure ClearTempTable;
  public
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  end;

var
  ProductionTovaraNForm: TProductionTovaraNForm;

implementation

uses
  frmProdazhaTovara, PriceListUnSostav;

{$R *.dfm}

procedure TProductionTovaraNForm.aDelExecute(Sender: TObject);
begin
  if tvMain.Controller.SelectedRecordCount = 0 then begin
    MessageDlg('Âûáåðèòå çàïèñü äëÿ óäàëåíèÿ!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  spDel.ParamByName('ZAKAZ_DETAILS_').AsInt64 := spZakazTemp.FieldByName('ZAKAZ_DETAILS').AsLargeInt;
  if ExecSP(spDel) then BEGIN
    if spDel.Transaction.InTransaction then
      spDel.Transaction.Commit;
    Readlist;
  END;
end;

procedure TProductionTovaraNForm.aInsExecute(Sender: TObject);
var PriceListUnSostavForm: TPriceListUnSostavForm;
begin
  PriceListUnSostavForm := TPriceListUnSostavForm.Create(Self);
  with PriceListUnSostavForm do begin
    try
      Typ := 100;
      if ShowModal = mrOk then begin

        with spInsTmp do begin
          if spZakazTemp.Locate('g_product', spRead.FieldByName('g_product').AsLargeInt, []) then
            SelectSQL.Text := 'UPDATE ZAKAZ_DETAILS_TMP K SET K.AMOUNT = K.AMOUNT + :AMOUNT WHERE K.G_PRODUCT = :G_PRODUCT'
          else begin
            SelectSQL.Text := 'INSERT INTO ZAKAZ_DETAILS_TMP (ZAKAZ_DETAILS, G_PRODUCT, AMOUNT,COST_PRICE) VALUES ( GEN_ID(GEN_DETAILS_TMP, 1), :G_PRODUCT, :AMOUNT, (SELECT * FROM GET_PRODUCTION_SELF_PRICE(:G_PRODUCT, :G_TOCHKA)))';
            ParamByName('G_TOCHKA').AsInt64 := CurSklad;
          end;
                    
          ParamByName('G_PRODUCT').AsInt64 := spRead.FieldByName('g_product').AsLargeInt;
          ParamByName('AMOUNT').AsFloat := StrToFloat(MyCurrencyFrameForm.edAmount.Text);
          try
            Open;
            if Transaction.InTransaction then
              Transaction.Commit;

            Readlist;
          except
            on E: EFIBError do begin
              if Transaction.InTransaction then
                Transaction.Rollback;
                MessageDlg('Îøèáêà. Êîä: ' + IntToStr(E.SQLCode) + '. Äåòàëè: ' + E.Message, mtError, [mbOK], 0);
            end;
            on E: Exception do begin
              if Transaction.InTransaction then
                Transaction.Rollback;
                MessageDlg('Îøèáêà: ' + E.Message, mtError, [mbOK], 0);
            end;
          end;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TProductionTovaraNForm.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  HELPC := 71;
  Application.HelpContext(HELPC);
end;

function TProductionTovaraNForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := False;

  if NOT CheckDate(edDate.Date, '01.01.2000', '01.01.2099') then begin
    ErrControl := edDate;
    MessageDlg('Ââåäåíà íåêîððåêòíàÿ äàòà', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TProductionTovaraNForm.ClearTempTable;
begin
  spDel.Params[0].Clear;
  if not spDel.Transaction.InTransaction then
    spDel.Transaction.StartTransaction;

  ExecSP(spDel);

  if spDel.Transaction.InTransaction then
    spDel.Transaction.Commit;
end;

procedure TProductionTovaraNForm.edAmountPropertiesChange(Sender: TObject);
begin
  Readlist;
end;

function TProductionTovaraNForm.FillLog: string;
var logTovar, logOplata : string;
  i, j, mode, AIndex : integer;
  str, str1: string;
  paymentFound : boolean;
  summ : double;
begin
  Result := '';

  // èçìåíåíèÿ òóò íåò, òîëüêî äîáàâëåíèå
  if OpenMode = omInsert then
    Result := FillLogProd(1, edDate.Date, spZakazTemp);
end;

procedure TProductionTovaraNForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  ClearTempTable;      // ÏÎ ÍÀÆÀÒÈÞ ÍÀ ÊÍÎÏÊÓ ÎÒÌÅÍÀ ÒÎÆÅ Î×ÈÙÀÞ ÂÐÅÌßÍÊÓ
end;

procedure TProductionTovaraNForm.FormShow(Sender: TObject);
begin
  inherited;
  edDate.Date := Date;
  Readlist;
end;

procedure TProductionTovaraNForm.peTovarKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TProductionTovaraNForm.Readlist;
begin
  OpenSP(spZakazTemp, False);
  aDel.Enabled := spZakazTemp.RecordCount > 0;

  spReadSost.ParamByName('g_tochka_').AsFloat := CurSklad;
  OpenSP(spReadSost, False);
  pnRowCnt.Caption := IntToStr(spReadSost.RecordCount);
end;

procedure TProductionTovaraNForm.SetParams(SP: TpFIBStoredProc);
begin
  with SP do begin
    ParamByName('G_TOCHKA_').AsInt64  := CurSklad;
    ParamByName('DATE_').AsDate       := edDate.Date;
    ParamByName('NOTE_').AsString     := mNote.Text;
    ParamByName('USER_ID_').AsInt64   := CurrentOfficial;
    ParamByName('LOG_BODY_').AsString := FillLog;
    ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := Integer(UploadToMobile);
  end;
end;

procedure TProductionTovaraNForm.spReadSostCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('name_amount').AsString := DataSet.FieldByName('name').AsString + ' - ' + FormatFloat('0.'.PadRight(2 + FormatSettings.CurrencyDecimals, '0'), DataSet.FieldByName('amount').AsFloat);
end;

end.
