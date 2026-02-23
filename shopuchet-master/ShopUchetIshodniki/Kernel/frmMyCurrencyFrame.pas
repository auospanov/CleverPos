unit frmMyCurrencyFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, StdCtrls, Math, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit,
  cxMaskEdit, cxSpinEdit, cxSpinButton;

type
  TMyCurrencyFrameForm = class(TFrame)
    edAmount: TEdit;
    sbCur: TSpinButton;
    procedure edAmountChange(Sender: TObject);
    procedure edAmountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edAmountKeyPress(Sender: TObject; var Key: Char);
    procedure sbCurDownClick(Sender: TObject);
    procedure sbCurUpClick(Sender: TObject);
    procedure edAmountExit(Sender: TObject);
  private
    FFlag : integer;   //знак того, что произошел луп и курсор пришел с конца строки, пока ничего не вводить
    Procedure AfterConstruction; Override;
  public
    Value : Double;
    Mode : Integer;  // 0 - дробное значение, 1 - целое
  end;

implementation

uses
  unCommonFunc;

{$R *.dfm}
type
  TMEdit = class(TEdit)
  procedure CreateParams(var Params: TCreateParams); override;
  end;

{ TMEdit }
procedure TMEdit.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or ES_RIGHT;
end;

Procedure TMyCurrencyFrameForm.AfterConstruction;
begin
  inherited;
  PPointer(edAmount)^ := TMEdit;
  FFlag := 0;
end;

procedure TMyCurrencyFrameForm.edAmountChange(Sender: TObject);
var onEditChng : TNotifyEvent;    //чтобы не срабатывало второй раз подряд при edAmount.Text := Format, буду отключать OnChange
    F : Currency;
    Sel, DecimalLen : integer;
    Str, Nol : string;
begin
  Nol := '0';
  with (Sender as TEdit) do begin
    if Text <> '' then begin
      Sel := Selstart;
      onEditChng := OnChange;
      OnChange := nil;
      if FormatSettings.CurrencyDecimals > 0 then begin
          if Mode = 0 then begin
            if pos(FormatSettings.DecimalSeparator, Text) > 0 then begin
              if (Length(Text) - pos(FormatSettings.DecimalSeparator, Text)) > FormatSettings.CurrencyDecimals then
                Text := Copy(Text, 1, pos(FormatSettings.DecimalSeparator, Text) + FormatSettings.CurrencyDecimals);

              // нельзя чтобы число было 00000.00, но при этом можно .00, поэтому смотрю до запятой сколько символов
              if Length(Copy(Text, 1, pos(FormatSettings.DecimalSeparator, Text)-1)) > 0 then
                Text := FloatToStr(StrToFloat(Copy(Text, 1, pos(FormatSettings.DecimalSeparator, Text)-1))) + Copy(Text, pos(FormatSettings.DecimalSeparator, Text), length(Text));

              // нельзя удалять нули после запятой
              if (Length(Text) - pos(FormatSettings.DecimalSeparator, Text)) < FormatSettings.CurrencyDecimals then
                Text := Text + '0';

            end else begin    // нельзя удалять запятую клавишей BCKSPACE
              if StrToFloat(Text) = 0 then
                Text := '0' + FormatSettings.DecimalSeparator + Nol.PadRight(FormatSettings.CurrencyDecimals, '0')
              else
                Text := Text + FormatSettings.DecimalSeparator + Nol.PadRight(FormatSettings.CurrencyDecimals, '0');
            end;
          end;

          // привожу к правильному формату, который задан длиной FormatSettings.CurrencyDecimals
          DecimalLen := Length((Sender as TEdit).Text) -
           Length(Copy((Sender as TEdit).Text, 1, pos(FormatSettings.DecimalSeparator, (Sender as TEdit).Text)));

          if FormatSettings.CurrencyDecimals <> DecimalLen then begin
            Str := (Sender as TEdit).Text;
            Str := Str + Nol.PadRight(FormatSettings.CurrencyDecimals - DecimalLen, '0');  // 1 знак - это '0' который стоит перед PadRight
            (Sender as TEdit).Text := Str;
          end;

      end else begin
        if pos(FormatSettings.DecimalSeparator, (Sender as TEdit).Text) > 0 then
          (Sender as TEdit).Text := Copy((Sender as TEdit).Text, 1, pos(FormatSettings.DecimalSeparator, (Sender as TEdit).Text)-1);

        if Text = '' then
          Text := '0';
      end;
      OnChange := onEditChng;
      Selstart := Sel;
    end;
  end;

  if edAmount.Text <> '' then
    F := StrToFloat(edAmount.Text)
  else
    F := 0;

  if Mode = 0 then begin
    F :=  F * Power(10, FormatSettings.CurrencyDecimals);     //таким образом я тупо отбрасываю все что после 2-х знаков после запятой, например 6.785 -> 6.78
    F := trunc(F);  // можно было сразу написать Trunc(F*100)/100;, но так почему-то глючило
    F := F/Power(10, FormatSettings.CurrencyDecimals);
  end;
  Value := F;
end;

procedure TMyCurrencyFrameForm.edAmountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if mode = 0 then begin
    with (Sender as TEdit) do begin
      if FormatSettings.CurrencyDecimals > 0 then begin
        if (Selstart > (pos(FormatSettings.DecimalSeparator, Text) + (FormatSettings.CurrencyDecimals - 1))) and not (Key in [8, 37, 39, 46]) then begin
          Selstart := 0;
          FFlag := 1;
        end;

        // нельзя удалять DecimalSeparator клавишей DEL
        if (Key = 46) and (Selstart = pos(FormatSettings.DecimalSeparator, Text) - 1) then
          Key := 0;
      end;
    end;
  end;
end;

procedure TMyCurrencyFrameForm.edAmountKeyPress(Sender: TObject;
  var Key: Char);
const Digit: set of Char=['1'..'9', '0', #8]; //Множество цифр, допустимых для ввода в edit:
      Separator: set of AnsiChar=['/', '.', ',', 'ю', 'Ю', 'б', 'Б']; //Множество символов, воспринимаемых как символ-разделитель:
var n, l : integer;
    onEditChng : TNotifyEvent;    //чтобы не срабатывало второй раз подряд при edAmount.Text := Format, буду отключать OnChange
    PosD : integer;
begin
  with (Sender as TEdit) do begin
    if FormatSettings.CurrencyDecimals > 0 then begin
        if Mode = 0 then begin
          PosD := pos(FormatSettings.DecimalSeparator, Text);
          if (Selstart = 0) and (FFlag = 1) then begin
            Key:=#0;
            FFlag := 0;
            Exit;
          end;

          if (Key = #8) and (Selstart = PosD) then begin
            Key := #0;
            Selstart := Selstart - 1;
            Exit;
          end;

          //если юзер выделил часть или полностью, то в этом случае мне надо плевать на все, и давать ему ввести первую цифру какую хочет
          if SelText = '' then begin
            //если изначально стоит 1.00, а пользователь хочет ввести 0.56, то меняю первую единицу на 0, пользователям надоело каждый раз удалять единицу
            if (Selstart = 0) and (PosD > 1) and (Key = '0') and (Copy(edAmount.Text, 1, PosD-1) = '1') then begin
              Text := StringReplace(Text, '1', '0',[]);
              Selstart := Selstart + 1;
              Exit;
            end else
            // нельзя ставить 0 в начале числа, например перед 78.56
            if (Selstart = 0) and (PosD > 1) and (Key = '0') then begin
              Key:=#0;
              Selstart := Selstart + 1;
              Exit;
            end;
          end;

          // нельзя ставить вторую точку в такой ситуации 0..15, надо чтобы она просто перескакивала
          if (PosD > 1) and (Selstart = PosD - 1) and (CharInSet(Ansistring(Key)[1], Separator)) then begin
            Key:=#0;
            Selstart := Selstart + 1;
            Exit;
          end;

          // нельзя ставить 0 перед запятой, если число и там и так стоит 0.
          if (Selstart = PosD - 1) and (Copy(Text, 1, PosD-1) = '0') then begin
            if (Key = '0') then begin
              Key:=#0;
              Selstart := Selstart + 1;
            end else begin
              Selstart := Selstart - 1;
              Text := Copy(Text, PosD, Length(Text));
            end;
            Exit;
          end;

          if (CharInSet(Ansistring(Key)[1], Separator)) and (Selstart < PosD) then begin
            try
              onEditChng := OnChange;
              OnChange := nil;
              n := Selstart;
              Text := StringReplace(Text, FormatSettings.DecimalSeparator, '',[rfReplaceAll, rfIgnoreCase]);
              SelStart := n;
              Key := FormatSettings.DecimalSeparator; //Delphi-константа типа Char, равная символу-разделителю Windows
            finally
              OnChange := onEditChng;
            end;
          end else
            if (not(Key in Digit)) then
              Key:=#0;
        end
        else begin
          // нельзя ставить 0 в начале числа, например перед 78.56
          if (Selstart = 0) and (Key = '0') then begin
            Key:=#0;
            Selstart := Selstart + 1;
            Exit;
          end;
        end;
    end
    else begin
      // нельзя ставить 0 в начале числа, например перед 78
      if (Selstart = 0) and (Key = '0') then begin
        Key:=#0;
        Selstart := Selstart + 1;
        Exit;
      end;

      // нельзя ставить 0, если там и так стоит 0
      if (StrToInt(Text) = 0) and (Key = '0') then begin
        Key := #0;
        Exit;
      end;

      // если стоит 0, то меняю его сразу на вводимое число
      if (StrToInt(Text) = 0) and (Key <> '0') then begin
        try
          onEditChng := OnChange;
          OnChange := nil;
          Text := Key;
          Key := #0;
          Selstart := Selstart + 1;
          Exit;
        finally
          OnChange := onEditChng;
        end;
      end;
    end;
  end;
end;

procedure TMyCurrencyFrameForm.sbCurDownClick(Sender: TObject);
var I : Double;
begin
  if edAmount.Text = '' then
    edAmount.Text := '0';

  I := StrToFloat(edAmount.Text) - 1;

  if I < 0 then
    edAmount.Text := '0'
  else
    edAmount.Text := FloatToStr(StrToFloat(edAmount.Text) - 1);
end;

procedure TMyCurrencyFrameForm.sbCurUpClick(Sender: TObject);
begin
  if edAmount.Text = '' then
    edAmount.Text := '0';

  edAmount.Text := FloatToStr(StrToFloat(edAmount.Text) + 1);
end;

procedure TMyCurrencyFrameForm.edAmountExit(Sender: TObject);
begin
  if (Mode = 1) and (edAmount.Text = '') then
    edAmount.Text := '0';
end;

end.