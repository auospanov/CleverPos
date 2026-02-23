unit frmSostavCalc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxCurrencyEdit, Vcl.ExtCtrls, Vcl.StdCtrls, frmMyCurrencyFrame,
  cxEditRepositoryItems, cxClasses, Vcl.AppEvnts, cxButtons, System.Math;

type
  TSostavCalcForm = class(TDlgForm)
    MyCurrencyFrameForm: TMyCurrencyFrameForm;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    lb2: TLabel;
    shp3: TShape;
    edPriceAll: TcxCurrencyEdit;
    shp4: TShape;
    Label1: TLabel;
    Shape1: TShape;
    lb3: TLabel;
    shp5: TShape;
    Shape2: TShape;
    edPrice: TcxCurrencyEdit;
    shp6: TShape;
    edPriceVol: TcxCurrencyEdit;
    Label3: TLabel;
    btnCalc: TcxButton;
    Label2: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    edPriceVolAll: TcxCurrencyEdit;
    procedure btnCalcClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SostavCalcForm: TSostavCalcForm;

implementation

{$R *.dfm}

procedure TSostavCalcForm.btnCalcClick(Sender: TObject);
begin
  edPrice.Value := RoundTo(edPriceAll.Value / MyCurrencyFrameForm.Value, -2);
  edPriceVol.Value := RoundTo(edPriceVolAll.Value / MyCurrencyFrameForm.Value, -2);
end;

end.
