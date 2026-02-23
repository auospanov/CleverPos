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
var onEditChng : TNotifyEvent;    //чтобы не срабатывало второй раз подр€д при edAmount.Text := Format, буду отключать OnChange
    F : Currency;
    Sel : integer;
begin
  with (Sender as TEdit) do begin
    Sel := Selstart;
    onEditChng := OnChange;
    OnChange := nil;

    if Mode = 0 then begin
      if pos(FormatSettings.DecimalSeparator, Text) > 0 then begin
        if (Length(Text) - pos(FormatSettings.DecimalSeparator, Text)) > 2 then
          Text := Copy(Text, 1, pos(FormatSettings.DecimalSeparator, Text) + 2);

        // нельз€ чтобы число было 00000.00, но при этом можно .00, поэтому смотрю до зап€той сколько символов
        if Length(Copy(Text, 1, pos(FormatSettings.DecimalSeparator, Text)-1)) > 0 then
          Text := FloatToStr(StrToFloat(Copy(Text, 1, pos(FormatSettings.DecimalSeparator, Text)-1))) + Copy(Text, pos(FormatSettings.DecimalSeparator, Text), length(Text));

        // нельз€ удал€ть нули после зап€той
        if (Length(Text) - pos(FormatSettings.DecimalSeparator, Text)) < 2 then
          Text := Text + '0';

      end else begin    // нельз€ удал€ть зап€тую клавишей BCKSPACE
        if StrToFloat(Text) = 0 then
          Text := '0' + FormatSettings.DecimalSeparator + '00'
        else
          Text := Text + FormatSettings.DecimalSeparator + '00';
      end;
    end;
    OnChange := onEditChng;
    Selstart := Sel;
  end;

  if edAmount.Text <> '' then
    F := StrToFloat(edAmount.Text)
  else
    F := 0;

  if Mode = 0 then begin
    F := F*100;     //таким образом € тупо отбрасываю все что после 2-х знаков после зап€той, например 6.785 -> 6.78
    F := trunc(F);  // можно было сразу написать Trunc(F*100)/100;, но так почему-то глючило
    F := F/100;
  end;
  Value := F;
end;

procedure TMyCurrencyFrameForm.edAmountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if mode = 0 then begin
    with (Sender as TEdit) do begin
      if (Selstart > (pos(FormatSettings.DecimalSeparator, Text) + 1)) and not (Key in [8, 37, 39, 46]) then begin
        Selstart := 0;
        FFlag := 1;
      end;

      // нельз€ удал€ть DecimalSeparator клавишей DEL
      if (Key = 46) and (Selstart = pos(FormatSettings.DecimalSeparator, Text) - 1) then
        Key := 0;
    end;
  end;
end;

procedure TMyCurrencyFrameForm.edAmountKeyPress(Sender: TObject;
  var Key: Char);
const Digit: set of Char=['1'..'9', '0', #8]; //ћножество цифр, допустимых дл€ ввода в edit:
      Separator: set of AnsiChar=['/', '.', ',', 'ю', 'ё', 'б', 'Ѕ']; //ћножество символов, воспринимаемых как символ-разделитель:
var n : integer;
    onEditChng : TNotifyEvent;    //чтобы не срабатывало второй раз подр€д при edAmount.Text := Format, буду отключать OnChange
    PosD : integer;
begin
  with (Sender as TEdit) do begin
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
        //если изначально стоит 1.00, а пользователь хочет ввести 0.56, то мен€ю первую единицу на 0, пользовател€м надоело каждый раз удал€ть единицу
        if (Selstart = 0) and (PosD > 1) and (Key = '0') and (Copy(edAmount.Text, 1, PosD-1) = '1') then begin
          Text := StringReplace(Text, '1', '0',[]);
          Selstart := Selstart + 1;
          Exit;
        end else
        // нельз€ ставить 0 в начале числа, например перед 78.56
        if (Selstart = 0) and (PosD > 1) and (Key = '0') then begin
          Key:=#0;
          Selstart := Selstart + 1;
          Exit;
        end;
      end;

      // нельз€ ставить вторую точку в такой ситуации 0..15, надо чтобы она просто перескакивала
      if (PosD > 1) and (Selstart = PosD - 1) and (CharInSet(Ansistring(Key)[1], Separator)) then begin
        Key:=#0;
        Selstart := Selstart + 1;
        Exit;
      end;

      // нельз€ ставить 0 перед зап€той, если число и там и так стоит 0.
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
          Key := FormatSettings.DecimalSeparator; //Delphi-константа типа Char, равна€ символу-разделителю Windows
        finally
          OnChange := onEditChng;
        end;
      end else
        if (not(Key in Digit)) then
          Key:=#0;
    end
    else begin
      // нельз€ ставить 0 в начале числа, например перед 78.56
      if (Selstart = 0) and (Key = '0') then begin
        Key:=#0;
        Selstart := Selstart + 1;
        Exit;
      end;
    end;
  end;
end;

procedure TMyCurrencyFrameForm.sbCurDownClick(Sender: TObject);
var I : Double;
begin
  I := StrToFloat(edAmount.Text) - 1;

  if I < 0 then
    edAmount.Text := '0'
  else
    edAmount.Text := FloatToStr(StrToFloat(edAmount.Text) - 1);
end;

procedure TMyCurrencyFrameForm.sbCurUpClick(Sender: TObject);
begin
  edAmount.Text := FloatToStr(StrToFloat(edAmount.Text) + 1);
end;

procedure TMyCurrencyFrameForm.edAmountExit(Sender: TObject);
begin
  if (Mode = 1) and (edAmount.Text = '') then
    edAmount.Text := '0';
end;

end.