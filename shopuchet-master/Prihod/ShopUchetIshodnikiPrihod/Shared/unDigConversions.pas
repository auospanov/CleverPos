unit unDigConversions;

interface

function HiDWord(I: Int64): Longword;
{Выделяет старшее (левое) двойное слово в double (аналогично Hi)}

function LoDWord(I: Int64): Longword;
{Выделяет младшее (правое) двойное слово в double (аналогично Hi)}

function HiWord(D: LongWord): Word;
{Выделяет старшее (левое) слово в длинном слове (аналогично Hi)}

function LoWord(D: LongWord): Word;
{Выделяет младшее (правое) слово в длинном слове (аналогично Lo)}

{------ To Hex conversions ------}
function Byte2Hex(D: Byte): String;
{Конвертирует байт в шестнадцатеричную строку}

function Word2Hex(D: Word): String;
{Конвертирует слово (или целое) в шестнадцатеричную строку.
 Аналог IntToHex}

function DWord2Hex(D: Longword): String;
{Конвертирует двойное слово в шестнадцатеричную строку}

function Bin2Hex(B: String): String;
{Конвертирует двоичную строку в шестнадцатеричную}

{----- From Hex conversions -----}
function CheckHexStr(H: String): Boolean;
{True, если B - корректная шестнадцатеричная строка}

function Hex2DWord(H: String): LongWord;
{Конвертирует шестнадцатеричную строку длиной до 8 "разрядов" в двойное слово}

{------ To Bin conversions ------}
function AddLeftZeros(B: String; RequiredLen: Integer): String;
{Дополняет строку B нулями слева}

function Byte2Bin(D: Byte): String;
{Конвертирует байт в двоичную строку}

function Word2Bin(D: Word): String;
{Конвертирует слово (или целое) в двоичную строку}

function DWord2Bin(D: Longword): String;
{Конвертирует двойное слово в двоичную строку}

function Hex2Bin(H: String): String;
{Конвертирует шестнадцатеричную строку в двоичную}

{----- From Bin conversions -----}
function CheckBinStr(B: String): Boolean;
{True, если B - корректная двоичная строка}

function Bin2DWord(B: String): Integer;
{Конвертирует двоичную строку в двойное слово}

{--------------------------------}
implementation
{--------------------------------}

uses SysUtils;

{--------------------------------}

function HiDWord(I: Int64): Longword;
{Выделяет старшее (левое) двойное слово в int64 (аналогично Hi)}
begin
  Result := I shr 32;
end;

function LoDWord(I: Int64): Longword;
{Выделяет младшее (правое) двойное слово в int64 (аналогично Hi)}
begin
  Result := I and $FFFFFFFF;
end;

function HiWord(D: LongWord): Word;
{Выделяет старшее (левое) слово в длинном слове (аналогично Hi)}
begin
  Result := D shr 16;
end;

function LoWord(D: LongWord): Word;
{Выделяет младшее (правое) слово в длинном слове (аналогично Lo)}
begin
  Result := D and $FFFF;
end;

{------ To Hex conversions ------}
function Byte2Hex(D: Byte): String;
{Конвертирует байт в шестнадцатеричную строку}
var
  HiPart,
  LoPart : Byte;
  HiHex,
  LoHex  : Char;
begin
  if D = 0 then begin
    Result := '00';
    Exit;
  end;

  HiHex := '0';
  LoHex := '0';
  HiPart := D div 16;
    case HiPart of
      0..9  : HiHex := chr(HiPart + 48);
      10..15: HiHex := chr(HiPart + 55);
    end;    {case}
  LoPart := D mod 16;
    case LoPart of
      0..9  : LoHex := chr(LoPart + 48);
      10..15: LoHex := chr(LoPart + 55);
    end;    {case}
  Result := HiHex + LoHex;  {Левая часть + правая часть байта}
end;

function Word2Hex(D: Word): String;
{Конвертирует слово (или целое) в шестнадцатеричную строку.
 Аналог IntToHex}
begin
  if D = 0 then begin
    Result := '0000';
    Exit;
  end;
  Result := Byte2Hex(Hi(D)) + Byte2Hex(Lo(D));  {Левый байт + правый байт слова}
end;

function DWord2Hex(D: Longword): String;
{Конвертирует двойное слово в шестнадцатеричную строку}
begin
  if D = 0 then begin
    Result := '00000000';
    Exit;
  end;
  Result := Word2Hex(HiWord(D)) + Word2Hex(LoWord(D));  {Левое слово + правое слово длинного слова}
end;

function Bin2Hex(B: String): String;
{Конвертирует двоичную строку в шестнадцатеричную}
begin
  case Length(B) of
    1..8  : Result := Byte2Hex(Bin2DWord(B));
    9..16 : Result := Word2Hex(Bin2DWord(B));
    17..32: Result := DWord2Hex(Bin2DWord(B));
  else
    Result := DWord2Hex(Bin2DWord(B));
  end;
end;

{----- From Hex conversions -----}
function CheckHexStr(H: String): Boolean;
{True, если H - корректная шестнадцатеричная строка}
var
  HexLen: Integer;  {Длина шестнадцатеричной строки}
  i     : Integer;  {Счетчик}
begin
  Result := True;
  if H = '' then begin
    Result := False;
    Exit;
  end;
  HexLen := Length(H);
  for i := 1 to HexLen do
    if not (H[i] in ['0'..'9', 'A'..'F']) then begin
      Result := False;
      Exit;
    end;
end;

function HexChar2Byte(H: Char): Byte;
{Конвертирует шестнадцатеричный символ в байт}
begin
  Result := 0;
  if not CheckHexStr(H) then begin
    {В строке есть символы, отличные от 0..9, A..F или пустая строка}
    raise EConvertError.Create(H + ' is not valid hex character');
    Exit;
  end;
  case H of
    '0'..'9': Result := StrToInt(H);
    'A'..'F': Result := ord(H) - 55;
  end;
end;

function Hex2DWord(H: String): LongWord;
{Конвертирует шестнадцатеричную строку длиной до 8 "разрядов" в двойное слово}
var
  DigWeight: LongWord;    {Вес текущего разряда}
  TmpDWord : LongWord;    {Промежуточный результат}
  HexLen   : Byte;        {Длина шестнадцатеричной строки}
  i        : Byte;        {Счетчик}
begin
  Result := 0;
  if not CheckHexStr(H) then begin
    {В строке есть символы, отличные от 0..9, A..F или пустая строка}
    raise EConvertError.Create(H + ' is not valid hex string');
    Exit;
  end;
  if Length(H) > 8 then begin
    {Строка слишком длинная}
    raise EConvertError.Create(H + ' is to long hex string');
    Exit;
  end;
  DigWeight := 1;
  TmpDWord := 0;
  HexLen := Length(H);
  if HexLen > SizeOf(Result) * 2 then
    {Длина строки больше 8 "разрядов"}
    Exit;
  for i := HexLen downto 1 do begin
    TmpDWord := TmpDWord + HexChar2Byte(H[i]) * DigWeight;
    DigWeight := DigWeight * 16;
  end;
  Result := TmpDWord;
end;

{------ To Bin conversions ------}
function AddLeftZeros(B: String; RequiredLen: Integer): String;
{Дополняет строку B нулями слева}
var
  BinLen: Integer;
  i     : Integer;
  TmpStr: String;
begin
  TmpStr := B;
  BinLen := Length(B);
  for i := 1 to (RequiredLen - BinLen) do
    TmpStr := '0' + TmpStr;
end;

function Dig2Bin(D: LongWord): String;
{Конвертирует число в двоичную строку}
{Последний "бит" в строке будет младший}
var
  Dividend : LongWord;
  Remainder: Byte;
  TmpStr   : String;
begin
  Dividend := D;
  TmpStr := '';
  repeat
    Remainder := Dividend mod 2;
    Dividend := Dividend div 2;
    TmpStr := IntToStr(Remainder) + TmpStr;  {Собираем остатки в обратном порядке}
  until Dividend = 0;
  Result := TmpStr;
end;

function Byte2Bin(D: Byte): String;
{Конвертирует байт в двоичную строку}
begin
  if D = 0 then begin
    Result := '00000000';
    Exit;
  end;
  Result := Dig2Bin(D);
end;

function Word2Bin(D: Word): String;
{Конвертирует слово (или целое) в двоичную строку}
begin
  if D = 0 then begin
    Result := '0000000000000000';
    Exit;
  end;
  Result := Dig2Bin(D);
end;

function DWord2Bin(D: Longword): String;
{Конвертирует двойное слово в двоичную строку}
begin
  if D = 0 then begin
    Result := '00000000000000000000000000000000';
    Exit;
  end;
  Result := Dig2Bin(D);
end;

function Hex2Bin(H: String): String;
{Конвертирует шестнадцатеричную строку в двоичную}
begin
  case Length(H) of
    2: Result := Byte2Bin(Hex2DWord(H));
    4: Result := Word2Bin(Hex2DWord(H));
    8: Result := DWord2Bin(Hex2DWord(H));
  else
    Result := DWord2Bin(Hex2DWord(H));
  end;
end;

{----- From Bin conversions -----}
function CheckBinStr(B: String): Boolean;
{True, если B - корректная двоичная строка}
var
  BinLen: Integer;  {Длина двоичной строки}
  i     : Integer;  {Счетчик}
begin
  Result := True;
  if B = '' then begin
    Result := False;
    Exit;
  end;
  BinLen := Length(B);
  for i := 1 to BinLen do
    if not (B[i] in ['0', '1']) then begin
      Result := False;
      Exit;
    end;
end;

function Bin2DWord(B: String): Integer;
{Конвертирует двоичную строку длиной до 32 "разрядов" в двойное слово}
{Подразумевается, что последний "бит" в строке - младший}
var
  DigWeight: Integer;        {Вес текущего разряда}
  TmpDWord : Integer;    {Промежуточный результат}
  BinLen   : Byte;        {Длина двоичной строки}
  i        : Byte;        {Счетчик}
begin
  Result := 0;
  if not CheckBinStr(B) then begin
    {В строке есть символы, отличные от 0 и 1 или пустая строка}
    raise EConvertError.Create(B + ' is not valid binary string');
    Exit;
  end;
  if Length(B) > 32 then begin
    {Строка слишком длинная}
    raise EConvertError.Create(B + ' is to long binary string');
    Exit;
  end;
  DigWeight := 1;
  TmpDWord := 0;
  BinLen := Length(B);
  if BinLen > SizeOf(Result) * 8 then
    {Длина строки больше 32 "разрядов"}
    Exit;
  for i := BinLen downto 1 do begin
    TmpDWord := TmpDWord + Integer(StrToInt(B[i])) * DigWeight;
    DigWeight := DigWeight * 2;
  end;
  Result := TmpDWord;
end;

end.
