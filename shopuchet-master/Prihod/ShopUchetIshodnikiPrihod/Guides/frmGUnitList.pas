unit frmGUnitList;

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
  dxSkinWhiteprint;

type
  TGUnitListForm = class(TDBListForm)
    clmMainG_UNIT: TcxGridDBColumn;
    clmMainNAME: TcxGridDBColumn;
    clmMainSHORT_NAME: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
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
  GUnitListForm: TGUnitListForm;

implementation

uses frmGUnit;

{$R *.dfm}

procedure TGUnitListForm.ReadList;
begin
  inherited;
end;

procedure TGUnitListForm.ViewData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGUnitListForm.InsData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGUnitListForm.InsLikeData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGUnitListForm.UpdData;
begin
  ClassForm := TGUnitForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGUnitListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить единицу измерения "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
end;

procedure TGUnitListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'g_unit';
  KeyFieldClass := 'g_unit_';
end;

procedure TGUnitListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

end.
