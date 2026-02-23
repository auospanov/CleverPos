unit unFRPrinted;

interface
  uses Vcl.Dialogs, System.UITypes, pFIBDataSet, Vcl.ExtCtrls,
  VCL.Graphics, System.SysUtils, Classes, Winapi.Windows,
  Controls, ShellApi, FileCtrl,
  System.Math, forms, fib;

function PrintBillAll(Zakaz : Int64; SummZakaz, SummCash, SummNonCash: Double;
Sdacha : Real; MODE : INTEGER; Decimal : integer; Bonus, SummBonusForSave : Real; Address : String;
FromSales : Boolean; PrintOnPrintersLoc : Boolean; PrintOnFrLoc : Boolean; Idn : String; NonCashPayType: Integer; TotalBonus: Double; FrmTovar: Boolean; REQUEST_NUMBER: string): Boolean;
//Печать чека на АТОЛККМ
function PrintBillAtolKKM(Zakaz : Int64; SummCash, SummNonCash: Double; FTovar: Boolean; Txt : String = '') : String;

//Печать чека на Штрих-М ККМ
function PrintBillStrihKKM(Zakaz : Int64; SummCash, SummNonCash, SummBonusForSave, Bonus, TotalBonus: Double; FTovar: Boolean; Txt : String = ''; Idn : String = '') : String;

//Печать чека ТИС
function PrintBillTIS(Zakaz: Int64; SummCash, SummNonCash, SummZakaz, Sdacha, SummBonusForSave, Bonus: Double; Address, Idn: string; TypeOplata: Integer; TotalBonus: Double; FTovar: Boolean; REQUEST_NUMBER: string): string;

//Печать чека на ReKassa
function PrintBillReKassa(Zakaz : Int64; SummCash, SummNonCash, SummZakaz, Sdacha, SummBonus, Bonus: Double; Adress, Idn: string; FTovar: Boolean; Txt : String = ''; TotalBonus: Double = 0): string;
function RekassaReportX(IDReport: integer; CloseShift: Boolean): Boolean;
function ReportReplaceMoney(CashIn, CashOut: real): string; //Внесение и изъятие денег с кассы
function ReportReturnSell(): string; //Возврат товара
function ReplaceMoneyRekassa(FActionStat: Integer; Sum: Double): string;
function ReportZRekassa: string;
function ReportXRekassa: string;
function ReportZTis: string;
function ReportXTis: string;
procedure PrintReportXTis(Xrep: Boolean);
function CheckRekassa(): String;
function ReturnSellReKassa(SummCash, SummNonCash: double; idn: string): string;

function ReplaceMoneyTis(FActionStat: Integer; Sum: Double): string;
function ReportReplaceMoneyTis(CashIn, CashOut: real): string; //Внесение и изъятие денег с кассы

function ReturnSellTIS(SummCash, SummNonCash: double; idn, TransID: string; Zakaz: Int64; NDSVal, NDSSUM: Double; TypeOplata: Integer; REQUEST_NUMBER: string): string;
function ReportReturnSellTIS(): string; //Возврат товара


var
  discountAllVal : double = 0;

implementation

uses
  unCommonFunc, dmReports, UnRekassa, frmKassa, frmPrihodTovaraN, frmSalePayment, dmMain;

function CheckRekassa(): String;
begin
  try
    Result := '';
    if (Assigned(KKMReKassa)) then
    begin
      if not KKMReKassa.iscon then
      begin
        Result := 'Ошибка reKassa: Нет связи, проверьте соединение с интернет!';
        Exit;
      end;
      if not KKMReKassa.GetToken() then
      begin
        Result := KKMReKassa.err;
        if Trim(Result) = EmptyStr then
          Result := 'Неизвестная ошибка отправки чека в ReKassa. Продажа не может быть сохранена!'
        else
          Result := 'Ошибка отправки чека в ReKassa. Детали: ' + Result;
        exit;
      end;
    end;
  except
    on E: Exception do
    begin
      Result := 'Ошибка отправки чека в ReKassa. Детали: ' + e.ClassName + ' ' + e.Message;
      exit;
    end;
  end;
end;

function ReportXTis: string;
begin
  Result := '';
  if Assigned(KKMTIS) then
    Result := KKMTIS.Reports(False);
  if Result = EmptyStr then
    PrintReportXTis(True);
end;

procedure PrintReportXTis(Xrep: Boolean);
var
  BillWidth: Integer;
begin
  if PrinterRekassa.Name = '' then
  begin
    MessageDlg('Чековый принтер не настроен! Укажите его в настройках программы! Печать чеков невоможна!', mtWarning, [mbOk], 0);
    Exit;
  end;
  with ReportsDM do
  begin
    if Xrep then
    begin
      if PrinterRekassa.BillWidth = '80 мм' then
        BillWidth := 0
      else if PrinterRekassa.BillWidth = '58 мм' then
        BillWidth := 1
      else
        BillWidth := 2;
      case BillWidth of
        0:
        begin
          LoadFastReport(Report, 101);
          PrepareReport(101);
        end;
        1:
        begin
          LoadFastReport(Report, 92);
          PrepareReport(92);
        end;
        else
        begin
          LoadFastReport(Report, 102);
          PrepareReport(102);
        end;
      end;
    end
    else
    begin
      if PrinterRekassa.BillWidth = '80 мм' then
        BillWidth := 0
      else if PrinterRekassa.BillWidth = '58 мм' then
        BillWidth := 1
      else
        BillWidth := 2;
      case BillWidth of
        0:
        begin
          LoadFastReport(Report, 103);
          PrepareReport(103);
        end;
        1:
        begin
          LoadFastReport(Report, 93);
          PrepareReport(93);
        end;
        else
        begin
          LoadFastReport(Report, 104);
          PrepareReport(104);
        end;
      end;
    end;

    //****************************************************************************
    FBillSdvig := PrinterRekassa.BillSdvig;
    if not mdReportX.Active then
      mdReportX.Open;
    if mdReportX.RecordCount >0 then
    begin
      with mdReportX do
      begin
        First;
        while not Eof do
          Delete;
      end;
    end;
      //Снятие денег и вложение в кассу
      if KKMTIS.SUM_MW>0 then
      begin
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'Сумма';
        mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.SUM_MW, -2));
        mdReportX.Post;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ИЗЪЯТИЕ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      if KKMTIS.SUM_MD>0 then
      begin
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'Сумма';
        mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.SUM_MD, -2));
        mdReportX.Post;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ВНЕСЕНИЕ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;

      //Возврат покупки
      if (KKMTIS.B_BUY_RETURN>0) or (KKMTIS.BB_CARD_RETURN>0) then
      begin
        if KKMTIS.BB_CARD_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.BB_CARD_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMTIS.B_BUY_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.B_BUY_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMTIS.COUNT_TICKET_RETURN_BUY>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMTIS.COUNT_TICKET_RETURN_BUY);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ВОЗВРАТ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      //Покупка
      if (KKMTIS.B_BUY>0) or (KKMTIS.BB_CARD>0) then
      begin
        if KKMTIS.BB_CARD>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.BB_CARD, -2));
          mdReportX.Post;
        end;
        if KKMTIS.B_BUY>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.B_BUY, -2));
          mdReportX.Post;
        end;
        if KKMTIS.COUNT_TICKET_BUY>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMTIS.COUNT_TICKET_BUY);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ПОКУПКА';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      //Возврат продажи
      if (KKMTIS.B_SELL_RETURN>0) or (KKMTIS.B_CARD_RETURN>0) then
      begin
        if KKMTIS.B_CARD_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.B_CARD_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMTIS.B_SELL_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.B_SELL_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMTIS.COUNT_TICKET_RETURN_SELL>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMTIS.COUNT_TICKET_RETURN_SELL);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ВОЗВРАТ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      //Продажа
      if (KKMTIS.B_SELL>0) or (KKMTIS.B_CARD>0) then
      begin
        if KKMTIS.B_CARD>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.B_CARD, -2));
          mdReportX.Post;
        end;
        if KKMTIS.B_SELL>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMTIS.B_SELL, -2));
          mdReportX.Post;
        end;
        if KKMTIS.COUNT_TICKET_SELL>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMTIS.COUNT_TICKET_SELL);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ПРОДАЖА';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      Report.PrepareReport;
      Report.PrintOptions.ShowDialog := False;
      if Trim(PrinterRekassa.Name)<>'' then
        Report.PrintOptions.Printer := PrinterRekassa.Name;
      Report.SelectPrinter();
      Report.Print;
  end;
end;

function ReportZTis: string;
begin
  Result := '';
  if Assigned(KKMTIS) then
    Result := KKMTIS.Reports(True);
  if Result = EmptyStr then
    PrintReportXTis(False);
end;

function ReportXRekassa: string;
begin
  if Assigned(KKMReKassa) then
    if not KKMReKassa.iscon then
    begin
      Result := 'Ошибка reKassa: Нет связи, проверьте соединение с интернетом!';
      Exit;
    end;
  if not RekassaReportX(75, False) then
    Result := KKMReKassa.err;
end;

function ReportZRekassa: string;
begin
  if Assigned(KKMReKassa) then
    if not KKMReKassa.iscon then
    begin
      Result := 'Ошибка reKassa: Нет связи, проверьте соединение с интернетом!';
      Exit;
    end;
  if not RekassaReportX(76, True) then
  begin
    if KKMReKassa.err = 'Ошибка reKassa: В кассовом аппарате должна быть открыта смена' then
      Result := 'Ошибка reKassa: Смена уже закрыта.'
    else
      Result := KKMReKassa.err;
    //'Ошибка reKassa: Не возможно отправить в ОФД';
    Exit;
  end;
end;

function PrintBillAll(Zakaz : Int64; SummZakaz, SummCash, SummNonCash: Double;
Sdacha : Real; MODE : INTEGER; Decimal : integer; Bonus, SummBonusForSave : Real; Address : String;
FromSales : Boolean; PrintOnPrintersLoc : Boolean; PrintOnFrLoc : Boolean; Idn : String; NonCashPayType: Integer; TotalBonus: Double; FrmTovar: Boolean; REQUEST_NUMBER: string): Boolean;
var
  str: String;
begin
  str := EmptyStr;
  Result := False;
  {IF PrintOnPrintersLoc THEN
  BEGIN
    ReportsDM.PrintBill(Zakaz,SummZakaz, SummCash, SummNonCash,Sdacha,MODE,Decimal,SummBonusForSave,Address,
                        FromSales,PrintOnPrintersLoc,PrintOnFrLoc, TotalBonus);
  END
  else}
  IF (PrintOnFrLoc = True) and (CheckPrintDeviceFr IN [1,2,3,4,5,6]) THEN
  BEGIN
    if FromSales then begin
      if MessageDlg('Скорее всего чек уже был распечатан и отправлен в ОФД. Вы уверены, что хотите повторно распечатать чек '+
      'на фискальном регистраторе?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
        Exit;
    end;

    Screen.Cursor := crHourGlass;
    TRY
      if ReportsDM.spUniversal.Active then
        ReportsDM.spUniversal.Close;
      ReportsDM.spUniversal.SelectSQL.Text := 'SELECT GP.NAME, ZD.AMOUNT, ZD.PRICE, ZD.DISCOUNT_TENGE, '+
                                    'ZD.MARK_CODE, Z.SUMM, Z.SUMM_BONUS, ZD.NDS, ZD.NDS_SUMM, '+
                                    'ZD.DISCOUNT_PERC '+
                                    'FROM ZAKAZ Z, '+
                                       'ZAKAZ_DETAILS ZD, '+
                                       'G_PRODUCT GP '+
                                    'WHERE Z.ZAKAZ = :ZAKAZ_ '+
                                    'AND ZD.ZAKAZ = Z.ZAKAZ '+
                                    'AND ZD.G_PRODUCT = GP.G_PRODUCT';
      MainDM.SQLTMP.Close;
      MainDM.SQLTMP.SelectSQL.Text := 'SELECT GP.NAME, ZD.AMOUNT, ZD.PRICE, ZD.DISCOUNT_TENGE,'+
                                    'ZD.MARK_CODE, ZD.NDS, ZD.NDS_SUMM,'+
                                    'ZD.DISCOUNT_PERC '+
                                    'FROM ZAKAZ_DETAILS_TMP ZD, G_PRODUCT GP '+
                                    'WHERE ZD.G_PRODUCT = GP.G_PRODUCT';

      if (CheckPrintDeviceFr = 1) and (Assigned(KKMPrinter)) then
        str := PrintBillAtolKKM(Zakaz, SummCash, SummNonCash, FrmTovar)
      else
        if (CheckPrintDeviceFr in [2,3,4]) and (Assigned(KKMPrinterStrih)) then
          str := PrintBillStrihKKM(Zakaz, SummCash, SummNonCash, SummBonusForSave, Bonus, TotalBonus, FrmTovar, Address, Idn)
        else
          if (ReKassa) and (CheckPrintDeviceFr = 5) then
            str := PrintBillReKassa(Zakaz, SummCash, SummNonCash, SummZakaz, Sdacha, SummBonusForSave, Bonus, Address, Idn, FrmTovar, '', TotalBonus)
          else
            if (CheckPrintDeviceFr = 6) and (Assigned(KKMTIS)) then
              str := PrintBillTIS(Zakaz, SummCash, SummNonCash, SummZakaz, Sdacha, SummBonusForSave, Bonus, Address, Idn, NonCashPayType, TotalBonus, FrmTovar, REQUEST_NUMBER);
    FINALLY
      Screen.Cursor := crDefault;
    END;
  END;

  if trim(str) <> EmptyStr then
  begin
    Result := true;
    MessageDlg(str, mtError, [mbOK], 0);
    exit;
  end;
end;

function PrintBillTIS(Zakaz: Int64; SummCash, SummNonCash, SummZakaz, Sdacha, SummBonusForSave, Bonus: Double; Address, Idn: string; TypeOplata: Integer; TotalBonus: Double; FTovar: Boolean; REQUEST_NUMBER: string): string;
var
  Terminal: Integer;
begin
  if SummZakaz>SummCash+SummNonCash+SummBonusForSave then
  begin
    Result := 'Ошибка TIS: Сумма всех товаров больше суммы оплаты. Операция не может быть завершена.';
    exit;
  end;

  Result := '';
  discountAllVal := 0;
  if FTovar then
  begin
    ReportsDM.spUniversal.Close;
    ReportsDM.spUniversal.ParamByName('zakaz_').AsInt64 := Zakaz;
    if not OpenSp(ReportsDM.spUniversal, False) then
      Exit;
    KKMTIS.JsonItems := '';
    KKMTIS.err := '';
    with ReportsDM.spUniversal do
    begin
      ReportsDM.NDS_SUM := 0;
      First;
      while not eof do
      begin
        //Itemsadd(Position: string; Price, Sum, Amount, SUMMSkidka, NDS, NDSSUMM: real);
        KKMTIS.Itemsadd(FieldByName('name').AsString,
        FieldByName('price').AsFloat,
        FieldByName('price').AsFloat
         * FieldByName('amount').AsFloat,
        FieldByName('amount').AsFloat,
        FieldByName('DISCOUNT_TENGE').AsFloat * FieldByName('amount').AsFloat, FieldByName('NDS').AsFloat,
        FieldByName('NDS_SUMM').AsFloat, FieldByName('MARK_CODE').AsString);

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;
        ReportsDM.NDS_SUM := ReportsDM.NDS_SUM + FieldByName('NDS_SUMM').AsFloat;
        Next;
      end;
    end;
  end
  else
  begin
    if not OpenSp(MainDM.SQLTMP, False) then
      Exit;
    KKMTIS.JsonItems := '';
    with MainDM.SQLTMP do
    begin
      ReportsDM.NDS_SUM := 0;
      First;
      while not eof do
      begin
        //Itemsadd(Position: string; Price, Sum, Amount, SUMMSkidka, NDS, NDSSUMM: real);
        KKMTIS.Itemsadd(FieldByName('name').AsString,
        FieldByName('price').AsFloat,
        FieldByName('price').AsFloat
         * FieldByName('amount').AsFloat,
        FieldByName('amount').AsFloat,
        FieldByName('DISCOUNT_TENGE').AsFloat * FieldByName('amount').AsFloat, FieldByName('NDS').AsFloat,
        FieldByName('NDS_SUMM').AsFloat, FieldByName('MARK_CODE').AsString);

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;
        ReportsDM.NDS_SUM := ReportsDM.NDS_SUM + FieldByName('NDS_SUMM').AsFloat;
        Next;
      end;
     
    end;
  end;
  case TypeOplata of
    0: Terminal := 0;
    1, 2: Terminal := 1;
    3: Terminal := 2;
  end;
  Result := KKMTIS.PostTicket(Zakaz, 2, Sdacha, SummCash, SummNonCash, SummZakaz, SummBonusForSave, Idn, '', NdsValue, ReportsDM.NDS_SUM, Terminal, TypeOplata, REQUEST_NUMBER);
  if Result <> '' then
    Exit
  else
    KKMTIS.JsonItems := '';
end;

function PrintBillReKassa(Zakaz : Int64; SummCash, SummNonCash, SummZakaz, Sdacha, SummBonus, Bonus: Double; Adress, Idn: string; FTovar: Boolean; Txt : String = ''; TotalBonus: Double = 0): string;
begin
  KKMReKassa.err := '';
  Result := '';
  discountAllVal := 0;

  // непонятно зачем cbFiscalMode.Checked, в будущем можно убрать !!!
  Result := CheckRekassa();
  if Result <> '' then begin
    exit;
  end;

  if SummZakaz>SummCash+SummNonCash+SummBonus then
  begin
    Result := 'Ошибка reKassa: Сумма всех товаров больше суммы оплаты. Операция не может быть завершена.';
    exit;
  end;

  if FTovar then
  begin
    ReportsDM.spUniversal.Close;
    ReportsDM.spUniversal.ParamByName('zakaz_').AsInt64 := Zakaz;
    if not OpenSp(ReportsDM.spUniversal, False) then
      Exit;
    //KKMReKassa
    if not Assigned(KKMReKassa) then
      KKMReKassa := TReKassa.Create(Login, Pass, PinCode, Test_Rekassa);
    if not KKMReKassa.iscon then
    begin
      Result := 'Ошибка reKassa: Нет связи, проверьте соединение с интернет!';
      Exit;
    end;
    KKMReKassa.JsonItems := '';
    with ReportsDM.spUniversal do begin
      ReportsDM.NDS_SUM := 0;
      First;
      while not eof do
      begin
        KKMReKassa.Itemsadd(FieldByName('name').AsString,
        FieldByName('price').AsFloat,
        (FieldByName('price').AsFloat
         * FieldByName('amount').AsFloat),
        (FieldByName('amount').AsFloat), FieldByName('DISCOUNT_PERC').AsFloat,
        FieldByName('DISCOUNT_TENGE').AsFloat, FieldByName('NDS').AsFloat,
        FieldByName('NDS_SUMM').AsFloat);

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;
        ReportsDM.NDS_SUM := ReportsDM.NDS_SUM + FieldByName('NDS_SUMM').AsFloat;
        Next;
      end;
    end;
  end
  else
  begin
    if not OpenSp(MainDM.SQLTMP, False) then
      Exit;
    //KKMReKassa
    if not Assigned(KKMReKassa) then
      KKMReKassa := TReKassa.Create(Login, Pass, PinCode, Test_Rekassa);
    if not KKMReKassa.iscon then
    begin
      Result := 'Ошибка reKassa: Нет связи, проверьте соединение с интернет!';
      Exit;
    end;
    KKMReKassa.JsonItems := '';
    with MainDM.SQLTMP do begin
      ReportsDM.NDS_SUM := 0;
      First;
      while not eof do
      begin
        KKMReKassa.Itemsadd(FieldByName('name').AsString,
        FieldByName('price').AsFloat,
        (FieldByName('price').AsFloat
         * FieldByName('amount').AsFloat),
        (FieldByName('amount').AsFloat), FieldByName('DISCOUNT_PERC').AsFloat,
        FieldByName('DISCOUNT_TENGE').AsFloat, FieldByName('NDS').AsFloat,
        FieldByName('NDS_SUMM').AsFloat);

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;
        ReportsDM.NDS_SUM := ReportsDM.NDS_SUM + FieldByName('NDS_SUMM').AsFloat;
        Next;
      end;
    end;
  end;
  if KKMReKassa.GetClosedShift(False) then
  begin
    Result := 'Ошибка reKassa: Чек не может быть отправлен в ОФД, так как смена '+
    'превысила 24 часа. Закройте смену.';
    exit;
  end;

  //Оплата (operation: string; Sdacha, CashSum, NoCashSum, SUMZakaz: integer)
  if not KKMReKassa.PostTicket('OPERATION_SELL', Sdacha, SummCash,
  SummNonCash, SummZakaz, SummBonus, DomainType, Idn) then
  begin
    Result := 'Ошибка reKassa: Чек не был отправлен в ОФД. Детали: ' + KKMReKassa.err;
    Exit;
  end
  else
  begin
    KKMReKassa.JsonItems := '';
  end;
end;

function PrintBillAtolKKM(Zakaz : Int64; SummCash, SummNonCash: Double; FTovar: Boolean; Txt : String = '') : String;
var
  //str : string;
  summAll : double;
begin
  Result := '';
  discountAllVal := 0;
  KKMPrinter.NewDocument;
  if FTovar then
  begin
    ReportsDM.spUniversal.ParamByName('zakaz_').AsInt64 := Zakaz;
    if not OpenSp(ReportsDM.spUniversal, False) then
      Exit;

    with ReportsDM.spUniversal do begin
      First;
      while not eof do begin
        Result := KKMPrinter.Payment(FieldByName('name').AsString, FieldByName('amount').AsFloat,
                                  FieldByName('price').AsFloat, FieldByName('discount_tenge').AsFloat);

        if Result <> '' then begin
          //MessageDlg(Result, mtWarning, [mbOk], 0);
          Exit;
        end;

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;
        summAll := summAll + FieldByName('amount').AsFloat * FieldByName('price').AsFloat;
        Next;
      end;
    end;
  end
  else
  begin
    if not OpenSp(MainDM.SQLTMP, False) then
      Exit;

    with MainDM.SQLTMP do begin
      First;
      while not eof do begin
        Result := KKMPrinter.Payment(FieldByName('name').AsString, FieldByName('amount').AsFloat,
                                  FieldByName('price').AsFloat, FieldByName('discount_tenge').AsFloat);

        if Result <> '' then begin
          //MessageDlg(Result, mtWarning, [mbOk], 0);
          Exit;
        end;

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;
        summAll := summAll + FieldByName('amount').AsFloat * FieldByName('price').AsFloat;
        Next;
      end;
    end;
  end;
  Result := KKMPrinter.CloseCheckSumm(SummCash, SummNonCash, summAll, discountAllVal);
  if Result <> '' then begin
    //MessageDlg(Result, mtWarning, [mbOk], 0);
    Exit;
  end;
end;

function PrintBillStrihKKM(Zakaz: Int64; SummCash, SummNonCash, SummBonusForSave,
Bonus, TotalBonus: Double; FTovar: Boolean; Txt : String = ''; Idn : String = '') : String;
var
  //str : string;
  cutMarkCode : integer;
  summAll, summBonus : double;
  NDS: Integer;
  txtNum : string;
begin
  Result := '';

  if not GetProcess('WebCash.PrintModule.Window.exe') then begin
    if CheckPrintDeviceFr = 3 then
      Result := 'Не запущен модуль печати WebKassa. Продолжение невозможно.'
    else
      Result := 'Не запущен модуль печати LightKassa. Продолжение невозможно.';
    Exit;
  end;

  discountAllVal := 0;
  KKMPrinterStrih.CancelCheckIf;

  if CheckPrintDeviceFr in [2,3] then
    cutMarkCode := 1
  else
    cutMarkCode := 0;
  if NdsValue>0 then
    NDS := 1
  else
    NDS := 0;
  if FTovar then
  begin
    ReportsDM.spUniversal.ParamByName('zakaz_').AsInt64 := Zakaz;
    if not OpenSp(ReportsDM.spUniversal, False) then
      Exit;
    with ReportsDM.spUniversal do begin
      First;
      while not eof do begin

        Result := KKMPrinterStrih.Payment(FieldByName('name').AsString, FieldByName('amount').AsFloat,
                                  FieldByName('price').AsFloat - FieldByName('discount_tenge').AsFloat, 0, // FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat,
                                  NDS, 0, FieldByName('MARK_CODE').AsString, cutMarkCode);

        if Result <> '' then begin
          //MessageDlg(Result, mtWarning, [mbOk], 0);
          Exit;
        end;

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;

        summAll := summAll + FieldByName('amount').AsFloat * FieldByName('price').AsFloat;
        summBonus := SummBonusForSave;
        //str := KKMPrinterStrih.Discount(FieldByName('discount_tenge').AsFloat * FieldByName('amount').AsFloat, FieldByName('name').AsString);
        Next;
      end;
    end;
  end
  else
  begin
    if not OpenSp(MainDM.SQLTMP, False) then
      Exit;
    with MainDM.SQLTMP do
    begin
      First;
      while not eof do begin

        Result := KKMPrinterStrih.Payment(FieldByName('name').AsString, FieldByName('amount').AsFloat,
                                  FieldByName('price').AsFloat - FieldByName('discount_tenge').AsFloat, 0, // FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat,
                                  NDS, 0, FieldByName('MARK_CODE').AsString, cutMarkCode);

        if Result <> '' then begin
          //MessageDlg(Result, mtWarning, [mbOk], 0);
          Exit;
        end;

        discountAllVal := discountAllVal + FieldByName('amount').AsFloat * FieldByName('discount_tenge').AsFloat;

        summAll := summAll + FieldByName('amount').AsFloat * FieldByName('price').AsFloat;
        summBonus := SummBonusForSave;
        //str := KKMPrinterStrih.Discount(FieldByName('discount_tenge').AsFloat * FieldByName('amount').AsFloat, FieldByName('name').AsString);
        Next;
      end;
    end;
  end;

  txtNum := 'Продажа №: ' + IntToStr(Zakaz);
  if Txt <> '' then begin
    Txt := txtNum + '------------------'#13#10 +
      'Адрес доставки: ' + Txt + #13#10 + '------------------';
  end
  else
    Txt := txtNum;

  Result := KKMPrinterStrih.CloseCheckSumm(SummCash, SummNonCash, summAll, discountAllVal, SummBonusForSave, Bonus, TotalBonus, Txt, Idn);
  if Result <> '' then begin
    //MessageDlg(Result, mtWarning, [mbOk], 0);
    Exit;
  end;
end;

function RekassaReportX(IDReport: integer; CloseShift: Boolean): Boolean;
var
  Printed: boolean;
  BillWidth: integer;
begin
  Result := false;
  Printed := True;
  if PrinterRekassa.Name = '' then
  begin
    MessageDlg('Чековый принтер не настроен! Укажите его в настройках программы! Печать чеков невоможна!', mtWarning, [mbOk], 0);
    Exit;
  end;
  with ReportsDM do
  begin
    case IDReport of
      75:
      begin
        if PrinterRekassa.BillWidth = '80 мм' then
          BillWidth := 0
        else if PrinterRekassa.BillWidth = '58 мм' then
          BillWidth := 1
        else
          BillWidth := 2;

        case BillWidth of
          0:
          begin
            LoadFastReport(Report, 84);
            PrepareReport(84);
          end;
          1:
          begin
            LoadFastReport(Report, 75);
            PrepareReport(75);
          end;
          else
          begin
            LoadFastReport(Report, 85);
            PrepareReport(85);
          end;
        end;
      end;
      76:
      begin
        if PrinterRekassa.BillWidth = '80 мм' then
          BillWidth := 0
        else if PrinterRekassa.BillWidth = '58 мм' then
          BillWidth := 1
        else
          BillWidth := 2;

        case BillWidth of
          0:
          begin
            LoadFastReport(Report, 86);
            PrepareReport(86);
          end;
          1:
          begin
            LoadFastReport(Report, 76);
            PrepareReport(76);
          end;
          else
          begin
            LoadFastReport(Report, 87);
            PrepareReport(87);
          end;
        end;
      end;
    end;
    FBillSdvig := PrinterRekassa.BillSdvig;
    if not Assigned(KKMReKassa) then
      KKMReKassa := TReKassa.Create(Login, Pass, PinCode, Test_Rekassa);
    //Получаем отчет Х
    if KKMReKassa.GetClosedShift(CloseShift) then
    begin
      if CloseShift then
      begin
        MessageDlg('Ошибка reKassa: Необходимо открыть смену в ОФД', mtError, [mbOK], 0);
        Exit;
      end;
    end;
    if not KKMReKassa.GetReportX() then
    begin
      //MessageDlg(KKMReKassa.err, mtWarning, [mbOK], 0);
      Exit;
    end
    else
    begin
      KKMReKassa.ParseReportX(KKMReKassa.ReportX);
      if not mdReportX.Active then
        mdReportX.Open;
      if mdReportX.RecordCount >0 then
      begin
        with mdReportX do
        begin
          First;
          while not Eof do
            Delete;
        end;
      end;
      //Снятие денег и вложение в кассу
      if KKMReKassa.SUM_MW>0 then
      begin
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'Сумма';
        mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.SUM_MW, -2));
        mdReportX.Post;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
        mdReportX.FieldByName('Values').AsString := IntToStr(KKMReKassa.COUNT_MW);
        mdReportX.Post;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ИЗЪЯТИЕ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      if KKMReKassa.SUM_MD>0 then
      begin
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'Сумма';
        mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.SUM_MD, -2));
        mdReportX.Post;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
        mdReportX.FieldByName('Values').AsString := IntToStr(KKMReKassa.COUNT_MD);
        mdReportX.Post;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ВНЕСЕНИЕ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;

      //Возврат покупки
      if (KKMReKassa.B_BUY_RETURN>0) or (KKMReKassa.BB_CARD_RETURN>0) or (KKMReKassa.BB_MOBILE_RETURN>0) then
      begin
        if KKMReKassa.BB_MOBILE_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Мобильные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.BB_MOBILE_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.BB_CARD_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.BB_CARD_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.B_BUY_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_BUY_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.COUNT_TICKET_RETURN_BUY>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMReKassa.COUNT_TICKET_RETURN_BUY);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ВОЗВРАТ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      //Покупка
      if (KKMReKassa.B_BUY>0) or (KKMReKassa.BB_CARD>0) or (KKMReKassa.BB_MOBILE>0) then
      begin
        if KKMReKassa.BB_MOBILE>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Мобильные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.BB_MOBILE, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.BB_CARD>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.BB_CARD, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.B_BUY>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_BUY, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.COUNT_TICKET_BUY>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMReKassa.COUNT_TICKET_BUY);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ПОКУПКА';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      //Возврат продажи
      if (KKMReKassa.B_SELL_RETURN>0) or (KKMReKassa.B_CARD_RETURN>0) or (KKMReKassa.B_MOBILE_RETURN>0) then
      begin
        if KKMReKassa.B_MOBILE_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Мобильные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_MOBILE_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.B_CARD_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_CARD_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.B_SELL_RETURN>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_SELL_RETURN, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.COUNT_TICKET_RETURN_SELL>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMReKassa.COUNT_TICKET_RETURN_SELL);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ВОЗВРАТ';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      //Продажа
      if (KKMReKassa.B_SELL>0) or (KKMReKassa.B_CARD>0) or (KKMReKassa.B_MOBILE>0)
      then
      begin
        if KKMReKassa.B_MOBILE>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Мобильные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_MOBILE, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.B_CARD>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Картой';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_CARD, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.B_SELL>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Наличные';
          mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(KKMReKassa.B_SELL, -2));
          mdReportX.Post;
        end;
        if KKMReKassa.COUNT_TICKET_SELL>0 then
        begin
          mdReportX.Insert;
          mdReportX.FieldByName('Names').AsString := 'Кол-во чеков';
          mdReportX.FieldByName('Values').AsString := IntToStr(KKMReKassa.COUNT_TICKET_SELL);
          mdReportX.Post;
        end;
        mdReportX.Insert;
        mdReportX.FieldByName('Names').AsString := 'ПРОДАЖА';
        mdReportX.FieldByName('Values').AsString := '';
        mdReportX.Post;
      end;
      if CloseShift then
      begin
        sleep(3000);
        //Закрыть смену
        if not KKMReKassa.PostCloseShift() then
          //KKMReKassa.Loged('Ошибка reKassa: Не удалось закрыть смену');
          Exit;
      end;
      if Printed then
      begin
        Report.PrepareReport;
        Report.PrintOptions.ShowDialog := False;
        if Trim(PrinterRekassa.Name)<>'' then
          Report.PrintOptions.Printer := PrinterRekassa.Name;
        Report.SelectPrinter();
        Report.Print;
      end
      else
        Report.ShowReport;
      Result := True;
    end;
  end;
end;

function ReturnSellReKassa(SummCash, SummNonCash: double; idn: string): string;
var
  NDS: Double;
begin
  if KKMReKassa.iscon then
  begin
    if not KKMReKassa.GetClosedShift(False) then
    begin
      //Оплата (operation: string; Sdacha, CashSum, NoCashSum, SUMZakaz: integer)
      if not KKMReKassa.PostTicket('OPERATION_SELL_RETURN', 0, (SummCash),

          (SummNonCash), (SummCash + SummNonCash), 0, DomainType, Idn)
      then
        result := KKMReKassa.err
      else
      begin
        KKMReKassa.JsonItems := '';
        //Распечатать или отправить чек
        if ReportsDM.SaveQR(KKMReKassa.qrCode) then
        begin
          if not ReportsDM.mdReportX.Active then
              ReportsDM.mdReportX.Open;

          if ReportsDM.mdReportX.RecordCount >0 then
          begin
            with ReportsDM.mdReportX do
            begin
              First;
              while not Eof do
                Delete;
            end;
          end;
          if SummCash>0 then
          begin
            ReportsDM.mdReportX.Insert;
            ReportsDM.mdReportX.FieldByName('Names').AsString := 'Наличными';
            ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(SummCash, -2));
            ReportsDM.mdReportX.Post;
          end;
          if SummNonCash>0 then
          begin
            ReportsDM.mdReportX.Insert;
            ReportsDM.mdReportX.FieldByName('Names').AsString := 'На карту';
            ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(SummNonCash, -2));
            ReportsDM.mdReportX.Post;
          end;
          if SummCash + SummNonCash > 0 then
          begin
            ReportsDM.mdReportX.Insert;
            ReportsDM.mdReportX.FieldByName('Names').AsString := 'ИТОГ';
            ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(SummCash + SummNonCash, -2));
            ReportsDM.mdReportX.Post;
          end;
          NDS := 0;
          with PrihodTovaraNForm.spZakazTemp do
          begin
            First;
            while not Eof do
            begin
              ReportsDM.mdReportX.Insert;
              ReportsDM.mdReportX.FieldByName('Names').AsString := FieldByName('PRODUCT_NAME').AsString +#13#10+ ' ' +
              FloatToStr(FieldByName('AMOUNT').AsFloat) + ' шт.x' + FloatToStr(RoundTo(FieldByName('price').AsFloat, -2));
              ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(FieldByName('price').AsFloat * FieldByName('AMOUNT').AsFloat, -2));
              ReportsDM.mdReportX.Post;
              NDS := NDS + FieldByName('NDS_SUMM').AsFloat;
              Next;
            end;
          end;
          if NDS > 0 then
          begin
            ReportsDM.mdReportX.Insert;
            ReportsDM.mdReportX.FieldByName('Names').AsString := 'в т.ч. НДС';
            ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(NDS, -2));
            ReportsDM.mdReportX.Post;
          end;
          ReportReturnSell();
        end;
      end;
    end
    else
    begin
      Result := 'Ошибка reKassa: Чек не может быть отправлен в ОФД, так как смена '+
      'превысила 24 часа. Закройте смену.';
    end;
  end
  else
  begin
    Result := 'Ошибка reKassa: Нет связи, проверьте соединение с интернетом!';
  end;
end;

function ReportReturnSell(): string;
var
  BillWidth: integer;
begin
  Result := '';
  if PrinterRekassa.Name = '' then
  begin
    Result := 'Чековый принтер не настроен! Укажите его в настройках программы! '+
    'Печать чеков невоможна!';
    Exit;
  end;

  if PrinterRekassa.BillWidth = '80 мм' then
    BillWidth := 0
  else if PrinterRekassa.BillWidth = '58 мм' then
    BillWidth := 1
  else
    BillWidth := 2;
  with ReportsDM do
  begin
    case BillWidth of
      0:
      begin
        LoadFastReport(Report, 80);
        PrepareReport(80);
      end;
      1:
      begin
        LoadFastReport(Report, 77);
        PrepareReport(77);
      end;
      else
      begin
        LoadFastReport(Report, 81);
        PrepareReport(81);
      end;
    end;
    FBillSdvig := PrinterRekassa.BillSdvig;

    Report.PrepareReport;
    //Report.ShowReport(True);
    Report.PrintOptions.ShowDialog := False;
    if Trim(PrinterRekassa.Name)<>'' then
      Report.PrintOptions.Printer := PrinterRekassa.Name;
    Report.SelectPrinter();
    Report.Print;
  end;
end;

function ReportReplaceMoney(CashIn, CashOut: real): string;
var
  BillWidth: integer;
begin
  result := '';
  if PrinterRekassa.Name = '' then
  begin
    Result := 'Чековый принтер не настроен! Укажите его в настройках программы! '+
    'Печать чеков невоможна!';
    Exit;
  end;
  if PrinterRekassa.BillWidth = '80 мм' then
    BillWidth := 0
  else if PrinterRekassa.BillWidth = '58 мм' then
    BillWidth := 1
  else
    BillWidth := 2;
  with ReportsDM do
  begin
    case BillWidth of
      0:
      begin
        LoadFastReport(Report, 82);
        PrepareReport(82);
      end;
      1:
      begin
        LoadFastReport(Report, 74);
        PrepareReport(74);
      end;
      else
      begin
        LoadFastReport(Report, 83);
        PrepareReport(83);
      end;
    end;
    FBillSdvig := PrinterRekassa.BillSdvig;
    if not mdReportX.Active then
        mdReportX.Open;
    if mdReportX.RecordCount >0 then
    begin
      with mdReportX do
      begin
        First;
        while not Eof do
          Delete;
      end;
    end;
    //Продажа
    if CashIn>0 then
    begin
      mdReportX.Insert;
      mdReportX.FieldByName('Names').AsString := 'Внесение денег в кассу';
      mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(CashIn, -2));
      mdReportX.Post;
    end
    else
    begin
      mdReportX.Insert;
      mdReportX.FieldByName('Names').AsString := 'Изъятие денег из кассы';
      mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(CashOut, -2));
      mdReportX.Post;
    end;

    Report.PrepareReport;
    Report.PrintOptions.ShowDialog := False;
    if Trim(PrinterRekassa.Name)<>'' then
      Report.PrintOptions.Printer := PrinterRekassa.Name;
    Report.SelectPrinter();
    Report.Print;
  end;
end;

function ReplaceMoneyReKassa(FActionStat: Integer; Sum: Double): string;
begin
  Result := '';
  KKMReKassa.err := '';
  if Assigned(KKMReKassa) then
  begin
    if not KKMReKassa.iscon then
    begin
      Result := 'Ошибка reKassa: Нет связи, проверьте соединение с интернет!';
      Exit;
    end;
    if FActionStat = 0 then
    begin
      if KKMReKassa.ReplaceMoney(0, Sum) then
      begin
        ReportReplaceMoney(Sum, 0);
        Result := KKMReKassa.err;
      end
      else
      begin
        Result := KKMReKassa.err;
      end;
    end
    else
    begin
      if KKMReKassa.ReplaceMoney(1, Sum) then
      begin
        ReportReplaceMoney(0, Sum);
        Result := KKMReKassa.err;
      end
      else
      begin
        Result := KKMReKassa.err;
      end;
    end;
  end;
end;

function ReplaceMoneyTIS(FActionStat: Integer; Sum: Double): string;
begin
  Result := '';
  if Assigned(KKMTIS) then
  begin
    if FActionStat = 0 then
    begin
      Result := KKMTIS.ReplaceMoney(0, Round(Sum));
      if Result = '' then
        ReportReplaceMoneyTis(Sum, 0);
    end
    else
    begin
      Result := KKMTIS.ReplaceMoney(1, Round(Sum));
      if Result = '' then
        ReportReplaceMoneyTis(0, Sum);
    end;
  end;
  Log('[TIS] - Внесение/Изъятие денег произведено успешно.');
end;

function ReportReplaceMoneyTis(CashIn, CashOut: real): string;
var
  BillWidth: integer;
begin
  result := '';
  if PrinterRekassa.Name = '' then
  begin
    Result := 'Чековый принтер не настроен! Укажите его в настройках программы! '+
    'Печать чеков невоможна!';
    Exit;
  end;
  if PrinterRekassa.BillWidth = '80 мм' then
    BillWidth := 0
  else if PrinterRekassa.BillWidth = '58 мм' then
    BillWidth := 1
  else
    BillWidth := 2;
  with ReportsDM do
  begin
    case BillWidth of
      0:
      begin
        LoadFastReport(Report, 99);
        PrepareReport(99);
      end;
      1:
      begin
        LoadFastReport(Report, 91);
        PrepareReport(91);
      end;
      else
      begin
        LoadFastReport(Report, 100);
        PrepareReport(100);
      end;
    end;
    FBillSdvig := PrinterRekassa.BillSdvig;
    if not mdReportX.Active then
        mdReportX.Open;
    if mdReportX.RecordCount >0 then
    begin
      with mdReportX do
      begin
        First;
        while not Eof do
          Delete;
      end;
    end;
    //Продажа
    if CashIn>0 then
    begin
      mdReportX.Insert;
      mdReportX.FieldByName('Names').AsString := 'Внесение денег в кассу';
      mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(CashIn, -2));
      mdReportX.Post;
    end
    else
    begin
      mdReportX.Insert;
      mdReportX.FieldByName('Names').AsString := 'Изъятие денег из кассы';
      mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(CashOut, -2));
      mdReportX.Post;
    end;

    Report.PrepareReport;
    Report.PrintOptions.ShowDialog := False;
    if Trim(PrinterRekassa.Name)<>'' then
      Report.PrintOptions.Printer := PrinterRekassa.Name;
    Report.SelectPrinter();
    Report.Print;
  end;
end;

function ReturnSellTIS(SummCash, SummNonCash: double; idn, TransID: string; Zakaz: Int64; NDSVal, NDSSUM: Double; TypeOplata: Integer; REQUEST_NUMBER: string): string;
var
  NDS: Double;
begin
  Result := KKMTIS.PostTicket(Zakaz, 3, 0, SummCash, SummNonCash, (SummCash + SummNonCash), 0, Idn, TransID, NDSVal, NDSSUM, Terminal, TypeOplata, REQUEST_NUMBER);
  if Result <> EmptyStr then
    Exit
  else
  begin
    KKMTIS.JsonItems := '';
    //Распечатать или отправить чек
    if ReportsDM.SaveQR(KKMTIS.qrCode) then
    begin
      if not ReportsDM.mdReportX.Active then
          ReportsDM.mdReportX.Open;

      if ReportsDM.mdReportX.RecordCount >0 then
      begin
        with ReportsDM.mdReportX do
        begin
          First;
          while not Eof do
            Delete;
        end;
      end;
      if SummCash>0 then
      begin
        ReportsDM.mdReportX.Insert;
        ReportsDM.mdReportX.FieldByName('Names').AsString := 'Наличными';
        ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(SummCash, -2));
        ReportsDM.mdReportX.Post;
      end;
      if SummNonCash>0 then
      begin
        ReportsDM.mdReportX.Insert;
        ReportsDM.mdReportX.FieldByName('Names').AsString := 'На карту';
        ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(SummNonCash, -2));
        ReportsDM.mdReportX.Post;
      end;
      if SummCash + SummNonCash > 0 then
      begin
        ReportsDM.mdReportX.Insert;
        ReportsDM.mdReportX.FieldByName('Names').AsString := 'ИТОГ';
        ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(SummCash + SummNonCash, -2));
        ReportsDM.mdReportX.Post;
      end;
      NDS := 0;
      with PrihodTovaraNForm.spZakazTemp do
      begin
        First;
        while not Eof do
        begin
          ReportsDM.mdReportX.Insert;
          ReportsDM.mdReportX.FieldByName('Names').AsString := FieldByName('PRODUCT_NAME').AsString +#13#10+ ' ' +
          FloatToStr(FieldByName('AMOUNT').AsFloat) + ' шт.x' + FloatToStr(RoundTo(FieldByName('price').AsFloat, -2));
          ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(FieldByName('price').AsFloat * FieldByName('AMOUNT').AsFloat, -2));
          ReportsDM.mdReportX.Post;
          NDS := NDS + FieldByName('NDS_SUMM').AsFloat;
          Next;
        end;
      end;
      if NDS > 0 then
      begin
        ReportsDM.mdReportX.Insert;
        ReportsDM.mdReportX.FieldByName('Names').AsString := 'в т.ч. НДС';
        ReportsDM.mdReportX.FieldByName('Values').AsString := FloatToStr(RoundTo(NDS, -2));
        ReportsDM.mdReportX.Post;
      end;
      ReportReturnSellTIS();
    end;
  end;
end;

function ReportReturnSellTIS(): string;
var
  BillWidth: integer;
begin
  Result := '';
  if PrinterRekassa.Name = '' then
  begin
    Result := 'Чековый принтер не настроен! Укажите его в настройках программы! '+
    'Печать чеков невоможна!';
    Exit;
  end;

  if PrinterRekassa.BillWidth = '80 мм' then
    BillWidth := 0
  else if PrinterRekassa.BillWidth = '58 мм' then
    BillWidth := 1
  else
    BillWidth := 2;
  with ReportsDM do
  begin
    case BillWidth of
      0:
      begin
        LoadFastReport(Report, 97);
        PrepareReport(97);
      end;
      1:
      begin
        LoadFastReport(Report, 94);
        PrepareReport(94);
      end;
      else
      begin
        LoadFastReport(Report, 98);
        PrepareReport(98);
      end;
    end;
    FBillSdvig := PrinterRekassa.BillSdvig;

    Report.PrepareReport;
    //Report.ShowReport(True);
    Report.PrintOptions.ShowDialog := False;
    if Trim(PrinterRekassa.Name)<>'' then
      Report.PrintOptions.Printer := PrinterRekassa.Name;
    Report.SelectPrinter();
    Report.Print;
  end;
end;

end.
