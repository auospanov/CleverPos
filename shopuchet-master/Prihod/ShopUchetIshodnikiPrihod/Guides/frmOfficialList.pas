unit frmOfficialList;

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
  TOfficialListForm = class(TDBListForm)
    clmMainG_OFFICIAL: TcxGridDBColumn;
    clmMainFIO: TcxGridDBColumn;
    clmMainIDN: TcxGridDBColumn;
    clmMainDT: TcxGridDBColumn;
    clmMainAPP_NAME: TcxGridDBColumn;
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
  OfficialListForm: TOfficialListForm;

implementation

uses frmOfficial;

{$R *.dfm}

procedure TOfficialListForm.ReadList;
begin
  inherited;
end;

procedure TOfficialListForm.ViewData;
begin
  ClassForm := TOfficialForm.Create(Self);
  try
    {Вызываем метод предка}
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TOfficialListForm.InsData;
begin
  ClassForm := TOfficialForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TOfficialListForm.InsLikeData;
begin
  ClassForm := TOfficialForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TOfficialListForm.UpdData;
begin
  ClassForm := TOfficialForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TOfficialListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить сотрудника "%s" ?',
    [spRead.FieldByName('FIO_DOC').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
  {spDel.SetVariable(KeyFieldList, spRead.FieldByName(KeyFieldClass).AsInteger);
  if ExecSP(spDel) then
    Readlist;}
end;

procedure TOfficialListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'g_official';
  KeyFieldClass := 'g_official_';
end;

procedure TOfficialListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 9;
  inherited;
end;

end.
