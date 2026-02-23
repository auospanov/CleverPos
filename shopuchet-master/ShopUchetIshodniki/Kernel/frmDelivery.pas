unit frmDelivery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  AppEvnts, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, System.UITypes,
  System.Actions, cxClasses, cxButtons, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxMemo, cxCurrencyEdit,
  frmDostavshikPopup, cxEditRepositoryItems, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TDeliveryForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label7: TLabel;
    Shape12: TShape;
    Shape13: TShape;
    edDate: TcxDateEdit;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Label4: TLabel;
    Shape8: TShape;
    edPrice: TcxCurrencyEdit;
    mNote: TcxMemo;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    mAddress: TcxMemo;
    Label5: TLabel;
    Shape9: TShape;
    Shape10: TShape;
    Label6: TLabel;
    Shape11: TShape;
    Shape14: TShape;
    Label8: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Label9: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Label10: TLabel;
    Shape20: TShape;
    spClient: TpFIBDataSet;
    dsPostavshik: TDataSource;
    leClient: TcxLookupComboBox;
    dePostavkaDate: TcxDateEdit;
    spZakaz: TpFIBDataSet;
    dsZakaz: TDataSource;
    spPrihod: TpFIBDataSet;
    dsPrihod: TDataSource;
    leZakaz: TcxLookupComboBox;
    lePrihod: TcxLookupComboBox;
    peDostavshik: TcxPopupEdit;
    cbbStatus: TcxComboBox;
    btnBringDolg: TcxButton;
    aBringDolg: TAction;
    procedure btHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure peTovarPropertiesCloseUp(Sender: TObject);
    procedure peTovarPropertiesInitPopup(Sender: TObject);
    procedure peDostavshikKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure leZakazPropertiesChange(Sender: TObject);
    procedure aBringDolgExecute(Sender: TObject);
  private
    FPopupForm : TDostavshikPopupForm;
    peDostavshikTag : Int64;
  public
    { Public declarations }
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  DeliveryForm: TDeliveryForm;

implementation

uses
  frmProdazhaTovaraN;

{$R *.dfm}

function TDeliveryForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if (VarToStr(leClient.EditValue) = '') or (VarToStr(leClient.EditValue) = '0') then begin
    ErrControl := leClient;
    MessageDlg('Клиент не выбран!', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TDeliveryForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPopupForm := TDostavshikPopupForm.Create(Self);
end;

procedure TDeliveryForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSP(spZakaz, False);
  OpenSP(spClient, False);
  OpenSP(spPrihod, False);
end;

procedure TDeliveryForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leZakaz.EditValue := ParamByName('zakaz_').AsInt64;
      //if (VarToStr(leZakaz.EditValue) = '') or (VarToStr(leZakaz.EditValue) = '0') then
      aBringDolg.Enabled := leZakaz.EditValue > 0;

      leClient.EditValue := ParamByName('G_CLIENT_').AsInt64;
      lePrihod.EditValue := ParamByName('SKLAD_').AsInt64;
      if ParamByName('TOVAR_DELIVERY_DATE_').AsDate <> 0 then
        dePostavkaDate.Date := ParamByName('TOVAR_DELIVERY_DATE_').AsDate;
      if ParamByName('DELIVERY_DATE_').AsDate <> 0 then
        edDate.date := ParamByName('DELIVERY_DATE_').AsDate;
      mAddress.Text := ParamByName('ADDRESS_').AsString;
      peDostavshikTag := ParamByName('DOSTAVSHIK_').AsInt64;
      peDostavshik.Text := ParamByName('DOSTAVSHIK_name_').asString;
      edPrice.Value := ParamByName('PRICE_').AsFloat;
      mNote.Text := ParamByName('NOTE_').AsString;
      cbbStatus.ItemIndex := ParamByName('STATUS_').AsInteger;
    end;
  end;
end;

procedure TDeliveryForm.leZakazPropertiesChange(Sender: TObject);
begin
  leClient.EditValue := spZakaz.FieldByName('g_client').AsLargeInt;
end;

procedure TDeliveryForm.peDostavshikKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TDeliveryForm.peTovarPropertiesCloseUp(Sender: TObject);
begin
  if FPopupForm.AcceptRes then begin
    peDostavshikTag := FPopupForm.spRead.FieldByName('ID').AsLargeInt;
    (Sender as TcxPopupEdit).Text := FPopupForm.spRead.FieldByName('name').AsString;
    mNote.ModifiedAfterEnter := True;
  end;
end;

procedure TDeliveryForm.peTovarPropertiesInitPopup(Sender: TObject);
begin
  peDostavshik.DroppedDown := True;
  FPopupForm.arefresh.Execute;
end;

procedure TDeliveryForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    if (VarToStr(leZakaz.EditValue) <> '') and (VarToStr(leZakaz.EditValue) <> '0') then
      ParamByName('zakaz_').AsInt64 := leZakaz.EditValue;

    if (VarToStr(leClient.EditValue) <> '') and (VarToStr(leClient.EditValue) <> '0') then
      ParamByName('G_CLIENT_').AsInt64 := leClient.EditValue;

    if (VarToStr(lePrihod.EditValue) <> '') and (VarToStr(lePrihod.EditValue) <> '0') then
      ParamByName('SKLAD_').AsInt64 := lePrihod.EditValue;

    if dePostavkaDate.Date > 0 then
      ParamByName('TOVAR_DELIVERY_DATE_').AsDate := dePostavkaDate.Date;
    if edDate.Date > 0 then
      ParamByName('DELIVERY_DATE_').AsDate := edDate.Date;
    ParamByName('ADDRESS_').asString := mAddress.Text;
    if peDostavshikTag <> 0 then
      ParamByName('DOSTAVSHIK_').AsInt64 := peDostavshikTag;
    ParamByName('PRICE_').asFloat := edPrice.Value;
    ParamByName('NOTE_').asString := mNote.Text;
    ParamByName('STATUS_').asInteger := cbbStatus.ItemIndex;
  end;
end;

procedure TDeliveryForm.aBringDolgExecute(Sender: TObject);
var ProdazhaTovaraNForm : TProdazhaTovaraNForm;
begin
  ProdazhaTovaraNForm := TProdazhaTovaraNForm.Create(Self);
  ProdazhaTovaraNForm.OpenMode := omUpdate;
  ProdazhaTovaraNForm.RecID := leZakaz.EditValue;
  try
    ProdazhaTovaraNForm.ShowModal;
  finally
    ProdazhaTovaraNForm.Free;
  end;
end;

procedure TDeliveryForm.btHelpClick(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

end.
