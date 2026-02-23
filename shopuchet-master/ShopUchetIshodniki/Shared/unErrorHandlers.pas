unit unErrorHandlers;

interface

procedure DBErrorHandler(ErrCode: Integer; ErrMsg: String);

implementation

uses
  Forms, Dialogs, SysUtils, frmDBErrorDlg, frmAppErrorDlg, unErrorParser;

procedure DBErrorHandler(ErrCode: Integer; ErrMsg: String); 
var
  MsgPartArr: TMsgPartArr;
  DBErrorDlgForm : TDBErrorDlgForm;
  AppErrorDlgForm: TAppErrorDlgForm;
begin
  {Выделяем из ErrMsg строку трассировки и сообщения на русском и английском
   языках}
  GetErrorSubStrings(ErrMsg, MsgPartArr);

//  if (ErrCode = UserError) or (ErrCode = 942) or (ErrCode = 6550) or (ErrCode = -6508) then begin  {Наше сообщение об ошибке}
  if Pos('user does not have privilege', ErrMsg) > 0 then begin {Наше сообщение об ошибке}
    AppErrorDlgForm := TAppErrorDlgForm.Create(Application);
    try
      with AppErrorDlgForm do begin
        meErrTrace.Text := MsgPartArr[1];
        lbErrCode.Caption := MsgPartArr[2];
        lbErrMsgEng.Text := MsgPartArr[3];

        MsgPartArr[4] := 'Недостаточно прав для выполнения операции';
(*
        {ORA-00942: Table or view does not exists}
        {ORA-06550: Identifier ... must be declared}
        if ((ErrCode = 942) or (ErrCode = 6550)) and (MsgPartArr[4] = '') then
          MsgPartArr[4] := 'Недостаточно прав для выполнения операции';

        {ORA-06508: Could not find program unit being called}
        if ErrCode = -6508 then
          MsgPartArr[4] := 'Администратором системы (или системой) были выполнены процессы,'#13#10 +
                           'требующие выполнения отключения и повторного подключения к БД';
*)
        lbErrMsgRus.Text := MsgPartArr[4];
        ShowModal;
      end;
    finally
      AppErrorDlgForm.Free;
    end;
  end
  else begin  {Сообщение FireBird'а}
    DBErrorDlgForm := TDBErrorDlgForm.Create(Application);
    try
      with DBErrorDlgForm do begin
        stErrTrace.Text := MsgPartArr[1];
        lbErrCode.Caption := IntToStr(ErrCode);
        lbErrMsgEng.Text := MsgPartArr[3];
        lbErrMsgRus.Text := MsgPartArr[4];

        //ВОЗМОЖНО ЧТО В ТЕКСТЕ ОШИБКИ СТОИТ ЗНАК ПОСЛЕ КОТОРОГО НАДО ВСЕ ВЫРЕЗАТЬ
        if POS('/Q\', lbErrMsgRus.Text) > 0 then
          lbErrMsgRus.Text := Copy(lbErrMsgRus.Text, 1, POS('/Q\', lbErrMsgRus.Text)-1);
        ShowModal;
      end;
    finally
      DBErrorDlgForm.Free;
    end;
  end;
end;

end.
