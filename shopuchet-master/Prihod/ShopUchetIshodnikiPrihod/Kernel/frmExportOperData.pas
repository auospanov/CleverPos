unit frmExportOperData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDlg, StdCtrls,
  ExtCtrls, AppEvnts, Buttons, ActiveX, FileCtrl, Inifiles, cxControls,
  cxContainer, cxEdit, cxCheckBox, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxButtonEdit, System.UITypes,
  cxClasses, Vcl.Menus, cxButtons;

type
  TExportOperDataForm = class(TDlgForm)
    lbPayment: TLabel;
    lb1: TLabel;
    lb2: TLabel;
    shp1: TShape;
    shp2: TShape;
    cbTime: TComboBox;
    lb3: TLabel;
    shp3: TShape;
    shp4: TShape;
    lb4: TLabel;
    cbSales: TcxCheckBox;
    cbOstatok: TcxCheckBox;
    cbOstatokXML: TcxCheckBox;
    bedtFileName: TcxButtonEdit;
    cbProfit: TcxCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cbSalesPropertiesChange(Sender: TObject);
    procedure bedtFileNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportOperDataForm: TExportOperDataForm;

implementation

{$R *.dfm}

procedure TExportOperDataForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
begin
  if ModalResult = mrOk then begin
    if not SysUtils.DirectoryExists(bedtFileName.Text) and (cbTime.ItemIndex > 0) then begin
      MessageDlg('Такого пути не существует! Переопределите папку для сохранения!', mtWarning, [mbOK], 0);
      bedtFileName.SetFocus;
      CanClose := False;
      Exit;
    end;

    Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
    try
      Ini.WriteString('ExportOperData', 'DataType', IntToStr(Integer(cbSales.checked)) +
      IntToStr(Integer(cbOstatok.checked)) + IntToStr(Integer(cbOstatokXML.checked)) +
      IntToStr(Integer(cbProfit.checked)));
      Ini.WriteInteger('ExportOperData', 'cbTime', cbTime.ItemIndex);
      Ini.WriteString('ExportOperData', 'ExportPath', bedtFileName.Text);
    finally
      Ini.UpdateFile;
      Ini.Free;
    end;
  end;  

  inherited;
end;

procedure TExportOperDataForm.FormShow(Sender: TObject);
var
  Ini: TMemIniFile; //необходимо создать объект, чтоб потом с ним работать
  Val : String;
begin
  inherited;

  //ставлю всем компонентам размеры и шрифты, на разных DPI по разному
  cbProfit.Style.Font.Size := 9;
  cbSales.Style.Font.Size := 9;
  cbOstatok.Style.Font.Size := 9;
  cbOstatokXML.Style.Font.Size := 9;

  Ini:=TMemIniFile.Create(extractfilepath(Application.ExeName)+'Settings.ini', TEncoding.UTF8);
  try
    Val := Ini.ReadString('ExportOperData', 'DataType', '0000');
    cbSales.Checked       := Copy(Val, 1, 1) = '1';
    cbOstatok.Checked     := Copy(Val, 2, 1) = '1';
    cbOstatokXML.Checked  := Copy(Val, 3, 1) = '1';
    cbProfit.Checked      := Copy(Val, 4, 1) = '1';

    cbTime.ItemIndex     := Ini.ReadInteger('ExportOperData', 'cbTime', 0);
    bedtFileName.Text    := Ini.ReadString('ExportOperData', 'ExportPath', '');
  finally
    Ini.Free;
  end;
end;

procedure TExportOperDataForm.cbSalesPropertiesChange(Sender: TObject);
begin
  if (Integer(cbSales.Checked) + Integer(cbOstatok.Checked) + Integer(cbOstatokXML.Checked) +
  Integer(cbProfit.Checked)) = 0 then
    cbTime.ItemIndex := 0;
end;

procedure TExportOperDataForm.bedtFileNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  Dir : String;
begin
  if SelectDirectory('Выберите папку', '', Dir) then
    bedtFileName.Text := IncludeTrailingPathDelimiter(Dir);
end;

end.
