unit unErrorParser;

interface

const
  UserError = - 20500;
  TagCnt = 4;

type
  TMsgPartArr = array[1..TagCnt] of String;

procedure GetErrorSubStrings(ErrMsg: String; var MsgPartArr: TMsgPartArr);

implementation
uses
  Forms, Dialogs, SysUtils, unCommonFunc;

procedure GetErrorSubStrings(ErrMsg: String; var MsgPartArr: TMsgPartArr);
type
  TTagArr = array[1..TagCnt] of String;
  TPosArr = array[1..TagCnt] of Integer;
const
  TagArr: TTagArr = ('/T\', '/C\', '/E\', '/R\');
  {
  /T\ - строка трассировки (не обязательный тэг, может просто начинаться с начала строки;
  /C\ - код ошибки;
  /E\ - сообщение об ошибке на англ. языке;
  /R\ - сообщение об ошибке на русском языке
  }
var
  i   : Integer;
  PosArr: TPosArr;
  PrevId: Integer;
  Found: Boolean;
begin
  Found := False;
  for i := 1 to TagCnt do begin
    PosArr[i] := Pos(TagArr[i], ErrMsg);
    if PosArr[i] > 0 then
      Found := True;
  end;

  PrevId := 1;
  for i := 2 to TagCnt do begin
    if PosArr[i] > 0 then begin
      if PosArr[PrevId] = 0 then {Для строки трассировки тэг не обязателен,
                                  поэтому позиция м.б. = 0, а строка должна начинаться с 1}
        PosArr[PrevId] := 1;
      {Выделяем очередной элемент сообщения об ошибке}
      MsgPartArr[PrevId] := Copy(ErrMsg, PosArr[PrevId], PosArr[i] - PosArr[PrevId]);
//      if Copy(MsgPartArr[PrevId], 1, 3) = TagArr[i - 1] then
      if Copy(MsgPartArr[PrevId], 1, 3) = TagArr[PrevId] then
        {Удаляем тэг}
        Delete(MsgPartArr[PrevId], 1, 3);
      PrevId := i;
    end;
  end;
  if PosArr[TagCnt] > 0 then begin
    MsgPartArr[TagCnt] := Copy(ErrMsg, PosArr[TagCnt], Length(ErrMsg) - PosArr[TagCnt] + 1);
    if Copy(MsgPartArr[TagCnt], 1, 3) = TagArr[TagCnt] then
      {Удаляем тэг}
      Delete(MsgPartArr[TagCnt], 1, 3);
  end;
  if not Found then
    MsgPartArr[3] := ErrMsg;

  for i := 1 to TagCnt do
    MsgPartArr[i] := UnixToWindowsCRLF(MsgPartArr[i]);
end;

end.
