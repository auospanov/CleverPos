unit frmKassaList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, DB, ExtCtrls, Menus,
  ActnList, dxBar, dxBarExtItems, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, dxSkinsdxBarPainter, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridLevel, cxGridCustomView, cxGrid,
  cxContainer, cxCalendar, System.UITypes, cxNavigator, System.Actions;

type
  TKassaListForm = class(TDBListForm)
    bcNalBeznal: TdxBarCombo;
    clmMainKASSA: TcxGridDBColumn;
    clmMainSUMM: TcxGridDBColumn;
    clmMainACTION_DATE: TcxGridDBColumn;
    clmMainNOTE: TcxGridDBColumn;
    clmMainSTATYA_NAME: TcxGridDBColumn;
    dcBegin: TdxBarDateCombo;
    dcEnd: TdxBarDateCombo;
    clmMainPAYMENT_TYPE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bcNalBeznalChange(Sender: TObject);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure dcBeginChange(Sender: TObject);
  private
    FAction : Integer;
  public
    property Action : Integer read FAction write FAction;
    procedure ReadList; override;
    constructor CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String = '');
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
  end;

var
  KassaListForm: TKassaListForm;

implementation

uses frmRashodPrihod, frmKassa, frmMain, unCommonFunc;

{$R *.dfm}

constructor TKassaListForm.CreateIt(AOwner: TComponent; Prizn: Integer; ActionName : String);
var Caption_ : String;
begin
  FAction := Prizn;
  if FAction = 1 then begin
    Caption_ := 'Расход';
    HelpC := 13;
  end else begin
    Caption_ := 'Приход';
    HelpC := 12;
  end;

  inherited Create(AOwner, Caption_, ActionName);

  Self.Caption := Caption_;
end;

procedure TKassaListForm.dcBeginChange(Sender: TObject);
begin
  Readlist;
end;

procedure TKassaListForm.ReadList;
begin
  spRead.ParamByName('date_begin_').AsDate := dcBegin.date;
  spRead.ParamByName('date_end_').AsDate := dcEnd.Date;
  spRead.ParamByName('action_').AsInteger := FAction;
  spRead.ParamByName('g_payment_type_').AsInteger := bcNalBeznal.ItemIndex;

  inherited;

  if (spRead.FieldByName('sklad').AsInteger = 0) and (spRead.FieldByName('zakaz').AsInteger = 0) then begin
    aView.Enabled := spRead.RecordCount > 0;
    aInsLike.Enabled := spRead.RecordCount > 0;
    aDel.Enabled := spRead.RecordCount > 0;
    aUpd.Enabled := spRead.RecordCount > 0;
  end else begin
    aView.Enabled := False;
    aInsLike.Enabled := False;
    aDel.Enabled := False;
    aUpd.Enabled := False;
  end;
end;

procedure TKassaListForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;

  if (spRead.FieldByName('sklad').AsInteger = 0) and (spRead.FieldByName('zakaz').AsInteger = 0) then begin
    aView.Enabled := spRead.RecordCount > 0;
    aInsLike.Enabled := spRead.RecordCount > 0;
    aDel.Enabled := spRead.RecordCount > 0;
    aUpd.Enabled := spRead.RecordCount > 0;
  end else begin
    aView.Enabled := False;
    aInsLike.Enabled := False;
    aDel.Enabled := False;
    aUpd.Enabled := False;
  end;
end;

procedure TKassaListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'kassa';
  KeyFieldClass := 'kassa_';
end;

procedure TKassaListForm.ViewData;
begin
  ClassForm := TKassaForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    (ClassForm as TKassaForm).ActionStat := FAction;
    (ClassForm as TKassaForm).GPaymentType := bcNalBeznal.ItemIndex;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TKassaListForm.InsData;
begin
  ClassForm := TKassaForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TKassaForm).ActionStat := FAction;
    (ClassForm as TKassaForm).GPaymentType := bcNalBeznal.ItemIndex;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TKassaListForm.InsLikeData;
begin
  ClassForm := TKassaForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TKassaForm).ActionStat := FAction;
    (ClassForm as TKassaForm).GPaymentType := bcNalBeznal.ItemIndex;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TKassaListForm.UpdData;
begin
  ClassForm := TKassaForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TKassaForm).ActionStat := FAction;
    (ClassForm as TKassaForm).GPaymentType := bcNalBeznal.ItemIndex;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TKassaListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить приход/расход "%s" ?',
    [spRead.FieldByName('statya_name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  spDel.ParamByName('g_payment_type_').AsInteger := spRead.FieldByName('g_payment_type').AsInteger;
  INHERITED;
  {spDel.SetVariable('kassa_', spRead.FieldByName('kassa').AsInteger);
  spDel.SetVariable('do_commit_', 1);
  if ExecSP(spDel) then
    Readlist;}
end;

procedure TKassaListForm.FormShow(Sender: TObject);
begin
  inherited;
  dxBarButtonView.Caption := 'Просмотреть';
end;

procedure TKassaListForm.bcNalBeznalChange(Sender: TObject);
begin
  inherited;
  Readlist;
end;

end.
