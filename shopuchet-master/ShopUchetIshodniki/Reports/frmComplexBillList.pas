unit frmComplexBillList;

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
  IniFiles, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  dxSkinscxPCPainter, dxSkinsdxBarPainter;

type
  TComplexBillListForm = class(TDBListROForm)
    spBillsCount: TpFIBDataSet;
    cxSplitter2: TcxSplitter;
    dcBeginDate: TdxBarDateCombo;
    dcEndDate: TdxBarDateCombo;
    spRepAvBill: TpFIBStoredProc;
    aPrint: TAction;
    dxbrbtn1: TdxBarButton;
    pnlTop: TPanel;
    pnl1: TPanel;
    lbComplexBill: TLabel;
    dbchtAverageBill: TDBChart;
    splSale1: TcxSplitter;
    pnlLeft: TPanel;
    pnl3: TPanel;
    lbBillsCount: TLabel;
    dbchtBillsCount: TDBChart;
    brsrsSeries2: TBarSeries;
    pnl5: TPanel;
    pnl6: TPanel;
    lbProductsCount: TLabel;
    dbchtTovsCount: TDBChart;
    brsrs1: TBarSeries;
    spTovsCount: TpFIBDataSet;
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
  ComplexBillListForm: TComplexBillListForm;

implementation

uses
  unCommonFunc, dmReports;

{$R *.dfm}

procedure TComplexBillListForm.aPrintExecute(Sender: TObject);
var
  TemplateTempFileName : string;
  TempFilePath         : string;
  arrPics : array of String;
  arrParams : array of String;
begin
  SetLength(arrPics, 3);
  SetLength(arrParams, 3);

  {Временный файл для шаблона}
  SetLength(TemplateTempFileName, MAX_PATH + 10);
  SetLength(TempFilePath, MAX_PATH + 10);
  GetTempPath(MAX_PATH + 10, @TempFilePath[1]);
  TempFilePath := PChar(TempFilePath);
  GetTempFileName(PChar(TempFilePath), '', 0, @TemplateTempFileName[1]);
  TemplateTempFileName := PChar(TemplateTempFileName);
  TemplateTempFileName := ChangeFileExt(TemplateTempFileName, '.bmp');

  dbchtAverageBill.SaveToBitmapFile(TemplateTempFileName);
  arrPics[0] := TemplateTempFileName;

  {Временный файл для шаблона}
  SetLength(TemplateTempFileName, MAX_PATH + 10);
  SetLength(TempFilePath, MAX_PATH + 10);
  GetTempPath(MAX_PATH + 10, @TempFilePath[1]);
  TempFilePath := PChar(TempFilePath);
  GetTempFileName(PChar(TempFilePath), '', 0, @TemplateTempFileName[1]);
  TemplateTempFileName := PChar(TemplateTempFileName);
  TemplateTempFileName := ChangeFileExt(TemplateTempFileName, '.bmp');

  dbchtBillsCount.SaveToBitmapFile(TemplateTempFileName);
  arrPics[1] := TemplateTempFileName;

  {Временный файл для шаблона}
  SetLength(TemplateTempFileName, MAX_PATH + 10);
  SetLength(TempFilePath, MAX_PATH + 10);
  GetTempPath(MAX_PATH + 10, @TempFilePath[1]);
  TempFilePath := PChar(TempFilePath);
  GetTempFileName(PChar(TempFilePath), '', 0, @TemplateTempFileName[1]);
  TemplateTempFileName := PChar(TemplateTempFileName);
  TemplateTempFileName := ChangeFileExt(TemplateTempFileName, '.bmp');

  dbchtTovsCount.SaveToBitmapFile(TemplateTempFileName);
  arrPics[2] := TemplateTempFileName;

  arrParams[0] := 'Период с ' + DateToStr(dcBeginDate.Date) + ' по ' + DateToStr(dcEndDate.Date);
  arrParams[1] := lbComplexBill.Caption;
  arrParams[2] := lbProductsCount.Caption;

  ReportsDM.PrintFastReport(69, arrParams, arrPics);
end;

procedure TComplexBillListForm.dcBeginDateChange(Sender: TObject);
begin
  ReadList;
end;

procedure TComplexBillListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    Ini.WriteInteger('ComplexBillList', 'pnlTop', pnlTop.Height);
    Ini.WriteInteger('ComplexBillList', 'pnlLeft', pnlLeft.Width);
  finally
    Ini.UpdateFile;
    Ini.Free;
  end;
end;

procedure TComplexBillListForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  Year, Month, Day: Word;
begin
  inherited;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    pnlTop.Height := Ini.ReadInteger('ComplexBillList', 'pnlTop', Round(SelfHeight/2));
    pnlLeft.Width := Ini.ReadInteger('ComplexBillList', 'pnlLeft', Round(SelfWidth/2));
  finally
    Ini.Free;
  end;

  DecodeDate(Date, Year, Month, Day);
  dcBeginDate.Date := EncodeDate(Year, Month, 1);
end;

procedure TComplexBillListForm.ReadList;
var s : double;
begin
  Screen.Cursor := crHourGlass;
  try
    spRead.PARAMByName('DATE_BEGIN_').AsDate := dcBeginDate.Date;
    spRead.PARAMByName('DATE_END_').AsDate := dcEndDate.Date;
    spRead.PARAMByName('G_TOCHKA_').AsInt64 := CurSklad;

    inherited;

    spBillsCount.PARAMByName('DATE_BEGIN_').AsDate := dcBeginDate.Date;
    spBillsCount.PARAMByName('DATE_END_').AsDate := dcEndDate.Date;
    spBillsCount.PARAMByName('G_TOCHKA_').AsInt64 := CurSklad;
    OpenSP(spBillsCount, False);

    spTovsCount.PARAMByName('DATE_BEGIN_').AsDate := dcBeginDate.Date;
    spTovsCount.PARAMByName('DATE_END_').AsDate := dcEndDate.Date;
    spTovsCount.PARAMByName('G_TOCHKA_').AsInt64 := CurSklad;
    OpenSP(spTovsCount, False);

    spRepAvBill.ParamByName('DATE_BEGIN_').AsDate := dcBeginDate.Date;
    spRepAvBill.ParamByName('DATE_END_').AsDate := dcEndDate.Date;
    spRepAvBill.ParamByName('G_TOCHKA_ARR_').AsString := '-' + IntToStr(CurSklad) + '-';
    if ExecSP(spRepAvBill) then begin
      lbComplexBill.Caption := 'Среднее количество товара в чеке: ' + spRepAvBill.ParamByName('SUMM_').AsString;
      lbBillsCount.Caption := 'Всего продано чеков: ' + spRepAvBill.ParamByName('CNT_BILLS_').AsString;
      lbProductsCount.Caption := 'Всего продано товаров: ' + spRepAvBill.ParamByName('CNT_TOVS_').AsString;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
