unit frmTochka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, AppEvnts, ExtCtrls, StdCtrls,
  Buttons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit, System.UITypes,
  System.Actions, cxClasses, Vcl.Menus, cxButtons;

type
  TTochkaForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    edName: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  TochkaForm: TTochkaForm;

implementation

{$R *.dfm}

function TTochkaForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edName.Text) = EmptyStr then begin
    ErrControl := edName;
    MessageDlg('Наименование не введено!', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TTochkaForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do
      edName.Text := ParamByName('Name_').AsString;
  end;
end;

procedure TTochkaForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do
    ParamByName('Name_').AsString := edName.Text;
end;

procedure TTochkaForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_tochka_';
end;

end.
