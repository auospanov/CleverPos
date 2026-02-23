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
  cxGrid, cxContainer, cxTextEdit, System.UITypes, cxNavigator, System.Actions,
  cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TDiscountListForm = class(TDBListForm)
    dxBarCombo: TdxBarCombo;
    clmMainG_DISCOUNT: TcxGridDBColumn;
    clmMainG_PRODUCT: TcxGridDBColumn;
    cxgrdbclmnMainG_PRODUCT_NAME: TcxGridDBColumn;
    cxgrdbclmnMainDATE_BEGIN: TcxGridDBColumn;
    cxgrdbclmnMainDATE_END: TcxGridDBColumn;
    cxgrdbclmnMainNAME: TcxGridDBColumn;
    cxgrdbclmnMainPRICE: TcxGridDBColumn;
    cxgrdbclmnMainSKIDKA_PROC: TcxGridDBColumn;
    cxgrdbclmnMainSKIDKA_SUM: TcxGridDBColumn;
    cxgrdbclmnMainColumn1: TcxGridDBColumn;
    clmTOCHKA_NAME: TcxGridDBColumn;
    clmMainG_PRODUCT_PAR_NAME: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    clmMainBARCODE: TcxGridDBColumn;
    clmMainNOMENCLATUR_NUM: TcxGridDBColumn;
    aDelNolOstatok: TAction;
    btn1: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure dxBarComboChange(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aDelNolOstatokExecute(Sender: TObject);
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

uses frmDiscount, frmMain, unCommonFunc;

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
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsLargeInt;
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
var i : integer;
  ArrIdL : TArrId;
begin
  ClassForm := TDiscountForm.Create(Self);
  try
    {Вызываем метод предка}
    SetLength(ArrIdL, tvMain.Controller.SelectedRowCount);
    for I := 0 to tvMain.Controller.SelectedRowCount - 1 do begin
      ArrIdL[i].Id := tvMain.Controller.SelectedRecords[i].Values[clmMainG_DISCOUNT.Index];
      ArrIdL[i].IdTov := tvMain.Controller.SelectedRecords[i].Values[clmMainG_PRODUCT.Index];
      ArrIdL[i].Price := tvMain.Controller.SelectedRecords[i].Values[cxgrdbclmnMainPRICE.Index];
    end;
    (ClassForm as TDiscountForm).ArrId := ArrIdL;
    (ClassForm as TDiscountForm).TovarName := spRead.FieldByName('G_PRODUCT_NAME').AsString;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountListForm.aDelExecute(Sender: TObject);
var i: integer;
    str : string;
begin
  if tvMain.Controller.SelectedRowCount = 1 then
    str := 'Удалить акцию?'
  else
    str := 'Удалить группу акций?';


  if MessageDlg(Format(str,
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  try
    Screen.Cursor := crHourGlass;
    for i := 0 to tvMain.Controller.SelectedRowCount - 1 do begin
      try
        spDel.ParamByName('g_discount_').AsInt64 := tvMain.Controller.SelectedRecords[i].Values[clmMainG_DISCOUNT.Index];
        if not ExecSPTR(spDel) then begin
          ReadList;
          Exit;
        end;
      except
      end;
    end;
  finally
    Readlist;
    Screen.Cursor := crDefault;
  end;
end;

procedure TDiscountListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'g_Discount';
  KeyFieldClass := 'g_Discount_';
end;

procedure TDiscountListForm.FormShow(Sender: TObject);
begin
  inherited;
  if High(SkladArr) <= 0 then
   clmTOCHKA_NAME.Destroy;
end;

procedure TDiscountListForm.dxBarComboChange(Sender: TObject);
begin
  inherited;
  ReadList;
end;

procedure TDiscountListForm.aDelNolOstatokExecute(Sender: TObject);
var i: integer;
    str : string;
begin
  if MessageDlg('Удалить все акции по товарам с нулевым остатком?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  try
    Screen.Cursor := crHourGlass;
    spDel.ParamByName('g_discount_').AsInt64 := -1000;
    if ExecSPTR(spDel) then begin
      ShowMessage('Акции успешно удалены!');
      ReadList;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDiscountListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 10;
  inherited;
end;

end.
