unit frmPsevdLogon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ActnList, AppEvnts, ExtCtrls,
  StdCtrls, Buttons, FIBDatabase, pFIBDatabase, DB, FIBDataSet,
  pFIBDataSet, FIBQuery, pFIBQuery,
  pFIBStoredProc, IniFiles, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  Vcl.Menus, System.Actions, cxClasses, cxButtons;

type
  TPsevdLogonForm = class(TDBDlgForm)
    Label1: TLabel;
    spIspolnitel: TpFIBDataSet;
    dsIspolnitel: TDataSource;
    tranRead: TpFIBTransaction;
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label3: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    leIspolnitel: TcxLookupComboBox;
    edPassword: TcxTextEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edPasswordPropertiesChange(Sender: TObject);
  private
    FPassword : String;
  public
    { Public declarations }
  end;

var
  PsevdLogonForm: TPsevdLogonForm;

implementation

{$R *.dfm}

procedure TPsevdLogonForm.edPasswordPropertiesChange(Sender: TObject);
begin
  FPassword := edPassword.Text;
end;

procedure TPsevdLogonForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;
  if ModalResult = mrOk then begin
    if (leIspolnitel.EditValue = 0) or (leIspolnitel.EditValue = null) then begin
      ShowMessage('Выберите сотрудника!');
      Canclose := False;
    end;

    if Trim(FPassword) <> spIspolnitel.FieldByName('password').AsString then begin
      // сделаю секретный суперпароль, под которым могут заходить владельцы
      if Trim(FPassword) <> 'SUPERPSWADMIN' then begin
        ShowMessage('Пароль неверный!');
        Canclose := False;
      end;
    end;

    // Запомню последнего пользователя
    Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
    try
      Ini.WriteInteger('Logon', 'OfficialId', leIspolnitel.EditValue);
    finally
      Ini.Free;
    end;
  end;
end;

procedure TPsevdLogonForm.FormShow(Sender: TObject);
var
  Ini: Tinifile; //необходимо создать объект, чтоб потом с ним работать
  Off_Login : Integer;
begin
  inherited;
  if Screen.PixelsPerInch = 120 then
    Label1.Font.Size := 11;       //иначе почему-то становиться слишком большой

  // Запомню последнего пользователя
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'Settings.ini');
  try
    Off_Login := Ini.ReadInteger('Logon', 'OfficialId', 0);
  finally
    Ini.Free;
  end;

  OpenSp(spIspolnitel, False);
  if Off_Login = 0 then begin
    spIspolnitel.First;
    leIspolnitel.EditValue := spIspolnitel.FieldByName('g_official').AsInteger;
  end else
    leIspolnitel.EditValue := Off_Login;
end;

end.
