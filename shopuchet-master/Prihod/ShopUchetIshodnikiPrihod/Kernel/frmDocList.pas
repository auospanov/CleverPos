unit frmDocList;

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
  TDocListForm = class(TDBListForm)
    cxgrdbclmnMainNUM: TcxGridDBColumn;
    cxgrdbclmnMainDOCS_DATE: TcxGridDBColumn;
    clmMainG_FIRM: TcxGridDBColumn;
    clmMainG_CLIENT: TcxGridDBColumn;
    cxgrdbclmnMainG_OFFICIAL: TcxGridDBColumn;
    cxgrdbclmnMainNOTE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDocType : Integer; //0 - ПКО, 1 - акт выполненных работ, 2 - доверенность на получение товаров
  public
    constructor CreateIt(AOwner: TComponent; DocType: Integer; ActionName : String = '');
    procedure ViewData; override;
    procedure InsData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  DocListForm: TDocListForm;

implementation

uses frmDoc;

{$R *.dfm}

constructor TDocListForm.CreateIt(AOwner: TComponent; DocType: Integer; ActionName : String);
var Caption_ : String;
begin
  FDocType := DocType;

  IF FDocType = 0 THEN BEGIN
    Caption_ := 'Журнал приходных кассовых ордеров';
    HELPC := 72;
  END ELSE if FDocType = 1 THEN BEGIN
    Caption_ := 'Журнал актов выполненных работ';
    HELPC := 73;
  END ELSE BEGIN
    Caption_ := 'Журнал доверенностей на получение товаров';
    HELPC := 74;
  END;

  inherited Create(AOwner, Caption_, ActionName);

  Self.Caption := Caption_;
end;

procedure TDocListForm.ReadList;
begin
  spRead.ParamByName('doc_type_').AsInteger := FDocType;
  spRead.ParamByName('IS_ALL_').AsInteger := 1;    // ВСЕ ДОКУМЕНТЫ, В ДАЛЬНЕЙШЕМ МОЖНО БУДЕТ ДОБАВИТЬ ФИЛЬТР ПО ДАТАМ
  inherited;
  if FDocType = 2 then begin
    aIns.Visible := True;
    aIns.Enabled := True;   //доверенности можно тут создавать, и можно создавать ТОЛЬКО ТУТ
  end else begin
    aIns.Visible := False;
    aIns.Enabled := False;
  end;
end;

procedure TDocListForm.ViewData;
begin
  ClassForm := TDocForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TDocForm).DocType := FDocType;
    (ClassForm as TDocForm).Zakaz := spRead.FieldByName('zakaz').AsInteger;
    ClassForm.RecID := spRead.FieldByName(KeyFieldList).AsInteger;
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TDocListForm.UpdData;
begin
  ClassForm := TDocForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TDocForm).DocType := FDocType;
    (ClassForm as TDocForm).Zakaz := spRead.FieldByName('zakaz').AsInteger;
    inherited;
    if (ClassForm as TDocForm).IsSaved = 1 then
      ReadList;
  finally
    ClassForm.Free;
  end;
end;

procedure TDocListForm.InsData;
begin
  ClassForm := TDocForm.Create(Self);
  try
    {Вызываем метод предка}
    (ClassForm as TDocForm).DocType := FDocType;
    inherited;
    if (ClassForm as TDocForm).IsSaved = 1 then
      ReadList;
  finally
    ClassForm.Free;
  end;
end;

procedure TDocListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить документ за "%s" ?',
    [spRead.FieldByName('DOCS_DATE').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  inherited;
end;

procedure TDocListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'Docs';
  KeyFieldClass := 'Docs_';
end;

procedure TDocListForm.aHelpExecute(Sender: TObject);
begin
  Helpc := 38;
  inherited;
end;

procedure TDocListForm.FormShow(Sender: TObject);
begin
  inherited;
  if FDocType = 2 then begin
    clmMainG_FIRM.Caption := 'Организация-получатель';
    clmMainG_CLIENT.Caption := 'Организация-поставщик';
  end;  
end;

end.
