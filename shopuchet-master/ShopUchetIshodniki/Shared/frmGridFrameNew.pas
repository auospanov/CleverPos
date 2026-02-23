unit frmGridFrameNew;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCheckBox,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, FIBDataSet, pFIBDataSet;

type
  TGridFrameNew = class(TFrame)
    spReadFrame: TpFIBDataSet;
    dsReadFrame: TDataSource;
    grMain: TcxGrid;
    tvMain: TcxGridDBTableView;
    clmMainColumn1: TcxGridDBColumn;
    clmMainColumn2: TcxGridDBColumn;
    clmMainColumn3: TcxGridDBColumn;
    lvMain: TcxGridLevel;
    procedure tvMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure clmMainColumn1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    function CheckList(ARecord: TcxCustomGridRecord): Boolean;
  public
    AList: TList;
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

function TGridFrameNew.CheckList(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := AList.IndexOf(Pointer(StrToInt(ARecord.Values[2]))) <> - 1;
end;

procedure TGridFrameNew.ClearList;
begin
  AList.Count := 0;
end;

procedure TGridFrameNew.clmMainColumn1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.EditViewInfo is TcxCustomCheckBoxViewInfo then
    TcxCustomCheckBoxViewInfo(AViewInfo.EditViewInfo).State :=  TcxCheckBoxState(CheckList(AViewInfo.GridRecord));
end;

procedure TGridFrameNew.CreateList;
begin
  AList := TList.Create;
end;

procedure TGridFrameNew.FreeList;
begin
  AList.Free;
end;

procedure TGridFrameNew.SetCheckOne(AGridRecord: TcxCustomGridRecord);
begin
  if not CheckList(AGridRecord) then
    AList.Add(Pointer(StrToInt(AGridRecord.Values[2])));
end;

procedure TGridFrameNew.SetRemoveCheckAll(SetCheck : Boolean);
var
  AGridRecord: TcxCustomGridRecord;
  i : Integer;
begin
  tvMain.DataController.GotoFirst;
  for i := 0 to tvMain.DataController.RecordCount - 1 do begin
    AGridRecord := tvMain.ViewData.Records[i];
    if SetCheck then begin
      if not CheckList(AGridRecord) then
        AList.Add(Pointer(StrToInt(AGridRecord.Values[2])));
    end else begin
      if CheckList(AGridRecord) then
        AList.Remove(Pointer(StrToInt(AGridRecord.Values[2])));
    end;

    tvMain.DataController.GotoNext;
  End;
  tvMain.DataController.GotoFirst;
end;

procedure TGridFrameNew.tvMainMouseDown(Sender: TObject; Button: TMouseButton;
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
      AList.Remove(Pointer(StrToInt(AGridRecord.Values[2])))
    else
      AList.Add(Pointer(StrToInt(AGridRecord.Values[2])));
end;

function TGridFrameNew.FillArr: String;
var
  i : integer;
begin
  for i := 0 to AList.Count-1 do
    //Result := Result + FloatToStr(TcxCustomGridRecord(AList[i]).Values[2]) + '~';
    Result := Result + IntToStr(Integer(AList[i])) + '~';
end;

function TGridFrameNew.GetCheckedCount: integer;
begin
  result := AList.Count;
end;

end.
