unit unLog;

interface

uses pFIBDataset, System.SysUtils, dxmdaset;

type
  TRec = record
    ZDate: TDate;
    ZTime : TTime;
    Osnovanie : String;
    Postavshik : Int64;
    PostavshikName : String;
    Note       : String;
    Address    : String;
    Summ       : Double;
    SummFact   : Double;
    Bonus      : Double;
    BonusPayed : Double;
    Statya     : Int64;
    StatyaName : String;
    StatyaSumm : Double;
    NotAddMinusOstatok : Boolean;
    ByRecipe   : Boolean;
    Reserv     : Boolean;
    SummCurrency : Double;
    GTochka : Int64;
    GTochkaName : String;
    GNonCashPayType : Int64;
    GNonCashPayTypeName : String;
  end;

  TKassaRec = record
    StatyaName  : String;
    PayTypeName : String;
    Kdate       : TDate;
    Summa       : Double;
    Note        : String;
    OfficialName : String;
  end;

  TClientRec = record
    Category      : Int64;
    CategoryName  : String;
    Name : String;
    BDate       : TDate;
    Phone       : String;
    Discount    : Double;
    CameFrom    : Int64;
    CameFromName    : String;
    Note        : String;
    ByDefault   : Integer;
    CardNum     : String;
    BonusVal    : Double;
    BonusSumm   : Double;
    MaxPayBonus : Double;
    ContrAgentType : Int64;
    ContrAgentTypeName : String;
    FullName     : String;
    IDN       : String;
    Kbe       : String;
    Beznal    : Integer;
    SmsNotify : Integer;
    SmsHBNotify : Integer;
    DogovorNum  : String;
    DogovorDate : TDate;
  end;

  TKitRec = record
    ID : Int64;
    Amount : Double;
    Price : Double;
  end;

  TTovarRec = record
    Category      : Int64;
    CategoryName  : String;
    Name : String;
    Articul: String;
    Barcode: String;
    Nomenclatur: String;
    Gunit: Int64;
    GunitName: String;
    Price: Double;
    PriceOpt: Double;
    Note: String;
    Minamount: Double;
    Packamount: Double;
    Mfcountry: String;
    Place: String;
    Salescomm: Double;
    Kodtnvd: String;
    Ismarked: Integer;
    IsTovarVes: Integer;
    IsKit: Integer;
    FastTovar: Integer;
    DoNotChargeBonus: Integer;
    Crosscode: array of String;
    DopBarcode: array of String;
    KitArr: array of TKitRec;
    Brand: String;
  end;

  TSettingsRec = record
    Country  : String;
    Formula  : String;
    ZpCalc : String;
    CanSellNol: Boolean;
    ManyFirm: Boolean;
    NotifyNol: Boolean;
    NewLineSale: Boolean;
    UseTovarPlace: Boolean;
    UseTovarNoteInSearch: Boolean;
    UseCurrency: Boolean;
    Config : String;
    BarcodeLength: String;
    DecimalCount: String;
    DoProductInSale: Boolean;
    DeliveryService: Boolean;
    ShowCostPrice: Boolean;
    PinCode: String;
    CheckPrintDevice: String;
    ComPortNumber: String;
    BaudRate: String;
    UseScales: Boolean;
    ScalesPrefix: String;
    ScalesIp: String;
    ScalesPort: String;
    Scales: String;
    SmsLogin: String;
    SmsPassword: String;
    BackupFileName: String;
    BackupPeriod: String;
    DoBackupOnStart: Boolean;
    NoNetwork: Boolean;
    Server: String;
    SyncEnabled: Boolean;
    SyncFileName: String;
    SyncInterval: Integer;
    LetDoReturnWithoutSale: Integer;
  end;

function FillInsWayBill(WType : Integer; ODate : TDate; OTime : TTime; Client : String; Summ, SummPayed,
  Bonus, BonusPayed : Double; SPin : TpFIBDataSet) : String;

function FillUpdWayBill(WType : Integer; FRecOld: TRec; ODate : TDate; OTime : TTime; Osnovanie,Client,Note,Address : String;
  Summ, SummPayed, Bonus, BonusPayed, StatyaSummPrihod : Double;
  ByRecipe, Reserv, NotAddMinusOstatok : Boolean;
  ClientId, Statya, GNonCashPayType : Int64;
  NotMinusOstatokCaption, StatyaName, GNonCashPayTypeName : string;
  mdNewTovar, mdOldTovar : TdxMemData) : String;

function FillLogProd(Mode : Integer; ODate : TDate; SPin : TpFIBDataSet) : String;

function FillLogKassa(Mode : Integer; Action : integer; FOldRec: TKassaRec; FNewRec: TKassaRec) : String;
function FillLogClient(Mode : Integer; FOldRec: TClientRec; FNewRec: TClientRec) : String;
function FillLogTovar(Mode : Integer; FOldRec: TTovarRec; FNewRec: TTovarRec;
  mdOldTovar, mdNewTovar: TdxMemData) : String;
function FillLogSettings(FOldRec: TSettingsRec; FNewRec: TSettingsRec) : String;

implementation

uses
  unCommonFunc;

function FillInsWayBill(WType : Integer; ODate : TDate; OTime : TTime; Client : String;
Summ, SummPayed, Bonus, BonusPayed : Double; SPin : TpFIBDataSet) : String;
var SP : TdxMemData;
  summa : string;
  cnt, i : integer;
begin
  Result := '';
  SP := TdxMemData.Create(nil);
  try
    SP.CopyFromDataSet(SPin);
    Result := Result + 'Дата "' + DateToStr(ODate) + '", время "' + TimeToStr(OTime) + '"';

    if Client <> '' then begin
      case WType of
        1,3,5,8 : Result := Result + ', клиент "' + Client + '"';  // продажа, выдача под реал
        6 : Result := Result + ', склад-получатель "' + Client + '"';  // продажа, выдача под реал
        4,7 : Result := Result + ', поставщик "' + Client + '"';  // продажа, выдача под реал
      end;
    end;

    Result := Result + ', сумма "' + FloatToStr(Summ) + '"';

    // если не списание и перемещение и производство
    if not (WType in [2,6,9]) then
      Result := Result + ', оплачено "' + FloatToStr(SummPayed) + '"';

    if (WType = 1) and (BonusPayed <> 0) then begin
      Result := Result + ', бонусами оплачено "' + FloatToStr(BonusPayed) + '".' + CRLF;
      if Bonus <> 0 then
        Result := Result + 'Бонусов получено "' + FloatToStr(Bonus) + '".' + CRLF;
    end
    else
      Result := Result + '.' + CRLF;

    Result := Result + CRLF + 'Товары (' + IntToStr(SP.RecordCount) + ').' + CRLF;
    SP.First;
    i := 1;

    // поставлю искуственное ограничение на 100 товаров, иначе возникает ошибка при удалении, если
    // слишком большой список товаров
    if SP.RecordCount > 100 then
      cnt := 100
    else
      cnt := SP.RecordCount;

    while i <= cnt do begin
      if WType = 9 then
        summa := FloatToStr(SP.FieldByName('amount').AsFloat * SP.FieldByName('cost_price').AsFloat)
      else
        summa := SP.FieldByName('summ').AsString;

      Result := Result + '"' + SP.FieldByName('PRODUCT_NAME').AsString + '", кол-во "' + SP.FieldByName('amount').AsString +
        '", сумма "' + summa + '".' + CRLF;
      SP.Next;
      i := i + 1;
    end;

    if SP.RecordCount > 100 then begin
      Result := Result + '...' + CRLF + 'Еще ' + IntToStr(SP.RecordCount - 100) + ' товаров.';
    end;

  finally
    SP.Close;
    Sp.Free;
  end;
end;

function FillUpdWayBill(WType : Integer; FRecOld : TRec; ODate : TDate; OTime : TTime; Osnovanie,Client,Note,Address : String;
  Summ, SummPayed, Bonus, BonusPayed, StatyaSummPrihod : Double;
  ByRecipe, Reserv, NotAddMinusOstatok : Boolean;
  ClientId, Statya, GNonCashPayType : Int64;
  NotMinusOstatokCaption, StatyaName, GNonCashPayTypeName : string;
  mdNewTovar, mdOldTovar : TdxMemData) : String;
var str, str1, logTovar, str_id : string;
begin
  Result := '';

  if Client <> '' then begin
    case WType of
      1,3,5,8 : str := 'Клиент';  // продажа, выдача под реал
      6 : str := 'Склад-получатель';  // перемещение
      4,7 : str := 'Поставщик';  // возврат товара поставщику
    end;
  end;

  case WType of
    1, 2, 6, 7 : str_id := 'zakaz_details';  // продажа, списание
    else str_id := 'sklad';
  end;

  if FRecOld.ZDate <> ODate then
    Result := Result + 'Дата изменена с "' + DateToStr(FRecOld.ZDate) + '" на "' + DateToStr(ODate) + '".' + CRLF;

  if FRecOld.ZTime <> OTime then
    Result := Result + 'Время изменено с "' + TimeToStr(FRecOld.ZTime) + '" на "' + TimeToStr(OTime) + '".' + CRLF;

  if FRecOld.Osnovanie <> Osnovanie then
    Result := Result + 'Документ-основание изменен с "' + FRecOld.Osnovanie + '" на "' + Osnovanie + '".' + CRLF;

  if FRecOld.Postavshik <> ClientId then
    Result := Result + str + ' изменен с "' + FRecOld.PostavshikName + '" на "' + Client + '".' + CRLF;

  if FRecOld.Note <> Note then
    Result := Result + 'Примечание изменено с "' + FRecOld.Note + '" на "' + Note + '".' + CRLF;

  if FRecOld.Address <> Address then
    Result := Result + 'Адрес доставки изменен с "' + FRecOld.Address + '" на "' + Address + '".' + CRLF;

  if WType = 1 then begin
    if FRecOld.Bonus <> Bonus then
      Result := Result + 'Бонусов за покупку изменено с "' + FloatToStr(FRecOld.Bonus) + '" на "' + FloatToStr(Bonus) + '".' + CRLF;

    if FRecOld.BonusPayed <> BonusPayed then
      Result := Result + 'Бонусами оплачено изменено с "' + FloatToStr(FRecOld.BonusPayed) + '" на "' + FloatToStr(BonusPayed) + '".' + CRLF;

    if FRecOld.ByRecipe <> ByRecipe then begin
      Result := Result + 'Признак "По рецепту" ';
      if ByRecipe then
        Result := Result + 'установлен'
      else
        Result := Result + 'снят';
      Result := Result + ';' + CRLF;
    end;

    if FRecOld.Reserv <> Reserv then begin
      Result := Result + 'Признак "На резерв" ';
      if Reserv then
        Result := Result + 'установлен'
      else
        Result := Result + 'снят';
      Result := Result + ';' + CRLF;
    end;
  end;

  if WType in [1, 4, 6] then begin
    if FRecOld.NotAddMinusOstatok <> NotAddMinusOstatok then begin
      Result := Result + 'Признак "' + NotMinusOstatokCaption + '" ';
      if NotAddMinusOstatok then
        Result := Result + 'установлен'
      else
        Result := Result + 'снят';
      Result := Result + ';' + CRLF;
    end;
  end;

  str := 'прихода';
  if WType in [4,5,8] then
    str := 'расхода';

  if FRecOld.Statya <> Statya then
    Result := Result + 'Статья ' + str + ' изменена с "' + FRecOld.StatyaName + '" на "' +
    StatyaName + '".' + CRLF;

  if FRecOld.StatyaSumm <> StatyaSummPrihod then
    Result := Result + 'Сумма статьи ' + str + ' изменена с "' + FloatToStr(FRecOld.StatyaSumm) + '" на "' +
    FloatToStr(StatyaSummPrihod) + '".' + CRLF;

  if FRecOld.Summ <> Summ then
    Result := Result + 'Сумма общая изменена с "' + FloatToStr(FRecOld.Summ) + '" на "' + FloatToStr(Summ) + '".' + CRLF;

  // только если продажа, проверяю безналичный способ оплаты
  if WType = 1 then begin
    if FRecOld.GNonCashPayType <> GNonCashPayType then
      Result := Result + 'Тип оплаты изменен с "' + FRecOld.GNonCashPayTypeName + '" на "' + GNonCashPayTypeName + '".' + CRLF;
  end;

  // если не списание и перемещение и производство
  if not (WType in [2,6,9]) then
    if FRecOld.SummFact <> SummPayed then
      Result := Result + 'Сумма оплаты изменена с "' + FloatToStr(FRecOld.SummFact) + '" на "' + FloatToStr(SummPayed) + '".' + CRLF;

  if mdNewTovar.RecordCount > 0 then begin   // значит что товары менялись
    mdNewTovar.Open;
    mdOldTovar.Open;
    mdNewTovar.First;
    while not mdNewTovar.Eof do begin
      if mdOldTovar.Locate(str_id, mdNewTovar.FieldByName(str_id).AsLargeInt, []) = false then
        logTovar := logTovar + 'Добавлен товар "' + mdNewTovar.FieldByName('PRODUCT_NAME').AsString + '", кол-во "' + mdNewTovar.FieldByName('amount').AsString +
          '", по цене "' + mdNewTovar.FieldByName('price').AsString + '", на сумму "' + mdNewTovar.FieldByName('summ').AsString + '".' + CRLF

      else begin
        if (mdNewTovar.FieldByName('amount').AsFloat <> mdOldTovar.FieldByName('amount').AsFloat) or
        (mdNewTovar.FieldByName('price').AsFloat <> mdOldTovar.FieldByName('price').AsFloat) or
        (mdNewTovar.FieldByName('summ').AsFloat <> mdOldTovar.FieldByName('summ').AsFloat) then begin
          logTovar := logTovar + 'Изменен товар "' + mdOldTovar.FieldByName('PRODUCT_NAME').AsString + '":' + CRLF;
          if mdNewTovar.FieldByName('amount').AsFloat <> mdOldTovar.FieldByName('amount').AsFloat then
            logTovar := logTovar + '- кол-во c "' + mdOldTovar.FieldByName('amount').AsString + '" на "' + mdNewTovar.FieldByName('amount').AsString + '";' + CRLF;
          if mdNewTovar.FieldByName('price').AsFloat <> mdOldTovar.FieldByName('price').AsFloat then
            logTovar := logTovar + '- цена c "' + mdOldTovar.FieldByName('price').AsString + '" на "' + mdNewTovar.FieldByName('price').AsString + '";' + CRLF;
          if mdNewTovar.FieldByName('summ').AsFloat <> mdOldTovar.FieldByName('summ').AsFloat then
            logTovar := logTovar + '- сумма c "' + mdOldTovar.FieldByName('summ').AsString + '" на "' + mdNewTovar.FieldByName('summ').AsString + '";' + CRLF;
        end;
      end;
      mdNewTovar.Next;
    end;

    mdOldTovar.First;
    while not mdOldTovar.Eof do begin
      if mdNewTovar.Locate(str_id, mdOldTovar.FieldByName(str_id).AsLargeInt, []) = false then
        logTovar := logTovar + 'Удален товар "' + mdOldTovar.FieldByName('PRODUCT_NAME').AsString + '", кол-во "' +
          mdOldTovar.FieldByName('amount').AsString + '", сумма "' + mdOldTovar.FieldByName('summ').AsString + '".' + CRLF;

      mdOldTovar.Next;
    end;
    mdOldTovar.Close;
    mdNewTovar.Close;

    if logTovar <> '' then
      logTovar := CRLF + 'Товары.' + CRLF + logTovar;
  end;

  Result := Result + logTovar;
end;

function FillLogProd(Mode : Integer; ODate : TDate; SPin : TpFIBDataSet) : String;
var SP : TdxMemData;
  summa : string;
begin
  Result := '';

  if Mode = 1 then begin
    SP := TdxMemData.Create(nil);
    try
      SP.CopyFromDataSet(SPin);
      SP.First;

      while not SP.Eof do begin
        summa := FloatToStr(SP.FieldByName('amount').AsFloat * SP.FieldByName('cost_price').AsFloat);
        Result := Result + '~*';
        Result := Result + 'Дата "' + DateToStr(ODate) + '", время "' + TimeToStr(Time) + '". ';
        Result := Result + 'Произведен товар "' + SP.FieldByName('PRODUCT_NAME').AsString +
          '", кол-во "' + SP.FieldByName('amount').AsString + '", себест-ть "' + summa + '".';
        SP.Next;
      end;
      Result := Result + '~*';
    finally
      SP.Close;
      Sp.Free;
    end;
  end
  else begin

    Result := Result + 'Дата "' + DateToStr(ODate) + '", время "' + TimeToStr(Time) + '". ';
    Result := Result + 'Удален товар "' + SPin.FieldByName('PRODUCT_NAME').AsString +
      '", кол-во "' + SPin.FieldByName('amount').AsString + '".';

  end;

end;

function FillLogKassa(Mode : Integer; Action : integer; FOldRec: TKassaRec; FNewRec: TKassaRec) : String;
var str : string;
begin
  if Action = 0 then
    str := 'Приход в кассу'
  else
    str := 'Расход из кассы';

  Result := Result + str + ' от "' + DateToStr(FNewRec.Kdate) + '"';

  if Mode = 1 then begin

    Result := Result + ', статья "' + FNewRec.StatyaName + '", способ расчета "' + FNewRec.PayTypeName +
      '", сумма "' + FloatToStr(FNewRec.Summa);

    if FNewRec.Note <> '' then
       Result := Result + ', примечание "' + FNewRec.Note + '"';

    Result := Result + '".';

  end
  else begin
    Result := Result + ' изменено:' + CRLF;
    if FOldRec.KDate <> FNewRec.KDate then
      Result := Result + '- дата c "' + DateToStr(FOldRec.KDate) + '" на "' + DateToStr(FNewRec.KDate) + '";' + CRLF;

    if FOldRec.StatyaName <> FNewRec.StatyaName then
      Result := Result + '- статья c "' + FOldRec.StatyaName + '" на "' + FNewRec.StatyaName + '";' + CRLF;

    if FOldRec.PayTypeName <> FNewRec.PayTypeName then
      Result := Result + '- рассчет c "' + FOldRec.PayTypeName + '" на "' + FNewRec.PayTypeName + '";' + CRLF;

    if FOldRec.Summa <> FNewRec.Summa then
      Result := Result + '- сумма c "' + FloatToStr(FOldRec.Summa) + '" на "' + FloatToStr(FNewRec.Summa) + '";' + CRLF;

    if FOldRec.Note <> FNewRec.Note then
       Result := Result + '- примечание с "' + FOldRec.Note + '" на "' + FNewRec.Note + '";';

  end
end;


function FillLogClient(Mode : Integer; FOldRec: TClientRec; FNewRec: TClientRec) : String;
begin

  if Mode = 1 then begin

    Result := 'Клиент "' + FNewRec.Name + '"';
    if FNewRec.Phone <> '' then
      Result := Result + ', телефон "' + FNewRec.Phone + '"';
    Result := Result + '.';

  end
  else begin

    Result := 'Изменено:' + CRLF;
    if FOldRec.Category <> FNewRec.Category then
      Result := Result + '- группа c "' + FOldRec.CategoryName + '" на "' + FNewRec.CategoryName + '";' + CRLF;

    if FOldRec.Name <> FNewRec.Name then
      Result := Result + '- наименование c "' + FOldRec.Name + '" на "' + FNewRec.Name + '";' + CRLF;

    if (FOldRec.Bdate <> FNewRec.Bdate) then begin
      Result := Result + '- дата рожд. c "';

      if DateToStr(FOldRec.Bdate) <> '30.12.1899' then
        Result := Result + DateToStr(FOldRec.Bdate);

      Result := Result + '" на "';

      if DateToStr(FNewRec.Bdate) <> '30.12.1899' then
        Result := Result + DateToStr(FNewRec.Bdate);

      Result := Result + '";' + CRLF;
    end;

    if FOldRec.Phone <> FNewRec.Phone then
      Result := Result + '- телефон c "' + FOldRec.Phone + '" на "' + FNewRec.Phone + '";' + CRLF;

    if FOldRec.Discount <> FNewRec.Discount then
       Result := Result + '- скидка с "' + FloatToStr(FOldRec.Discount) + '" на "' + FloatToStr(FNewRec.Discount) + '";' + CRLF;

    if FOldRec.CameFrom <> FNewRec.CameFrom then
       Result := Result + '- "Откуда пришел" с "' + FOldRec.CameFromName + '" на "' + FNewRec.CameFromName + '";' + CRLF;

    if FOldRec.Note <> FNewRec.Note then
       Result := Result + '- примечание с "' + FOldRec.Note + '" на "' + FNewRec.Note + '";' + CRLF;

    if FOldRec.ByDefault <> FNewRec.ByDefault then begin
       Result := Result + '- признак "По умолчанию" ';
       if FNewRec.ByDefault = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;

    if FOldRec.CardNum <> FNewRec.CardNum then
       Result := Result + '- номер карты с "' + FOldRec.CardNum + '" на "' + FNewRec.CardNum + '";' + CRLF;

    if FOldRec.BonusVal <> FNewRec.BonusVal then
       Result := Result + '- процент бонуса с "' + FloatToStr(FOldRec.BonusVal) + '" на "' + FloatToStr(FNewRec.BonusVal) + '";' + CRLF;

    if FOldRec.MaxPayBonus <> FNewRec.MaxPayBonus then
       Result := Result + '- макс. сумма оплаты бонусами с "' + FloatToStr(FOldRec.MaxPayBonus) + '" на "' + FloatToStr(FNewRec.MaxPayBonus) + '";' + CRLF;

    if FOldRec.BonusSumm <> FNewRec.BonusSumm then
       Result := Result + '- общая сумма бонуса с "' + FloatToStr(FOldRec.BonusSumm) + '" на "' + FloatToStr(FNewRec.BonusSumm) + '";' + CRLF;

    if FOldRec.ContrAgentType <> FNewRec.ContrAgentType then
       Result := Result + '- контрагент с "' + FOldRec.ContrAgentTypeName + '" на "' + FNewRec.ContrAgentTypeName + '";' + CRLF;

    if FOldRec.FullName <> FNewRec.FullName then
       Result := Result + '- наим-ние полное с "' + FOldRec.FullName + '" на "' + FNewRec.FullName + '";' + CRLF;

    if FOldRec.IDN <> FNewRec.IDN then
       Result := Result + '- ИИН/БИН с "' + FOldRec.IDN + '" на "' + FNewRec.IDN + '";' + CRLF;

    if FOldRec.Kbe <> FNewRec.Kbe then
       Result := Result + '- Кбе с "' + FOldRec.Kbe + '" на "' + FNewRec.Kbe + '";' + CRLF;

    if FOldRec.Beznal <> FNewRec.Beznal then begin
       Result := Result + '- признак "Безнал. рассчет" ';
       if FNewRec.Beznal = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;

    if FOldRec.DogovorNum <> FNewRec.DogovorNum then
       Result := Result + '- Номер договора с "' + FOldRec.DogovorNum + '" на "' + FNewRec.DogovorNum + '";' + CRLF;

    if (FOldRec.DogovorDate <> FNewRec.DogovorDate) then begin
      Result := Result + '- Дата договора c "';

      if DateToStr(FOldRec.DogovorDate) <> '30.12.1899' then
        Result := Result + DateToStr(FOldRec.DogovorDate);

      Result := Result + '" на "';

      if DateToStr(FNewRec.DogovorDate) <> '30.12.1899' then
        Result := Result + DateToStr(FNewRec.DogovorDate);

      Result := Result + '";' + CRLF;
    end;

    if FOldRec.SmsNotify <> FNewRec.SmsNotify then begin
       Result := Result + '- признак "Уведомлять по скидках" ';
       if FNewRec.SmsNotify = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;
    if FOldRec.SmsHBNotify <> FNewRec.SmsHBNotify then begin
       Result := Result + '- признак "Поздравлять с ДР" ';
       if FNewRec.SmsHBNotify = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;
  end
end;

function FillLogTovar(Mode : Integer; FOldRec: TTovarRec; FNewRec: TTovarRec;
  mdOldTovar, mdNewTovar: TdxMemData) : String;
var logTovar, logCross, logDopBarcode : string;
  i,j : integer;
  finded : boolean;
  str : string;
begin

  if Mode in [1,3] then begin

    Result := 'Товар "' + FNewRec.Name + '", артикул "' + FNewRec.Articul + '".';

  end
  else begin

    Result := 'Изменено:' + CRLF;
    if FOldRec.Category <> FNewRec.Category then
      Result := Result + '- группа c "' + FOldRec.CategoryName + '" на "' + FNewRec.CategoryName + '";' + CRLF;

    if FOldRec.Name <> FNewRec.Name then
      Result := Result + '- наименование c "' + FOldRec.Name + '" на "' + FNewRec.Name + '";' + CRLF;

    if FOldRec.Articul <> FNewRec.Articul then
      Result := Result + '- артикул c "' + FOldRec.Articul + '" на "' + FNewRec.Articul + '";' + CRLF;

    if FOldRec.Barcode <> FNewRec.Barcode then
       Result := Result + '- штрихкод с "' + FOldRec.Barcode + '" на "' + FNewRec.Barcode + '";' + CRLF;

    if FOldRec.Nomenclatur <> FNewRec.Nomenclatur then
       Result := Result + '- номенкл. номер с "' + FOldRec.Nomenclatur + '" на "' + FNewRec.Nomenclatur + '";' + CRLF;

    if FOldRec.Gunit <> FNewRec.Gunit then
       Result := Result + '- ед. измерения с "' + FOldRec.GunitName + '" на "' + FNewRec.GunitName + '";' + CRLF;

    if FOldRec.Price <> FNewRec.Price then
       Result := Result + '- цена продажи с "' + FloatToStr(FOldRec.Price) + '" на "' + FloatToStr(FNewRec.Price) + '";' + CRLF;

    if FOldRec.PriceOpt <> FNewRec.PriceOpt then
       Result := Result + '- цена продажи опт с "' + FloatToStr(FOldRec.PriceOpt) + '" на "' + FloatToStr(FNewRec.PriceOpt) + '";' + CRLF;

    if FOldRec.Note <> FNewRec.Note then
       Result := Result + '- примечание с "' + FOldRec.Note + '" на "' + FNewRec.Note + '";' + CRLF;

    if FOldRec.Minamount <> FNewRec.Minamount then
       Result := Result + '- мин. остаток с "' + FloatToStr(FOldRec.Minamount) + '" на "' + FloatToStr(FNewRec.Minamount) + '";' + CRLF;

    if FOldRec.PackAmount <> FNewRec.PackAmount then
       Result := Result + '- кол-во в упаковке с "' + FloatToStr(FOldRec.PackAmount) + '" на "' + FloatToStr(FNewRec.PackAmount) + '";' + CRLF;

    if FOldRec.Mfcountry <> FNewRec.Mfcountry then
       Result := Result + '- страна-производитель с "' + FOldRec.Mfcountry + '" на "' + FNewRec.Mfcountry + '";' + CRLF;

    if FOldRec.Brand <> FNewRec.Brand then
       Result := Result + '- бренд с "' + FOldRec.Brand + '" на "' + FNewRec.Brand + '";' + CRLF;

    if FOldRec.Place <> FNewRec.Place then
       Result := Result + '- место на складе с "' + FOldRec.Place + '" на "' + FNewRec.Place + '";' + CRLF;

    if FOldRec.Salescomm <> FNewRec.Salescomm then
       Result := Result + '- комиссия продавца с "' + FloatToStr(FOldRec.Salescomm) + '" на "' + FloatToStr(FNewRec.Salescomm) + '";' + CRLF;

    if FOldRec.Kodtnvd <> FNewRec.Kodtnvd then
       Result := Result + '- код ТНВЭД с "' + FOldRec.Kodtnvd + '" на "' + FNewRec.Kodtnvd + '";' + CRLF;

    if FOldRec.IsMarked <> FNewRec.IsMarked then begin
       Result := Result + '- признак "Товар маркирован" ';
       if FNewRec.IsMarked = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;

    if FOldRec.IsTovarVes <> FNewRec.IsTovarVes then begin
       Result := Result + '- признак "Весовой товар" ';
       if FNewRec.IsTovarVes = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;

    if FOldRec.IsKit <> FNewRec.IsKit then begin
       Result := Result + '- изменен тип товара на "';
       case FNewRec.IsKit of
         0: str := 'Обычный товар';
         1: str := 'Набор (составной)';
         2: str := 'Готовый продукт';
       end;
       Result := Result + str + '";' + CRLF;
    end;

    if FOldRec.FastTovar <> FNewRec.FastTovar then begin
       Result := Result + '- признак "Быстрый товар" ';
       if FNewRec.FastTovar = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;

    if FOldRec.DoNotChargeBonus <> FNewRec.DoNotChargeBonus then begin
       Result := Result + '- признак "Не начислять бонусы" ';
       if FNewRec.DoNotChargeBonus = 1 then
         Result := Result + 'установлен'
       else
         Result := Result + 'снят';
       Result := Result + ';' + CRLF;
    end;

    //кросскоды
    for I := 0 to High(FNewRec.Crosscode) do begin
      finded := false;
      for j := 0 to High(FOldRec.Crosscode) do
        if FOldRec.Crosscode[j] = FNewRec.Crosscode[i] then begin
          finded := true;
          break;
        end;

      if finded = false then
        logCross := logCross + FNewRec.Crosscode[i] + ', ';
    end;
    if logCross <> '' then
      Result := Result + '- кросс-кода добавлены "' + Copy(logCross, 1, Length(logCross)-2) + '";' + CRLF;

    logCross := '';
    for I := 0 to High(FOldRec.Crosscode) do begin
      finded := false;
      for j := 0 to High(FNewRec.Crosscode) do
        if FNewRec.Crosscode[j] = FOldRec.Crosscode[i] then begin
          finded := true;
          break;
        end;

      if finded = false then
        logCross := logCross + FOldRec.Crosscode[i] + ', ';
    end;
    if logCross <> '' then
      Result := Result + '- кросс-кода удалены "' + Copy(logCross, 1, Length(logCross)-2) + '";' + CRLF;

    //допполнительные штрихкоды
    for I := 0 to High(FNewRec.DopBarcode) do begin
      finded := false;
      for j := 0 to High(FOldRec.DopBarcode) do
        if FOldRec.DopBarcode[j] = FNewRec.DopBarcode[i] then begin
          finded := true;
          break;
        end;

      if finded = false then
        logDopBarcode := logDopBarcode + FNewRec.DopBarcode[i] + ', ';
    end;
    if logDopBarcode <> '' then
      Result := Result + '- доп. штрихкоды добавлены "' + Copy(logDopBarcode, 1, Length(logDopBarcode)-2) + '";' + CRLF;

    logDopBarcode := '';
    for I := 0 to High(FOldRec.DopBarcode) do begin
      finded := false;
      for j := 0 to High(FNewRec.DopBarcode) do
        if FNewRec.DopBarcode[j] = FOldRec.DopBarcode[i] then begin
          finded := true;
          break;
        end;

      if finded = false then
        logDopBarcode := logDopBarcode + FOldRec.DopBarcode[i] + ', ';
    end;
    if logDopBarcode <> '' then
      Result := Result + '- доп. штрихкоды удалены "' + Copy(logDopBarcode, 1, Length(logDopBarcode)-2) + '";' + CRLF;

    if Assigned(mdNewTovar) then begin   // значит что составные товары менялись
      mdNewTovar.Open;
      mdOldTovar.Open;
      mdNewTovar.First;
      while not mdNewTovar.Eof do begin
        if mdOldTovar.Locate('G_PRODUCT_KIT', mdNewTovar.FieldByName('G_PRODUCT_KIT').AsLargeInt, []) = false then
          logTovar := logTovar + 'Добавлен товар "' + mdNewTovar.FieldByName('name').AsString + '", кол-во "' + mdNewTovar.FieldByName('amount').AsString +
            '", по цене "' + mdNewTovar.FieldByName('price').AsString + '".' + CRLF

        else begin
          if (mdNewTovar.FieldByName('amount').AsFloat <> mdOldTovar.FieldByName('amount').AsFloat) or
          (mdNewTovar.FieldByName('price').AsFloat <> mdOldTovar.FieldByName('price').AsFloat) then begin
            logTovar := logTovar + 'Изменен товар "' + mdOldTovar.FieldByName('name').AsString + '":' + CRLF;
            if mdNewTovar.FieldByName('amount').AsFloat <> mdOldTovar.FieldByName('amount').AsFloat then
              logTovar := logTovar + '- кол-во c "' + mdOldTovar.FieldByName('amount').AsString + '" на "' + mdNewTovar.FieldByName('amount').AsString + '";' + CRLF;
            if mdNewTovar.FieldByName('price').AsFloat <> mdOldTovar.FieldByName('price').AsFloat then
              logTovar := logTovar + '- цена c "' + mdOldTovar.FieldByName('price').AsString + '" на "' + mdNewTovar.FieldByName('price').AsString + '";' + CRLF;
          end;
        end;
        mdNewTovar.Next;
      end;

      mdOldTovar.First;
      while not mdOldTovar.Eof do begin
        if mdNewTovar.Locate('G_PRODUCT_KIT', mdOldTovar.FieldByName('G_PRODUCT_KIT').AsLargeInt, []) = false then
          logTovar := logTovar + 'Удален товар "' + mdOldTovar.FieldByName('name').AsString + '", кол-во "' +
            mdOldTovar.FieldByName('amount').AsString + '".' + CRLF;

        mdOldTovar.Next;
      end;
      mdOldTovar.Close;
      mdNewTovar.Close;

      if logTovar <> '' then
        logTovar := CRLF + 'Состав товара.' + CRLF + logTovar;
    end;
  end;

  Result := Result + logTovar;
end;

function FillLogSettings(FOldRec: TSettingsRec; FNewRec: TSettingsRec) : String;
begin
  Result := '';
  if FOldRec.Country <> FNewRec.Country then
    Result := Result + '- страна c "' + FOldRec.Country + '" на "' + FNewRec.Country + '";' + CRLF;

  if FOldRec.Formula <> FNewRec.Formula then
    Result := Result + '- рассчет себес. товара c "' + FOldRec.Formula + '" на "' + FNewRec.Formula + '";' + CRLF;

  if FOldRec.ZpCalc <> FNewRec.ZpCalc then
    Result := Result + '- начисление ЗП продавцам c "' + FOldRec.ZpCalc + '" на "' + FNewRec.ZpCalc + '";' + CRLF;

  if FOldRec.CanSellNol <> FNewRec.CanSellNol then begin
     Result := Result + '- признак "Разрешить продавать товары с нулевым остатком" ';
     if FNewRec.CanSellNol then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.ManyFirm <> FNewRec.ManyFirm then begin
     Result := Result + '- признак "Режим нескольких компаний" ';
     if FNewRec.ManyFirm then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.NotifyNol <> FNewRec.NotifyNol then begin
     Result := Result + '- признак "Уведомлять о продаже товара с нулевой ценой" ';
     if FNewRec.NotifyNol then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.NewLineSale <> FNewRec.NewLineSale then begin
     Result := Result + '- признак "Не суммировать количество товара при продаже" ';
     if FNewRec.NewLineSale then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.UseTovarPlace <> FNewRec.UseTovarPlace then begin
     Result := Result + '- признак "Использовать поле "Место на складе" при поиске товара" ';
     if FNewRec.UseTovarPlace then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.UseTovarNoteInSearch <> FNewRec.UseTovarNoteInSearch then begin
     Result := Result + '- признак "Использовать поле "Примечание" при поиске товара" ';
     if FNewRec.UseTovarNoteInSearch then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.UseCurrency <> FNewRec.UseCurrency then begin
     Result := Result + '- признак "Дополнительно отображать закупочные цены в валюте" ';
     if FNewRec.UseCurrency then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.LetDoReturnWithoutSale <> FNewRec.LetDoReturnWithoutSale then begin
     Result := Result + '- признак "Разрешить делать возврат без продажи" ';
     if FNewRec.LetDoReturnWithoutSale = 1 then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.Config <> FNewRec.Config then
    Result := Result + '- конфигурация c "' + FOldRec.Config + '" на "' + FNewRec.Config + '";' + CRLF;

  if FOldRec.BarcodeLength <> FNewRec.BarcodeLength then
    Result := Result + '- длина штрихкода по умолчанию  c "' + FOldRec.BarcodeLength + '" на "' + FNewRec.BarcodeLength + '";' + CRLF;

  if FOldRec.DecimalCount <> FNewRec.DecimalCount then
    Result := Result + '- количество знаков после запятой в остатках товара c "' + FOldRec.DecimalCount + '" на "' + FNewRec.DecimalCount + '";' + CRLF;

  if FOldRec.DoProductInSale <> FNewRec.DoProductInSale then begin
     Result := Result + '- признак "Производить товары автоматически во время продажи" ';
     if FNewRec.DoProductInSale then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.ShowCostPrice <> FNewRec.ShowCostPrice then begin
     Result := Result + '- признак "Показывать закупочные цены в режиме кассира" ';
     if FNewRec.ShowCostPrice then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.PinCode <> FNewRec.PinCode then
    Result := Result + '- ПИН-код для удаления товаров из корзины c "' + FOldRec.PinCode + '" на "' + FNewRec.PinCode + '";' + CRLF;

  if FOldRec.CheckPrintDevice <> FNewRec.CheckPrintDevice then
    Result := Result + '- принтер чеков c "' + FOldRec.CheckPrintDevice + '" на "' + FNewRec.CheckPrintDevice + '";' + CRLF;

  if FOldRec.ComPortNumber <> FNewRec.ComPortNumber then
    Result := Result + '- COM-порт фиск. регистр-ра c "' + FOldRec.ComPortNumber + '" на "' + FNewRec.ComPortNumber + '";' + CRLF;

  if FOldRec.BaudRate <> FNewRec.BaudRate then
    Result := Result + '- скорость порта фиск. регистр-ра c "' + FOldRec.BaudRate + '" на "' + FNewRec.BaudRate + '";' + CRLF;

  if FOldRec.UseScales <> FNewRec.UseScales then begin
     Result := Result + '- признак "Использовать весы с печатью штрихкода" ';
     if FNewRec.UseScales then
       Result := Result + 'установлен'
     else
       Result := Result + 'снят';
     Result := Result + ';' + CRLF;
  end;

  if FOldRec.ScalesPrefix <> FNewRec.ScalesPrefix then
    Result := Result + '- префикс весового товара c "' + FOldRec.ScalesPrefix + '" на "' + FNewRec.ScalesPrefix + '";' + CRLF;

  if FOldRec.ScalesIp <> FNewRec.ScalesIp then
    Result := Result + '- IP-адрес весов c "' + FOldRec.ScalesIp + '" на "' + FNewRec.ScalesIp + '";' + CRLF;

  if FOldRec.ScalesPort <> FNewRec.ScalesPort then
    Result := Result + '- порт весов c "' + FOldRec.ScalesPort + '" на "' + FNewRec.ScalesPort + '";' + CRLF;

  if FOldRec.Scales <> FNewRec.Scales then
    Result := Result + '- фирма весов c "' + FOldRec.Scales + '" на "' + FNewRec.Scales + '";' + CRLF;

  if FOldRec.SmsLogin <> FNewRec.SmsLogin then
    Result := Result + '- СМС-логин c "' + FOldRec.SmsLogin + '" на "' + FNewRec.SmsLogin + '";' + CRLF;

  if FOldRec.SmsPassword <> FNewRec.SmsPassword then
    Result := Result + '- пароль;' + CRLF;

  if FOldRec.BackupFileName <> FNewRec.BackupFileName then
    Result := Result + '- папка для хранения резерв. копии c "' + FOldRec.BackupFileName + '" на "' + FNewRec.BackupFileName + '";' + CRLF;

  if FOldRec.BackupPeriod <> FNewRec.BackupPeriod then
    Result := Result + '- период резерв. копирования c "' + FOldRec.BackupPeriod + '" на "' + FNewRec.BackupPeriod + '";' + CRLF;

  if FOldRec.DoBackupOnStart <> FNewRec.DoBackupOnStart then begin
    Result := Result + '- запуск резерв. копирования изменен на ';
    if FNewRec.DoBackupOnStart then
      Result := Result + '"Делать копию при запуске программы"'
    else
      Result := Result + '"Делать копию при выходе из программы"';
    Result := Result + ';' + CRLF;
  end;

  if FOldRec.NoNetwork <> FNewRec.NoNetwork then begin
    Result := Result + '- сетевой режим изменен на ';
    if FNewRec.NoNetwork then
      Result := Result + '"Выключен"'
    else
      Result := Result + '"Включен"';
    Result := Result + ';' + CRLF;
  end;

  if FOldRec.Server <> FNewRec.Server then
    Result := Result + '- адрес сервера c "' + FOldRec.Server + '" на "' + FNewRec.Server + '";' + CRLF;

  if FOldRec.SyncEnabled <> FNewRec.SyncEnabled then begin
    Result := Result + '- режим синхронизации изменен на ';
    if FNewRec.SyncEnabled = False then
      Result := Result + '"Выключен"'
    else
      Result := Result + '"Включен"';
    Result := Result + ';' + CRLF;
  end;

  if FOldRec.SyncFileName <> FNewRec.SyncFileName then
    Result := Result + '- папка для обмена файлами синхронизации c "' + FOldRec.SyncFileName + '" на "' + FNewRec.SyncFileName + '";' + CRLF;

  if FOldRec.SyncInterval <> FNewRec.SyncInterval then begin
    Result := Result + '- интервал синхронизации изменен на ';
    case FNewRec.SyncInterval of
      300000: Result := Result + '"Каждые 5 минут"';
      600000: Result := Result + '"Каждые 10 минут"';
      900000: Result := Result + '"Каждые 15 минут"';
      1800000: Result := Result + '"Каждые 30 минут"';
      3600000: Result := Result + '"Каждый 1 час"';
      7200000: Result := Result + '"Каждые 2 часа"';
      14400000: Result := Result + '"Каждые 4 часа"';
      28800000: Result := Result + '"Каждые 8 часов"';
    end;
  end;

  if Result <> '' then
    Result := 'Изменено:' + CRLF + Result;
end;

end.
