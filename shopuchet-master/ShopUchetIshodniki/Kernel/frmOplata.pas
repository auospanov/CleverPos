unit frmOplata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ActnList, AppEvnts, ExtCtrls,
  StdCtrls, Buttons, DB, dxmdaset, cxDropDownEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar,
  cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, System.UITypes, cxNavigator, System.Actions, Vcl.Menus,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, cxButtons, Math, cxEditRepositoryItems;

type
  TRecOplata = record
    Id: Int64;
    Date: TDate;
    Summ  : Currency;
    Payment: Int64;
  end;

  TArrOplata = Array of TRecOplata;

  TOplataForm = class(TDBDlgForm)
    pn2: TPanel;
    btnIns: TBitBtn;
    btnUpd: TBitBtn;
    btnDel: TBitBtn;
    pnRowCnt: TPanel;
    mdRead: TdxMemData;
    dsRead: TDataSource;
    dtfldReadDatePay: TDateField;
    fltfldReadSummPay: TFloatField;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    strngfldReadPayment_type_str: TStringField;
    gr1: TcxGrid;
    tvOplata: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    clmMainRecId: TcxGridDBColumn;
    clmMainid: TcxGridDBColumn;
    clmMainDate_Pay: TcxGridDBColumn;
    clmMainSumm_Pay: TcxGridDBColumn;
    clmMainPayment_Type: TcxGridDBColumn;
    clmMainPayment_type_str: TcxGridDBColumn;
    mdReadSertId: TIntegerField;
    mdReadSertNum: TStringField;
    mdReadID: TBCDField;
    mdReadPayment_type: TBCDField;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure ReadList;
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvOplataFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
  private
    FArrOplata : TArrOplata;
    FSummZakaz : Currency;
    FSummBonusPayed : Currency;
    FPaymentType : Int64;
    FHelpcc : integer;
    FSumm : Currency;
    FGClient : Int64;
    FIsZakaz : Integer;  //0 - приход, 1 - продажа
    FOplataWasChanged : boolean;
  public
    property ArrOplata : TArrOplata read FArrOplata write FArrOplata;
    property SummZakaz : Currency read FSummZakaz write FSummZakaz;
    property PaymentType : Int64 read FPaymentType write FPaymentType;
    property Helpcc : Integer read FHelpcc write FHelpcc;
    property Summ: Currency read FSumm write FSumm;
    property SummBonusPayed: Currency read FSummBonusPayed write FSummBonusPayed;
    property GClient: Int64 read FGClient write FGClient;
    property IsZakaz: Integer read FIsZakaz write FIsZakaz;
    property OplataWasChanged: Boolean read FOplataWasChanged write FOplataWasChanged;
  end;

var
  OplataForm: TOplataForm;

implementation

uses
  frmPayDetails, unCommonFunc;

{$R *.dfm}

procedure TOplataForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  tvOplata.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvOPlata.name);
end;

procedure TOplataForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var AIndex : Integer;
begin
  inherited;

  if ModalResult = mrOk then begin
    with tvOplata.DataController.Summary do begin
      AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSumm_Pay);
      if (FooterSummaryValues[AIndex] + FSummBonusPayed) > FSummZakaz then begin
        MessageDlg('Сумма платежей не может быть больше суммы заказа! Продолжение невозможно!', mtWarning, [mbOK], 0);
        CanClose := False;
        Exit;
      end;
    end;
  end;  
end;

procedure TOplataForm.aInsExecute(Sender: TObject);
var PayDetailsForm: TPayDetailsForm;
    AIndex : integer;
begin
  PayDetailsForm := TPayDetailsForm.Create(Self);
  with PayDetailsForm do begin
    try
      deDate.Date := Date;
      //не буду ставить способ оплаты "Сертификат", если стоит именно он в накладной, поставлю "Наличный"
      if FPaymentType = 3 then
        PaymentType := 1
      else
        PaymentType := FPaymentType;
      SummZakaz  := FSummZakaz;
      SummBonusPayed := FSummBonusPayed;
      OpenMod := 0;
      GClient := FGClient;
      IsZakaz := FIsZakaz;
      with tvOplata.DataController.Summary do begin
        AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSumm_Pay);
        SummPayments := FooterSummaryValues[AIndex];
      end;
      if ShowModal = mrOk then begin
        mdRead.Insert;
        mdRead.FieldByName('Date_Pay').AsDateTime := deDate.Date;
        mdRead.FieldByName('Payment_Type').AsLargeInt := lePAYMENT_TYPE.EditValue;
        if lePAYMENT_TYPE.EditValue = 3 then begin
          mdRead.FieldByName('Payment_type_str').AsString := 'Сертификат №' + spSertificates.FieldByName('sertificate_num').AsString;
          mdRead.FieldByName('Summ_Pay').AsFloat := MIN(spSertificates.FieldByName('ostatok').AsFloat, edSumm.Value);
          mdRead.FieldByName('SertId').AsLargeInt := leSertificate.EditValue;
        end else begin
          mdRead.FieldByName('Payment_type_str').AsString := lePAYMENT_TYPE.Text;
          mdRead.FieldByName('Summ_Pay').AsFloat := edSumm.Value;
        end;

        ReadList;
        FOplataWasChanged := True;
      end;
    finally
      Free;
    end;
  end
end;

procedure TOplataForm.aUpdExecute(Sender: TObject);
var PayDetailsForm: TPayDetailsForm;
  AIndex : integer;
begin
  PayDetailsForm := TPayDetailsForm.Create(Self);
  with PayDetailsForm do begin
    try
      deDate.Date := mdRead.FieldByName('Date_Pay').AsDateTime;
      edSumm.Value := mdRead.FieldByName('Summ_pay').asFloat;
      PaymentType := mdRead.FieldByName('Payment_type').AsLargeInt;
      SummZakaz  := FSummZakaz;
      SummBonusPayed := FSummBonusPayed;
      OpenMod := 1;
      GClient := FGClient;
      IsZakaz := FIsZakaz;
      with tvOplata.DataController.Summary do begin
        AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSumm_Pay);
        SummPayments := FooterSummaryValues[AIndex] - edSumm.Value;  // ЧТОБЫ НЕ УЧИТЫВАТЬ САМОГО СЕБЯ
      end;
      if ShowModal = mrOk then begin
        mdRead.Edit;
        mdRead.FieldByName('Date_Pay').AsDateTime := deDate.Date;
        mdRead.FieldByName('Summ_pay').asFloat := edSumm.Value;
        mdRead.FieldByName('Payment_Type').AsLargeInt := lePAYMENT_TYPE.EditValue;
        mdRead.FieldByName('Payment_type_str').AsString := lePAYMENT_TYPE.Text;
        ReadList;
        FOplataWasChanged := True;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TOplataForm.aDelExecute(Sender: TObject);
begin
  if mdRead.RecordCount = 1 then begin
    MessageDlg('Нельзя удалить единственный платеж!', mtError, [mbOk], 0);
    Exit;
  end;

  mdRead.Delete;
  ReadList;
  FOplataWasChanged := True;
end;

procedure TOplataForm.ReadList;
var
  Aindex : Integer;
begin
  mdRead.Refresh;
  aUpd.Enabled := (mdRead.RecordCount > 0) and (mdRead.FieldByName('Payment_Type').AsLargeInt <> 3);
  aDel.Enabled := mdRead.RecordCount > 0;
  pnRowCnt.Caption := IntToStr(mdRead.RecordCount);
  with tvOplata.DataController.Summary do begin
    AIndex :=  FooterSummaryItems.IndexOfItemLink(clmMainSumm_Pay);
    Fsumm := FooterSummaryValues[AIndex];
  end;
end;

procedure TOplataForm.tvOplataFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  aUpd.Enabled := mdRead.FieldByName('Payment_Type').AsLargeInt <> 3;
end;

procedure TOplataForm.FormShow(Sender: TObject);
begin
  inherited;
  ReadList;
end;

procedure TOplataForm.btHelpClick(Sender: TObject);
begin
  Application.HelpContext(FHelpcc);
end;

end.
