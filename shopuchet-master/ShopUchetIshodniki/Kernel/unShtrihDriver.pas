unit unShtrihDriver;

interface

uses
  // VCL
  Classes, SysUtils, Forms, ActiveX, ComObj,
  // This
  DrvFRLib_TLB, System.UITypes, System.Variants;

type
  TShtrihDriver = class
  protected
    FDriver : Variant;
    const
      OperationRegisterMin = $00;
      OperationRegisterMax = $FF;
  public
    constructor Create;
    destructor Destroy;

    //function DriverExists: Boolean;
    function Connect(PortNumber : Integer; BaudRate : integer; IsFrConnectedAnotherComp : integer; IpFrConnectAnotherComp : String) : String;
    function DisConnect : String;
    function XReport : String;
    function ZReport : String;
    function OpenSession() : String;
    function CashIn( sum: real=0) : String;
    function CashOUT(sum: real=0) : String;
    function Discount(MaxSumm: Currency; Tovar: string): string;
    function Payment(GoodsName:string; Quantity:double; Price:double; DiscountSum : Double;
    NDS: Integer;
      Department: integer = 0; DataMatrix : string = ''; CutMarkCode : Integer = 0) : String;  //нет пересносв
    function ReturnGoods(GoodsName:string; Quantity:double; Price:double; NDS: Integer; Department: integer = 0;
      DataMatrix : string = ''; CutMarkCode : Integer = 0) : String;  //нет пересносв
    function CloseCheckSumm(SummCash, SummNonCash, SumAll :double; Discount : Double;
      Bonus, BonusD, TotalBonus: Double; Txt : String = ''; Idn : String = '') : String;   //закрыть чек с суммой
    function GetConnectionStatus:boolean;
    function GetDeviceName(out str : string) : boolean;
    function GetResult : string;
    function GetResultCode : integer;
    function GetResultDescription : string;
    function CancelCheckIf : string;
    function CancelCheck : string;

    function GetTicketNum: string;
  end;

implementation

uses
  Windows;

constructor TShtrihDriver.Create;
resourcestring
  SDriverCreateFailed = 'Ошибка создания объекта драйвера: ';
begin
  {if FDriver = nil then
  try
    FDriver := TDrvFR.Create(nil);
  except
    on E: Exception do
    begin
      E.Message := SDriverCreateFailed + E.Message + '. Возможно не установлен драйвер Штрих-М.';
      raise;
    end;
  end;}
  CoInitialize(nil);
  inherited Create;

  if VarIsEmpty(FDriver) then begin
    try
      FDriver := CreateOLEObject('AddIn.Drvfr');
    except
      on E: exception do
        raise exception.Create('Ошибка создания объекта драйвера ККМ Штрих-М: ' + E.Message +
        '. Возможно не установлен драйвер ККМ Штрих-М.');
    end;
  end;
end;

destructor TShtrihDriver.Destroy;
begin
  //FDriver.Free;
  if not VarIsEmpty(FDriver) then
    FDriver := 0;

  inherited Destroy;
  CoUninitialize;
end;

function TShtrihDriver.DisConnect: String;
begin
  if FDriver.Disconnect <> 0 then
    result := GetResult;
end;

{function TShtrihDriver.DriverExists: Boolean;
begin
  Result := FDriver <> nil;
end; }

function TShtrihDriver.GetConnectionStatus: boolean;
begin
  if FDriver.CheckConnection = 0 then
    Result := True
  else
    Result := False;
end;

function TShtrihDriver.GetDeviceName(out str : string) : boolean;
begin
  if FDriver.GetDeviceMetrics <> 0 then begin
    str := GetResult;
    result := false;
  end else begin
    str := FDriver.UDescription;
    result := true;
  end;
end;

function TShtrihDriver.GetResult: string;
var s : Integer;
begin
  s := GetResultCode;
  result := 'Ошибка фиск. регистратора. Код ' + IntToStr(s) + '. ' + GetResultDescription;

  // не поддерживается в данном режиме - покажу, что за режим
  if s = 115 then
    result := Result + ': "' + FDriver.ECRModeDescription + '".';
end;

function TShtrihDriver.GetResultCode: integer;
begin
  result := FDriver.ResultCode;
end;

function TShtrihDriver.GetResultDescription: string;
begin
  result := FDriver.ResultCodeDescription;
end;

function TShtrihDriver.OpenSession: String;
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  if FDriver.OpenSession <> 0 then
    Result := GetResult;

  Screen.Cursor := crDefault;
end;

function TShtrihDriver.Discount(MaxSumm: Currency; Tovar: string): string;
begin
  Result := '';
  if MaxSumm>0 then
  begin
    FDriver.Tax1 := 0;
    FDriver.Tax2 := 0;
    FDriver.Tax3 := 0;
    FDriver.Tax4 := 0;
    FDriver.Summ1 := MaxSumm;
    Tovar := Trim(Tovar);
    if Length(Tovar)>38 then
      Tovar := Copy(Tovar, 1, 38);

    FDriver.StringForPrinting := 'Скидка на ' + Tovar + ': ';
    Result := FDriver.Discount;
  end;
end;

function TShtrihDriver.Payment(GoodsName: string; Quantity, Price,
  DiscountSum: Double; NDS: Integer; Department: integer = 0; DataMatrix : string = ''; CutMarkCode : Integer = 0): String;
begin
  Result := '';

  //FDriver.Summ1 := Price * Quantity;
  FDriver.Price := Price;  // - Discount по закону 54-Ф3 надо указывать сумму с учетом скидок уже
  FDriver.Quantity := Quantity;
  FDriver.Department := Department;
  FDriver.StringforPrinting := GoodsName;
  FDriver.Tax1 := NDS;
  if FDriver.Sale <> 0 then
    Result := GetResult

  else begin
    if DataMatrix <> '' then begin
      if (CutMarkCode = 1) and (Length(DataMatrix) = 29) then
        FDriver.StringforPrinting := 'M:[' + Copy(DataMatrix, 1, 14) + '>' + Copy(DataMatrix, 15) + ']'
      else
        FDriver.StringforPrinting := 'M:[' + DataMatrix + ']';

      if FDriver.PrintString <> 0 then
        Result := GetResult

      // печатаем скидку после каждого товара
      else begin
        if DiscountSum > 0 then begin
          FDriver.StringforPrinting := 'Скидка ' + FloatToStr(DiscountSum);

          if FDriver.PrintString <> 0 then
            Result := GetResult;
        end;
      end;
    end;
  end;
end;

function TShtrihDriver.ReturnGoods(GoodsName: string; Quantity, Price: double; NDS: Integer;
  Department: integer = 0; DataMatrix : string = ''; CutMarkCode : Integer = 0): String;
begin
  Result := '';

  FDriver.Summ1 := Price * Quantity;
  FDriver.Price := Price;
  FDriver.Quantity := Quantity;
  FDriver.Department := Department;
  FDriver.StringforPrinting := GoodsName;
  FDriver.Tax1 := NDS;
  if FDriver.ReturnSale <> 0 then
    Result := GetResult

  else begin
    if DataMatrix <> '' then begin
      if CutMarkCode = 1 then
        FDriver.StringforPrinting := 'M:[' + Copy(DataMatrix, 1, 14) + '>' + Copy(DataMatrix, 15) + ']'
      else
        FDriver.StringforPrinting := 'M:[' + DataMatrix + ']';

      if FDriver.PrintString <> 0 then
        Result := GetResult;
    end;
  end;
end;

function TShtrihDriver.XReport: String;
begin
  Screen.Cursor := crHourGlass;

  if FDriver.PrintReportWithoutCleaning <> 0 then
    Result := GetResult;

  Screen.Cursor := crDefault;
end;

function TShtrihDriver.ZReport: String;
begin
  Screen.Cursor := crHourGlass;

  if FDriver.PrintReportWithCleaning <> 0 then
    Result := GetResult;

  Screen.Cursor := crDefault;
end;

function TShtrihDriver.CancelCheck: string;
begin
  FDriver.CancelCheck;
  FDriver.OperationBlockFirstString := 0;

  if GetResultCode <> 0 then
    Result := GetResult;
end;

function TShtrihDriver.CancelCheckIf: string;
begin
  if FDriver.GetShortECRStatus <> 0 then
    Result := GetResult;

  if FDriver.ECRMode = 8 then
    Result := CancelCheck;
end;

function TShtrihDriver.CashIn(sum: real): String;
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  try
    if VarIsEmpty(FDriver) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      Exit;
    end;

    CancelCheckIf;
    FDriver.Summ1 := sum;
    if FDriver.CashInCome <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TShtrihDriver.CashOUT(sum: real): String;
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  try
    if VarIsEmpty(FDriver) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      Exit;
    end;

    CancelCheckIf;
    FDriver.Summ1 := sum;
    if FDriver.CashOutCome <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TShtrihDriver.CloseCheckSumm(SummCash, SummNonCash, SumAll: double; Discount : Double;
Bonus, BonusD, TotalBonus: Double; Txt : String = ''; Idn : String = ''): String;
var
  Str_print: string;
begin
  Screen.Cursor := crHourGlass;
  Result := '';
  FDriver.StringforPrinting := '';
  Str_print := '';
  try
    if VarIsEmpty(FDriver) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      CancelCheckIf;
      Exit;
    end;
    if Bonus<>0 then
    begin
      FDriver.StringforPrinting := 'Оплата бонусами';
      FDriver.Summ1 := Bonus;
      FDriver.Discount;
    end;
    Sleep(1000);
    FDriver.Summ1 := SummCash;
    FDriver.Summ2 := SummNonCash;
    FDriver.Summ3 := 0;
    FDriver.Summ4 := 0;

    if Discount > 0 then begin
      Str_print := Str_print + '--Скидки по чеку--'#13#10 +
        'Сумма чека без скидок ' + FormatFloat('0.00', SumAll) + #13#10 +
        'Сумма скидки ' + FloatToStr(Discount)+ #13#10;
    end;

    if BonusD<>0 then
    begin
      Str_print := Str_print +'------------------'+#13#10 +'Получено бонусов: ' + FloatToStr(BonusD)+ #13#10;
      Str_print := Str_print +#13#10 +'Накоплено бонусов: ' + FloatToStr(TotalBonus)+ #13#10;
    end;

    if Txt <> '' then begin
      Str_print := Str_print + '------------------'#13#10 + Txt;
    end;

    if Str_print <> '' then
      Str_print := Str_print + '------------------'+ #13#10;

    if (Idn <> '') and (Length(Idn) = 12) then
    begin
      FDriver.TagNumber := 1228;
      FDriver.TagType := 7;
      FDriver.TagValueStr := Idn;
      FDriver.FNSendTag;
    end;
      //FDriver.StringforPrinting := '1228:[' + Idn + ']';
    FDriver.StringforPrinting := #13#10+Str_print+#13#10;

    if FDriver.CloseCheck <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TShtrihDriver.Connect(PortNumber : Integer; BaudRate : integer;
IsFrConnectedAnotherComp : integer; IpFrConnectAnotherComp : String): String;
begin
  Screen.Cursor := crHourGlass;

  FDriver.ComNumber := PortNumber;
  FDriver.BaudRate := BaudRate;

  if IsFrConnectedAnotherComp = 1 then begin
    FDriver.ConnectionType := 1;
    FDriver.IPAddress := IpFrConnectAnotherComp;
    FDriver.UseIPAddress := True;
  end;

  if FDriver.Connect <> 0 then
    Result := GetResult;

  Screen.Cursor := crDefault;
end;

function TShtrihDriver.GetTicketNum: string;
begin
  Result := '0';
  try
    FDriver.RegisterNumber := 144;
    Application.ProcessMessages;
    if FDriver.GetOperationReg <> 0 then Abort;
      Result := FloatToStr(FDriver.ContentsOfOperationRegister +1);
  except
  end;
end;

end.
