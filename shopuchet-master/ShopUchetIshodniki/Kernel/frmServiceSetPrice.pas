unit frmServiceSetPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, ExtCtrls, AppEvnts, dxExEdtr,
  dxCntner, Buttons, dxEditor, dxDBEdtr, dxDBELib, DB, FIBDataSet,
  pFIBDataSet, FIBDatabase, pFIBDatabase, frmDBDlg, ActnList, cxSpinEdit,
  cxTimeEdit, cxPC, dxDBCtrl, dxTL, dxDBTLCl, dxDBTL, dxEdLib,
  cxSplitter, frmTreeFrame, frmPopupClientList;

type
  TServiceSetPriceForm = class(TDBDlgForm)
    tranRead: TpFIBTransaction;
    spIspolnitel: TpFIBDataSet;
    dsIspolnitel: TDataSource;
    PageControl: TcxPageControl;
    tsDates: TcxTabSheet;
    tsSklad: TcxTabSheet;
    tlSklad: TdxDBTreeList;
    CheckCol: TdxDBTreeListCheckColumn;
    tlSkladNAME: TdxDBTreeListMaskColumn;
    G_TOCHKA: TdxDBTreeListColumn;
    Panel2: TPanel;
    btAll: TButton;
    btNone: TButton;
    spReadTochka: TpFIBDataSet;
    pnOfficial: TPanel;
    Label4: TLabel;
    Shape6: TShape;
    Shape5: TShape;
    leIspolnitel: TdxLookupEdit;
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
    cbxPayment: TComboBox;
    dsReadTochka: TDataSource;
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
    TovaryFrame: TTreeFrame;
    Panel5: TPanel;
    Panel7: TPanel;
    cbCatAll: TCheckBox;
    TovCatFrame: TTreeFrame;
    splMenu: TcxSplitter;
    TimerTovar: TTimer;
    peClient: TdxPopupEdit;
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
    procedure tlSkladClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TovCatFrametlCommonClick(Sender: TObject);
    procedure edSearchTovarChange(Sender: TObject);
    procedure TimerTovarTimer(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure peClientCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure peClientInitPopup(Sender: TObject);
    procedure peClientKeyPress(Sender: TObject; var Key: Char);
  private
    FSotrudnik  : Integer;
    FDateBegin : TDate;
    FDateEnd   : TDate;
    FClient    : Integer;
    FPayment      : Integer;
    FCategory     : Integer;
    FCategoryArr  : String;
    FTovar        : Integer;
    FTovarArr     : String;
    FTovarName    : String;
    FSkladsArr    : String;
    FSkladsArrStr : String;
    FTovCategoryArr : String;
    FTovaryArr      : String;
    FModeR : Integer;
    FPopupClientForm : TPopupClientListForm;
  public
    property DateBegin : TDate read FDateBegin write FDateBegin;
    property DateEnd   : TDate read FDateEnd write FDateEnd;
    property Client    : Integer read FClient write FClient;
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
  ServiceSetPriceForm: TServiceSetPriceForm;

implementation

uses unCommonFunc;

{$R *.dfm}

procedure TServiceSetPriceForm.FormShow(Sender: TObject);
var onEditChng : TNotifyEvent;    //чтобы не срабатывало открытие spRead при открытии формы, в случае когда вкладка была не "Дата"
begin
  onEditChng := PageControl.OnChange;
  PageControl.OnChange := nil;
  PageControl.ActivePage := tsDates;
  PageControl.OnChange := onEditChng;

  edDate.Date := Date;
  edEndDate.Date := Date;
  pnReal.Visible := False;
  tsTovar.TabVisible := False;

  // открываю склады, и если больше 1, то делаю вкладку видимой и ставлю галочку на текущий склад
  IF High(SkladArr) > 0 THEN BEGIN
    OpenSP(spReadTochka, False);
    tsSklad.TabVisible := True;
    spReadTochka.Locate('g_tochka', CurSklad, []);
    tlSklad.FocusedNode.Values[0] := '1';
    tlSklad.FullCollapse;  //иначе почему-то весь раскрывается
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

  END else IF FModeR = 3 then begin   //ОТЧЕТ О ПРОДАЖАХ В МАГАЗИНЕ
    pnPayment.Visible := False;
    OpenSP(spIspolnitel, False);
    tsTovar.TabVisible := True;
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
  END else IF FModeR = 8 then begin   //ОТЧЕТ ПО ОСТАТКАМ ТОВАРОВ НА РЕАЛИЗАЦИИ
    tsTovar.TabVisible := True;
    PageControl.ActivePage := tsTovar;
    tsDates.TabVisible := false;
  END
end;

procedure TServiceSetPriceForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var ANode: TdxTreeListNode;
begin
  inherited;
  if ModalResult = mrOK then begin
    FDateBegin := edDate.Date;
    FDateEnd   := edEndDate.Date;

    if not cbPayment.Checked then
      FPayment := cbxPayment.itemindex + 1;

    if not cbClient.Checked then
      if peClient.Tag > 0 then
        FClient := peClient.Tag
      else begin
        Showmessage('Выберите клиента!');
        CanClose := False;
        Exit;
      end;

    if not cbOfficial.Checked then
      if leIspolnitel.LookupKeyValue > 0 then
        FSotrudnik := leIspolnitel.LookupKeyValue
      else begin
        Showmessage('Выберите сотрудника!');
        CanClose := False;
        Exit;
      end;

    if not cbCatAll.Checked then
      FCategoryArr := TovCatFrame.FillArr;

    if not cbTovAll.Checked then
      FTovarArr := TovaryFrame.FillArr;

    if FModeR = 7 then
      if FTovarArr = '' then begin
        Showmessage('Выберите хотя бы один товар!');
        PageControl.ActivePage := tsTovar;
        CanClose := False;
        Exit;
      end;

    //ЗАПОЛНЯЮ МАССИВ СКЛАДОВ
    IF spReadTochka.RecordCount > 1 THEN BEGIN
      FSkladsArrStr := 'Склады: ';
      FSkladsArr := '-';
      tlSklad.FullExpand;
      tlSklad.GotoFirst;
      ANode := tlSklad.FocusedNode;
      while ANode <> nil do begin
        if ANode.Values[0] = '1' then BEGIN
          FSkladsArr := FSkladsArr + IntToStr(ANode.Values[2]) + '-';
          FSkladsArrStr := FSkladsArrStr + ANode.Values[1] + ', ';
        END;

        ANode := ANode.GetNextNode;
        if ANode = nil then BEGIN
          FSkladsArrStr := copy(FSkladsArrStr, 1, LastDelimiter(',', FSkladsArrStr)-1);
          Break;
        END;
      end;
    END;
  end;
end;

procedure TServiceSetPriceForm.byMonthClick(Sender: TObject);
begin
  edDate.Date := edDate.Date - 30;
  edDate.Enabled := False;
  edEndDate.Enabled := False;
end;

procedure TServiceSetPriceForm.byYearClick(Sender: TObject);
begin
  edDate.Date := edEndDate.Date - 365;
  edDate.Enabled := False;
  edEndDate.Enabled := False;
end;

procedure TServiceSetPriceForm.byPeriodClick(Sender: TObject);
begin
  edDate.Enabled := True;
  edEndDate.Enabled := True;
end;

procedure TServiceSetPriceForm.byDayClick(Sender: TObject);
begin
  edDate.Date := Date;
  edDate.Enabled := True;
  edEndDate.Enabled := False;
  edEndDate.Date := edDate.Date;
end;

procedure TServiceSetPriceForm.edDateExit(Sender: TObject);
begin
  if byDay.Checked then
    edEndDate.Date := edDate.Date;
end;

procedure TServiceSetPriceForm.leIspolnitelChange(Sender: TObject);
begin
  FSotrudnik := leIspolnitel.LookupKeyValue;
end;

procedure TServiceSetPriceForm.ceTimeClick(Sender: TObject);
begin
  edTimeBegin.Enabled := ceTime.Checked;
  edTimeEnd.Enabled := ceTime.Checked;
end;

procedure TServiceSetPriceForm.cbCatAllClick(Sender: TObject);
begin
  if cbCatAll.Checked then begin
    TovCatFrame.spReadFrame.Close;
    TovCatFrame.tlCommon.ClearNodes;
    TovCatFrame.tlCommon.Enabled := False;

    cbTovAll.Checked := True;
    cbTovAll.Enabled := False;
  end else begin
    OpenSp(TovCatFrame.spReadFrame, False);
    TovCatFrame.FillGrid;
    TovCatFrame.tlCommon.Enabled := True;
    cbTovAll.Enabled := True;
  end;
end;

procedure TServiceSetPriceForm.cbTovAllClick(Sender: TObject);
begin
  if cbTovAll.Checked then begin
    TovaryFrame.spReadFrame.Close;
    TovaryFrame.tlCommon.ClearNodes;
    TovaryFrame.tlCommon.Enabled := False;
  end else begin
    Screen.Cursor := crHourGlass;
    TovaryFrame.spReadFrame.ParamByName('G_CATEGORY_').AsString := TovCatFrame.FillArr;
    OpenSp(TovaryFrame.spReadFrame, False);
    TovaryFrame.FillGrid;
    TovaryFrame.tlCommon.Enabled := True;
    Screen.Cursor := crDefault;    
  end;
end;

procedure TServiceSetPriceForm.btAllClick(Sender: TObject);
var ANode: TdxTreeListNode;
begin
  spReadTochka.First;
  ANode := tlSklad.FocusedNode;
  while ANode <> nil do begin
    ANode.Values[0] := '1';
    if ANode.HasChildren then ANode.Expand(False);
    ANode := ANode.GetNextNode;
    if ANode = nil then Break;
  end;
end;

procedure TServiceSetPriceForm.btNoneClick(Sender: TObject);
var ANode: TdxTreeListNode;
begin
  spReadTochka.First;
  ANode := tlSklad.FocusedNode;
  while ANode <> nil do begin
    ANode.Values[0] := '0';
    if ANode.HasChildren then ANode.Expand(False);
    ANode := ANode.GetNextNode;
    if ANode = nil then Break;
  end;
  tlSklad.FullCollapse;  //иначе почему-то весь раскрывается
end;

procedure TServiceSetPriceForm.cbPaymentClick(Sender: TObject);
begin
  if cbPayment.Checked then begin
    cbxPayment.ItemIndex := -1;
    cbxPayment.Enabled := False;
  end else begin
    cbxPayment.Enabled := True;
    cbxPayment.ItemIndex := 0;
  end
end;

procedure TServiceSetPriceForm.cbClientClick(Sender: TObject);
begin
  if cbClient.Checked then begin
    peClient.Tag := 0;
    peClient.Clear;
    peClient.Enabled := False;
    FClient := 0;
  end else
    peClient.Enabled := True;
end;

procedure TServiceSetPriceForm.cbOfficialClick(Sender: TObject);
begin
  if cbOfficial.Checked then begin
    leIspolnitel.Clear;
    leIspolnitel.Enabled := False;
    FSotrudnik := 0;
  end else
    leIspolnitel.Enabled := True;
end;

procedure TServiceSetPriceForm.tlSkladClick(Sender: TObject);
var
  AnItem: TdxTreeListNode;
  ANode: TdxTreeListNode;
  i : Integer;
  Cnt : integer;
begin
  with (Sender as TdxDBTreeList) do begin
    AnItem := FocusedNode;
    if AnItem <> nil then begin
      if AnItem.Values[0] = '1' then
       AnItem.Values[0] := '0'
      else if (AnItem.Values[0] = '0') or (AnItem.Values[0] = '') then
       AnItem.Values[0] := '1';

      // если есть детки, то проставляю им всем галочки
      if AnItem.HasChildren then begin
        AnItem.Expand(False);
        ANode := AnItem.GetFirstChild;
        for i := 0 to AnItem.Count - 1 do begin
          ANode.Values[0] := AnItem.Values[0];
          ANode := ANode.GetNextNode;
        end;

      // если это дочка, и галочка ставится, то надо родителю тоже поставить
      end else if (AnItem.Parent <> nil) and (AnItem.Values[0] = '1') then
        AnItem.Parent.Values[0] := '1'

      // если это дочка, и галочка убирается, то надо проверить а у всех ли дочек убрана галочка, если у всех, то галочку у родителя надо тоже убрать
      else if (AnItem.Parent <> nil) and (AnItem.Values[0] = '0') then begin
        ANode := AnItem.Parent.GetFirstChild;
        Cnt := 0;
        for i := 0 to AnItem.Parent.Count - 1 do begin
          if ANode.Values[0] = '1' then
           Cnt := Cnt + 1;
          ANode := ANode.GetNextNode;
        end;
        if Cnt = 0 then
          AnItem.Parent.Values[ColumnByName('CheckCol').Index] := '0';  //везде поставил 0, а тут оставил такой вызов просто так
      end
    end;
  end;
end;

procedure TServiceSetPriceForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPopupClientForm := TPopupClientListForm.Create(Self);
end;

procedure TServiceSetPriceForm.TovCatFrametlCommonClick(Sender: TObject);
begin
  TovCatFrame.tlCommonClick(Sender);
  if not cbTovAll.Checked then begin
    TovaryFrame.tlCommon.ClearNodes;
    TovaryFrame.spReadFrame.ParamByName('G_CATEGORY_').AsString := TovCatFrame.FillArr;
    OpenSp(TovaryFrame.spReadFrame, False);
    TovaryFrame.FillGrid;
  end;
end;

procedure TServiceSetPriceForm.edSearchTovarChange(Sender: TObject);
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
    TovaryFrame.tlCommon.ClearNodes;
    TovaryFrame.FillGrid;
  END;
end;

procedure TServiceSetPriceForm.TimerTovarTimer(Sender: TObject);
var s: string;
begin
  TimerTovar.Enabled := False;
  if (edSearchTovar.text<>'') then begin
    with TovaryFrame.spReadFrame do begin
      s := '(NAME CONTAINING ''' + edSearchTovar.text + ''') OR (ARTICUL CONTAINING ''' + edSearchTovar.text + ''') OR (BARCODE CONTAINING '''+ edSearchTovar.text + ''')';
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    TovaryFrame.tlCommon.ClearNodes;
    TovaryFrame.FillGrid;
  END;
end;

procedure TServiceSetPriceForm.PageControlChange(Sender: TObject);
begin
  // иначе когда вызываем отчет История товара, spRead сразу открывается, и открытие окна подтормаживает, если товаров много. Потому решил открытие здесь делать
  if (FModeR = 7) and (cbCatAll.Checked) then begin
    cbCatAll.Checked := False;
    cbTovAll.Checked := False;
    cbCatAll.Visible := False;
    cbTovAll.Visible := False;
  end;
end;

procedure TServiceSetPriceForm.peClientCloseUp(Sender: TObject;
  var Text: String; var Accept: Boolean);
begin
  if Accept then begin
    (Sender as TdxPopupEdit).Tag := FPopupClientForm.spRead.FieldByName('ID').AsInteger;
    Text := FPopupClientForm.spRead.FieldByName('name').AsString;
    FClient := FPopupClientForm.spRead.FieldByName('ID').AsInteger;
  end;
end;

procedure TServiceSetPriceForm.peClientInitPopup(Sender: TObject);
begin
  FPopupCLIENTForm.arefresh.Execute;
end;

procedure TServiceSetPriceForm.peClientKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

end.
