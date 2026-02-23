unit unDisplayDriver;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, CPort, CPortCtl, Vcl.Dialogs;

type
  TDisplayDriver = class
  protected
    FModel : Integer;   // 0 - модель 310, 1 - модель 610
    ComPort: TComPort;
  public
    constructor Create(DisplayModel : Integer; ComportStr : String; BaudRate : Integer);
    destructor Destroy;

    procedure ShowRoutine(Summ : Double);
    procedure Calibrate;
  end;

implementation

constructor TDisplayDriver.Create(DisplayModel : Integer; ComportStr : String; BaudRate : Integer);
begin

  inherited Create;

  try
    ComPort := TComPort.Create(nil);
    ComPort.BeginUpdate;
    ComPort.Port := ComportStr;
    case BaudRate of
      0 : ComPort.BaudRate := br2400;
      1 : ComPort.BaudRate := br4800;
      2 : ComPort.BaudRate := br9600;
      3 : ComPort.BaudRate := br19200;
      4 : ComPort.BaudRate := br38400;
      5 : ComPort.BaudRate := br57600;
      6 : ComPort.BaudRate := br115200;
    end;
    ComPort.EndUpdate;
    ComPort.Open;
  except
    on E: Exception do begin
      MessageDlg('Не удалось открыть Com-порт дисплея покупателя - ' + ComportStr + '. Ошибка: ' + E.Message, mtError, [mbOK], 0);
      exit;
    end;
  end;

  FModel := DisplayModel;
end;

destructor TDisplayDriver.Destroy;
begin
  ComPort.Close;
  ComPort.Free;

  inherited Destroy;
end;

procedure TDisplayDriver.ShowRoutine(Summ: Double);
var str, Nums : string;
begin
  Nums := FloatToStr(Summ);
  if FModel = 0 then begin
    if pos('.', Nums, 1) > 0 then
      Str := StringOfChar(' ', 9 - Length(Nums)) + Nums
    else
      Str := StringOfChar(' ', 8 - Length(Nums)) + Nums;
  end
  else if FModel = 1 then begin
    str := StringReplace(Nums, '.', '', [rfReplaceAll]);
    if Length(str) = 3 then
      str := '0' + str;

    str := StringOfChar('_', 8 - Length(str)) + str;

    str := copy(str, 5, 4) + copy(str, 1, 4);
  end;

  Str := Str + #13#10;
  ComPort.WriteStr(Str);
end;

procedure TDisplayDriver.Calibrate;
var str : string;
begin
  str := '_000____' + #13#10;
  ComPort.WriteStr(Str);
  //ComPort.WriteStr(Str);
  //ComPort.WriteStr(Str);
  //ComPort.WriteStr(Str);
end;

end.
