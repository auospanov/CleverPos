unit frmZakazNaReal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, AppEvnts, ExtCtrls, StdCtrls,
  Buttons, DB, FIBDataSet,
  pFIBDataSet, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, unCommonFunc, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCurrencyEdit, System.UITypes, System.Actions, cxClasses,
  Vcl.Menus, cxButtons;

type
  TZakazNaRealForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Label4: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Shape9: TShape;
    Label5: TLabel;
    Shape10: TShape;
    Label6: TLabel;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Label7: TLabel;
    Shape14: TShape;
    Label8: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Label9: TLabel;
    Label10: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    edTovar: TcxTextEdit;
    edPrice: TcxCurrencyEdit;
    edAmount: TcxCurrencyEdit;
    edSumm: TcxCurrencyEdit;
    edAmountPayed: TcxCurrencyEdit;
    edSummPayed: TcxCurrencyEdit;
    edAmountReturned: TcxCurrencyEdit;
    edSummReturned: TcxCurrencyEdit;
    edAmountLeft: TcxCurrencyEdit;
    edSummLeft: TcxCurrencyEdit;
    procedure edAmountChange(Sender: TObject);
  private
    FgProduct : Integer;
  public
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ZakazNaRealForm: TZakazNaRealForm;

implementation

{$R *.dfm}

function TZakazNaRealForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if edAmountPayed.Value > edAmount.Value then begin
    ErrControl := edAmountPayed;
    MessageDlg('Количество отданного товара под реализацию не может быть меньше оплаченного.', mtWarning, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TZakazNaRealForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('G_PRODUCT_').AsiNTEGER := FgProduct;
    ParamByName('PRICE_').AsFloat := edPrice.Value;
    ParamByName('AMOUNT_ALL_').AsFloat := edAmount.Value;
    ParamByName('SUMM_ALL_').AsFloat := edSumm.Value;
    ParamByName('ALLOW_SELL_ABSENT_GOODS_').AsInteger := AllowSellAbsGoods;
  END;
end;

procedure TZakazNaRealForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      FgProduct := ParamByName('G_PRODUCT_').AsiNTEGER;
      edTovar.Text := ParamByName('PRODUCT_NAME_').AsString;
      edAmount.Value := ParamByName('AMOUNT_ALL_').AsFloat;
      edPrice.Value := ParamByName('PRICE_').AsFloat;
      edSumm.Value := ParamByName('SUMM_ALL_').AsFloat;
      edAmountPayed.Value := ParamByName('AMOUNT_PAYED_').AsFloat;
      edSummPayed.Value := ParamByName('SUMM_PAYED_').AsFloat;
      edAmountReturned.Value := ParamByName('AMOUNT_RETURNED_').AsFloat;
      edSummReturned.Value := ParamByName('SUMM_RETURNED_').AsFloat;
      edAmountLeft.Value := ParamByName('AMOUNT_LEFT_').AsFloat;
      edSummLeft.Value := ParamByName('SUMM_LEFT_').AsFloat;
    end;
  end;
end;

procedure TZakazNaRealForm.edAmountChange(Sender: TObject);
begin
  inherited;
  edSumm.Value := edAmount.Value * edPrice.Value;
  edSummLeft.Value := edSumm.Value - edSummPayed.Value;
end;

end.
