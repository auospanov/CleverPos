unit frmInspector;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frmDlg, dxExEdtr, dxCntner, ExtCtrls, StdCtrls, Buttons, dxInspct, dxOI,
  ComCtrls;

type
  TInspectorForm = class(TDlgForm)
    ListView: TListView;
    Splitter: TSplitter;
    dxRTTIInspector: TdxRTTIInspector;
    procedure FormShow(Sender: TObject);
    procedure ListViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Ffrm: TForm;
  public
    property frm : TForm read Ffrm write Ffrm;
  end;

var
  InspectorForm: TInspectorForm;

implementation

{$R *.DFM}

procedure TInspectorForm.FormShow(Sender: TObject);
var
	item 	: TListItem;
  i     : Integer;
begin
  inherited;

  if not Assigned(Ffrm) then
    Exit;

  with Ffrm do begin
    for i := 0 to ComponentCount - 1 do begin
      item := ListView.Items.Add;
      item.Caption := Components[i].Name;
      Item.SubItems.Add(Components[i].ClassName);
    end;
  end;
end;

procedure TInspectorForm.ListViewClick(Sender: TObject);
begin
  inherited;

  dxRTTIInspector.InspectedObject := frm.FindComponent(ListView.ItemFocused.Caption);
end;

procedure TInspectorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i, j : integer;
begin
	for i := ListView.Items.Count - 1 downto 0 do begin
		with ListView.Items[i] do begin
			for j := Subitems.Count - 1 downto 0 do
				SubItems.Objects[j].Free;
		end;
		ListView.Items.Delete(i);
	end;

  inherited;
end;

end.
