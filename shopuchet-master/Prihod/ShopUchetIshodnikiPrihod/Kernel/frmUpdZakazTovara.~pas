unit frmUpdZakazTovara;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, OracleData, dxEditor, dxExEdtr, dxDBEdtr,
  dxDBELib, dxCntner, dxEdLib, ExtCtrls, StdCtrls, Menus, Oracle, ActnList,
  Buttons, VLSummdxEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, dxDBGrid, dxTL, dxDBCtrl,
  FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase,
  FIBDataSet, pFIBDataSet, AppEvnts;

type
  TUpdZakazTovaraForm = class(TDBEditForm)
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    dsPaymentType: TDataSource;
    lePAYMENT_TYPE: TdxLookupEdit;
    Label7: TLabel;
    Shape12: TShape;
    Shape13: TShape;
    edDate: TcxDateEdit;
    Label8: TLabel;
    Shape14: TShape;
    edOsnovanie: TdxEdit;
    Shape16: TShape;
    Label9: TLabel;
    Shape17: TShape;
    lePostavshik: TdxLookupEdit;
    Shape18: TShape;
    dsPostavshik: TDataSource;
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    lbZakazNum: TLabel;
    spPostavshik: TpFIBDataSet;
    spPaymentType: TpFIBDataSet;
    Label2: TLabel;
    Shape1: TShape;
    mNote: TMemo;
    Shape2: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FG_product: Integer;
    FPName: String;
  public
    property G_product: Integer read FG_product write FG_product;
    property PName: String read FPName write FPName;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  UpdZakazTovaraForm: TUpdZakazTovaraForm;

implementation

uses frmZakupkaTovara;

{$R *.dfm}

procedure TUpdZakazTovaraForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSp(spPostavshik, False);
  OpenSp(spPaymentType, False);
end;

function TUpdZakazTovaraForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edDate.Text) = '  .  .    ' then begin
    ErrControl := edDate;
    MessageDlg('Дата не введена', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TUpdZakazTovaraForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'zakaz_';
end;

procedure TUpdZakazTovaraForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do begin
    ParamByName('G_CLIENT_').AsInteger := lePostavshik.LookupKeyValue;
    ParamByName('G_PAYMENT_TYPE_').AsInteger := lePAYMENT_TYPE.LookupKeyValue;
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    ParamByName('note_').AsString := mNote.Text;
    ParamByName('z_date_').AsDate := edDate.Date;
  end;
end;

procedure TUpdZakazTovaraForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      lbZakazNum.Caption := 'Заказ №' + IntToStr(ParamByName('zakaz_').AsInteger);
      edOsnovanie.Text := ParamByName('osnovanie_').AsString;
      mNote.Text := ParamByName('note_').AsString;
      edDate.Date := ParamByName('z_date_').AsDate;
      lePostavshik.LookupKeyValue := ParamByName('G_CLIENT_').AsInteger;
      lePAYMENT_TYPE.LookupKeyValue := ParamByName('G_PAYMENT_TYPE_').AsInteger;
    end;
  end;
end;

end.
