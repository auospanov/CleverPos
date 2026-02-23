unit frmContrAgentType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, ExtCtrls, StdCtrls, Buttons,
  pFIBErrorHandler, AppEvnts, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit, System.UITypes,
  System.Actions, cxClasses, Vcl.Menus, cxButtons;

type
  TContrAgentTypeForm = class(TDBEditForm)
    Label13: TLabel;
    Shape25: TShape;
    Shape4: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    edName: TcxTextEdit;
    edShortName: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure edNameExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    //procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ContrAgentTypeForm: TContrAgentTypeForm;

implementation

{$R *.dfm}

procedure TContrAgentTypeForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_contragent_';
end;

function TContrAgentTypeForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edName.Text) = EmptyStr then begin
    ErrControl := edName;
    MessageDlg('Тип контрагента не заполнен', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;  
end;

procedure TContrAgentTypeForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('name_').AsString := edName.Text;
    ParamByName('short_name_').AsString := edShortName.Text;
  end;
end;

procedure TContrAgentTypeForm.edNameExit(Sender: TObject);
begin
  inherited;
  edShortName.Text := edName.Text;
end;

end.
