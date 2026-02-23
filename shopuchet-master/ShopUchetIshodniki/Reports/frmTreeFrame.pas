unit frmTreeFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, FIBDataSet, pFIBDataSet, cxDBTL, cxCheckBox, unCommonFunc,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData,
  cxStyles, cxTL, cxTextEdit, cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxInplaceContainer, cxMaskEdit,
  cxTLData, System.UITypes, System.Types, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TTreeFrame = class(TFrame)
    spReadFrame: TpFIBDataSet;
    dsReadFrame: TDataSource;
    tlCommon: TcxDBTreeList;
    cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeListColumn2: TcxDBTreeListColumn;
    tlSkladcxDBTreeListColumn1: TcxDBTreeListColumn;
    procedure tlCommonCustomDrawDataCell(Sender: TcxCustomTreeList;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
      var ADone: Boolean);
    procedure tlCommonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
  public
    function FillArr:String;
  end;

implementation

{$R *.dfm}


function TTreeFrame.FillArr: String;
var
  Anode : TcxTreeListNode;
begin
  //tlRights.FullExpand;
  tlCommon.TopNode.Focused := True;
  ANode := tlCommon.FocusedNode;
  while ANode <> nil do begin
    if not ANode.HasChildren then
    begin
      if ANode.Values[0] = '1' then
        Result := Result + IntToStr(ANode.Values[2]) + '~';
    end;

    ANode := ANode.GetNext;
    if ANode = nil then BEGIN
      Break;
    END;
  end;
end;

procedure TTreeFrame.tlCommonCustomDrawDataCell(Sender: TcxCustomTreeList;
  ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
  var ADone: Boolean);
begin
  with TcxDBTreeListColumn(AViewInfo.Column) do
  if (DataBinding.FieldName = '') and (Properties is TcxCheckBoxProperties) then
    with AViewInfo.Node do
      TcxCustomCheckBoxViewInfo(AViewInfo.EditViewInfo).State :=
        TcxCheckBoxState(not((Data = nil) or ((Data <> nil) and (PBoolean(Data)^ = False))));
end;

procedure TTreeFrame.tlCommonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var ANode: TcxTreeListNode; AColumn: TcxTreeListColumn;
begin
  with TcxTreeList(Sender) do
  begin
    HitTest.ReCalculate(Point(X, Y));
    if HitTest.HitAtNode and (HitTest.HitColumn <> nil) then
    begin
      ANode := HitTest.HitNode;
      AColumn := HitTest.HitColumn;
      if AColumn.Properties is TcxCheckBoxProperties then
        SetChecks(TcxTreeList(Sender), ANode, AColumn);
    end;
  end;
end;

end.
