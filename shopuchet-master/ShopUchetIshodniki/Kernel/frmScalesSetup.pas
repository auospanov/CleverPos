unit frmScalesSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxSpinEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, Vcl.ExtCtrls, Vcl.StdCtrls,
  cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons;

type
  TScalesSetupForm = class(TDlgForm)
    lb5: TLabel;
    shp11: TShape;
    shp12: TShape;
    shp10: TShape;
    shp13: TShape;
    shp9: TShape;
    shp14: TShape;
    lb1: TLabel;
    edScalesIp: TcxTextEdit;
    cbScales: TcxComboBox;
    edScalesPort: TcxTextEdit;
    lb3: TLabel;
    procedure cbScalesPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScalesSetupForm: TScalesSetupForm;

implementation

{$R *.dfm}

procedure TScalesSetupForm.cbScalesPropertiesChange(Sender: TObject);
begin
  edScalesIp.Enabled := cbScales.ItemIndex <> 3;
  edScalesPort.Enabled := cbScales.ItemIndex <> 3;
end;

end.
