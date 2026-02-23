unit frmFoldersSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, ActnList, dxExEdtr, dxCntner, ExtCtrls, StdCtrls, Buttons,
  dxEditor, dxEdLib, ComCtrls, dxDBEdtr, dxDBELib, DB, FIBDataSet,
  pFIBDataSet;

type
  TFoldersSetupForm = class(TDBEditForm)
    PageControl: TPageControl;
    tsFolders: TTabSheet;
    GroupBox1: TGroupBox;
    Shape17: TShape;
    Label1: TLabel;
    Shape18: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    edINGOING_OK: TdxButtonEdit;
    edINGOING_IN: TdxButtonEdit;
    edINGOING_ERR: TdxButtonEdit;
    edINGOING_ARCH: TdxButtonEdit;
    GroupBox2: TGroupBox;
    Shape7: TShape;
    Label5: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edOUTGOING_IN: TdxButtonEdit;
    edOUTGOING_OK: TdxButtonEdit;
    edOUTGOING_ERR: TdxButtonEdit;
    edOUTGOING_ARCH: TdxButtonEdit;
    tsParams: TTabSheet;
    GroupBox4: TGroupBox;
    Shape15: TShape;
    Label9: TLabel;
    Shape16: TShape;
    Shape19: TShape;
    Label10: TLabel;
    Shape20: TShape;
    edSENDER: TdxEdit;
    Shape21: TShape;
    Label11: TLabel;
    Shape22: TShape;
    edRECEIVER: TdxEdit;
    Shape23: TShape;
    Label12: TLabel;
    Shape24: TShape;
    spReadSender: TpFIBDataSet;
    TranReadSender: TpFIBTransaction;
    dsReadSender: TDataSource;
    Shape25: TShape;
    Label13: TLabel;
    Shape26: TShape;
    tranMT102: TpFIBTransaction;
    spMT102: TpFIBDataSet;
    dsMT102: TDataSource;
    edSENDER_STR: TdxLookupEdit;
    edMT102: TdxLookupEdit;
    dsReadReciever: TDataSource;
    spReadReciever: TpFIBDataSet;
    tranReadReciever: TpFIBTransaction;
    edRECEIVER_STR: TdxLookupEdit;
    GroupBox3: TGroupBox;
    Memo50: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure edINGOING_INValidate(Sender: TObject; var ErrorText: String;
      var Accept: Boolean);
    procedure edSENDER_STRChange(Sender: TObject);
    procedure edRECEIVER_STRChange(Sender: TObject);
  protected
    procedure GetData; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
    function CheckParams(var ErrControl: TWinControl): Boolean; override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FoldersSetupForm: TFoldersSetupForm;

implementation

uses frmDBDlg;

{$R *.dfm}
Procedure TFoldersSetupForm.GetData;
Begin
  Inherited;

  OpenSP(spMT102,False);
  OpenSP(spReadSender,False);
  OpenSP(spReadReciever,False);
  
  With spGetData Do Begin
     edINGOING_IN.Text := ParamByName('INGOING_IN').AsString;
     edINGOING_OK.Text := ParamByName('INGOING_OK').AsString;
     edINGOING_ERR.Text := ParamByName('INGOING_ERR').AsString;
     edINGOING_ARCH.Text := ParamByName('INGOING_ARCH').AsString;
     edOUTGOING_IN.Text := ParamByName('OUTGOING_IN').AsString;
     edOUTGOING_OK.Text := ParamByName('OUTGOING_OK').AsString;
     edOUTGOING_ERR.Text := ParamByName('OUTGOING_ERR').AsString;
     edOUTGOING_ARCH.Text := ParamByName('OUTGOING_ARCH').AsString;
     Memo50.Text := ParamByName('FIELD_50').AsString;
     edMT102.LookupKeyValue := StrToInt(ParamByName('MT102_FORMAT').AsString);
     edSENDER_STR.LookupKeyValue := StrToInt(ParamByName('SENDER').AsString);
     edSENDER.Text := ParamByName('SENDER_STR').AsString;
     edRECEIVER_STR.LookupKeyValue := StrToInt(ParamByName('RECEIVER').AsString);
     edRECEIVER.Text := ParamByName('RECEIVER_STR').AsString;
  End;

End;

function TFoldersSetupForm.CheckParams(var ErrControl: TWinControl): Boolean;
Begin
  Result :=True;
End;

Procedure TFoldersSetupForm.SetParams(SP: TpFIBStoredProc);
Begin
  inherited;
  With SP Do Begin
    ParamByName('INGOING_IN').AsString := edINGOING_IN.Text;
    ParamByName('INGOING_OK').AsString := edINGOING_OK.Text;
    ParamByName('INGOING_ERR').AsString := edINGOING_ERR.Text;
    ParamByName('INGOING_ARCH').AsString := edINGOING_ARCH.Text;
    ParamByName('OUTGOING_IN').AsString := edOUTGOING_IN.Text;
    ParamByName('OUTGOING_OK').AsString := edOUTGOING_OK.Text;
    ParamByName('OUTGOING_ERR').AsString := edOUTGOING_ERR.Text;
    ParamByName('OUTGOING_ARCH').AsString := edOUTGOING_ARCH.Text;
    ParamByName('FIELD_50').AsString := Memo50.Text;
    ParamByName('MT102_FORMAT').AsString := IntToStr(edMT102.LookupKeyValue);
    ParamByName('SENDER_STR').AsString := spReadSender.FieldByName('CRYPTO_CODE_KCMR').AsString; //edSENDER_STR.Text;
    ParamByName('SENDER').AsString := IntToStr(edSENDER_STR.LookupKeyValue);
    ParamByName('RECEIVER_STR').AsString := spReadReciever.FieldByName('CRYPTO_CODE_KCMR').AsString;
    ParamByName('RECEIVER').AsString := IntToStr(edRECEIVER_STR.LookupKeyValue);
  End;
End;

procedure TFoldersSetupForm.FormCreate(Sender: TObject);
begin
  OpenMode := omUpdate;
  KeyFieldIsStr := False;
  KeyField := 'CODE_';
  PageControl.ActivePageIndex := 0;
  inherited;

end;

procedure TFoldersSetupForm.edINGOING_INValidate(Sender: TObject;
  var ErrorText: String; var Accept: Boolean);
begin
  inherited;
  If Copy((Sender as TdxButtonEdit).Text, Length((Sender as TdxButtonEdit).Text),1) <> '\' Then
  Begin
     (Sender as TdxButtonEdit).Text := (Sender as TdxButtonEdit).Text + '\';
     (Sender as TdxButtonEdit).Modified := True;
  End;
  Accept := True;
end;

procedure TFoldersSetupForm.edSENDER_STRChange(Sender: TObject);
begin
  inherited;
  edSENDER.Text := spReadSender.FieldByName('CRYPTO_CODE_KCMR').AsString;
end;

procedure TFoldersSetupForm.edRECEIVER_STRChange(Sender: TObject);
begin
  inherited;
  edRECEIVER.Text := spReadReciever.FieldByName('CRYPTO_CODE_KCMR').AsString;
end;

end.
