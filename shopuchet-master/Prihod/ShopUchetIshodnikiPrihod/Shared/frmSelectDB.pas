unit frmSelectDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, System.UITypes;

type
  TSelectDBForm = class(TForm)
    Panel1: TPanel;
    edDBName: TEdit;
    Bevel1: TBevel;
    btnDBName: TBitBtn;
    rbLocalEngine: TRadioButton;
    rbRemoteEngine: TRadioButton;
    Bevel2: TBevel;
    edServerName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    dlgOpen: TOpenDialog;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnDBNameClick(Sender: TObject);
    procedure rbLocalEngineClick(Sender: TObject);
    procedure rbRemoteEngineClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FIsRemoteEngine: Boolean;
    FServerName: String;
    FDBName: String;
  public
    property IsRemoteEngine: Boolean read FIsRemoteEngine write FIsRemoteEngine;
    property ServerName: String read FServerName write FServerName;
    property DBName: String read FDBName write FDBName;
  end;

implementation

{$R *.DFM}

procedure TSelectDBForm.FormShow(Sender: TObject);
begin
  if FIsRemoteEngine then begin
    rbRemoteEngine.Checked := True;
    edServerName.Enabled := True;
    edServerName.Color := clWindow;
    edServerName.Text := FServerName;
  end
  else begin
    rbLocalEngine.Checked := True;
    edServerName.Enabled := False;
    edServerName.Color := clBtnFace;
    edServerName.Text := '';
  end;
  edDBName.Text := FDBName;
end;

procedure TSelectDBForm.rbLocalEngineClick(Sender: TObject);
begin
  FIsRemoteEngine := False;
  edServerName.Enabled := False;
  edServerName.Color := clBtnFace;
  edServerName.Text := '';
end;

procedure TSelectDBForm.rbRemoteEngineClick(Sender: TObject);
begin
  FIsRemoteEngine := True;
  edServerName.Enabled := True;
  edServerName.Color := clWindow;
end;

procedure TSelectDBForm.btnDBNameClick(Sender: TObject);
begin
//  dlgOpen.FileName := FDBName;
  if dlgOpen.Execute then
    edDBName.Text := dlgOpen.FileName;
end;

procedure TSelectDBForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult <> mrOk then
    Exit;

  CanClose := False;

  if rbRemoteEngine.Checked and (edServerName.Text = '') then begin
    MessageDlg('Не указано имя сервера', mtInformation, [mbOK], 0);
    edServerName.SetFocus;
    Exit;
  end;

  if edDBName.Text = '' then begin
    MessageDlg('Не указано имя базы данных', mtInformation, [mbOK], 0);
    edDBName.SetFocus;
    Exit;
  end;

  FServerName := edServerName.Text;
  FDBName := edDBName.Text;

  CanClose := True;
end;

end.
