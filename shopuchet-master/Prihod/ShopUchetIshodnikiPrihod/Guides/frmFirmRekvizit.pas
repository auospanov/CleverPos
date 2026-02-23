unit frmFirmRekvizit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, Menus, ActnList,
  ExtCtrls, StdCtrls, Buttons, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxPC, DB, FIBDataSet,
  pFIBDataSet, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, AppEvnts, unCommonFunc, cxListBox, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxCheckBox,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, unInitApp, System.UITypes,
  dxBarBuiltInMenu, cxNavigator, Vcl.ComCtrls, dxCore, cxDateUtils,
  System.Actions, cxButtons;

type
  TFirmRekvizitForm = class(TDBEditForm)
    aIns: TAction;
    aUpd: TAction;
    aDel: TAction;
    spReadContact: TpFIBDataSet;
    dsReadContact: TDataSource;
    spReadBankRekv: TpFIBDataSet;
    dsReadBankRekv: TDataSource;
    spDelContact: TpFIBStoredProc;
    spDelBankRekv: TpFIBStoredProc;
    spTochka: TpFIBDataSet;
    dsTochka: TDataSource;
    spDelTochka: TpFIBStoredProc;
    pc1: TcxPageControl;
    tsCommon: TcxTabSheet;
    pn1: TPanel;
    pcClientRekv: TcxPageControl;
    tsContact: TcxTabSheet;
    tsBankRekv: TcxTabSheet;
    pn2: TPanel;
    btnUpd: TBitBtn;
    btnDel: TBitBtn;
    btnIns: TBitBtn;
    shp12: TShape;
    lb7: TLabel;
    shp14: TShape;
    lb10: TLabel;
    shp17: TShape;
    lb11: TLabel;
    shp18: TShape;
    lb12: TLabel;
    shp19: TShape;
    lbKPP: TLabel;
    shKpp: TShape;
    lb13: TLabel;
    shp20: TShape;
    lbIDN: TLabel;
    shp21: TShape;
    lb14: TLabel;
    shp22: TShape;
    lb15: TLabel;
    shp23: TShape;
    lb16: TLabel;
    shp24: TShape;
    shp25: TShape;
    shp26: TShape;
    lb17: TLabel;
    shp27: TShape;
    shp28: TShape;
    shp29: TShape;
    lbOgrn: TLabel;
    shpOgrn: TShape;
    lb18: TLabel;
    shp30: TShape;
    shpKpp1: TShape;
    shp31: TShape;
    shp32: TShape;
    shpOgrn1: TShape;
    shp33: TShape;
    shp34: TShape;
    shp35: TShape;
    shp36: TShape;
    tsFirms: TcxTabSheet;
    lb9: TLabel;
    shp16: TShape;
    shp15: TShape;
    cbByDefault: TCheckBox;
    spReadFirms: TpFIBDataSet;
    dsReadFirms: TDataSource;
    aInsFirm: TAction;
    pn3: TPanel;
    btnIns1: TBitBtn;
    btnDel1: TBitBtn;
    aDelFirm: TAction;
    spDelFirm: TpFIBStoredProc;
    tsSklad: TcxTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnInsSklad: TBitBtn;
    tsNds: TcxTabSheet;
    lb8: TLabel;
    shp13: TShape;
    shp11: TShape;
    lb2: TLabel;
    shp5: TShape;
    lb3: TLabel;
    shp4: TShape;
    lb4: TLabel;
    shp3: TShape;
    shp8: TShape;
    shp7: TShape;
    shp6: TShape;
    shp2: TShape;
    lb5: TLabel;
    shp1: TShape;
    lb6: TLabel;
    shp10: TShape;
    shp9: TShape;
    deDate: TcxDateEdit;
    cbForm: TcxComboBox;
    edName: TcxTextEdit;
    edShortName: TcxTextEdit;
    edIDN: TcxTextEdit;
    edKBE: TcxTextEdit;
    edKPP: TcxTextEdit;
    edOKPO: TcxTextEdit;
    edOgrn: TcxTextEdit;
    edHead: TcxTextEdit;
    edMainChief: TcxTextEdit;
    edWebsite: TcxTextEdit;
    edEmail: TcxTextEdit;
    ceBezNDS: TcxCheckBox;
    gr1: TcxGrid;
    tvContact: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    cxGrid1: TcxGrid;
    tvBank: TcxGridDBTableView;
    lv1: TcxGridLevel;
    ceISPayNDS: TcxCheckBox;
    edSerial: TcxTextEdit;
    edNum: TcxTextEdit;
    edIssuer: TcxTextEdit;
    edNDS: TcxCurrencyEdit;
    cxGrid2: TcxGrid;
    tvFirms: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    tvFirmsG_FIRM_REKVIZIT: TcxGridDBColumn;
    tvFirmsNAME: TcxGridDBColumn;
    tvFirmsIS_DEFAULT: TcxGridDBColumn;
    cxGrid3: TcxGrid;
    tv2: TcxGridDBTableView;
    lv2: TcxGridLevel;
    clmtv2G_TOCHKA: TcxGridDBColumn;
    clmtv2NAME: TcxGridDBColumn;
    clmMainADDRESS: TcxGridDBColumn;
    clmMainPHONE: TcxGridDBColumn;
    clmMainFAX: TcxGridDBColumn;
    clmMainIS_DEFAULT: TcxGridDBColumn;
    clmMainADDRESS_TYPE_STR: TcxGridDBColumn;
    clmtv1ACCOUNT: TcxGridDBColumn;
    clmtv1IS_DEFAULT: TcxGridDBColumn;
    clmtv1BIK: TcxGridDBColumn;
    clmtv1NAME: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure aInsExecute(Sender: TObject);
    procedure aUpdExecute(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
    procedure pcClientRekvChange(Sender: TObject);
    procedure cbFormChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btHelpClick(Sender: TObject);
    procedure edShortNameEnter(Sender: TObject);
    procedure aInsFirmExecute(Sender: TObject);
    procedure aDelFirmExecute(Sender: TObject);
    procedure pc1Change(Sender: TObject);
    procedure tvFirmsFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure ceISPayNDSPropertiesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    { Public declarations }
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
    procedure ReadContact;
    procedure RefreshFirms;
    procedure GetRekv;
  end;

var
  FirmRekvizitForm: TFirmRekvizitForm;

implementation

uses frmMyAddressBankRek, frmMyFirmAddress, frmTochka, dmMain;

{$R *.dfm}

procedure TFirmRekvizitForm.ceISPayNDSPropertiesChange(Sender: TObject);
begin
  if ceISPayNDS.Checked = False then begin
    edSerial.Clear;
    edNum.Clear;
    deDate.Text := '';
    edIssuer.Clear;
    edNDS.Clear;

    edSerial.Enabled := False;
    edNum.Enabled := False;
    deDate.Enabled := False;
    edIssuer.Enabled := False;
    edNDS.Enabled := False;
  end else begin
    edSerial.Enabled := True;
    edNum.Enabled := True;
    deDate.Enabled := True;
    edIssuer.Enabled := True;
    edNDS.Enabled := True;
  end;
end;

function TFirmRekvizitForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(cbForm.Text) = EmptyStr then begin
    pc1.ActivePage := tsCommon;
    ErrControl := cbForm;
    MessageDlg('Организацоннная форма не выбрана!', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(edName.Text) = EmptyStr then begin
    pc1.ActivePage := tsCommon;
    ErrControl := edName;
    MessageDlg('Наименование не введено', mtInformation, [mbOK], 0);
    Exit;
  end;

  if ceISPayNDS.Checked then begin
    if Trim(edSerial.Text) = EmptyStr then begin
      pc1.ActivePage := tsNds;
      ErrControl := edSerial;
      MessageDlg('Серия свидетельства НДС не указана!', mtInformation, [mbOK], 0);
      Exit;
    end;
    if Trim(edNum.Text) = EmptyStr then begin
      pc1.ActivePage := tsNds;
      ErrControl := edNum;
      MessageDlg('Номер свидетельства НДС не указана!', mtInformation, [mbOK], 0);
      Exit;
    end;
    if Trim(edNum.Text) = EmptyStr then begin
      pc1.ActivePage := tsNds;
      ErrControl := edNum;
      MessageDlg('Номер свидетельства НДС не указана!', mtInformation, [mbOK], 0);
      Exit;
    end;
    if Trim(deDate.Text) = EmptyStr then begin
      pc1.ActivePage := tsNds;
      ErrControl := deDate;
      MessageDlg('Дата свидетельства НДС не указана!', mtInformation, [mbOK], 0);
      Exit;
    end;
    if Trim(edIssuer.Text) = EmptyStr then begin
      pc1.ActivePage := tsNds;
      ErrControl := edIssuer;
      MessageDlg('Орган выдачи не указан!', mtInformation, [mbOK], 0);
      Exit;
    end;
  end;

  Result := True;
end;

procedure TFirmRekvizitForm.tvFirmsFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GetRekv;
end;

procedure TFirmRekvizitForm.GetData;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      RecID := spGetData.ParamByName('g_firm_rekvizit__').AsInteger;
      edName.Text := ParamByName('NAME_').AsString;
      edShortName.Text := ParamByName('SHORT_NAME_').AsString;
      edIDN.Text := ParamByName('IDN_').AsString;
      edKPP.Text := ParamByName('KPP_').AsString;
      edOgrn.Text := ParamByName('OGRN_').AsString;
      edKBE.Text := ParamByName('KBE_').AsString;
      edOKPO.Text := ParamByName('OKPO_').AsString;
      ceISPayNDS.Checked := ParamByName('IS_NDS_').AsInteger = 1;
      ceBezNDS.Checked := ParamByName('NOL_VMESTO_BEZ_').AsInteger = 1;
      edSerial.Text := ParamByName('NDS_SERIAL_').AsString;
      edNum.Text := ParamByName('NDS_NUM_').AsString;
      if DateToStr(ParamByName('NDS_DATE_').AsDate) <> '30.12.1899' then
        deDate.Date := ParamByName('NDS_DATE_').AsDate;
      edIssuer.Text := ParamByName('NDS_ORGAN_').AsString;
      edNDS.Value := ParamByName('NDS_value_').AsFloat;
      edHead.Text := ParamByName('HEAD_').AsString;
      edMainChief.Text := ParamByName('MAIN_CHIEF_').AsString;
      edEmail.Text := ParamByName('EMAIL_').AsString;
      edWebsite.Text := ParamByName('WEBSITE_').AsString;
      cbForm.ItemIndex := ParamByName('ip_or_jur_').AsInteger;
      cbByDefault.Checked := ParamByName('is_default_').AsInteger = 1;
    end;
  end;
  ReadContact;
end;

procedure TFirmRekvizitForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('NAME_').AsString := edName.Text;
    ParamByName('SHORT_NAME_').AsString := edShortName.Text;
    ParamByName('IDN_').AsString := edIDN.Text;
    ParamByName('KPP_').AsString := edKPP.Text;
    ParamByName('OGRN_').AsString := edOgrn.Text;
    ParamByName('KBE_').AsString := edKBE.Text;
    ParamByName('OKPO_').AsString := edOKPO.Text;
    ParamByName('IS_NDS_').AsInteger := Integer(ceISPayNDS.Checked);
    ParamByName('NOL_VMESTO_BEZ_').AsInteger := Integer(ceBezNDS.Checked);
    ParamByName('NDS_SERIAL_').AsString := edSerial.Text;
    ParamByName('NDS_NUM_').AsString := edNum.Text;
    if (deDate.Text <> '  .  .    ') and (deDate.Text <> '00.00.0000') then
      ParamByName('NDS_DATE_').AsDate := deDate.Date;

    ParamByName('NDS_ORGAN_').AsString := edIssuer.Text;
    ParamByName('NDS_value_').AsFloat := edNDS.Value;
    ParamByName('HEAD_').AsString := edHead.Text;
    ParamByName('MAIN_CHIEF_').AsString := edMainChief.Text;
    ParamByName('EMAIL_').AsString := edEmail.Text;
    ParamByName('WEBSITE_').AsString := edWebsite.Text;
    ParamByName('ip_or_jur_').AsInteger := cbForm.ItemIndex;
    ParamByName('is_default_').AsInteger := Integer(cbByDefault.Checked);
  end;
end;

procedure TFirmRekvizitForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'g_firm_rekvizit_';
end;

procedure TFirmRekvizitForm.aInsExecute(Sender: TObject);
begin
  inherited;
  if pc1.ActivePage <> tsSklad then begin
    if RecID = 0 then begin
      MessageDlg('Сначала сохраните реквизиты.', mtWarning, [mbOk], 0);
      Exit;
    end;

    if pcClientRekv.ActivePage = tsContact then begin
      MyFirmAddressForm := TMyFirmAddressForm.Create(Self);
      try
        MyFirmAddressForm.OpenMode := omInsert;
        MyFirmAddressForm.GFirmRekvizit := RecID;
        if MyFirmAddressForm.ShowModal = mrOk then begin
          ReadContact;
          spReadContact.Locate('G_ADDRESS', MyFirmAddressForm.RecID, []);
          FocusRowAfterInscxGrid(tvContact);
        end;
      finally
        MyFirmAddressForm.Free;
      end;

    end else if pcClientRekv.ActivePage = tsBankRekv then begin
      MyAddressBankRekForm := TMyAddressBankRekForm.Create(Self);
      try
        MyAddressBankRekForm.OpenMode := omInsert;
        MyAddressBankRekForm.GFirmRekvizit := RecID;
        if MyAddressBankRekForm.ShowModal = mrOk then begin
          ReadContact;
          spReadBankRekv.Locate('G_ACCOUNT', MyAddressBankRekForm.RecID, []);
          FocusRowAfterInscxGrid(tvBank);
        end;
      finally
        MyAddressBankRekForm.Free;
      end;
    end;
  end else begin
    TochkaForm := TTochkaForm.Create(Self);
    try
      TochkaForm.OpenMode := omInsert;
      if TochkaForm.ShowModal = mrOk then begin
        ReadContact;

        //если массив складов не был заполнен, то надо заполнить его и основным складом тоже
        if High(SkladArr) = -1 then begin
          SetLength(SkladArr, 1);
          SkladArr[0].ID := 1;
          spTochka.Locate('g_tochka', 1, []);
          SkladArr[0].Name := spTochka.fieldbyname('name').AsString;
        end;
        spTochka.Locate('g_tochka', TochkaForm.RecID, []);
        SetLength(SkladArr, High(SkladArr) + 2);
        SkladArr[High(SkladArr)].ID := spTochka.fieldbyname('g_tochka').AsInteger;
        SkladArr[High(SkladArr)].Name := spTochka.fieldbyname('name').AsString;
      end;
    finally
      TochkaForm.Free;
    end;
  end;
end;

procedure TFirmRekvizitForm.aUpdExecute(Sender: TObject);
begin
  inherited;
  if pc1.ActivePage <> tsSklad then begin
    if pcClientRekv.ActivePage = tsContact then begin
      MyFirmAddressForm := TMyFirmAddressForm.Create(Self);
      try
        MyFirmAddressForm.OpenMode := omUpdate;
        MyFirmAddressForm.RecID := spReadContact.FieldByName('g_address').AsInteger;
        MyFirmAddressForm.GFirmRekvizit := RecID;
        if MyFirmAddressForm.ShowModal = mrOk then
        begin
          ReadContact;
        end;
      finally
        MyFirmAddressForm.Free;
      end;

    end else if pcClientRekv.ActivePage = tsBankRekv then begin
      MyAddressBankRekForm := TMyAddressBankRekForm.Create(Self);
      try
        MyAddressBankRekForm.OpenMode := omUpdate;
        MyAddressBankRekForm.RecID := spReadBankRekv.FieldByName('g_account').AsInteger;
        MyAddressBankRekForm.GFirmRekvizit := RecID;
        if MyAddressBankRekForm.ShowModal = mrOk then
        begin
          ReadContact;
        end;
      finally
        MyAddressBankRekForm.Free;
      end;
    end;
  end else begin
    TochkaForm := TTochkaForm.Create(Self);
    try
      TochkaForm.OpenMode := omUpdate;
      TochkaForm.RecID := spTochka.FieldByName('g_tochka').AsInteger;
      if TochkaForm.ShowModal = mrOk then
        ReadContact;
    finally
      TochkaForm.Free;
    end;
  end;
end;

procedure TFirmRekvizitForm.aDelExecute(Sender: TObject);
var SP : TpFIBStoredProc;
  i : integer;
begin
  if pc1.ActivePage <> tsSklad then begin
    if pcClientRekv.ActivePage = tsContact then begin
      if MessageDlg(Format('Удалить адрес "%s" ?',
        [spReadContact.FieldByName('Address').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

      SP := spDelContact;
      SP.ParamByName('G_ADDRESS_').AsInteger := spReadContact.FieldByName('G_ADDRESS').AsInteger;

      if ExecSPTR(SP) then
        ReadContact;

    end else if pcClientRekv.ActivePage = tsBankRekv then begin
      if MessageDlg(Format('Удалить счет "%s" ?',
        [spReadBankRekv.FieldByName('Account').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;

      SP := spDelBankRekv;
      SP.ParamByName('G_account_').AsInteger := spReadBankRekv.FieldByName('G_account').AsInteger;
    
      if ExecSPTR(SP) then
        ReadContact;

    end;
  end else begin
    if spTochka.FieldByName('g_tochka').AsInteger = 1 then begin
      MessageDlg('Данный склад является основным и не может быть удален.', mtConfirmation, [mbOk], 0);
      Exit;
    end;

    if spTochka.FieldByName('g_tochka').AsInteger = CurSklad then begin
      MessageDlg('Вы не можете удалить текущий склад, в котором вы находитесь!' + #10#13 + 'Закройте окно, через меню "Сервис - Склады" пройдите на другой склад и попробуйте снова.', mtConfirmation, [mbOk], 0);
      Exit;
    end;

    if MessageDlg(Format('Вы совершенно уверены, что хотите удалить склад "%s" ?' + #10#13 + 'Все данные склада будут удалены, с невозможностью восстановления!',
      [spTochka.FieldByName('name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    SP := spDelTochka;
    SP.ParamByName('G_tochka_').AsInteger := spTochka.FieldByName('G_tochka').AsInteger;

    if ExecSPTR(SP) then begin
      ReadContact;
      //переформировываю весь массив, причем если в списке складов остался лишь один Основной склад, то массив не заполняю
      SetLength(SkladArr, 0);
      SetLength(SkladArr, spTochka.AllRecordCount);
      spTochka.First;
      i := 0;
      while not spTochka.Eof do begin
        SkladArr[i].ID := spTochka.FieldByName('g_tochka').AsInteger;
        SkladArr[i].Name := spTochka.FieldByName('name').Asstring;
        spTochka.Next;
        inc(i);
      end;
    end;
  end;
end;

procedure TFirmRekvizitForm.ReadContact;
begin
  if pc1.ActivePage <> tsSklad then begin
    if pcClientRekv.ActivePage = tsContact then begin
      spReadContact.ParamByName('g_firm_').AsInteger := RecID;
      OpenSP(spReadContact, True);
      aUpd.Enabled := spReadContact.RecordCount > 0;
      aDel.Enabled := spReadContact.RecordCount > 0;
    end else if pcClientRekv.ActivePage = tsBankRekv then begin
      spReadBankRekv.ParamByName('g_firm_').AsInteger := RecID;
      OpenSP(spReadBankRekv, True);
      aUpd.Enabled := spReadBankRekv.RecordCount > 0;
      aDel.Enabled := spReadBankRekv.RecordCount > 0;
    end;
  end else begin
    OpenSP(spTochka, True);
    aUpd.Enabled := spTochka.RecordCount > 0;
    aDel.Enabled := spTochka.RecordCount > 0;  //основной склад удалить нельзя
  end;
end;

procedure TFirmRekvizitForm.pcClientRekvChange(Sender: TObject);
begin
  inherited;
  ReadContact;
end;

procedure TFirmRekvizitForm.cbFormChange(Sender: TObject);
begin
  edName.ModifiedAfterEnter := True;  // иначе не цепляется изменения
end;

procedure TFirmRekvizitForm.FormShow(Sender: TObject);
begin
  pc1.ActivePage := tsCommon;
  //для России видны поля КПП и ОГРН
  if CurrencyVal in [1,2] then begin
    lbKPP.Visible := True;
    shKPP.Visible := True;
    shpKPP1.Visible := True;
    edKPP.Visible := True;
    edKPP.Enabled := True;
    lbOgrn.Visible := True;
    shpOgrn.Visible := True;
    shpOgrn1.Visible := True;
    edOgrn.Visible := True;
    edOgrn.Enabled := True;
    lbIDN.Caption  := 'ИНН';
  end else begin
    lbKPP.Visible := false;
    shKPP.Visible := false;
    shpKPP1.Visible := false;
    edKPP.Visible := false;
    edKPP.Enabled := false;
    lbOgrn.Visible := false;
    shpOgrn.Visible := false;
    shpOgrn1.Visible := false;
    edOgrn.Visible := false;
    edOgrn.Enabled := false;
    lbIDN.Caption  := 'ИИН/БИН';
  end;

  inherited;

  if ManyFirm = 1 then begin
    RefreshFirms;
    tsFirms.TabVisible := True;
    //onChange := tvFirms.OnFocusedRecordChanged;
    //tvFirms.OnFocusedRecordChanged := nil;
    spReadFirms.Locate('is_default', 1, []);
    if tvFirms.Controller.FocusedRow <> Nil then begin
      if tvFirms.Controller.SelectedRowCount > 0 then
        tvFirms.Controller.SelectedRows[0].Selected := False;
      tvFirms.Controller.FocusedRow.Selected := True;
    end;
    //tvFirms.OnFocusedRecordChanged := onChange;
  end else
    tsFirms.TabVisible := False;

  if ProductName = 'SalonUchet' then
    tsSklad.Caption := 'Филиалы';
end;

procedure TFirmRekvizitForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tvContact.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvContact.name);
  tvBank.StoreToIniFile('Settings.ini', False, [], Self.Name + '-' + tvBank.name);
end;

procedure TFirmRekvizitForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  edName.ModifiedAfterEnter := True;
  inherited;

  if (ModalResult = mrOk) and (Success = True) then begin
    NdsValue := edNDS.Value;
    if RecID = 0 then
      RecID := spUpd.FieldByName('G_FIRM_REKVIZIT__').AsInteger;

    Showmessage('Сохранено успешно!');
    RefreshFirms;
    if tvFirms.Controller.FocusedRow <> Nil then begin
      if tvFirms.Controller.SelectedRowCount > 0 then
        tvFirms.Controller.SelectedRows[0].Selected := False;
      tvFirms.Controller.FocusedRow.Selected := True;
    end;

    CanClose := False;
  end;
end;

procedure TFirmRekvizitForm.btHelpClick(Sender: TObject);
begin
  Helpc := 3;
  inherited;
end;

procedure TFirmRekvizitForm.edShortNameEnter(Sender: TObject);
begin
  if edShortName.Text = '' then
    edShortName.Text := edName.Text;
end;

procedure TFirmRekvizitForm.RefreshFirms;
begin
  OpenSP(spReadFirms, True);
  cbByDefault.Checked := spReadFirms.FieldByName('is_default').AsInteger = 1;
  aDelFirm.Enabled := spReadFirms.RecordCount > 1;  //нельзя удалять если компания осталась одна
end;

procedure TFirmRekvizitForm.aInsFirmExecute(Sender: TObject);
VAR I : INTEGER;
begin
  //создам новую фирму с названием "Новая фирма"
  for i := 0 to spUpd.ParamCount - 1 do
    spUpd.ParamByName(spUpd.ParamName(I)).Clear;
  spUpd.ParamByName('name_').AsString := 'Новая фирма';
  spUpd.ParamByName('IS_NDS_').AsInteger := 0;
  spUpd.ParamByName('NOL_VMESTO_BEZ_').AsInteger := 0;
  spUpd.ParamByName('NDS_value_').AsFloat := 0;
  spUpd.ParamByName('ip_or_jur_').AsInteger := 0;
  if ExecSPTR(spUpd) then begin
    Showmessage('Компания создана успешно!');
    RefreshFirms;
    RecID := spUpd.ParamByName('G_FIRM_REKVIZIT__').AsInteger;
    spReadFirms.Locate('g_firm_rekvizit', RecID, []);
    if tvFirms.Controller.FocusedRow <> Nil then begin
      if tvFirms.Controller.SelectedRowCount > 0 then
        tvFirms.Controller.SelectedRows[0].Selected := False;
      tvFirms.Controller.FocusedRow.Selected := True;
    end;
  end;
end;

procedure TFirmRekvizitForm.aDelFirmExecute(Sender: TObject);
begin
  if MessageDlg('Вы уверены, что хотите удалить компанию "' + spReadFirms.FieldByName('name').AsString + '"?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    spDelFirm.ParamByName('G_FIRM_REKVIZIT_').AsInteger := spReadFirms.FieldByName('g_firm_rekvizit').AsInteger;
    if ExecSPTR(spDelFirm) then begin
      Showmessage('Компания удалена успешно!');
      RefreshFirms;
      if tvFirms.Controller.FocusedRow <> Nil then begin
        if tvFirms.Controller.SelectedRowCount > 0 then
          tvFirms.Controller.SelectedRows[0].Selected := False;
        tvFirms.Controller.FocusedRow.Selected := True;
      end;
      GetRekv;
    end;
  end;
end;

procedure TFirmRekvizitForm.GetRekv;
begin
  RecId := spReadFirms.FieldByName('g_firm_rekvizit').AsInteger;
  GetData;
end;

procedure TFirmRekvizitForm.pc1Change(Sender: TObject);
begin
  if pc1.ActivePage = tsSklad then
    if spTochka.Active = False then
      ReadContact;
end;

end.
