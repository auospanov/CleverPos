unit frmZakazRealParent;

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
  dxSkinXmas2008Blue, cxMemo, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  System.UITypes, Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions, cxClasses,
  Vcl.Menus, cxButtons;

type
  TZakazRealParentForm = class(TDBEditForm)
    LabelDoc: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    edDate: TcxDateEdit;
    Shape1: TShape;
    Shape25: TShape;
    Shape17: TShape;
    Shape14: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape16: TShape;
    Shape18: TShape;
    Shape26: TShape;
    Shape2: TShape;
    spPostavshik: TpFIBDataSet;
    dsPostavshik: TDataSource;
    spPaymentType: TpFIBDataSet;
    dsPaymentType: TDataSource;
    edOsnovanie: TcxTextEdit;
    lePostavshik: TcxLookupComboBox;
    lePAYMENT_TYPE: TcxLookupComboBox;
    mNote: TcxMemo;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  ZakazRealParentForm: TZakazRealParentForm;

implementation

{$R *.dfm}

function TZakazRealParentForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if not CheckDate(edDate.Date, '01.01.2000', '01.01.2099') then begin
    ErrControl := edDate;
    MessageDlg('Неверная дата!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if edOsnovanie.Text = '' then begin
    ErrControl := edOsnovanie;
    MessageDlg('Номер накладной не введен!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if lePostavshik.EditValue = 0 then begin
    ErrControl := lePostavshik;
    MessageDlg('Клиент не выбран!', mtWarning, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TZakazRealParentForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('ZAKAZ_DATE_').AsDate := edDate.Date;
    ParamByName('G_client_').AsiNTEGER := lePostavshik.EditValue;
    ParamByName('OSNOVANIE_').AsString := edOsnovanie.Text;
    ParamByName('G_PAYMENT_TYPE_').AsiNTEGER := lePAYMENT_TYPE.EditValue;
    ParamByName('NOTE_').AsString := mNote.Text;
  END;
end;

procedure TZakazRealParentForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edDate.Date := ParamByName('ZAKAZ_DATE_').AsDate;
      lePostavshik.EditValue := ParamByName('G_client_').AsiNTEGER;
      edOsnovanie.Text := ParamByName('OSNOVANIE_').AsString;
      lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsiNTEGER;
      mNote.Text := ParamByName('NOTE_').AsString;
    end;
  end;
end;

procedure TZakazRealParentForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSp(spPostavshik, False);
  OpenSp(spPaymentType, False);
end;

procedure TZakazRealParentForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'zakaz_real_parent_';
end;

end.
