unit frmClientCategory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, pFIBErrorHandler, AppEvnts,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, System.UITypes, System.Actions, cxClasses,
  cxButtons, dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, cxCheckBox, cxEditRepositoryItems;

type
  TClientCategoryForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    spClientCategory: TpFIBDataSet;
    dsClientCategory: TDataSource;
    leClientCategory: TcxLookupComboBox;
    edName: TcxTextEdit;
    procedure FormShow(Sender: TObject);
  private
    FIs_supplier: Integer; // 0 - Клиент, 1 - Поставщик
  public
    property Is_supplier: Integer read FIs_supplier write FIs_supplier;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ClientCategoryForm: TClientCategoryForm;

implementation

{$R *.dfm}

procedure TClientCategoryForm.FormShow(Sender: TObject);
begin
  inherited;
  spClientCategory.ParamByName('G_CLIENT_').AsInt64 := RecID;
  spClientCategory.ParamByName('is_supplier_').AsInteger := FIs_supplier;
  OpenSp(spClientCategory, False);
end;

function TClientCategoryForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edName.Text) = EmptyStr then begin
    ErrControl := edName;
    MessageDlg('Наименование не введено', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TClientCategoryForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leClientCategory.EditValue := ParamByName('g_client_parent_').AsInt64;
      edName.Text    := ParamByName('NAME_').AsString;
    end;
  end;
end;

procedure TClientCategoryForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    if leClientCategory.EditValue > 0 then
      ParamByName('G_CLIENT_PARENT_').AsInt64 := leClientCategory.EditValue;
    ParamByName('NAME_').AsString := edName.Text;
    ParamByName('IS_SUPPLIER_').AsInteger := FIs_supplier;
  end;
end;

end.
