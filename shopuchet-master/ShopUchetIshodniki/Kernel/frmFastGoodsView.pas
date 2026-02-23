unit frmFastGoodsView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.ExtCtrls, Data.DB, FIBDataSet,
  pFIBDataSet, cxEditRepositoryItems, cxEdit, cxClasses, cxContainer,
  Vcl.AppEvnts, Vcl.StdCtrls, cxButtons, unCommonFunc, FIBDatabase, pFIBDatabase,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFastGoodsViewForm = class(TDlgForm)
    spRead: TpFIBDataSet;
    ScrollBox: TScrollBox;
    FlowPanel: TFlowPanel;
    tranRead: TpFIBTransaction;
    procedure FormShow(Sender: TObject);
  private
    FGprod : Int64;
    FPrice : Double;
    FVolumePrice : Double;
    FVesGrammPrice : Double;
    FOstatok : Double;
    FIsKit : Integer;
    FIsMarked : Integer;
    FIsTovarVes : Integer;
    FMainMenu : Integer;
    FArrIdParent  : Array of Int64; // массив ID родителей, текущий уровень - последн€€ ID
    procedure WMClickFastTovView(var Message: TMessage); message WM_CLICK_FAST_TOVVIEW;
    procedure ClickTovarViewButton(Sender: TObject);
    procedure FillTovarViewButtons(MainMenu : Integer = 0);  // Category = true значит надо идти по категори€м
    procedure ClearTovarViewButtons;
  public
    property GProd : Int64 read FGprod;
    property Price : Double read FPrice;
    property VolumePrice : Double read FVolumePrice;
    property VesGrammPrice : Double read FVesGrammPrice;
    property Ostatok : Double read FOstatok;
    property IsKit : Integer read FIsKit;
    property IsMarked : Integer read FIsMarked;
    property IsTovarVes : Integer read FIsTovarVes;
  end;

var
  FastGoodsViewForm: TFastGoodsViewForm;

implementation

{$R *.dfm}

procedure TFastGoodsViewForm.FormShow(Sender: TObject);
var vButton:TcxButton;
begin
  inherited;

  Color := clBtnFace;
  Panel1.Color := clBtnFace;
  FMainMenu := 1;
  SetLength(FArrIdParent, 0);

  FillTovarViewButtons(FMainMenu);

  {Color := clBtnFace;
  Panel1.Color := clBtnFace;
  spRead.ParamByName('g_tochka_').AsInt64 := CurSklad;
  OpenSP(spRead, false);

  spRead.First;
  while not spRead.Eof do begin
    vButton:= TcxButton.Create(self);
    vButton.Parent := FlowPanel;
    vButton.width := 100;
    vButton.height := 100;
    vButton.OnClick := ClickTovarViewButton;
    vButton.Caption:= spRead.FieldByName('Name').AsString;
    vButton.WordWrap := True;
    if Length(vButton.Caption) <= 50 then
      vButton.Font.Size := 10
    else
      vButton.Font.Size := 8;
    vButton.Font.Color := clBlack;
    vButton.LookAndFeel.Kind := lfFlat;
    vButton.Description := spRead.FieldByName('g_product').AsString + '|||' +
      spRead.FieldByName('price').AsString + '|||' + spRead.FieldByName('volume_price').AsString +
      '|||' + spRead.FieldByName('OSTATOK').AsString + '|||' + spRead.FieldByName('IS_KIT').AsString +
      '|||' + spRead.FieldByName('is_marked').AsString;

    spRead.Next;
  end;}

  if Screen.Height <= 768 then begin
    Height := ScaleDimension(450);
    Width := ScaleDimension(680);
    Panel1.Width := ScaleDimension(656);
    FlowPanel.Width := Panel1.Width;
    btnOk.Left := ScaleDimension(419);
    btnCancel.Left := ScaleDimension(546);
  end;
end;

procedure TFastGoodsViewForm.FillTovarViewButtons(MainMenu: Integer = 0);
var vButton:TcxButton;
begin
  spRead.ParamByName('IS_MAIN_').AsInt64 := MainMenu;

  if MainMenu = 0 then begin
    spRead.ParamByName('g_tochka_').AsInt64 := CurSklad;
  end;

  // делаю кнопку Ќазад
  if High(FArrIdParent) > -1 then begin
    spRead.ParamByName('G_PRODUCT_PAR_').AsInt64 := FArrIdParent[High(FArrIdParent)];
    vButton:= TcxButton.Create(self);
    vButton.Parent := FlowPanel;
    vButton.width := 100;
    vButton.height := 100;
    vButton.OnClick := ClickTovarViewButton;
    vButton.Caption:= 'Ќазад';
    vButton.WordWrap := True;
    vButton.Font.Size := 10;
    vButton.Font.Color := clBlack;
    vButton.LookAndFeel.Kind := lfFlat;
    vButton.Colors.Default := clWebDarkGray;
    vButton.Tag := -100;
  end;

  OpenSp(spRead, False);
  spRead.First;
  while not spRead.Eof do begin
    vButton:= TcxButton.Create(self);
    vButton.Parent := FlowPanel;
    vButton.width := 100;
    vButton.height := 100;
    vButton.OnClick := ClickTovarViewButton;
    vButton.Caption:= spRead.FieldByName('Name').AsString;
    vButton.WordWrap := True;
    if Length(vButton.Caption) <= 50 then
      vButton.Font.Size := 10
    else
      vButton.Font.Size := 8;
    vButton.Font.Color := clBlack;
    vButton.LookAndFeel.Kind := lfFlat;
    vButton.Tag := spRead.FieldByName('is_category').AsInteger;

    if spRead.FieldByName('is_category').AsInteger = 1 then
      vButton.Description := spRead.FieldByName('g_product').AsString
    else
      vButton.Description := spRead.FieldByName('g_product').AsString + '|||' +
        spRead.FieldByName('price').AsString + '|||' + spRead.FieldByName('volume_price').AsString +
        '|||' + spRead.FieldByName('OSTATOK').AsString + '|||' + spRead.FieldByName('IS_KIT').AsString +
        '|||' + spRead.FieldByName('is_marked').AsString + '|||' + spRead.FieldByName('is_weight').AsString +
        '|||' + spRead.FieldByName('ves_gramm_price').AsString;

    spRead.Next;
  end;
end;

procedure TFastGoodsViewForm.ClearTovarViewButtons;
var i : Integer;
begin
  for I := FlowPanel.ControlCount - 1 downto 0 do
    FlowPanel.Controls[i].Free;
end;

procedure TFastGoodsViewForm.ClickTovarViewButton(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLICK_FAST_TOVVIEW, WPARAM(Sender), 0);
end;

procedure TFastGoodsViewForm.WMClickFastTovView(var Message: TMessage);
var Str, str1 : string;
  Id : int64;
begin
  // если нажали кнопку Ќазад
  if TcxButton(Message.WParam).Tag = -100 then begin
    SetLength(FArrIdParent, High(FArrIdParent));

    ClearTovarViewButtons;
    // если в массиве родительских категорий больше ничего нет, значит надо возвращатьс€ в
    // главное меню
    if High(FArrIdParent) = -1 then
      FillTovarViewButtons(1)
    else
      FillTovarViewButtons(0);

    Exit;
  end;

  if TcxButton(Message.WParam).Tag = 1 then begin
    Id := StrToInt64(TcxButton(Message.WParam).Description);
    SetLength(FArrIdParent, High(FArrIdParent) + 2);
    FArrIdParent[High(FArrIdParent)] := Id;
    ClearTovarViewButtons;
    FillTovarViewButtons(0);

  end else begin
    Str  := TcxButton(Message.WParam).Description;
    str1 := Copy(Str, 1, Pos('|||', Str) - 1);
    FGProd := StrToInt64(str1);

    Str  := Copy(Str, Pos('|||', Str) + 3, Length(Str));
    str1 := Copy(Str, 1, Pos('|||', Str) - 1);
    Fprice := StrToFloat(str1);

    Str  := Copy(Str, Pos('|||', Str) + 3, Length(Str));
    str1 := Copy(Str, 1, Pos('|||', Str) - 1);
    FVolumePrice := StrToFloat(str1);

    Str  := Copy(Str, Pos('|||', Str) + 3, Length(Str));
    str1 := Copy(Str, 1, Pos('|||', Str) - 1);
    FOstatok := StrToFloat(str1);

    Str  := Copy(Str, Pos('|||', Str) + 3, Length(Str));
    str1 := Copy(Str, 1, Pos('|||', Str) - 1);
    FIsKit := StrToInt(str1);

    Str  := Copy(Str, Pos('|||', Str) + 3, Length(Str));
    str1 := Copy(Str, 1, Pos('|||', Str) - 1);
    FIsMarked := StrToInt(str1);

    Str  := Copy(Str, Pos('|||', Str) + 3, Length(Str));
    str1 := Copy(Str, 1, Pos('|||', Str) - 1);
    FIsTovarVes := StrToInt(str1);

    Str  := Copy(Str, Pos('|||', Str) + 3, Length(Str));
    FVesGrammPrice := StrToFloat(str);

    btnOk.Click;
  end;
end;

end.
