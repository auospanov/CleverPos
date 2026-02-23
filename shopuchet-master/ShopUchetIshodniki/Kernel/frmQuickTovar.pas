unit frmQuickTovar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, Vcl.ExtCtrls, cxScrollBox,
  cxClasses, cxContainer, cxEdit, Vcl.AppEvnts, Vcl.StdCtrls, cxButtons;

type
  TQuickTovarForm = class(TDlgForm)
    ScrollBox: TcxScrollBox;
    fpTovarlist: TFlowPanel;
    procedure FormShow(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QuickTovarForm: TQuickTovarForm;

implementation

{$R *.dfm}

procedure TQuickTovarForm.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position + 10;
end;

procedure TQuickTovarForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position - 10;
end;

procedure TQuickTovarForm.FormShow(Sender: TObject);
begin
  inherited;
  {spReadTovar.First;
  i := 0;
  while i < 5000 do begin
    but := TcxButton.Create(Application);
    but.Parent := fpTovarList;
    but.Height := 150;
    but.Width := 100;
    but.Left := Left;
    but.Caption := spReadTovar.FieldByName('name').AsString;
    but.Tag := spReadTovar.FieldByName('g_product').AsInteger;
    but.LookAndFeel.Kind := lfFlat;
    but.WordWrap := True;

    i := i + 1;
    Left := Left + but.Width;
    spReadTovar.Next;
  end;
  Scrollbox.VertScrollBar.Range := fpTovarList.Height;}
end;

end.
