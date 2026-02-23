unit frmProductionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  FIBDataSet, pFIBDataSet, ExtCtrls, Menus, FIBDatabase, pFIBDatabase,
  ActnList, dxBar, dxBarExtItems, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, dxSkinsdxBarPainter,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridLevel, cxGridCustomView, cxGrid, cxContainer, cxCalendar, System.UITypes,
  cxNavigator, System.Actions;

type
  TProductionListForm = class(TDBListForm)
    dcBegin: TdxBarDateCombo;
    dcEnd: TdxBarDateCombo;
    clmMainSKLAD: TcxGridDBColumn;
    clmMainOP_DATE: TcxGridDBColumn;
    clmMainNOTE: TcxGridDBColumn;
    clmMainSTRING_DTLS: TcxGridDBColumn;
    aCalcPreCost: TAction;
    dxbrbtn1: TdxBarButton;
    aPrint: TAction;
    dxbrbtn2: TdxBarButton;
    procedure dcBeginChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure aPrintExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InsData; override;
    procedure ReadList; override;
  end;

var
  ProductionListForm: TProductionListForm;

implementation

uses
  frmProductionTovaraN, dmReports, unCommonFunc;

{$R *.dfm}

{ TProductionForm }

procedure TProductionListForm.ReadList;
begin
  spRead.ParamByName('date_begin_').AsDate := dcBegin.Date;
  spRead.ParamByName('date_end_').AsDate := dcEnd.Date;
  inherited;
  aUpd.Enabled := False;
end;

procedure TProductionListForm.InsData;
begin
  ClassForm := TProductionTovaraNForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;

  {ProductionTovaraNForm := TProductionTovaraNForm.Create(Self);
  try
    ProductionTovaraNForm.OpenMode := omInsert;
    if ProductionTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('SKLAD', ProductionTovaraNForm.RecID, []);
      if tvMain.Controller.FocusedRow <> Nil then begin
        if tvMain.Controller.SelectedRowCount > 0 then
          tvMain.Controller.SelectedRows[0].Selected := False;
        tvMain.Controller.FocusedRow.Selected := True;
      end;
    end;
  finally
    ProductionTovaraNForm.Free;
  end;}
end;

procedure TProductionListForm.aPrintExecute(Sender: TObject);
begin
  if tvMain.Controller.SelectedRowCount = 0 then begin
    MessageDlg('Выберите запись!', mtInformation, [mbOK], 0);
    Exit;
  end;

  ReportsDM.PrepareReport(47);
  ReportsDM.spReport.ParamByName('OTHER_').AsInteger := spRead.FieldByName('other').AsInteger;
  ReportsDM.spReport.ParamByName('SKLAD_').AsInteger := spRead.FieldByName('SKLAD').AsInteger;
  ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
  ReportsDM.ShowReport(0, '');
end;

procedure TProductionListForm.dcBeginChange(Sender: TObject);
begin
  ReadList;
end;

procedure TProductionListForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'SKLAD';
  KeyFieldClass := 'SKLAD_';

  inherited;
end;

procedure TProductionListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 71;
  inherited;
end;

end.
