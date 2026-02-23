unit frmDeliveryList;

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
  dxSkinWhiteprint, cxCalendar, cxEditRepositoryItems;

type
  TDeliveryListForm = class(TDBListForm)
    clmMainDELIVERY: TcxGridDBColumn;
    clmMainG_CLIENT: TcxGridDBColumn;
    clmMainDOSTAVSHIK: TcxGridDBColumn;
    clmMainDELIVERY_DATE: TcxGridDBColumn;
    clmMainADDRESS: TcxGridDBColumn;
    clmMainPRICE: TcxGridDBColumn;
    clmMainCLIENT_NAME: TcxGridDBColumn;
    clmMainPHONE: TcxGridDBColumn;
    clmMainDOST_NAME: TcxGridDBColumn;
    clmMainColumn1: TcxGridDBColumn;
    clmMainTOVAR_DELIVERY_DATE: TcxGridDBColumn;
    clmMainSTATUS: TcxGridDBColumn;
    Action1: TAction;
    bdDate: TdxBarDateCombo;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure bdDateChange(Sender: TObject);
  private

  public
    procedure ViewData; override;
    procedure InsData; override;
    procedure InsLikeData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  DeliveryListForm: TDeliveryListForm;

implementation

uses frmDelivery;

{$R *.dfm}

procedure TDeliveryListForm.ReadList;
begin
  spRead.ParamByName('date_').AsDate := bdDate.Date;
  inherited;
end;

procedure TDeliveryListForm.ViewData;
begin
  ClassForm := TDeliveryForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsLargeInt;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDeliveryListForm.InsData;
begin
  ClassForm := TDeliveryForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDeliveryListForm.InsLikeData;
begin
  ClassForm := TDeliveryForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDeliveryListForm.UpdData;
begin
  ClassForm := TDeliveryForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDeliveryListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить доставку на дату "%s" ?',
    [spRead.FieldByName('delivery_date').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
end;

procedure TDeliveryListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'delivery';
  KeyFieldClass := 'delivery_';
end;

procedure TDeliveryListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

procedure TDeliveryListForm.bdDateChange(Sender: TObject);
begin
  ReadList;
end;

end.
