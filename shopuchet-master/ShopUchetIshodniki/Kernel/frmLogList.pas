unit frmLogList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDBListRO, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxEditRepositoryItems, cxContainer, FIBDataSet, pFIBDataSet, Vcl.ExtCtrls,
  Vcl.Menus, FIBDatabase, pFIBDatabase, cxClasses, System.Actions, Vcl.ActnList,
  dxBar, dxBarExtItems, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinscxPCPainter, dxSkinsdxBarPainter;

type
  TLogListForm = class(TDBListROForm)
    clmMainLOG_OPER: TcxGridDBColumn;
    clmMainODATE: TcxGridDBColumn;
    clmMainOPERATION: TcxGridDBColumn;
    clmMainG_OFFICIAL_FIO: TcxGridDBColumn;
    clmMainHEADER: TcxGridDBColumn;
    dcDateBegin: TdxBarDateCombo;
    dcDateEnd: TdxBarDateCombo;
    aView: TAction;
    dxbrbtn1: TdxBarButton;
    clmMainColumn1: TcxGridDBColumn;
    procedure dcDateBeginChange(Sender: TObject);
    procedure tvMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure aViewExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ReadList; override;
  end;

var
  LogListForm: TLogListForm;

implementation

uses
  frmCommonLog, dmMain, unCommonFunc;

{$R *.dfm}

procedure TLogListForm.aViewExecute(Sender: TObject);
var CommonLogForm: TCommonLogForm;
begin
  CommonLogForm := TCommonLogForm.Create(Self);
  try
    if MainDm.spReadUniversal.Active then
      MainDm.spReadUniversal.Close;
    MainDm.spReadUniversal.SelectSQL.Text := 'select body from log_oper where log_oper = :id';
    MainDm.spReadUniversal.ParamByName('Id').AsInt64 := spRead.FieldByName('log_oper').AsLargeInt;
    OpenSp(MainDm.spReadUniversal, False);
    CommonLogForm.mMain.Text := 'Дата и время: ' + spRead.FieldByName('ODate').AsString + CRLF;
    CommonLogForm.mMain.Text := CommonLogForm.mMain.Text + 'Действие: ' + spRead.FieldByName('OPERATION').AsString + CRLF;
    CommonLogForm.mMain.Text := CommonLogForm.mMain.Text + 'Пользователь: ' + spRead.FieldByName('G_OFFICIAL_FIO').AsString + CRLF;
    CommonLogForm.mMain.Text := CommonLogForm.mMain.Text + '==============================' + CRLF + CRLF;
    CommonLogForm.mMain.Text := CommonLogForm.mMain.Text + MainDm.spReadUniversal.FieldByName('body').AsString;
    CommonLogForm.ShowModal;
  finally
    CommonLogForm.Free;
    MainDm.spReadUniversal.Close;
  end;
end;

procedure TLogListForm.dcDateBeginChange(Sender: TObject);
begin
  Readlist;
end;

procedure TLogListForm.FormShow(Sender: TObject);
begin
  inherited;
  Readlist;
end;

procedure TLogListForm.ReadList;
begin
  spRead.ParamByName('date_begin_').AsDate := dcDateBegin.date;
  spRead.ParamByName('date_end_').AsDate := dcDateEnd.Date;

  inherited;

  AvIEW.Enabled := spRead.RecordCount > 0;
end;

procedure TLogListForm.tvMainCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  aView.Execute;
end;

end.
