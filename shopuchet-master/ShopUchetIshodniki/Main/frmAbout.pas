unit frmAbout;

interface

{$I ShopUchet.inc}

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, SysUtils, Shellapi, unCommonFunc, Dialogs, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2Click(Sender: TObject);
  private
  public
  end;

var
  AboutForm: TAboutForm;

implementation

uses unFileInfo;

{$R *.DFM}

procedure TAboutForm.FormShow(Sender: TObject);
var
  LocalInfo : unFileInfo.TFixedFileInfo;
begin
  LocalInfo  := unFileInfo.FileInfo(Application.ExeName);

  Version.Caption := Format('Version %d.%d.%d.%d',
    [LocalInfo.wFileVersionLS, LocalInfo.wFileVersionMS,
     LocalInfo.wProductVersionLS, LocalInfo.wProductVersionMS]);

  Copyright.Caption := '© 2016-' + IntToStr(SysUtils.CurrentYear) + ', правообладатель ИП "Пандора". Все права защищены.';

  Copyright.Width := ScaleDimension(300);
  Copyright.height := ScaleDimension(65);
  Copyright.Left := ScaleDimension(40);
end;

procedure TAboutForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then {Esc}
    Close;
end;

procedure TAboutForm.Label2MouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TAboutForm.Label2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TAboutForm.Label2Click(Sender: TObject);
begin
  ShellExecute(handle,'open','https://shopuchet.kz/', nil, nil, SW_SHOW);
end;

end.

