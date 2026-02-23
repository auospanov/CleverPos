unit frmPopupClientMultList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPopupMultipageList, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, ActnList, Menus, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxPC, StdCtrls, Buttons, ExtCtrls, cxTL,
  cxMaskEdit, cxTLdxBarBuiltInMenu, cxInplaceContainer, cxDBTL, cxTLData,
  dxBarBuiltInMenu, cxNavigator, System.Actions, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TPopupClientMultListForm = class(TPopupMultipageListForm)
    tsGroups: TcxTabSheet;
    spGroups: TpFIBDataSet;
    dsGroups: TDataSource;
    Label10: TLabel;
    edBarcode: TEdit;
    sbClear: TSpeedButton;
    TimerChangeEd: TTimer;
    tlClientCategory: TcxDBTreeList;
    clmn1: TcxDBTreeListColumn;
    clmnClientCategorycxId: TcxDBTreeListColumn;
    tvMainID: TcxGridDBColumn;
    tvMainNAME: TcxGridDBColumn;
    tvMainPHONE: TcxGridDBColumn;
    tvMainNOTE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure edBarcodeChange(Sender: TObject);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tlClientCategoryDblClick(Sender: TObject);
    procedure tlClientCategoryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dxPageControlChange(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FIsPostavshik : Integer;
  public
    property IsPostavshik : Integer read FIsPostavshik write FIsPostavshik;
  protected
    procedure ReadList; override;
  end;

var
  PopupClientMultListForm: TPopupClientMultListForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TPopupClientMultListForm.dxPageControlChange(Sender: TObject);
begin
  Readlist;
end;

procedure TPopupClientMultListForm.edBarcodeChange(Sender: TObject);
var SP : TpFIBDataSet;
begin
  TimerChangeEd.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edBarcode.Text <> '' then
    TimerChangeEd.Enabled := True
  else BEGIN
    if dxPageControl.ActivePage = ts1 then
      SP := spRead
    else
      SP := spGroups;

    with SP do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TPopupClientMultListForm.edBarcodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_UP then
    spRead.Prior
  else if Key = VK_DOWN then
    spRead.Next;
end;

procedure TPopupClientMultListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldIsStr := False;
  KeyFieldList  := 'ID';
  KeyFieldClass := 'ID_';

  SelectedFieldName := 'ID';
  SelectedFieldIsStr := false;
end;

procedure TPopupClientMultListForm.FormShow(Sender: TObject);
begin
  inherited;
  edBarcode.SetFocus;
end;

procedure TPopupClientMultListForm.ReadList;
begin
  if dxPageControl.ActivePage = ts1 then begin
    spRead.ParamByName('Is_supplier_').AsInteger := FIsPostavshik;
    inherited;
  end else begin
    spGroups.ParamByName('Is_supplier_').AsInteger := FIsPostavshik;
    OpenSp(spGroups, False);
    stRecCnt.Caption := Format('%d', [spGroups.AllRecordCount]);
  end;

  aIns.Enabled := False;
  aIns.Visible := False;
  aInsLike.Enabled := False;
  aInsLike.Visible := False;
end;

procedure TPopupClientMultListForm.sbClearClick(Sender: TObject);
begin
  edBarcode.Clear;
end;

procedure TPopupClientMultListForm.TimerChangeEdTimer(Sender: TObject);
var s : string;
begin
  TimerChangeEd.Enabled := False;
  if (edBarcode.text<>'') then begin
    if dxPageControl.ActivePage = ts1 then begin
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
    end
    else begin
      with spGroups do begin
        s := '(NAME CONTAINING ''' + edBarcode.text + ''')';
        if Active then Close;
        CancelConditions;
        Conditions.Clear;
        Conditions.AddCondition('by_customer', S, True);
        ApplyConditions;
        Open;
      end;
      if Assigned(tlClientCategory.FocusedNode) then
          tlClientCategory.FocusedNode.Selected := True;
    end;
  END;
end;

procedure TPopupClientMultListForm.tlClientCategoryDblClick(Sender: TObject);
begin
  btnOkClick(btnOk);
end;

procedure TPopupClientMultListForm.tlClientCategoryKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ClosePopupForm(Sender);
  if Key = VK_RETURN then
    btnOkClick(nil);
end;

end.

