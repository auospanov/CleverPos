unit frmPosTerminalProcess;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, XSuperObject, frmDlg, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  cxEditRepositoryItems, cxEdit, cxClasses, cxContainer, Vcl.AppEvnts,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.ComCtrls, System.DateUtils,
  Vcl.Buttons, cxControls, cxProgressBar, System.JSON;

type
  TPosTerminalProcessForm = class(TDlgForm)
    Request_Idhttp: TIdHTTP;
    redMain: TRichEdit;
    tmrSetProcess: TTimer;
    pb1: TcxProgressBar;
    btnRepeat: TcxButton;
    btnChangePayType: TcxButton;
    idhtp1: TIdHTTP;
    procedure FormShow(Sender: TObject);
    procedure btnStop_BtnClick(Sender: TObject);
    procedure tmrSetProcessTimer(Sender: TObject);
    procedure btnRepeatClick(Sender: TObject);
    procedure btnChangePayTypeClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FUrl : String;
    FAmount : Double;
    FJson: ISuperObject;
    FIsStopPressed: boolean;
    FIsPaused: boolean;
    FMethod : String;
    FTransactionID : String;
    FSuccess : Boolean;
    FIsRefund : Boolean;
    FStayOnParentForm : Boolean;
    FTypePosTerminal: Integer;

    function MakeGetRequest(url: string): string;
    function GetJson(response: string): boolean;
    function SendAmount(amount: integer; url : string): string;
    function GetStatusPayment(processId: string; url : string): string;
    function ProcessPayment(amount: integer; url : string): boolean;
    function CheckTerminalAdrress(): boolean;
    function ProcessRefund(transactionId, method: string; amount: integer; url : string): boolean;
    function SendRefund(transactionId, method: string; amount: integer; url : string): string;
    function GetStatusRefund(processId: string; url : string): string;

    procedure print(str: string; col: tcolor = clblack);
    procedure Pause(p: Integer; r: Boolean = false);
    procedure ScrollToEnd(ARichEdit: TRichEdit);
    procedure MakeRefund(amountF: Double);
    procedure MakePayment(amountF: Double);
    procedure DisableControls(Enabled : Boolean);

    //Jusan
    procedure MakeJRefund(Amount_: Double);
    procedure MakeJPayment(Amount_: Double);
    procedure ProcessPaymentJusan(amount: integer; url : string);
    function SendJusan(amount: Integer; url: string; Operation: Integer; IDTransaction: string): string;

    procedure ProcessRefundJusan(IDTransaction: string; Amount_: Integer; URL: string);
    function CancelOperation: Boolean;
  public
    property Url : String read FUrl write Furl;
    property Amount : Double read FAmount write FAmount;
    property Method : String read FMethod write FMethod;
    property TransactionID : String read FTransactionID write FTransactionID;
    property IsRefund : Boolean read FIsRefund write FIsRefund;
    property Success : Boolean read FSuccess write FSuccess;
    property StayOnParentForm : Boolean read FStayOnParentForm write FStayOnParentForm;
    property TypePosTerminal: Integer read FTypePosTerminal write FTypePosTerminal;
  end;

const
  MAX_WAIT_STATUS = 60; // сколько максимум ожидать статус результата операции (в секундах)

var
  PosTerminalProcessForm: TPosTerminalProcessForm;
  Started: Boolean = False;

implementation

{$R *.dfm}

function MakeRandomDelay(p: Integer): Integer;
var
  sign, del: Integer;
begin
  if Random(2) = 1 then
    sign := -1
  else
    sign := 1;
  del := Random(p div 5);
  Result := p + sign * del;
end;

function IncludeMyChar(str: string; myChar: char): string;
var
  ch: char;
begin
  result := '';
  if str = '' then
    exit;

  ch := str[Length(str)];
  if ch <> myChar then
    str := str + myChar;
  result := str;
end;

function AddColorText(ARichEdit: TRichEdit; Text: string; Color: tcolor): string;
begin
  ARichEdit.SelAttributes.Color := Color;
  ARichEdit.SelText := Text;
  ARichEdit.SelAttributes.Color := clblack;
end;

procedure TPosTerminalProcessForm.ScrollToEnd(ARichEdit: TRichEdit);
var
  isSelectionHidden: Boolean;
begin
  if FIsPaused then
    exit;

  try
    with ARichEdit do
    begin
      try
        SelStart := Perform(EM_LINEINDEX, Lines.Count, 0); //Set caret at end
        isSelectionHidden := HideSelection;
        try
          HideSelection := False;
          Perform(EM_SCROLLCARET, 0, 0); // Scroll to caret
        finally
          HideSelection := isSelectionHidden;
        end;
      except
      end;
    end;
  except
  end;
end;

procedure TPosTerminalProcessForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  {if Started then
    CanClose := CancelOperation;}
end;

procedure TPosTerminalProcessForm.FormShow(Sender: TObject);
begin
  inherited;

  tmrSetProcess.Enabled := True;
end;

function TPosTerminalProcessForm.GetJson(response: string): boolean;
begin
  result := false;
  FJson := nil;

  try
    FJson := SO(response);
    if not Assigned(FJson) then
    begin
      print('Ошибка разбора парсинга!', clred);
      exit;
    end;
    result := true;
  except
    print('Ошибка парсинга!', clred);
    exit;
  end;
end;

function TPosTerminalProcessForm.MakeGetRequest(url: string): string;
var
  response: string;
begin
  result := '';

  try
    response := Request_Idhttp.Get(url);
  except
    on E: Exception do
    begin
      print('Ошибка выполнения запроса: ' + e.ToString);
      response := 'Ошибка выполнения запроса: ' + e.ToString;
    end;
  end;

  result := response;
end;

procedure TPosTerminalProcessForm.btnChangePayTypeClick(Sender: TObject);
begin
  StayOnParentForm := True;
  Close;
end;

procedure TPosTerminalProcessForm.btnRepeatClick(Sender: TObject);
begin
  DisableControls(False);

  tmrSetProcess.Enabled := True;
end;

procedure TPosTerminalProcessForm.btnStop_BtnClick(Sender: TObject);
begin
  Print('Нажали Стоп!', clblue);
  DisableControls(False);
  FisStopPressed := True;
  Application.ProcessMessages;
end;

function TPosTerminalProcessForm.CheckTerminalAdrress(): boolean;
begin
  if Trim(FUrl) = '' then
  begin
    beep;
    print('Не указан адрес для подключения к терминалу!', clred);
    result := False;
  end
  else
    result := True;
end;

procedure TPosTerminalProcessForm.DisableControls(Enabled: Boolean);
begin
  btnCancel.Enabled := Enabled;
  btnRepeat.Enabled := Enabled;
  btnChangePayType.Enabled := Enabled;
end;

procedure TPosTerminalProcessForm.MakePayment(amountF: Double);
var
  amountS: string;
  amount: integer;
begin
  if not CheckTerminalAdrress then
    Exit;

  print('Соединение с терминалом Kaspi. Оплата...');
  DisableControls(False);

  try
    amountS := FloatToStr(amountF);
    try
      amount := StrToInt(amountS);
    except
      beep;
      print('Ошибка получения значения суммы платежа!');
      exit;
    end;

    Application.ProcessMessages;
    ProcessPayment(amount, Furl + ':8080');
  finally
    DisableControls(True);
  end;
end;

procedure TPosTerminalProcessForm.MakeRefund(amountF: Double);
var
  amountS, method, transactionId: string;
  amount: integer;
begin
  if not CheckTerminalAdrress then
    Exit;

  print('Соединение с терминалом Kaspi. Возврат...');
  DisableControls(False);

  try

    amountS := FloatToStr(amountF);
    try
      amount := StrToInt(amountS);
    except
      beep;
      print('Ошибка получения значения суммы возврата!');
      exit;
    end;

    if amount = 0 then
    begin
      beep;
      print('Сумма для возврата указана 0! Автоматический возврат через POS-терминал невозможен!');
      exit;
    end;

    transactionId := Trim(FTransactionID);
    if transactionId = '' then
    begin
      beep;
      print('Не задана ID операции для возврата! Автоматический возврат через POS-терминал невозможен!');
      exit;
    end;

    method := Trim(FMethod);
    if method = '' then
    begin
      beep;
      print('Не задан метод возврата "Qr" или "Card"! Автоматический возврат через POS-терминал невозможен!');
      exit;
    end;

    ProcessRefund(transactionId, method, amount, Furl + ':8080');
  finally
    DisableControls(True);
  end;
end;

procedure TPosTerminalProcessForm.print(str: string; col: tcolor = clblack);
begin
  str := trim(str);
  str := StringReplace(str, #0, '', [rfReplaceAll]);

  try
    redMain.SetFocus;
  except
  end;

  Application.ProcessMessages;
  try
    redMain.Lines.Add(AddColorText(redMain, TimeToStr(Time) + ': ' + str, col));
    redMain.SelStart := redMain.GetTextLen;
    ScrollToEnd(redMain);
    Application.ProcessMessages;
  except
  end;
end;

function TPosTerminalProcessForm.SendAmount(amount: integer; url : string): string;
var
  baseUrl, paymentReq, response, processId: string;
begin

  result := '';
  baseUrl := IncludeMyChar(Trim(url), '/');

  if Pos('http', baseUrl) = 0 then
    baseUrl := 'http://' + baseUrl;

  paymentReq := baseUrl + 'payment?amount=' + amount.ToString;

  response := MakeGetRequest(paymentReq);
  //response := '{"processId":"1632905319577","status":"wait"}';

  if Pos('Ошибка', response) > 0 then begin
    if Pos('Host not found', response) > 0 then
      print('Нет связи с POS-терминалом! Проверьте, что POS-терминал включен и ' +
        'доступен по локальной сети!')
    else
      print(response);

    exit;
  end;

  //response := Trim(TestBuy_Memo.Text);
  //response := StringReplace(response, #$D#$A, '', [rfReplaceAll]);
  //print('Ответ от сервера: ' + response);

  if not GetJson(response) then
  begin
    print('Не удалось получить корректный ответ от терминала!');
    print(response);
  end;

  try
    processId := Trim(FJson['processId'].AsString);
  except
    processId := '';
  end;

  if processId = '' then
    print('Не удалось получить processId оплаты!')
  else begin
    //print('Успешно получен текущий processId оплаты: ' + processId);
    pb1.Position := pb1.Position + 10;
  end;

  result := processId;
end;

function TPosTerminalProcessForm.SendRefund(transactionId, method: string; amount: integer; url : string): string;
var
  baseUrl, refundReq, response, processId: string;
begin
  result := '';
  baseUrl := IncludeMyChar(Trim(url), '/');
  if Pos('http', baseUrl) = 0 then
    baseUrl := 'http://' + baseUrl;

  refundReq := baseUrl + 'refund?method=' + method + '&amount=' + amount.ToString
    + '&transactionId=' + transactionId;

  response := MakeGetRequest(refundReq);
  //response := '{"processId":"1632905319577","status":"wait"}';

  if Pos('Ошибка', response) > 0 then begin
    if Pos('Host not found', response) > 0 then
      print('Нет связи с POS-терминалом! Проверьте, что POS-терминал включен и ' +
        'доступен по локальной сети!')
    else
      print(response);

    exit;
  end;

  //if Debug_CB.Checked then
  //begin
  //  print('Строка запроса: ' + refundReq);
  //  print('Ответ от сервера: ' + response);
  //end;

  if not GetJson(response) then
  begin
    print('Не удалось получить корректный ответ от терминала!');
    print(response);
  end;

  try
    processId := Trim(FJson['processId'].AsString);
  except
    print('Не удалось получить processId возврата!');
    Exit;
  end;

  if processId = '' then
    print('Не удалось получить processId возврата!')
  else begin
    //print('Успешно получен текущий processId возврата: ' + processId);
    pb1.Position := pb1.Position + 10;
  end;

  result := processId;
end;

procedure TPosTerminalProcessForm.tmrSetProcessTimer(Sender: TObject);
begin
  tmrSetProcess.Enabled := False;
  Screen.Cursor := crHourGlass;
  try
    Case FTypePosTerminal of
      1:  //Kaspi
      begin
        if FIsRefund then
          MakeRefund(FAmount)
        else
          MakePayment(FAmount);
      end;
      2:  //Jusan
      begin
        if FIsRefund then
          MakeJRefund(FAmount)
        else
          MakeJPayment(FAmount);
      end;
    End;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TPosTerminalProcessForm.MakeJRefund(Amount_: Double);
var
  amountS: string;
  amount: integer;
begin
  if not CheckTerminalAdrress then
    Exit;

  print('Соединение с терминалом Jusan. Возврат...');
  DisableControls(False);

  try

    amountS := FloatToStr(Amount_);
    try
      amount := StrToInt(amountS);
    except
      beep;
      print('Ошибка получения значения суммы возврата!');
      exit;
    end;

    if amount = 0 then
    begin
      beep;
      print('Сумма для возврата указана 0! Автоматический возврат через POS-терминал невозможен!');
      exit;
    end;

    if Trim(FTransactionID) = '' then
    begin
      beep;
      print('Не задана ID операции для возврата! Автоматический возврат через POS-терминал невозможен!');
      exit;
    end;

    ProcessRefundJusan(Trim(FTransactionID), amount, Furl + ':8080');
  finally
    DisableControls(True);
  end;
end;

procedure TPosTerminalProcessForm.ProcessRefundJusan(IDTransaction: string; Amount_: Integer; URL: string);
var
  processId, status, method, transactionID, msg: string;
  JSONObject: TJSONValue;
  res: Integer;
begin
  msg := '';
  Started := True;
  processId := SendJusan(Amount_, url, 2, IDTransaction);
  if processId <> '' then
  begin
    try
      try
        JSONObject := TJSONObject.ParseJSONValue(processId);
        if Assigned(JSONObject) then
        begin
          if not TryStrToInt(JSONObject.GetValue<TJSONString>('data.result').Value, res) then
            res := 0;
          if res <> 0 then //error
          begin
            msg := JSONObject.GetValue<TJSONString>('data.msg').Value;
            print(msg);
            FMethod := 'ERROR';
            FTransactionID := 'ERROR';
            msg := 'Возврат не удался';
            FSuccess := False;
            Exit;
          end
          else
          begin
            if AnsiPos('cardNo', processId) > 0 then //Оплата картой
            begin
              FMethod := 'CARD';
              FTransactionID := JSONObject.GetValue<TJSONString>('data.tagRRN').Value;
            end
            else
            begin
              FMethod := 'QR';
              FTransactionID := JSONObject.GetValue<TJSONString>('data.paymentId').Value;
            end;
            FSuccess := True;
            print('Успешный возврат');
          end;
        end;
        Started := False;
      finally
        if JSONObject<>nil then
          FreeAndNil(JSONObject);
      end;
    except on E: Exception do
      print('Ошибка при выполнении операции с сообщением: ' + e.Message);
    end;
    btnOk.Click;
  end;
end;

procedure TPosTerminalProcessForm.MakeJPayment(Amount_: Double);
var
  amountS: string;
  amount: integer;
begin
  if not CheckTerminalAdrress then
    Exit;

  print('Соединение с терминалом Jusan. Оплата...');
  DisableControls(False);

  try
    amountS := FloatToStr(Amount_);
    try
      amount := StrToInt(amountS);
    except
      beep;
      print('Ошибка получения значения суммы платежа!');
      exit;
    end;

    Application.ProcessMessages;
    ProcessPaymentJusan(amount, Furl + ':8080');
  finally
    DisableControls(True);
  end;
end;

procedure TPosTerminalProcessForm.ProcessPaymentJusan(amount: integer; url : string);
var
  processId, status, method, transactionID, msg: string;
  JSONObject: TJSONValue;
  res: Integer;
begin
  msg := '';
  Started := True;
  processId := SendJusan(amount, url, 1, '');
  if processId <> '' then
  begin
    try
      try
        JSONObject := TJSONObject.ParseJSONValue(processId);
        if Assigned(JSONObject) then
        begin
          if not TryStrToInt(JSONObject.GetValue<TJSONString>('data.result').Value, res) then
            res := 0;
          if res <> 0 then //error
          begin
            msg := JSONObject.GetValue<TJSONString>('data.msg').Value;
            print(msg);
            FMethod := 'ERROR';
            FTransactionID := 'ERROR';
            print('Не удалось получить method/transaction из ответа терминала!');
            msg := 'Оплата не прошла';
            FSuccess := False;
            Exit;
          end
          else
          begin
            if AnsiPos('cardNo', processId) > 0 then //Оплата картой
            begin
              FMethod := 'CARD';
              FTransactionID := JSONObject.GetValue<TJSONString>('data.tagRRN').Value;
            end
            else
            begin
              FMethod := 'QR';
              FTransactionID := JSONObject.GetValue<TJSONString>('data.paymentId').Value;
            end;
            FSuccess := True;
            print('Успешная оплата');
          end;
        end;
        Started := False;
      finally
        if JSONObject<>nil then
          FreeAndNil(JSONObject);
      end;
    except on E: Exception do
      print('Ошибка при выполнении операции с сообщением: ' + e.Message);
    end;
    btnOk.Click;
  end;
end;

function TPosTerminalProcessForm.SendJusan(amount: Integer; url: string; Operation: Integer; IDTransaction: string): string;
var
  baseUrl: string;
  Data: TStringStream;
begin
  Result := '';

  baseUrl := IncludeMyChar(Trim(url), '/');

  if Pos('http', baseUrl) = 0 then
    baseUrl := 'http://' + baseUrl;

  case Operation of
    1: //Оплата
    begin
      try
        Data := TStringStream.Create('',TEncoding.UTF8);
        Data.WriteString('{"task": "purchase", "data": {"amount": '+IntToStr(amount)+'}}');
        try
          Result := idhtp1.Post(baseUrl, data);
        except
          on E: Exception do
          begin
            if Pos('Host not found', e.Message) > 0 then
              print('Нет связи с POS-терминалом! Проверьте, что POS-терминал включен и ' +
                'доступен по локальной сети!')
            else
              print('Ошибка при отправке оплаты. Детали: ' + E.Message);
            Result := '';
          end;
        end;
      finally
        FreeAndNil(Data);
      end;
    end;
    2: //Возврат оплаты
    begin
      try
        Data := TStringStream.Create('',TEncoding.UTF8);
        Data.WriteString('{"task": "refund", "data": {"amount": '+IntToStr(amount)+', "tagRRN": '+IDTransaction+'}}');
        try
          Result := idhtp1.Post(baseUrl, data);
        except
          on E: Exception do
          begin
            if Pos('Host not found', e.Message) > 0 then
              print('Нет связи с POS-терминалом! Проверьте, что POS-терминал включен и ' +
                'доступен по локальной сети!')
            else
              print('Ошибка при отправке оплаты. Детали: ' + E.Message);
            Result := '';
          end;
        end;
      finally
        FreeAndNil(Data);
      end;
    end;
  end;
end;

function TPosTerminalProcessForm.ProcessPayment(amount: integer; url : string): boolean;
var
  processId, status, method, transactionID, msg: string;
begin
  result := False;
  msg := '';

  // для теста
  {FSuccess := true;
  FMethod := 'qr';
  FTransactionID := '0000011111111';
  sleep(1000);
  btnOk.Click;
  exit;}

  processId := SendAmount(amount, url);
  if processId <> '' then
  begin
    status := GetStatusPayment(processId, url);
    if status = 'success' then
    begin
      try
        method := LowerCase(Trim(FJson['chequeInfo."method"'].AsString));
        transactionID := LowerCase(Trim(FJson['transactionId'].AsString));
        msg := 'Успешная оплата';
        FSuccess := True;
        FMethod := method;
        FTransactionID := transactionID;
        //print('Метод оплаты : ' + FMethod);
        //print('ID транзакции : ' + FTransactionID);

      except
        method := 'ERROR';
        transactionID := 'ERROR';
        print('Не удалось получить method/transaction из ответа терминала!');
        msg := 'Оплата не прошла';
        FSuccess := False;
      end;
    end
    else
    begin
//      msg := 'ProcessId = ' + processId + ', Статус = ' + status;
      msg := 'Оплата не прошла';
    end;

    print(msg);
  end;

  Application.ProcessMessages;

  if FSuccess then begin
    btnOk.Click;
  end;
end;

function TPosTerminalProcessForm.ProcessRefund(transactionId, method: string; amount: integer; url : string): boolean;
var
  processId, status, msg: string;
begin
  result := False;
  msg := '';

  // для теста
  {FSuccess := true;
  sleep(1000);
  btnOk.Click;
  exit;}

  processId := SendRefund(transactionId, method, amount, url);
  if processId <> '' then
  begin
    status := GetStatusRefund(processId, url);
    if status = 'success' then
    begin
      //transactionID := LowerCase(Trim(FJson['transactionId'].AsString));
      //FTransactionID := transactionID;
      msg := 'Успешный возврат';
      FSuccess := True;
    end
    else
    begin
      msg := 'Возврат не удался';
    end;

    print(msg);
  end;

  Application.ProcessMessages;

  {if FSuccess then begin
    btnOk.Click;
  end;}
end;

function TPosTerminalProcessForm.GetStatusPayment(processId: string; url : string): string;
var
  baseUrl, response, status, statusReq: string;
  endTime: TTime;
begin
  result := '';
  status := '';

  print('Ожидание оплаты...');
  Pause(1000);

  baseUrl := IncludeMyChar(Trim(url), '/');
  if Pos('http', baseUrl) = 0 then
    baseUrl := 'http://' + baseUrl;

  statusReq := baseUrl + 'status?processId=' + processId;

  endTime := IncSecond(Now, MAX_WAIT_STATUS);
  repeat
    if FIsStopPressed then
      exit;
    if Now > endTime then
    begin
      print('Сработал таймаут ожидания оплаты!');
      break;
    end;

    response := MakeGetRequest(statusReq);

    if Pos('Ошибка', response) > 0 then begin
      if Pos('Host not found', response) > 0 then
        print('Нет связи с POS-терминалом! Проверьте, что POS-терминал включен и ' +
          'доступен по локальной сети!')
      else
        print(response);

      exit;
    end;
    //response := Trim(TestBuy_Memo.Text);
    //response := StringReplace(response, #$D#$A, '', [rfReplaceAll]);

    if not GetJson(response) then
    begin
      print('Не удалось получить корректный ответ от терминала!');
      print(response);
      exit;
    end;

    try
      status := LowerCase(Trim(FJson['status'].AsString));
    except
      status := '';
      print('Не удалось получить status!');
      break;
    end;

    if status <> 'wait' then
      break;

    if pb1.Position >= pb1.Properties.Max then
      pb1.Position := 0
    else
      pb1.Position := pb1.Position + 10;

    Pause(1000);
  until false;

  if status = '' then
    try
      status := LowerCase(Trim(FJson['message'].AsString));
    except
      status := '';
      print('Не удалось получить сообщение об ошибке!');
    end;

  print('Полученный статус: ' + status);
  result := LowerCase(status);
end;

function TPosTerminalProcessForm.GetStatusRefund(processId: string; url : string): string;
var
  baseUrl, response, status, statusReq, msg: string;
  endTime: TTime;
begin
  result := '';
  status := '';
  print('Ожидание возврата...');
  Pause(1000);

  baseUrl := IncludeMyChar(Trim(url), '/');
  if Pos('http', baseUrl) = 0 then
    baseUrl := 'http://' + baseUrl;

  statusReq := baseUrl + 'status?processId=' + processId;

  endTime := IncSecond(Now, MAX_WAIT_STATUS);
  repeat
    if FisStopPressed then
      exit;
    if Now > endTime then
    begin
      print('Сработал таймаут ожидания возврата!');
      break;
    end;

    response := MakeGetRequest(statusReq);

    if Pos('Ошибка', response) > 0 then begin
      if Pos('Host not found', response) > 0 then
        print('Нет связи с POS-терминалом! Проверьте, что POS-терминал включен и ' +
          'доступен по локальной сети!')
      else
        print(response);

      exit;
    end;

    //response := Trim(TestRefund_Memo.Text);
    //response := StringReplace(response, #$D#$A, '', [rfReplaceAll]);
    //print('Ответ терминала: ' + response);

    if not GetJson(response) then
    begin
      print('Не удалось получить корректный ответ от терминала!');
      print(response);
      exit;
    end;

    try
      status := LowerCase(Trim(FJson['status'].AsString));
    except
      status := '';
      print('Не удалось получить status!');
      break;
    end;


    if status <> 'wait' then
      break;

    if pb1.Position >= pb1.Properties.Max then
      pb1.Position := 0
    else
      pb1.Position := pb1.Position + 10;

    Pause(1000);
  until false;

  if status = '' then
  try
    status := LowerCase(Trim(FJson['message'].AsString));
  except
    status := '';
    print('Не удалось получить сообщение об ошибке!');
  end;

  print('Полученный статус: ' + status);
  result := LowerCase(status);
end;

procedure TPosTerminalProcessForm.Pause(p: Integer; r: Boolean = false);
var
  pa1: real;
  h, m, S: Integer;
begin
  if r then
    p := MakeRandomDelay(p);
  if p < 1000 then
  begin
    pa1 := encodetime(0, 0, 0, p) + Now;
  end
  else
  begin
    h := p div 3600000;
    m := (p mod 3600000) div 60000;
    S := (p mod 60000) div 1000;
    pa1 := encodetime(h, m, S, 0) + Now;
  end;
  repeat
    Application.ProcessMessages;
    if FIsStopPressed then
      break;
    Sleep(10);
  until Now >= pa1;
end;

function TPosTerminalProcessForm.CancelOperation: Boolean;
var
  JS: TJSONValue;
  JsonStr: String;
  URL: String;
  msg: String;
  Data: TStringStream;
  res: Integer;
begin
  Result := False;
  try
    try
      print('Отмена операции...');

      URL := IncludeMyChar(Trim(FUrl + ':8080'), '/');

      if Pos('http', URL) = 0 then
        URL := 'http://' + URL;

      Data := TStringStream.Create('',TEncoding.UTF8);
      Data.WriteString('{"task": "cancel" }');
      JsonStr := Request_Idhttp.Post(URL, data);
    finally
      FreeAndNil(Data);
    end;
    try
      if JsonStr = EmptyStr then Exit;
      JS := TJSONObject.ParseJSONValue(JsonStr);
      if Assigned(JS) then
      begin
        if not TryStrToInt(JS.GetValue<TJSONString>('data.result').Value, res) then
          res := 0;
        if res <> 1010 then //error
        begin
          msg := JS.GetValue<TJSONString>('data.msg').Value;
          print(msg);
          Exit;
        end;
        Result := True;
      end;
    finally
      if JS<>nil then
        FreeAndNil(JS);
    end;
  except on E: Exception do
    print('Ошибка при выполнении отмены операции. Детали: ' + e.Message);
  end;
end;


end.
