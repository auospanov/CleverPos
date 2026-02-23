unit frmKassa;

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
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxMemo,
  cxCurrencyEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, System.UITypes,
  Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions, cxClasses, cxButtons, unCommonFunc;

type
  TKassaForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    edDate: TcxDateEdit;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    dsReadStatya: TDataSource;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    spReadStatya: TpFIBDataSet;
    leStatya: TcxLookupComboBox;
    edSumm: TcxCurrencyEdit;
    Memo: TcxMemo;
    lbPayment: TLabel;
    ShapePayment: TShape;
    ShapePayment1: TShape;
    cbPaymentType: TcxComboBox;
    spGetOstatok: TpFIBStoredProc;
    procedure FormShow(Sender: TObject);
    procedure leStatyaPropertiesChange(Sender: TObject);
  private
    FActionStat : Integer;
    FGPaymentType : Integer;
  public
    property ActionStat : Integer read FActionStat write FActionStat;
    property GPaymentType : Integer read FGPaymentType write FGPaymentType; //1 - наличный, 2 - безналичный
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  KassaForm: TKassaForm;

implementation

{$R *.dfm}

function TKassaForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if {(leStatya.EditValue = 0) OR }(VarisNull(leStatya.EditValue)) then begin
    ErrControl := leStatya;
    MessageDlg('Статья не выбрана', mtInformation, [mbOK], 0);
    Exit;
  end;

  if edDate.Text = '  .  .    ' then begin
    ErrControl := edDate;
    MessageDlg('Дата не выбрана', mtInformation, [mbOK], 0);
    Exit;
  end;

  if edSumm.Value = 0 then begin
    ErrControl := edSumm;
    MessageDlg('Сумма не указана!', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TKassaForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      leStatya.EditValue := ParamByName('g_prihod_rashod_').AsInteger;
      edDate.Date := ParamByName('action_date_').AsDate;
      edSumm.Value := ParamByName('summ_').AsFloat;
      Memo.Text := ParamByName('note_').AsString;
      cbPaymentType.ItemIndex := ParamByName('G_PAYMENT_TYPE_').AsInteger - 1;
    end;
  end;

  //ПРОВЕРЯЮ ЕСТЬ ЛИ ПРАВО НА РЕДАКТИРОВАНИЕ ФИН.ОПЕРАЦИИ ЗА ПРОШЛЫЕ ДАТЫ
  //НЕВАЖНО КАКАЯ ДАТА У ОПЕРАЦИИ, МНЕ ПРОЦЕДУРА УЖЕ ВОЗВРАЩАЕТ 1, ЕСЛИ ОПЕРАЦИЯ ЗА ТЕКУЩУЮ ДАТУ
  if OpenMode = omUpdate then
    IF (spGetData.ParamByName('HAVERIGHT_TO_CHANGE_OLD_').AsInteger = 0) THEN BEGIN
      MessageDlg('Вы не обладаете правом для редактирования финансовых операций за прошлые даты!', mtWarning, [mbOk], 0);
      edSumm.Enabled := False;
      btnOk.Enabled := False;
      EXIT;
    END;
end;

procedure TKassaForm.leStatyaPropertiesChange(Sender: TObject);
begin
  if leStatya.EditValue = 0 then begin
    spGetOstatok.ParamByName('g_payment_type_').AsInteger := 1;
    spGetOstatok.ParamByName('date_').AsDate := Date;
    ExecSPTR(spGetOstatok);
    edSumm.Value := Abs(spGetOstatok.ParamByName('summ_').AsFloat);
  end;
end;

procedure TKassaForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('G_Payment_Type_').AsInteger := cbPaymentType.ItemIndex + 1;
    ParamByName('g_prihod_rashod_').AsInteger := leStatya.EditValue;
    ParamByName('action_date_').AsDate := edDate.Date;
    ParamByName('action_').AsInteger := FActionStat;
    ParamByName('summ_').AsFloat := edSumm.Value;
    ParamByName('note_').AsString := Memo.Text;
  end;
end;

procedure TKassaForm.FormShow(Sender: TObject);
begin
  inherited;
  spReadStatya.ParamByName('action_').AsInteger := FActionStat;
  OpenSp(spReadStatya, False);
  edDate.Date := Date;

  if FGPaymentType > 0 then
    cbPaymentType.ItemIndex := FGPaymentType-1;

  if OpenMode = omUpdate then
    cbPaymentType.Enabled := False;

  if FActionStat = 0 then BEGIN
    Self.Caption := 'Приход';
    Label13.Caption := 'Статья прихода';
    HelpC := 12;
  END else begin
    Self.Caption := 'Расход';
    HelpC := 13;
  end;
end;

end.
