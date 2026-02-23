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
  cxClasses;

type
  TPrintEtiketSetupForm = class(TDlgForm)
    Label6: TLabel;
    Shape11: TShape;
    Label7: TLabel;
    Shape13: TShape;
    cbChooseLentWidth: TComboBox;
    Shape14: TShape;
    cbPrinters: TComboBox;
    Shape12: TShape;
    rbPrint: TRadioButton;
    rbPrinterA4: TRadioButton;
    Label2: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    grp1: TGroupBox;
    cbPrintPrice: TCheckBox;
    cbPriceBold: TCheckBox;
    grp2: TGroupBox;
    cbPrintSlogan: TCheckBox;
    lbl1: TLabel;
    shp1: TShape;
    shp2: TShape;
    cbSloganBold: TCheckBox;
    lblCannot1: TLabel;
    lbl2: TLabel;
    spnPriceSize: TcxSpinEdit;
    lbl3: TLabel;
    spnSloganSize: TcxSpinEdit;
    edAmount: TcxCurrencyEdit;
    edSlogan: TcxTextEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbNameBold: TCheckBox;
    spnNameSize: TcxSpinEdit;
    Label3: TLabel;
    cbA4Size: TComboBox;
    btHelp: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rbPrintClick(Sender: TObject);
    procedure cbChooseLentWidthChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure cbPrintSloganClick(Sender: TObject);
    procedure cbPrintPriceClick(Sender: TObject);
    procedure ApplicationEvents1ActionExecute(Action: TBasicAction;
      var Handled: Boolean);
  private
    procedure SetDefaultSize(PriceSize : Integer; SloganSize : Integer; NameSize : Integer);
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
  SloganSize, PriceSize, NameSize : integer;
begin
  inherited;
  cbPrinters.Items.Assign(Printer.Printers);
  cbPrinters.ItemIndex := Printer.PrinterIndex;

  //открыли файл в директории программы
  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    cbPrinters.ItemIndex := Ini.ReadInteger('Printetiket', 'PrinterIndex', 0);
    rbPrint.Checked := Ini.ReadInteger('Printetiket', 'PrinterEtiket', 1) = 1;
    rbPrinterA4.Checked := Ini.ReadInteger('Printetiket', 'PrinterA4', 0) = 1;
    cbChooseLentWidth.ItemIndex := Ini.ReadInteger('Printetiket', 'LentaWidth', 0);
    cbA4Size.ItemIndex := Ini.ReadInteger('Printetiket', 'A4Size', 0);
    edSlogan.Text := Ini.ReadString('Printetiket', 'Slogan', '');
    edAmount.Text := IntToStr(Ini.ReadInteger('Printetiket', 'Amount', 1));
    cbPrintPrice.Checked := Ini.ReadInteger('Printetiket', 'PrintPrice', 0) = 1;
    cbPrintSlogan.Checked := Ini.ReadInteger('Printetiket', 'PrintSlogan', 0) = 1;
    cbPriceBold.Checked := Ini.ReadInteger('Printetiket', 'PriceBold', 0) = 1;
    cbSloganBold.Checked := Ini.ReadInteger('Printetiket', 'SloganBold', 0) = 1;
    PriceSize := Ini.ReadInteger('Printetiket', 'PriceSize', 0);
    SloganSize := Ini.ReadInteger('Printetiket', 'SloganSize', 0);
    NameSize := Ini.ReadInteger('Printetiket', 'NameSize', 0);
    cbNameBold.Checked := Ini.ReadInteger('Printetiket', 'NameBold', 0) = 1;
    SetDefaultSize(PriceSize, SloganSize, NameSize);
  finally
    Ini.Free;
  end;
end;

procedure TPrintEtiketSetupForm.SetDefaultSize(PriceSize : Integer; SloganSize : Integer; NameSize : Integer);
begin
  // у этикеток есть размеры по умолчанию, при переключении, или если не заданы настройки, надо ставить эти значения
  if cbChooseLentWidth.ItemIndex = 1 then begin     // 30*15
    if PriceSize = 0 then
      spnPriceSize.Value := 6
    else
      spnPriceSize.Value := PriceSize;

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
      Ini.WriteString('Printetiket', 'Slogan', edSlogan.Text);
      Ini.WriteInteger('Printetiket', 'Amount', StrToInt(edAmount.Text));
      Ini.WriteInteger('Printetiket', 'PrintPrice', Integer(cbPrintPrice.Checked));
      Ini.WriteInteger('Printetiket', 'PrintSlogan', Integer(cbPrintSlogan.Checked));
      Ini.WriteInteger('Printetiket', 'PriceBold', Integer(cbPriceBold.Checked));
      Ini.WriteInteger('Printetiket', 'SloganBold', Integer(cbSloganBold.Checked));
      Ini.WriteInteger('Printetiket', 'PriceSize', spnPriceSize.Value);
      Ini.WriteInteger('Printetiket', 'SloganSize', spnSloganSize.Value);
      Ini.WriteInteger('Printetiket', 'NameSize', spnNameSize.Value);
      Ini.WriteInteger('Printetiket', 'NameBold', Integer(cbNameBold.Checked));
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

procedure TPrintEtiketSetupForm.cbChooseLentWidthChange(Sender: TObject);
begin
  SetDefaultSize(0, 0, 0);
end;

procedure TPrintEtiketSetupForm.btHelpClick(Sender: TObject);
begin
  Application.HelpContext(55);
end;

procedure TPrintEtiketSetupForm.cbPrintSloganClick(Sender: TObject);
begin
  edSlogan.Enabled := cbPrintSlogan.Checked;
  cbSloganBold.Enabled := cbPrintSlogan.Checked;
  spnSloganSize.Enabled := cbPrintSlogan.Checked;

  if cbPrintSlogan.Checked = False then
    cbSloganBold.Checked := False;
end;

procedure TPrintEtiketSetupForm.cbPrintPriceClick(Sender: TObject);
begin
  cbPriceBold.Enabled := cbPrintPrice.Checked;
  spnPriceSize.Enabled := cbPrintPrice.Checked;

  if cbPrintPrice.Checked = False then
    cbPriceBold.Checked := False;
end;

procedure TPrintEtiketSetupForm.ApplicationEvents1ActionExecute(
  Action: TBasicAction; var Handled: Boolean);
begin
  //inherited;
end;

end.
