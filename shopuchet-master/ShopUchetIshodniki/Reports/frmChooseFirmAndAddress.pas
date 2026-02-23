unit frmChooseFirmAndAddress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Data.DB,
  FIBDataSet, pFIBDataSet, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.ExtCtrls, Vcl.StdCtrls,
  cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons, FIBDatabase,
  pFIBDatabase;

type
  TChooseFirmAndAddressForm = class(TDlgForm)
    lbPostavshik: TLabel;
    shpsh1: TShape;
    shpsh2: TShape;
    leFirm: TcxLookupComboBox;
    spAddress: TpFIBDataSet;
    dsAddress: TDataSource;
    spFirm: TpFIBDataSet;
    dsFirm: TDataSource;
    lb14: TLabel;
    shp25: TShape;
    shp29: TShape;
    leAddress: TcxLookupComboBox;
    tranRead: TpFIBTransaction;
    procedure leFirmPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChooseFirmAndAddressForm: TChooseFirmAndAddressForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TChooseFirmAndAddressForm.FormCreate(Sender: TObject);
begin
  inherited;

  OpenSp(spFirm, false);
  spFirm.Locate('is_default', 1, []);
  leFirm.EditValue := spFirm.FieldByName('G_FIRM_REKVIZIT').AsLargeInt;
  OpenSp(spAddress, false);
  spAddress.Locate('is_default', 1, []);
  leAddress.EditValue := spAddress.FieldByName('g_address').AsLargeInt;
end;

procedure TChooseFirmAndAddressForm.leFirmPropertiesChange(Sender: TObject);
begin
  spAddress.ParamByName('G_FIRM_').AsInt64 := leFirm.EditValue;
  OpenSp(spAddress, false);
  spAddress.Locate('is_default', 1, []);
  leAddress.EditValue := spAddress.FieldByName('g_address').AsLargeInt;
end;

end.
