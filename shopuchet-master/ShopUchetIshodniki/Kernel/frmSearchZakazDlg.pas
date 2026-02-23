unit frmSearchZakazDlg;

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
  cxTextEdit, cxNavigator, System.Actions, cxButtons, cxEditRepositoryItems,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, cxCalc;

type
  TSearchZakazDlgForm = class(TDBDlgForm)
    pnlTop: TPanel;
    btnRefresh: TBitBtn;
    btnIns: TBitBtn;
    btnInsLike: TBitBtn;
    btnUpd: TBitBtn;
    tranRead: TpFIBTransaction;
    spSearchZakaz: TpFIBDataSet;
    dsRead: TDataSource;
    pmGrid: TPopupMenu;
    pmCustomizeColumns: TMenuItem;
    aCustomizeColumns: TAction;
    edSearch: TcxTextEdit;
    grProduct: TcxGrid;
    tv1: TcxGridDBTableView;
    lv1: TcxGridLevel;
    btnFind: TcxButton;
    btnClear: TcxButton;
    clmtv1ZAKAZ: TcxGridDBColumn;
    clmtv1Z_DATE: TcxGridDBColumn;
    clmtv1Z_TIME: TcxGridDBColumn;
    clmtv1NAME: TcxGridDBColumn;
    clmtv1SUMM: TcxGridDBColumn;
    clmtv1PAY_NAME: TcxGridDBColumn;
    btnProcessWithOutCheck: TcxButton;
    clmtv1Column1: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure aCustomizeColumnsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tv1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnFindClick(Sender: TObject);
    procedure btnProcessWithOutCheckClick(Sender: TObject);
  private
    FZakaz : Int64;
    FZakazStr : String;
    FContinueReturn : Boolean;
  public
    property Zakaz : Int64 read FZakaz write FZakaz;
    property ZakazStr : String read FZakazStr write FZakazStr;
    property ContinueReturn : Boolean read FContinueReturn write FContinueReturn;
  end;

var
  SearchZakazDlgForm: TSearchZakazDlgForm;

implementation

{$R *.dfm}

procedure TSearchZakazDlgForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  tv1.StoreToIniFile('Settings_grid.ini', False, [], Self.Name + '-' + tv1.name);
end;

procedure TSearchZakazDlgForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Zakaz := 0;

  if ModalResult = mrOk then begin
    if tv1.Controller.SelectedRowCount = 0 then begin
      btnFind.Click;
      CanClose := False;
      Exit;
    end;
    FContinueReturn := True;
    FZakaz := spSearchZakaz.FieldByName('zakaz').AsLargeInt;
    FZakazStr := 'Чек №' + spSearchZakaz.FieldByName('zakaz').AsString + ' от ' +
      spSearchZakaz.FieldByName('z_date').AsString + ' ' + spSearchZakaz.FieldByName('z_time').AsString +
      ', на сумму ' + spSearchZakaz.FieldByName('summ').AsString;
  end;
end;

procedure TSearchZakazDlgForm.FormShow(Sender: TObject);
begin
  edSearch.SetFocus;
  FContinueReturn := False;

  tv1.RestoreFromIniFile('Settings_grid.ini', False, False, [], Self.Name + '-' + tv1.name);

  if Screen.Height <= 768 then begin
    Width := ScaleDimension(700);
    Panel1.Width := ScaleDimension(687);
    edSearch.Width := ScaleDimension(400);
    btnFind.Left := 417;
    btnClear.Left := 551;
    btnOk.Left := 456;
    btnCancel.Left := 579;
  end;

  btnProcessWithOutCheck.Visible := LetDoReturnWithoutSale = 1;
end;

procedure TSearchZakazDlgForm.edSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_UP then
    spSearchZakaz.Prior
  else if Key = VK_DOWN then
    spSearchZakaz.Next;
end;

procedure TSearchZakazDlgForm.tv1CellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  ModalResult := mrOk;
end;

procedure TSearchZakazDlgForm.btnClearClick(Sender: TObject);
begin
  edSearch.Clear;
end;

procedure TSearchZakazDlgForm.btnFindClick(Sender: TObject);
begin
  spSearchZakaz.ParamByName('g_tochka_').AsInt64 := CurSklad;
  spSearchZakaz.ParamByName('Z_NUM_').AsString := edSearch.Text;
  OpenSp(spSearchZakaz, False);
end;

procedure TSearchZakazDlgForm.btnProcessWithOutCheckClick(Sender: TObject);
begin
  FContinueReturn := True;
  Close;
end;

procedure TSearchZakazDlgForm.aCustomizeColumnsExecute(Sender: TObject);
begin
  inherited;
  tv1.Controller.Customization := True;
end;

end.
