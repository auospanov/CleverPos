unit frmInvoice;

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
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxPC, System.UITypes, dxBarBuiltInMenu, Vcl.ComCtrls,
  dxCore, cxDateUtils, System.Actions, cxClasses, cxButtons;

type
  TInvoiceForm = class(TDBEditForm)
    dsAddress: TDataSource;
    dsAccount: TDataSource;
    dsIspolnitel: TDataSource;
    aPrint: TAction;
    dsPaymentType: TDataSource;
    dsIikClient: TDataSource;
    dsRukovoditel: TDataSource;
    dsGlavBuh: TDataSource;
    dsMestoClienta: TDataSource;
    spAddress: TpFIBDataSet;
    spAccount: TpFIBDataSet;
    spPaymentType: TpFIBDataSet;
    spMestoClienta: TpFIBDataSet;
    spIikClient: TpFIBDataSet;
    spRukovoditel: TpFIBDataSet;
    spIspolnitel: TpFIBDataSet;
    spGlavBuh: TpFIBDataSet;
    spFirm: TpFIBDataSet;
    dsFirm: TDataSource;
    pcMain: TcxPageControl;
    tsMisc: TcxTabSheet;
    tsPostavshik: TcxTabSheet;
    tsPoluchatel: TcxTabSheet;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    edNum: TcxTextEdit;
    lb2: TLabel;
    shp3: TShape;
    shp4: TShape;
    edDate: TcxDateEdit;
    lb3: TLabel;
    shp5: TShape;
    edOsnovanie: TcxTextEdit;
    shp6: TShape;
    lb4: TLabel;
    shp7: TShape;
    shp8: TShape;
    lePAYMENT_TYPE: TcxLookupComboBox;
    lb5: TLabel;
    shp9: TShape;
    shp10: TShape;
    edPunkt: TcxTextEdit;
    lb6: TLabel;
    shp11: TShape;
    shp12: TShape;
    edDoverka: TcxTextEdit;
    lb7: TLabel;
    shp13: TShape;
    shp14: TShape;
    edSposobOtpravki: TcxTextEdit;
    lb8: TLabel;
    edNakladnaya: TcxTextEdit;
    shp15: TShape;
    shp16: TShape;
    lb9: TLabel;
    shp17: TShape;
    lb10: TLabel;
    shp18: TShape;
    lb11: TLabel;
    shp19: TShape;
    shp20: TShape;
    leRukovoditel: TcxLookupComboBox;
    shp21: TShape;
    leGlavBuh: TcxLookupComboBox;
    shp22: TShape;
    leIspolnitel: TcxLookupComboBox;
    lbPostavshik: TLabel;
    shpsh1: TShape;
    shp23: TShape;
    lb12: TLabel;
    lb13: TLabel;
    shp24: TShape;
    lb14: TLabel;
    shp25: TShape;
    lb15: TLabel;
    shp26: TShape;
    shpsh2: TShape;
    leFirm: TcxLookupComboBox;
    shp27: TShape;
    edPostavshik: TcxTextEdit;
    shp28: TShape;
    edIDN: TcxTextEdit;
    shp29: TShape;
    leAddress: TcxLookupComboBox;
    shp30: TShape;
    leAccount: TcxLookupComboBox;
    lb16: TLabel;
    shp31: TShape;
    shp32: TShape;
    edOtpravitel: TcxTextEdit;
    lb17: TLabel;
    shp33: TShape;
    shp34: TShape;
    edPoluchatel: TcxTextEdit;
    lb18: TLabel;
    shp35: TShape;
    shp36: TShape;
    edAddressGruzopoluch: TcxTextEdit;
    lb19: TLabel;
    shp37: TShape;
    lb20: TLabel;
    shp38: TShape;
    lb21: TLabel;
    shp39: TShape;
    lb22: TLabel;
    shp40: TShape;
    shp41: TShape;
    leIikClient: TcxLookupComboBox;
    shp42: TShape;
    leMestoClienta: TcxLookupComboBox;
    shp43: TShape;
    edIDNClient: TcxTextEdit;
    shp44: TShape;
    edClient: TcxTextEdit;
    cxButton1: TcxButton;
    procedure aPrintExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure leMestoClientaChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure leFirmPropertiesChange(Sender: TObject);
  private
    FNotSaved : integer;  // 1 - счет еще не сохранен, 0 - сохранен (то есть счета не было до сего момента, будет создан сейчас)
    FZakaz : integer;
    FGClient : integer;
  public
    property NotSaved: Integer read FNotSaved write FNotSaved;
    property Zakaz: Integer read FZakaz write FZakaz;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  InvoiceForm: TInvoiceForm;

implementation

uses dmReports, unInitApp;

{$R *.dfm}

function TInvoiceForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if leAddress.EditValue = 0 then begin
    pcMain.ActivePage := tsPostavshik;
    ErrControl := leAddress;
    MessageDlg('Адрес местонахожд. поставщика не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  if leAccount.EditValue = 0 then begin
    pcMain.ActivePage := tsPostavshik;
    ErrControl := leAccount;
    MessageDlg('Расчетный счет поставщика не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  if lePAYMENT_TYPE.EditValue = 0 then begin
    pcMain.ActivePage := tsMisc;
    ErrControl := lePAYMENT_TYPE;
    MessageDlg('Способ оплаты не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  {if leMestoClienta.EditValue = 0 then begin
    pcMain.ActivePage := tsPoluchatel;
    ErrControl := leMestoClienta;
    MessageDlg('Адрес местонахождения получ-ля не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  if leIikClient.EditValue = 0 then begin
    pcMain.ActivePage := tsPoluchatel;
    ErrControl := leIikClient;
    MessageDlg('Расчетный счет клиента не указан!', mtInformation, [mbOK], 0);
    Exit
  end; }

  if leRukovoditel.EditValue = 0 then begin
    pcMain.ActivePage := tsMisc;
    ErrControl := leRukovoditel;
    MessageDlg('Руководитель не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  if leGlavBuh.Text = '' then begin
    pcMain.ActivePage := tsMisc;
    ErrControl := leGlavBuh;
    MessageDlg('Главный бухгалтер не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  if leIspolnitel.EditValue = 0 then begin
    pcMain.ActivePage := tsMisc;
    ErrControl := leIspolnitel;
    MessageDlg('Исполнитель не указан!', mtInformation, [mbOK], 0);
    Exit
  end;

  Result := True;
end;

procedure TInvoiceForm.GetData;
begin
  spGetData.ParamByName('ZAKAZ_').AsInteger := FZakaz;
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edNum.Text := ParamByName('NUM_').AsString;
      edDate.Date := ParamByName('INIT_DATE_').AsDate;
      // раньше не было leFirm.EditValue поэтому у многих клиентов нет этого, надо проверять если 0, то можно заполнять
      if (ParamByName('g_firm_').AsInteger = 0) OR (ManyFirm = 0) then begin
        edIDN.Text := ParamByName('IDN_').AsString;
        OpenSP(spAddress, False);
        OpenSP(spAccount, False);
        leAddress.EditValue := ParamByName('ADDRESS_').AsInteger;
        leAccount.EditValue := ParamByName('IIK_').AsInteger;
      end else
        leFirm.EditValue := ParamByName('g_firm_').AsInteger;
      edPostavshik.Text := ParamByName('POSTAVSHIK_').AsString;
      edOsnovanie.Text := ParamByName('agreement_').AsString;
      lePAYMENT_TYPE.EditValue := ParamByName('G_PAYMENT_TYPE_').AsInteger;
      edDoverka.Text := ParamByName('DOVERENNOST_').AsString;
      edSposobOtpravki.Text := ParamByName('SPOSOB_OTPRAVKI_').AsString;
      edNakladnaya.Text := ParamByName('NAKLADNAYA_').AsString;
      edOtpravitel.Text := ParamByName('GRUZOOTPRAVITEL_').AsString;
      edPoluchatel.Text := ParamByName('GRUZOPOLUCHATEL_').AsString;
      FGClient          := ParamByName('G_CLIENT_').AsInteger;
      edClient.Text := ParamByName('CLIENT_NAME_').AsString;
      edIDNClient.Text := ParamByName('IDN_CLIENT_').AsString;

      spMestoClienta.ParamByName('g_client_').AsInteger := FGClient;
      OpenSP(spMestoClienta, False);
      spMestoClienta.First;
      leMestoClienta.EditValue := ParamByName('ADDRESS_POKUPATEL_').AsInteger;

      edPunkt.Text := ParamByName('PUNKT_NAZNACHENIYA_').AsString;
      edAddressGruzopoluch.Text := ParamByName('ADDRESS_POLUCHATELYA_').AsString;

      spIikClient.ParamByName('G_CLIENT_').AsInteger := FGClient;
      OpenSP(spIikClient, False);
      leIikClient.EditValue := ParamByName('IIK_CLIENT_').AsInteger;
      leRukovoditel.EditValue := ParamByName('G_OFFICIAL_RUKOVOD_').AsInteger;
      leIspolnitel.EditValue := ParamByName('G_OFFICIAL_').AsInteger;
      IF spGlavBuh.RecordCount = 0 THEN
        leGlavBuh.Text := 'Не предусмотрен'
      ELSE
        leGlavBuh.EditValue := ParamByName('G_OFFICIAL_GB_').AsInteger;

      // ЕСЛИ ФОРМА ВЫЗЫВАЕТСЯ УЖЕ С ЖУРНАЛА СЧЕТ-ФАКТУР, ТО ТАМ ID ЗАКАЗА БЕРУ ИЗ GET, ЗДЕСЬ ЖЕ ПЕРЕДАЮ С ФОРМЫ ПРОДАЖ
      IF FZakaz = 0 THEN
        FZakaz := ParamByName('ZAKAZ_SAVED_').AsInteger;
    end;
  end;
end;

procedure TInvoiceForm.SetParams(SP: TpFIBStoredProc);
begin
  with SP do begin
    ParamByName('NUM_').AsString := edNum.Text;
    ParamByName('INIT_DATE_').AsDate := edDate.Date;
    ParamByName('POSTAVSHIK_').AsString := edPostavshik.Text;
    IF NOT VarIsNull(leFirm.EditValue) THEN
      ParamByName('G_FIRM_').AsInteger := leFirm.EditValue;
    ParamByName('IDN_').AsString := edIDN.Text;
    ParamByName('ADDRESS_').AsInteger := leAddress.EditValue;
    ParamByName('IIK_').AsInteger := leAccount.EditValue;
    ParamByName('agreement_').AsString := edOsnovanie.Text;
    ParamByName('G_PAYMENT_TYPE_').AsInteger := lePAYMENT_TYPE.EditValue;
    ParamByName('PUNKT_NAZNACHENIYA_').AsString := edPunkt.Text;
    ParamByName('DOVERENNOST_').AsString := edDoverka.Text;
    ParamByName('SPOSOB_OTPRAVKI_').AsString := edSposobOtpravki.Text;
    ParamByName('NAKLADNAYA_').AsString := edNakladnaya.Text;
    ParamByName('GRUZOOTPRAVITEL_').AsString := edOtpravitel.Text;
    ParamByName('GRUZOPOLUCHATEL_').AsString := edPoluchatel.Text;
    ParamByName('ADDRESS_POLUCHATELYA_').AsString := edAddressGruzopoluch.Text;
    ParamByName('G_CLIENT_').AsInteger := FGClient;
    ParamByName('CLIENT_NAME_').AsString := edClient.Text;
    ParamByName('IDN_CLIENT_').AsString := edIDNClient.Text;
    if not VarIsNull(leMestoClienta.EditValue) then
      if leMestoClienta.EditValue <> 0 then
        ParamByName('ADDRESS_POKUPATEL_').AsInteger := leMestoClienta.EditValue;
    if not VarIsNull(leIikClient.EditValue) then
      if leIikClient.EditValue <> 0 then
        ParamByName('IIK_CLIENT_').AsInteger := leIikClient.EditValue;
    ParamByName('G_OFFICIAL_').AsInteger := leIspolnitel.EditValue;
    IF leRukovoditel.EditValue > 0 THEN
      ParamByName('G_OFFICIAL_RUKOVOD_').AsInteger := leRukovoditel.EditValue;
    IF leGlavBuh.EditValue > 0 THEN
      ParamByName('G_OFFICIAL_GB_').AsInteger := leGlavBuh.EditValue;
    ParamByName('ZAKAZ_').AsInteger := FZakaz;
  end;

  inherited;
end;

procedure TInvoiceForm.aPrintExecute(Sender: TObject);
begin
  inherited;

  if FNotSaved = 1 then begin
    MessageDlg('Сначала сохраните счет-фактуру!', mtWarning, [mbOK], 0);
    Exit;
  end;

  IF CurrencyVal <> 0 THEN BEGIN
    ReportsDM.PrepareReport(27)
  END ELSE
    ReportsDM.PrepareReport(4);

  ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CurrencyVal;
  ReportsDM.spReport.ParamByName('INVOICE_').AsInteger := RecId;
  ReportsDM.ShowReport(1, 'Счет-фактура №' + edNum.Text + ' от ' + edDate.Text);
end;

procedure TInvoiceForm.FormCloseQuery(Sender: TObject;
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
    FNotSaved := 0;
    MessageDlg('Счет-фактура сохранена успешно!', mtInformation, [mbOK], 0);
  end;

  CanClose := False;
end;

procedure TInvoiceForm.FormCreate(Sender: TObject);
begin
  pcMain.ActivePage := tsMisc;
  inherited;
  KeyField := 'INVOICE_';  
end;

procedure TInvoiceForm.FormShow(Sender: TObject);
begin
  inherited;
  IF ManyFirm = 0 then BEGIN
    lbPostavshik.Visible := False;
    shpsh1.Visible := False;
    shpsh2.Visible := FALSE;
    leFirm.Visible := FALSE;
    leFirm.Enabled := False;
  end ELSE
    OpenSP(spFirm, False);
  OpenSP(spPaymentType, False);
  OpenSP(spPaymentType, False);

  spRukovoditel.ParamByName('GLAVBUH_OR_RUKOVODITEL_').AsInteger := 1;
  OpenSP(spRukovoditel, False);

  if AppName = 'SalonUchet' then begin
    spIspolnitel.Filter := 'is_category = 0';
    spIspolnitel.Filtered := True;
  end;
  OpenSP(spIspolnitel, False);
  if spIspolnitel.RecordCount = 1 then
    leIspolnitel.EditValue := spIspolnitel.FieldByName('g_official').AsInteger;


  spGlavBuh.ParamByName('GLAVBUH_OR_RUKOVODITEL_').AsInteger := 2;
  OpenSP(spGlavBuh, False);

  lb3.Width := ScaleDimension(208);
  lb5.Width := ScaleDimension(208);
  lb6.Width := ScaleDimension(208);
end;

procedure TInvoiceForm.leMestoClientaChange(Sender: TObject);
begin
  inherited;
  edPunkt.Text := leMestoClienta.Text;
  edAddressGruzopoluch.Text := leMestoClienta.Text;  
end;

procedure TInvoiceForm.btHelpClick(Sender: TObject);
begin
  Helpc := 38;
  inherited;
end;

procedure TInvoiceForm.leFirmPropertiesChange(Sender: TObject);
begin
  edPostavshik.Text := leFirm.Text;
  edIDN.Text := spFirm.FieldByName('IDN').AsString;
  spAddress.ParamByName('g_firm_').AsInteger := leFirm.editValue;
  OpenSP(spAddress, False);
  spAddress.Locate('IS_DEFAULT', 1, []);
  leAddress.EditValue := spAddress.FieldByName('g_address').AsInteger;
  spAccount.ParamByName('g_firm_').AsInteger := leFirm.editValue;
  OpenSP(spAccount, False);
  spAccount.Locate('IS_DEFAULT', 1, []);
  leAccount.EditValue := spAccount.FieldByName('g_account').AsInteger;

  if spFirm.FieldByName('IP_OR_JUR').AsInteger = 0 then
    edOtpravitel.Text := 'ИИН: '
  else
    edOtpravitel.Text := 'БИН: ';

  edOtpravitel.Text := edOtpravitel.Text + spFirm.FieldByName('IDN').AsString +
    ', ' + spFirm.FieldByName('NAME').AsString  + ', ' + leAddress.Text;
end;

end.
