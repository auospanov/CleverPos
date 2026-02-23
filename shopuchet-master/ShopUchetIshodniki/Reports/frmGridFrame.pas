unit frmGridFrame;

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
  cxTLData, dxSkinscxPCPainter, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, System.UITypes, System.Types, cxNavigator,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, Generics.Collections;

type
  TGridFrame = class(TFrame)
    spReadFrame: TpFIBDataSet;
    dsReadFrame: TDataSource;
    grMain: TcxGrid;
    tvMain: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    clmMainColumn1: TcxGridDBColumn;
    clmMainColumn2: TcxGridDBColumn;
    clmMainColumn3: TcxGridDBColumn;
    procedure clmMainColumn1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure tvMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    function CheckList(ARecord: TcxCustomGridRecord): Boolean;
  public
    AList: TList<Int64>;
    function FillArr:String;
    function GetCheckedCount : integer;
    procedure CreateList;
    procedure FreeList;
    procedure SetCheckOne(AGridRecord: TcxCustomGridRecord);
    procedure SetRemoveCheckAll(SetCheck : Boolean);
    procedure ClearList;
  end;

implementation

{$R *.dfm}

function TGridFrame.CheckList(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := AList.IndexOf(StrToInt64(ARecord.Values[2])) <> - 1;
end;

procedure TGridFrame.ClearList;
begin
  AList.Count := 0;
end;

procedure TGridFrame.clmMainColumn1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.EditViewInfo is TcxCustomCheckBoxViewInfo then
    TcxCustomCheckBoxViewInfo(AViewInfo.EditViewInfo).State :=  TcxCheckBoxState(CheckList(AViewInfo.GridRecord));
end;

procedure TGridFrame.CreateList;
begin
  AList := TList<Int64>.Create;
end;

procedure TGridFrame.FreeList;
begin
  AList.Free;
end;

procedure TGridFrame.SetCheckOne(AGridRecord: TcxCustomGridRecord);
begin
  if not CheckList(AGridRecord) then
    AList.Add(StrToInt64(AGridRecord.Values[2]));
end;

procedure TGridFrame.SetRemoveCheckAll(SetCheck : Boolean);
var
  AGridRecord: TcxCustomGridRecord;
  i : Integer;
begin
  tvMain.DataController.GotoFirst;
  for i := 0 to tvMain.DataController.RecordCount - 1 do begin
    AGridRecord := tvMain.ViewData.Records[i];
    if SetCheck then begin
      if not CheckList(AGridRecord) then
        AList.Add(StrToInt64(AGridRecord.Values[2]));
    end else begin
      if CheckList(AGridRecord) then
        AList.Remove(StrToInt64(AGridRecord.Values[2]));
    end;

    tvMain.DataController.GotoNext;
  End;
  tvMain.DataController.GotoFirst;
end;

function TGridFrame.FillArr: String;
var
  i : integer;
begin
  for i := 0 to AList.Count-1 do
    //Result := Result + FloatToStr(TcxCustomGridRecord(AList[i]).Values[2]) + '~';
    Result := Result + IntToStr(Int64(AList[i])) + '~';
end;

function TGridFrame.GetCheckedCount: integer;
begin
  result := AList.Count;
end;

procedure TGridFrame.tvMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  AGridRecord: TcxCustomGridRecord;
begin
  if Sender is TcxGridSite then
  begin
    with TcxGridSite(Sender).GridView do
      AHitTest := ViewInfo.GetHitTest(X, Y);

    if (AHitTest.HitTestCode = htCell) and  (TcxGridDBColumn(TcxGridRecordCellHitTest(AHitTest).Item).DataBinding.FieldName = '') then
      AGridRecord := TcxGridRecordCellHitTest(AHitTest).GridRecord
    else
      Exit;
  end;

  if (AGridRecord <> nil) then
    if CheckList(AGridRecord) then
      AList.Remove(StrToInt64(AGridRecord.Values[2]))
    else
      AList.Add(StrToInt64(AGridRecord.Values[2]));
end;

end.
