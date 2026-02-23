unit frmPopupSaleTovList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPopupList, DB, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, ActnList, Menus, StdCtrls, Buttons, ExtCtrls, unCommonFunc, cxGraphics, cxControls,
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
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxTextEdit, FIBQuery,
  pFIBQuery, pFIBStoredProc, cxContainer, cxNavigator, System.Actions, cxButtons;

type
  TPopupSaleTovListForm = class(TPopupListForm)
    TimerChangeEd: TTimer;
    clmMainNAME: TcxGridDBColumn;
    clmMainARTICUL: TcxGridDBColumn;
    clmMainBARCODE: TcxGridDBColumn;
    edBarcode: TcxTextEdit;
    sbClear: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure edBarcodePropertiesChange(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edBarcodeFocusChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ReadList; override;
  end;

var
  PopupSaleTovListForm: TPopupSaleTovListForm;

implementation

{$R *.dfm}

procedure TPopupSaleTovListForm.edBarcodeFocusChanged(Sender: TObject);
begin
  inherited;
  if Length(edBarcode.Text) > 0 then
    edBarcode.SelStart := Length(edBarcode.Text);
end;

procedure TPopupSaleTovListForm.edBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_UP then
    spRead.Prior
  else if Key = VK_DOWN then
    spRead.Next;
end;

procedure TPopupSaleTovListForm.edBarcodePropertiesChange(Sender: TObject);
begin
  TimerChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    TimerChangeEd.Enabled := True
  else BEGIN
    with spRead do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;;
  END;
end;

procedure TPopupSaleTovListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldIsStr := False;
  KeyFieldList  := 'ID';
  KeyFieldClass := 'ID_';

  SelectedFieldName := 'ID';
  SelectedFieldIsStr := false;
end;

procedure TPopupSaleTovListForm.ReadList;
begin
  inherited;

  aIns.Enabled := False;
  aIns.Visible := False;
  aInsLike.Enabled := False;
  aInsLike.Visible := False;
  aUpd.Enabled := False;
  aUpd.Visible := False;
  aDel.Enabled := False;
  aDel.Visible := False;
end;

procedure TPopupSaleTovListForm.TimerChangeEdTimer(Sender: TObject);
var s : string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spRead do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (ARTICUL CONTAINING ''' + edBarcode.text + ''') OR (BARCODE CONTAINING '''+ edBarcode.text + ''')';
      
      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edBarcode.text + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if Assigned(tvMain.Controller.FocusedRow) then
      tvMain.Controller.FocusedRow.Selected := True;
  END;
end;

procedure TPopupSaleTovListForm.sbClearClick(Sender: TObject);
begin
  edBarcode.Clear;
end;

end.
