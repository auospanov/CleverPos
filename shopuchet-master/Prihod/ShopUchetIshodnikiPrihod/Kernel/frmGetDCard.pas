unit frmGetDCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ActnList, AppEvnts, ExtCtrls,
  StdCtrls, Buttons, FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery,
  pFIBStoredProc, DateUtils, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxCurrencyEdit, cxTextEdit, cxCheckBox, Vcl.Menus,
  System.Actions, cxClasses, cxButtons;

type
  TGetDCardForm = class(TDBDlgForm)
    Label4: TLabel;
    Shape8: TShape;
    Shape7: TShape;
    aSearch: TAction;
    spGetCard: TpFIBStoredProc;
    tranRead: TpFIBTransaction;
    Label6: TLabel;
    Shape11: TShape;
    Shape16: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    lbBonusSumm: TLabel;
    lbAllSumm: TLabel;
    edBarcode: TcxTextEdit;
    edClient: TcxTextEdit;
    sePercent: TcxCurrencyEdit;
    cbCloseDialog: TcxCheckBox;
    cxButton1: TcxButton;
    procedure aSearchExecute(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    FDiscont_card : Integer;
    KeysBuffer: String;
    LastDateForAddedKey: TDateTime;
    FClient : Integer;
    FSummBonus : String;
    FSummBonusNum : Double;
    procedure SearchCard;
  public
    property Client : Integer read FClient write FClient;
    property SummBonus : String read FSummBonus write FSummBonus;
    property SummBonusNum : Double read FSummBonusNum write FSummBonusNum;
    property Discont_card : Integer read FDiscont_card write FDiscont_card;
  end;

var
  GetDCardForm: TGetDCardForm;

implementation

{$R *.dfm}

procedure TGetDCardForm.aSearchExecute(Sender: TObject);
begin
  spGetCard.ParamByName('card_code_').AsString := edBarcode.Text;
  spGetCard.ParamByName('G_DISCONT_CARD_').AsInteger := 0;
  SearchCard;
end;

procedure TGetDCardForm.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
  procedure ClearBuffer;
  begin
    if MilliSecondsBetween(Now, LastDateForAddedKey) > 200 then
    begin
      // при медленном вводе буфер очищяется, т.к. скан идет "мгновенно"
      KeysBuffer := '';
    end;
  end;
begin
  // обработка штрих-кодов
  // автор: jaydi85@gmail.com

  // данные считываем на WM_CHAR
  // НО КЛАВИШУ ЭНТЕР на WM_KEYDOWN

  // заканчиваем ввод
  IF Screen.ActiveForm <> Nil THEN BEGIN
    IF Screen.ActiveForm.Name = Self.Name THEN BEGIN
      if Msg.message = WM_KEYDOWN then
      begin
        if (Msg.wParam = 13) or (Msg.wParam = 10) then
        begin
          ClearBuffer;
          if KeysBuffer <> '' then begin
            // при сканировании нажатие энтера передавать никуда не надо
            Handled := True;
            aSearch.Execute;
            KeysBuffer := '';
          end;
        end
      end;

      // сохраняем ввод
      if Msg.message = WM_CHAR then
      begin
        ClearBuffer;
        if Msg.wParam <> 13 then
        begin
          // нажали что-то другое (надо отбросить всякие шифты и контролы)
          KeysBuffer := KeysBuffer + Chr(Msg.wParam);
          LastDateForAddedKey := Now;
        end;
      end;
    END;
  END;
end;

procedure TGetDCardForm.FormShow(Sender: TObject);
begin
  inherited;
  if Discont_card > 0 then begin
    spGetCard.ParamByName('G_DISCONT_CARD_').AsInteger := FDiscont_card;
    spGetCard.ParamByName('card_code_').AsString := '';
    SearchCard;
  end;
end;

procedure TGetDCardForm.SearchCard;
begin
  if CallSpWithout(spGetCard) then begin
    with spGetCard do begin
      FClient := ParamByName('g_client_').AsInteger;
      if cbCloseDialog.Checked then
        btnOk.Click;

      if FClient = 0 then
        ShowMessage('Дисконтная карта не найдена!')
      else begin
        edClient.Text := ParamByName('client_NAME_').AsString;
        edBarcode.Text := ParamByName('BARCODE_').AsString;
        sePercent.Value := ParamByName('N_PERCENT_').AsFloat;
        FSummBonusNum := ParamByName('SUMM_').asFloat;

        FormatSettings.ThousandSeparator := ' ';
        FormatSettings.CurrencyString := '';
        FSummBonus := StringReplace(FloatToStrF(ParamByName('SUMM_').AsFloat, ffCurrency, 10, 2), '.', ',', [rfReplaceAll]);
        lbBonusSumm.Caption := 'Сумма накоплений ' + FSummBonus;
        lbAllSumm.Caption := 'Общая сумма покупок ' + StringReplace(FloatToStrF(ParamByName('SUMM_All_').AsFloat, ffCurrency, 10, 2), '.', ',', [rfReplaceAll]);
      end;
    end;
  end;
end;

procedure TGetDCardForm.btHelpClick(Sender: TObject);
begin
  HELPC := 18;
  inherited;
end;

end.
