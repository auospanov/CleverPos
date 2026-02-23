unit frmFillData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxEdit, cxEditRepositoryItems,
  cxClasses, cxContainer, Vcl.AppEvnts, cxButtons, Vcl.ExtCtrls, cxControls,
  cxCheckBox, Vcl.ComCtrls, FIBDatabase, pFIBDatabase, pFIBScripter, FIB,
  FIBQuery, pFIBQuery, pFIBStoredProc, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  TFillDataForm = class(TDlgForm)
    Label1: TLabel;
    cbProducti: TcxCheckBox;
    cbHim: TcxCheckBox;
    cbApteka: TcxCheckBox;
    tranMainWrite: TpFIBTransaction;
    spFillData: TpFIBStoredProc;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FillDataForm: TFillDataForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TFillDataForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i : integer;
begin
  if (ModalResult = mrOk) and ((Integer(cbProducti.Checked) + Integer(cbHim.Checked) +
  Integer(cbApteka.Checked)) > 0 ) then begin
    CanClose := False;
    Screen.Cursor := crHourGlass;
    spFillData.ParamByName('PRODUCTY_').AsInteger := Integer(cbProducti.Checked);
    spFillData.ParamByName('HIM_').AsInteger := Integer(cbHim.Checked);
    spFillData.ParamByName('APTEKA_').AsInteger := Integer(cbApteka.Checked);

    if ExecSPTr(spFillData) then begin
      MessageDlg('Товары внесены успешно!', mtInformation, [mbOk], 0);
      SaveSettingsIni('Common', 'DataAlreadyFilled', 1, '');

      CanClose := True;
    end;
    Screen.Cursor := crDefault;
  end;
end;

end.
