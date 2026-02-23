unit frmClientDateFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, ExtCtrls, AppEvnts, Buttons, DB, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, frmDBDlg, ActnList, cxSpinEdit,
  cxTimeEdit, cxPC,
  cxSplitter, frmTreeFrame, cxRadioGroup, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxCurrencyEdit, cxCheckBox, cxDBTL,
  cxTLData, frmGridFrame, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, frmPopupClientMultList, System.UITypes,
  dxBarBuiltInMenu, Vcl.ComCtrls, dxCore, cxDateUtils, System.Actions,
  Vcl.Menus, cxButtons;

type
  TClientDateFilterForm = class(TDBDlgForm)
    tranRead: TpFIBTransaction;
    spIspolnitel: TpFIBDataSet;
    dsIspolnitel: TDataSource;
    PageControl: TcxPageControl;
    tsDates: TcxTabSheet;
    tsSklad: TcxTabSheet;
    Panel2: TPanel;
    btAll: TButton;
    btNone: TButton;
    pnOfficial: TPanel;
    Label4: TLabel;
    Shape6: TShape;
    Shape5: TShape;
    cbOfficial: TCheckBox;
    pnClient: TPanel;
    Label3: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    cbClient: TCheckBox;
    pnPayment: TPanel;
    Label7: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    cbPayment: TCheckBox;
    pnTime: TPanel;
    ceTime: TCheckBox;
    edTimeBegin: TcxTimeEdit;
    edTimeEnd: TcxTimeEdit;
    pnDate: TPanel;
    byDay: TRadioButton;
    byMonth: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    edDate: TcxDateEdit;
    edEndDate: TcxDateEdit;
    Shape4: TShape;
    byYear: TRadioButton;
    byPeriod: TRadioButton;
    pnReal: TPanel;
    Label5: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    ComboBox: TComboBox;
    tsTovar: TcxTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Label10: TLabel;
    cbTovAll: TCheckBox;
    edSearchTovar: TEdit;
    Panel5: TPanel;
    Panel7: TPanel;
    cbCatAll: TCheckBox;
    TovCatFrame: TTreeFrame;
    splMenu: TcxSplitter;
    TimerTovar: TTimer;
    tsSetNewPrices: TcxTabSheet;
    lb1: TLabel;
    sh1: TShape;
    sh2: TShape;
    lb2: TLabel;
    sh3: TShape;
    sh4: TShape;
    lb3: TLabel;
    sh5: TShape;
    sh6: TShape;
    lb4: TLabel;
    sh7: TShape;
    sh8: TShape;
    sh9: TShape;
    lb5: TLabel;
    sh10: TShape;
    pnPostavshik: TPanel;
    sh11: TShape;
    lb6: TLabel;
    sh12: TShape;
    cbPostavshikAll: TCheckBox;
    tsPredzakaz: TcxTabSheet;
    lb7: TLabel;
    sh13: TShape;
    lb8: TLabel;
    sh14: TShape;
    sh15: TShape;
    sh16: TShape;
    lb9: TLabel;
    sh17: TShape;
    sh18: TShape;
    lb10: TLabel;
    sh19: TShape;
    sh20: TShape;
    rbUnit: TcxRadioButton;
    rbProcent: TcxRadioButton;
    lbMode0: TLabel;
    cbbRound: TcxComboBox;
    lb12: TLabel;
    sh21: TShape;
    sh22: TShape;
    lb13: TLabel;
    lbVybor1: TLabel;
    lbVybor2: TLabel;
    lbVybor3: TLabel;
    lbMode1: TLabel;
    dsFirm: TDataSource;
    spFirm: TpFIBDataSet;
    pnContragent: TPanel;
    Label9: TLabel;
    rbClient: TRadioButton;
    rbPostavshik: TRadioButton;
    pnActSverki: TPanel;
    Label6: TLabel;
    Shape19: TShape;
    Shape21: TShape;
    Label11: TLabel;
    Label12: TLabel;
    Shape22: TShape;
    Shape24: TShape;
    edRukovod: TEdit;
    Shape23: TShape;
    cbbFirm: TcxLookupComboBox;
    Shape20: TShape;
    edClientDir: TEdit;
    edAmountAdd: TcxCurrencyEdit;
    cbDoSklad: TcxComboBox;
    cbMetodVybora: TcxComboBox;
    cbPredzakazMode: TcxComboBox;
    edValue: TcxCurrencyEdit;
    edOldCourse: TcxCurrencyEdit;
    edNewCourse: TcxCurrencyEdit;
    peClient: TcxPopupEdit;
    pePostavshik: TcxPopupEdit;
    leIspolnitel: TcxLookupComboBox;
    cbxPayment: TcxComboBox;
    TovaryFrame: TGridFrame;
    frmSklad: TGridFrame;
    cbChangePrice: TcxCheckBox;
    cbChangeCategory: TcxCheckBox;
    cbChangeMinOstatok: TcxCheckBox;
    cbMode: TcxComboBox;
    cbRoundMode: TcxComboBox;
    spProductCategory: TpFIBDataSet;
    dsProductCategory: TDataSource;
    leCategory: TcxLookupComboBox;
    shp1: TShape;
    shp2: TShape;
    edMinAmount: TcxCurrencyEdit;
    lbWhatPrice: TLabel;
    shpWhatPrice: TShape;
    shpWhatPrice1: TShape;
    cbWhatPrice: TcxComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure byMonthClick(Sender: TObject);
    procedure byYearClick(Sender: TObject);
    procedure byPeriodClick(Sender: TObject);
    procedure byDayClick(Sender: TObject);
    procedure edDateExit(Sender: TObject);
    procedure leIspolnitelChange(Sender: TObject);
    procedure ceTimeClick(Sender: TObject);
    procedure cbCatAllClick(Sender: TObject);
    procedure cbTovAllClick(Sender: TObject);
    procedure btAllClick(Sender: TObject);
    procedure btNoneClick(Sender: TObject);
    procedure cbPaymentClick(Sender: TObject);
    procedure cbClientClick(Sender: TObject);
    procedure cbOfficialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edSearchTovarChange(Sender: TObject);
    procedure TimerTovarTimer(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure peClientKeyPress(Sender: TObject; var Key: Char);
    procedure cbModeChange(Sender: TObject);
    procedure rbUnitClick(Sender: TObject);
    procedure cbMetodVyboraChange(Sender: TObject);
    procedure cbPredzakazModeChange(Sender: TObject);
    procedure rbPostavshikClick(Sender: TObject);
    procedure cbbFirmPropertiesChange(Sender: TObject);
    procedure TovCatFrametlCommonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure peClientPropertiesCloseUp(Sender: TObject);
    procedure peClientPropertiesInitPopup(Sender: TObject);
    procedure pePostavshikPropertiesInitPopup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb1PropertiesChange(Sender: TObject);
    procedure cbChangePricePropertiesChange(Sender: TObject);
    procedure cbChangeCategoryPropertiesChange(Sender: TObject);
    procedure cbChangeMinOstatokPropertiesChange(Sender: TObject);
  private
    FSotrudnik  : Integer;
    FDateBegin : TDate;
    FDateEnd   : TDate;
    FClient    : Integer;
    FClientCategory  : Integer;
    FPostavshik   : Integer;
    FContrAgentName : String;
    FContrAgentDirName : String;
    FFirmName     : String;
    FFIORukovod   : String;
    FPayment      : Integer;
    FCategoryArr  : String;
    FTovarArr     : String;
    FTovarName    : String;
    FSkladsArr    : String;
    FSkladsArrStr : String;
    FModeR : Integer;             // 100 - Сервис - массовое изменение цен товаров
    FPopupClientForm : TPopupClientMultListForm;
    function FillCatArr : STRING;
  public
    property DateBegin : TDate read FDateBegin write FDateBegin;
    property DateEnd   : TDate read FDateEnd write FDateEnd;
    property Client    : Integer read FClient write FClient;
    property ClientCategory  : Integer read FClientCategory write FClientCategory;
    property ContrAgentName  : String read FContrAgentName write FContrAgentName;
    property ContrAgentDirName  : String read FContrAgentDirName write FContrAgentDirName;
    property FirmName  : String read FFirmName write FFirmName;
    property FIORukovod  : String read FFIORukovod write FFIORukovod;
    property Postavshik  : Integer read FPostavshik write FPostavshik;
    property Sotrudnik : Integer read FSotrudnik write FSotrudnik;
    property Payment   : Integer read FPayment write FPayment;
    property Category  : String read FCategoryArr write FCategoryArr;
    property Tovar     : String read FTovarArr write FTovarArr;
    property TovarName  : String read FTovarName write FTovarName;
    property SkladsArr  : String read FSkladsArr write FSkladsArr;
    property SkladsArrStr  : String read FSkladsArrStr write FSkladsArrStr;
    property ModeR  : Integer read FModeR write FModeR;
  end;

var
  ClientDateFilterForm: TClientDateFilterForm;
  P : Pboolean;

implementation

uses unCommonFunc;

{$R *.dfm}

procedure TClientDateFilterForm.FormShow(Sender: TObject);
var onEditChng : TNotifyEvent;    //чтобы не срабатывало открытие spRead при открытии формы, в случае когда вкладка была не "Дата"
begin
  // у одного клиента почему-то надписи были укороченные, поставлю их тут силком полные
  byDay.width := ScaleDimension(100);
  byMonth.width := ScaleDimension(100);
  byYear.width := ScaleDimension(100);
  byPeriod.width := ScaleDimension(152);

  onEditChng := PageControl.OnChange;
  PageControl.OnChange := nil;
  PageControl.ActivePage := tsDates;
  PageControl.OnChange := onEditChng;

  edDate.Date := Date;
  edEndDate.Date := Date;
  pnReal.Visible := False;
  pnActSverki.Visible := False;
  pnPostavshik.Visible := False;
  tsTovar.TabVisible := False;
  tsSetNewPrices.TabVisible := False;
  tsPredzakaz.TabVisible := False;
  pnContragent.Visible := False;

  // открываю склады, и если больше 1, то делаю вкладку видимой и ставлю галочку на текущий склад
  IF High(SkladArr) > 0 THEN BEGIN
    tsSklad.TabVisible := True;
    OpenSP(frmSklad.spReadFrame, False);
    frmSklad.spReadFrame.Locate('g_tochka', CurSklad, []);
    frmSklad.SetCheckOne(frmSklad.tvMain.ViewData.Records[frmSklad.tvMain.DataController.FocusedRecordIndex]);
  END;

  if FModeR = 1 then begin         //ПРИБЫЛЬ МАГАЗИНА
    pnOfficial.Visible := False;
    pnTime.Visible := False;

  end else IF FModeR in [2, 7] then begin   //ОТЧЕТ О ДВИЖЕНИИ ТОВАРА В МАГАЗИНЕ, ИСТОРИЯ ТОВАРА
    pnOfficial.Visible := False;
    pnPayment.Visible := False;
    pnClient.Visible := False;
    pnTime.Visible := False;
    tsTovar.TabVisible := True;
    IF FModeR = 2 then
      pnPostavshik.Visible := True;

  END else IF FModeR in [3, 31, 32] then begin   //ОТЧЕТ О ПРОДАЖАХ В МАГАЗИНЕ
    pnPayment.Visible := False;
    OpenSP(spIspolnitel, False);
    if FModeR <> 32 then begin             // ДЛЯ ОТЧЕТА ПО ПРОДАЖАМ В РАЗРЕЗЕ НАКЛАДНЫХ - НЕ НАДО ТОВАРЫ
      tsTovar.TabVisible := True;
      FPopupClientForm.tsGroups.TabVisible := True;
    end
    else begin
      pnClient.Visible := False;
      pnOfficial.Visible := False;
    end;
  END else IF FModeR = 4 then begin   //ОТЧЕТ ПО ПРИХОДУ ТОВАРА
    pnPayment.Visible := False;
    pnClient.Visible := False;
    pnTime.Visible := False;
    pnOfficial.Visible := False;
  END else IF FModeR = 5 then begin   //ОТЧЕТ ПО ОСТАТКАМ ДЕНЕГ
    byMonth.Visible := False;
    byYear.Visible := False;
    byPeriod.Visible := False;
    pnPayment.Visible := False;
    pnClient.Visible := False;
    pnTime.Visible := False;
    pnOfficial.Visible := False;
  END else IF FModeR = 6 then begin   //ОТЧЕТ ПО ТОВАРУ НА РЕАЛИЗАЦИИ
    pnPayment.Visible := False;
    pnTime.Visible := False;
    pnOfficial.Visible := False;
    pnReal.Visible := True;
    FPopupClientForm.tsGroups.TabVisible := True;
  END else IF FModeR = 8 then begin   //ОТЧЕТ ПО ОСТАТКАМ ТОВАРОВ НА РЕАЛИЗАЦИИ
    tsTovar.TabVisible := True;
    PageControl.ActivePage := tsTovar;
    tsDates.TabVisible := False;
    tsSklad.TabVisible := False;
  END else IF FModeR = 9 then begin   //ОТЧЕТ АКТ СВЕРКИ
    pnActSverki.Visible := True;
    pnContragent.Visible := True;
    cbClient.Enabled := False;
    cbClient.Visible := False;
    cbClient.Enabled := False;
    cbClient.Visible := False;
    cbPostavshikAll.Enabled := False;
    cbPostavshikAll.Visible := False;
    pnPayment.Visible := False;
    pnOfficial.Visible := False;
    peClient.Enabled := True;
    OpenSP(spFirm, False);
    if spFirm.RecordCount > 1 then
      spFirm.Locate('is_default', 1, [])
    else
      spFirm.First;
    cbbFirm.EditValue := spFirm.FieldByName('G_FIRM_REKVIZIT').AsInteger;

  END else IF FModeR = 100 then begin   //МАССОВОЕ ИЗМЕНИЕ ЦЕН ТОВАРОВ
    tsTovar.TabVisible := True;
    tsSetNewPrices.TabVisible := True;
    PageControl.ActivePage := tsSetNewPrices;
    tsDates.TabVisible := false;
    tsSklad.TabVisible := false;      // обычно этого делать не нужно, но тут просто режим, который вообще не нуждается в складах
    OpenSP(spProductCategory, False);
  END else IF FModeR = 101 then begin   //ПРЕДЗАКАЗ ТОВАРОВ
    PageControl.ActivePage := tsPredzakaz;
    tsDates.Enabled := False;
    pnTime.Visible := False;
    tsSklad.TabVisible := False;
    pnClient.Visible := False;
    pnOfficial.Visible := False;
    pnPayment.Visible := False;
    pnPostavshik.Visible := true;
    tsPredzakaz.TabVisible := true;
    cbbRound.ItemIndex := 0;
  end;

  //если программа не активирована, то буду давать формировать только за сегодня
  if IsActivated = 0 then begin
    MessageDlg('Программа не активирована! Включены ограничения!', mtWarning, [mbOK], 0);
    byDay.Checked := True;
    byMonth.Enabled := False;
    byYear.Enabled := false;
    byPeriod.Enabled := false;
  end;
end;

procedure TClientDateFilterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TovaryFrame.FreeList;
  frmSklad.FreeList;
end;

procedure TClientDateFilterForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i : integer;
begin
  inherited;
  if ModalResult = mrOK then begin
    FDateBegin := edDate.Date;
    FDateEnd   := edEndDate.Date;

    if not cbPayment.Checked then
      FPayment := cbxPayment.itemindex + 1;

    if not cbClient.Checked then
      if peClient.Tag = 0 then begin
        Showmessage('Выберите клиента!');
        CanClose := False;
        Exit;
      end;

    if (pnPostavshik.Visible) and (cbMetodVybora.ItemIndex > 0) then
      if pePostavshik.Tag <= 0 then begin
        Showmessage('Выберите поставщика!');
        PageControl.ActivePage := tsDates;
        CanClose := False;
        Exit;
      end;

    if not cbOfficial.Checked then
      if leIspolnitel.EditValue > 0 then
        FSotrudnik := leIspolnitel.EditValue
      else begin
        Showmessage('Выберите сотрудника!');
        CanClose := False;
        Exit;
      end;

    if not cbCatAll.Checked then begin
      FCategoryArr := FillCatArr;
      if FCategoryArr = '~' then
        FCategoryArr := '';
    end;

    if not cbTovAll.Checked then BEGIN
      FTovarArr := '~';
      FTovarArr := FTovarArr + TovaryFrame.FillArr;

      if FTovarArr = '~' then
        FTovarArr := '';
    END;

    if FModeR = 7 then
      if FTovarArr = '' then begin
        Showmessage('Выберите хотя бы один товар!');
        PageControl.ActivePage := tsTovar;
        CanClose := False;
        Exit;
      end;

    IF (((cbMode.ItemIndex < 4) AND (edValue.Value <> 0)) or ((cbMode.ItemIndex = 4) AND ((edOldCourse.Value <> 0) or (edNewCourse.Value <> 0)))) then begin
      if (FModeR = 100) and (cbCatAll.checked) and (cbTovAll.checked) then
        if MessageDlg('Вы уверены, что хотите изменить цены ВСЕХ товаров?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then begin
          PageControl.ActivePage := tsTovar;
          CanClose := False;
          Exit;
        end;
    end;

    if FModeR = 9 then begin
      if rbClient.checked then begin
        if peClient.Text = '' then begin
          MessageDlg('Выберите клиента!', mtInformation, [mbOK], 0);
          CanClose := False;
          Exit;
        end;
        FContrAgentName := peClient.Text
      end else begin
        if pePostavshik.Text = '' then begin
          MessageDlg('Выберите поставщика!', mtInformation, [mbOK], 0);
          CanClose := False;
          Exit;
        end;
        FContrAgentName := pePostavshik.Text;
        FClient := FPostavshik;
      end;

      IF cbbFirm.EditValue = 0 THEN begin
        MessageDlg('Выберите свою компанию!', mtInformation, [mbOK], 0);
        CanClose := False;
        Exit;
      end;
    end;

    if FModeR = 100 then begin
      if cbChangePrice.Checked then begin
        if (cbMode.ItemIndex < 4) AND (edValue.Value = 0) then begin
          MessageDlg('Укажите значение!', mtInformation, [mbOK], 0);
          PageControl.ActivePage := tsSetNewPrices;
          edValue.SetFocus;
          CanClose := False;
          Exit;
        end;

        if (cbMode.ItemIndex = 4) AND (edOldCourse.Value = 0) and (edNewCourse.Value = 0) then begin
          MessageDlg('Укажите значения курсов!', mtInformation, [mbOK], 0);
          PageControl.ActivePage := tsSetNewPrices;
          edNewCourse.SetFocus;
          CanClose := False;
          Exit;
        end;
      end;

      if (cbChangeCategory.Checked) and (leCategory.EditValue = 0) or (leCategory.EditValue = null) then begin
        MessageDlg('Выберите группу товаров!', mtInformation, [mbOK], 0);
        PageControl.ActivePage := tsSetNewPrices;
        leCategory.SetFocus;
        CanClose := False;
        Exit;
      end;
    end;

    //ЗАПОЛНЯЮ МАССИВ СКЛАДОВ
    IF frmSklad.spReadFrame.RecordCount > 1 THEN BEGIN
      FSkladsArrStr := 'Склады: ';
      FSkladsArr := '-';
      for i := 0 to frmSklad.AList.Count-1 do begin
        FSkladsArr := FSkladsArr + IntToStr(Integer(frmSklad.AList[i])) + '-';

        frmSklad.spReadFrame.Locate('g_tochka', Integer(frmSklad.AList[i]), []);
        FSkladsArrStr := FSkladsArrStr + frmSklad.spReadFrame.FieldByName('name').AsString + ', ';
      end;
      FSkladsArrStr := copy(FSkladsArrStr, 1, LastDelimiter(',', FSkladsArrStr)-1);
    END;
  end;
end;

procedure TClientDateFilterForm.byMonthClick(Sender: TObject);
begin
  edDate.Date := edDate.Date - 30;
  edDate.Enabled := False;
  edEndDate.Enabled := False;
end;

procedure TClientDateFilterForm.byYearClick(Sender: TObject);
begin
  edDate.Date := edEndDate.Date - 365;
  edDate.Enabled := False;
  edEndDate.Enabled := False;
end;

procedure TClientDateFilterForm.byPeriodClick(Sender: TObject);
begin
  edDate.Enabled := True;
  edEndDate.Enabled := True;
end;

procedure TClientDateFilterForm.byDayClick(Sender: TObject);
begin
  edDate.Date := Date;
  edDate.Enabled := True;
  edEndDate.Enabled := False;
  edEndDate.Date := edDate.Date;
end;

procedure TClientDateFilterForm.edDateExit(Sender: TObject);
begin
  if byDay.Checked then
    edEndDate.Date := edDate.Date;
end;

procedure TClientDateFilterForm.leIspolnitelChange(Sender: TObject);
begin
  FSotrudnik := leIspolnitel.EditValue;
end;

procedure TClientDateFilterForm.ceTimeClick(Sender: TObject);
begin
  edTimeBegin.Enabled := ceTime.Checked;
  edTimeEnd.Enabled := ceTime.Checked;
end;

procedure TClientDateFilterForm.cbCatAllClick(Sender: TObject);
begin
  if cbCatAll.Checked then begin
    TovCatFrame.spReadFrame.Close;
    TovCatFrame.tlCommon.Clear;
    TovCatFrame.tlCommon.Enabled := False;
  end else begin
    OpenSp(TovCatFrame.spReadFrame, False);
    TovCatFrame.tlCommon.Enabled := True;
    TovCatFrame.tlCommon.FullExpand;
    TovCatFrame.tlCommon.SetFocus;
    if FModeR <> 31 then     //ДЛЯ ОТЧЕТА ПО ПРОДАЖАМ ПО КАТЕГОРИЯМ - НЕ НУЖНЫ ТОВАРЫ
      cbTovAll.Enabled := True;
  end;
end;

procedure TClientDateFilterForm.cbChangeCategoryPropertiesChange(
  Sender: TObject);
begin
  leCategory.Enabled := cbChangeCategory.Checked;
end;

procedure TClientDateFilterForm.cbChangeMinOstatokPropertiesChange(
  Sender: TObject);
begin
  edMinAmount.Enabled := cbChangeMinOstatok.Checked;
end;

procedure TClientDateFilterForm.cbChangePricePropertiesChange(Sender: TObject);
begin
  cbMode.Enabled := cbChangePrice.Checked;
  edValue.Enabled := cbChangePrice.Checked;
  cbRoundMode.Enabled := cbChangePrice.Checked;
end;

procedure TClientDateFilterForm.cbTovAllClick(Sender: TObject);
begin
  if cbTovAll.Checked then begin
    TovaryFrame.ClearList;
    TovaryFrame.spReadFrame.Close;
    TovaryFrame.grMain.Enabled := False;
  end else begin
    Screen.Cursor := crHourGlass;
    TovaryFrame.spReadFrame.ParamByName('g_category_').AsString := FillCatArr;
    OpenSp(TovaryFrame.spReadFrame, False);
    TovaryFrame.grMain.Enabled := True;
    TovaryFrame.grMain.SetFocus;
    Screen.Cursor := crDefault;
  end;
end;

function TClientDateFilterForm.FillCatArr : STRING;
var ANode, ANodeOld: TcxTreeListNode;
begin
  ANodeOld := TovCatFrame.tlCommon.FocusedNode;
  //ЗАПОЛНЯЮ МАССИВ КАТЕГОРИЙ
  Result := '~';
  TovCatFrame.tlCommon.GotoBOF;
  TovCatFrame.tlCommon.TopNode.Focused := True;
  ANode := TovCatFrame.tlCommon.FocusedNode;
  while ANode <> nil do begin
    if ANode.Data <> nil then
      if PBoolean(ANode.Data)^ then
        Result  := Result + IntToStr(ANode.Values[2]) + '~';

    ANode := ANode.GetNext;
    if ANode = nil then BEGIN
      Break;
    END;
  end;

  ANodeOld.Focused := True;
end;

procedure TClientDateFilterForm.TovCatFrametlCommonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TovCatFrame.tlCommonMouseDown(Sender, Button, Shift, X, Y);
  if not cbTovAll.Checked then begin
    Screen.Cursor := crHourGlass;
    TovaryFrame.spReadFrame.ParamByName('g_category_').AsString := FillCatArr;
    OpenSp(TovaryFrame.spReadFrame, False);
    Screen.Cursor := crDefault;
  end;
end;

procedure TClientDateFilterForm.btAllClick(Sender: TObject);
begin
  frmSklad.SetRemoveCheckAll(true);
end;

procedure TClientDateFilterForm.btNoneClick(Sender: TObject);
begin
  frmSklad.SetRemoveCheckAll(false);
end;

procedure TClientDateFilterForm.cbPaymentClick(Sender: TObject);
begin
  if cbPayment.Checked then begin
    cbxPayment.ItemIndex := -1;
    cbxPayment.Enabled := False;
  end else begin
    cbxPayment.Enabled := True;
    cbxPayment.ItemIndex := 0;
  end
end;

procedure TClientDateFilterForm.cbClientClick(Sender: TObject);
begin
  if cbClient.Checked then begin
    peClient.Tag := 0;
    peClient.Clear;
    peClient.Enabled := False;
    FClient := 0;
  end else
    peClient.Enabled := True;
end;

procedure TClientDateFilterForm.cbOfficialClick(Sender: TObject);
begin
  if cbOfficial.Checked then begin
    leIspolnitel.Clear;
    leIspolnitel.Enabled := False;
    FSotrudnik := 0;
  end else
    leIspolnitel.Enabled := True;
end;

procedure TClientDateFilterForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPopupClientForm := TPopupClientMultListForm.Create(Self);
  TovaryFrame.CreateList;
  frmSklad.CreateList;
end;

procedure TClientDateFilterForm.edSearchTovarChange(Sender: TObject);
begin
  TimerTovar.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edSearchTovar.Text <> '' then
    TimerTovar.Enabled := True
  else BEGIN
    with TovaryFrame.spReadFrame do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

procedure TClientDateFilterForm.TimerTovarTimer(Sender: TObject);
var s: string;
begin
  TimerTovar.Enabled := False;
  if (edSearchTovar.text<>'') then begin
    with TovaryFrame.spReadFrame do begin
      s := '(NAME CONTAINING ''' + edSearchTovar.text + ''') OR (ARTICUL CONTAINING ''' + edSearchTovar.text + ''') OR (BARCODE CONTAINING '''+ edSearchTovar.text + ''')';
      
      if UseTovarPlace = 1 then
        s := s + ' OR (PLACE CONTAINING ''' + edSearchTovar.text + ''')';

      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if TovaryFrame.tvMain.Controller.FocusedRow <> Nil then begin
      if TovaryFrame.tvMain.Controller.SelectedRowCount > 0 then
        TovaryFrame.tvMain.Controller.SelectedRows[0].Selected := False;
      TovaryFrame.tvMain.Controller.FocusedRow.Selected := True;
    end;
  END;
end;

procedure TClientDateFilterForm.PageControlChange(Sender: TObject);
begin
  // иначе когда вызываем отчет История товара, spRead сразу открывается, и открытие окна подтормаживает, если товаров много. Потому решил открытие здесь делать
  if (FModeR = 7) and (cbCatAll.Checked) then begin
    cbCatAll.Checked := False;
    cbTovAll.Checked := False;
    cbCatAll.Visible := False;
    cbTovAll.Visible := False;
  end;
end;

procedure TClientDateFilterForm.peClientKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TClientDateFilterForm.peClientPropertiesCloseUp(Sender: TObject);
begin
  if FPopupCLIENTForm.AcceptRes then begin
    if FPopupCLIENTForm.dxPageControl.ActivePage = FPopupCLIENTForm.ts1 then begin
      (Sender as TcxPopupEdit).Tag := FPopupCLIENTForm.spRead.FieldByName('ID').AsInteger;
      (Sender as TcxPopupEdit).Text := FPopupCLIENTForm.spRead.FieldByName('name').AsString;

      if (Sender as TcxPopupEdit).Name = 'peClient' then
        FClient := (Sender as TcxPopupEdit).Tag
      else
        FPostavshik := (Sender as TcxPopupEdit).Tag;
    end else begin
      (Sender as TcxPopupEdit).Tag := FPopupCLIENTForm.spGroups.FieldByName('ID').AsInteger;
      (Sender as TcxPopupEdit).Text := FPopupCLIENTForm.spGroups.FieldByName('name').AsString;
      FClientCategory := (Sender as TcxPopupEdit).Tag;
    end;
  end;
end;

procedure TClientDateFilterForm.peClientPropertiesInitPopup(Sender: TObject);
begin
  peClient.DroppedDown := True;
  FPopupCLIENTForm.IsPostavshik := 0;
  FPopupCLIENTForm.arefresh.Execute;
end;

procedure TClientDateFilterForm.pePostavshikPropertiesInitPopup(
  Sender: TObject);
begin
  pePostavshik.DroppedDown := True;
  FPopupCLIENTForm.IsPostavshik := 1;
  FPopupCLIENTForm.arefresh.Execute;
end;

procedure TClientDateFilterForm.cbModeChange(Sender: TObject);
begin


  {if (cbMode.ItemIndex in [0, 2]) then
    edValue.Properties.DisplayFormat := ',0.00%'
  else
    edValue.Properties.DisplayFormat := ',0.00';}
end;

procedure TClientDateFilterForm.rbUnitClick(Sender: TObject);
begin
  cbbRound.Enabled := rbProcent.Checked;
  if (rbProcent.Checked) then
    edAmountAdd.Properties.DisplayFormat := ',0.00%'
  else
    edAmountAdd.Properties.DisplayFormat := ',0.00';
end;

procedure TClientDateFilterForm.cbMetodVyboraChange(Sender: TObject);
begin
  tsDates.Enabled := cbMetodVybora.ItemIndex > 0;
  pnDate.Visible := cbMetodVybora.ItemIndex = 2;

  lbVybor1.Visible := cbMetodVybora.ItemIndex = 0;
  lbVybor2.Visible := cbMetodVybora.ItemIndex = 1;
  lbVybor3.Visible := cbMetodVybora.ItemIndex = 2;
end;

procedure TClientDateFilterForm.cbPredzakazModeChange(Sender: TObject);
begin
  lbMode0.Visible := cbPredzakazMode.ItemIndex = 0;
  lbMode1.Visible := cbPredzakazMode.ItemIndex = 1;
end;

procedure TClientDateFilterForm.rbPostavshikClick(Sender: TObject);
begin
  pnPostavshik.Visible := rbPostavshik.Checked;
  pnClient.Visible := rbClient.Checked;
end;

procedure TClientDateFilterForm.cb1PropertiesChange(Sender: TObject);
begin
  edValue.Enabled := cbMode.ItemIndex <> 4;
  edOldCourse.Enabled := cbMode.ItemIndex = 4;
  edNewCourse.Enabled := cbMode.ItemIndex = 4;

  lbWhatPrice.Visible := cbMode.ItemIndex = 5;
  shpWhatPrice.Visible := cbMode.ItemIndex = 5;
  shpWhatPrice1.Visible := cbMode.ItemIndex = 5;
  cbWhatPrice.Visible := cbMode.ItemIndex = 5;
end;

procedure TClientDateFilterForm.cbbFirmPropertiesChange(Sender: TObject);
begin
  edRukovod.Text := spFirm.FieldByName('head').asString;
end;

end.
