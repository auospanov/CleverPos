unit frmDBErrorDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, unCommonFunc, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TDBErrorDlgForm = class(TForm)
    Label1: TLabel;
    lbErrCode: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lbErrMsgRus: TMemo;
    lbErrMsgEng: TMemo;
    stErrTrace: TMemo;
    OkButton: TcxButton;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

implementation

{$R *.DFM}

procedure TDBErrorDlgForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_ESCAPE) then
    Close;

  {Alt нажата?}
  if not (ssAlt in Shift) then
    {Нет, выходим}
    Exit;

  if chr(Key) = 'D' then BEGIN {D - Debug}
    Height := ScaleDimension(384);
    OkButton.Top := ScaleDimension(324);
    stErrTrace.Visible := True;
  END;
end;

end.
