unit frmAppErrorDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, unCommonFunc, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons;

type
  TAppErrorDlgForm = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    lbErrCode: TLabel;
    meErrTrace: TMemo;
    lbErrMsgRus: TMemo;
    lbErrMsgEng: TMemo;
    OkButton: TcxButton;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

implementation

{$R *.DFM}

procedure TAppErrorDlgForm.FormShow(Sender: TObject);
begin
  Height := ScaleDimension(244);
end;

procedure TAppErrorDlgForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_ESCAPE) then
    Close;

  {Alt нажата?}
  if not (ssAlt in Shift) then
    {Нет, выходим}
    Exit;

  if chr(Key) = 'D' then begin{D - Debug}
    meErrTrace.Visible := True;
    Height := ScaleDimension(350);
  end;
end;

end.
