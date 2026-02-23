unit frmSalePayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ActnList, AppEvnts, ExtCtrls,
  StdCtrls, Buttons, DB, FIBDataSet,
  pFIBDataSet, Math, FIBDatabase, pFIBDatabase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxMemo,
  cxCheckBox, cxTextEdit, cxCurrencyEdit, Vcl.Menus, System.Actions, cxClasses,
  cxButtons, cxEditRepositoryItems, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, Vcl.ComCtrls, dxmdaset;

type
  TSalePaymentForm = class(TDBDlgForm)
    tranRead: TpFIBTransaction;
    Panel3: TPanel;
    pnlButton: TPanel;
    btn7: TcxButton;
    btn8: TcxButton;
    btn9: TcxButton;
    btn4: TcxButton;
    btn5: TcxButton;
    btn6: TcxButton;
    btn1: TcxButton;
    btn2: TcxButton;
    btn3: TcxButton;
    btn0: TcxButton;
    btnBcksp: TcxButton;
    btnPnt: TcxButton;
    pnlTopSummItog: TPanel;
    lbSummSelf: TLabel;
    edBonus: TcxCurrencyEdit;
    edBonusAll: TcxCurrencyEdit;
    lbBonus: TLabel;
    lb4: TLabel;
    cbDoNotCreditBonus: TcxCheckBox;
    pnlNoteAddress: TPanel;
    pnlAddress: TPanel;
    lb8: TLabel;
    mAddress: TcxMemo;
    pnlNote: TPanel;
    lb7: TLabel;
    mNote: TcxMemo;
    pnlPayment: TPanel;
    pcPayType: TPageControl;
    tsCash: TTabSheet;
    pnl2: TPanel;
    lb5: TLabel;
    lb2: TLabel;
    lb1: TLabel;
    edSummCash: TcxCurrencyEdit;
    btnOstatokCash: TBitBtn;
    btnEqualCash: TBitBtn;
    btnEqualBonus: TBitBtn;
    btnOstatokBonus: TBitBtn;
    edSummBonus: TcxCurrencyEdit;
    edSdacha: TcxCurrencyEdit;
    btn500: TcxButton;
    btn2k: TcxButton;
    btn10k: TcxButton;
    btn20k: TcxButton;
    btn5k: TcxButton;
    btn1k: TcxButton;
    tsNonCash: TTabSheet;
    tsCombin: TTabSheet;
    lb3: TLabel;
    lb6: TLabel;
    edSummNonCash: TcxCurrencyEdit;
    btnOstatokNonCash: TBitBtn;
    btnOstatokBonusBeznal: TBitBtn;
    btnEqualBonusNonCash: TBitBtn;
    btnEqualNonCash: TBitBtn;
    lb9: TLabel;
    lb10: TLabel;
    lb11: TLabel;
    edSummBonusCombin: TcxCurrencyEdit;
    edSummCashCombin: TcxCurrencyEdit;
    edSdachaCombin: TcxCurrencyEdit;
    btnOstatokCashCombin: TBitBtn;
    btnEqualCashCombin: TBitBtn;
    btnOstatokBonusCombin: TBitBtn;
    btnEqualBonusCombin: TBitBtn;
    lb12: TLabel;
    edSummNonCashCombin: TcxCurrencyEdit;
    btnOstatokNonCashCombin: TBitBtn;
    btnEqualNonCashCombin: TBitBtn;
    spPaymentTypes: TpFIBDataSet;
    dsPaymentTypes: TDataSource;
    lb13: TLabel;
    lb14: TLabel;
    leGNonCashPayTypeCombin: TcxLookupComboBox;
    edSummBonusNonCash: TcxCurrencyEdit;
    leGNonCashPayType: TcxLookupComboBox;
    cbFiscalMode: TcxCheckBox;
    cbPrintOnPrinter: TcxCheckBox;
    btnBin: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure cbPayBonusClick(Sender: TObject);
    procedure btnEqualCashClick(Sender: TObject);
    procedure edSummFactPropertiesChange(Sender: TObject);
    procedure ce1PropertiesChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure btnEqualNonCashClick(Sender: TObject);
    procedure btnOstatokCashClick(Sender: TObject);
    procedure btnOstatokNonCashClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn500Click(Sender: TObject);
    procedure btn1kClick(Sender: TObject);
    procedure btn2kClick(Sender: TObject);
    procedure btn5kClick(Sender: TObject);
    procedure btn10kClick(Sender: TObject);
    procedure btn20kClick(Sender: TObject);
    procedure cbShowButtonPanelPropertiesChange(Sender: TObject);
    procedure edSummCashEnter(Sender: TObject);
    procedure edSummNoncashEnter(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure btnBckspClick(Sender: TObject);
    procedure edSummCashExit(Sender: TObject);
    procedure edSummNoncashExit(Sender: TObject);
    procedure edSummBonusEnter(Sender: TObject);
    procedure edSummBonusExit(Sender: TObject);
    procedure pcPayTypeChange(Sender: TObject);
    procedure btnOstatokBonusClick(Sender: TObject);
    procedure btnOstatokBonusBeznalClick(Sender: TObject);
    procedure btnOstatokCashCombinClick(Sender: TObject);
    procedure btnOstatokNonCashCombinClick(Sender: TObject);
    procedure btnOstatokBonusCombinClick(Sender: TObject);
    procedure btnEqualBonusClick(Sender: TObject);
    procedure btnEqualBonusNonCashClick(Sender: TObject);
    procedure btnEqualCashCombinClick(Sender: TObject);
    procedure btnEqualNonCashCombinClick(Sender: TObject);
    procedure btnEqualBonusCombinClick(Sender: TObject);
    procedure edSummBonusNonCashEnter(Sender: TObject);
    procedure edSummCashCombinEnter(Sender: TObject);
    procedure edSummNonCashCombinEnter(Sender: TObject);
    procedure edSummBonusCombinEnter(Sender: TObject);
    procedure edSummBonusNonCashExit(Sender: TObject);
    procedure edSummCashCombinExit(Sender: TObject);
    procedure edSummNonCashCombinExit(Sender: TObject);
    procedure edSummBonusCombinExit(Sender: TObject);
    procedure edSummBonusNonCashPropertiesChange(Sender: TObject);
    procedure edSummBonusPropertiesChange(Sender: TObject);
    procedure edSummCashCombinPropertiesChange(Sender: TObject);
    procedure edSummNonCashCombinPropertiesChange(Sender: TObject);
    procedure cbPrintOnPrinterPropertiesChange(Sender: TObject);
    procedure btnBinClick(Sender: TObject);
    procedure cbFiscalModePropertiesChange(Sender: TObject);
  private
    FPaymentType : Integer;
    FSummBonus : Double;
    FSummBonusLocal : Double;
    FSummBonusPay   : Double;       // сумма бонуса, оплачеваемого за данный заказ
    FMaxBonusPaySumm : Double;
    FSummZakaz : Double;
    FSummZakazToChargeBonus : Double;
    FBonusPercent : Double;
    FSdacha : Double;
    FNotFirst : Boolean;
    FEdSummCashFocused    : Boolean;
    FEdSummBonusFocused : Boolean;
    FEdSummNonCashFocused : Boolean;
    FEdSummBonusNonCashFocused : Boolean;
    FEdSummCashCombinFocused    : Boolean;
    FEdSummBonusCombinFocused : Boolean;
    FEdSummNonCashCombinFocused : Boolean;
    FSummCashPaidFact : Double; // сколько реально оплачено налом
    FSummCashForSave  : Double; // сколько нужно посадить в таблицу с учетом безнала и бонусов
    FSummNonCashForSave : Double;
    FSummBonusForSave : Double;
    FNonCashPayType : Int64;
    FClientAddress : String;
    FClientIdn : String;
    FPosTerminalProcessMethod : String;
    FPosTerminalProcessTransactionID : String;
    FIdn : String;
    Fis_Credit: Boolean;
    procedure PrintButtonNum(Num : string);
    procedure BonusFieldsSetEnable;
    procedure CalcSdacha;
    procedure ChangePageActions;
    function MinusBtn(BtnName : string; SummCash, SummNonCash, SummBonus : Double) : Double;
  public
    property PaymentType : Integer read FPaymentType write FPaymentType;
    property SummBonus : Double read FSummBonus write FSummBonus;
    property MaxBonusPaySumm : Double read FMaxBonusPaySumm write FMaxBonusPaySumm;
    property SummZakaz : Double read FSummZakaz write FSummZakaz;
    property SummZakazToChargeBonus : Double read FSummZakazToChargeBonus write FSummZakazToChargeBonus;
    property BonusPercent : Double read FBonusPercent write FBonusPercent;
    property Sdacha : Double read FSdacha write FSdacha;
    property SummCashForSave : Double read FSummCashForSave write FSummCashForSave;
    property SummNonCashForSave : Double read FSummNonCashForSave write FSummNonCashForSave;
    property SummBonusForSave : Double read FSummBonusForSave write FSummBonusForSave;
    property SummCashPaidFact : Double read FSummCashPaidFact write FSummCashPaidFact;
    property NonCashPayType : Int64 read FNonCashPayType write FNonCashPayType;
    property ClientAddress : String read FClientAddress write FClientAddress;
    property ClientIdn : String read FClientIdn write FClientIdn;
    property PosTerminalProcessMethod : String read FPosTerminalProcessMethod write FPosTerminalProcessMethod;
    property PosTerminalProcessTransactionID : String read FPosTerminalProcessTransactionID write FPosTerminalProcessTransactionID;
    property Idn : String read FIdn write FIdn;
    property is_Credit: Boolean read Fis_Credit write Fis_Credit;
  end;

var
  SalePaymentForm: TSalePaymentForm;

implementation

uses
  unCommonFunc, frmPosTerminalProcess, frmSaleCommonDilg, dmMain, unFRPrinted;

{$R *.dfm}

procedure TSalePaymentForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  PosTerminalProcessForm: TPosTerminalProcessForm;
  SuccessLoc : Boolean;
  PosTerminalProcessMethod, PosTerminalProcessTransactionID : string;
  PrintOnFrLoc, PrintOnPrintersLoc: Boolean;
  TypeTis, i: Integer;
begin
  if ModalResult = mrOk then
  begin
    if edSummBonus.Value > edBonusAll.Value then begin
      MessageDlg('Нельзя оплатить бонусами больше, чем имеется на счету клиента!', mtError, [mbOk], 0);
      edSummBonus.SetFocus;
      CanClose := False;
      Exit;
    end;

    // если подключен ФР, то не даю продавать заказ, где сумма оплаты меньше суммы заказа
    if CheckPrintDeviceFr in [1,2,3,4,5,6] then
      if FSummZakaz > (edSummCash.Value + edSummNonCash.Value + edSummBonus.Value) then begin
        MessageDlg('Сумма оплаты меньше суммы чека! Такой чек не будет принят фиск. регистратором (онлайн-кассой).' + CRLF +
        'Уменьшите стоимость товаров или установите скидку.', mtWarning, [mbOk], 0);
        CanClose := False;
        Exit;
      end;
  end;

  FSummCashForSave := 0;
  FSummNonCashForSave := 0;
  FSummBonusForSave   := 0;
  if pcPayType.ActivePage = tsCash then begin
    FSummCashForSave := MAX(edSummCash.Value - Max(edSummCash.Value + edSummBonus.Value - FSummZakaz, 0), 0);
    // чтобы бонусов не стало больше, чем сумма заказа
    FSummBonusForSave := Min(edSummBonus.Value, FSummZakaz);
    {if FSummCashForSave = 0 then
      FSummBonusForSave := FSummZakaz
    else
      FSummBonusForSave := edSummBonus.Value;}

    FSdacha := Max(edSdacha.Value, 0);//Max((edSummCash.Value + edSummNonCash.Value) - FSummZakaz, 0);//(edSummCash.Value + edSummNonCash.Value) - FSummZakaz; //Max((edSummCash.Value + edSummNonCash.Value) - FSummZakaz, 0);
    FSummCashPaidFact := edSummCash.Value;

  end else if pcPayType.ActivePage = tsNonCash then begin
    FSummNonCashForSave := MAX(edSummNonCash.Value - Max(edSummNonCash.Value + edSummBonusNonCash.Value - FSummZakaz, 0), 0);
    FNonCashPayType := leGNonCashPayType.EditValue;
    // чтобы бонусов не стало больше, чем сумма заказа
    FSummBonusForSave := Min(edSummBonusNonCash.Value, FSummZakaz);
    {if FSummNonCashForSave = 0 then
      FSummBonusForSave := FSummZakaz
    else
      FSummBonusForSave := edSummBonusNonCash.Value;}

  end else if pcPayType.ActivePage = tsCombin then begin
    FSdacha := Max(edSdachaCombin.Value, 0);//Max((edSummCash.Value + edSummNonCash.Value) - FSummZakaz, 0);//(edSummCash.Value + edSummNonCash.Value) - FSummZakaz; //Max((edSummCash.Value + edSummNonCash.Value) - FSummZakaz, 0);
    FNonCashPayType := leGNonCashPayTypeCombin.EditValue;

    if edSummNonCashCombin.Value <> 0 then
      FSummCashForSave := MAX(edSummCashCombin.Value - Max(edSummCashCombin.Value + edSummNonCashCombin.Value + edSummBonusCombin.Value - FSummZakaz, 0), 0)
    else if edSummCashCombin.Value > FSummZakaz then
      FSummCashForSave := edSummCashCombin.Value - FSdacha
    else
      FSummCashForSave := edSummCashCombin.Value;

    FSummNonCashForSave := Min(edSummNonCashCombin.Value, FSummZakaz);
    FSummBonusForSave   := edSummBonusCombin.Value;
    FSummCashPaidFact   := edSummCashCombin.Value;
  end;
  if ModalResult = mrOk then
  begin
    if is_Credit then
    begin
      if (FSummZakaz > (FSummCashForSave + FSummNonCashForSave + FSummBonusForSave)) then
      begin
        MessageDlg('Сумма оплаты меньше суммы чека! Установлен запрет продажи в долг.', mtError, [mbOk], 0);
        CanClose := False;
        Exit;
      end;
    end;
  end;
  if (DoNotCreditBonusOnDolg = 1) and (FSummZakaz > (FSummCashForSave + FSummNonCashForSave + FSummBonusForSave)) then
    edBonus.Value := 0;

  SaveSettingsIni('SaleMode', 'FiscalMode', Integer(cbFiscalMode.Checked), '');
  SaveSettingsIni('SaleMode', 'PrintOnPrinter', Integer(cbPrintOnPrinter.Checked), '');

  //=================================================
  // ОТПРАВКА В ОФД И ОТПРАВКА В ТЕРМИНАЛ
  //=================================================
  if ModalResult = mrOk then
  begin
    //****************************************************************************************************
    // ЗАПУСКАЮ ОБРАБОТКУ ТЕРМИНАЛОВ (ПОКА ТОЛЬКО КАСПИ)
    if CheckPrintDeviceFr <> 6 then
      if (UsePosTerminal = 1) and (FSummNonCashForSave > 0) {and (FNonCashPayType = 0PosTerminalNonCashPayType)} then
      begin
        spPaymentTypes.Locate('G_NONCASH_PAY_TYPE', leGNonCashPayType.EditValue, []);
        for i := 0 to High(PosTerminalArr) do begin
          if (PosTerminalArr[i].Model = spPaymentTypes.FieldByName('POS_TERMINAL_TYPE').AsInteger) and
          (spPaymentTypes.FieldByName('POS_TERMINAL_TYPE').AsInteger > 0) then
          begin
            PosTerminalProcessForm := TPosTerminalProcessForm.Create(Self);
            try
              PosTerminalProcessForm.Url := PosTerminalArr[i].IP;
              PosTerminalProcessForm.Amount := MathRound(SummNonCashForSave, 0);
              PosTerminalProcessForm.TypePosTerminal := PosTerminalArr[i].Model;
              //теперь надо записать метод и транзакцию в продажу
              if PosTerminalProcessForm.ShowModal = mrOk then begin
                FPosTerminalProcessMethod := PosTerminalProcessForm.Method;
                FPosTerminalProcessTransactionID := PosTerminalProcessForm.TransactionID;
              end
              else begin
                if PosTerminalProcessForm.StayOnParentForm then begin
                  CanClose := False;
                  Exit;
                end;
              end;
            finally
              FreeAndNil(PosTerminalProcessForm);
            end;
          end;
        end;
      end;
    //************************************************************************************
    if PrintOnFr and cbFiscalMode.Checked then
    begin
      PrintOnFrLoc := (PrintOnFr and cbFiscalMode.Checked);
      TypeTis := 0;
      // если идет печать чеков на ФР, то нехуй дублировать на принтер
      if PrintOnFrLoc = True then
        PrintOnPrintersLoc := False
      else
        PrintOnPrintersLoc := PrintOnPrinters;
      with MainDM.SQLTMP do
      begin
        Close;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_ZAKAZ, 0) +1 FROM RDB$DATABASE;');
        Open;
        LastCheck := Fields[0].Value;
        Close;
      end;
      if CheckPrintDeviceFr = 6 then
      begin
        if spPaymentTypes.Active then
        begin
          spPaymentTypes.Locate('G_NONCASH_PAY_TYPE', NonCashPayType, [loCaseInsensitive]);
          TypeTis := spPaymentTypes.FieldByName('IS_TIS_TYPE').AsInteger;
        end;
        if PrintBillAll(LastCheck, FSummZakaz, FSummCashPaidFact, FSummNonCashForSave,
            sdacha, 0, FormatSettings.CurrencyDecimals, edBonus.Value, FSummBonusForSave,
            mAddress.Text, False, PrintOnPrintersLoc, PrintOnFrLoc, Idn, TypeTis, SummBonus-FSummBonusForSave, False, '')
        then
        begin
          if (CheckPrintDeviceFr = 6) and (cbFiscalMode.Checked and PrintOnFr) and (KKMTIS.Request <> '') then
          begin
            if MessageDlg('Все равно продолжить и сохранить продажу?'+#10#13+'Вы сможете отправить данную продажу в ОФД позже!', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
            begin
              ModalResult := mrOk;
            end
            else
              CanClose := False;
          end;
        end;
      end
      else
      begin
        if PrintBillAll(LastCheck, FSummZakaz, FSummCashPaidFact, FSummNonCashForSave,
            sdacha, 0, FormatSettings.CurrencyDecimals, edBonus.Value, FSummBonusForSave,
            mAddress.Text, False, PrintOnPrintersLoc, PrintOnFrLoc, Idn, 0, SummBonus-FSummBonusForSave, False, '')
        then
          CanClose := False;
      end;
    end;

  end;
end;

procedure TSalePaymentForm.FormShow(Sender: TObject);
begin

  if FPaymentType = 1 then    // С ГЛАВНОЙ ФОРМЫ 1 - ЭТО БЕЗНАЛИЧНЫЙ РАСЧЕТ
    pcPayType.ActivePage := tsNonCash
  else
    pcPayType.ActivePage := tsCash;
  ChangePageActions;

  edBonus.Value := FSummZakazToChargeBonus;
  edBonusAll.Value := FSummBonus;
  //cbPayBonus.Enabled := edBonusAll.Value > 0;
  cbDoNotCreditBonus.Enabled := edBonus.Value > 0;

  if DeliveryService = 0 then begin
    pnlAddress.Visible := False;
    Height := Height - pnlAddress.Height;
  end
  else
    mAddress.Text := FClientAddress;

  cbFiscalMode.Visible := PrintOnFr;
  cbFiscalMode.Checked := (cbFiscalMode.Visible) and (ReadIntSettingsIni( 'SaleMode', 'FiscalMode', 1) = 1);

  cbPrintOnPrinter.Visible := not cbFiscalMode.Visible;
  cbPrintOnPrinter.Checked := ReadIntSettingsIni( 'SaleMode', 'PrintOnPrinter', 1) = 1;

  btnBin.Visible := PrintOnFr;
  btnBin.Enabled := (btnBin.Visible) and (cbFiscalMode.Checked);

  if Screen.Height <= 768 then begin
    ClientHeight := ScaleDimension(539);
    ClientWidth := ScaleDimension(738);
    Height := ScaleDimension(550);
    Width := ScaleDimension(744);
    Panel1.Height := ScaleDimension(467);
    Panel1.Width := ScaleDimension(725);
    pnlButton.Width := ScaleDimension(218);
    pnlNote.Height := ScaleDimension(40);
    pnlAddress.Height := ScaleDimension(35);

    lb1.Font.Size := 14;
    lb5.Font.Size := 14;
    lb2.Font.Size := 14;
    lb3.Font.Size := 14;
    lb6.Font.Size := 14;
    lb13.Font.Size := 14;
    lb9.Font.Size := 14;
    lb12.Font.Size := 14;
    lb14.Font.Size := 14;
    lb10.Font.Size := 14;
    lb11.Font.Size := 14;
    lb7.Font.Size := 12;
    lb8.Font.Size := 12;
    lbBonus.Font.Size := 12;
    lb4.Font.Size := 12;
    btn500.Font.Size := 14;
    btn2k.Font.Size := 14;
    btn10k.Font.Size := 14;
    btn20k.Font.Size := 14;
    btn5k.Font.Size := 14;
    btn1k.Font.Size := 14;
    cbPrintOnPrinter.Style.Font.Size := 11;
    cbFiscalMode.Style.Font.Size := 11;
    cbDoNotCreditBonus.Style.Font.Size := 11;
    btnBin.Font.Size := 14;
    btnOk.Font.Size := 14;
    btnCancel.Font.Size := 14;
    pcPayType.Font.Size := 14;
    mNote.Style.Font.Size := 10;
    mAddress.Style.Font.Size := 10;
    edSummCash.Style.Font.Size := 15;
    edSummBonus.Style.Font.Size := 15;
    edSdacha.Style.Font.Size := 15;
    edSummNonCash.Style.Font.Size := 15;
    edSummBonusNonCash.Style.Font.Size := 15;
    leGNonCashPayType.Style.Font.Size := 15;
    edSummCashCombin.Style.Font.Size := 15;
    edSummNonCashCombin.Style.Font.Size := 15;
    leGNonCashPayTypeCombin.Style.Font.Size := 15;
    edSummBonusCombin.Style.Font.Size := 15;
    edSdachaCombin.Style.Font.Size := 15;
    edBonus.Style.Font.Size := 15;
    edBonusAll.Style.Font.Size := 15;

    // устанавливаю размеры
    pcPayType.TabWidth := ScaleDimension(155);
    mNote.Height := ScaleDimension(30);
    mAddress.Height := ScaleDimension(30);
    mNote.Width := ScaleDimension(355);
    mAddress.Width := ScaleDimension(355);
    cbFiscalMode.Top := ScaleDimension(170);

    btn500.Height := ScaleDimension(30);
    btn1k.Height := ScaleDimension(30);
    btn5k.Height := ScaleDimension(30);
    btn2k.Height := ScaleDimension(30);
    btn10k.Height := ScaleDimension(30);
    btn20k.Height := ScaleDimension(30);
    btn500.Width := ScaleDimension(120);
    btn1k.Width := ScaleDimension(120);
    btn5k.Width := ScaleDimension(120);
    btn2k.Width := ScaleDimension(120);
    btn10k.Width := ScaleDimension(120);
    btn20k.Width := ScaleDimension(120);
    edSummCash.Width := ScaleDimension(220);
    edSummBonus.Width := ScaleDimension(220);
    edSdacha.Width := ScaleDimension(220);
    btnEqualCash.Height := ScaleDimension(36);
    btnOstatokCash.Height := ScaleDimension(36);
    btnOstatokBonus.Height := ScaleDimension(36);
    btnEqualBonus.Height := ScaleDimension(36);
    btnEqualCash.Width := ScaleDimension(50);
    btnOstatokCash.Width := ScaleDimension(50);
    btnOstatokBonus.Width := ScaleDimension(50);
    btnEqualBonus.Width := ScaleDimension(50);
    btnEqualNonCash.Height := ScaleDimension(36);
    btnOstatokNonCash.Height := ScaleDimension(36);
    btnOstatokBonusBeznal.Height := ScaleDimension(36);
    edSummNonCash.Width := ScaleDimension(220);
    edSummBonusNonCash.Width := ScaleDimension(220);
    leGNonCashPayType.Width := ScaleDimension(220);
    btnEqualBonusNonCash.Height := ScaleDimension(36);
    btnEqualNonCash.Width := ScaleDimension(50);
    btnOstatokNonCash.Width := ScaleDimension(50);
    btnOstatokBonusBeznal.Width := ScaleDimension(50);
    btnEqualBonusNonCash.Width := ScaleDimension(50);
    btnOstatokCashCombin.Height := ScaleDimension(36);
    btnEqualNonCashCombin.Height := ScaleDimension(36);
    btnOstatokNonCashCombin.Height := ScaleDimension(36);
    btnOstatokBonusCombin.Height := ScaleDimension(36);
    btnEqualBonusCombin.Height := ScaleDimension(36);
    btnOstatokCashCombin.Width := ScaleDimension(50);
    btnEqualCashCombin.Height := ScaleDimension(36);
    btnEqualCashCombin.Width := ScaleDimension(50);
    btnEqualNonCashCombin.Width := ScaleDimension(50);
    btnOstatokNonCashCombin.Width := ScaleDimension(50);
    btnOstatokBonusCombin.Width := ScaleDimension(50);
    btnEqualBonusCombin.Width := ScaleDimension(50);
    edSummCashCombin.Width := ScaleDimension(220);
    edSummNonCashCombin.Width := ScaleDimension(220);
    leGNonCashPayTypeCombin.Width := ScaleDimension(220);
    edSummBonusCombin.Width := ScaleDimension(220);
    edSdachaCombin.Width := ScaleDimension(220);
    btn7.Height := ScaleDimension(45);
    btn8.Height := ScaleDimension(45);
    btn9.Height := ScaleDimension(45);
    btn6.Height := ScaleDimension(45);
    btn5.Height := ScaleDimension(45);
    btn4.Height := ScaleDimension(45);
    btn1.Height := ScaleDimension(45);
    btn2.Height := ScaleDimension(45);
    btn3.Height := ScaleDimension(45);
    btnBcksp.Height := ScaleDimension(45);
    btnPnt.Height := ScaleDimension(45);
    btn0.Height := ScaleDimension(45);
    btn7.Width := ScaleDimension(50);
    btn8.Width := ScaleDimension(50);
    btn9.Width := ScaleDimension(50);
    btn6.Width := ScaleDimension(50);
    btn5.Width := ScaleDimension(50);
    btn4.Width := ScaleDimension(50);
    btn1.Width := ScaleDimension(50);
    btn2.Width := ScaleDimension(50);
    btn3.Width := ScaleDimension(50);
    btnBcksp.Width := ScaleDimension(50);
    btnPnt.Width := ScaleDimension(50);
    btn0.Width := ScaleDimension(50);
    btnBin.Width := ScaleDimension(145);
    btnOk.Width := ScaleDimension(160);
    btnCancel.Width := ScaleDimension(156);
    btnBin.Height := ScaleDimension(40);
    btnOk.Height := ScaleDimension(40);
    btnCancel.Height := ScaleDimension(40);

    edBonus.Width := ScaleDimension(175);
    edBonusAll.Width := ScaleDimension(175);
    cbDoNotCreditBonus.Width := ScaleDimension(185);

    // устанавливаю координаты
    // наличные
    lb1.Left := ScaleDimension(14);
    lb1.Top := ScaleDimension(20);
    lb5.Left := ScaleDimension(14);
    lb5.Top := ScaleDimension(62);
    lb2.Left := ScaleDimension(14);
    lb2.Top := ScaleDimension(105);
    btn500.Left := ScaleDimension(14);
    btn500.Top := ScaleDimension(159);
    btn1k.Left := ScaleDimension(14);
    btn1k.Top := ScaleDimension(198);
    btn2k.Left := ScaleDimension(183);
    btn2k.Top := ScaleDimension(159);
    btn5k.Left := ScaleDimension(183);
    btn5k.Top := ScaleDimension(198);
    btn10k.Left := ScaleDimension(350);
    btn10k.Top := ScaleDimension(159);
    btn20k.Left := ScaleDimension(350);
    btn20k.Top := ScaleDimension(198);
    btnEqualCash.Left := ScaleDimension(372);
    btnEqualCash.Top := ScaleDimension(11);
    btnOstatokCash.Left := ScaleDimension(433);
    btnOstatokCash.Top := ScaleDimension(11);
    btnEqualBonus.Left := ScaleDimension(372);
    btnEqualBonus.Top := ScaleDimension(57);
    btnOstatokBonus.Left := ScaleDimension(433);
    btnOstatokBonus.Top := ScaleDimension(57);
    edSummCash.Left := ScaleDimension(140);
    edSummCash.Top := ScaleDimension(15);
    edSummBonus.Left := ScaleDimension(140);
    edSummBonus.Top := ScaleDimension(58);
    edSdacha.Left := ScaleDimension(140);
    edSdacha.Top := ScaleDimension(102);
    //безналичные
    lb3.Left := ScaleDimension(14);
    lb3.Top := ScaleDimension(20);
    lb6.Left := ScaleDimension(14);
    lb6.Top := ScaleDimension(62);
    lb13.Left := ScaleDimension(14);
    lb13.Top := ScaleDimension(105);
    edSummNonCash.Left := ScaleDimension(140);
    edSummNonCash.Top := ScaleDimension(15);
    edSummBonusNonCash.Left := ScaleDimension(140);
    edSummBonusNonCash.Top := ScaleDimension(58);
    leGNonCashPayType.Left := ScaleDimension(140);
    leGNonCashPayType.Top := ScaleDimension(102);
    btnEqualNonCash.Left := ScaleDimension(372);
    btnEqualNonCash.Top := ScaleDimension(11);
    btnOstatokNonCash.Left := ScaleDimension(433);
    btnOstatokNonCash.Top := ScaleDimension(20);
    btnEqualBonusNonCash.Left := ScaleDimension(372);
    btnEqualBonusNonCash.Top := ScaleDimension(57);
    btnOstatokBonusBeznal.Left := ScaleDimension(433);
    btnOstatokBonusBeznal.Top := ScaleDimension(57);
    //смешанная
    lb9.Left := ScaleDimension(14);
    lb9.Top := ScaleDimension(20);
    lb12.Left := ScaleDimension(14);
    lb12.Top := ScaleDimension(62);
    lb14.Left := ScaleDimension(14);
    lb14.Top := ScaleDimension(105);
    lb10.Left := ScaleDimension(14);
    lb10.Top := ScaleDimension(156);
    lb11.Left := ScaleDimension(14);
    lb11.Top := ScaleDimension(205);
    edSummCashCombin.Left := ScaleDimension(140);
    edSummCashCombin.Top := ScaleDimension(15);
    edSummNonCashCombin.Left := ScaleDimension(140);
    edSummNonCashCombin.Top := ScaleDimension(58);
    leGNonCashPayTypeCombin.Left := ScaleDimension(140);
    leGNonCashPayTypeCombin.Top := ScaleDimension(102);
    edSummBonusCombin.Left := ScaleDimension(140);
    edSummBonusCombin.Top := ScaleDimension(149);
    edSdachaCombin.Left := ScaleDimension(140);
    edSdachaCombin.Top := ScaleDimension(200);
    btnOstatokCashCombin.Left := ScaleDimension(372);
    btnOstatokCashCombin.Top := ScaleDimension(11);
    btnEqualCashCombin.Left := ScaleDimension(433);
    btnEqualCashCombin.Top := ScaleDimension(11);
    btnOstatokNonCashCombin.Left := ScaleDimension(372);
    btnOstatokNonCashCombin.Top := ScaleDimension(57);
    btnEqualNonCashCombin.Left := ScaleDimension(433);
    btnEqualNonCashCombin.Top := ScaleDimension(57);
    btnOstatokBonusCombin.Left := ScaleDimension(372);
    btnOstatokBonusCombin.Top := ScaleDimension(146);
    btnEqualBonusCombin.Left := ScaleDimension(433);
    btnEqualBonusCombin.Top := ScaleDimension(146);

    btnOk.Left := ScaleDimension(400);
    btnCancel.Left := ScaleDimension(574);
    btnBin.Left := ScaleDimension(194);
    btnOk.Top := ScaleDimension(477);
    btnCancel.Top := ScaleDimension(477);
    btnBin.Top := ScaleDimension(477);

    // остальное
    lb7.Left := ScaleDimension(12);
    lb7.Top := ScaleDimension(9);
    lb8.Left := ScaleDimension(12);
    lb8.Top := ScaleDimension(4);
    lbBonus.Left := ScaleDimension(21);
    lbBonus.Top := ScaleDimension(295);
    lb4.Left := ScaleDimension(21);
    lb4.Top := ScaleDimension(359);
    edBonus.Left := ScaleDimension(22);
    edBonus.Top := ScaleDimension(317);
    edBonusAll.Left := ScaleDimension(22);
    edBonusAll.Top := ScaleDimension(379);
    cbPrintOnPrinter.Top := ScaleDimension(483);
    cbFiscalMode.Top := ScaleDimension(483);
    cbDoNotCreditBonus.Left := ScaleDimension(20);
    cbDoNotCreditBonus.Top := ScaleDimension(414);
    btn7.Left := ScaleDimension(29);
    btn7.Top := ScaleDimension(33);
    btn8.Left := ScaleDimension(85);
    btn8.Top := ScaleDimension(33);
    btn9.Left := ScaleDimension(141);
    btn9.Top := ScaleDimension(33);
    btn4.Left := ScaleDimension(29);
    btn4.Top := ScaleDimension(84);
    btn5.Left := ScaleDimension(85);
    btn5.Top := ScaleDimension(84);
    btn6.Left := ScaleDimension(141);
    btn6.Top := ScaleDimension(84);
    btn1.Left := ScaleDimension(29);
    btn1.Top := ScaleDimension(136);
    btn2.Left := ScaleDimension(85);
    btn2.Top := ScaleDimension(136);
    btn3.Left := ScaleDimension(141);
    btn3.Top := ScaleDimension(136);
    btn0.Left := ScaleDimension(29);
    btn0.Top := ScaleDimension(189);
    btnPnt.Left := ScaleDimension(85);
    btnPnt.Top := ScaleDimension(189);
    btnBcksp.Left := ScaleDimension(141);
    btnBcksp.Top := ScaleDimension(189);
    mNote.Left := ScaleDimension(140);
    mNote.Top := ScaleDimension(4);
    mAddress.Left := ScaleDimension(140);
    mAddress.Top := ScaleDimension(0);
  end;
end;

procedure TSalePaymentForm.pcPayTypeChange(Sender: TObject);
begin
  if (CheckPrintDeviceFr = 6) and ((cbFiscalMode.Visible) and (ReadIntSettingsIni( 'SaleMode', 'FiscalMode', 1) = 1)) then
  begin
    if Terminal < 1 then
    begin
      pcPayType.ActivePage := tsCash;
      ShowMessage('Не выбран терминал для оплаты.'+#13#10+' Выберите терминал в настройках.');
    end;
  end;
  ChangePageActions;
end;

procedure TSalePaymentForm.ChangePageActions;
begin
  if (pcPayType.ActivePage = tsNonCash) or (pcPayType.ActivePage = tsCombin) then begin
    if spPaymentTypes.Active = false then begin
      OpenSp(spPaymentTypes, False);

      //if spPaymentTypes.RecordCount = 1 then begin
      leGNonCashPayTypeCombin.EditValue := 1;    // банк. карта
      leGNonCashPayType.EditValue := 1;          // банк. карта
      //end;
    end;
  end;

  if (pcPayType.ActivePage = tsCash) then begin
    if edSummCash.Value = 0 then
      edSummCash.Value := FSummZakaz;

    edSummCash.SetFocus;
    edSummCash.SelectAll;

    if FSummBonus = 0 then begin
      edSummBonus.Enabled := False;
      btnOstatokBonus.Enabled := False;
      btnEqualBonus.Enabled := False;
    end;
  end

  else if (pcPayType.ActivePage = tsNonCash) and (edSummNonCash.Value = 0) then begin
    if edSummNonCash.Value = 0 then
      edSummNonCash.Value := FSummZakaz;
    edSummNonCash.SetFocus;
    edSummNonCash.SelectAll;

    if FSummBonus = 0 then begin
      edSummBonusNonCash.Enabled := False;
      btnOstatokBonusBeznal.Enabled := False;
      btnEqualBonusNonCash.Enabled := False;
    end;
  end

  else if (pcPayType.ActivePage = tsCombin) and (edSummNonCashCombin.Value = 0) then begin
    if edSummCashCombin.Value = 0 then
      edSummCashCombin.Value := FSummZakaz;
    edSummCashCombin.SetFocus;
    edSummCashCombin.SelectAll;

    if FSummBonus = 0 then begin
      edSummBonusCombin.Enabled := False;
      btnOstatokBonusCombin.Enabled := False;
      btnEqualBonusCombin.Enabled := False;
    end;
  end;

end;

procedure TSalePaymentForm.edSummBonusCombinEnter(Sender: TObject);
begin
  FEdSummBonusCombinFocused := True;

  FEdSummCashFocused := False;
  FEdSummBonusFocused := False;
  FEdSummNonCashFocused := False;
  FEdSummBonusNonCashFocused := False;
  FEdSummNonCashCombinFocused := False;
  FEdSummCashCombinFocused := False;
end;

procedure TSalePaymentForm.edSummBonusCombinExit(Sender: TObject);
begin
  if edSummBonusCombin.Text = '' then
    edSummBonusCombin.Value := 0;
end;

procedure TSalePaymentForm.edSummBonusEnter(Sender: TObject);
begin
  FEdSummBonusFocused := True;

  FEdSummCashFocused := False;
  FEdSummNonCashFocused := False;
  FEdSummBonusNonCashFocused := False;
  FEdSummCashCombinFocused := False;
  FEdSummBonusCombinFocused := False;
  FEdSummNonCashCombinFocused := False;
end;

procedure TSalePaymentForm.edSummBonusExit(Sender: TObject);
begin
  if edSummBonus.Text = '' then
    edSummBonus.Value := 0;
end;

procedure TSalePaymentForm.edSummBonusNonCashEnter(Sender: TObject);
begin
  FEdSummBonusNonCashFocused := True;

  FEdSummCashFocused := False;
  FEdSummBonusFocused := False;
  FEdSummNonCashFocused := False;
  FEdSummCashCombinFocused := False;
  FEdSummBonusCombinFocused := False;
  FEdSummNonCashCombinFocused := False;
end;

procedure TSalePaymentForm.edSummBonusNonCashExit(Sender: TObject);
begin
  if edSummBonusNonCash.Text = '' then
    edSummBonusNonCash.Value := 0;
end;

procedure TSalePaymentForm.edSummBonusNonCashPropertiesChange(Sender: TObject);
begin
  if edSummBonusNonCash.Value < 0 then begin
    edSummBonusNonCash.Value := 0;
    Exit;
  end;

  if edSummBonusNonCash.Value > FSummZakaz then
    edSummBonusNonCash.Value := FSummZakaz;
  edSummNonCash.Value := FSummZakaz - edSummBonusNonCash.Value;
end;

procedure TSalePaymentForm.edSummBonusPropertiesChange(Sender: TObject);
begin
  if edSummBonus.Value < 0 then begin
    edSummBonus.Value := 0;
    Exit;
  end;

  if edSummBonus.Value > FSummZakaz then
    edSummBonus.Value := FSummZakaz;
  edSummCash.Value := Max(FSummZakaz - edSummBonus.Value, 0);
end;

procedure TSalePaymentForm.edSummCashCombinEnter(Sender: TObject);
begin
  FEdSummCashCombinFocused := True;

  FEdSummCashFocused := False;
  FEdSummBonusFocused := False;
  FEdSummNonCashFocused := False;
  FEdSummBonusNonCashFocused := False;
  FEdSummBonusCombinFocused := False;
  FEdSummNonCashCombinFocused := False;
end;

procedure TSalePaymentForm.edSummCashCombinExit(Sender: TObject);
begin
  if edSummCashCombin.Text = '' then
    edSummCashCombin.Value := 0;
end;

procedure TSalePaymentForm.edSummCashCombinPropertiesChange(Sender: TObject);
begin
  CalcSdacha;
end;

procedure TSalePaymentForm.edSummCashEnter(Sender: TObject);
begin
  FEdSummCashFocused := True;

  FEdSummBonusFocused := False;
  FEdSummNonCashFocused := False;
  FEdSummBonusNonCashFocused := False;
  FEdSummCashCombinFocused := False;
  FEdSummBonusCombinFocused := False;
  FEdSummNonCashCombinFocused := False;
end;

procedure TSalePaymentForm.edSummCashExit(Sender: TObject);
begin
  if edSummCash.Text = '' then
    edSummCash.Value := 0;
end;

procedure TSalePaymentForm.edSummNonCashCombinEnter(Sender: TObject);
begin
  FEdSummNonCashCombinFocused := True;

  FEdSummCashFocused := False;
  FEdSummBonusFocused := False;
  FEdSummNonCashFocused := False;
  FEdSummBonusNonCashFocused := False;
  FEdSummBonusCombinFocused := False;
  FEdSummCashCombinFocused := False;
end;

procedure TSalePaymentForm.edSummNonCashCombinExit(Sender: TObject);
begin
  if edSummNonCashCombin.Text = '' then
    edSummNonCashCombin.Value := 0;
end;

procedure TSalePaymentForm.edSummNonCashCombinPropertiesChange(Sender: TObject);
begin
  if edSummBonusCombin.Value < 0 then
    edSummBonusCombin.Value := 0;

  edSummCashCombin.Value := Max(FSummZakaz - (edSummNonCashCombin.Value + edSummBonusCombin.Value), 0);
end;

procedure TSalePaymentForm.edSummNoncashEnter(Sender: TObject);
begin
  FEdSummNonCashFocused := True;

  FEdSummCashFocused := False;
  FEdSummBonusFocused := False;
  FEdSummBonusNonCashFocused := False;
  FEdSummCashCombinFocused := False;
  FEdSummBonusCombinFocused := False;
  FEdSummNonCashCombinFocused := False;
end;

procedure TSalePaymentForm.edSummNoncashExit(Sender: TObject);
begin
  if edSummNonCash.Text = '' then
    edSummNonCash.Value := 0;
end;

procedure TSalePaymentForm.edSummFactPropertiesChange(Sender: TObject);
begin
  // если обнуляют сумму, то нажатия кнопки будут ставить значения сначала
  if edSummCash.Value = 0 then
    FNotFirst := False;

  CalcSdacha;
end;

procedure TSalePaymentForm.cbFiscalModePropertiesChange(Sender: TObject);
begin
  btnBin.Enabled := (btnBin.Visible) and (cbFiscalMode.Checked);
end;

procedure TSalePaymentForm.cbPayBonusClick(Sender: TObject);
begin
  {IF cbPayBonus.Checked THEN BEGIN
    if FMaxBonusPaySumm <> 100 then begin
      FSummBonusLocal := Min(Round(FSummZakaz * FMaxBonusPaySumm / 100), FSummBonus);
      edBonusAll.Value   := FSummBonus - FSummBonusLocal;
    end else begin
      FSummBonusLocal := Min(FSummBonus, FSummZakaz);
      edBonusAll.Value := MAX(FSummBonus - FSummZakaz, 0);
    end;

    // решил сделать так - если заполнено только "Безналичные", то редактирую "Безналичные",
    // во всех остальных случаях редактирую поле "Наличные", а поле "Безнал" - обнуляю
    if (edSummNonCash.Value > 0) and (edSummCash.Value = 0) then
      edSummNonCash.Value := Max(FSummZakaz - FSummBonusLocal, 0)

    else begin
      edSummCash.Value := Max(FSummZakaz - FSummBonusLocal, 0);
      edSummNonCash.Value := 0;
    end;

  END ELSE BEGIN
    FSummBonusLocal := 0;
    edBonusAll.Value := FSummBonus;

    // решил сделать так - если заполнено только "Безналичные", то редактирую "Безналичные",
    // во всех остальных случаях редактирую поле "Наличные", а поле "Безнал" - обнуляю
    if (edSummNonCash.Value > 0) and (edSummCash.Value = 0) then
      edSummNoncash.Value := FSummZakaz

    else begin
      edSummCash.Value := FSummZakaz;
      edSummNonCash.Value := 0;
    end;

  END;}
end;

procedure TSalePaymentForm.cbPrintOnPrinterPropertiesChange(Sender: TObject);
begin
  if PrintOnFr = False then
    if (cbPrintOnPrinter.Checked = True) and (PrintOnPrinters = False) then begin
      cbPrintOnPrinter.Checked := False;
      MessageDlg('Не включена печать чеков на принтере чеков в Настройках программы!' + CRLF +
        'Чек не будет отправлен на печать!', mtError, [mbOk], 0);
    end;
end;

procedure TSalePaymentForm.cbShowButtonPanelPropertiesChange(Sender: TObject);
begin
  //pnlButton.Visible := cbShowButtonPanel.Checked;
end;

procedure TSalePaymentForm.ce1PropertiesChange(Sender: TObject);
begin
  if cbDoNotCreditBonus.Checked then
    edBonus.Value := 0
  else
    edBonus.Value := FSummZakaz * FBonusPercent;
end;

procedure TSalePaymentForm.BonusFieldsSetEnable;
begin

end;

procedure TSalePaymentForm.btHelpClick(Sender: TObject);
begin
  Helpc := 16;
  inherited;
end;

procedure TSalePaymentForm.btn0Click(Sender: TObject);
begin
  if (Sender as TcxButton).Name = 'btn0' then
    PrintButtonNum('0')

  else if (Sender as TcxButton).Name = 'btn1' then
    PrintButtonNum('1')

  else if (Sender as TcxButton).Name = 'btn2' then
    PrintButtonNum('2')

  else if (Sender as TcxButton).Name = 'btn3' then
    PrintButtonNum('3')

  else if (Sender as TcxButton).Name = 'btn4' then
    PrintButtonNum('4')

  else if (Sender as TcxButton).Name = 'btn5' then
    PrintButtonNum('5')

  else if (Sender as TcxButton).Name = 'btn6' then
    PrintButtonNum('6')

  else if (Sender as TcxButton).Name = 'btn7' then
    PrintButtonNum('7')

  else if (Sender as TcxButton).Name = 'btn8' then
    PrintButtonNum('8')

  else if (Sender as TcxButton).Name = 'btn9' then
    PrintButtonNum('9')

  else if (Sender as TcxButton).Name = 'btnPnt' then
    PrintButtonNum('.');
end;

procedure TSalePaymentForm.PrintButtonNum(Num : string);
  procedure setVal(editSum : TcxCurrencyEdit);
    var s : integer;
  begin
    try
      s := editSum.SelStart;
      if s = Length(editSum.Text) then  // если курсор стоит в самом конце, то ничего не делаю и выхожу
        Exit;

      editSum.SelText := '';

      if editSum.Value = 0 then begin
        if Num = '0' then
          editSum.Value := 0
        else
          editSum.Value := StrToFloat(Num);

        Exit;
      end;

      if Num = '.' then begin
        // если след. символ и так точка, то просто перешагиваю через него
        // или если символ точки уже позади курсора
        if (Copy(editSum.Text, s+1, 1) = '.') or (Copy(editSum.Text, s+1, 1) = ',') or
        (Pos('.', editSum.Text) <= s) then
          Exit
        // если же нет, то сначала вырезаю точку, а затем вставляю свою
        else
          editSum.Text := Copy(editSum.Text, 1, Pos('.', editSum.Text)-1) +
            Copy(editSum.Text, Pos('.', editSum.Text)+1, Length(editSum.Text));
      end;

      editSum.Value := StrToFloat(Copy(editSum.Text, 1, s) + Num + Copy(editSum.Text, s + 1, Length(editSum.Text)));
    finally
      // снова выделяю editSum, иначе фокус убегает, т.к. юзер нажимает кнопку
      editSum.SetFocus;
      if ((Copy(editSum.Text, s+1, 1) = '.') or (Copy(editSum.Text, s+1, 1) = ',')) and
      (Num <> '.') then
        editSum.SelStart := s
      else
        editSum.SelStart := s + 1;
    end;
  end;
begin
  if FEdSummCashFocused then
    setVal(edSummCash)
  else if FEdSummBonusFocused then
    setVal(edSummBonus)

  else if FEdSummNonCashFocused then
    setVal(edSummNonCash)
  else if FEdSummBonusNonCashFocused then
    setVal(edSummBonusNonCash)

  else if FEdSummCashCombinFocused then
    setVal(edSummCashCombin)
  else if FEdSummNonCashCombinFocused then
    setVal(edSummNonCashCombin)
  else if FEdSummBonusCombinFocused then
    setVal(edSummBonusCombin);
end;

procedure TSalePaymentForm.btnBckspClick(Sender: TObject);
  procedure delSymb(editSum : TcxCurrencyEdit);
    var s : integer;
  begin
    try
      editSum.SelText := '';
      s := editSum.SelStart;

      if (s = 0) and (editSum.SelText <> '') then
        Exit;

      if (Copy(editSum.Text, s, 1) = '.') or (Copy(editSum.Text, s, 1) = ',') then
        Exit;

      if editSum.Text <> '' then
        editSum.Value := StrToFloat(Copy(editSum.Text, 1, s-1) +
        Copy(editSum.Text, s+1, Length(editSum.Text)));

    finally
      editSum.SetFocus;
      editSum.SelStart := s-1;
    end;
  end;
begin
  if FEdSummCashFocused then
    delSymb(edSummCash)
  else if FEdSummBonusFocused then
    delSymb(edSummBonus)

  else if FEdSummNonCashFocused then
    delSymb(edSummNonCash)
  else if FEdSummBonusNonCashFocused then
    delSymb(edSummBonusNonCash)

  else if FEdSummCashCombinFocused then
    delSymb(edSummCashCombin)
  else if FEdSummNonCashCombinFocused then
    delSymb(edSummNonCashCombin)
  else if FEdSummBonusCombinFocused then
    delSymb(edSummBonusCombin);
end;

procedure TSalePaymentForm.btnBinClick(Sender: TObject);
var SaleCommonDilgForm: TSaleCommonDilgForm;
begin
  SaleCommonDilgForm := TSaleCommonDilgForm.Create(Self);
  try
    if FClientIdn <> '' then
      SaleCommonDilgForm.edStrField.Text := FClientIdn;

    if SaleCommonDilgForm.ShowModal = mrOk then begin
      FIdn := SaleCommonDilgForm.edStrField.Text;
      btnBin.Caption := 'ИИН/БИН (ДА)';
    end;
  finally
    FreeAndNil(SaleCommonDilgForm);
  end;
end;

procedure TSalePaymentForm.btn10kClick(Sender: TObject);
begin
  if FNotFirst = False then begin
    edSummCash.Value := 10000;
    FNotFirst := True;
  end else begin
    if Length(edSummCash.SelText) = Length(edSummCash.Text) then
      edSummCash.Value := 10000
    else
      edSummCash.Value := edSummCash.Value + 10000;
  end;

  edSummCash.SelStart := Length(edSummCash.text) - 3;
end;

procedure TSalePaymentForm.btn1kClick(Sender: TObject);
begin
  if FNotFirst = False then begin
    edSummCash.Value := 1000;
    FNotFirst := True;
  end else begin
    if Length(edSummCash.SelText) = Length(edSummCash.Text) then
      edSummCash.Value := 1000
    else
      edSummCash.Value := edSummCash.Value + 1000;
  end;
  edSummCash.SelStart := Length(edSummCash.text) - 3;
end;

procedure TSalePaymentForm.btn20kClick(Sender: TObject);
begin
  if FNotFirst = False then begin
    edSummCash.Value := 20000;
    FNotFirst := True;
  end else begin
    if Length(edSummCash.SelText) = Length(edSummCash.Text) then
      edSummCash.Value := 20000
    else
      edSummCash.Value := edSummCash.Value + 20000;
  end;

  edSummCash.SelStart := Length(edSummCash.text) - 3;
end;

procedure TSalePaymentForm.btn2kClick(Sender: TObject);
begin
  if FNotFirst = False then begin
    edSummCash.Value := 2000;
    FNotFirst := True;
  end else begin
    if Length(edSummCash.SelText) = Length(edSummCash.Text) then
      edSummCash.Value := 2000
    else
      edSummCash.Value := edSummCash.Value + 2000;
  end;
  edSummCash.SelStart := Length(edSummCash.text) - 3;
end;

procedure TSalePaymentForm.btn500Click(Sender: TObject);
begin
  if FNotFirst = False then begin
    edSummCash.Value := 500;
    FNotFirst := True;
  end else begin
    if Length(edSummCash.SelText) = Length(edSummCash.Text) then
      edSummCash.Value := 500
    else
      edSummCash.Value := edSummCash.Value + 500;
  end;

  edSummCash.SelStart := Length(edSummCash.text) - 3;
end;

procedure TSalePaymentForm.btn5kClick(Sender: TObject);
begin
  if FNotFirst = False then begin
    edSummCash.Value := 5000;
    FNotFirst := True;
  end else begin
    if Length(edSummCash.SelText) = Length(edSummCash.Text) then
      edSummCash.Value := 5000
    else
      edSummCash.Value := edSummCash.Value + 5000;
  end;
  edSummCash.SelStart := Length(edSummCash.text) - 3;
end;

procedure TSalePaymentForm.btnEqualBonusClick(Sender: TObject);
begin
  edSummCash.Value := 0;
  if (FMaxBonusPaySumm > 0) and (FMaxBonusPaySumm < 100) then
    edSummBonus.Value := Min(Round(FSummZakaz * FMaxBonusPaySumm / 100), FSummBonus)
  else
    edSummBonus.Value := MIN(FSummZakaz, FSummBonus);

  edSdacha.Value := (edSummCash.Value + edSummBonus.Value) - FSummZakaz;
end;

procedure TSalePaymentForm.btnEqualBonusCombinClick(Sender: TObject);
begin
  edSummNonCashCombin.Value := 0;
  edSummCashCombin.Value := 0;
  if FMaxBonusPaySumm <> 100 then
    edSummBonusCombin.Value := Min(Round(FSummZakaz * FMaxBonusPaySumm / 100), FSummBonus)
  else
    edSummBonusCombin.Value := MIN(FSummZakaz, FSummBonus);
end;

procedure TSalePaymentForm.btnEqualBonusNonCashClick(Sender: TObject);
begin
  edSummNonCash.Value := 0;
  if (FMaxBonusPaySumm > 0) and (FMaxBonusPaySumm < 100) then
    edSummBonusNonCash.Value := Min(Round(FSummZakaz * FMaxBonusPaySumm / 100), FSummBonus)
  else
    edSummBonusNonCash.Value := MIN(FSummZakaz, FSummBonus);
end;

procedure TSalePaymentForm.btnEqualCashClick(Sender: TObject);
begin
  edSummBonus.Value := 0;
  edSummCash.Value := FSummZakaz;
end;

procedure TSalePaymentForm.btnEqualCashCombinClick(Sender: TObject);
begin
  edSummBonusCombin.Value := 0;
  edSummNonCashCombin.Value := 0;
  edSummCashCombin.Value := FSummZakaz;
end;

procedure TSalePaymentForm.btnEqualNonCashClick(Sender: TObject);
begin
  edSummBonusNonCash.Value := 0;
  edSummNonCash.Value := FSummZakaz;
end;

procedure TSalePaymentForm.btnEqualNonCashCombinClick(Sender: TObject);
begin
  edSummBonusCombin.Value := 0;
  edSummNonCashCombin.Value := FSummZakaz;
  edSummCashCombin.Value := 0;
end;

procedure TSalePaymentForm.btnOstatokNonCashClick(Sender: TObject);
begin
  edSummNonCash.Value := MinusBtn(btnOstatokNonCash.Name, 0, 0, edSummBonusNonCash.Value);
end;

procedure TSalePaymentForm.btnOstatokNonCashCombinClick(Sender: TObject);
begin
  edSummNonCashCombin.Value := MinusBtn(btnOstatokNonCashCombin.Name, edSummCashCombin.Value, edSummNonCashCombin.Value, edSummBonusCombin.Value);
  CalcSdacha;
end;

procedure TSalePaymentForm.CalcSdacha;
begin
  if pcPayType.ActivePage = tsCash then
    edSdacha.Value := (edSummCash.Value + edSummBonus.Value) - FSummZakaz

  else begin
    if edSummNonCashCombin.Value >= FSummZakaz then
      edSdachaCombin.Value := edSummCashCombin.Value - edSummBonusCombin.Value
    else
      edSdachaCombin.Value := (edSummCashCombin.Value + edSummNonCashCombin.Value + edSummBonusCombin.Value) - FSummZakaz;
  end;
end;

procedure TSalePaymentForm.btnOstatokBonusBeznalClick(Sender: TObject);
begin
  edSummBonusNonCash.Value := MinusBtn(btnOstatokBonusBeznal.Name, 0, edSummCash.Value, 0);
end;

procedure TSalePaymentForm.btnOstatokBonusClick(Sender: TObject);
begin
  edSummBonus.Value := MinusBtn(btnOstatokBonus.Name, edSummCash.Value, 0, 0);
end;

procedure TSalePaymentForm.btnOstatokBonusCombinClick(Sender: TObject);
begin
  edSummBonusCombin.Value := MinusBtn(btnOstatokBonusCombin.Name, edSummCashCombin.Value, edSummNonCashCombin.Value, 0);
  CalcSdacha;
end;

procedure TSalePaymentForm.btnOstatokCashClick(Sender: TObject);
begin
  edSummCash.Value := MinusBtn(btnOstatokCash.Name, 0, 0, edSummBonus.Value);
end;

procedure TSalePaymentForm.btnOstatokCashCombinClick(Sender: TObject);
begin
  edSummCashCombin.Value := MinusBtn(btnOstatokCashCombin.Name, 0, edSummNonCashCombin.Value, edSummBonusCombin.Value);
  CalcSdacha;
end;

function TSalePaymentForm.MinusBtn(BtnName: string; SummCash, SummNonCash, SummBonus : Double): Double;
var availPayBonus : Double;
begin
  Result := 0;

  if (FMaxBonusPaySumm > 0) and (FMaxBonusPaySumm < 100) then
    availPayBonus := Min(Round(FSummZakaz * FMaxBonusPaySumm / 100), FSummBonus)
  else
    availPayBonus := FSummBonus;

  // Вкладка "НАЛ" и "БЕЗНАЛ"
  if (pcPayType.ActivePage = tsCash) or (pcPayType.ActivePage = tsNonCash) then begin

    // Значит нужно высчитать значение для поля Сумма на вкладке "Нал" или "Безнал"
    if (BtnName = 'btnOstatokCash') or (BtnName = 'btnOstatokNonCash') then
      Result := Max(FSummZakaz - SummBonus, 0)

    // Иначе нужно высчитать значение для поля Сумма Бонус на вкладке "Нал" или "Безнал"
    else begin

      if pcPayType.ActivePage = tsCash then
        Result := Max(Min(FSummZakaz - edSummCash.Value, availPayBonus), 0)
      else if pcPayType.ActivePage = tsNonCash then
        Result := Max(Min(FSummZakaz - edSummNonCash.Value, availPayBonus), 0)

    end;

  // Вкладка "СМЕШАННО"
  end else begin

    if BtnName = 'btnOstatokCashCombin' then
      Result := Max(FSummZakaz - SummBonus - SummNonCash, 0)
    else if BtnName = 'btnOstatokNonCashCombin' then
      Result := Max(FSummZakaz - SummBonus - SummCash, 0)
    else
      Result := Max(Min(FSummZakaz - SummNonCash - SummCash, availPayBonus), 0);

  end;
end;

end.
