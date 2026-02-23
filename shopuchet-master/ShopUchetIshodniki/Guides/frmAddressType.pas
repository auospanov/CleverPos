unit frmAddressType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, Menus, ActnList,
  ExtCtrls, StdCtrls, Buttons, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, AppEvnts, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit, System.UITypes,
  System.Actions, cxClasses, cxButtons, cxEditRepositoryItems;

type
  TAddressTypeForm = class(TDBEditForm)
    Label13: TLabel;
    Shape25: TShape;
    Shape4: TShape;
    edAddress: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
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
  AddressTypeForm: TAddressTypeForm;

implementation

{$R *.dfm}

procedure TAddressTypeForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'G_ADDRESS_TYPE_';
end;

function TAddressTypeForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edAddress.Text) = EmptyStr then begin
    ErrControl := edAddress;
    MessageDlg('Тип адреса не заполнен', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;  
end;

procedure TAddressTypeForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('name_').AsString := edAddress.Text;
  end;
end;

end.
