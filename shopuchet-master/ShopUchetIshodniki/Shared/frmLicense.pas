unit frmLicense;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, dxExEdtr, dxCntner, ExtCtrls, StdCtrls, Buttons, unCommonFunc,
  dxEditor, dxEdLib, AppEvnts, UnSupport, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME, cxPC, cxControls, Registry;

type
  TLicenseForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    edControlNum: TEdit;
    Label3: TLabel;
    odlg: TOpenDialog;
    SaveDialog: TSaveDialog;
    IdEncoderMIME1: TIdEncoderMIME;
    pcKey: TcxPageControl;
    tsLoad: TcxTabSheet;
    tsPath: TcxTabSheet;
    lb1: TLabel;
    bedtFileName: TdxButtonEdit;
    sh1: TShape;
    lb2: TLabel;
    sh2: TShape;
    btnLoadLicense: TButton;
    dlgOpen1: TOpenDialog;
    procedure btnLoadLicenseClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure bedtFileNameButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure pcKeyChange(Sender: TObject);
    procedure SaveKeyPath(Filename : string);
  private
    function CheckKey(Filename : string) : boolean;
  public
    { Public declarations }
  protected
    procedure GetData; override;
  end;

var
  LicenseForm: TLicenseForm;

implementation

uses
  unInitApp;

{$R *.dfm}

procedure TLicenseForm.GetData;
begin
  if NUM = 1 then begin
    Label3.Caption := 'Программа успешно зарегистрирована.';
    Label3.Font.Color := clNavy;
    edControlNum.Enabled := False;
    edControlNum.Clear;
    btnLoadLicense.Enabled := False;
  end else begin
    Label3.Font.Color := clRed;
    edControlNum.Text := ZNUM;
    edControlNum.ReadOnly := True;
    edControlNum.Font.Color := clGrayText;
  end;
  bedtFileName.Text := LicenseKeyPath;
end;

procedure TLicenseForm.btnLoadLicenseClick(Sender: TObject);
var FileName, FileName1 : String;
begin
  FileName1 := ExtractFilePath(Application.exename) + 'License.dat';
  IF FileExists(FileName1) then begin
    MessageDlg('В папке с приложением Shopuchet уже есть лицензионный ключ.' + #13#10 + 'Закройте приложение и удалите его, прежде чем загружать новый.', mtInformation, [mbOK], 0);
    NUM := 0;
    Exit;
  End;

  if odlg.Execute then begin
    FileName := odlg.FileName;
    if CheckKey(FileName) then begin
      NUM := 1;
      MoveFile(pChar(FileName), pchar(FileName1));
      SaveKeyPath(FileName1);
      GetData;
    end;
  end;
end;

procedure TLicenseForm.bedtFileNameButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
var
  FileName : string;
begin
  if odlg.Execute then begin
    bedtFileName.Text := odlg.FileName;
    if not FileExists(bedtFileName.Text) then begin
      MessageDlg('Недоступен файл по данному пути!', mtError, [mbOK], 0);
      bedtFileName.SetFocus;
      Exit;
    end;

    FileName := bedtFileName.Text;
    if CheckKey(FileName) then begin
      NUM := 1;
      SaveKeyPath(FileName);
      GetData;
    end;
  end
end;

procedure TLicenseForm.btHelpClick(Sender: TObject);
begin
  Helpc := 64;
  inherited;
end;

function TLicenseForm.CheckKey(Filename: string) : boolean;
var
    s,s1,s2 : string;
    _ecx,_eax,_edx, _ebx : longword;
    i: integer;
    F: TextFile;
    V, FileS, ZNACH: String;
begin
  Result := false;

  ZNACH := UDDDigestToStr(UDDString(ZNUM));
  ZNACH := UDDDigestToStr(UDDString(ZNACH));
  ZNACH := IdEncoderMIME1.Encode(ZNACH);
  ZNACH := UDDDigestToStr(UDDString(ZNACH));

  FileS := FileName;
  AssignFile(F, FileS);
  Reset(F);
  Readln(F, V);
  CloseFile(F);

  if ZNACH <> V then begin
    NUM := 0;
    MessageDlg('Выбранный Вами ключ не подходит. Выберите другой!', mtWarning, [mbOK], 0);
    Exit;
  end;

  Result := true;
end;

procedure TLicenseForm.pcKeyChange(Sender: TObject);
begin
  inherited;
  if pcKey.ActivePage = tsPath then
    bedtFileName.SetFocus;
end;

procedure TLicenseForm.SaveKeyPath(Filename: string);
var
  Reg: TRegistry;
begin
  try
    Reg := TRegistry.Create;
    try
      with Reg do begin
        RootKey := RegSetupRoot;
        LazyWrite := False;  {Сохраняем ключи до закрытия}
        if OpenKey(RegSetupKey, True) then
          try
            WriteString('LicenseKeyPath', Filename);
            LicenseKeyPath := Filename;
          finally
            CloseKey;
          end;
      end;
    finally
      Reg.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TLicenseForm.SaveKeyPath)', mtError, [mbOk], 0);
  end;
end;

end.
