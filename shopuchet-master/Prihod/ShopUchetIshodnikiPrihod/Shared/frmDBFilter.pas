unit frmDBFilter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DB, frmDlg,
  ActnList, cxPC, AppEvnts, Menus, frmDBDlg, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxLookAndFeels,
  cxGraphics, cxLookAndFeelPainters, System.Actions, cxClasses, cxButtons,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TDBFilterForm = class(TDBDlgForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  protected
  public
    
  end;

implementation

{$R *.DFM}

{ TDBFilterForm }   

procedure TDBFilterForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ErrControl: TWinControl;
begin
  inherited;

  if ModalResult <> mrOk then
    Exit;

  CanClose := False;
  if not CheckParams(ErrControl) then begin
    if ErrControl <> Nil then begin
      if ErrControl.Parent.ClassNameIs('TcxTabSheet') then
        (ErrControl.Parent as TcxTabSheet).PageControl.ActivePageIndex := (ErrControl.Parent as TcxTabSheet).PageIndex;
      ErrControl.SetFocus;
    end;
    Exit;
  end;

  CanClose := True;
end;

end.
