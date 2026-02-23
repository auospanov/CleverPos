unit frmProductionTovaraN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxMemo, DB,
  FIBDataSet, pFIBDataSet, cxDropDownEdit, cxCurrencyEdit, ExtCtrls, StdCtrls,
  cxTextEdit, cxMaskEdit, cxCalendar, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDatabase, pFIBDatabase, ActnList, AppEvnts, Buttons, unCommonFunc, frmPopupTovList, System.UITypes,
  Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions, cxClasses, Vcl.Menus,
  cxButtons;

type
  TProductionTovaraNForm = class(TDBEditForm)
    edDate: TcxDateEdit;
    Label7: TLabel;
    lb1: TLabel;
    lb2: TLabel;
    lbContent: TLabel;
    lbNote: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    pnRowCnt: TPanel;
    Panel3: TPanel;
    lst1: TListBox;
    Shape12: TShape;
    Shape13: TShape;
    ShapeNote: TShape;
    ShapeNote1: TShape;
    shp1: TShape;
    shp2: TShape;
    shp3: TShape;
    shp4: TShape;
    edAmount: TcxCurrencyEdit;
    peTovar: TcxPopupEdit;
    spReadSost: TpFIBDataSet;
    spUpdLock: TpFIBStoredProc;
    mNote: TcxMemo;
    aIns: TAction;
    aDel: TAction;
    aUpd: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure peTovarKeyPress(Sender: TObject; var Key: Char);
    procedure peTovarPropertiesCloseUp(Sender: TObject);
    procedure peTovarPropertiesInitPopup(Sender: TObject);
  private
    FPopupTovarForm : TPopupTovListForm;
  protected
    procedure SetParams(SP: TpFIBStoredProc); override;
  public
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  end;

var
  ProductionTovaraNForm: TProductionTovaraNForm;

implementation

{$R *.dfm}

procedure TProductionTovaraNForm.btHelpClick(Sender: TObject);
var Helpc : integer;
begin
  HELPC := 71;
  Application.HelpContext(HELPC);
end;

function TProductionTovaraNForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := False;

  if NOT CheckDate(edDate.Date, '01.01.2000', '01.01.2099') then begin
    ErrControl := edDate;
    MessageDlg('¬ведена некорректна€ дата', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TProductionTovaraNForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPopupTovarForm := TPopupTovListForm.Create(Self);
end;

procedure TProductionTovaraNForm.FormShow(Sender: TObject);
begin
  inherited;
  edDate.Date := Date;
end;

procedure TProductionTovaraNForm.peTovarKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TProductionTovaraNForm.peTovarPropertiesCloseUp(Sender: TObject);
begin
  if FPopupTovarForm.AcceptRes then begin
    (Sender as TcxPopupEdit).Tag := FPopupTovarForm.spRead.FieldByName('ID').AsInteger;
    (Sender as TcxPopupEdit).Text := FPopupTovarForm.spRead.FieldByName('name').AsString;

    lst1.Clear;
    spReadSost.ParamByName('g_product_').AsInteger := (Sender as TcxPopupEdit).Tag;
    OpenSP(spReadSost, False);
    pnRowCnt.Caption := IntToStr(spReadSost.RecordCount);
    spReadSost.First;
    while not spReadSost.Eof do begin
      lst1.Items.Add(Trim(spReadSost.FieldByName('Name').AsString));
      spReadSost.Next;
    end;
  end;
end;

procedure TProductionTovaraNForm.peTovarPropertiesInitPopup(Sender: TObject);
begin
  peTovar.DroppedDown := True;

  if FPopupTovarForm.spRead.Active then
    FPopupTovarForm.spRead.Close;
  FPopupTovarForm.spRead.SelectSQL.Text := 'select g_product id, name, articul, barcode from g_product where is_kit in (2,3)';
  FPopupTovarForm.arefresh.Execute;
end;

procedure TProductionTovaraNForm.SetParams(SP: TpFIBStoredProc);
begin
  with SP do begin
    ParamByName('G_TOCHKA_').AsInteger := CurSklad;
    ParamByName('DATE_').AsDate := edDate.Date;
    ParamByName('G_PRODUCT_').AsInteger := peTovar.Tag;
    ParamByName('AMOUNT_').AsFloat      := edAmount.Value;
    ParamByName('NOTE_').AsString       := mNote.Text;
  end;
end;

end.
