unit frmDiscountCardList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, dxExEdtr, FIBQuery, pFIBQuery, pFIBStoredProc, DB,
  FIBDataSet, pFIBDataSet, ExtCtrls, Menus, FIBDatabase, pFIBDatabase,
  ActnList, dxBar, dxBarExtItems, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, cxControls, cxSplitter, Buttons, IniFiles;

type
  TDiscountCardListForm = class(TDBListForm)
    dxDBGridG_DISCONT_CARD: TdxDBGridMaskColumn;
    dxDBGridCODE: TdxDBGridMaskColumn;
    dxDBGridBARCODE: TdxDBGridMaskColumn;
    dxDBGridN_PERCENT: TdxDBGridCurrencyColumn;
    dxDBGridSUMM: TdxDBGridCurrencyColumn;
    splDiscountCard: TcxSplitter;
    spRelClients: TpFIBDataSet;
    dsRelClients: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    grRelClients: TdxDBGrid;
    dxDBGridMaskColumn1: TdxDBGridMaskColumn;
    cxSplitter1: TcxSplitter;
    dxDBGrid1: TdxDBGrid;
    dxDBGridMaskColumn2: TdxDBGridMaskColumn;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    spNotRelClients: TpFIBDataSet;
    dsNotRelClients: TDataSource;
    aAddClient: TAction;
    aDelClient: TAction;
    spAddDelClient: TpFIBStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure dxDBGridChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure aAddClientExecute(Sender: TObject);
    procedure aDelClientExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure RefreshRelClients;
  public
    procedure ViewData; override;
    procedure InsData; override;
    procedure UpdData; override;
    procedure ReadList; override;
    procedure DelData; override;
  end;

var
  DiscountCardListForm: TDiscountCardListForm;

implementation

uses frmDiscountCard;

{$R *.dfm}

procedure TDiscountCardListForm.FormCreate(Sender: TObject);
begin
  KeyFieldList := 'G_DISCONT_CARD';
  KeyFieldClass := 'G_DISCONT_CARD_';
  inherited;
end;

procedure TDiscountCardListForm.ReadList;
begin
  inherited;

  aDel.Enabled := spRead.RecordCount > 0;
  aView.Enabled := spRead.RecordCount > 0;
  aUpd.Enabled := spRead.RecordCount > 0;

  RefreshRelClients;
end;

procedure TDiscountCardListForm.RefreshRelClients;
begin
  spNotRelClients.ParamByName('g_client_').AsInteger := -100;
  spNotRelClients.ParamByName('D_CARD_').ASINTEGER := spRead.FieldByName('g_discont_card').AsInteger;
  OpenSP(spNotRelClients, false);

  spRelClients.ParamByName('g_client_').Clear;
  spRelClients.ParamByName('D_CARD_').ASINTEGER := spRead.FieldByName('g_discont_card').AsInteger;
  OpenSP(spRelClients, false);
end;

procedure TDiscountCardListForm.ViewData;
begin
  ClassForm := TDiscountCardForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountCardListForm.InsData;
begin
  ClassForm := TDiscountCardForm.Create(Self);
  try
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountCardListForm.UpdData;
begin
  ClassForm := TDiscountCardForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDiscountCardListForm.DelData;
begin
  if MessageDlg(Format('Удалить карту "%s" ?',
    [spRead.FieldByName('Code').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
    
  inherited;
end;

procedure TDiscountCardListForm.dxDBGridChangeNode(Sender: TObject;
  OldNode, Node: TdxTreeListNode);
begin
  RefreshRelClients;
end;

procedure TDiscountCardListForm.aAddClientExecute(Sender: TObject);
begin
  spAddDelClient.ParamByName('MODE_').AsInteger := 0;
  spAddDelClient.ParamByName('g_client_').AsInteger := spNotRelClients.FieldByName('LT_CLIENT_DCARD').AsInteger;
  spAddDelClient.ParamByName('D_CARD_').AsInteger := spRead.FieldByName('G_DISCONT_CARD').AsInteger;
  if ExecSPTr(spAddDelClient) then BEGIN
    RefreshRelClients;
    spRelClients.Locate('LT_CLIENT_DCARD', spAddDelClient.ParamByName('LT_CLIENT_DCARD_').AsInteger, []);
  END;
end;

procedure TDiscountCardListForm.aDelClientExecute(Sender: TObject);
begin
  spAddDelClient.ParamByName('MODE_').AsInteger := 1;
  spAddDelClient.ParamByName('g_client_').AsInteger := spRelClients.FieldByName('LT_CLIENT_DCARD').AsInteger;
  spAddDelClient.ParamByName('D_CARD_').AsInteger := spRead.FieldByName('G_DISCONT_CARD').AsInteger;
  if ExecSPTr(spAddDelClient) then
    RefreshRelClients;
end;

procedure TDiscountCardListForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  //выставляю положения сплиттеров
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    if Ini.ReadInteger('Splitters', 'splDiscountCard', 0) = 0 then
      Panel1.Width := 260                               //почему-то положение Splitter.PositionAfterOpen не работает, поэтому пришлось так делать, ширину и длину панелей ставить
    else
      Panel1.Width := Ini.ReadInteger('Splitters', 'splDiscountCard', 0);
  finally
    Ini.Free;
  end;
end;

procedure TDiscountCardListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  //выставляю положения сплиттеров
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    Ini.WriteInteger('Splitters', 'splDiscountCard', Panel1.Width);  //почему-то положение Splitter.PositionAfterOpen не работает, поэтому пришлось так делать, ширину и длину панелей ставить
  finally
    Ini.Free;
  end;
end;

end.
