unit frmRevisionImportFillDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxCheckBox,
  Vcl.ExtCtrls, Vcl.StdCtrls, cxEditRepositoryItems, cxClasses, Vcl.AppEvnts,
  cxButtons;

type
  TRevisionImportFillDlgForm = class(TDlgForm)
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    cbFillRestProduct: TcxCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RevisionImportFillDlgForm: TRevisionImportFillDlgForm;

implementation

{$R *.dfm}

end.
