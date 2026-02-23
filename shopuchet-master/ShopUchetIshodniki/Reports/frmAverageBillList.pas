unit frmAverageBillList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDBListRO, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxEditRepositoryItems, cxContainer, FIBDataSet, pFIBDataSet, Vcl.ExtCtrls,
  Vcl.Menus, FIBDatabase, pFIBDatabase, cxClasses, System.Actions, Vcl.ActnList,
  dxBar, dxBarExtItems, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart,
  Vcl.StdCtrls, cxSplitter, cxCalc, FIBQuery, pFIBQuery, pFIBStoredProc,
  IniFiles;

type
  TAverageBillListForm = class(TDBListROForm)
    spBillsCount: TpFIBDataSet;
    dsBillsCount: TDataSource;
    pnlChart: TPanel;
    pnlRight: TPanel;
    splMenu: TcxSplitter;
    grBillsCount: TcxGrid;
    tvBillsCount: TcxGridDBTableView;
    lv1: TcxGridLevel;
    cxGrid1: TcxGrid;
    tvAverageBill: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    Panel4: TPanel;
    Label3: TLabel;
    cxSplitter2: TcxSplitter;
    Panel1: TPanel;
    Label1: TLabel;
    dbchAverageBill: TDBChart;
    dbchBillsCount: TDBChart;
    cxSplitter1: TcxSplitter;
    dcBeginDate: TdxBarDateCombo;
    dcEndDate: TdxBarDateCombo;
    clmAverageBillZ_DATE: TcxGridDBColumn;
    clmAverageBillSUMM: TcxGridDBColumn;
    clmBillsCountZ_DATE: TcxGridDBColumn;
    clmBillsCountCNT: TcxGridDBColumn;
    Panel2: TPanel;
    lbAverageBill: TLabel;
    Panel3: TPanel;
    lbBillsCount: TLabel;
    spRepAvBill: TpFIBStoredProc;
    aPrint: TAction;
    dxbrbtn1: TdxBarButton;
    brsrsSeries2: TBarSeries;
    lnsrsSeries1: TLineSeries;
    procedure dcBeginDateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aPrintExecute(Sender: TObject);
  private
    { Private declarations }
    procedure ReadList; override;
  public
    { Public declarations }
  end;

var
  AverageBillListForm: TAverageBillListForm;

implementation

uses
  unCommonFunc, dmReports;

{$R *.dfm}

procedure TAverageBillListForm.aPrintExecute(Sender: TObject);
var
  TemplateTempFileName : string;
  TempFilePath         : string;
  arrPics : array of String;
  arrParams : array of String;
begin
  SetLength(arrPics, 2);
  SetLength(arrParams, 3);

  {Временный файл для шаблона}
  SetLength(TemplateTempFileName, MAX_PATH + 10);
  SetLength(TempFilePath, MAX_PATH + 10);
  GetTempPath(MAX_PATH + 10, @TempFilePath[1]);
  TempFilePath := PChar(TempFilePath);
  GetTempFileName(PChar(TempFilePath), '', 0, @TemplateTempFileName[1]);
  TemplateTempFileName := PChar(TemplateTempFileName);
  TemplateTempFileName := ChangeFileExt(TemplateTempFileName, '.bmp');

  dbchAverageBill.SaveToBitmapFile(TemplateTempFileName);
  arrPics[0] := TemplateTempFileName;

  {Временный файл для шаблона}
  SetLength(TemplateTempFileName, MAX_PATH + 10);
  SetLength(TempFilePath, MAX_PATH + 10);
  GetTempPath(MAX_PATH + 10, @TempFilePath[1]);
  TempFilePath := PChar(TempFilePath);
  GetTempFileName(PChar(TempFilePath), '', 0, @TemplateTempFileName[1]);
  TemplateTempFileName := PChar(TemplateTempFileName);
  TemplateTempFileName := ChangeFileExt(TemplateTempFileName, '.bmp');

  dbchBillsCount.SaveToBitmapFile(TemplateTempFileName);
  arrPics[1] := TemplateTempFileName;

  arrParams[0] := 'Период с ' + DateToStr(dcBeginDate.Date) + ' по ' + DateToStr(dcEndDate.Date);
  arrParams[1] := lbAverageBill.Caption;
  arrParams[2] := lbBillsCount.Caption;

  ReportsDM.PrintFastReport(61, arrParams, arrPics);
end;

procedure TAverageBillListForm.dcBeginDateChange(Sender: TObject);
begin
  ReadList;
end;

procedure TAverageBillListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    Ini.WriteInteger('AverageBillList', 'pnlChart', pnlChart.Width);
    Ini.WriteInteger('AverageBillList', 'dbchBillsCount', dbchBillsCount.Height);
    Ini.WriteInteger('AverageBillList', 'grBillsCount', grBillsCount.Height);
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;

  tvAverageBill.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvAverageBill.name);
  tvBillsCount.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tvBillsCount.name);
end;

procedure TAverageBillListForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  Year, Month, Day: Word;
begin
  inherited;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    pnlChart.Width := Ini.ReadInteger('AverageBillList', 'pnlChart', Round(SelfWidth/3 * 2));
    dbchBillsCount.Height := Ini.ReadInteger('AverageBillList', 'dbchBillsCount', Round(SelfHeight/2.2));
    grBillsCount.Height := Ini.ReadInteger('AverageBillList', 'grBillsCount', Round(SelfHeight/2.2));
  finally
    Ini.Free;
  end;

  DecodeDate(Date, Year, Month, Day);
  dcBeginDate.Date := EncodeDate(Year, Month, 1);
end;

procedure TAverageBillListForm.ReadList;
begin
  spRead.PARAMByName('DATE_BEGIN_').AsDate := dcBeginDate.Date;
  spRead.PARAMByName('DATE_END_').AsDate := dcEndDate.Date;
  spRead.PARAMByName('G_TOCHKA_').AsInt64 := CurSklad;

  inherited;

  spBillsCount.PARAMByName('DATE_BEGIN_').AsDate := dcBeginDate.Date;
  spBillsCount.PARAMByName('DATE_END_').AsDate := dcEndDate.Date;
  spBillsCount.PARAMByName('G_TOCHKA_').AsInt64 := CurSklad;
  OpenSP(spBillsCount, False);

  spRepAvBill.ParamByName('DATE_BEGIN_').AsDate := dcBeginDate.Date;
  spRepAvBill.ParamByName('DATE_END_').AsDate := dcEndDate.Date;
  spRepAvBill.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
  if ExecSP(spRepAvBill) then begin
    lbAverageBill.Caption := 'Средний чек: ' + spRepAvBill.ParamByName('SUMM_').AsString;
    lbBillsCount.Caption := 'Всего чеков: ' + spRepAvBill.ParamByName('CNT_').AsString;
  end;
end;

end.
