unit uNews;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, System.IniFiles, UnNews,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  Vcl.StdCtrls, cxButtons, Math, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, idGlobal;

type
  TFrmNews = class(TForm)
    btn1: TcxButton;
    pmn1: TPopupMenu;
    mSkipWeek: TMenuItem;
    mSkipMonth: TMenuItem;
    mSkip: TMenuItem;
    msUpdate: TMenuItem;
    mUpdate: TMenuItem;
    mmo1: TMemo;
    msSkipWeek: TMenuItem;
    msSkipMonth: TMenuItem;
    procedure mUpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure mSkipWeekClick(Sender: TObject);
    procedure mSkipMonthClick(Sender: TObject);
    procedure mSkipClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mUpdateDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure mUpdateMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width,
      Height: Integer);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmNews: TFrmNews;
  CurFont: TFont;

implementation

uses
  unCommonFunc;

{$R *.dfm}


procedure TFrmNews.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(CurFont);
  Action := caFree;
end;

procedure TFrmNews.FormCreate(Sender: TObject);
begin
  try
    CurFont := TFont.Create;
    with CurFont do
    begin
      Assign(Font);
      Name := 'Arial';
      Size := 14;
      Color := clBlack;
    end;
  except
    on E: Exception do
      log('[Новости] - Ошибка при получении новостей. Детали: ' + e.Message);
  end;
end;

procedure TFrmNews.FormDestroy(Sender: TObject);
begin
  FrmNews := nil;
end;

procedure TFrmNews.mSkipWeekClick(Sender: TObject);
var
  ini: TMemIniFile;
begin
  try
    try
      ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + '\NEWS.ini', TEncoding.UTF8);
      ini.WriteDate('NEWS', 'HOLD_OVER', Date + 7);
      ini.WriteBool('NEWS', 'SKIP', True);
      ini.UpdateFile;
    except
      on E: Exception do
        log('[Новости] - Ошибка при записи файла. Детали: ' + e.Message);
    end;
  finally
    FreeAndNil(ini);
  end;
  Close;
end;

procedure TFrmNews.mSkipMonthClick(Sender: TObject);
var
  ini: TMemIniFile;
begin
  try
    try
      ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + '\NEWS.ini', TEncoding.UTF8);
      ini.WriteDate('NEWS', 'HOLD_OVER', IncMonth(Date));
      ini.WriteBool('NEWS', 'SKIP', True);
      ini.UpdateFile;
    except
      on E: Exception do
        log('[Новости] - Ошибка при записи файла. Детали: ' + e.Message);
    end;
  finally
    FreeAndNil(ini);
  end;
  Close;
end;

procedure TFrmNews.mSkipClick(Sender: TObject);
var
  ini: TMemIniFile;
begin
  try
    try
      ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + '\NEWS.ini', TEncoding.UTF8);
      ini.WriteDate('NEWS', 'HOLD_OVER', Date - 1);
      ini.WriteBool('NEWS', 'SKIP', True);
      ini.UpdateFile;
    except
      on E: Exception do
        log('[Новости] - Ошибка при записи файла. Детали: ' + e.Message);
    end;
  finally
    FreeAndNil(ini);
  end;
  Close;
end;

procedure TFrmNews.mUpdateClick(Sender: TObject);
var
  IdHTTP1: TIdHTTP;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  SetupStream: TMemoryStream;
  ini: TMemIniFile;
  LINK: string;
begin
  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    try
      //Создаем компоненты для https запросов
      try
        IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        with IdSSLIOHandlerSocketOpenSSL1 do
        begin
          SSLOptions.Method := sslvTLSv1;  //sslvSSLv23
          SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
          SSLOptions.Mode := sslmClient;
          SSLOptions.VerifyMode := [];
          SSLOptions.VerifyDepth := 0;
        end;
      except
        on E: Exception do
          log('[Новости] - Ошибка при создании OpenSSL с сообщением: ' + e.Message);
      end;
      try
        IdHTTP1 := TIdHTTP.Create(nil);
        with IdHTTP1 do
        begin
          IOHandler := IdSSLIOHandlerSocketOpenSSL1;
          AllowCookies := True;
          HandleRedirects := true;
          ProxyParams.BasicAuthentication := false;
          ProxyParams.ProxyPort := 0;
          Request.CharSet := 'utf-8';
          Request.ContentType := 'application/json';
          Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
          Request.BasicAuthentication := False;
          Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
          Request.Ranges.Units := 'bytes';
          HTTPOptions := [];
          IOHandler.DefStringEncoding := enUTF8;
        end;
      except
        on E: Exception do
          log('[Новости] - Ошибка при создании TIdHTTP с сообщением: ' + e.Message);
      end;
      try
        ini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + '\NEWS_tmp.ini', TEncoding.UTF8);
        LINK := ini.ReadString('NEWS', 'LINK', '');
      finally
        FreeAndNil(ini);
      end;
      if FileExists(GetTempWindows + 'setup.exe') then
        DeleteFile(GetTempWindows + 'setup.exe');
      SetupStream := TMemoryStream.Create;
      IdHTTP1.Get(LINK, SetupStream);
      SetupStream.SaveToFile(GetTempWindows + 'setup.exe');
    except
      on E: Exception do
        log('[Обновление] - Ошибка при обновлении. Детали: ' + e.Message);
    end;
  finally
    FreeAndNil(IdHTTP1);
    FreeAndNil(IdSSLIOHandlerSocketOpenSSL1);
    FreeAndNil(SetupStream);
    Self.Cursor := crDefault;
  end;
  StartUpdated := True;
  UpdatePo(GetTempWindows + 'setup.exe');
  Close;
end;

procedure TFrmNews.mUpdateDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  item : TMenuItem;
begin
  item := Sender as TMenuItem;
  ACanvas.Font.Assign(CurFont);

  ACanvas.Font.Color := IfThen(Selected, clHighlightText, clMenuText);
  ACanvas.Brush.Color := IfThen(Selected, clHighlight, clMenu);
  ACanvas.FillRect(ARect);

  DrawText(ACanvas.Handle, PChar(item.Caption), Length(item.Caption),
    ARect, DT_LEFT);
end;

procedure TFrmNews.mUpdateMeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
begin
  Canvas.Font.Assign(CurFont);
  Width := btn1.Width - 20;
  Height := Canvas.TextHeight(TMenuItem(Sender).Caption) + 4;
end;

end.
