unit frmSendLogs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, ZipForge, Vcl.Menus, Vcl.StdCtrls, cxButtons, IdMessage,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  idAttachment, IdAttachmentFile, JvComponentBase, JvThread,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, cxMemo,
  Vcl.ExtCtrls;

type
  TSendLogsForm = class(TForm)
    edtDatStart: TcxDateEdit;
    edtDateEnd: TcxDateEdit;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    cxlbl3: TcxLabel;
    btnSend: TcxButton;
    btnClose: TcxButton;
    JvThread1: TJvThread;
    mmo1: TcxMemo;
    pnl1: TPanel;
    pnl2: TPanel;
    procedure btnSendClick(Sender: TObject);
    procedure JvThread1Execute(Sender: TObject; Params: Pointer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    err: string;
    FZip: TZipForge;
    const
      MailFrom: string = 'shopuchet.logs@mail.ru';
      MailTo: string = 'Info@shopuchet.kz';

    function AddZipFile(FileName, FileNameZip: string): string;
    function SearchFile(Path: string): string;
    function SendMail(FileNameZip: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SendLogsForm: TSendLogsForm;

implementation

uses
  dmReports;

{$R *.dfm}

procedure TSendLogsForm.btnSendClick(Sender: TObject);
begin
  err := '';
  JvThread1.Execute(nil);
  while JvThread1.Terminated = false do Application.ProcessMessages;
  if err = '' then
    ShowMessage('Логи программы успешно отправлены.')
  else
    ShowMessage(err);
end;

procedure TSendLogsForm.FormCreate(Sender: TObject);
begin
  edtDatStart.EditValue := Now;
  edtDateEnd.EditValue := Now;
end;

procedure TSendLogsForm.FormShow(Sender: TObject);
begin
  mmo1.InnerControl.Perform(EM_LINESCROLL, 0, mmo1.Lines.Count);
end;

function TSendLogsForm.AddZipFile(FileName, FileNameZip: string): string;
begin
  try
    Result := '';
    try
      if (Length(FileName) > 0) then
        FZip.AddFiles(FileName);
    except
      on e: Exception do
        Result := e.ClassName + ' ' + e.Message;
    end;
  finally
    err := Result;
  end;
end;

function TSendLogsForm.SearchFile(Path: string): string;
var
  SR: TSearchRec;
  s: string;
  DAT_START: TDate;
begin
  Result := '';
  try
    DAT_START := edtDatStart.Date;
    try
      FZip := TZipForge.Create(nil);
      FZip.FileName := Path + 'Zip.rar';
      FZip.OpenArchive(fmCreate);
      while true do
      begin
        if DAT_START > edtDateEnd.Date then
          Break;
        s := FormatDateTime('yyyymmdd', DAT_START);
        if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
        begin
          repeat
            if (SR.Attr <> faDirectory) then
            begin
              if Pos(s, SR.Name)<>0 then
              begin
                AddZipFile(Path + sr.Name, Path + 'Zip.rar');
              end;
            end;
          until FindNext(SR) <> 0;
          FindClose(SR);
        end;
        DAT_START := DAT_START + 1;
      end;
      FZip.CloseArchive;

      if not (FileExists(Path + 'Zip.rar')) then
      begin
        Result := ('Невозможно создать архив для отправки!' + #13#10 +
               'Запустите приложение от имени Администратора.');
        Exit;
      end;
    except
      on e: Exception do
        Result := e.ClassName + ' ' + e.Message;
    end;
  finally
    err := Result;
    FreeAndNil(FZip);
  end;
end;

function TSendLogsForm.SendMail(FileNameZip: string): string;
var
  attach: TidAttachment;
  attach2: TidAttachment;
  msg: TIdMessage;
  att: TIdAttachmentFile;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  IdMess: TIdMessage;
  IdSMTP: TIdSMTP;
begin
  Result := '';
  try
    try
      with ReportsDM do
      begin
        spRekvizit.Close;
        spRekvizit.Open;
        IdMess := TIdMessage.Create;
        IdMess.From.Address := MailFrom; // адрес первого ящика
        IdMess.Recipients.EMailAddresses := MailTo; // адрес второго ящика на который прейдет письмо
        IdMess.Subject := UTF8Encode('234');
        IdMess.Subject := AnsiString(spRekvizit.FieldByName('NAME').AsWideString);// тема письма
        IdMess.Date := Now;
        spRekvizit.Close;
      end;

      //настройка компонентов перед отправкой
      IdSMTP:= TIdSMTP.Create(nil);

      IdSMTP.Host := 'smtp.mail.ru';
      IdSMTP.Port := 465; // обычно при использование ssl 495, 587 или стандартный 25
      IdSMTP.Username := MailFrom;// адрес первого ящика
      IdSMTP.Password := 'T0RVbvtLztndFdRjwr91'; //пароль от первого ящика с которого шлём письмо
      IdSMTP.AuthType := satDefault;

      //это необходимо использовать для SSL
      IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      IdSSL.Destination := IdSMTP.Host + ':' + IntToStr(IdSMTP.Port);
      IdSSL.Host := IdSMTP.Host;
      IdSSL.Port := IdSMTP.Port;
      IdSSL.DefaultPort := 0;
      IdSSL.SSLOptions.Method := sslvTLSv1;
      IdSSL.SSLOptions.Mode := sslmUnassigned;
      IdSMTP.IOHandler := IdSSL;
      IdSMTP.UseTLS := utUseImplicitTLS;
    except
      on e: Exception do
        Result := e.ClassName + ' ' + e.Message;
    end;

    if FileExists(FileNameZip) then
    begin
      try
        IdMess.IsEncoded:=true;
        att := TIdAttachmentfile.Create(IdMess.MessageParts, FileNameZip);
        //отправляем письмо
        IdSMTP.Connect();
        if IdSMTP.Connected then
        begin
          IdSMTP.Send(IdMess);
          Application.ProcessMessages;
          IdSMTP.Disconnect;
        end;
      except
        on e: Exception do
          Result := e.ClassName + ' ' + e.Message;
      end;
    end;
  finally
    err := Result;
    FreeAndNil(IdMess);
    FreeAndNil(IdSSL);
    FreeAndNil(IdSMTP);
  end;
end;

procedure TSendLogsForm.JvThread1Execute(Sender: TObject; Params: Pointer);
begin
  Screen.Cursor := crHourGlass;
  try
    if DirectoryExists(ExtractFilePath(Application.ExeName) + 'Log\') then
    begin
      if FileExists(ExtractFilePath(Application.ExeName) + 'Log\Zip.rar') then
        DeleteFile(ExtractFilePath(Application.ExeName) + 'Log\Zip.rar');
      SearchFile(ExtractFilePath(Application.ExeName) + 'Log\');
    end;
    SendMail(ExtractFilePath(Application.ExeName) + 'Log\Zip.rar');
  finally
    Screen.Cursor := crDefault;;
  end;
end;

end.
