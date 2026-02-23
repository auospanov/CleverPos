unit frmSalesOstBySkladList;

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
  dxSkinWhiteprint, cxEditRepositoryItems;

type
  TSalesOstBySkladListForm = class(TDBListForm)
    clmMainNAME: TcxGridDBColumn;
    tvMainBARCODE: TcxGridDBColumn;
    tvMainARTICUL: TcxGridDBColumn;
    tvMainAMOUNT: TcxGridDBColumn;
    tvMainAMOUNT_SOLD: TcxGridDBColumn;
    dcDateBegin: TdxBarDateCombo;
    dcDateEnd: TdxBarDateCombo;
    aExportToExcel: TAction;
    dxBarButton2: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aExportToExcelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    constructor CreateIt(AOwner: TComponent; DateBegin: TDate; DateEnd : TDate; ActionName : String);
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  SalesOstBySkladListForm: TSalesOstBySkladListForm;

implementation

uses frmGUnit, unCommonFunc;

{$R *.dfm}

constructor TSalesOstBySkladListForm.CreateIt(AOwner: TComponent; DateBegin: TDate; DateEnd : TDate;  ActionName : String);
begin
  inherited Create(AOwner, 'Остаток товаров и продажи за период', ActionName);

  dcDateBegin.Date := DateBegin;
  dcDateEnd.Date := DateEnd;
end;

procedure TSalesOstBySkladListForm.ReadList;
begin
  spRead.ParamByName('BEGIN_DATE_').AsDate  := dcDateBegin.Date;
  spRead.ParamByName('END_DATE_').AsDate    := dcDateEnd.Date;
  spRead.ParamByName('G_TOCHKA_').AsInt64 := CurSklad;
  inherited;
end;

procedure TSalesOstBySkladListForm.ViewData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsLargeInt;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TSalesOstBySkladListForm.InsData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TSalesOstBySkladListForm.InsLikeData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TSalesOstBySkladListForm.UpdData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TSalesOstBySkladListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить единицу измерения "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
end;

procedure TSalesOstBySkladListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'g_unit';
  KeyFieldClass := 'g_unit_';
end;

procedure TSalesOstBySkladListForm.FormShow(Sender: TObject);
var i : Integer;
  ADBColumn: TcxCustomGridTableItem;
  COL : TcxGridDBColumn;
begin
  // в общем так, если складов несколько, то надо отразить остатки в гриде
  // т.к. я не знаю сколько складов, то пришлось делать через динамический запрос
  // вначале закрываю spReadTovar, т.к. эта процедура вызывается еще при переключении складов
  spRead.Close;

  spRead.SelectSQL.Text := 'SELECT NAME, '#13#10+
                           '       BARCODE, '#13#10+
                           '       ARTICUL, '#13#10+
                           '       COALESCE((SELECT LT.AMOUNT - LT.AMOUNT_RESERVE FROM LT_SKLAD_PRODUCT LT '#13#10+
                           '                WHERE LT.G_PRODUCT = GP.G_PRODUCT AND LT.G_TOCHKA = :G_TOCHKA_), 0) AMOUNT, '#13#10+
                           '       COALESCE((SELECT SUM(AMOUNT) FROM ZAKAZ Z, ZAKAZ_DETAILS ZD '#13#10+
                           '                WHERE Z.Z_DATE BETWEEN :BEGIN_DATE_ AND :END_DATE_ '#13#10+
                           '                AND Z.ZAKAZ = ZD.ZAKAZ '#13#10+
                           '                AND ZD.G_PRODUCT = GP.G_PRODUCT '#13#10+
                           '                AND Z.G_TOCHKA = :G_TOCHKA_ '#13#10+
                           '                AND Z.NOT_MINUS_OSTATOK = 0 '#13#10+
                           '                AND Z.IS_SPISANIE IN (0,2)), 0) AMOUNT_SOLD'#13#10;
  if High(SkladArr) > 0 then begin
    for I := 0 to High(SkladArr) do begin
      tvMain.FindItemByName('tvMainAmount' + I.ToString).Free;
      tvMain.FindItemByName('tvMainAmountSold' + I.ToString).Free;
    end;

    for I := 0 to High(SkladArr) do
      if SkladArr[i].ID <> CurSklad then begin
        spRead.SelectSQL.Text := spRead.SelectSQL.Text + ', ';
        spRead.SelectSQL.Text := spRead.SelectSQL.Text + ' COALESCE((SELECT LT.AMOUNT - LT.AMOUNT_RESERVE FROM LT_SKLAD_PRODUCT LT '#13#10+
                                                   '                WHERE LT.G_PRODUCT = GP.G_PRODUCT AND LT.G_TOCHKA = ' + SkladArr[i].ID.ToString + '), 0) AMOUNT' + I.ToString + ', '#13#10+
                                                   '       COALESCE((SELECT SUM(AMOUNT) FROM ZAKAZ Z, ZAKAZ_DETAILS ZD '#13#10+
                                                   '                WHERE Z.Z_DATE BETWEEN :BEGIN_DATE_ AND :END_DATE_ '#13#10+
                                                   '                AND Z.ZAKAZ = ZD.ZAKAZ '#13#10+
                                                   '                AND ZD.G_PRODUCT = GP.G_PRODUCT '#13#10+
                                                   '                AND Z.NOT_MINUS_OSTATOK = 0 '#13#10+
                                                   '                AND Z.IS_SPISANIE IN (0,2) '#13#10+
                                                   '                AND Z.G_TOCHKA = ' + SkladArr[i].ID.ToString + '), 0) AMOUNT_SOLD' + I.ToString + ' ' + #13#10;

        with tvMain.CreateColumn do begin
          DataBinding.FieldName := 'AMOUNT' + I.ToString;
          Name := 'tvMainAmount' + I.ToString;
          Caption := 'Остаток ' + SkladArr[i].Name;
          HeaderAlignmentHorz := taCenter;
          RepositoryItem := riEditRepositoryCurrencyItem;
          Index := tvMain.VisibleColumns[tvMain.VisibleColumnCount-1].Index + i + 1;
        end;
        with tvMain.CreateColumn do begin
          DataBinding.FieldName := 'AMOUNT_SOLD' + I.ToString;
          Name := 'tvMainAmountSold' + I.ToString;
          Caption := 'Продажи ' + SkladArr[i].Name;
          HeaderAlignmentHorz := taCenter;
          RepositoryItem := riEditRepositoryCurrencyItem;
          Index := tvMain.VisibleColumns[tvMain.VisibleColumnCount-1].Index + i + 1;
          Summary.FooterKind := skSum;
        end;
      end;
  end;

  spRead.SelectSQL.Text := spRead.SelectSQL.Text + '   FROM G_PRODUCT GP '#13#10+
                                                   '  WHERE GP.IS_ACTIVE = 1 '#13#10+
                                                   '    AND GP.IS_CATEGORY = 0 '#13#10+
                                                   ' ORDER BY NAME, BARCODE ';
  inherited;
end;

procedure TSalesOstBySkladListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

procedure TSalesOstBySkladListForm.aExportToExcelExecute(Sender: TObject);
begin
  inherited;
  aSaveAllToXLS.Execute;
end;

end.
