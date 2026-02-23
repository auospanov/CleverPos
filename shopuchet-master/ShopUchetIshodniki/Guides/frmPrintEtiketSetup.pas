unit frmPrintEtiketSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, ExtCtrls, StdCtrls,
  AppEvnts, Buttons, Printers, IniFiles, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCurrencyEdit, Menus, cxButtons, System.UITypes,
  cxClasses, cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, dxBarBuiltInMenu, cxPC,
  cxCheckBox, cxDropDownEdit, cxRadioGroup, dxSkinscxPCPainter;

type
  TPrintEtiketSetupForm = class(TDlgForm)
    Label6: TLabel;
    Shape11: TShape;
    Shape12: TShape;
    Label2: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    edAmount: TcxCurrencyEdit;
    btHelp: TcxButton;
    lb7: TLabel;
    seSdvig: TcxSpinEdit;
    pcPrintMode: TcxPageControl;
    tsEtiket: TcxTabSheet;
    tsCennik: TcxTabSheet;
    Shape13: TShape;
    Label7: TLabel;
    Shape14: TShape;
    lblCannot1: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    grp1: TGroupBox;
    lbl2: TLabel;
    spnPriceSize: TcxSpinEdit;
    grp3: TGroupBox;
    lb1: TLabel;
    spnArticulSize: TcxSpinEdit;
    grp4: TGroupBox;
    lb2: TLabel;
    lb3: TLabel;
    spnNameSize: TcxSpinEdit;
    grp2: TGroupBox;
    shp1: TShape;
    lbl1: TLabel;
    shp2: TShape;
    lbl3: TLabel;
    spnSloganSize: TcxSpinEdit;
    edSlogan: TcxTextEdit;
    grp5: TGroupBox;
    lb4: TLabel;
    spnCennikPriceSize: TcxSpinEdit;
    grp6: TGroupBox;
    lb5: TLabel;
    lb6: TLabel;
    spnCennikNameSize: TcxSpinEdit;
    grp7: TGroupBox;
    shp3: TShape;
    lb8: TLabel;
    shp4: TShape;
    lb9: TLabel;
    spnCennikSloganSize: TcxSpinEdit;
    edCennikSlogan: TcxTextEdit;
    rbPrint: TcxRadioButton;
    rbPrinterA4: TcxRadioButton;
    cbPrinters: TcxComboBox;
    cbA4Size: TcxComboBox;
    cbChooseLentWidth: TcxComboBox;
    cbPrintPrice: TcxCheckBox;
    cbPriceBold: TcxCheckBox;
    cbPrintArticul: TcxCheckBox;
    cbArticulBold: TcxCheckBox;
    cbNameBold: TcxCheckBox;
    cbPrintSlogan: TcxCheckBox;
    cbSloganBold: TcxCheckBox;
    cbCennikSize: TcxComboBox;
    cbCennikPrintPrice: TcxCheckBox;
    cbCennikPriceBold: TcxCheckBox;
    cbCennikNameBold: TcxCheckBox;
    cbCennikPrintSlogan: TcxCheckBox;
    cbCennikSloganBold: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rbPrintClick(Sender: TObject);
    procedure cbChooseLentWidthChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure cbPrintSloganClick(Sender: TObject);
    procedure cbPrintPriceClick(Sender: TObject);
    procedure ApplicationEvents1ActionExecute(Action: TBasicAction;
      var Handled: Boolean);

    procedure DisablePriceRekv;
    procedure DisableArticulRekv;
    procedure DisableSloganRekv;
    procedure cbPrintArticulClick(Sender: TObject);
    procedure cbCennikSizeChange(Sender: TObject);
    procedure cbCennikPrintPriceClick(Sender: TObject);
    procedure cbCennikPrintSloganClick(Sender: TObject);
  private
    procedure SetDefaultSize(PriceSize, ArticulSize : Integer; SloganSize : Integer; NameSize : Integer);
    procedure SetCennikDefaultSize(PriceSize, SloganSize, NameSize : Integer);
  public
    { Public declarations }
  end;

var
  PrintEtiketSetupForm: TPrintEtiketSetupForm;

implementation

uses
  dmReports;

{$R *.dfm}

procedure TPrintEtiketSetupForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  SloganSize, PriceSize, NameSize, ArticulSize : integer;
  CennikSloganSize, CennikPriceSize, CennikNameSize : integer;
begin
  inherited;
  cbPrinters.Properties.Items.Assign(Printer.Printers);
  cbPrinters.ItemIndex := Printer.PrinterIndex;

  //открыли файл в директории программы
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    cbPrinters.ItemIndex := Ini.ReadInteger('Printetiket', 'PrinterIndex', 0);
    rbPrint.Checked := Ini.ReadInteger('Printetiket', 'PrinterEtiket', 1) = 1;
    rbPrinterA4.Checked := Ini.ReadInteger('Printetiket', 'PrinterA4', 0) = 1;
    cbChooseLentWidth.ItemIndex := Ini.ReadInteger('Printetiket', 'LentaWidth', 0);
    cbCennikSize.ItemIndex := Ini.ReadInteger('Printetiket', 'CennikSize', 0);
    cbA4Size.ItemIndex := Ini.ReadInteger('Printetiket', 'A4Size', 0);
    edAmount.Text := IntToStr(Ini.ReadInteger('Printetiket', 'Amount', 1));
    //этикетки
    edSlogan.Text := Ini.ReadString('Printetiket', 'Slogan', '');
    cbPrintPrice.Checked := Ini.ReadInteger('Printetiket', 'PrintPrice', 0) = 1;
    cbPrintArticul.Checked := Ini.ReadInteger('Printetiket', 'PrintArticul', 0) = 1;
    cbPrintSlogan.Checked := Ini.ReadInteger('Printetiket', 'PrintSlogan', 0) = 1;
    cbPriceBold.Checked := Ini.ReadInteger('Printetiket', 'PriceBold', 0) = 1;
    cbArticulBold.Checked := Ini.ReadInteger('Printetiket', 'ArticulBold', 0) = 1;
    cbSloganBold.Checked := Ini.ReadInteger('Printetiket', 'SloganBold', 0) = 1;
    PriceSize := Ini.ReadInteger('Printetiket', 'PriceSize', 0);
    ArticulSize := Ini.ReadInteger('Printetiket', 'ArticulSize', 0);
    SloganSize := Ini.ReadInteger('Printetiket', 'SloganSize', 0);
    NameSize := Ini.ReadInteger('Printetiket', 'NameSize', 0);
    cbNameBold.Checked := Ini.ReadInteger('Printetiket', 'NameBold', 0) = 1;
    SetDefaultSize(PriceSize, ArticulSize, SloganSize, NameSize);
    //ценники
    edCennikSlogan.Text := Ini.ReadString('Printetiket', 'CennikSlogan', '');
    cbCennikPrintPrice.Checked := Ini.ReadInteger('Printetiket', 'CennikPrintPrice', 0) = 1;
    cbCennikPrintSlogan.Checked := Ini.ReadInteger('Printetiket', 'CennikPrintSlogan', 0) = 1;
    cbCennikPriceBold.Checked := Ini.ReadInteger('Printetiket', 'CennikPriceBold', 0) = 1;
    cbCennikSloganBold.Checked := Ini.ReadInteger('Printetiket', 'CennikSloganBold', 0) = 1;
    CennikPriceSize := Ini.ReadInteger('Printetiket', 'CennikPriceSize', 0);
    CennikSloganSize := Ini.ReadInteger('Printetiket', 'CennikSloganSize', 0);
    CennikNameSize := Ini.ReadInteger('Printetiket', 'CennikNameSize', 0);
    cbCennikNameBold.Checked := Ini.ReadInteger('Printetiket', 'CennikNameBold', 0) = 1;
    SetCennikDefaultSize(CennikPriceSize, CennikSloganSize, CennikNameSize);

    seSdvig.Value := Ini.ReadInteger('Printetiket', 'Sdvig', 0);
    pcPrintMode.ActivePageIndex := Ini.ReadInteger('Printetiket', 'pcPrintMode', 0);
  finally
    Ini.Free;
  end;

  DisablePriceRekv;
  DisableArticulRekv;
  DisableSloganRekv;
end;

procedure TPrintEtiketSetupForm.SetCennikDefaultSize(PriceSize, SloganSize,
  NameSize: Integer);
begin
  // у ценников есть размеры по умолчанию
  if cbCennikSize.ItemIndex = 0 then begin     // 35 x 60
    if PriceSize = 0 then
      spnCennikPriceSize.Value := 15
    else
      spnCennikPriceSize.Value := PriceSize;

    if SloganSize = 0 then
      spnCennikSloganSize.Value := 7
    else
      spnCennikSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnCennikNameSize.Value := 10
    else
      spnCennikNameSize.Value := NameSize;
  end
  else if cbCennikSize.ItemIndex = 1 then begin     // 40 x 60
    if PriceSize = 0 then
      spnCennikPriceSize.Value := 15
    else
      spnCennikPriceSize.Value := PriceSize;

    if SloganSize = 0 then
      spnCennikSloganSize.Value := 9
    else
      spnCennikSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnCennikNameSize.Value := 10
    else
      spnCennikNameSize.Value := NameSize;
  end
  else if cbCennikSize.ItemIndex = 2 then begin     // Лист А5
    if PriceSize = 0 then
      spnCennikPriceSize.Value := 25
    else
      spnCennikPriceSize.Value := PriceSize;

    if SloganSize = 0 then
      spnCennikSloganSize.Value := 15
    else
      spnCennikSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnCennikNameSize.Value := 22
    else
      spnCennikNameSize.Value := NameSize;
  end
end;

procedure TPrintEtiketSetupForm.SetDefaultSize(PriceSize, ArticulSize : Integer; SloganSize : Integer; NameSize : Integer);
begin
  // у этикеток есть размеры по умолчанию, при переключении, или если не заданы настройки, надо ставить эти значения
  if cbChooseLentWidth.ItemIndex in [1, 10] then begin     // 30*15 , 66*15
    if PriceSize = 0 then
      spnPriceSize.Value := 6
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 6
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 6
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 6
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex in [0, 2, 3]  then begin     // 29*20, 47*25, 43*25
    if PriceSize = 0 then
      spnPriceSize.Value := 7
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 7
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 7
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 7
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex = 5 then begin     // 58*30
    if PriceSize = 0 then
      spnPriceSize.Value := 9
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 9
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 9
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 9
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex in [4, 6, 7, 8] then begin     // 58*40, 58*60, 58*100
    if PriceSize = 0 then
      spnPriceSize.Value := 10
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 10
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 10
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 10
    else
      spnNameSize.Value := NameSize;
  end
  else if cbChooseLentWidth.ItemIndex = 9 then begin     // 100*70
    if PriceSize = 0 then
      spnPriceSize.Value := 12
    else
      spnPriceSize.Value := PriceSize;

    if ArticulSize = 0 then
      spnArticulSize.Value := 12
    else
      spnArticulSize.Value := ArticulSize;

    if SloganSize = 0 then
      spnSloganSize.Value := 12
    else
      spnSloganSize.Value := SloganSize;

    if NameSize = 0 then
      spnNameSize.Value := 12
    else
      spnNameSize.Value := NameSize;
  end
end;

procedure TPrintEtiketSetupForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  inherited;

  //создали файл в директории программы
  if ModalResult = mrOK then begin
    if (rbPrinterA4.checked) and (edAmount.Value > 1000) then begin
      MessageDlg('При печати на принтере А4, нельзя напечатать больше 1000 этикеток за раз!' + #10#13 +
                 'Выберите меньшее количество!', mtInformation, [mbOK], 0);
      edAmount.SetFocus;
      Exit;
    end;

    Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
    try
      Ini.WriteInteger('Printetiket', 'PrinterIndex', cbPrinters.ItemIndex);
      Ini.WriteInteger('Printetiket', 'PrinterEtiket', Integer(rbPrint.Checked));
      Ini.WriteInteger('Printetiket', 'PrinterA4', Integer(rbPrinterA4.Checked));
      Ini.WriteInteger('Printetiket', 'LentaWidth', cbChooseLentWidth.ItemIndex);
      Ini.WriteInteger('Printetiket', 'A4Size', cbA4Size.ItemIndex);
      Ini.WriteInteger('Printetiket', 'CennikSize', cbCennikSize.ItemIndex);
      Ini.WriteInteger('Printetiket', 'Amount', StrToInt(edAmount.Text));
      //этикетки
      Ini.WriteString('Printetiket', 'Slogan', edSlogan.Text);
      Ini.WriteInteger('Printetiket', 'PrintPrice', Integer(cbPrintPrice.Checked));
      Ini.WriteInteger('Printetiket', 'PrintArticul', Integer(cbPrintArticul.Checked));
      Ini.WriteInteger('Printetiket', 'PrintSlogan', Integer(cbPrintSlogan.Checked));
      Ini.WriteInteger('Printetiket', 'PriceBold', Integer(cbPriceBold.Checked));
      Ini.WriteInteger('Printetiket', 'ArticulBold', Integer(cbArticulBold.Checked));
      Ini.WriteInteger('Printetiket', 'SloganBold', Integer(cbSloganBold.Checked));
      Ini.WriteInteger('Printetiket', 'PriceSize', spnPriceSize.Value);
      Ini.WriteInteger('Printetiket', 'ArticulSize', spnArticulSize.Value);
      Ini.WriteInteger('Printetiket', 'SloganSize', spnSloganSize.Value);
      Ini.WriteInteger('Printetiket', 'NameSize', spnNameSize.Value);
      Ini.WriteInteger('Printetiket', 'NameBold', Integer(cbNameBold.Checked));
      //ценники
      Ini.WriteString('Printetiket', 'CennikSlogan', edCennikSlogan.Text);
      Ini.WriteInteger('Printetiket', 'CennikPrintPrice', Integer(cbCennikPrintPrice.Checked));
      Ini.WriteInteger('Printetiket', 'CennikPrintSlogan', Integer(cbCennikPrintSlogan.Checked));
      Ini.WriteInteger('Printetiket', 'CennikPriceBold', Integer(cbCennikPriceBold.Checked));
      Ini.WriteInteger('Printetiket', 'CennikSloganBold', Integer(cbCennikSloganBold.Checked));
      Ini.WriteInteger('Printetiket', 'CennikPriceSize', spnCennikPriceSize.Value);
      Ini.WriteInteger('Printetiket', 'CennikSloganSize', spnCennikSloganSize.Value);
      Ini.WriteInteger('Printetiket', 'CennikNameSize', spnCennikNameSize.Value);
      Ini.WriteInteger('Printetiket', 'CennikNameBold', Integer(cbCennikNameBold.Checked));

      Ini.WriteInteger('Printetiket', 'Sdvig', seSdvig.Value);
      Ini.WriteInteger('Printetiket', 'pcPrintMode', pcPrintMode.ActivePageIndex);
    finally
      Ini.UpdateFile;
      Ini.Free;
    end
  end;
end;

procedure TPrintEtiketSetupForm.rbPrintClick(Sender: TObject);
begin
  cbChooseLentWidth.Visible := rbPrint.Checked;
  cbA4Size.Visible := rbPrinterA4.Checked;
end;

procedure TPrintEtiketSetupForm.cbCennikPrintPriceClick(Sender: TObject);
begin
  cbCennikPriceBold.Enabled := cbCennikPrintPrice.Checked;
  spnCennikPriceSize.Enabled := cbCennikPrintPrice.Checked;

  if cbCennikPrintPrice.Checked = False then
    cbCennikPriceBold.Checked := False;
end;

procedure TPrintEtiketSetupForm.cbCennikPrintSloganClick(Sender: TObject);
begin
  edCennikSlogan.Enabled := cbCennikPrintSlogan.Checked;
  cbCennikSloganBold.Enabled := cbCennikPrintSlogan.Checked;
  spnCennikSloganSize.Enabled := cbCennikPrintSlogan.Checked;

  if cbCennikPrintSlogan.Checked = False then
    cbCennikSloganBold.Checked := False;
end;

procedure TPrintEtiketSetupForm.cbCennikSizeChange(Sender: TObject);
begin
  SetCennikDefaultSize(0, 0, 0);
end;

procedure TPrintEtiketSetupForm.cbChooseLentWidthChange(Sender: TObject);
begin
  SetDefaultSize(0, 0, 0, 0);
end;

procedure TPrintEtiketSetupForm.btHelpClick(Sender: TObject);
begin
  Application.HelpContext(55);
end;

procedure TPrintEtiketSetupForm.cbPrintSloganClick(Sender: TObject);
begin
  DisableSloganRekv;
end;

procedure TPrintEtiketSetupForm.DisableArticulRekv;
begin
  cbArticulBold.Enabled := cbPrintArticul.Checked;
  spnArticulSize.Enabled := cbPrintArticul.Checked;

  if cbPrintArticul.Checked = False then
    cbArticulBold.Checked := False;
end;

procedure TPrintEtiketSetupForm.DisablePriceRekv;
begin
  cbPriceBold.Enabled := cbPrintPrice.Checked;
  spnPriceSize.Enabled := cbPrintPrice.Checked;

  if cbPrintPrice.Checked = False then
    cbPriceBold.Checked := False;
end;

procedure TPrintEtiketSetupForm.DisableSloganRekv;
begin
  edSlogan.Enabled := cbPrintSlogan.Checked;
  cbSloganBold.Enabled := cbPrintSlogan.Checked;
  spnSloganSize.Enabled := cbPrintSlogan.Checked;

  if cbPrintSlogan.Checked = False then
    cbSloganBold.Checked := False;
end;

procedure TPrintEtiketSetupForm.cbPrintArticulClick(Sender: TObject);
begin
  DisableArticulRekv;
end;

procedure TPrintEtiketSetupForm.cbPrintPriceClick(Sender: TObject);
begin
  DisablePriceRekv;
end;

procedure TPrintEtiketSetupForm.ApplicationEvents1ActionExecute(
  Action: TBasicAction; var Handled: Boolean);
begin
  //inherited;
end;

end.