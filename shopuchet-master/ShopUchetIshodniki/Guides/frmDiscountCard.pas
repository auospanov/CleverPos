unit frmDiscountCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, dxEdLib, VLSummdxEdit, StdCtrls, dxCntner, dxEditor,
  dxExEdtr, ExtCtrls, Buttons, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDatabase, pFIBDatabase, ActnList, AppEvnts;

type
  TDiscountCardForm = class(TDBEditForm)
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Shape8: TShape;
    Shape7: TShape;
    Shape4: TShape;
    Shape2: TShape;
    Shape16: TShape;
    Shape12: TShape;
    Shape11: TShape;
    Shape1: TShape;
    sePercent: TdxCurrencyEdit;
    Label6: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    edPrice: TVLSummdxEdit;
    edCode: TdxEdit;
    edBarcode: TdxEdit;
    sbGenBarcode: TSpeedButton;
    SpeedButton4: TSpeedButton;
    spGetBarcode: TpFIBStoredProc;
    procedure sbGenBarcodeClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
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
  DiscountCardForm: TDiscountCardForm;

implementation

{$R *.dfm}

procedure TDiscountCardForm.sbGenBarcodeClick(Sender: TObject);
begin
  spGetBarcode.ParamByName('MODE_').AsInteger := 13;
  CallSPWithout(spGetBarcode);
  edBarcode.Text := spGetBarcode.ParamByName('Barcode_').AsString;
  edBarcode.Modified := True;
end;

procedure TDiscountCardForm.SpeedButton4Click(Sender: TObject);
begin
  edBarcode.Clear;
end;

function TDiscountCardForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edCode.Text) = EmptyStr then begin
    ErrControl := edCode;
    MessageDlg('Код карточки не введен', mtInformation, [mbOK], 0);
    Exit;
  end;

  if sePercent.Value = 0 then begin
    ErrControl := sePercent;
    MessageDlg('Процент бонуса не введен!', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TDiscountCardForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edCode.Text := ParamByName('code_').AsString;
      edBarcode.Text := ParamByName('BARCODE_').AsString;
      sePercent.Value := ParamByName('N_PERCENT_').AsFloat;
      edPrice.SummValue := ParamByName('SUMM_').AsFloat;
    end;
  end;

  if OpenMode in [omInsert, omInsertLike] then
    sbGenBarcode.Click;
end;

procedure TDiscountCardForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('code_').AsString := edCode.Text;
    ParamByName('BARCODE_').AsString := edBarcode.Text;
    ParamByName('N_PERCENT_').AsFloat := sePercent.Value;
  end;
end;

end.
