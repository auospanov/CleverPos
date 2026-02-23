unit frmDiscountList;

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
  cxDBData, dxSkinsdxBarPainter, cxCheckBox, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridLevel, cxGridCustomView,
  cxGrid, cxContainer, cxTextEdit, System.UITypes, cxNavigator, System.Actions;

type
  TDiscountListForm = class(TDBListForm)
    dxBarCombo: TdxBarCombo;
    cxgrdbclmnMainG_DISCOUNT: TcxGridDBColumn;
    cxgrdbclmnMainG_PRODUCT: TcxGridDBColumn;
    cxgrdbclmnMainG_PRODUCT_NAME: TcxGridDBColumn;
    cxgrdbclmnMainDATE_BEGIN: TcxGridDBColumn;
    cxgrdbclmnMainDATE_END: TcxGridDBColumn;
    cxgrdbclmnMainNAME: TcxGridDBColumn;
    cxgrdbclmnMainPRICE: TcxGridDBColumn;
    cxgrdbclmnMainSKIDKA_PROC: TcxGridDBColumn;
    cxgrdbclmnMainSKIDKA_SUM: TcxGridDBColumn;
    cxgrdbclmnMainColumn1: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure dxBarComboChange(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  DiscountListForm: TDiscountListForm;

implementation

uses frmDiscount, frmMain;

{$R *.dfm}

procedure TDiscountListForm.ReadList;
begin
  spRead.ParamByName('IS_ALL_').AsInteger := dxBarCombo.ItemIndex;
  inherited;
end;

procedure TDiscountListForm.ViewData;
begin
  ClassForm := TDiscountForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    (ClassForm as TDiscountForm).TovarName := spRead.FieldByName('G_PRODUCT_NAME').AsString;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountListForm.InsData;
begin
  ClassForm := TDiscountForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountListForm.InsLikeData;
begin
  ClassForm := TDiscountForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TDiscountForm).TovarName := spRead.FieldByName('G_PRODUCT_NAME').AsString;    
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountListForm.UpdData;
begin
  ClassForm := TDiscountForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TDiscountForm).TovarName := spRead.FieldByName('G_PRODUCT_NAME').AsString;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить акцию "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
  {spDel.SetVariable(KeyFieldList, spRead.FieldByName(KeyFieldClass).AsInteger);
  if ExecSP(spDel) then
    Readlist;}
end;

procedure TDiscountListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'g_Discount';
  KeyFieldClass := 'g_Discount_';
end;

procedure TDiscountListForm.dxBarComboChange(Sender: TObject);
begin
  inherited;
  ReadList;
end;

procedure TDiscountListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 10;
  inherited;
end;

end.
