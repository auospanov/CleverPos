unit frmUpdate1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxShellTreeView,
  cxShellListView;

type
  TUpdateForm1 = class(TForm)
    Timer: TTimer;
    mScript: TMemo;
    mLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
  public
    SuccessUpd : Boolean;
  end;

var
  UpdateForm1: TUpdateForm1;
type

  TConnectErrorCallbackFunc = function (AErrorMessage : PChar) : integer;  stdcall;
  TScriptErrorCallbackFunc = function (AStmtText, AErrMessage : PChar) : integer; stdcall;
  TScriptBeforeExecStatementFunc = function (AStmtText, AText : PChar) : integer; stdcall;
  TScriptAfterExecStatementFunc = function (AStmtText : PChar; Success : integer) : integer; stdcall;
  TScriptIBEBlockProgressFunc = function (AProgressMessage : PChar) : integer; stdcall;

  TExecuteScriptProc = procedure (AScriptFile : PChar;
                                  AErrorCallbackFunc : TScriptErrorCallbackFunc;
                                  ABeforeCallbackFunc : TScriptBeforeExecStatementFunc;
                                  AAfterCallbackFunc : TScriptAfterExecStatementFunc); stdcall;

  TExecuteScriptProc2 = procedure (AScriptFile : PChar;
                                  AErrorCallbackFunc : TScriptErrorCallbackFunc;
                                  ABeforeCallbackFunc : TScriptBeforeExecStatementFunc;
                                  AAfterCallbackFunc : TScriptAfterExecStatementFunc;
                                  AIBEBlockProgressFunc : TScriptIBEBlockProgressFunc); stdcall;

  TConnectDBProc = function (AConnectParams : PChar;
                             AConnectErrorCallbacFunc : TConnectErrorCallbackFunc) : integer; stdcall;


function HandleError(AStmtText, AErrMessage : PChar) : integer; stdcall;
function BeforeExec(AStmtText, AText : PChar) : integer; stdcall;
function AfterExec(AStmtText : PChar; Success : integer) : integer; stdcall;
function CEH(AErrorMessage : PChar) : integer;  stdcall;

implementation

uses frmMain;

{$R *.DFM}

function HandleError(AStmtText, AErrMessage : PChar) : integer; stdcall;
begin
  Result := 0;
  UpdateForm1.mLog.Lines.Add('------- STATEMENT --------');
  UpdateForm1.mLog.Lines.Add(AStmtText);
  UpdateForm1.mLog.Lines.Add('-------   ERROR   --------');
  UpdateForm1.mLog.Lines.Add(AErrMessage);
end;

function BeforeExec(AStmtText, AText : PChar) : integer; stdcall;
begin
  Result := 0;
  UpdateForm1.mLog.Lines.Add(AText);
end;

function AfterExec(AStmtText : PChar; Success : integer) : integer; stdcall;
begin
  Result := 0;
  if Success = 1 then begin
    UpdateForm1.mLog.Lines.Add('Altering successfull...');
    UpdateForm1.SuccessUpd := True;
  end else begin
    Result := 1; // Abort script execution
    UpdateForm1.SuccessUpd := False;
  end;
end;

function CEH(AErrorMessage : PChar) : integer;  stdcall;
begin
  ShowMessage(AErrorMessage);
end;

procedure TUpdateForm1.FormCreate(Sender: TObject);
begin
  SuccessUpd := False;
end;

procedure TUpdateForm1.FormShow(Sender: TObject);
begin
  Timer.Enabled := True;
end;

procedure TUpdateForm1.TimerTimer(Sender: TObject);
var
  Hndl : THandle;
  ESP : TExecuteScriptProc;
  CP : TConnectDBProc;
  FileName : String;
  s : string;
  Res : integer;
begin
  Timer.Enabled := False;

  mLog.Lines.Clear;
  GetDir(0, FileName);
  FileName := FileName + '\Shopuchet.gdb';
  s := mScript.Text;

  if Trim(s) = '' then
  begin
    ShowMessage('Nothing to do!');
    Exit;
  end;

  try
    Hndl := LoadLibrary(PChar('IBEScript.dll'));
    if (Hndl > HINSTANCE_ERROR) then
    begin
      ESP := GetProcAddress(Hndl, 'ExecScriptText');
      CP := GetProcAddress(Hndl, 'Connect');
      if (@ESP <> nil) and (@CP <> nil) then
      begin
       Pages.ActivePage := tsOutput;
       Res := CP(PChar('db_name=localhost:'+ FileName + '; password=osjadf09; user_name=AIDYN;'+
                       'lc_ctype=win1251; sql_role_name=ADMIN; sql_dialect=3;' +
                       'clientlib="fbclient.dll"'), @CEH);
       if Res = 0 then
         ESP(PChar(s), @HandleError, @BeforeExec, @AfterExec);
      end;
    end;
  finally
    if Hndl > HINSTANCE_ERROR then
      FreeLibrary(Hndl);
  end;

  IF SuccessUpd then BEGIN
    UpdateForm1.mLog.Lines.Add('------- намнбкемхе гюбепьемн сяоеьмн --------');
    Sleep(100);
    Close;
  END;
end;

end.
