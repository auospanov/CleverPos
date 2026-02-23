unit frmRashodPrihodList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, DB, ExtCtrls, Menus,
  ActnList, dxBar, dxBarExtItems,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, cxGraphics, cxControls, cxLookAndFeels,
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
  cxGridLevel, cxGridCustomView, cxGrid, cxContainer, System.UITypes,
  cxNavigator, System.Actions;

type
  TRashodPrihodListForm = class(TDBListForm)
    dxBarCombo: TdxBarCombo;
    clmMainG_PRIHOD_RASHOD: TcxGridDBColumn;
    clmMainDO_ACTION: TcxGridDBColumn;
    clmMainNAME: TcxGridDBColumn;
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
  RashodPrihodListForm: TRashodPrihodListForm;

implementation

uses frmRashodPrihod;

{$R *.dfm}

procedure TRashodPrihodListForm.ReadList;
begin
  spRead.ParamByName('action_').AsInteger := dxBarCombo.ItemIndex;

  inherited;
end;

procedure TRashodPrihodListForm.ViewData;
begin
  ClassForm := TRashodPrihodForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TRashodPrihodListForm.InsData;
begin
  ClassForm := TRashodPrihodForm.Create(Self);
  try
    // если значение не ВСЕ, то ставлю значение выбранной статьи, если "Все", то по умолчанию "Расход"
    if dxBarCombo.ItemIndex <> 2 then
      (ClassForm as TRashodPrihodForm).PrihodRashod := dxBarCombo.ItemIndex
    else
      (ClassForm as TRashodPrihodForm).PrihodRashod := 1;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TRashodPrihodListForm.InsLikeData;
begin
  ClassForm := TRashodPrihodForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TRashodPrihodListForm.UpdData;
begin
  ClassForm := TRashodPrihodForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TRashodPrihodListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить статью "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  inherited;

  {spDel.SetVariable('G_PRIHOD_RASHOD_', spRead.FieldByName('G_PRIHOD_RASHOD').AsInteger);
  if ExecSP(spDel) then
    Readlist;}
end;

procedure TRashodPrihodListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'G_PRIHOD_RASHOD';
  KeyFieldClass := 'G_PRIHOD_RASHOD_';
end;

procedure TRashodPrihodListForm.dxBarComboChange(Sender: TObject);
begin
  inherited;
  Readlist;
end;

procedure TRashodPrihodListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 8;
  inherited;
end;

end.
