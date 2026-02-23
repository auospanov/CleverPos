unit frmLogCommonDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxEditRepositoryItems, cxEdit,
  cxClasses, cxContainer, Vcl.AppEvnts, cxButtons, Vcl.ExtCtrls;

type
  TLogCommonDlgForm = class(TDlgForm)
    m1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogCommonDlgForm: TLogCommonDlgForm;

implementation

{$R *.dfm}

end.
