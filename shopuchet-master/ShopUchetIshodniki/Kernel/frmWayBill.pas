unit frmWayBill;

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
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, cxEditRepositoryItems;

type
  TWayBillForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    edDate: TcxDateEdit;
    Label3: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label4: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    Label5: TLabel;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    dsIspolnitel: TDataSource;
    Label13: TLabel;
    aPrint: TAction;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape34: TShape;
    Label19: TLabel;
    Shape30: TShape;
    spIspolnitel: TpFIBDataSet;
    lbTtn: TLabel;
    Label14: TLabel;
    spOtpuskAgree: TpFIBDataSet;
    dsOtpuskAgree: TDataSource;
    Label15: TLabel;
    spOtpustil: TpFIBDataSet;
    dsOtpustil: TDataSource;
    spGlavBuh: TpFIBDataSet;
    dsGlavBuh: TDataSource;
    lbGlavbuh: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    spFirm: TpFIBDataSet;
    dsFirm: TDataSource;
    lbPostavshik: TLabel;
    sh1: TShape;
    sh2: TShape;
    leFirm: TcxLookupComboBox;
    edNum: TcxTextEdit;
    edPostavshik: TcxTextEdit;
    edIDN: TcxTextEdit;
    edPoluchatel: TcxTextEdit;
    leIspolnitel: TcxLookupComboBox;
    edTransp: TcxTextEdit;
    edTTN: TcxTextEdit;
    leGlavBuh: TcxLookupComboBox;
    leOtpuskAgree: TcxLookupComboBox;
    leOtpustil: TcxLookupComboBox;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    edDoverka: TcxTextEdit;
    lb2: TLabel;
    shp3: TShape;
    shp4: TShape;
    edDoverkaVydana: TcxTextEdit;
    cxButton1: TcxButton;
    procedure aPrintExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure leFirmPropertiesChange(Sender: TObject);
  private
    FNotSaved : integer;  // 1 - счет еще не сохранен, 0 - сохранен (то есть счета не было до сего момента, будет создан сейчас)
    FZakaz : int64;
    FGClient : int64;
    FIs_spisanie    : Integer;  // 0 - продажа, 3 - перемещение на склад
  public
    property NotSaved: Integer read FNotSaved write FNotSaved;
    property Zakaz: Int64 read FZakaz write FZakaz;
    property Is_spisanie: Integer read FIs_spisanie write FIs_spisanie;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  WayBillForm: TWayBillForm;

implementation

uses dmReports, unInitApp;

{$R *.dfm}

function TWayBillForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if edPostavshik.text = '' then begin
    ErrControl := edPostavshik;
    MessageDlg('Организация-отправитель не указана!', mtInformation, [mbOK], 0);
    Exit
  end;

  if edPoluchatel.text = '' then begin
    ErrControl := edPoluchatel;
    MessageDlg('Организация-получатель не указана!', mtInformation, [mbOK], 0);
    Exit
  end;

  Result := True;
end;

procedure TWayBillForm.GetData;
begin
  spGetData.ParamByName('ZAKAZ_').AsInt64 := FZakaz;
  spGetData.ParamByName('currency_').AsInteger := CurrencyVal;
  spGetData.ParamByName('MODE_').AsInteger := FIs_spisanie;
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edNum.Text := ParamByName('NUM_').AsString;
      edDate.Date := ParamByName('INIT_DATE_').AsDate;
      // раньше не было leFirm.EditValue поэтому у многих клиентов нет этого, надо проверять если 0, то можно заполнять
      if (ParamByName('g_firm_').AsInt64 = 0) OR (ManyFirm = 0) then begin
        edPostavshik.Text := ParamByName('POSTAVSHIK_').AsString;
        edIDN.Text := ParamByName('IDN_').AsString;
      END else begin
        leFirm.EditValue := ParamByName('g_firm_').AsInt64;
        edPostavshik.Text := ParamByName('POSTAVSHIK_').AsString;
        edIDN.Text := ParamByName('IDN_').AsString;

        // подставляю последний сохраненный, потому что бывает, что на разных компьютерах штопают разные ИП
        if FNotSaved = 1 then
          leFirm.EditValue := ReadIntSettingsIni('ManyFirm', 'FirmId', spFirm.FieldByName('G_FIRM_REKVIZIT').AsLargeInt);
      end;

      edPoluchatel.Text := ParamByName('GRUZOPOLUCHATEL_').AsString;
      leIspolnitel.EditValue := ParamByName('OTVETST_ZA_POST_').AsInt64;
      edTransp.Text := ParamByName('TRANSP_ORG_').AsString;
      edTTN.Text := ParamByName('TRANSP_NAKLAD_').AsString;
      leOtpuskAgree.EditValue := ParamByName('G_OFFICIAL_RUKOVOD_').AsInt64;
      leOtpustil.EditValue := ParamByName('G_OFFICIAL_').AsInt64;

      edDoverka.Text := ParamByName('doverennost_').AsString;
      edDoverkaVydana.Text := ParamByName('doverennost_fio_').AsString;

      IF spGlavBuh.RecordCount = 0 THEN
        leGlavBuh.Text := 'Не предусмотрен'
      ELSE
        leGlavBuh.EditValue := ParamByName('GLAVBUH_').AsInt64;

      // ЕСЛИ ФОРМА ВЫЗЫВАЕТСЯ УЖЕ С ЖУРНАЛА НАКЛАДНЫХ, ТО ТАМ ID ЗАКАЗА БЕРУ ИЗ GET, ЗДЕСЬ ЖЕ ПЕРЕДАЮ С ФОРМЫ ПРОДАЖ
      IF FZakaz = 0 THEN
        FZakaz := ParamByName('ZAKAZ_SAVED_').AsInt64;
    end;
  end;
end;

procedure TWayBillForm.SetParams(SP: TpFIBStoredProc);
begin
  with SP do begin
    ParamByName('NUM_').AsString := edNum.Text;
    ParamByName('INIT_DATE_').AsDate := edDate.Date;
    ParamByName('POSTAVSHIK_').AsString := edPostavshik.Text;
    IF NOT VarIsNull(leFirm.EditValue) THEN
      ParamByName('G_FIRM_').AsInt64 := leFirm.EditValue;
    ParamByName('IDN_').AsString := edIDN.Text;
    ParamByName('GRUZOPOLUCHATEL_').AsString := edPoluchatel.Text;
    if leIspolnitel.EditValue > 0 then
      ParamByName('OTVETST_ZA_POST_').AsInt64 := leIspolnitel.EditValue;
    ParamByName('TRANSP_ORG_').AsString := edTransp.Text;
    ParamByName('TRANSP_NAKLAD_').AsString := edTTN.Text;
    if leOtpuskAgree.EditValue > 0 then
      ParamByName('G_OFFICIAL_RUKOVOD_').AsInt64 := leOtpuskAgree.EditValue;
    if leOtpustil.EditValue > 0 then
      ParamByName('G_OFFICIAL_').AsInt64 := leOtpustil.EditValue;
    ParamByName('ZAKAZ_').AsInt64 := FZakaz;

    IF leGlavBuh.EditValue > 0 THEN
      ParamByName('GLAVBUH_').AsInt64 := leGlavBuh.EditValue;

    ParamByName('doverennost_').AsString := edDoverka.Text;
    ParamByName('doverennost_fio_').AsString := edDoverkaVydana.Text;
  end;
end;

procedure TWayBillForm.aPrintExecute(Sender: TObject);
begin
  inherited;

  if FNotSaved = 1 then begin
    MessageDlg('Сначала сохраните накладную!', mtWarning, [mbOK], 0);
    Exit;
  end;

  if CurrencyVal = 0 then
    ReportsDM.PrepareReport(23)
  else
    ReportsDM.PrepareReport(28);

  ReportsDM.spReport.ParamByName('currency_').AsInteger := CurrencyVal;
  ReportsDM.spReport.ParamByName('WayBill_').AsInt64 := RecId;
  ReportsDM.spReport.ParamByName('MODE_').AsInteger := FIs_spisanie;  
  ReportsDM.ShowReport(1, 'Накладная №' + edNum.Text + ' от ' + edDate.Text);
end;

procedure TWayBillForm.FormCloseQuery(Sender: TObject;
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

  if (OpenMode in [omInsert, omInsertLike, omInsertChild]) or (FNotSaved = 1) then begin
    Success := InsData;
    FNotSaved := 0;
  end else if OpenMode = omUpdate then
    Success := UpdData;

  if Success then begin
    MessageDlg('Накладная сохранена успешно!', mtInformation, [mbOK], 0);
    FNotSaved := 0;
    if ManyFirm = 1 then
      SaveSettingsIni('ManyFirm', 'FirmId', leFirm.EditValue, '');
  end;

  CanClose := False;
end;

procedure TWayBillForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'WayBill_';
end;

procedure TWayBillForm.FormShow(Sender: TObject);
begin
  inherited;

  IF ManyFirm = 0 then BEGIN
    lbPostavshik.Visible := False;
    sh1.Visible := False;
    sh2.Visible := FALSE;
    leFirm.Visible := FALSE;
    leFirm.Enabled := False;
  end ELSE BEGIN
    OpenSP(spFirm, False);
  END;
  OpenSP(spIspolnitel, False);
  OpenSP(spOtpuskAgree, False);
  OpenSP(spOtpustil, False);
  spGlavBuh.ParamByName('GLAVBUH_OR_RUKOVODITEL_').AsInteger := 2;
  OpenSP(spGlavBuh, False);

  lbTtn.Width := ScaleDimension(199);
  lbGlavbuh.Width := ScaleDimension(199);

  if AppName = 'salonuchet' then begin
    spIspolnitel.Filter := 'is_category = 0';
    spIspolnitel.Filtered := True;
    spOtpuskAgree.Filter := 'is_category = 0';
    spOtpuskAgree.Filtered := True;
    spOtpustil.Filter := 'is_category = 0';
    spOtpustil.Filtered := True;
  end;
end;

procedure TWayBillForm.btHelpClick(Sender: TObject);
begin
  HelpC := 39;
  inherited;
end;

procedure TWayBillForm.leFirmPropertiesChange(Sender: TObject);
begin
  edPostavshik.Text := leFirm.Text;
  edIDN.Text := spFirm.FieldByName('IDN').AsString;
end;

end.
