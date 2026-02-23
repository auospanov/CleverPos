unit frmPriceListUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, ExtCtrls, StdCtrls, Buttons,
  DB, FIBDataSet, idGlobal,
  pFIBDataSet, AppEvnts, cxPC, cxControls,
  ComCtrls, ExtDlgs, jpeg, pngimage, frmDBDlg, pFIBErrorHandler, unErrorHandlers, FIB,
  dxmdaset, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxMemo,
  cxCurrencyEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Menus, System.UITypes, dxBarBuiltInMenu,
  cxNavigator, System.Actions, cxButtons, cxEditRepositoryItems, cxCheckBox,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, unLog, JvComponentBase, JvThread, Winapi.ActiveX, SHDocVw,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TArr = record
    ID: Integer;
    Name: String;
    Amount : Double;
    Price : Double;
  end;
  TProductList = class(TObject)
  public
    ID: Integer;
    Name: String;
    Amount : Double;
    Price : Double;
  end;

type
  TPriceListUnForm = class(TDBEditForm)
    spGUnit: TpFIBDataSet;
    spProductCategory: TpFIBDataSet;
    dsProductCategory: TDataSource;
    dsGUnit: TDataSource;
    spGetArticul: TpFIBStoredProc;
    spGetBarcode: TpFIBStoredProc;
    aGenBarcode: TAction;
    aClearBarcode: TAction;
    aGenArticul: TAction;
    aClearArticul: TAction;
    cxPageControl: TcxPageControl;
    tsCommon: TcxTabSheet;
    SpeedButton4: TSpeedButton;
    SpeedButton3: TSpeedButton;
    btnGenBarcode: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Shape9: TShape;
    Shape8: TShape;
    Shape7: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape26: TShape;
    Shape25: TShape;
    Shape2: TShape;
    Shape14: TShape;
    Shape13: TShape;
    Shape12: TShape;
    Shape11: TShape;
    Shape10: TShape;
    Shape1: TShape;
    rb8: TRadioButton;
    rb13: TRadioButton;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    tsBarcode: TcxTabSheet;
    spBarcode: TpFIBDataSet;
    dsBarcode: TDataSource;
    aRefreshBarcode: TAction;
    spInsBarcode: TpFIBStoredProc;
    spDelBarcode: TpFIBStoredProc;
    sbInsCategory: TSpeedButton;
    aInsCategory: TAction;
    lbNote: TLabel;
    ShapeNote: TShape;
    ShapeNote1: TShape;
    tsCross: TcxTabSheet;
    Panel4: TPanel;
    btnIns: TBitBtn;
    btnDel: TBitBtn;
    Panel2: TPanel;
    bbAddCross: TBitBtn;
    bbDelCross: TBitBtn;
    lbCross: TListBox;
    aRefreshCross: TAction;
    tsPhoto: TcxTabSheet;
    pn1: TPanel;
    btnInsPic: TBitBtn;
    btnDelPic: TBitBtn;
    dlgOpenPic: TOpenPictureDialog;
    spReadPics: TpFIBDataSet;
    ds1: TDataSource;
    spUpdatePics: TpFIBStoredProc;
    pn2: TPanel;
    img1: TImage;
    lbPhotoNum: TLabel;
    sbPrev: TSpeedButton;
    sbNext: TSpeedButton;
    tsSostav: TcxTabSheet;
    pn3: TPanel;
    btnInsKit: TBitBtn;
    btnDelKit: TBitBtn;
    btnUpdKit: TBitBtn;
    aInsKit: TAction;
    aUpdKit: TAction;
    aDelKit: TAction;
    pn4: TPanel;
    lbUsual: TLabel;
    lbSostav: TLabel;
    lbProduct: TLabel;
    spReadKit: TpFIBDataSet;
    dsReadKit: TDataSource;
    tsMisc: TcxTabSheet;
    Label10: TLabel;
    Shape19: TShape;
    Shape20: TShape;
    lb1: TLabel;
    sh1: TShape;
    sh2: TShape;
    lb2: TLabel;
    sh3: TShape;
    sh4: TShape;
    Label8: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    leCategory: TcxLookupComboBox;
    edName: TcxTextEdit;
    edArticul: TcxTextEdit;
    edNomenclatur: TcxTextEdit;
    edBarcode: TcxTextEdit;
    leGUnit: TcxLookupComboBox;
    edPrice: TcxCurrencyEdit;
    edVolPrice: TcxCurrencyEdit;
    mNote: TcxMemo;
    edMinAmount: TcxCurrencyEdit;
    edPackAmount: TcxCurrencyEdit;
    edMFCountry: TcxTextEdit;
    edPlace: TcxTextEdit;
    grBarcode: TcxGrid;
    tvBarcode: TcxGridDBTableView;
    lvMain: TcxGridLevel;
    grSostav: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    clmMainBARCODE: TcxGridDBColumn;
    clmGridDBTableView1AMOUNT: TcxGridDBColumn;
    clmGridDBTableView1PRICE: TcxGridDBColumn;
    clmGridDBTableView1NAME: TcxGridDBColumn;
    pmBarcode: TPopupMenu;
    NUsualBarcode: TMenuItem;
    NScaleBarcode: TMenuItem;
    cbTovar: TcxComboBox;
    Label9: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    edSalesComm: TcxCurrencyEdit;
    Label11: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    edTnved: TcxTextEdit;
    Label12: TLabel;
    Shape23: TShape;
    Shape24: TShape;
    cbFastTovar: TcxCheckBox;
    Label14: TLabel;
    Shape27: TShape;
    Shape28: TShape;
    cbDoNotChargeBonus: TcxCheckBox;
    lbLastPrice: TLabel;
    shpLastPrice: TShape;
    shpLastPrice1: TShape;
    edLastPrice: TcxCurrencyEdit;
    Label16: TLabel;
    TimerChangeEd: TTimer;
    btnInsUnit: TSpeedButton;
    aInsUnit: TAction;
    Label15: TLabel;
    Shape29: TShape;
    Shape30: TShape;
    cbIsMarked: TcxCheckBox;
    Label18: TLabel;
    Shape33: TShape;
    Shape34: TShape;
    edBrand: TcxTextEdit;
    Shape31: TShape;
    Label17: TLabel;
    Shape32: TShape;
    cbTovarVes: TcxCheckBox;
    Shape35: TShape;
    lbVesGramm: TLabel;
    shpVesGramm: TShape;
    lbVesGrammPrice: TLabel;
    shpVesGrammPrice: TShape;
    shpVesGramm1: TShape;
    edVesGramm: TcxCurrencyEdit;
    shpVesGrammPrice1: TShape;
    edVesGrammPrice: TcxCurrencyEdit;
    shpKaspi1: TShape;
    lblKaspi: TLabel;
    shpKaspi2: TShape;
    cbKaspiShop: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rb13Click(Sender: TObject);
    procedure rb8Click(Sender: TObject);
    procedure aClearBarcodeExecute(Sender: TObject);
    procedure aGenArticulExecute(Sender: TObject);
    procedure aClearArticulExecute(Sender: TObject);
    procedure edNameKeyPress(Sender: TObject; var Key: Char);
    procedure aRefreshBarcodeExecute(Sender: TObject);
    procedure cxPageControlChange(Sender: TObject);
    procedure btnInsClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure aInsCategoryExecute(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure bbAddCrossClick(Sender: TObject);
    procedure bbDelCrossClick(Sender: TObject);
    procedure aRefreshCrossExecute(Sender: TObject);
    procedure btnInsPicClick(Sender: TObject);
    procedure btnDelPicClick(Sender: TObject);
    procedure sbPrevClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure aInsKitExecute(Sender: TObject);
    procedure aUpdKitExecute(Sender: TObject);
    procedure aDelKitExecute(Sender: TObject);
    procedure cbTovar1Change(Sender: TObject);
    procedure cbTovar1Click(Sender: TObject);
    procedure edMFCountryKeyPress(Sender: TObject; var Key: Char);
    procedure edPriceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edVolPriceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGenBarcodeClick(Sender: TObject);
    procedure NUsualBarcodeClick(Sender: TObject);
    procedure NScaleBarcodeClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edPricePropertiesChange(Sender: TObject);
    procedure TimerChangeEdTimer(Sender: TObject);
    procedure edVolPricePropertiesChange(Sender: TObject);
    procedure aInsUnitExecute(Sender: TObject);
    procedure cbIsMarkedPropertiesChange(Sender: TObject);
    procedure edVesGrammPropertiesChange(Sender: TObject);
  private
    FId_Category: Int64;
    FG_PROD_FOR_NEW_PRICE : INT64;  // ФОРМА вызвана для создания старого товара с новой ценой, ПЕРЕДАЕТСЯ ID СТАРОГО ТОВАРА
    FBARCODE  : STRING;  //штрихкод, который будет посдавляться автоматом из PriceList, если форма вызвана при помощи сканера штрихкода
    FBARCODE8 : STRING;
    FBARCODE13 : STRING;
    FIsGetDataNow : Boolean;  //флаг, что сейчас происходит GetData
    FProductType : Integer;
    FOldRec : TTovarRec;
    FNewRec : TTovarRec;
    FBarcodeModified : boolean;
    FKitModified : boolean;
    FSPOld : TdxMemData;
    function FillLog : string;
    procedure RecalcPriceKit(real_amount : Double);
    function MarkedSostavCheck(mode : integer) : boolean;
  public
    property Id_Category: Int64 read FId_Category write FId_Category;
    property BARCODE: String read FBARCODE write FBARCODE;
    property G_PROD_FOR_NEW_PRICE : Int64 read FG_PROD_FOR_NEW_PRICE write FG_PROD_FOR_NEW_PRICE;  // ФОРМА вызвана для создания старого товара с новой ценой, ПЕРЕДАЕТСЯ ID СТАРОГО ТОВАРА
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
  protected
    procedure GetData; override;
    procedure ReadPictureList(ShowLast : Boolean);
    procedure ShowPicture;
    procedure ExecQuery;
    procedure ReadSostav;
    procedure GetBarcode(Mode : Integer);

    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  PriceListUnForm: TPriceListUnForm;

implementation

uses unCommonFunc, frmCategory, PriceListUnSostav, frmGUnit;

{$R *.dfm}

procedure TPriceListUnForm.FormShow(Sender: TObject);
begin
  inherited;
  cxPageControl.ActivePage := tsCommon;
  if Config <> 3 then
    cbTovar.Properties.Items.Delete(2);

  if Config <> 4 then begin
    lbVesGramm.Visible := False;
    shpVesGramm.Visible := False;
    lbVesGrammPrice.Visible := False;
    shpVesGrammPrice.Visible := False;
    shpVesGramm1.Visible := False;
    edVesGramm.Visible := False;
    shpVesGrammPrice1.Visible := False;
    edVesGrammPrice.Visible := False;

    ClientHeight := ScaleDimension(451);
  end;

  OpenSp(spProductCategory, False);
  OpenSp(spGUnit, False);
  leGUnit.EditValue := 1;

  // 12.04.2017 - потеряло актуальность, решил всегда пусть отражается
  // если конфигурация аптека, то отражаю спец поля
  {if Config = 1 then
    Height := ScaleDimension(432);
  else begin
    Height := ScaleDimension(370);
    edPackAmount.Enabled := False;
    edMFCountry.Enabled := False;
    edMFCountry.Visible := False;}

  if Config = 2 then
    tsCross.TabVisible := True;

  if BarcodeLength = 0 then
    rb13.Checked := True
  else if BarcodeLength = 1 then
    rb8.Checked := True;

  if OpenMode = omView then begin
    btnInsPic.Enabled := False;
    btnIns.Enabled := False; 
  end;

  lbProduct.Width := ScaleDimension(550);
  lbSostav.Width := ScaleDimension(550);
  lbUsual.Width := ScaleDimension(550);

  if HaveRightToSeeCostPrice = false then begin
    lbLastPrice.Visible := False;
    shpLastPrice.Visible := False;
    shpLastPrice1.Visible := False;
    edLastPrice.Visible := False;
  end;

  if CurrencyVal = 0 then
  begin
    lblKaspi.Visible := True;
    shpKaspi1.Visible := True;
    shpKaspi2.Visible := True;
    cbKaspiShop.Visible := True;
  end
  else
  begin
    lblKaspi.Visible := False;
    shpKaspi1.Visible := False;
    shpKaspi2.Visible := False;
    cbKaspiShop.Visible := False;
  end;

  edName.SetFocus;
end;

function TPriceListUnForm.CheckParams(var ErrControl: TWinControl): Boolean;
var str : string;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(leCategory.Text) = EmptyStr then begin
    cxPageControl.ActivePage := tsCommon;
    ErrControl := leCategory;
    MessageDlg('Категория товара не выбрана', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(edName.Text) = EmptyStr then begin
    cxPageControl.ActivePage := tsCommon;
    ErrControl := edName;
    MessageDlg('Наименование не введено', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(leGUnit.Text) = EmptyStr then begin
    cxPageControl.ActivePage := tsCommon;
    ErrControl := leGUnit;
    MessageDlg('Ед. измерения не введена', mtInformation, [mbOK], 0);
    Exit;
  end;

  // Нельзя изменить составной товар на готовый продукт и обратно, надо создавать новый
  if (FProductType <> 0) and (FProductType <> cbTovar.ItemIndex) then begin
    cxPageControl.ActivePage := tsSostav;
    ErrControl := cbTovar;
    if FProductType = 1 then
      str := '"Составной товар"'
    else
      str := '"Готовый продукт"';

    MessageDlg('Нельзя изменить вид товара с ' + str + ' на "' + cbTovar.Text + '"! Если хотите изменить вид товара, ' +
      'то создайте новый товар, а данный товар удалите!', mtWarning, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TPriceListUnForm.GetBarcode(Mode: Integer);
begin
  if rb13.Checked then begin
    if UseScales = 1 then
      spGetBarcode.ParamByName('prefix_').AsString := ScalesPrefix
    else
      spGetBarcode.ParamByName('prefix_').AsString := '';   // иначе переменная закэшируется

    if Mode = 2 then
      spGetBarcode.ParamByName('MODE_').AsInteger := 131
    else
      spGetBarcode.ParamByName('MODE_').AsInteger := 13;
  end else
    spGetBarcode.ParamByName('MODE_').AsInteger := 8;

  ExecSp(spGetBarcode);
  edBarcode.Text := spGetBarcode.ParamByName('Barcode_').AsString;
  edBarcode.ModifiedAfterEnter := True;

  if rb13.Checked then
    FBARCODE13 := edBarcode.Text
  else
    FBARCODE8 := edBarcode.Text;
end;

procedure TPriceListUnForm.GetData;
var cross : string;
    i, j : integer;

const
  URL: string = 'https://barcode-list.ru/barcode/RU/%D0%9F%D0%BE%D0%B8%D1%81%D0%BA.htm?barcode=';
var
  s: string;
  IdHTTP1: TIdHTTP;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  k: Integer;
begin
  try
    FIsGetDataNow := true;
    if OpenMode = omInsertLike then
      spGetData.ParamByName('MODE_').AsInteger := 1;

    inherited;
    if OpenMode in [omView, omUpdate, omInsertLike] then begin
      with spGetData do begin
        leCategory.EditValue := ParamByName('G_PRODUCT_PAR_').AsInt64;
        edName.Text    := ParamByName('NAME_').AsString;
        edArticul.Text    := ParamByName('ARTICUL_').AsString;
        edNomenclatur.Text    := ParamByName('NOMENCLATUR_NUM_').AsString;
        edBarcode.Text    := ParamByName('BARCODE_').AsString;
        if ((Length(edBarcode.Text) = 13) and (edBarcode.Text <> '')) then begin
          FBARCODE13 := edBarcode.Text;
          rb13.Checked := True;
        end else if ((Length(edBarcode.Text) = 8) and (edBarcode.Text <> '')) then begin
          FBARCODE8 := edBarcode.Text;
          rb8.Checked := True;
        end;

        leGUnit.EditValue := ParamByName('G_UNIT_').AsInt64;
        edLastPrice.Value    := ParamByName('LAST_PRICE_').AsFloat;
        edPrice.Value    := ParamByName('PRICE_').AsFloat;
        edVolPrice.Value    := ParamByName('VOLUME_PRICE_').AsFloat;
        mNote.Text := ParamByName('NOTE_').AsString;
        edMinAmount.Value := ParamByName('MIN_AMOUNT_').AsFloat;
        edPlace.Text := ParamByName('PLACE_').AsString;
        cbIsMarked.Checked := ParamByName('is_marked_').AsInteger = 1;
        cbTovarVes.Checked := ParamByName('IS_WEIGHT_').AsInteger = 1;

        edVesGramm.Value    := ParamByName('VES_GRAMM_').AsFloat;
        edVesGrammPrice.Value    := ParamByName('VES_GRAMM_PRICE_').AsFloat;
        cbKaspiShop.Checked := ParamByName('IS_KASPI_SHOP_').AsInteger = 1;

        //если вдруг товар был производственным продуктом, а потом в настройках производство выключили, то надо ставить поле cbTovar пустым, но комплектующие при этом отражать
        if (ParamByName('is_kit_').AsInteger > 1) and (Config <> 3) then begin
          cbTovar.ItemIndex := -1;
          ReadSostav;
        end else begin
          FProductType := ParamByName('is_kit_').AsInteger;
          cbTovar.ItemIndex := FProductType;
        end;
        //edPrice.Properties.ReadOnly := cbTovar.ItemIndex = 1;
        //edVolPrice.Properties.ReadOnly := cbTovar.ItemIndex = 1;
        edSalesComm.Value := ParamByName('SALES_COMM_').AsFloat;
        edTnved.Text := ParamByName('KOD_TNVD_').AsString;
        cbFastTovar.Checked := ParamByName('FAST_TOVAR_').AsInteger = 1;
        cbDoNotChargeBonus.Checked := ParamByName('DO_NOT_CHARGE_BONUS_').AsInteger = 1;

        edPackAmount.Value := ParamByName('PACK_AMOUNT_').AsFloat;
        edMFCountry.Text   := ParamByName('MF_COUNTRY_').AsString;
        edBrand.Text   := ParamByName('Brand_').AsString;

        //если конфигурация Автозапчасти, то проверяю кроссы, если заполнены, то заполняю массивы
        if Config = 2 then begin
          cross := ParamByName('CROSSCODE_').AsSTRING;
          j := 0;
          while (Length(cross) > 0) do begin
            I := pos('~', cross);
            lbCross.Items.Add(Copy(cross, 1, i-1));

            SetLength(FOldRec.Crosscode, High(FOldRec.Crosscode)+2);
            FOldRec.Crosscode[j] := Copy(cross, 1, i-1);
            j := j+1;

            delete(cross, 1, i);
          end;
          aRefreshCross.Execute;
        end;

        FOldRec.Category     := ParamByName('G_PRODUCT_PAR_').AsInt64;
        FOldRec.CategoryName := leCategory.Text;
        FOldRec.Name        := ParamByName('NAME_').AsString;
        FOldRec.Articul     := ParamByName('ARTICUL_').AsString;
        FOldRec.Nomenclatur := ParamByName('NOMENCLATUR_NUM_').AsString;
        FOldRec.Barcode     := ParamByName('BARCODE_').AsString;
        FOldRec.GUnit       := ParamByName('G_UNIT_').AsInt64;
        FOldRec.GUnitName   := leGUnit.Text;
        FOldRec.Price   := ParamByName('PRICE_').AsFloat;
        FOldRec.PriceOpt   := ParamByName('VOLUME_PRICE_').AsFloat;
        FOldRec.Note   := ParamByName('NOTE_').AsString;
        FOldRec.Minamount   := ParamByName('MIN_AMOUNT_').AsFloat;
        FOldRec.Place   := ParamByName('PLACE_').AsString;
        FOldRec.Ismarked   := ParamByName('is_marked_').AsInteger;
        FOldRec.IsTovarVes := ParamByName('IS_WEIGHT_').AsInteger;
        FOldRec.IsKit := ParamByName('is_kit_').AsInteger;

        FOldRec.SalesComm := ParamByName('SALES_COMM_').AsFloat;
        FOldRec.Kodtnvd   := ParamByName('KOD_TNVD_').AsString;
        FOldRec.FastTovar := ParamByName('FAST_TOVAR_').AsInteger;
        FOldRec.DoNotChargeBonus := ParamByName('DO_NOT_CHARGE_BONUS_').AsInteger;

        FOldRec.PackAmount := ParamByName('PACK_AMOUNT_').AsFloat;
        FOldRec.Mfcountry  := ParamByName('MF_COUNTRY_').AsString;
        FOldRec.Brand  := ParamByName('Brand_').AsString;
      end;
    end;
    if OpenMode = omInsert then
      leCategory.EditValue := FId_Category;

    if OpenMode in [omInsert, omInsertLike] then
    begin
      aGenArticul.Execute;
      if FBARCODE <> '' then
      begin
        edBarcode.Text := FBARCODE;
        if FindShtrikh then
        begin
          try
            Screen.Cursor := crHourGlass;
            if edName.Text = EmptyStr then
            begin
              try
                try
                  IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
                  with IdSSLIOHandlerSocketOpenSSL1 do
                  begin
                    SSLOptions.Method := sslvTLSv1;
                    SSLOptions.SSLVersions := [sslvTLSv1_2];
                    SSLOptions.Mode := sslmClient;
                    SSLOptions.VerifyMode := [];
                    SSLOptions.VerifyDepth := 0;
                  end;
                except
                  on E: Exception do
                    MessageDlg(e.Message, mtError, [mbOK], 0);
                end;
                try
                  IdHTTP1 := TIdHTTP.Create(nil);
                  with IdHTTP1 do
                  begin
                    IOHandler := IdSSLIOHandlerSocketOpenSSL1;
                    AllowCookies := True;
                    HandleRedirects := true;
                    ProxyParams.BasicAuthentication := false;
                    ProxyParams.ProxyPort := 0;
                    Request.CharSet := 'utf-8';
                    Request.ContentType := 'text/html';
                    Request.ContentEncoding := 'gzip';
                    Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
                    Request.BasicAuthentication := False;
                    Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
                    Request.Ranges.Units := 'bytes';
                    HTTPOptions := [];
                    IOHandler.DefStringEncoding := enUTF8;
                  end;
                except
                  on E: Exception do
                    MessageDlg(e.Message, mtError, [mbOK], 0);
                end;
                try
                  s := IdHTTP1.Get(URL + FBARCODE);
                except
                  on E: Exception do
                    MessageDlg(e.Message, mtError, [mbOK], 0);
                end;
                try
                  try
                    k := Pos('Этот штрих-код встречается в следующих товарах:', s);
                    if k > 0 then
                    begin
                      s := Copy(s, k, Length(s) -k);
                      s := StringReplace(s, 'Этот штрих-код встречается в следующих товарах:', '', [rfReplaceAll]);
                      s := Trim(s);
                      for i := 0 to Length(s) -1 do
                      begin
                        if (s[i] = ';') or (s[i] = '>') or (s[i] = '<') or (s[i] = '&') then
                        begin
                          s := Copy(s, 1, i -1);
                          Break;
                        end;
                      end;
                      s := StringReplace(s, '"', '', [rfReplaceAll]);
                      s := StringReplace(s, '  ', ' ', [rfReplaceAll]);
                      edName.Text := Trim(s);
                    end;
                  except
                    on e: Exception do
                      MessageDlg(e.Message, mtError, [mbOK], 0);
                  end;
                except
                  on e: Exception do
                    MessageDlg(e.Message, mtError, [mbOK], 0);
                end;
              finally
                FreeAndNil(IdHTTP1);
                FreeAndNil(IdSSLIOHandlerSocketOpenSSL1);
              end;
            end;
          finally
            Screen.Cursor := crDefault;
          end;
        end;
      end
      else
        GetBarcode(1);
    end;
    //если "Добавить копию" то удаляю доп. штрихкода
    if OpenMode = omInsertLike then begin
      ExecSPTR(spDelBarcode);
      aRefreshBarcode.Execute;
    end;
  finally
    FIsGetDataNow := False;
  end;
end;

procedure TPriceListUnForm.NScaleBarcodeClick(Sender: TObject);
begin
  // Ставлю автоматом на EAN-13
  rb13.Checked := True;

  GetBarcode(2);   // весовой штрихкод
end;

procedure TPriceListUnForm.NUsualBarcodeClick(Sender: TObject);
begin
  GetBarcode(1);   // обычный штрихкод
end;

procedure TPriceListUnForm.SetParams(SP: TpFIBStoredProc);
var cross : string;
    i : integer;
begin
  inherited;

  // иногда бывает, что пользователь пропикивает штрихкод в поле Цена, и потом программа валится.
  // буду тут проверять, если поле цена больше 10 символов, то нафиг обрезать, что за цены такие
  if Length(FloatToStr(edPrice.Value)) > 10 then begin
    edPrice.Value := StrToFloat(Copy(FloatToStr(edPrice.Value), 1, 10));
    FNewRec.Price := edPrice.Value;
  end;

  if Length(FloatToStr(edVolPrice.Value)) > 10 then begin
    edVolPrice.Value := StrToFloat(Copy(FloatToStr(edVolPrice.Value), 1, 10));
    FNewRec.PriceOpt := edVolPrice.Value;
  end;

  with SP do begin
    ParamByName('G_PRODUCT_PAR_').AsInt64 := leCategory.EditValue;
    FNewRec.Category := leCategory.EditValue;
    FNewRec.CategoryName := leCategory.Text;

    ParamByName('ARTICUL_').AsString  := trim(edArticul.Text);
    FNewRec.Articul := trim(edArticul.Text);

    ParamByName('NOMENCLATUR_NUM_').AsString := edNomenclatur.Text;
    FNewRec.Nomenclatur := edNomenclatur.Text;

    ParamByName('BARCODE_').AsString  := edBarcode.Text;
    FNewRec.Barcode := edBarcode.Text;

    edName.Text := StringReplace(StringReplace(edName.Text, '''', '', [rfReplaceAll]), #9, ' ', [rfReplaceAll]);
    edName.Text := StringReplace(StringReplace(edName.Text, '"', '', [rfReplaceAll]), ';', '', [rfReplaceAll]);
    ParamByName('NAME_').AsString  := edName.Text;
    FNewRec.Name := edName.Text;

    ParamByName('G_UNIT_').AsInt64 := leGUnit.EditValue;
    FNewRec.GUnit := leGUnit.EditValue;
    FNewRec.GUnitName := leGUnit.Text;

    ParamByName('PRICE_').AsFloat := edPrice.Value;
    FNewRec.Price := edPrice.Value;

    ParamByName('VOLUME_PRICE_').AsFloat := edVolPrice.Value;
    FNewRec.PriceOpt := edVolPrice.Value;

    ParamByName('VES_GRAMM_').AsFloat := edVesGramm.Value;
    ParamByName('VES_GRAMM_PRICE_').AsFloat := edVesGrammPrice.Value;

    IF FG_PROD_FOR_NEW_PRICE > 0 THEN
      ParamByName('G_PRODUCT_NEW_PRICE_').AsFloat := FG_PROD_FOR_NEW_PRICE;
    ParamByName('IS_CATEGORY_').AsInteger := 0;

    ParamByName('MIN_AMOUNT_').AsFloat := edMinAmount.Value;
    FNewRec.MinAmount := edMinAmount.Value;

    ParamByName('PLACE_').AsString  := edPlace.Text;
    FNewRec.Place := edPlace.Text;

    ParamByName('NOTE_').AsString := mNote.Text;
    FNewRec.Note := mNote.Text;

    if spReadKit.RecordCount = 0 then
      ParamByName('is_kit_').AsInteger := 0
    else
      ParamByName('is_kit_').AsInteger := cbTovar.ItemIndex;
    FNewRec.IsKit := ParamByName('is_kit_').AsInteger;

    ParamByName('PACK_AMOUNT_').AsFloat := edPackAmount.Value;
    FNewRec.PackAmount := edPackAmount.Value;
    ParamByName('MF_COUNTRY_').AsString := edMFCountry.Text;
    FNewRec.MfCountry := edMFCountry.Text;

    ParamByName('Brand_').AsString := edBrand.Text;
    FNewRec.Brand := edBrand.Text;

    //если конфигурация Автозапчасти, то проверяю кроссы, если заполнены, то заполняю массивы
    if Config = 2 then
      if lbCross.Items.Count > 0 then begin
        for i := 0 to lbCross.Items.Count - 1 do begin
          cross := cross + lbCross.Items[i] + '~';

          SetLength(FNewRec.Crosscode, High(FNewRec.Crosscode) + 2);
          FNewRec.Crosscode[i] := lbCross.Items[i];
        end;
        ParamByName('CROSSCODE_').AsString := cross;
      end;

    ParamByName('SALES_COMM_').AsFloat := edSalesComm.Value;
    FNewRec.SalesComm := edSalesComm.Value;

    ParamByName('KOD_TNVD_').AsString := edTnved.Text;
    FNewRec.KodTnvd := edTnved.Text;

    ParamByName('FAST_TOVAR_').AsInteger := Integer(cbFastTovar.Checked);
    FNewRec.FastTovar := Integer(cbFastTovar.Checked);

    ParamByName('is_marked_').AsInteger := Integer(cbIsMarked.Checked);
    FNewRec.IsMarked := Integer(cbIsMarked.Checked);

    ParamByName('IS_WEIGHT_').AsInteger := Integer(cbTovarVes.Checked);
    FNewRec.IsTovarVes := Integer(cbTovarVes.Checked);

    ParamByName('DO_NOT_CHARGE_BONUS_').AsInteger := Integer(cbDoNotChargeBonus.Checked);
    FNewRec.DoNotChargeBonus := Integer(cbDoNotChargeBonus.Checked);

    ParamByName('USER_ID_').AsInt64 := CurrentOfficial;
    ParamByName('LOG_BODY_').AsString := FillLog;
	
	  ParamByName('UPLOAD_TO_EXT_APP_').AsInteger := Integer(UploadToMobile);

    ParamByName('IS_KASPI_SHOP_').AsInteger := Integer(cbKaspiShop.Checked);
  end;
end;

function TPriceListUnForm.FillLog: string;
var I : integer;
  SPNew : TdxMemData;
begin

  // допштрихкода
  if FBarcodeModified then begin
    spBarcode.First;
    i := 0;
    while not spBarcode.eof do begin
      SetLength(FNewRec.DopBarcode, High(FNewRec.DopBarcode) + 2);
      FNewRec.DopBarcode[i] := spBarcode.FieldByName('BARCODE').AsString;
      spBarcode.Next;
      i := i + 1;
    end;
  end
  else
    FNewRec.DopBarcode := FOldRec.DopBarcode;

  try
    // составные части
    SPNew := nil;
    if FKitModified then begin
      SPNew := TdxMemData.Create(nil);
      SPNew.CopyFromDataSet(spReadKit);
    end;

    Result := FillLogTovar(Integer(OpenMode), FOldRec, FNewRec, FSPOld, SPNew);
  finally
    if (FKitModified) and (Assigned(SPNew)) then
      SPNew.Free;
  end;
end;

procedure TPriceListUnForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if CanClose then begin
    ExecSPTR(spDelBarcode);   // очищаю временную таблицу
    spUpdatePics.SQL.Text := 'DELETE FROM G_PRODUCT_IMAGE_TMP';
    ExecQuery;

    spUpdatePics.SQL.Text := 'DELETE FROM G_PRODUCT_KIT_TMP';
    ExecQuery;
  end;
end;

procedure TPriceListUnForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyField   := 'g_product_';
  FBARCODE8  := '';
  FBARCODE13 := '';
end;

procedure TPriceListUnForm.rb13Click(Sender: TObject);
begin
  edBarcode.Text := FBARCODE13;

  {if edBarcode.Text = '' then
    if FBARCODE13 = '' then
      aGenBarcode.Execute;}
end;

procedure TPriceListUnForm.rb8Click(Sender: TObject);
begin
  edBarcode.Text := FBARCODE8;

  if edBarcode.Text = '' then
    if FBARCODE8 = '' then
      aGenBarcode.Execute;
end;

procedure TPriceListUnForm.aClearBarcodeExecute(Sender: TObject);
begin
  edBarcode.Clear;
end;

procedure TPriceListUnForm.aGenArticulExecute(Sender: TObject);
begin
  ExecSp(spGetArticul);
  edArticul.Text := spGetArticul.ParamByName('ARTICUL_').AsString;
  edArticul.ModifiedAfterEnter := True;
end;

procedure TPriceListUnForm.aClearArticulExecute(Sender: TObject);
begin
  edArticul.Clear;
end;

procedure TPriceListUnForm.edNameKeyPress(Sender: TObject; var Key: Char);
Var S : String;
begin
  if (edName.SelStart = 0) then begin
    S := AnsiUpperCase(Key);
    Key := S[1];
  end;

  if (Key in ['''', '"', '`', #9, ';', ',']) Then
    Key := #0;
end;

procedure TPriceListUnForm.aRefreshBarcodeExecute(Sender: TObject);
begin
  OpenSP(spBarcode, true);
  btnDel.Enabled := spBarcode.RecordCount > 0;
end;

procedure TPriceListUnForm.cxPageControlChange(Sender: TObject);
var i : integer;
begin
  if (cxPageControl.ActivePage = tsBarcode) and (spBarcode.Active = False) then begin
    aRefreshBarcode.Execute;
    spBarcode.First;
    i := 0;
    while not spBarcode.eof do begin
      SetLength(FOldRec.DopBarcode, High(FOldRec.DopBarcode) + 2);
      FOldRec.DopBarcode[i] := spBarcode.FieldByName('BARCODE').AsString;
      spBarcode.Next;
      i := i + 1;
    end;
    spBarcode.First;

  end else if (cxPageControl.ActivePage = tsPhoto) and (spReadPics.Active = False) then begin
    ReadPictureList(False);
    if spReadPics.RecordCount > 0 then
      ShowPicture;
  end else if (cxPageControl.ActivePage = tsSostav) {and (spReadKit.Active = False)} then begin
    ReadSostav;

    if not Assigned(FSPOld) then begin
      FSPOld := TdxMemData.Create(nil);
      FSPOld.CopyFromDataSet(spReadKit);
    end;
  end;
end;

procedure TPriceListUnForm.btnInsClick(Sender: TObject);
var Barcode : String;
begin
  if rb13.Checked then
    spGetBarcode.ParamByName('MODE_').AsInteger := 13
  else
    spGetBarcode.ParamByName('MODE_').AsInteger := 8;

  ExecSp(spGetBarcode);
  Barcode := spGetBarcode.ParamByName('Barcode_').AsString;

  if InputQuery( 'Новый штрихкод', 'Нажмите ОК или введите свой штрихкод', Barcode) then begin
    if length(Barcode) > 30 then begin
      MessageDlg('Штрихкод не может быть больше 30 символов!', mtInformation, [mbOk], 0);
      Exit;
    end;

    spInsBarcode.ParamByName('BARCODE_').AsString := Barcode;
    if ExecSPTR(spInsBarcode) then begin
      aRefreshBarcode.Execute;
      spBarcode.locate('lt_barcode', spInsBarcode.ParamByName('lt_barcode_').AsInt64, []);
      if tvBarcode.Controller.FocusedRow <> Nil then begin
        if tvBarcode.Controller.SelectedRowCount > 0 then
          tvBarcode.Controller.SelectedRows[0].Selected := False;
        tvBarcode.Controller.FocusedRow.Selected := True;
      end;

      edBarcode.ModifiedAfterEnter := True;
      FBarcodeModified := true;
    end;
  end;
end;

procedure TPriceListUnForm.btnDelClick(Sender: TObject);
begin
  spDelBarcode.ParamByName('LT_BARCODE_').AsInt64 := spBarcode.FieldByName('lt_barcode').AsLargeInt;
  if ExecSPTR(spDelBarcode) then begin
    aRefreshBarcode.Execute;
    edBarcode.ModifiedAfterEnter := True;
    FBarcodeModified := True;
  end;
  spDelBarcode.ParamByName('LT_BARCODE_').Clear;
end;

procedure TPriceListUnForm.aInsCategoryExecute(Sender: TObject);
begin
  CategoryForm := TCategoryForm.Create(Self);
  CategoryForm.OpenMode := omInsert;
  CategoryForm.edName.TabOrder := 0;
  try
    if CategoryForm.Showmodal = mrOk then begin
      OpenSp(spProductCategory, False);
      leCategory.EditValue := CategoryForm.RecId;
    end;
  finally
    CategoryForm.free;
  end;
end;

procedure TPriceListUnForm.btHelpClick(Sender: TObject);
begin
  Helpc := 53;
  inherited;
end;

procedure TPriceListUnForm.bbAddCrossClick(Sender: TObject);
var s : string;
begin
  if InputQuery('Введите кросс-код', '', s) then begin
    lbCross.Items.Add(Copy(s, 1, 30));// беру 30 символовs);
    aRefreshCross.Execute;
    edName.ModifiedAfterEnter := True;
  end;
end;

procedure TPriceListUnForm.bbDelCrossClick(Sender: TObject);
begin
  lbCross.Items.Delete(lbCross.ItemIndex);
  aRefreshCross.Execute;
  edName.ModifiedAfterEnter := True;
end;

procedure TPriceListUnForm.aRefreshCrossExecute(Sender: TObject);
begin
  bbDelCross.Enabled := lbCross.Items.Count > 0;
end;

procedure TPriceListUnForm.btnInsPicClick(Sender: TObject);
var
 Graphic  :TGraphic;
 FileExt : string;
 FileExtInt : integer;
 F : TFileStream;
begin
  if dlgOpenPic.Execute then begin
      edName.ModifiedAfterEnter := true;
      FileExt := UpperCase(ExtractFileExt(dlgOpenPic.FileName));
      if (FileExt <> '.JPEG') and (FileExt <> '.JPG') and (FileExt <> '.JPE') and
      (FileExt <> '.BMP') and (FileExt <> '.PNG') then begin
        MessageDlg('Формат поддерживаемых файлов - JPG/JPEG, BMP или PNG. Загрузка невозможна!', mtWarning, [mbOK], 0);
        Exit;
      end;

      try
        F := TFileStream.Create(dlgOpenPic.Filename, fmOpenRead);
        if F.Size > 600000 then begin
          if MessageDlg('Размер файла превышает 600 кб. Рекомендуется загружать файлы не более' + #10#13 +
          '600 килобайт во избежание большой нагрузки на базу и, как следствие, медленной работы базы данных.' + #10#13 +
          'Вы можете уменьшить размер файла в любом графическом редакторе.' + #10#13 +
          'Все равно продолжить?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
            Exit;
        end;

        if (FileExt = '.JPEG') or (FileExt = '.JPG') then BEGIN
          //Graphic := TJPEGImage.Create;
          FileExtInt := 1;
        END else
        if (FileExt = '.BMP') then BEGIN
          //Graphic := TBitmap.Create;
          FileExtInt := 3;
        END else
        if (FileExt = '.PNG') then BEGIN
          //Graphic := TPNGImage.Create;
          FileExtInt := 2;
        END else
        BEGIN  // по умолчанию поставлю JPG, а то вдруг никуда не попадет
          //Graphic := TJPEGImage.Create;
          FileExtInt := 1;
        END;

        //Graphic.LoadFromStream(F);

        spUpdatePics.SQL.Text := 'Insert into G_PRODUCT_IMAGE_TMP Values (GEN_ID(GEN_G_PRODUCT_IMAGE, 1), :G_product_, :BLOB, :type)';
        spUpdatePics.Params[0].Value := RecId;
        spUpdatePics.Params[1].LoadFromStream(F);
        spUpdatePics.Params[2].Value := FileExtInt;
        ExecQuery;

        ReadPictureList(True);
        if spReadPics.RecordCount > 0 then
          ShowPicture;
      finally
        F.Free;
      end;
  end;
end;

procedure TPriceListUnForm.ReadPictureList(ShowLast : Boolean);
begin
  OpenSp(spReadPics, False);
  if spReadPics.RecordCount > 0 then begin
    if ShowLast then
      spReadPics.Last;
  end else
    lbPhotoNum.Caption := 'Фото 0';
  btnDelPic.Enabled := (spReadPics.RecordCount > 0) and (OpenMode <> omView);
  sbNext.Enabled := spReadPics.RecordCount > 0;
  sbPrev.Enabled := spReadPics.RecordCount > 0;
end;

procedure TPriceListUnForm.ShowPicture;
var Graphic :TGraphic;
begin
  try
    case spReadPics.FieldByName('type').AsInteger of
         1: Graphic:=TJpegimage.Create;
         2: Graphic:=TPNGImage.Create;
         3: Graphic:=TBitmap.Create;
    else
      Graphic:=TJpegimage.Create;
    end;
    Graphic.Assign(spReadPics.FieldByName('body'));
    img1.Picture.Assign(Graphic);
    lbPhotoNum.Caption := 'Фото ' + IntToStr(spReadPics.RecNo) + ' из ' + IntToStr(spReadPics.RecordCount);
  finally
    Graphic.Free;
  end;
end;

procedure TPriceListUnForm.TimerChangeEdTimer(Sender: TObject);
begin
  TimerChangeEd.Enabled := False;
  // если данный товар составной и если он состоит из одного товара, то надо менять цену в составе
  // короче ситуация на примере пива
  // "Шымкент 1л" стоит 300
  // "Шымкент 1.5", который состоит из "Шымкент 1л", стоит не 450, а, к примеру 420, типа скачуха на 1.5л
  // тогда надо пересчитывать и менять цену за 1л в составе, чтобы при продаже правильно выставлялась эта цена
  if (spReadKit.RecordCount = 1) then begin
    spReadKit.First;
    if edPrice.Value <> (spReadKit.FieldByName('price').AsFloat * spReadKit.FieldByName('amount').AsFloat) then begin
      spUpdatePics.SQL.Text := 'UPDATE G_PRODUCT_KIT_TMP K SET K.AMOUNT = :AMOUNT_, K.PRICE = :PRICE_, K.PRICE1 = :PRICE1_ WHERE K.G_PRODUCT_ITEM = :G_PRODUCT_ITEM_';
      spUpdatePics.ParamByName('G_PRODUCT_ITEM_').AsInt64 := spReadKit.FieldByName('G_PRODUCT').AsLargeInt;
      spUpdatePics.ParamByName('PRICE_').AsFloat := Round(edPrice.Value / spReadKit.FieldByName('amount').AsFloat);
      ExecQuery;
      ReadSostav;
    end;
  end;
end;

procedure TPriceListUnForm.btnDelPicClick(Sender: TObject);
begin
  edName.ModifiedAfterEnter := true;
  spUpdatePics.SQL.Text := 'delete from G_PRODUCT_IMAGE_TMP where G_PRODUCT_IMAGE = :ID_';
  spUpdatePics.Params[0].Value := spReadPics.FieldByName('G_PRODUCT_IMAGE').AsLargeInt;
  ExecQuery;
  ReadPictureList(True);
  IF spReadPics.RecordCount > 0 THEN
    ShowPicture
  else
    img1.Picture := nil; 
end;


procedure TPriceListUnForm.btnGenBarcodeClick(Sender: TObject);
begin
  if UseScales = 1 then begin
    if cbTovarVes.Checked = False then
      pmBarcode.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    else
      GetBarcode(2);   // весовой штрихкод
  end else
    GetBarcode(1);   // обычный штрихкод
end;

procedure TPriceListUnForm.ExecQuery;
begin
  if not spUpdatePics.Transaction.InTransaction then
    spUpdatePics.Transaction.StartTransaction;
  spUpdatePics.ExecQuery;
  spUpdatePics.Transaction.Commit;
end;

procedure TPriceListUnForm.sbPrevClick(Sender: TObject);
begin
  spReadPics.Prior;
  ShowPicture;
end;

procedure TPriceListUnForm.sbNextClick(Sender: TObject);
begin
  spReadPics.Next;
  ShowPicture;
end;

procedure TPriceListUnForm.aInsKitExecute(Sender: TObject);
var PriceListUnSostavForm: TPriceListUnSostavForm;
  realAmount, realAmountForCalc : Double;
  res : Boolean;
begin
  PriceListUnSostavForm := TPriceListUnSostavForm.Create(Self);
  with PriceListUnSostavForm do begin
    try
      Typ := cbTovar.ItemIndex;
      if OpenMode = omUpdate then
        ExceptId := RecId;
      if ShowModal = mrOk then begin
        //дабы пользователь, например в случае с пивным магазином, не рассчитывал вручную какое количество
        //указать, к примеру в одной кружке пива 1л от кеги в 50л, это будет 0.02, так вот, чтобы юзер это сам не
        //рассчитывал, я буду рассчитывать из поля "Количество в упаковке" ТОВАРА "Кега 50л", при условии,
        //что это поле не равно 0
        if spRead.FieldByName('pack_amount').AsFloat > 0 then begin
          realAmount := StrToFloat(MyCurrencyFrameForm.edAmount.Text) / spRead.FieldByName('pack_amount').AsFloat;
          realAmountForCalc := StrToFloat(MyCurrencyFrameForm.edAmount.Text);
        end
        else begin
          realAmount := StrToFloat(MyCurrencyFrameForm.edAmount.Text);
          realAmountForCalc := realAmount;
        end;

        res := spReadKit.Locate('g_product', spRead.FieldByName('g_product').AsLargeInt, []);

        if (res) and (spReadKit.FieldByName('price').AsFloat = edPrice.Value) then begin
          spUpdatePics.SQL.Text := 'UPDATE G_PRODUCT_KIT_TMP K SET K.AMOUNT = K.AMOUNT + :AMOUNT_, K.PRICE = :PRICE_, K.PRICE1 = :PRICE1_ WHERE K.G_PRODUCT_ITEM = :G_PRODUCT_ITEM_';
          spUpdatePics.ParamByName('G_PRODUCT_ITEM_').AsInt64 := spRead.FieldByName('g_product').AsLargeInt;
          spUpdatePics.ParamByName('AMOUNT_').AsFloat := realAmount;// + spUpdatePics.ParamByName('AMOUNT_').AsFloat;
          spUpdatePics.ParamByName('PRICE_').AsFloat := edPrice.Value;
          spUpdatePics.ParamByName('PRICE1_').AsFloat := edPriceVol.Value;
        end else begin
          spUpdatePics.SQL.Text := 'INSERT INTO G_PRODUCT_KIT_TMP (G_PRODUCT_KIT, G_PRODUCT, G_PRODUCT_ITEM, AMOUNT, PRICE, PRICE1, PRICE2, PRICE3) VALUES (GEN_ID(GEN_G_PRODUCT_KIT, 1), :G_PRODUCT_, :G_PRODUCT_ITEM_, :AMOUNT_, :PRICE_, :PRICE1_, 0, 0)';
          spUpdatePics.ParamByName('G_PRODUCT_').AsInt64 := RecID;
          spUpdatePics.ParamByName('G_PRODUCT_ITEM_').AsInt64 := spRead.FieldByName('g_product').AsLargeInt;
          spUpdatePics.ParamByName('AMOUNT_').AsFloat := realAmount;
          spUpdatePics.ParamByName('PRICE_').AsFloat := edPrice.Value;
          spUpdatePics.ParamByName('PRICE1_').AsFloat := edPriceVol.Value;
        end;
        ExecQuery;

        ReadSostav;
        RecalcPriceKit(realAmountForCalc);

        edName.ModifiedAfterEnter := true;
        FKitModified := true;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TPriceListUnForm.aInsUnitExecute(Sender: TObject);
var
  GUnitForm: TGUnitForm;
begin
  GUnitForm := TGUnitForm.Create(Self);
  try
    GUnitForm.OpenMode := omInsert;
    if GUnitForm.ShowModal = mrOk then begin
      OpenSp(spGUnit, false);
      leGUnit.EditValue := GUnitForm.RecID;
      leGUnit.SetFocus;
    end;
  finally
    GUnitForm.Free;
  end;
end;

procedure TPriceListUnForm.aUpdKitExecute(Sender: TObject);
var PriceListUnSostavForm: TPriceListUnSostavForm;
  realAmount, realAmountForCalc : Double;
begin
  PriceListUnSostavForm := TPriceListUnSostavForm.Create(Self);
  with PriceListUnSostavForm do begin
    try
      Id := spReadKit.FieldByName('g_product').AsLargeInt;
      Typ := cbTovar.ItemIndex;
      ExceptId := RecId;
      Amount := spReadKit.FieldByName('amount').AsString;
      Price := spReadKit.FieldByName('price').AsString;
      if ShowModal = mrOk then begin
        //дабы пользователь, например в случае с пивным магазином, не рассчитывал вручную какое количество
        //указать, к примеру в одной кружке пива 1л от кеги в 50л, это будет 0.02, так вот, чтобы юзер это сам не
        //рассчитывал, я буду рассчитывать из поля "Количество в упаковке", при условии, что это поле не равно 0
        if spRead.FieldByName('pack_amount').AsFloat > 0 then begin
          realAmount := StrToFloat(MyCurrencyFrameForm.edAmount.Text) / spRead.FieldByName('pack_amount').AsFloat;
          realAmountForCalc := StrToFloat(MyCurrencyFrameForm.edAmount.Text);
        end
        else begin
          realAmount := StrToFloat(MyCurrencyFrameForm.edAmount.Text);
          realAmountForCalc := realAmount;
        end;

        spUpdatePics.SQL.Text := 'UPDATE G_PRODUCT_KIT_TMP K SET K.AMOUNT = :AMOUNT_, K.PRICE = :PRICE_, K.PRICE1 = :PRICE1_ WHERE K.G_PRODUCT_KIT = :G_PRODUCT_KIT_';
        spUpdatePics.ParamByName('G_PRODUCT_KIT_').AsInt64 := spReadKit.FieldByName('G_PRODUCT_KIT').AsLargeInt;
        spUpdatePics.ParamByName('AMOUNT_').AsFloat := realAmount;
        spUpdatePics.ParamByName('PRICE_').AsFloat := edPrice.Value;
        spUpdatePics.ParamByName('PRICE1_').AsFloat := edPriceVol.Value;
        ExecQuery;
        ReadSostav;
        RecalcPriceKit(realAmountForCalc);

        edName.ModifiedAfterEnter := true;
        FKitModified := true;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TPriceListUnForm.RecalcPriceKit(real_amount : Double);
var BM : TBookmark;
begin
  edPrice.Value := 0;
  edVolPrice.Value := 0;
  BM := spReadKit.GetBookmark;
  spReadKit.First;
  while not spReadKit.Eof do begin
    edPrice.Value := edPrice.Value + spReadKit.FieldByName('amount').AsFloat * spReadKit.FieldByName('price').AsFloat;
    edVolPrice.Value := edVolPrice.Value + spReadKit.FieldByName('amount').AsFloat * spReadKit.FieldByName('price_vol').AsFloat;
    spReadKit.Next;
  end;
  spReadKit.GotoBookmark(BM);
end;

procedure TPriceListUnForm.aDelKitExecute(Sender: TObject);
begin
  //mdSostav.Delete;
  spUpdatePics.SQL.Text := 'DELETE FROM G_PRODUCT_KIT_TMP K WHERE K.G_PRODUCT_ITEM = :G_PRODUCT_ITEM_';
  spUpdatePics.ParamByName('G_PRODUCT_ITEM_').AsInt64 := spReadKit.FieldByName('G_PRODUCT').AsLargeInt;
  ExecQuery;
  ReadSostav;
  edName.ModifiedAfterEnter := True;
  FKitModified := true;
end;

function TPriceListUnForm.MarkedSostavCheck(mode: integer) : boolean;
var onChange, onChange1 : TNotifyEvent;
begin
  result := false;

  try
    onChange := cbIsMarked.Properties.OnChange;
    onChange1 := cbTovar.Properties.OnChange;
    cbIsMarked.Properties.OnChange := nil;
    cbTovar.Properties.OnChange := nil;

    if (cbTovar.ItemIndex = 1) and (cbIsMarked.Checked) then begin
      MessageDlg('Тип товара указан "Набор (составной)". К такому типу не применима' +
        ' маркировка товара. Измените тип товара.', mtError, [mbOk], 0);

      if mode = 1 then
        cbIsMarked.Checked := False
      else
        cbTovar.ItemIndex := 0;

      Exit;
    end;
  finally
    cbIsMarked.Properties.OnChange := onChange;
    cbTovar.Properties.OnChange := onChange1;
  end;

  result := true;
end;

procedure TPriceListUnForm.cbIsMarkedPropertiesChange(Sender: TObject);
begin
  MarkedSostavCheck(1);
end;

procedure TPriceListUnForm.cbTovar1Change(Sender: TObject);
begin
  if MarkedSostavCheck(2) = false then
    Exit;

  ReadSostav;
  clmGridDBTableView1PRICE.Visible := cbTovar.ItemIndex <> 2;
  edName.ModifiedAfterEnter := True;
end;

procedure TPriceListUnForm.ReadSostav;
begin
  lbUsual.Visible := cbTovar.ItemIndex = 0;
  lbSostav.Visible := cbTovar.ItemIndex = 1;
  lbProduct.Visible := cbTovar.ItemIndex = 2;

  OpenSP(spReadKit, False);
  if cbTovar.ItemIndex > 0 then begin
    grSostav.Enabled := True;
    aInsKit.Enabled := True;
    aUpdKit.Enabled := spReadKit.RecordCount > 0;
    aDelKit.Enabled := spReadKit.RecordCount > 0;
  end else begin
    grSostav.Enabled := False;
    aInsKit.Enabled := False;
    aUpdKit.Enabled := False;
    aDelKit.Enabled := False;
  end;

  if (spReadKit.RecordCount > 1) and (cbTovar.ItemIndex = 1) then begin
    edPrice.Properties.ReadOnly := True;
    edVolPrice.Properties.ReadOnly := True;
  end else begin
    edPrice.Properties.ReadOnly := False;
    edVolPrice.Properties.ReadOnly := False;
  end;
end;

procedure TPriceListUnForm.cbTovar1Click(Sender: TObject);
begin
  inherited;
  edName.ModifiedAfterEnter := True;
end;

procedure TPriceListUnForm.edMFCountryKeyPress(Sender: TObject;
  var Key: Char);
Var S : String;
begin
  if ((Sender as TcxTextEdit).SelStart = 0) then begin
    S := AnsiUpperCase(Key);
    Key := S[1];
  end;
end;

procedure TPriceListUnForm.edPriceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If ((Shift = [ssCtrl])) or
    ((Shift = [ssShift]) and (Key=45)) or
    ((Shift = [ssShift]) and (Key=0)) then
    edName.ModifiedAfterEnter := True;    // иначе не цепляеться изменение при вставке
end;

procedure TPriceListUnForm.edPricePropertiesChange(Sender: TObject);
begin
  edPrice.Text := StringReplace(edPrice.Text, ',', '.', [rfReplaceAll]);

  // решил сделать через калькулятор при добавлении составного товара
  // здесь через таймер слишком сложно
  {
  if FIsGetDataNow = false then begin
    TimerChangeEd.Enabled := False;
    // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
    if edPrice.Text <> '' then
      TimerChangeEd.Enabled := True;
  end;
  }
end;

procedure TPriceListUnForm.edVesGrammPropertiesChange(Sender: TObject);
var OnChange : TNotifyEvent;
begin
  OnChange := edPrice.Properties.OnChange;
  edPrice.Properties.OnChange := nil;
  edPrice.Value := edVesGramm.Value * edVesGrammPrice.Value;

  edPrice.Properties.OnChange := OnChange;
end;

procedure TPriceListUnForm.edVolPriceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If ((Shift = [ssCtrl])) or
    ((Shift = [ssShift]) and (Key=45)) or
    ((Shift = [ssShift]) and (Key=0)) then
    edName.ModifiedAfterEnter := True;    // иначе не цепляеться изменение при вставке
end;

procedure TPriceListUnForm.edVolPricePropertiesChange(Sender: TObject);
begin
  inherited;
  edVolPrice.Text := StringReplace(edVolPrice.Text, ',', '.', [rfReplaceAll]);
end;


end.
