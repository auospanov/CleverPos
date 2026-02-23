unit frmBank;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, ExtCtrls, StdCtrls, Buttons,
  DB, FIBDataSet, pFIBDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxMemo, AppEvnts, System.UITypes,
  System.Actions, cxClasses, Vcl.Menus, cxButtons, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxEditRepositoryItems;

type
  TBankForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Shape5: TShape;
    Label3: TLabel;
    Shape6: TShape;
    meName: TcxMemo;
    meShortName: TcxMemo;
    edBik: TcxTextEdit;
    procedure edBikKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure meShortNameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  BankForm: TBankForm;

implementation

{$R *.dfm}

function TBankForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edBIK.Text) = EmptyStr then begin
    ErrControl := edBIK;
    MessageDlg('БИК банка не введен', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(meName.Text) = EmptyStr then begin
    ErrControl := meName;
    MessageDlg('Наименование банка не введено', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TBankForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edBik.Text       := ParamByName('BIK_').AsString;
      meName.Text      := ParamByName('NAME_').AsString;
      meShortName.Text := ParamByName('SHORT_NAME_').AsString;
    end;
  end;
end;

procedure TBankForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('BIK_').AsString  := edBik.Text;
    ParamByName('NAME_').AsString := meName.Text;
    ParamByName('SHORT_NAME_').AsString := meShortName.Text;
  end;
end;

procedure TBankForm.edBikKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If not (Key in ['A'..'Z', 'a'..'z', '0'..'9', #8]) Then
    Key := #0;
end;

procedure TBankForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_bank_';
end;

procedure TBankForm.meShortNameClick(Sender: TObject);
begin
  inherited;
  meShortName.Text := meName.Text;
end;

end.
