unit frmRevisionUpd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDBEdit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  frmMyCurrencyFrame, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, System.Actions, Vcl.ActnList, cxEdit, cxEditRepositoryItems,
  cxClasses, cxContainer, Vcl.AppEvnts, cxButtons, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  TRevisionUpdForm = class(TDBEditForm)
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    Label4: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    edModified: TEdit;
    procedure FormShow(Sender: TObject);
    procedure MyCurrencyFrameFormedAmountChange(Sender: TObject);
  private
    FAmountReal : Double;
  public
    property AmountReal : Double read FAmountReal write FAmountReal;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  RevisionUpdForm: TRevisionUpdForm;

implementation

{$R *.dfm}

function TRevisionUpdForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  Result := True;
end;

procedure TRevisionUpdForm.FormShow(Sender: TObject);
begin
  inherited;
  KeyField := 'revision_';
  MyCurrencyFrameForm.edAmount.SelectAll;
  MyCurrencyFrameForm.edAmount.Text := FloatToStr(FAmountReal);
end;

procedure TRevisionUpdForm.GetData;
begin
  //
end;

procedure TRevisionUpdForm.MyCurrencyFrameFormedAmountChange(Sender: TObject);
begin
  MyCurrencyFrameForm.edAmountChange(Sender);
  edModified.Modified := True;
end;

procedure TRevisionUpdForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  SP.ParamByName('AMOUNT_REAL_').AsFloat := MyCurrencyFrameForm.Value;
end;

end.
