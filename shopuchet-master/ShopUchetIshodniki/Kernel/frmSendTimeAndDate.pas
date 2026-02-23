unit frmSendTimeAndDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxSpinEdit,
  cxTimeEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ExtCtrls,
  StdCtrls, AppEvnts, Buttons, Vcl.Menus, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxClasses, cxButtons, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, cxEditRepositoryItems;

type
  TSendTimeAndDateForm = class(TDlgForm)
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    edDate: TcxDateEdit;
    lb2: TLabel;
    shp3: TShape;
    shp4: TShape;
    teTime: TcxTimeEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SendTimeAndDateForm: TSendTimeAndDateForm;

implementation

{$R *.dfm}

procedure TSendTimeAndDateForm.FormShow(Sender: TObject);
begin
  inherited;
  edDate.Date := Date;
  teTime.Time := Time;
end;

end.
