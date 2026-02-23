unit frmLogonDialog;

{$I ShopUchet.inc}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, IniFiles, Dialogs, Registry, System.UITypes;

type
  TLogonDlgForm = class(TForm)
    Panel1: TPanel;
    ServerLabel: TLabel;
    edDBName: TEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Bevel1: TBevel;
    btnDBName: TBitBtn;
    Panel2: TPanel;
    UserNameLabel: TLabel;
    PasswordLabel: TLabel;
    edUserName: TEdit;
    edPassword: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnDBNameClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FIsRemoteEngine: Boolean;
    FServerName: String;
    FDBName  : String;
    FUserName: String;
    FPassword: String;
    procedure LoadLastValues;
    procedure SaveLastValues;
    function GetServerAndDBName(DBPath: String; var ServerName_, DBName_: String): Boolean;
  public
    property IsRemoteEngine: Boolean read FIsRemoteEngine;
    property ServerName: String read FServerName;
    property DBName  : String read FDBName;
    property UserName: String read FUserName;
    property Password: String read FPassword;
  end;

var
  LogonDlgForm: TLogonDlgForm;

implementation

uses unInitApp, frmSelectDB, unCommonFunc;

{$R *.DFM}

procedure TLogonDlgForm.FormShow(Sender: TObject);
begin
  LoadLastValues;

  if edDBName.Text <> '' then begin
    if edUserName.Text <> '' then
      edPassword.SetFocus
    else
      edUserName.SetFocus;
  end
  else BEGIN
    edDBName.Text := ExtractFilePath(Application.exename) + DataBaseName;
    edDBName.SetFocus;
    FDBName := edDBName.Text;
  END;
end;

procedure TLogonDlgForm.LoadLastValues;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    with Reg do begin
      RootKey := RegSetupRoot;
      LazyWrite := True;  {Сохраняем ключи после закрытия}
      if OpenKey(RegConnectKey, True) then
        try
          if not ValueExists('ProductName') then
            WriteString('ProductName', ProductName + ' - ' + AppName);
          {----------------------------}
          if ValueExists('IsRemoteEngine') then
            FIsRemoteEngine := ReadBool('IsRemoteEngine');
          if ValueExists('ServerName') then
            FServerName := ReadString('ServerName');
          if ValueExists('DBName') then
            FDBName := ReadString('DBName');
          if ValueExists('UserName') then
            FUserName := ReadString('UserName');

          if FIsRemoteEngine then begin
            if (FServerName <> '') and (FDBName <> '') then
              edDBName.Text := FServerName + ':' + FDBName
            else
              edDBName.Text := FDBName;
          end
          else
            edDBName.Text := FDBName;

          edUserName.Text := FUserName;
        finally
          CloseKey;
        end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TLogonDlgForm.SaveLastValues;
var
  Reg   : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    with Reg do begin
      RootKey := RegSetupRoot;
      LazyWrite := False;  {Сохраняем ключи до закрытия}
      if OpenKey(RegConnectKey, True) then begin
        try
          WriteBool('IsRemoteEngine', FIsRemoteEngine);
          WriteString('ServerName', FServerName);
          WriteString('DBName', FDBName);
          WriteString('UserName', FUserName);
        finally
          Reg.CloseKey;
        end;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TLogonDlgForm.btnDBNameClick(Sender: TObject);
var
  SelectDBForm: TSelectDBForm;
begin
  SelectDBForm := TSelectDBForm.Create(Application);

  try
    SelectDBForm.IsRemoteEngine := FIsRemoteEngine;
    SelectDBForm.ServerName := FServerName;
    SelectDBForm.DBName := FDBName;
    if SelectDBForm.ShowModal = mrOk then begin
      FIsRemoteEngine := SelectDBForm.IsRemoteEngine;
      FServerName := SelectDBForm.ServerName;
      FDBName := SelectDBForm.DBName;
      if FIsRemoteEngine then
        edDBName.Text := FServerName + ':' + FDBName
      else
        edDBName.Text := FDBName;
    end;
  finally
    SelectDBForm.Free;
  end;
end;

function TLogonDlgForm.GetServerAndDBName(DBPath: String; var ServerName_,
  DBName_: String): Boolean;
  {Разбирает путь к БД в формате TCP/IP: ServerName:LocalPath}
var
  P1, P2: Integer;
begin
  Result := True;

  P1 := Pos(':', DBPath);
  if P1 = 0 then begin {Локальный путь}
    ServerName_ := '';
    DBName_ := DBPath;
    Exit;
  end;

  P2 := PosFrom(':', DBPath, P1 + 1);
  if P2 = 0 then begin {Локальный путь}
    ServerName_ := '';
    DBName_ := DBPath;
    Exit;
  end;

  ServerName_ := Copy(DBPath, 1, P1 - 1);
  DBName_ := Copy(DBPath, P1 + 1, Length(DBPath) - P1);

  if (ServerName_ = '') or (DBName_ = '') then
    Result := False;
end;

procedure TLogonDlgForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  DBNameChanged: Boolean;
begin
  if ModalResult <> mrOk then
    Exit;

  CanClose := False;

  IF ((FDBName = '') or (FDBName[Length(FDBName)] in [':', '\'])) then BEGIN
    MessageDlg('База данных не указана', mtInformation, [mbOk], 0);
    edDBName.SetFocus;
    Exit;
  END;
  
  if FIsRemoteEngine then
    DBNameChanged := edDBName.Text <> FServerName + ':' + FDBName
  else
    DBNameChanged := edDBName.Text <> FDBName;

  if DBNameChanged then
    if GetServerAndDBName(edDBName.Text, FServerName, FDBName) then begin
      if FServerName = '' then
        FIsRemoteEngine := False
      else
        FIsRemoteEngine := True;
    end
    else begin
      FServerName := '';
      FIsRemoteEngine := False;
      FDBName := edDBName.Text;
    end;

  FUserName := 'AIDYN';
  FPassword := 'osjadf09';

  if FUserName = '' then begin
    MessageDlg('Имя пользователя не введено', mtInformation, [mbOk], 0);
    edUserName.SetFocus;
    Exit;
  end;

  if FPassword = '' then begin
    MessageDlg('Пароль не введен', mtInformation, [mbOk], 0);
    edPassword.SetFocus;
    Exit;
  end;

  SaveLastValues;

  CanClose := True;
end;

end.

