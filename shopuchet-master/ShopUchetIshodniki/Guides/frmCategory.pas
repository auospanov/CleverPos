unit frmCategory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, ExtCtrls, StdCtrls, Buttons,
  DB, FIBDataSet, pFIBDataSet,
  AppEvnts, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, UITypes, System.Actions, cxClasses,
  Vcl.Menus, cxButtons, cxEditRepositoryItems, cxCheckBox, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TCategoryForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    spProductCategory: TpFIBDataSet;
    dsProductCategory: TDataSource;
    leCategory: TcxLookupComboBox;
    edName: TcxTextEdit;
    cbDoNotShow: TcxCheckBox;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  CategoryForm: TCategoryForm;

implementation

uses
  unCommonFunc;

{$R *.dfm}

procedure TCategoryForm.FormShow(Sender: TObject);
begin
  inherited;
  KeyField := 'g_product_';
  spProductCategory.ParamByName('G_PRODUCT_').AsInt64 := RecID;
  OpenSp(spProductCategory, False);
end;

function TCategoryForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edName.Text) = EmptyStr then begin
    ErrControl := edName;
    MessageDlg('Наименование не введено', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TCategoryForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leCategory.EditValue := ParamByName('G_PRODUCT_PAR_').AsInt64;
      edName.Text    := ParamByName('NAME_').AsString;
      cbDoNotShow.Checked := ParamByName('DO_NOT_SHOW_RMK_').AsInteger = 1;
    end;
    spProductCategory.Filter := 'g_product <> ' + IntToStr(ReciD);
    spProductCategory.Filtered := True;
  end;
end;

procedure TCategoryForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    if leCategory.EditValue > 0 then
      ParamByName('G_PRODUCT_PAR_').AsInt64 := leCategory.EditValue;
    ParamByName('NAME_').AsString := edName.Text;
    ParamByName('IS_CATEGORY_').AsInteger := 1;
    ParamByName('IS_kit_').AsInteger := 0;
    ParamByName('DO_NOT_SHOW_RMK_').AsInteger := Integer(cbDoNotShow.Checked);

    ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := Integer(UploadToMobile);
  end;
end;

end.
