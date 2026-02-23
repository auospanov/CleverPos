unit unInitApp;

{$I ShopUchet.inc}

interface

uses Windows, Forms, Sysutils;

const
  ProductName = 'ShopUchet';
  //AppName = 'ShopUchet';
  AppTitle = 'Учет магазина';
  AppId = 3;
  DefaultAliasName = 'ShopUchet';
  DataBaseName  = 'SHOPUCHET.FDB';
  DataBaseEtalonName  = 'SHOPUCHET_ETALON.FDB';

  RegSetupRoot = HKEY_CURRENT_USER;
  RegAppKey = '\Software\ShopUchet\';
  RegSetupKey = RegAppKey + '\Shopuchet\Setup';
  RegConnectKey = RegAppKey + '\Connect';
  RegReportKey = RegAppKey + '\Report';
  RegDialogKey = RegAppKey + '\Dialog';
  RegParserKey = RegAppKey + '\Parser';
  RegManagerKey = RegAppKey + '\Manager';

  {$IFDEF AUTOLOGON}
  AutoLogonPassword = 'masterkey';
  {$ENDIF AUTOLOGON}
var
  CurrAppVers: Integer;

procedure InitializeApp;

implementation

uses unFileInfo;

procedure InitializeApp;
var LocalInfo : unFileInfo.TFixedFileInfo;
begin
  {Запрещаем изменять форматы (даты, времени) при изменении настроек Windows}
  Application.UpdateFormatSettings := False;

  {Устанавливаем разделитель дат, времени и их формат}
  FormatSettings.DateSeparator := '.';
  FormatSettings.ShortDateFormat := 'dd.mm.yyyy';
  FormatSettings.LongDateFormat := 'd mmmm yyyy г';

  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortTimeFormat := 'hh:nn:ss';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

  {Устанавливаем разделители чисел}
  FormatSettings.ThousandSeparator := ' ';
  FormatSettings.DecimalSeparator  := '.';
  {Устанавливаем формат валюты}
  FormatSettings.CurrencyDecimals  := 2;

  // считаваю текущую версию екзешника
  LocalInfo  := unFileInfo.FileInfo(Application.ExeName);
  CurrAppVers := StrToInt(IntToStr(LocalInfo.wFileVersionLS) + IntToStr(LocalInfo.wFileVersionMS) + IntToStr(LocalInfo.wProductVersionLS) + IntToStr(LocalInfo.wProductVersionMS));
end;

end.
