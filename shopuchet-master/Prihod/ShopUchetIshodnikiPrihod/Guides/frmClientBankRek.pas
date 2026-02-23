unit frmClientBankRek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxCheckBox,
  FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDatabase, pFIBDatabase, pFIBErrorHandler, AppEvnts, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxMemo, System.UITypes,
  System.Actions, cxClasses, cxButtons;

type
  TClientBankRekForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    dsBank: TDataSource;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    spBank: TpFIBDataSet;
    SpeedButton1: TSpeedButton;
    meName: TcxMemo;
    edAccount: TcxTextEdit;
    ceIsDefault: TcxCheckBox;
    leBank: TcxLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edAccountKeyPress(Sender: TObject; var Key: Char);
    procedure leBankPropertiesChange(Sender: TObject);
  private
    FGClient: Integer;
  public
    property GClient: Integer read FGClient write FGClient;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ClientBankRekForm: TClientBankRekForm;

implementation

uses frmBank;

{$R *.dfm}

procedure TClientBankRekForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSp(spBank, False);
end;

function TClientBankRekForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(leBank.Text) = EmptyStr then begin
    ErrControl := leBank;
    MessageDlg('Банк не выбран', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(edAccount.Text) = EmptyStr then begin
    ErrControl := edAccount;
    MessageDlg('ИИК не задан', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TClientBankRekForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leBank.EditValue := ParamByName('g_bank_').AsInteger;
      edAccount.TEXT := ParamByName('account_').AsString;
      ceIsDefault.CHECKED := ParamByName('IS_DEFAULT_').AsInteger = 1;
    end;
  end;
end;

procedure TClientBankRekForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('ACCOUNT_').AsString := edAccount.Text;
    ParamByName('g_client_').AsInteger := FGClient;
    ParamByName('G_BANK_').AsInteger := leBank.EditValue;
    ParamByName('IS_DEFAULT_').AsInteger := Integer(ceIsDefault.CHECKED);
  end;
end;

procedure TClientBankRekForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_account_';
end;

procedure TClientBankRekForm.leBankPropertiesChange(Sender: TObject);
begin
  inherited;
  meName.Text := spBank.FieldByname('name').AsString;
end;

procedure TClientBankRekForm.SpeedButton1Click(Sender: TObject);
begin
  BankForm := TBankForm.Create(Self);
  try
    BankForm.OpenMode := omInsert;
    if BankForm.ShowModal = mrOk then
      OpenSp(spBank, False);
  finally
    BankForm.Free;
  end;
end;

procedure TClientBankRekForm.edAccountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If not (Key in ['A'..'Z', 'a'..'z', '0'..'9', #8]) Then
    Key := #0;
end;

end.
