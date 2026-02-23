unit frmDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, TypInfo, Registry,
  cxPC, dxBar,
  unCommonFunc, cxGrid, AppEvnts, Tabs, cxCalendar, cxClasses,
  cxContainer, cxEdit, cxGraphics, cxTextEdit, cxMemo, cxCheckBox, cxCustomData, cxDropDownEdit,
  cxLookAndFeels, cxLookAndFeelPainters, cxButtons, cxControls, cxMaskEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox,
  cxImage, cxStyles, cxFilter, cxData, cxCurrencyEdit,
  cxDataStorage, cxNavigator, cxDBData, cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer, cxTLData, cxDBTL, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, Menus, System.UITypes,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TDlgForm = class(TForm)
    Panel1: TPanel;
    ApplicationEvents1: TApplicationEvents;
    dxEditStyleController: TcxEditStyleController;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
  private
    FToolbarStyle: TdxBarManagerStyle;
    FtbButtonsStyle: TtbButtonsStyle;
    FCustomStyle: TCustomStyle;
    FTabStyle: TcxPCStyleID;

    FPopupFormBorderStyle: TcxEditPopupBorderStyle;
    FPopupFlatBorder: Boolean;

    FGridFontSize: Integer;
    FGridFontName: String;

{}    procedure WMSysCommand (var Message: TWMSYSCOMMAND); message WM_SYSCOMMAND;

    procedure WMGetData(var Message: TMessage); message WM_GETDATA;
    procedure WMSetControlsNotModified(var Message: TMessage); message WM_SETCONTROLSNOTMODIFIED;
  protected
    procedure GetData; virtual;
    procedure GetCustomStyle; virtual;
    procedure SetCustomStyle; virtual;
    procedure ReadOnlyControls; virtual;
  public
    procedure SetControlsNotModified; virtual;
    property ToolbarStyle: TdxBarManagerStyle read FToolbarStyle write FToolbarStyle;
    property CustomStyle: TCustomStyle read FCustomStyle write FCustomStyle;
    property TabStyle: TcxPCStyleID read FTabStyle write FTabStyle;
  end;

implementation

uses dmMain, unInitApp, frmMain;

{$R *.DFM}

{ TDlgForm }

procedure TDlgForm.FormShow(Sender: TObject);
begin
  inherited;

  //btnCancel.Caption := 'Отмена';

  {Изменяем стиль оформления диалогового окна в соответствии с настройками пользователя}
  GetCustomStyle;
  SetCustomStyle;

  PostMessage(Self.Handle, WM_GETDATA, 0, 0);
end;

procedure TDlgForm.WMGetData(var Message: TMessage);
begin
  Repaint;
  GetData;
end;

procedure TDlgForm.WMSysCommand(var Message: TWMSYSCOMMAND);
//var
//  HintWindow: THintWindow;
begin
  case Message.CmdType of
    SC_MINIMIZE:
      begin
        ShowWindow(Application.Handle, SW_MINIMIZE);
      end;

    SC_CONTEXTHELP:
      begin
{}      inherited;
      // THintWindow.Create... а лучше - см. в Сокровищнице:
      // http://delphi.vitpc.com/treasury/s001.htm
      end
  else
    inherited;
  end;
end;

procedure TDlgForm.GetData;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TcxLookupComboBox then
      (Components[i] as TcxLookupComboBox).Properties.DropDownRows := 15;

  PostMessage(Self.Handle, WM_SETCONTROLSNOTMODIFIED, 0, 0);
  {Обработчик сооб-я будет вызван ТОЛЬКО ПОСЛЕ отработки этого метода в потомке}

// Все остальное задается в потомке
end;

procedure TDlgForm.WMSetControlsNotModified(var Message: TMessage);
begin
  SetControlsNotModified;
end;

procedure TDlgForm.SetControlsNotModified;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
    if (Self.Components[i] is TCustomEdit) then
      (Self.Components[i] as TCustomEdit).Modified := False
    else
      if (Self.Components[i] is TcxTextEdit) then
        (Self.Components[i] as TcxTextEdit).ModifiedAfterEnter := False;
end;

procedure TDlgForm.ReadOnlyControls;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
    begin
      {if Components[i].ClassType = tcxEdit then begin
        (Components[i] as tdxEdit).ReadOnly := True;
        (Components[i] as tdxEdit).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tdxMemo then begin
        (Components[i] as tdxMemo).ReadOnly := True;
        (Components[i] as tdxMemo).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tMemo then begin
        (Components[i] as tMemo).ReadOnly := True;
        (Components[i] as tMemo).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TdxDateEdit then begin
        (Components[i] as TdxDateEdit).ReadOnly := True;
        (Components[i] as TdxDateEdit).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TCxDateEdit then begin
        (Components[i] as TCxDateEdit).Enabled := False;
      end
      else if Components[i].ClassType = TdxCheckEdit then begin
        (Components[i] as TdxCheckEdit).ReadOnly := True;
        (Components[i] as TdxCheckEdit).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TdxPickEdit then begin
        (Components[i] as TdxPickEdit).ReadOnly := True;
        (Components[i] as TdxPickEdit).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TdxPopupEdit then begin
        (Components[i] as TdxPopupEdit).ReadOnly := True;
        (Components[i] as TdxPopupEdit).Enabled := False;
        (Components[i] as TdxPopupEdit).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TdxLookupEdit then begin
        (Components[i] as TdxLookupEdit).ReadOnly := True;
        (Components[i] as TdxLookupEdit).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxLookupComboBox then begin
        (Components[i] as TcxLookupComboBox).Properties.ReadOnly := True;
        (Components[i] as TcxLookupComboBox).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TdxDBEdit then begin
        (Components[i] as TdxDBEdit).ReadOnly := True;
        (Components[i] as TdxDBEdit).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TSpeedButton then
        (Components[i] as TSpeedButton).Enabled := False
      else if Components[i].ClassType = TRadioButton then
        (Components[i] as TRadioButton).Enabled := False;}
      if Components[i].ClassType = tcxTextEdit then begin
        (Components[i] as tcxTextEdit).Properties.ReadOnly := True;
        (Components[i] as tcxTextEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tcxCurrencyEdit then begin
        (Components[i] as tcxCurrencyEdit).Properties.ReadOnly := True;
        (Components[i] as tcxCurrencyEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tcxMemo then begin
        (Components[i] as tcxMemo).Properties.ReadOnly := True;
        (Components[i] as tcxMemo).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = tMemo then begin
        (Components[i] as tMemo).ReadOnly := True;
        (Components[i] as tMemo).Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxDateEdit then begin
        (Components[i] as TcxDateEdit).Properties.ReadOnly := True;
        (Components[i] as TcxDateEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TCxDateEdit then begin
        (Components[i] as TCxDateEdit).Enabled := False;
      end
      else if Components[i].ClassType = TcxCheckBox then begin
        (Components[i] as TcxCheckBox).Properties.ReadOnly := True;
        (Components[i] as TcxCheckBox).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxComboBox then begin
        (Components[i] as TcxComboBox).Properties.ReadOnly := True;
        (Components[i] as TcxComboBox).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxPopupEdit then begin
        (Components[i] as TcxPopupEdit).Properties.ReadOnly := True;
        (Components[i] as TcxPopupEdit).Enabled := False;
        (Components[i] as TcxPopupEdit).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TcxLookupComboBox then begin
        (Components[i] as TcxLookupComboBox).Properties.ReadOnly := True;
        (Components[i] as TcxLookupComboBox).Style.Font.Color := clGrayText;
      end
      else if Components[i].ClassType = TSpeedButton then
        (Components[i] as TSpeedButton).Enabled := False
      else if Components[i].ClassType = TRadioButton then
        (Components[i] as TRadioButton).Enabled := False;
    end;
end;

procedure TDlgForm.GetCustomStyle;
var
  Reg: TRegistry;
begin
  try
    Reg := TRegistry.Create;
    try
      with Reg do begin
        RootKey := RegSetupRoot;
        LazyWrite := False;  {Сохраняем ключи до закрытия}
        if OpenKey(RegSetupKey, True) then
          try
            {----------------------------}
            if ValueExists('ToolbarStyle') then
              FToolbarStyle := TdxBarManagerStyle(ReadInteger('ToolbarStyle'))
            else begin
              FToolbarStyle := bmsEnhanced;
              WriteInteger('ToolbarStyle', Integer(FToolbarStyle));
            end;
            {----------------------------}
            if ValueExists('tbButtonsStyle') then
              FtbButtonsStyle := TtbButtonsStyle(ReadInteger('tbButtonsStyle'))
            else begin
              FtbButtonsStyle := bsGlyphText;
              WriteInteger('tbButtonsStyle', Integer(FtbButtonsStyle));
            end;
            {----------------------------}
            if ValueExists('CustomStyle') then
              FCustomStyle := TCustomStyle(ReadInteger('CustomStyle'))
            else begin
              FCustomStyle := csRealBlank;
              WriteInteger('CustomStyle', Integer(FCustomStyle));
            end;
            {----------------------------}
            if ValueExists('TabStyle') then
              FTabStyle := TcxPCStyleID(ReadInteger('TabStyle'))
            else begin
              FTabStyle := 4{dxtsFlat};
              WriteInteger('TabStyle', Integer(FTabStyle));
            end;

            {----------------------------}
            if ValueExists('PopupFormBorderStyle') then
              FPopupFormBorderStyle := TcxEditPopupBorderStyle(ReadInteger('PopupFormBorderStyle'))
            else begin
              FPopupFormBorderStyle := epbsSingle;
              WriteInteger('PopupFormBorderStyle', Integer(FPopupFormBorderStyle));
            end;

            if ValueExists('PopupFlatBorder') then
              FPopupFlatBorder := ReadBool('PopupFlatBorder')
            else begin
              FPopupFlatBorder := True;
              WriteBool('PopupFlatBorder', FPopupFlatBorder);
            end;

            {----------------------------}
            if ValueExists('GridFontName') then
              FGridFontName := ReadString('GridFontName')
            else begin
              FGridFontName := 'Tahoma';
              WriteString('GridFontName', FGridFontName);
            end;

            if ValueExists('GridFontSize') then
              FGridFontSize := ReadInteger('GridFontSize')
            else begin
              FGridFontSize := 9;
              WriteInteger('GridFontSize', FGridFontSize);
            end;
            {----------------------------}
          finally
            CloseKey;
          end;
      end;
    finally
      Reg.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message + #13#10'(occured in TDlgForm.GetCustomStyle)', mtInformation, [mbOk], 0);
  end;
end;

procedure TDlgForm.SetCustomStyle;
var
  i: Integer;
  BarManager: TdxBarManager;
  HeaderStyle : TcxStyle;
  CxGridArr : array of TcxGridDBTableView;
  str : string;
begin
  case FCustomStyle of
    csShadow: {Затененный}
      begin
        with dxEditStyleController do begin
          Style.BorderColor := $00E2BC6D;
          Style.BorderStyle := ebsSingle;
          Style.ButtonStyle := btsSimple;
          Style.ButtonTransparency := ebtNone;
          Style.HotTrack := True;
          Style.Shadow := True;
        end;
        Self.Color := clBtnFace;
        Panel1.Color := clBtnFace;
        for i := 0 to Self.ComponentCount - 1 do begin
          if Self.Components[i] is TShape then
            (Self.Components[i] as TShape).Visible := False;

          if Self.Components[i] is TLabel then begin
            {Tag = 1 - Цвет метки определяется стилем, Tag = 0 - Цвет не изменять}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TLabel).Font.Color := clWindowText;

            //(Self.Components[i] as TLabel).Color      := clBtnFace;
          end;

          if Self.Components[i] is TRadioButton then begin
            (Self.Components[i] as TRadioButton).Font.Color := clWindowText;
            {Tag = 0 - Цвет кнопки определяется стилем (голубой),
             Tag = 1 - Цвет кнопки равен цвету фона (Owner) (серый)}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TRadioButton).Color      := clBtnFace
            else
              (Self.Components[i] as TRadioButton).Color      := clBtnFace;
          end;

          if Self.Components[i] is TcxTextEdit then
            if IsPublishedProp(Self.Components[i] as TControl, 'Color') then
              {Tag = 0 - Цвет едита определяется стилем, Tag = 1 - Цвет не изменять}
              if Self.Components[i].Tag = 0 then
                SetOrdProp(Self.Components[i] as TControl, 'Color', $00FCF4ED);
          if Self.Components[i] is TcxCheckBox then
            (Self.Components[i] as TcxCheckBox).Style.Color := clBtnFace;

          if Self.Components[i] is TTabSet then begin
            {Tag = 0 - Цвет метки определяется стилем, Tag = 1 - Цвет не изменять}
            if Self.Components[i].Tag = 0 then
              (Self.Components[i] as TTabSet).BackgroundColor := clBtnFace;
          end;
        end;
      end;
    csWebStyle: {Web-стиль}
      begin
        with dxEditStyleController do begin
          Style.BorderColor := $00D69F30;
          Style.BorderStyle := ebsSingle;
          Style.ButtonStyle := btsSimple;
          Style.ButtonTransparency := ebtNone;
          Style.HotTrack := True;
          Style.Shadow := False;
        end;
        Self.Color := $00F0E8D9;
        Panel1.Color := $00F0E8D9;
        for i := 0 to Self.ComponentCount - 1 do begin
          if Self.Components[i] is TShape then
            (Self.Components[i] as TShape).Visible := False;

          if Self.Components[i] is TLabel then begin
            {Tag = 1 - Цвет метки определяется стилем, Tag = 0 - Цвет не изменять}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TLabel).Font.Color := clWindowText;

            //(Self.Components[i] as TLabel).Color      := $00F0E8D9;
          end;

          if Self.Components[i] is TRadioButton then begin
            (Self.Components[i] as TRadioButton).Font.Color := clWindowText;
            (Self.Components[i] as TRadioButton).Color      := $00F0E8D9;
            {Tag = 0 - Цвет кнопки определяется стилем (голубой),
             Tag = 1 - Цвет кнопки равен цвету фона (Owner) (серый)}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TRadioButton).Color      := $00F0E8D9
            else
              (Self.Components[i] as TRadioButton).Color      := $00F0E8D9;
          end;

          if Self.Components[i] is TcxTextEdit then
            if IsPublishedProp(Self.Components[i] as TControl, 'Color') then
              {Tag = 0 - Цвет едита определяется стилем, Tag = 1 - Цвет не изменять}
              if Self.Components[i].Tag = 0 then
                SetOrdProp(Self.Components[i] as TControl, 'Color', $00FDF9F4);

          if Self.Components[i] is TcxCheckBox then
            (Self.Components[i] as TcxCheckBox).Style.Color := $00F0E8D9;

          if Self.Components[i] is TTabSet then begin
            {Tag = 0 - Цвет метки определяется стилем, Tag = 1 - Цвет не изменять}
            if Self.Components[i].Tag = 0 then
              (Self.Components[i] as TTabSet).BackgroundColor := $00F0E8D9;
          end;
        end;
      end;
    csRealBlank:  {Бланк}
      begin
        with dxEditStyleController do begin
          Style.BorderColor := clWindowFrame;//$00E3BF75;
          Style.BorderStyle := ebsFlat;
          Style.ButtonStyle := btsDefault;
          Style.ButtonTransparency := ebtNone;
          Style.HotTrack := True;
          Style.Shadow := False;
        end;
        Self.Color := clWhite;
        Panel1.Color := clWhite;
        for i := 0 to Self.ComponentCount - 1 do begin
          if Self.Components[i] is TShape then
            (Self.Components[i] as TShape).Visible := True;

          if Self.Components[i] is TLabel then begin
            {Tag = 1 - Цвет метки определяется стилем, Tag = 0 - Цвет не изменять}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TLabel).Font.Color := $00725416;

            //(Self.Components[i] as TLabel).Color      := clWhite;
          end;

          {if Self.Components[i] is TRadioButton then begin
            (Self.Components[i] as TRadioButton).Font.Color := $00725416;
            {Tag = 1 - Цвет кнопки определяется стилем (голубой),
             Tag = 0 - Цвет кнопки равен цвету фона (Owner) (серый)}
          {  if Self.Components[i].Tag = 0 then
              (Self.Components[i] as TRadioButton).Color      := clWhite
            else
              (Self.Components[i] as TRadioButton).Color      := $00FCF4ED;
          end; }

          if Self.Components[i] is TcxTextEdit then
            if IsPublishedProp(Self.Components[i] as TControl, 'Color') then
              {Tag = 1 - Цвет едита определяется стилем, Tag = 0 - Цвет не изменять}
              if Self.Components[i].Tag = 1 then
                SetOrdProp(Self.Components[i] as TControl, 'Color', clWhite);
          {if Self.Components[i] is TcxCheckBox then
            (Self.Components[i] as TcxCheckBox).Style.Color := clWhite;}

          if Self.Components[i] is TTabSet then begin
            {Tag = 1 - Цвет метки определяется стилем, Tag = 0 - Цвет не изменять}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TTabSet).BackgroundColor := clWhite;
          end;
        end;
      end;
    csFlat:  {Плоский}
      begin
        with dxEditStyleController do begin
          Style.BorderColor := $00E2BC6D;
          Style.BorderStyle := ebsFlat;
          Style.ButtonStyle := btsDefault;
          Style.ButtonTransparency := ebtNone;
          Style.HotTrack := False;
          Style.Shadow := False;
        end;
        Self.Color := clBtnFace;
        Panel1.Color := clBtnFace;
        for i := 0 to Self.ComponentCount - 1 do begin
          if Self.Components[i] is TShape then
            (Self.Components[i] as TShape).Visible := False;

          if Self.Components[i] is TLabel then begin
            {Tag = 1 - Цвет метки определяется стилем, Tag = 0 - Цвет не изменять}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TLabel).Font.Color := clWindowText;

            //(Self.Components[i] as TLabel).Color      := clBtnFace;
          end;

          if Self.Components[i] is TRadioButton then begin
            (Self.Components[i] as TRadioButton).Font.Color := clWindowText;
            {Tag = 0 - Цвет кнопки определяется стилем (голубой),
             Tag = 1 - Цвет кнопки равен цвету фона (Owner) (серый)}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TRadioButton).Color      := clBtnFace
            else
              (Self.Components[i] as TRadioButton).Color      := clBtnFace;
          end;

          if Self.Components[i] is TcxTextEdit then
            if IsPublishedProp(Self.Components[i] as TControl, 'Color') then
              {Tag = 0 - Цвет едита определяется стилем, Tag = 1 - Цвет не изменять}
              if Self.Components[i].Tag = 0 then
                SetOrdProp(Self.Components[i] as TControl, 'Color', clWindow);
          if Self.Components[i] is TcxCheckBox then
            (Self.Components[i] as TcxCheckBox).Style.Color := clBtnFace;

          if Self.Components[i] is TTabSet then begin
            {Tag = 0 - Цвет метки определяется стилем, Tag = 1 - Цвет не изменять}
            if Self.Components[i].Tag = 0 then
              (Self.Components[i] as TTabSet).BackgroundColor := clBtnFace;
          end;
        end;
      end;
    csStandard:  {Стандартный}
      begin
        with dxEditStyleController do begin
          Style.BorderColor := $00E2BC6D;
          Style.BorderStyle := ebs3D;
          Style.ButtonStyle := btsDefault;
          Style.ButtonTransparency := ebtNone;
          Style.HotTrack := False;
          Style.Shadow := False;
        end;
        Self.Color := clBtnFace;
        Panel1.Color := clBtnFace;
        for i := 0 to Self.ComponentCount - 1 do begin
          if Self.Components[i] is TShape then
            (Self.Components[i] as TShape).Visible := False;

          if Self.Components[i] is TLabel then begin
            {Tag = 1 - Цвет метки определяется стилем, Tag = 0 - Цвет не изменять}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TLabel).Font.Color := clWindowText;

            //(Self.Components[i] as TLabel).Color      := clBtnFace;
          end;

          if Self.Components[i] is TRadioButton then begin
            (Self.Components[i] as TRadioButton).Font.Color := clWindowText;
            {Tag = 0 - Цвет кнопки определяется стилем (голубой),
             Tag = 1 - Цвет кнопки равен цвету фона (Owner) (серый)}
            if Self.Components[i].Tag = 1 then
              (Self.Components[i] as TRadioButton).Color      := clBtnFace
            else
              (Self.Components[i] as TRadioButton).Color      := clBtnFace;
          end;

          if Self.Components[i] is TcxTextEdit then
            if IsPublishedProp(Self.Components[i] as TControl, 'Color') then
              {Tag = 0 - Цвет едита определяется стилем, Tag = 1 - Цвет не изменять}
              if Self.Components[i].Tag = 0 then
                SetOrdProp(Self.Components[i] as TControl, 'Color', clWindow);
          if Self.Components[i] is TcxCheckBox then
            (Self.Components[i] as TcxCheckBox).Style.Color := clBtnFace;

          if Self.Components[i] is TTabSet then begin
            {Tag = 0 - Цвет метки определяется стилем, Tag = 1 - Цвет не изменять}
            if Self.Components[i].Tag = 0 then
              (Self.Components[i] as TTabSet).BackgroundColor := clBtnFace;
          end;
        end;
      end;
  end;

  BarManager := TdxBarManager(FindComponent('dxBarManagerDlg'));
  if Assigned(BarManager) then begin
    BarManager.Style := TdxBarManagerStyle(FToolbarStyle);

    with BarManager do
      for i := 0 to ItemCount - 1 do
        if Items[i] is TdxBarButton then
          case FtbButtonsStyle of
            bsText:      (Items[i] as TdxBarButton).PaintStyle := psCaption;
            bsGlyphText: (Items[i] as TdxBarButton).PaintStyle := psCaptionGlyph;
            bsGlyph:     (Items[i] as TdxBarButton).PaintStyle := dxBar.psStandard;
          end;
  end;

  for i := 0 to Self.ComponentCount - 1 do begin
    if Self.Components[i] is TcxPageControl then
      (Self.Components[i] as TcxPageControl).Style := TcxPCStyleID(FTabStyle);
  end;

  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TcxPopupEdit then begin
      (Components[i] as TcxPopupEdit).Style.PopupBorderStyle := FPopupFormBorderStyle;
      //(Components[i] as TcxPopupEdit).PopupFlatBorder := FPopupFlatBorder;
    end;
  end;

  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TcxGrid then begin
      (Components[i] as TcxGrid).Font.Name := FGridFontName;
      (Components[i] as TcxGrid).Font.Size := FGridFontSize;
      MainDM.stGridSelectedRow.Font.Name := FGridFontName;
      MainDM.stGridSelectedRow.Font.Size := FGridFontSize;
    end;
    if Components[i] is TcxGridDBTableView then begin
      HeaderStyle := TcxStyle.Create(nil);
      HeaderStyle.Font.Name := FGridFontName;
      HeaderStyle.Font.Size := FGridFontSize;
      (Components[i] as TcxGridDBTableView).Styles.Header := HeaderStyle;

      //закидываю грид в массив, для дальнейшего восстановления настроек
      SetLength(CxGridArr, High(CxGridArr) + 2);
      CxGridArr[High(CxGridArr)] := (Components[i] as TcxGridDBTableView);
    end;

    if Components[i] is TcxDBTreeList then begin
      (Components[i] as TcxDBTreeList).Font.Name := FGridFontName;
      (Components[i] as TcxDBTreeList).Font.Size := FGridFontSize;
      MainDM.stBandStyle.Font.Name := FGridFontName;
      MainDM.stBandStyle.Font.Size := FGridFontSize;
      MainDM.stColumnHeaderStyle.Font.Name := FGridFontName;
      MainDM.stColumnHeaderStyle.Font.Size := FGridFontSize;
    end;
  end;

  //восстанавливаю настройки гридов
  if High(CxGridArr) <> -1 then begin
    for i := 0 to High(CxGridArr) do begin
      str := Self.name + '-' + CxGridArr[i].name;                          ////
      CxGridArr[i].RestoreFromIniFile('Settings.ini', True, False, [], str);
    end;
  end;

end;

procedure TDlgForm.ApplicationEvents1Activate(Sender: TObject);
begin
  //SetFocus;
end;

end.
