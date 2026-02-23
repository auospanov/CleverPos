unit frmGNonCashPayTypeList;

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
  dxSkinWhiteprint, cxEditRepositoryItems, cxCheckBox, cxDBLookupComboBox,
  dxmdaset;

type
  TGNonCashPayTypeListForm = class(TDBListForm)
    clmMainG_NONCASH_PAY_TYPE: TcxGridDBColumn;
    clmMainNAME: TcxGridDBColumn;
    clmMainIS_ACTIVE: TcxGridDBColumn;
    clmMainIS_TIS_TYPE: TcxGridDBColumn;
    dsTIS: TDataSource;
    clmMainPOS_TERMINAL_TYPE: TcxGridDBColumn;
    dsTerminal: TDataSource;
    mdPosTerminal: TdxMemData;
    atncfldMemDataPosTerminalID: TAutoIncField;
    strngfldMemDataPosTerminalIP: TStringField;
    mdMemDataPosTerminalTypeTerminal: TIntegerField;
    strngfldPosTerminalName: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  GNonCashPayTypeListForm: TGNonCashPayTypeListForm;

implementation

uses frmGNonCashPayType, unCommonFunc, dmMain;

{$R *.dfm}

procedure TGNonCashPayTypeListForm.ReadList;
begin
  inherited;
end;

procedure TGNonCashPayTypeListForm.ViewData;
begin
  ClassForm := TGNonCashPayTypeForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsLargeInt;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGNonCashPayTypeListForm.InsData;
begin
  ClassForm := TGNonCashPayTypeForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGNonCashPayTypeListForm.InsLikeData;
begin
  ClassForm := TGNonCashPayTypeForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGNonCashPayTypeListForm.UpdData;
begin
  ClassForm := TGNonCashPayTypeForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TGNonCashPayTypeListForm.aDelExecute(Sender: TObject);
begin
  if spRead.FieldByName('G_NONCASH_PAY_TYPE').AsInteger = 1 then begin
    MessageDlg(Format('Нельзя удалить тип оплаты "%s" ! Вы можете ее переименовать.',
      [spRead.FieldByName('Name').AsString]), mtError, [mboK], 0);
    Exit;
  end;

  if MessageDlg(Format('Удалить тип оплаты "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
end;

procedure TGNonCashPayTypeListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'G_NONCASH_PAY_TYPE';
  KeyFieldClass := 'G_NONCASH_PAY_TYPE_';
end;

procedure TGNonCashPayTypeListForm.FormShow(Sender: TObject);
var i : integer;
begin
  if (PrintOnFr) and (CheckPrintDeviceFr = 6) then
    clmMainIS_TIS_TYPE.Visible := True
  else
    clmMainIS_TIS_TYPE.Visible := False;

  if clmMainIS_TIS_TYPE.Visible then
    MainDM.dxMemDataTIS.Open;

  if UsePosTerminal = 1 then begin
    mdPosTerminal.Open;
    for i := 0 to High(PosTerminalArr) do begin
      mdPosTerminal.Insert;
      mdPosTerminal.FieldByName('IP').AsString := PosTerminalArr[i].IP;
      mdPosTerminal.FieldByName('TypeTerminal').AsInteger := PosTerminalArr[i].Model;
      mdPosTerminal.FieldByName('Name').AsString := PosTerminalArr[i].Name;
      mdPosTerminal.Post;
    end;
    mdPosTerminal.Refresh;
  end
  else begin
    clmMainPOS_TERMINAL_TYPE.Destroy;
  end;

  inherited;
end;

procedure TGNonCashPayTypeListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

procedure TGNonCashPayTypeListForm.aUpdExecute(Sender: TObject);
begin
  {if spRead.FieldByName('G_NONCASH_PAY_TYPE').AsInteger = 1 then begin
    MessageDlg(Format('Нельзя редактировать/удалить тип оплаты "%s" !',
      [spRead.FieldByName('Name').AsString]), mtError, [mboK], 0);
    Exit;
  end;}

  inherited;
end;

end.
