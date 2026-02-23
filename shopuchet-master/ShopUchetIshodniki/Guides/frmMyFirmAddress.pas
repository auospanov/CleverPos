unit frmMyFirmAddress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxCheckBox,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase,
  FIBDataSet, pFIBDataSet, AppEvnts, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, System.UITypes, System.Actions, cxClasses,
  cxButtons, cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TMyFirmAddressForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    dsMyFirmAddressCategory: TDataSource;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    SpeedButton1: TSpeedButton;
    spMyFirmAddressCategory: TpFIBDataSet;
    aInsAddressType: TAction;
    leAddressType: TcxLookupComboBox;
    edAddress: TcxTextEdit;
    edFax: TcxTextEdit;
    edPhone: TcxTextEdit;
    ceIsDefault: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aInsAddressTypeExecute(Sender: TObject);
  private
    FGFirmRekvizit: Int64;
  public
    property GFirmRekvizit: Int64 read FGFirmRekvizit write FGFirmRekvizit;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  MyFirmAddressForm: TMyFirmAddressForm;

implementation

uses frmAddressType;

{$R *.dfm}

procedure TMyFirmAddressForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSp(spMyFirmAddressCategory, False);
  leAddressType.ItemIndex := 0;
end;

function TMyFirmAddressForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(leAddressType.Text) = EmptyStr then begin
    ErrControl := leAddressType;
    MessageDlg('Тип адреса не выбран', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TMyFirmAddressForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leAddressType.EditValue := ParamByName('G_ADDRESS_TYPE_').AsInt64;
      edAddress.TEXT := ParamByName('ADDRESS_').AsString;
      edPhone.TEXT := ParamByName('PHONE_').AsString;
      edFax.TEXT := ParamByName('FAX_').AsString;
      ceIsDefault.CHECKED := ParamByName('IS_DEFAULT_').AsInteger = 1;
    end;
  end;
end;

procedure TMyFirmAddressForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('G_ADDRESS_TYPE_').AsInt64 := leAddressType.EditValue;
    ParamByName('address_').AsString := edAddress.Text;
    ParamByName('g_firm_rekvizit_').AsInt64 := FGFirmRekvizit;
    ParamByName('PHONE_').AsString := edPhone.Text;
    ParamByName('FAX_').AsString := edFax.Text;
    ParamByName('IS_DEFAULT_').AsInteger := Integer(ceIsDefault.CHECKED);
  end;
end;

procedure TMyFirmAddressForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_Address_';
end;

procedure TMyFirmAddressForm.aInsAddressTypeExecute(Sender: TObject);
begin
  AddressTypeForm := TAddressTypeForm.Create(Self);
  try
    AddressTypeForm.OpenMode := omInsert;
    if AddressTypeForm.ShowModal = mrOk then begin
      OpenSp(spMyFirmAddressCategory, False);
      leAddressType.EditValue := AddressTypeForm.RecID;
    end;
  finally
    AddressTypeForm.Free;
  end;
end;


end.
