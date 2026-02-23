unit frmSalesMarkCodeInput;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxTextEdit,
  Vcl.StdCtrls, cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons,
  Vcl.ExtCtrls;

type
  TSalesMarkCodeInputForm = class(TDlgForm)
    Label1: TLabel;
    cxTextEdit1: TcxTextEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SalesMarkCodeInputForm: TSalesMarkCodeInputForm;

implementation

{$R *.dfm}

end.
