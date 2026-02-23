unit frmRevisionList;

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
  cxContainer, cxTextEdit, System.UITypes, cxNavigator, System.Actions,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, cxEditRepositoryItems, cxCheckBox, Vcl.StdCtrls, cxSplitter,
  cxCalc, IniFiles;

type
  TRevisionListForm = class(TDBListForm)
    tvMainREVISION_PARENT: TcxGridDBColumn;
    tvMainDATE_BEGIN: TcxGridDBColumn;
    tvMainDATE_END: TcxGridDBColumn;
    tvMainNOTE: TcxGridDBColumn;
    tvMainG_TOCHKA: TcxGridDBColumn;
    clmMainIS_MADE: TcxGridDBColumn;
    dcBegin: TdxBarDateCombo;
    dcEnd: TdxBarDateCombo;
    splSaleMenu: TcxSplitter;
    pnl1: TPanel;
    txtDetailsCount: TStaticText;
    grRevisionDetails: TcxGrid;
    tvDetails: TcxGridDBTableView;
    lv1: TcxGridLevel;
    spRevisionDetails: TpFIBDataSet;
    dsRevisionDetails: TDataSource;
    clmDetailsREVISION: TcxGridDBColumn;
    clmDetailsSKLAD: TcxGridDBColumn;
    clmDetailsAMOUNT_BD: TcxGridDBColumn;
    clmDetailsAMOUNT_REAL: TcxGridDBColumn;
    clmDetailsNAME: TcxGridDBColumn;
    clmDetailsBARCODE: TcxGridDBColumn;
    clmDetailsARTICUL: TcxGridDBColumn;
    clmDetailsColumn1: TcxGridDBColumn;
    clmDetailsColumn2: TcxGridDBColumn;
    clmDetailsColumn3: TcxGridDBColumn;
    aPrint: TAction;
    btn1: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure dcBeginChange(Sender: TObject);
    procedure tvMainFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvMainCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure aPrintExecute(Sender: TObject);
  private
    procedure RefreshChild;
  public
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  RevisionListForm: TRevisionListForm;

implementation

uses frmRevision, unCommonFunc, frmRevisionDlg, dmReports;

{$R *.dfm}

procedure TRevisionListForm.ReadList;
begin
  spRead.PARAMByName('DATE_BEGIN_').AsDate := dcBegin.Date;
  spRead.PARAMByName('DATE_END_').AsDate := dcEnd.Date;
  spRead.PARAMByName('G_TOCHKA_').AsInt64 := CurSklad;

  inherited;

  aPrint.Enabled := spRead.RecordCount > 0;

  RefreshChild;
end;

procedure TRevisionListForm.RefreshChild;
begin
  spRevisionDetails.ParamByName('revision_parent_').AsInt64 := spRead.FieldByName('revision_parent').AsLargeInt;
  OpenSp(spRevisionDetails, True);

  txtDetailsCount.Caption := Format('%.5d', [spRevisionDetails.AllRecordCount]);
end;

procedure TRevisionListForm.tvMainCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  if spRead.FieldByName('is_made').AsInteger = 0 then
    aUpd.Execute
  else
    aView.Execute;
end;

procedure TRevisionListForm.tvMainFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  RefreshChild;
end;

procedure TRevisionListForm.ViewData;
begin
  ClassForm := TRevisionDlgForm.Create(Self);
  try
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsLargeInt;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TRevisionListForm.InsData;
begin
  ClassForm := TRevisionDlgForm.Create(Self);
  try
    inherited;
    Readlist;
  finally
    ClassForm.Free;
  end;
end;

procedure TRevisionListForm.InsLikeData;
begin
  {ClassForm := TRevisionForm.Create(Self);
  try
    inherited;
  finally
    ClassForm.Free;
  end;}
end;

procedure TRevisionListForm.UpdData;
begin
  ClassForm := TRevisionDlgForm.Create(Self);
  try
    inherited;
    Readlist;
  finally
    ClassForm.Free;
  end;
end;

procedure TRevisionListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить ревизию от "%s" ?',
    [spRead.FieldByName('DATE_BEGIN').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
end;

procedure TRevisionListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;

  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings_grid.ini');
  try
    Ini.WriteInteger('RevisionList', 'SplitterPos', grRevisionDetails.Height);
  finally
    Ini.Free;
  end;

  tvMain.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvMain.name);
  tvDetails.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvDetails.name);
end;

procedure TRevisionListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'revision_parent';
  KeyFieldClass := 'revision_parent_';
end;

procedure TRevisionListForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings_grid.ini');
  try
    grRevisionDetails.Height := Ini.ReadInteger('RevisionList', 'SplitterPos', 150);   //у сплиттера не работает положение из ИНИ, приходится выкручиваться высотой cxdvZakazDetails
  finally
    Ini.Free;
  end;
end;

procedure TRevisionListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

procedure TRevisionListForm.aPrintExecute(Sender: TObject);
begin
  ReportsDM.PrepareReport(107);
  ReportsDM.spReport.ParamByName('REVISION_PARENT_').AsInt64 := spRead.FieldByName('revision_parent').AsLargeInt;
  ReportsDM.ShowReport;
end;

procedure TRevisionListForm.dcBeginChange(Sender: TObject);
begin
  Readlist;
end;

end.
