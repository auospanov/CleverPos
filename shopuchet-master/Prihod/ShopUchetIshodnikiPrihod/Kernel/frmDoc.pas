unit frmDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, unCommonFunc, FIBQuery,
  pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet,
  pFIBDataSet, AppEvnts, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxPC, xmldom, XMLIntf, msxmldom, XMLDoc,
  dxmdaset, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxMemo, System.UITypes,
  dxBarBuiltInMenu, Vcl.ComCtrls, dxCore, cxDateUtils, cxNavigator,
  System.Actions, cxButtons, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TDocForm = class(TDBEditForm)
    dsAddress: TDataSource;
    dsAccount: TDataSource;
    dsIspolnitel: TDataSource;
    aPrint: TAction;
    dsIikClient: TDataSource;
    dsRukovoditel: TDataSource;
    dsGlavBuh: TDataSource;
    dsMestoClienta: TDataSource;
    spAddress: TpFIBDataSet;
    spAccount: TpFIBDataSet;
    spMestoClienta: TpFIBDataSet;
    spIikClient: TpFIBDataSet;
    spRukovoditel: TpFIBDataSet;
    spIspolnitel: TpFIBDataSet;
    spGlavBuh: TpFIBDataSet;
    spFirm: TpFIBDataSet;
    dsFirm: TDataSource;
    spClient: TpFIBDataSet;
    dsClient: TDataSource;
    pcMain: TcxPageControl;
    tsDocs: TcxTabSheet;
    shp4: TShape;
    shp3: TShape;
    shp2: TShape;
    shp1: TShape;
    Shape9: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape44: TShape;
    Shape43: TShape;
    Shape42: TShape;
    Shape41: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape26: TShape;
    Shape25: TShape;
    Shape2: TShape;
    Shape16: TShape;
    Shape15: TShape;
    Shape14: TShape;
    Shape13: TShape;
    Shape12: TShape;
    Shape11: TShape;
    Shape10: TShape;
    Shape1: TShape;
    pnParam2: TPanel;
    Shape35: TShape;
    lbParam2: TLabel;
    Shape36: TShape;
    pnParam1: TPanel;
    Shape37: TShape;
    lbParam1: TLabel;
    Shape38: TShape;
    lb2: TLabel;
    lbClient: TLabel;
    Label8: TLabel;
    lbClientIIk: TLabel;
    lbCompanyAccount: TLabel;
    lbCompanyAddress: TLabel;
    lbCompany: TLabel;
    lbClientAddress: TLabel;
    Label21: TLabel;
    Label2: TLabel;
    lbOfficial: TLabel;
    Label1: TLabel;
    edDate: TcxDateEdit;
    cbbFirm: TcxLookupComboBox;
    cbbClient: TcxLookupComboBox;
    tsDetails: TcxTabSheet;
    pn3: TPanel;
    btnIns: TBitBtn;
    btnDel: TBitBtn;
    btnUpd: TBitBtn;
    dsTovary: TDataSource;
    mdTovary: TdxMemData;
    strngfldMemData1name: TStringField;
    strngfldMemData1amount: TStringField;
    strngfldTovaryg_product: TStringField;
    xmlTovary: TXMLDocument;
    edNum: TcxTextEdit;
    leIspolnitel: TcxLookupComboBox;
    leGlavBuh: TcxLookupComboBox;
    leRukovoditel: TcxLookupComboBox;
    mNote: TcxMemo;
    edParam1: TcxTextEdit;
    edParam2: TcxTextEdit;
    gr1: TcxGrid;
    tvTovary: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    cxgrdbclmnMainRecId: TcxGridDBColumn;
    cxgrdbclmnMaing_product: TcxGridDBColumn;
    cxgrdbclmnMainname: TcxGridDBColumn;
    cxgrdbclmnMainamount: TcxGridDBColumn;
    leMestoClienta: TcxLookupComboBox;
    leIikClient: TcxLookupComboBox;
    leAddress: TcxLookupComboBox;
    leAccount: TcxLookupComboBox;
    cxButton1: TcxButton;
    procedure aPrintExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure edNumKeyPress(Sender: TObject; var Key: Char);
    procedure cbbClientPropertiesChange(Sender: TObject);
    procedure cbbFirmPropertiesChange(Sender: TObject);
    procedure btnInsClick(Sender: TObject);
    procedure btnUpdClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  private
    FIsSaved : integer;  // 0 - счет еще не сохранен, 1 - сохранен (то есть счета не было до сего момента, будет создан сейчас)
    FZakaz : integer;
    FDocType : integer;   // тип документа 0 - ПКО, 1 - акт выполненных работ, 2 - доверенность
  public
    property Zakaz: Integer read FZakaz write FZakaz;
    property DocType: Integer read FDocType write FDocType;
    property IsSaved: Integer read FIsSaved write FIsSaved;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  DocForm: TDocForm;

implementation

uses dmReports, frmMyCurrencyFrame, PriceListUnSostav, unInitApp;

{$R *.dfm}

function TDocForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if cbbFirm.EditValue = 0 then begin
    ErrControl := cbbFirm;
    MessageDlg('Поле "' + lbCompany.Caption +'" не указано!', mtInformation, [mbOK], 0);
    pcMain.ActivePage := tsDocs;
    Exit
  end;

  if cbbClient.EditValue = 0 then begin
    ErrControl := cbbClient;
    MessageDlg('Поле "' + lbClient.Caption +'" не указано!', mtInformation, [mbOK], 0);
    pcMain.ActivePage := tsDocs;    
    Exit
  end;

  if leIspolnitel.EditValue = 0 then begin
    ErrControl := leIspolnitel;
    MessageDlg('Исполнитель не указан!', mtInformation, [mbOK], 0);
    pcMain.ActivePage := tsDocs;    
    Exit
  end;

  if (FDocType = 2) and (mdTovary.RecordCount = 0) then begin
    MessageDlg('Укажите хотя бы один товар для получения!', mtInformation, [mbOK], 0);
    pcMain.ActivePage := tsDetails;
    Exit
  end;

  Result := True;
end;

procedure TDocForm.GetData;
var xmlStream : TMemoryStream;
   XmlDocNode, XmlNode : IXMLNode;
   var i : Integer;
begin
  if OpenMode = omInsert then
    OpenMode := omUpdate;
  spGetData.ParamByName('ZAKAZ_').AsInteger := FZakaz;
  spGetData.ParamByName('DOC_TYPE_').AsInteger := FDocType;
  inherited;
  with spGetData do begin
    IF not (VarIsNull(ParamByName('DOCS_ID_').AsINTEGER)) THEN          // ПРИ GETDATA ДОКУМЕНТ НЕ ВСЕГДА БЫВАЕТ СОЗДАН
      RecID :=  ParamByName('DOCS_ID_').AsINTEGER;
    edNum.Text := ParamByName('NUM_').AsString;
    edDate.Date := ParamByName('DOCS_DATE_').AsDate;
    cbbFirm.EditValue := ParamByName('G_FIRM_').Asinteger;
    leAddress.EditValue := ParamByName('G_FIRM_ADDRESS_').AsInteger;
    leAccount.EditValue := ParamByName('G_FIRM_ACCOUNT_').AsInteger;
    cbbClient.EditValue := ParamByName('G_CLIENT_').Asinteger;
    leMestoClienta.EditValue := ParamByName('G_CLIENT_ADDRESS_').AsInteger;
    leIikClient.EditValue := ParamByName('G_CLIENT_ACCOUNT_').AsInteger;
    leRukovoditel.EditValue := ParamByName('G_OFFICIAL_RUKOVOD_').AsInteger;
    leIspolnitel.EditValue := ParamByName('G_OFFICIAL_').AsInteger;
    IF spGlavBuh.RecordCount = 0 THEN
      leGlavBuh.Text := 'Не предусмотрен'
    ELSE
      leGlavBuh.EditValue := ParamByName('GLAVBUH_').AsInteger;
    mNote.Text := ParamByName('NOTE_').AsString;
    edParam1.Text := ParamByName('PARAM1_').AsString;
    edParam2.Text := ParamByName('PARAM2_').AsString;
    FIsSaved := ParamByName('IS_SAVED_').AsInteger;

    if (FDocType = 2) and (RecID > 0) then begin
      try
        mdTovary.Open;
        xmlStream := TMemoryStream.Create;
        ParamByName('param6_').SaveToStream(xmlStream);
        xmlTovary.LoadFromStream(xmlStream);
        xmlTovary.Active := true;
        XmlDocNode := xmlTovary.DocumentElement;
        for i := 0 to XmlDocNode.ChildNodes.Count - 1 do begin
          if XmlDocNode.ChildNodes[i].NodeName <> 'tovar' then Continue;
          XmlNode := XmlDocNode.ChildNodes[i];
          mdTovary.Insert;
          mdTovary.FieldByName('g_product').AsInteger := XmlNode.ChildNodes[0].NodeValue;
          mdTovary.FieldByName('name').AsString := XmlNode.ChildNodes[1].NodeValue;
          mdTovary.FieldByName('amount').AsFloat := XmlNode.ChildNodes[2].NodeValue;
          mdTovary.Refresh;
        end;
      finally
        FreeAndNil(xmlStream);
        xmlTovary.Active := False;
      end;
    end;
  end;
end;

procedure TDocForm.SetParams(SP: TpFIBStoredProc);
var xmlStream : TMemoryStream;
   XmlRoot : IXMLNode;
   amount_itog : double;
begin
  with SP do begin
    ParamByName('NUM_').AsString := edNum.Text;
    ParamByName('DOCS_DATE_').AsDate := edDate.Date;
    ParamByName('G_FIRM_').Asinteger := cbbFirm.EditValue;
    if leAddress.EditValue > 0 then
      ParamByName('G_FIRM_ADDRESS_').AsInteger := leAddress.EditValue;
    if leAccount.EditValue > 0 then
      ParamByName('G_FIRM_ACCOUNT_').AsInteger := leAccount.EditValue;
    ParamByName('G_CLIENT_').Asinteger := cbbClient.EditValue;
    if leMestoClienta.EditValue > 0 then
      ParamByName('G_CLIENT_ADDRESS_').AsInteger := leMestoClienta.EditValue;
    if leIikClient.EditValue > 0 then
      ParamByName('G_CLIENT_ACCOUNT_').AsInteger := leIikClient.EditValue;
    if leRukovoditel.EditValue > 0 then
      ParamByName('G_OFFICIAL_RUKOVOD_').AsInteger := leRukovoditel.EditValue;
    if leIspolnitel.EditValue > 0 then
      ParamByName('G_OFFICIAL_').AsInteger := leIspolnitel.EditValue;
    if leGlavBuh.EditValue > 0 then
      ParamByName('GLAVBUH_').AsInteger := leGlavBuh.EditValue;
    ParamByName('NOTE_').AsString := mNote.Text;
    ParamByName('PARAM1_').AsString := edParam1.Text;
    ParamByName('PARAM2_').AsString := edParam2.Text;
    if SP.Name='spIns' then begin
      ParamByName('ZAKAZ_').AsInteger := FZakaz;
      ParamByName('doc_type_').AsInteger := FDocType;
    end;

    if FDocType = 2 then begin
      try
        xmlTovary.Active := true;
        with xmlTovary do begin
          Active := true;
          Version := '1.0';
          Encoding := 'WINDOWS-1251';
          DocumentElement:=AddChild('tovary');
        end;
        mdTovary.First;
        while not mdTovary.Eof do begin
          XmlRoot:=xmlTovary.ChildNodes['tovary'].AddChild('tovar');
          with XmlRoot do
          begin
            AddChild('id');
            ChildValues['id'] := mdTovary.FieldByName('g_product').AsString;
            AddChild('name');
            ChildValues['name'] := mdTovary.FieldByName('name').AsString;
            AddChild('amount');
            ChildValues['amount'] := mdTovary.FieldByName('amount').AsString;
          end;
          amount_itog := amount_itog + mdTovary.FieldByName('amount').asfloat;
          mdTovary.Next;
        end;

        // в самом конце добавляю итоговое количество
        XmlRoot:=xmlTovary.ChildNodes['tovary'].AddChild('amount_itog');
        XmlRoot.ChildValues['amount_itog_val'] := FloatToStr(amount_itog);

        xmlStream := TMemoryStream.Create;
        xmlTovary.SaveToStream(xmlStream);
        ParamByName('param6_').LoadFromStream(xmlStream);
      finally
        FreeAndNil(xmlStream);
        xmlTovary.Active := false;
      end;
    end;
  end;

  inherited;
end;

procedure TDocForm.aPrintExecute(Sender: TObject);
var str : string;
begin
  inherited;

  if FIsSaved = 0 then begin
    MessageDlg('Сначала сохраните документ!', mtWarning, [mbOK], 0);
    Exit;
  end;

  IF FDocType = 0 THEN BEGIN
    ReportsDM.PrepareReport(36);
    str := 'Приходный кассовый ордер №';
  END ELSE if FDocType = 1 then BEGIN
    ReportsDM.PrepareReport(37);
    str := 'Акт выполненных работ №';
  end ELSE BEGIN
    ReportsDM.PrepareReport(38);
    str := 'Доверенность №';
  end;

  ReportsDM.spReport.ParamByName('CURRENCY_').AsInteger := CURRENCYVal;
  ReportsDM.spReport.ParamByName('Doc_').AsInteger := RecId;
  ReportsDM.spReport.ParamByName('Zakaz_').AsInteger := FZakaz;
  ReportsDM.spReport.ParamByName('Doc_type_').AsInteger := FDocType;
  ReportsDM.ShowReport(1, str + edNum.Text + ' от ' + edDate.Text);
end;

procedure TDocForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult <> mrOk then
    Exit;

  CanClose := False;

  if (OpenMode in [omInsert, omInsertLike, omInsertChild]) or (RecId = 0) then
    Success := InsData
  else if OpenMode = omUpdate then
    Success := UpdData;

  if Success then begin
    FIsSaved := 1;
    MessageDlg('Документ сохранен успешно!', mtInformation, [mbOK], 0);
  end;

  CanClose := False;
end;

procedure TDocForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField := 'Docs_';

  // если Салон или Сервис учет, то другой селект
  if AppName = 'ServiceUchet' then begin
    spIspolnitel.SQLs.SelectSQL.Text := 'SELECT * FROM G_READ_G_OFFICIAL_LIST(?IS_CATEGORY_, ?MODE_, ?IS_FIRED_)';
    spIspolnitel.ParamByName('is_category_').AsInteger := 0;
    spIspolnitel.ParamByName('is_fired_').AsInteger := 0;
  end;
end;

procedure TDocForm.FormShow(Sender: TObject);
begin
  pcMain.ActivePage := tsDocs;
  tsDetails.TabVisible := False;
  edNum.SetFocus;
  spClient.ParamByName('IS_SUPPLIER_').AsInteger := 0;
  if FDocType = 0 then begin
    Caption := 'Приходный кассовый ордер';
    pnParam1.Visible := True;
    pnParam2.Visible := True;
  end else if FDocType = 1 then begin
    Caption := 'Акт выполненных работ';
    lbParam1.Caption := 'Сведения об использ. запасов';
    pnParam2.Visible := False;
  end else if FDocType = 2 then begin
    Caption := 'Доверенность на получение запасов';
    lbCompany.Caption := 'Организация-получатель';
    lbCompanyAddress.Caption := 'Адрес получателя';
    lbCompanyAccount.Caption := 'Расчетный счет получателя';
    lbClient.Caption := 'Поставщик';
    lbClientAddress.Caption  := 'Адрес поставщика';
    lbClientIIk.Caption := 'Расчетный счет поставщика';
    tsDetails.TabVisible := true;
    spClient.ParamByName('IS_SUPPLIER_').AsInteger := 1;
    lbOfficial.Caption := 'Получатель (кому выдана)';
    lbParam1.Caption := 'Действительно до';
    lbParam2.Caption := 'Получение активов согласно';
  end;

  inherited;
  OpenSP(spFirm, False);
  OpenSP(spClient, False);
  spRukovoditel.ParamByName('GLAVBUH_OR_RUKOVODITEL_').AsInteger := 1;
  OpenSP(spRukovoditel, False);
  spRukovoditel.First;
  leRukovoditel.EditValue := spRukovoditel.FieldByName('g_official').AsInteger;
  OpenSP(spIspolnitel, False);
  spGlavBuh.ParamByName('GLAVBUH_OR_RUKOVODITEL_').AsInteger := 2;
  OpenSP(spGlavBuh, False);
end;

procedure TDocForm.btHelpClick(Sender: TObject);
begin
  if FDocType = 0 then
    Helpc := 72
  else if FDocType = 1 then
    Helpc := 73
  else if FDocType = 2 then
    Helpc := 74;

  inherited;
end;

procedure TDocForm.edNumKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

procedure TDocForm.cbbClientPropertiesChange(Sender: TObject);
begin
  spIikClient.ParamByName('g_client_').AsInteger := cbbClient.editValue;
  OpenSP(spIikClient, False);
  spIikClient.Locate('IS_DEFAULT', 1, []);
  leIikClient.EditValue := spIikClient.FieldByName('g_account').AsInteger;
  spMestoClienta.ParamByName('g_client_').AsInteger := cbbClient.editValue;
  OpenSP(spMestoClienta, False);
  spMestoClienta.Locate('IS_DEFAULT', 1, []);
  leMestoClienta.EditValue := spMestoClienta.FieldByName('g_address').AsInteger;
end;

procedure TDocForm.cbbFirmPropertiesChange(Sender: TObject);
begin
  spAddress.ParamByName('g_firm_').AsInteger := cbbFirm.editValue;
  OpenSP(spAddress, False);
  spAddress.Locate('IS_DEFAULT', 1, []);
  leAddress.EditValue := spAddress.FieldByName('g_address').AsInteger;
  spAccount.ParamByName('g_firm_').AsInteger := cbbFirm.editValue;
  OpenSP(spAccount, False);
  spAccount.Locate('IS_DEFAULT', 1, []);
  leAccount.EditValue := spAccount.FieldByName('g_account').AsInteger;
end;

procedure TDocForm.btnInsClick(Sender: TObject);
var PriceListUnSostavForm: TPriceListUnSostavForm;
begin
  PriceListUnSostavForm := TPriceListUnSostavForm.Create(Self);
  with PriceListUnSostavForm do begin
    try
      edPrice.Enabled := False;
      edPriceVol.Enabled := False;
      Typ := 3;       // чтобы отражались все продукты
      if ShowModal = mrOk then begin
        if mdTovary.Active = False then
          mdTovary.Open;
          
        if mdTovary.Locate('g_product', spRead.FieldByName('g_product').AsInteger, []) then begin
          mdTovary.Edit;
          mdTovary.FieldByName('amount').AsFloat := mdTovary.FieldByName('amount').AsFloat + StrToFloat(MyCurrencyFrameForm.edAmount.Text);
        end else begin
          mdTovary.Insert;
          mdTovary.FieldByName('g_product').asInteger := spRead.FieldByName('g_product').AsInteger;
          mdTovary.FieldByName('name').asString := spRead.FieldByName('Name').AsString;
          mdTovary.FieldByName('amount').AsFloat := StrToFloat(MyCurrencyFrameForm.edAmount.Text);
        end;
        mdTovary.Refresh;
        mdTovary.Locate('g_product', spRead.FieldByName('g_product').AsInteger, []);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TDocForm.btnUpdClick(Sender: TObject);
var PriceListUnSostavForm: TPriceListUnSostavForm;
begin
  if tvTovary.Controller.SelectedRowCount < 0 then begin
    MessageDlg('Выберите запись!', mtWarning, [mbOK], 0);
    Exit;
  end;

  PriceListUnSostavForm := TPriceListUnSostavForm.Create(Self);
  with PriceListUnSostavForm do begin
    try
      edPrice.Enabled := False;
      edPriceVol.Enabled := False;
      Id := mdTovary.FieldByName('g_product').AsInteger;
      Typ := 3;       // чтобы отражались все продукты
      Amount := mdTovary.FieldByName('amount').AsString;
      if ShowModal = mrOk then begin
        mdTovary.Edit;
        mdTovary.FieldByName('amount').AsFloat := StrToFloat(MyCurrencyFrameForm.edAmount.Text);
        mdTovary.Refresh;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TDocForm.btnDelClick(Sender: TObject);
begin
  if tvTovary.Controller.SelectedRowCount < 0 then begin
    MessageDlg('Выберите запись!', mtWarning, [mbOK], 0);
    Exit;
  end;
  
  mdTovary.Delete;
end;

end.

