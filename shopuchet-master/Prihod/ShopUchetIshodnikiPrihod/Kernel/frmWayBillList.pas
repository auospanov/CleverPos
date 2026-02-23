unit frmWayBillList;

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
  cxGridDBTableView, cxContainer, cxClasses, cxGridLevel, cxGridCustomView,
  cxGrid, cxTextEdit, System.UITypes, cxNavigator, System.Actions;

type
  TWayBillListForm = class(TDBListForm)
    clmMainNUM: TcxGridDBColumn;
    clmMainINIT_DATE: TcxGridDBColumn;
    clmMainPOSTAVSHIK: TcxGridDBColumn;
    clmMainIDN: TcxGridDBColumn;
    clmMainGRUZOPOLUCHATEL: TcxGridDBColumn;
    clmMainTRANSP_NAKLAD: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ViewData; override;
    {procedure InsData; override;
    procedure InsLikeData; override;}
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  WayBillListForm: TWayBillListForm;

implementation

uses frmWayBill;

{$R *.dfm}

procedure TWayBillListForm.ReadList;
begin
  inherited;
  aIns.Visible := False;
  aInsLike.Visible := False;
end;

procedure TWayBillListForm.ViewData;
begin
  ClassForm := TWayBillForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

{procedure TWayBillListForm.InsData;
begin
  ClassForm := TWayBillPayForm.Create(Self);
  try
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TWayBillListForm.InsLikeData;
begin
  ClassForm := TWayBillPayForm.Create(Self);
  try
    inherited;
  finally
    ClassForm.Free;
  end;
end;}

procedure TWayBillListForm.UpdData;
begin
  ClassForm := TWayBillForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TWayBillListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить накладную за "%s" ?',
    [spRead.FieldByName('init_date').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  inherited;
end;

procedure TWayBillListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'WayBill';
  KeyFieldClass := 'WayBill_';
end;

procedure TWayBillListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 39;
  inherited;
end;

end.
