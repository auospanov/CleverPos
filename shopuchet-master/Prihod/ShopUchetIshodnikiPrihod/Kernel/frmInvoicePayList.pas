unit frmInvoicePayList;

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
  cxContainer, cxTextEdit, System.UITypes, cxNavigator, System.Actions;

type
  TInvoicePayListForm = class(TDBListForm)
    clmMainINVOICE_PAY: TcxGridDBColumn;
    clmMainNUM: TcxGridDBColumn;
    clmMainINIT_DATE: TcxGridDBColumn;
    clmMainG_CLIENT: TcxGridDBColumn;
    clmMainIDN_CLIENT: TcxGridDBColumn;
    clmMainAGREEMENT: TcxGridDBColumn;
    clmMainADDRESS_STR: TcxGridDBColumn;
    clmMainFIO_DOC: TcxGridDBColumn;
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
  InvoicePayListForm: TInvoicePayListForm;

implementation

uses frmInvoicePay;

{$R *.dfm}

procedure TInvoicePayListForm.ReadList;
begin
  inherited;
  aIns.Visible := False;
  aInsLike.Visible := False;
end;

procedure TInvoicePayListForm.ViewData;
begin
  ClassForm := TInvoicePayForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

{procedure TInvoicePayListForm.InsData;
begin
  ClassForm := TInvoicePayForm.Create(Self);
  try
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TInvoicePayListForm.InsLikeData;
begin
  ClassForm := TInvoicePayForm.Create(Self);
  try
    inherited;
  finally
    ClassForm.Free;
  end;
end;}

procedure TInvoicePayListForm.UpdData;
begin
  ClassForm := TInvoicePayForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TInvoicePayListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить счет на оплату за "%s" ?',
    [spRead.FieldByName('init_date').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  INHERITED;
  {spDel.SetVariable(KeyFieldClass, spRead.FieldByName(KeyFieldList).AsInteger);
  if ExecSP(spDel) then
    Readlist;          }
end;

procedure TInvoicePayListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'INVOICE_PAY';
  KeyFieldClass := 'INVOICE_PAY_';
end;

procedure TInvoicePayListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 37;
  inherited;
end;

end.
