unit frmPriceListRepFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBFilter, Menus, ActnList, ExtCtrls,
  StdCtrls, Buttons, cxControls, cxContainer, cxEdit, cxGroupBox,
  cxRadioGroup, DB, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, AppEvnts, cxPC,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTextEdit,
  cxTLdxBarBuiltInMenu, cxCheckBox, cxInplaceContainer, cxDBTl, cxMaskEdit,
  cxTLData, frmGridFrame, cxGridCustomTableView, frmPopupClientMultList,
  cxDropDownEdit, Types, system.UITypes, dxBarBuiltInMenu, System.Actions,
  cxClasses, cxButtons;

type
  TExistRecArr = record
    Id: array of Integer;
    EntityId: array of Integer;
    Return: array of string;
    Enabled: array of string;
    Code: array of string;
    Name: array of string;
  end;

  TExistRec = record
    EntityId: Integer;
    Return: string;
    Enabled: string;
    Code: string;
    Name: string;
  end;

  TExistArray = array of TExistRec;
  
  TPriceListRepFilterForm = class(TDBFilterForm)
    dsReadErr: TDataSource;
    tranRead: TpFIBTransaction;
    spRead: TpFIBDataSet;
    pcMain: TcxPageControl;
    tsCommon: TcxTabSheet;
    tsSklad: TcxTabSheet;
    Panel2: TPanel;
    btAll: TButton;
    btNone: TButton;
    spReadTochka: TpFIBDataSet;
    dsReadTochka: TDataSource;
    tlError: TcxDBTreeList;
    clmnCheckCol: TcxDBTreeListColumn;
    clmnNAME: TcxDBTreeListColumn;
    clmnG_PRODUCT: TcxDBTreeListColumn;
    frmSklad: TGridFrame;
    pn1: TPanel;
    ceIncludeNol: TcxCheckBox;
    ceIncludeFew: TcxCheckBox;
    cbSortByName: TcxCheckBox;
    rgCategory: TcxRadioGroup;
    pnPostavshik: TPanel;
    lb1: TLabel;
    pePostavshik: TcxPopupEdit;
    pn2: TPanel;
    rbVybor: TRadioButton;
    rbService: TRadioButton;
    rbTovar: TRadioButton;
    rbRashodniki: TRadioButton;
    rbAll: TRadioButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rgCategoryClick(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAllClick(Sender: TObject);
    procedure btNoneClick(Sender: TObject);
    procedure tlErrorCustomDrawDataCell(Sender: TcxCustomTreeList;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
      var ADone: Boolean);
    procedure tlErrorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tlSkladCustomDrawDataCell(Sender: TcxCustomTreeList;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
      var ADone: Boolean);
    procedure tlSkladMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pePostavshikKeyPress(Sender: TObject; var Key: Char);
    procedure pePostavshikPropertiesCloseUp(Sender: TObject);
    procedure pePostavshikPropertiesInitPopup(Sender: TObject);
  private
    FG_Category: TExistRecArr;
    FG_CategoryArr: String;
    FIncludeNol: Integer;
    FIncludeFew: Integer;
    FSortByName: Integer;
    FSkladsArr    : String;
    FSkladsArrStr : String;
    FMode : Integer;
    FPopupClientForm : TPopupClientMultListForm;
  public
    property G_Category: TExistRecArr read FG_Category write FG_Category;
    property G_CategoryArr: string read FG_CategoryArr write FG_CategoryArr;
    property IncludeNol: Integer read FIncludeNol write FIncludeNol;
    property IncludeFew: Integer read FIncludeFew write FIncludeFew;
    property SortByName: Integer read FSortByName write FSortByName;
    property SkladsArr  : String read FSkladsArr write FSkladsArr;
    property SkladsArrStr  : String read FSkladsArrStr write FSkladsArrStr;
    property Mode: Integer read FMode write FMode;
  end;

var
  PriceListRepFilterForm: TPriceListRepFilterForm;

implementation

uses unCommonFunc;

{$R *.dfm}


procedure TPriceListRepFilterForm.rgCategoryClick(Sender: TObject);
begin
  inherited;
  if rgCategory.ItemIndex = 1 then begin
    tlError.Enabled := True;
    OpenSp(spRead, False);
  end else begin
    spRead.Close;
    tlError.Enabled := False;
  end;
end;

procedure TPriceListRepFilterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmSklad.FreeList;
end;

procedure TPriceListRepFilterForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i : integer;
    ANode: TcxTreeListNode;
begin
  IF ModalResult = mrOK then BEGIN
    //ЗАПОЛНЯЮ МАССИВ КАТЕГОРИЙ ТОВАРА
    if spRead.Active then begin
      FG_CategoryArr := '~';
      tlError.TopNode.Focused := True;
      ANode := tlError.FocusedNode;
      while ANode <> nil do begin
        if ANode.Data <> nil then
          if PBoolean(ANode.Data)^ then
            FG_CategoryArr := FG_CategoryArr + IntToStr(ANode.Values[2]) + '~';

        ANode := ANode.GetNext;
        if ANode = nil then BEGIN
          Break;
        END;
      end;
    end;

    FIncludeNol := Integer(ceIncludeNol.Checked);
    FIncludeFew := Integer(ceIncludeFew.Checked);
    FSortByName := Integer(cbSortByName.Checked);

    //ЗАПОЛНЯЮ МАССИВ СКЛАДОВ
    IF spReadTochka.RecordCount > 1 THEN BEGIN
      FSkladsArrStr := 'Склады: ';
      FSkladsArr := '-';
      for i := 0 to frmSklad.AList.Count-1 do begin
        //FSkladsArr := FSkladsArr + FloatToStr(TcxCustomGridRecord(frmSklad.AList[i]).Values[2]) + '-';
        //FSkladsArrStr := FSkladsArrStr + TcxCustomGridRecord(frmSklad.AList[i]).Values[1] + ', ';
        FSkladsArr := FSkladsArr + IntToStr(Integer(frmSklad.AList[i])) + '-';

        frmSklad.spReadFrame.Locate('g_tochka', Integer(frmSklad.AList[i]), []);
        FSkladsArrStr := FSkladsArrStr + frmSklad.spReadFrame.FieldByName('name').AsString + ', ';
      end;
      FSkladsArrStr := copy(FSkladsArrStr, 1, LastDelimiter(',', FSkladsArrStr)-1);
    END;
  END;
END;

procedure TPriceListRepFilterForm.FormCreate(Sender: TObject);
begin
  inherited;
  frmSklad.CreateList;
  FPopupClientForm := TPopupClientMultListForm.Create(Self);
end;

procedure TPriceListRepFilterForm.tlErrorCustomDrawDataCell(
  Sender: TcxCustomTreeList; ACanvas: TcxCanvas;
  AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
begin
  with TcxDBTreeListColumn(AViewInfo.Column) do
    if (DataBinding.FieldName = '') and (Properties is TcxCheckBoxProperties) then
      with AViewInfo.Node do
        TcxCustomCheckBoxViewInfo(AViewInfo.EditViewInfo).State :=
          TcxCheckBoxState(not((Data = nil) or ((Data <> nil) and (PBoolean(Data)^ = False))));
end;

procedure TPriceListRepFilterForm.tlErrorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ANode: TcxTreeListNode;
  AColumn: TcxTreeListColumn;
begin
  with TcxTreeList(Sender) do
  begin
    HitTest.ReCalculate(Point(X, Y));
    if HitTest.HitAtNode and (HitTest.HitColumn <> nil) then
    begin
      ANode := HitTest.HitNode;
      AColumn := HitTest.HitColumn;
      if AColumn.Properties is TcxCheckBoxProperties then
        SetChecks(TcxTreeList(Sender), ANode, AColumn);
    end;
  end;
end;

procedure TPriceListRepFilterForm.ApplicationEvents1Activate(
  Sender: TObject);
begin
  //inherited;
end;

procedure TPriceListRepFilterForm.FormShow(Sender: TObject);
begin
  inherited;
  G_CategoryArr := '';
  FillChar(FG_Category, SizeOf(FG_Category), 0);

  // открываю склады, и если больше 1, то делаю вкладку видимой и ставлю галочку на текущий склад, и если вызывается в отчете Остаток товаров
  OpenSP(spReadTochka, False);
  IF FMode = 1 THEN BEGIN
    IF spReadTochka.RecordCount > 1 THEN BEGIN
      tsSklad.TabVisible := True;
      OpenSP(frmSklad.spReadFrame, False);
      frmSklad.spReadFrame.Locate('g_tochka', CurSklad, []);
      frmSklad.SetCheckOne(frmSklad.tvMain.ViewData.Records[frmSklad.tvMain.DataController.FocusedRecordIndex]);
    END;
    pnPostavshik.Visible := TRUE;
  END;

  rgCategory.Style.Font.Size := 9;

  //если программа не активирована, то буду давать формировать только за сегодня
  if IsActivated = 0 then begin
    MessageDlg('Программа не активирована! Включены ограничения!', mtWarning, [mbOK], 0);
    rgCategory.Properties.Items.Delete(1);
  end;
end;

procedure TPriceListRepFilterForm.pePostavshikKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TPriceListRepFilterForm.pePostavshikPropertiesCloseUp(
  Sender: TObject);
begin
  if FPopupCLIENTForm.AcceptRes then begin
    (Sender as TcxPopupEdit).Tag := FPopupCLIENTForm.spRead.FieldByName('ID').AsInteger;
    (Sender as TcxPopupEdit).Text := FPopupCLIENTForm.spRead.FieldByName('name').AsString;
  end;
end;

procedure TPriceListRepFilterForm.pePostavshikPropertiesInitPopup(
  Sender: TObject);
begin
  pePostavshik.DroppedDown := True;
  FPopupCLIENTForm.IsPostavshik := 1;
  FPopupCLIENTForm.arefresh.Execute;
end;

procedure TPriceListRepFilterForm.btAllClick(Sender: TObject);
begin
  frmSklad.SetRemoveCheckAll(true);
end;

procedure TPriceListRepFilterForm.btNoneClick(Sender: TObject);
begin
  frmSklad.SetRemoveCheckAll(false);
end;

procedure TPriceListRepFilterForm.tlSkladCustomDrawDataCell(
  Sender: TcxCustomTreeList; ACanvas: TcxCanvas;
  AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
begin
  with TcxDBTreeListColumn(AViewInfo.Column) do
  if (DataBinding.FieldName = '') and (Properties is TcxCheckBoxProperties) then
    with AViewInfo.Node do
      TcxCustomCheckBoxViewInfo(AViewInfo.EditViewInfo).State :=
        TcxCheckBoxState(not((Data = nil) or ((Data <> nil) and (PBoolean(Data)^ = False))));
end;

procedure TPriceListRepFilterForm.tlSkladMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var ANode: TcxTreeListNode; AColumn: TcxTreeListColumn;
begin
  with TcxTreeList(Sender) do
  begin
    HitTest.ReCalculate(Point(X, Y));
    if HitTest.HitAtNode and (HitTest.HitColumn <> nil) then
    begin
      ANode := HitTest.HitNode;
      AColumn := HitTest.HitColumn;
      SetChecks(TcxTreeList(Sender), ANode, AColumn);
    end;
  end;
end;

end.
