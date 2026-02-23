unit unkkm;

interface

uses unAtolkkm, System.SysUtils, Vcl.Forms, System.UITypes, Vcl.dialogs;

type TKKMAtol = class
  protected
    KKMDevice : TKKMDriver;
  public
    constructor Create(isTestMode: boolean = false);
    destructor Destroy;
    procedure SetTextWrap(ISWrap: integer = 0);
    function XReport : String;
    function ZReport : String;
    function Connect(port, Model: integer) : String;
    function Disconnect : String;
    function OpenSession() : String;
    function CashIn( sum: real=0) : String;
    function CashOUT(sum: real=0) : String;
    function Payment(GoodsName:string; Quantity:double; Price:double; Discount : Double; Department: integer = 0) : String;  //нет пересносв
    function ReturnGoods(GoodsName:string; Quantity:double; Price:double; Department: integer = 0) : String;  //нет пересносв
    //function CloseCheck : String;
    function CloseCheckSumm(SummCash, SummNonCash, SumAll, discountAllVal :double; Idn : String = '') : String;   //закрыть чек с суммой
    function GetConnectionStatus:boolean;
    function GetDeviceName : string;
    function GetResult : string;
    function GetResultCode : integer;
    function GetResultDescription : string;
    function CancelCheckIf : Boolean;
    function CancelCheck : Boolean;
    function NewDocument : Boolean;
    //   procedure DiscountCheck(Percents:double);
    //   procedure DiscountGoods(Percents:double);
end;

implementation

constructor  TKKMAtol.Create(isTestMode: boolean = false);
begin
  if not Assigned(KKMDevice) then begin
    KKMDevice := TKKMDriver.Create;
    KKMDevice.TestMode := isTestMode; //тестовый режим
  end;
end;

destructor  TKKMAtol.Destroy;
begin
  KKMDevice.free;
end;

function  TKKMAtol.XReport : String;
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  try
    if not Assigned(KKMDevice) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      Exit;
    end;

    KKMDevice.NewDocument;
    KKMDevice.mode := TKKMMode.kmXReport;
    KKMDevice.SetMode;
    if KKMDevice.ResultCode <> 0 then begin
      Result := GetResult;
      Exit;
    end;

    KKMDevice.ReportType:= rtXReport;
    KKMDevice.report;
    if KKMDevice.ResultCode <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function  TKKMAtol.ZReport : String;
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  try
    if not Assigned(KKMDevice) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      Exit;
    end;

    KKMDevice.NewDocument;
    KKMDevice.mode := TKKMMode.kmZReport;
    KKMDevice.SetMode;
    if KKMDevice.ResultCode <> 0 then begin
      Result := GetResult;
      Exit;
    end;
  
    KKMDevice.ReportType:= rtZReport;
    KKMDevice.report;
    if KKMDevice.ResultCode <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TKKMAtol.Connect(port, Model: integer) : String;
begin
  Screen.Cursor := crHourGlass;
  result := '';

  //KKMDevice.Model := Model;//62; //атол 55 ф стр 360 драйвера
  //KKMDevice.PortNumber  := port;
  KKMDevice.DeviceEnabled := true;

  if not KKMDevice.DeviceEnabled then
    Result := GetResult + '. Скорее всего нет связи с фискальным регистратором.' + #13#10 +
    'Он выключен либо не подключен к компьютеру.';

  Screen.Cursor := crDefault;
end;

function TKKMAtol.Disconnect : String;
begin
  Screen.Cursor := crHourGlass;
  Result := '';
  KKMDevice.DeviceEnabled := False;

  if not KKMDevice.DeviceEnabled then
    Result := GetResult;

  Screen.Cursor := crDefault;
end;

function TKKMAtol.OpenSession : String;
begin
  Screen.Cursor := crHourGlass;
  Result := '';
  
  KKMDevice.OpenSession;

  if not KKMDevice.DeviceEnabled then
    Result := GetResult;

  Screen.Cursor := crDefault;
end;

function TKKMAtol.CashIn(sum: real=0) : string;
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  try
    if not Assigned(KKMDevice) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      Exit;
    end;
  
    KKMDevice.NewDocument;
    KKMDevice.mode := TKKMMode.kmRegistration;
    KKMDevice.SetMode;
    if KKMDevice.ResultCode <> 0 then begin
      Result := GetResult;
      Exit;
    end;

    KKMDevice.Summ := sum;
    KKMDevice.CashIncome;
    if KKMDevice.ResultCode <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TKKMAtol.CashOUT(sum: real=0) : string;
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  try
    if not Assigned(KKMDevice) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      Exit;
    end;

    KKMDevice.NewDocument;
    KKMDevice.mode := TKKMMode.kmRegistration;
    KKMDevice.SetMode;
    if KKMDevice.ResultCode <> 0 then begin
      Result := GetResult;
      Exit;
    end;
  
    KKMDevice.Summ := sum;
    KKMDevice.EnableCheckSumm := True;
    KKMDevice.CashOutcome;
    if KKMDevice.ResultCode <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure  TKKMAtol.SetTextWrap(ISWrap: integer = 0);  //нет пересносв
begin
  KKMDevice.TextWrap := ISWrap;
end;

function TKKMAtol.Payment(GoodsName:string; Quantity:double; Price:double; Discount : Double; Department: integer = 0) : String;  //нет пересносв
begin
  Result := '';

  if not Assigned(KKMDevice) then begin
    Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
    Exit;
  end;

  KKMDevice.TextWrap := 1;
  KKMDevice.mode := TKKMMode.kmRegistration;
  KKMDevice.SetMode;
  KKMDevice.name := GoodsName;
  KKMDevice.Quantity := Quantity;
  KKMDevice.Price := Price - Discount;  //по закону 54-Ф3 надо указывать цену с учетом скидок
  //KKMDevice.DiscountType := 0;
  //KKMDevice.DiscountValue := Discount;
  KKMDevice.Department := Department;
  KKMDevice.AdvancedRegistration := false;
  KKMDevice.Registration;

  if KKMDevice.ResultCode <> 0 then
    Result := GetResult;  
end;

{function TKKMAtol.CloseCheck : String;
begin
  Result := '';

  if not Assigned(KKMDevice) then begin
    Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
    Exit;
  end;
  
  KKMDevice.Summ:= 0;// Сумма оплаты
  KKMDevice.Payment;
  KKMDevice.CloseCheck(); // Закрыть чек

  if KKMDevice.ResultCode <> 0 then
    Result := GetResult;  
end; }

function TKKMAtol.CloseCheckSumm(SummCash, SummNonCash, SumAll, DiscountAllVal :double; Idn : String = '') : String;   //закрыть чек с суммой
begin
  Screen.Cursor := crHourGlass;
  Result := '';

  try
    if not Assigned(KKMDevice) then begin
      Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
      CancelCheckIf;
      Exit;
    end;

    if SummCash > 0 then begin
      KKMDevice.Summ:= SummCash;// Сумма оплаты
      KKMDevice.TypeClose := tcCash; // Тип оплаты «НАЛИЧНЫМИ»
      KKMDevice.Payment();
    end;

    if SummNonCash > 0 then begin
      KKMDevice.Summ:= SummNonCash;// Сумма оплаты
      KKMDevice.TypeClose := tcType1; // Тип оплаты «БЕЗНАЛИЧНЫМИ»
      KKMDevice.Payment();
    end;

    if KKMDevice.ResultCode <> 0 then begin
      Result := GetResult;
      Exit;
    end;

    if DiscountAllVal > 0 then begin
      KKMDevice.TextWrap := 1;
      KKMDevice.Alignment := 1;
      KKMDevice.Caption := '--Скидки по чеку--';
      KKMDevice.PrintString;
      KKMDevice.Alignment := 0;
      KKMDevice.Caption := 'Сумма чека без скидок ' + FormatFloat('0.00', SumAll);
      KKMDevice.PrintString;
      KKMDevice.Caption := 'Cумма скидки ' + FormatFloat('0.00', DiscountAllVal);
      KKMDevice.PrintString;
    end;
    if (Idn <> '') and (Length(Idn) = 12) then
    begin
      KKMDevice.Caption := '1228:[' + Idn + ']';
      KKMDevice.PrintString;
    end;
    KKMDevice.CloseCheck(); // Закрыть чек

    if KKMDevice.ResultCode <> 0 then
      Result := GetResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TKKMAtol.ReturnGoods(GoodsName:string; Quantity:double; Price:double; Department: integer = 0) : string;  //нет пересносв
begin
  Result := '';

  if not Assigned(KKMDevice) then begin
    Result := 'Фискальный регистратор не подключен. Печать чека невозможна.';
    CancelCheckIf;
    Exit;
  end;
  
  KKMDevice.mode := TKKMMode.kmRegistration;
  KKMDevice.SetMode;
  KKMDevice.name := GoodsName;
  KKMDevice.EnableCheckSumm := false; //Проверять наличность
  KKMDevice.Quantity := Quantity;
  KKMDevice.Price := Price;
  KKMDevice.Department := Department;
  KKMDevice.AdvancedRegistration := false;
  KKMDevice.Return;

  if KKMDevice.ResultCode <> 0 then
    Result := GetResult;    
end;

function  TKKMAtol.GetConnectionStatus:boolean;
begin
  result :=  KKMDevice.DeviceEnabled;
end;

function TKKMAtol.GetDeviceName: string;
begin
  result := KKMDevice.CurrentDeviceName;
end;

function TKKMAtol.GetResult: string;
begin
  result := 'Ошибка фиск. регистратора. Код ' + IntToStr(GetResultCode) + '. ' + GetResultDescription;
  if GetResultCode = -16 then begin
    if KKMDevice.GetCurrentMode <> 0 then begin
      result := result + #13#10 + 'Не удалось получить текущий режим.';
      Exit;
    end;
    result := result + #13#10 + 'Текущий режим - ' + Integer(KKMDevice.Mode).ToString + ', ' +
      KKMDevice.AdvancedMode.ToString;
  end;
end;

function TKKMAtol.GetResultCode: integer;
begin
  result := KKMDevice.ResultCode;
end;

function TKKMAtol.GetResultDescription: string;
begin
  result := KKMDevice.ResultDescription;
end;

function TKKMAtol.NewDocument: Boolean;
begin
  result := true;
  if KKMDevice.NewDocument <> 0 then
    result := false;

  if not KKMDevice.SessionOpened then
    KKMDevice.OpenSession;
end;

function TKKMAtol.CancelCheckIf: Boolean;
begin
  KKMDevice.GetStatus;

  if KKMDevice.CheckState <> csClosed then
    CancelCheck;
end;

// если есть открытый чек, то отменяем его
function TKKMAtol.CancelCheck: Boolean;
begin
  if KKMDevice.CancelCheck <> 0 then
    Exit;
end;


end.
