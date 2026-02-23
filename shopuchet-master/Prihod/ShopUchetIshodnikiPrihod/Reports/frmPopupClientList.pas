unit frmPopupClientList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPopupList, DB, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, ActnList, Menus, StdCtrls, Buttons, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, cxTextEdit, FIBQuery, pFIBQuery, pFIBStoredProc, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxNavigator, System.Actions, cxButtons;

type
  TPopupClientListForm = class(TPopupListForm)
    Label10: TLabel;
    edBarcode: TEdit;
    sbClear: TSpeedButton;
    TimerChangeEd: TTimer;
    clmMainID: TcxGridDBColumn;
    clmMainNAME: TcxGridDBColumn;
    clmMainPHONE: TcxGridDBColumn;
    clmMainColumn1: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIsPostavshik : Integer;
  public
    property IsPostavshik : Integer read FIsPostavshik write FIsPostavshik;
  protected
    procedure ReadList; override;
  end;

var
  PopupClientListForm: TPopupClientListForm;

implementation

{$R *.dfm}

procedure TPopupClientListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldIsStr := False;
  KeyFieldList  := 'ID';
  KeyFieldClass := 'ID_';

  SelectedFieldName := 'ID';
  SelectedFieldIsStr := false;
end;

procedure TPopupClientListForm.ReadList;
begin
  spRead.ParamByName('Is_supplier_').AsInteger := FIsPostavshik;
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

procedure TPopupClientListForm.edBarcodeChange(Sender: TObject);
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
    end;
  END;
end;

procedure TPopupClientListForm.TimerChangeEdTimer(Sender: TObject);
var s : string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    with spRead do begin
      s := '(NAME CONTAINING ''' + edBarcode.text + ''') OR (PHONE CONTAINING ''' + edBarcode.text + ''') OR (NOTE CONTAINING ''' + edBarcode.text + ''')';
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

procedure TPopupClientListForm.sbClearClick(Sender: TObject);
begin
  edBarcode.Clear;
end;

procedure TPopupClientListForm.FormShow(Sender: TObject);
begin
  inherited;
  edBarcode.SetFocus;
end;

end.
