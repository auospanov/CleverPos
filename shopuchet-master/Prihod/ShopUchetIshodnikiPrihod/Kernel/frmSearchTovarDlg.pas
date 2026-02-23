unit frmSearchTovarDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, DB, FIBDataSet, pFIBDataSet, FIBDatabase,
  pFIBDatabase, StdCtrls, Buttons,
  ActnList, AppEvnts, ExtCtrls, unCommonFunc, Menus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxTextEdit, cxNavigator, System.Actions, cxButtons;

type
  TSearchTovarDlgForm = class(TDBDlgForm)
    pnlTop: TPanel;
    btnRefresh: TBitBtn;
    btnIns: TBitBtn;
    btnInsLike: TBitBtn;
    btnUpd: TBitBtn;
    tranRead: TpFIBTransaction;
    spSearchTov: TpFIBDataSet;
    dsRead: TDataSource;
    tmrChangeEd: TTimer;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    aCustomizeColumns: TAction;
    edSearch: TcxTextEdit;
    grProduct: TcxGrid;
    tv1: TcxGridDBTableView;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1ARTICUL: TcxGridDBColumn;
    clmtv1BARCODE: TcxGridDBColumn;
    clmtv1NOMENCLATUR_NUM: TcxGridDBColumn;
    clmtv1VOLUME_PRICE: TcxGridDBColumn;
    clmtv1PLACE: TcxGridDBColumn;
    lv1: TcxGridLevel;
    btnFindAnalog: TcxButton;
    sbClear: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure tmrChangeEdTimer(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure btnFindAnalogClick(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tv1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchTovarDlgForm: TSearchTovarDlgForm;

implementation

{$R *.dfm}

procedure TSearchTovarDlgForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  tv1.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tv1.name);
end;

procedure TSearchTovarDlgForm.FormShow(Sender: TObject);
begin
  //inherited;
  if UseTovarPlace = 0 then
    clmtv1PLACE.Destroy;

  spSearchTov.ParamByName('g_tochka_').AsInteger := CurSklad;
  OpenSp(spSearchTov, False);
  edSearch.SetFocus;
  IF CONFIG = 2 THEN
    btnFindAnalog.Visible := true
  else
    btnFindAnalog.Visible := false;

  tv1.RestoreFromIniFile('Settings.ini', True, False, [], Self.Name + '-' + tv1.name);
end;

procedure TSearchTovarDlgForm.edSearchChange(Sender: TObject);
begin
  tmrChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edSearch.Text <> '' then
    tmrChangeEd.Enabled := True
  else BEGIN
    with spSearchTov do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;;
  END;
end;

procedure TSearchTovarDlgForm.tmrChangeEdTimer(Sender: TObject);
var s : string;
begin
  tmrChangeEd.Enabled := False;
  if (edSearch.text<>'') then begin
    with spSearchTov do begin
      s := '(NAME CONTAINING ''' + edSearch.text + ''') OR (ARTICUL CONTAINING ''' + edSearch.text + ''') OR (BARCODE CONTAINING '''+ edSearch.text + ''') OR (CROSSCODE CONTAINING '''+ edSearch.text + ''')';
      
      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edSearch.text + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if Assigned(tv1.Controller.FocusedRow) then
      tv1.Controller.FocusedRow.Selected := True;
  END;
end;

procedure TSearchTovarDlgForm.tv1CellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  ModalResult := mrOk;
end;

procedure TSearchTovarDlgForm.sbClearClick(Sender: TObject);
begin
  edSearch.Clear;
end;

procedure TSearchTovarDlgForm.btnFindAnalogClick(Sender: TObject);
var s : string;
begin
  IF CONFIG = 2 THEN BEGIN
    s := spSearchTov.FieldByName('articul').AsString;
    edSearch.Clear;
    edSearch.Text := s;
  END;
end;

procedure TSearchTovarDlgForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  inherited;
  tv1.Controller.Customization := True;
end;

end.
