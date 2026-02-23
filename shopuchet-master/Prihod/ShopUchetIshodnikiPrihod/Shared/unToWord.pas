{
  ћодуль преобразовани€ целочисленной —уммы в пропись.
}
unit unToWord;

interface

type
  TTriada = record
    T: array[1..3] of String;
    R: Boolean;
  end;

var
  Triada: array [0..5] of TTriada;

{основна€}
function IntToWord(E: Int64; I: Integer):String;

{производные}
function RubToWord(E: Int64):String; {дл€ рубликов}
function DollarToWord(E: Int64):String; {дл€ зелени}
function TengeToWord(E: Int64):String; {дл€ тенге}
function TiinToWord(E: Int64):String; {дл€ тиин}

implementation

uses SysUtils;

function IntToWord(E: Int64; I: Integer):String;
var
  S, S1, S2, S3, S4: String;
  K: Integer;
begin
  Result := '';
  K := 3;
  if E >= 1000 then
  begin
    Result := IntToWord(E div 1000, I+1); {¬ќ“ ќЌј-–≈ ”–—»я !!!}
    E := E - E div 1000 * 1000;
  end;
  if (E = 0) and (I <> 0) then Exit;
  S := Format('%3d', [E]);
  Case S[1] of
    '1': S1 := 'сто '; '2': S1 := 'двести '; '3': S1 := 'триста ';
    '4': S1 := 'четыреста '; '5': S1 := 'п€тьсот '; '6': S1 := 'шестьсот ';
    '7': S1 := 'семьсот '; '8': S1 := 'восемьсот '; '9': S1 := 'дев€тьсот ';
  end;
  Case S[2] of
    '1':
      begin
      Case S[3] of
        '0': S2 := 'дес€ть '; '1': S2 := 'одинадцать '; '2': S2 := 'двенадцать ';
        '3': S2 := 'тринадцать '; '4': S2 := 'четырнадцать '; '5': S2 := 'п€тнадц€ть ';
        '6': S2 := 'шестнадц€ть '; '7': S2 := 'семнадцать '; '8': S2 := 'восемнадцать ';
        '9': S2 := 'дев€тнадцать ';
      end;
      S[3] := ' ';
     end;
    '2': S2 := 'двадцать '; '3': S2 := 'тридцать '; '4': S2 := 'сорок ';
    '5': S2 := 'п€тьдес€т '; '6': S2 := 'шестьдес€т '; '7': S2 := 'семдес€т ';
    '8': S2 := 'восемдес€т '; '9': S2 := 'дев€носто ';
  end;
  Case S[3] of
    '1': begin K := 1; if Triada[I].R then S3 := 'одна ' else S3 := 'один '; end;
    '2': begin K := 2; if Triada[I].R then S3 := 'две ' else S3 := 'два '; end;
    '3': begin S3 := 'три '; K := 2; end;
    '4': begin S3 := 'четыре '; K := 2; end;
    '5': S3 := 'п€ть '; '6': S3 := 'шесть '; '7': S3 := 'семь ';
    '8': S3 := 'восемь '; '9': S3 := 'дев€ть ';
  end;
  Result := Result + S1 + S2 + S3 + S4 + Triada[I].T[K];
end;

function RubToWord(E: Int64):String;
begin
  Triada[0].T[1] := 'рубль '; Triada[0].T[2] := 'рубл€ '; Triada[0].T[3] := 'рублей ';
  Triada[0].R := False;
  if E = 0 then Result := 'ноль рублей' else Result := IntToWord(E, 0);
end;

function DollarToWord(E: Int64):String;
begin
  Triada[0].T[1] := 'доллар '; Triada[0].T[2] := 'доллара '; Triada[0].T[3] := 'долларов ';
  Triada[0].R := False;
  if E = 0 then Result := 'ноль долларов' else Result := IntToWord(E, 0);
end;

function TengeToWord(E: Int64):String;
begin
  Triada[0].T[1] := 'тенге '; Triada[0].T[2] := 'тенге '; Triada[0].T[3] := 'тенге ';
  Triada[0].R := False;
  if E = 0 then Result := 'ноль тенге' else Result := IntToWord(E, 0);
end;

function TiinToWord(E: Int64):String; {дл€ тиин}
begin
  Triada[0].T[1] := 'тиин '; Triada[0].T[2] := 'тиин '; Triada[0].T[3] := 'тиин ';
  Triada[0].R := False;
  if E = 0 then Result := 'ноль тиин' else Result := IntToWord(E, 0);
end;

initialization

  { именительный, родительный, родительный мн.ч.}
  Triada[0].T[1] := 'рубль';
  Triada[0].T[2] := 'рубл€';
  Triada[0].T[3] := 'рублей';
  Triada[0].R    := False;

  Triada[1].T[1] := 'тыс€ча ';
  Triada[1].T[2] := 'тыс€чи ';
  Triada[1].T[3] := 'тыс€ч ';
  Triada[1].R    := True;

  Triada[2].T[1] := 'миллион ';
  Triada[2].T[2] := 'миллиона ';
  Triada[2].T[3] := 'миллионов ';
  Triada[2].R    := False;

  Triada[3].T[1] := 'миллиард ';
  Triada[3].T[2] := 'миллиарда ';
  Triada[3].T[3] := 'миллиардов ';
  Triada[3].R    := False;

  Triada[4].T[1] := 'триллион ';
  Triada[4].T[2] := 'триллиона ';
  Triada[4].T[3] := 'триллионов ';
  Triada[4].R    := False;

  Triada[5].T[1] := 'квадрильон ';
  Triada[5].T[2] := 'квадрильона ';
  Triada[5].T[3] := 'квадрильонов ';
  Triada[5].R    := False;

  {можно продолжить и дальше}

end.
