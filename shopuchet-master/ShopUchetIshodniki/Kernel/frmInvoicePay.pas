unit frmInvoicePay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, unCommonFunc, FIBQuery,
  pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet,
  pFIBDataSet, AppEvnts, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, System.UITypes,
  Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions, cxClasses, cxButtons,
  cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TInvoicePayForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    edDate: TcxDateEdit;
    dsAddress: TDataSource;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label4: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    Label5: TLabel;
    Shape9: TShape;
    Shape10: TShape;
    Label6: TLabel;
    Shape11: TShape;
    Shape12: TShape;
    dsAccount: TDataSource;
    Label7: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    Label8: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Label9: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Label10: TLabel;
    Shape19: TShape;
    Shape20: TShape;
    dsAddressClient: TDataSource;
    Label11: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    Label12: TLabel;
    Shape23: TShape;
    Shape24: TShape;
    Label14: TLabel;
    Shape27: TShape;
    Shape28: TShape;
    Label15: TLabel;
    Shape29: TShape;
    Shape30: TShape;
    dsIspolnitel: TDataSource;
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    aPrint: TAction;
    spAddress: TpFIBDataSet;
    spAccount: TpFIBDataSet;
    spAddressClient: TpFIBDataSet;
    spIspolnitel: TpFIBDataSet;
    shPostavshik: TShape;
    lbPostavshik: TLabel;
    spFirm: TpFIBDataSet;
    dsFirm: TDataSource;
    shPostavshik1: TShape;
    leFirm: TcxLookupComboBox;
    edNum: TcxTextEdit;
    edIDN: TcxTextEdit;
    leAddress: TcxLookupComboBox;
    leAccount: TcxLookupComboBox;
    edBank: TcxTextEdit;
    edBIK: TcxTextEdit;
    edKBE: TcxTextEdit;
    edKNP: TcxTextEdit;
    edClient: TcxTextEdit;
    edIDNClient: TcxTextEdit;
    leAddressClient: TcxLookupComboBox;
    leIspolnitel: TcxLookupComboBox;
    edOsnovanie: TcxTextEdit;
    edPostavshik: TcxTextEdit;
    cxButton1: TcxButton;
    spGetNum: TpFIBDataSet;
    procedure aPrintExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure leFirmPropertiesChange(Sender: TObject);
    procedure edDatePropertiesChange(Sender: TObject);
  private
    FNotSaved : integer;  // 1 - счет еще не сохранен, 0 - сохранен (то есть счета не было до сего момента, будет создан сейчас)
    FZakaz : int64;
  public
    property NotSaved: Integer read FNotSaved write FNotSaved;
    property Zakaz: Int64 read FZakaz write FZakaz;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  InvoicePayForm: TInvoicePayForm;

implementation

uses dmReports, unInitApp;

{$R *.dfm}

function TInvoicePayForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if leAddress.EditValue = 0 then begin
    ErrControl := leAddress;
    MessageDlg('Адрес местонахожд. поставщика не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  if leAccount.EditValue = 0 then begin
    ErrControl := leAccount;
    MessageDlg('Расчетный счет поставщика не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  {if leAddressClient.EditValue = 0 then begin
    ErrControl := leAddressClient;
    MessageDlg('Адрес клиента не указан!', mtInformation, [mbOK], 0);
    Exit
  end;}

  if leIspolnitel.EditValue = 0 then begin
    ErrControl := leIspolnitel;
    MessageDlg('Исполнитель не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  Result := True;
end;

procedure TInvoicePayForm.edDatePropertiesChange(Sender: TObject);
var num : string;
begin
  spGetNum.ParamByName('INIT_DATE_').AsDate := edDate.Date;
  OpenSp(spGetNum, False);
  if spGetNum.FieldByName('num').AsString = '' then
    edNum.Text := '1'
  else
    edNum.Text := spGetNum.FieldByName('num').AsString;
end;

procedure TInvoicePayForm.GetData;
var onChange : TNotifyEvent;
begin
  spGetData.ParamByName('ZAKAZ_').AsInt64 := FZakaz;
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edNum.Text := ParamByName('NUM_').AsString;

      onChange := edDate.Properties.OnChange;
      edDate.Properties.OnChange := nil;
      edDate.Date := ParamByName('INIT_DATE_').AsDate;
      edDate.Properties.OnChange := onChange;

      // раньше не было leFirm.EditValue поэтому у многих клиентов нет этого, надо проверять если 0, то можно заполнять
      if (ParamByName('g_firm_').AsInt64 = 0) OR (ManyFirm = 0) then begin
        OpenSP(spAddress, False);
        OpenSP(spAccount, False);
        leAddress.EditValue := ParamByName('ADDRESS_').AsInt64;
        edPostavshik.Text := ParamByName('POSTAVSHIK_').AsString;
        edIDN.Text := ParamByName('IDN_').AsString;
        leAccount.EditValue := ParamByName('IIK_').AsInt64;
      end else begin
        leFirm.EditValue := ParamByName('g_firm_').AsInt64;
        edPostavshik.Text := ParamByName('POSTAVSHIK_').AsString;
        edIDN.Text := ParamByName('IDN_').AsString;

        // подставляю последний сохраненный, потому что бывает, что на разных компьютерах штопают разные ИП
        if FNotSaved = 1 then
          leFirm.EditValue := ReadStrSettingsIni('ManyFirm', 'FirmId', spFirm.FieldByName('G_FIRM_REKVIZIT').AsString);
      end;

      edBank.Text := ParamByName('BANK_NAME_').AsString;
      edBIK.Text := ParamByName('BIK_').AsString;
      if (edBank.Text ='') and (edBIK.Text = '') then begin     // вдруг счет-фактуры еще нет, идет предварительное заполнение
        edBank.Text := spAccount.FieldByName('NAME').AsString;
        edBIK.Text := spAccount.FieldByName('BIK').AsString;
      end;
      edKBE.Text := ParamByName('KBE_').AsString;
      edKNP.Text := ParamByName('KNP_').AsString;
      edClient.Text := ParamByName('G_CLIENT_').AsString;
      edIDNClient.Text := ParamByName('IDN_CLIENT_').AsString;

      spAddressClient.ParamByName('g_client_').AsInt64 := ParamByName('G_CLIENT_ID_').AsInt64;
      OpenSP(spAddressClient, False);
      spAddressClient.First;
      leAddressClient.EditValue := ParamByName('ADDRESS_POKUPATEL_').AsInt64;

      edOsnovanie.Text := ParamByName('AGREEMENT_').AsString;

      if True then

      leIspolnitel.EditValue := ParamByName('G_OFFICIAL_').AsInt64;

      // ЕСЛИ ФОРМА ВЫЗЫВАЕТСЯ УЖЕ С ЖУРАНАЛ СЧЕТОВ НА ОПЛАТУ, ТО ТАМ ID ЗАКАЗА ДОЛЖЕН ВЫТАСКИВАТЬСЯ ИЗ GET
      IF FZakaz = 0 THEN
        FZakaz := ParamByName('ZAKAZ_SAVED_').AsInt64;
    end;
  end;
end;

procedure TInvoicePayForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('NUM_').AsString := edNum.Text;
    ParamByName('INIT_DATE_').AsDate := edDate.Date;
    ParamByName('POSTAVSHIK_').AsString := edPostavshik.Text;
    IF NOT VarIsNull(leFirm.EditValue) THEN
      ParamByName('G_FIRM_').AsInt64 := leFirm.EditValue;
    ParamByName('IDN_').AsString := edIDN.Text;
    ParamByName('ADDRESS_').AsInt64 := leAddress.EditValue;
    ParamByName('IIK_').AsInt64 := leAccount.EditValue;
    ParamByName('BANK_NAME_').AsString := edBank.Text;
    ParamByName('BIK_').AsString := edBIK.Text;
    ParamByName('KBE_').AsString := edKBE.Text;
    ParamByName('KNP_').AsString := edKNP.Text;
    ParamByName('G_CLIENT_').AsString := edClient.Text;
    ParamByName('IDN_CLIENT_').AsString := edIDNClient.Text;
    IF (leAddressClient.EditValue <> 0) and (leAddressClient.EditValue <> null) THEN
      ParamByName('ADDRESS_POKUPATEL_').AsInt64 := leAddressClient.EditValue;
    ParamByName('AGREEMENT_').AsString := edOsnovanie.Text;
    ParamByName('G_OFFICIAL_').AsInt64 := leIspolnitel.EditValue;
    ParamByName('ZAKAZ_').AsInt64 := FZakaz;
  end;
end;

procedure TInvoicePayForm.aPrintExecute(Sender: TObject);
begin
  inherited;

  if FNotSaved = 1 then begin
    MessageDlg('Сначала сохраните счет!', mtWarning, [mbOK], 0);
    Exit;
  end;

  IF CurrencyVal <> 0 THEN BEGIN
    ReportsDM.PrepareReport(26)
  END ELSE
    ReportsDM.PrepareReport(5);

  ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;  
  ReportsDM.spReport.ParamByName('INVOICE_PAY_').AsInt64 := RecId;
  ReportsDM.ShowReport(1, 'Счет на оплату №' + edNum.Text + ' от ' + edDate.Text);
end;

procedure TInvoicePayForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult <> mrOk then
    Exit;

  CanClose := False;
  {if (OpenMode = omUpdate) and (not CheckRequizChanged(Self)) then
  begin
    //Возможно, OK просто нажата после утверждения или для закрытия окна. Изменений не было
    Success := True;
    CanClose := True;
    Exit;
  end;}

  if (OpenMode in [omInsert, omInsertLike, omInsertChild]) or (FNotSaved = 1) then
    Success := InsData
  else if OpenMode = omUpdate then
    Success := UpdData;

  if Success then begin
    MessageDlg('Счет на оплату сохранен успешно!', mtInformation, [mbOK], 0);
    FNotSaved := 0;
    if ManyFirm = 1 then
      SaveSettingsIni('ManyFirm', 'FirmId', null, IntToStr(leFirm.EditValue));
  end;

  CanClose := False;
end;

procedure TInvoicePayForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'INVOICE_PAY_';
end;

procedure TInvoicePayForm.FormShow(Sender: TObject);
begin
  inherited;

  IF ManyFirm = 0 then BEGIN
    lbPostavshik.Visible := False;
    shPostavshik.Visible := False;
    shPostavshik1.Visible := FALSE;
    leFirm.Visible := FALSE;
    leFirm.Enabled := False;
  end ELSE
    OpenSP(spFirm, False);

  if AppName = 'salonuchet' then begin
    spIspolnitel.Filter := 'is_category = 0';
    spIspolnitel.Filtered := True;
  end;
  OpenSP(spIspolnitel, False);
end;

procedure TInvoicePayForm.btHelpClick(Sender: TObject);
begin
  Helpc := 37;
  inherited;
end;

procedure TInvoicePayForm.leFirmPropertiesChange(Sender: TObject);
begin
  edPostavshik.Text := leFirm.Text;
  edIDN.Text := spFirm.FieldByName('IDN').AsString;
  spAddress.ParamByName('g_firm_').AsInt64 := leFirm.editValue;
  OpenSP(spAddress, False);
  spAddress.Locate('IS_DEFAULT', 1, []);
  leAddress.EditValue := spAddress.FieldByName('g_address').AsLargeInt;
  spAccount.ParamByName('g_firm_').AsInt64 := leFirm.editValue;
  OpenSP(spAccount, False);
  spAccount.Locate('IS_DEFAULT', 1, []);
  leAccount.EditValue := spAccount.FieldByName('g_account').AsLargeInt;
end;

end.
