unit frmMDIChild;

{$I ShopUchet.inc}

interface

uses Windows, Classes, Graphics, Forms, Controls, Comctrls, StdCtrls,
  ActnList, dxBar, Registry, cxPC, SysUtils, Dialogs, cxGrid,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxBarPainter, cxClasses, cxStyles, cxGridDBTableView,
  System.Actions, system.UITypes, dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TMDIChildForm = class(TForm)
    dxBarManagerChild: TdxBarManager;
    dxBarPopupMenuChild: TdxBarPopupMenu;
    alChild: TActionList;
    dxBarButtonEnableAutoSize: TdxBarButton;
    cxStyleRepository: TcxStyleRepository;
    stlHeader: TcxStyle;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    FAutoSizeEnabled: Boolean;
    FActionName : String;
    FToolbarStyle: TdxBarManagerStyle;
    FTabStyle: TcxPCStyleID;
    FMenuFontName: String;
    FMenuFontSize: Integer;
    FGridFontSize: Integer;
    FGridFontName: String;

    procedure GetCustomStyle; virtual;
    procedure SetCustomStyle; virtual;
  public
    property AutoSizeEnabled: Boolean read FAutoSizeEnabled write FAutoSizeEnabled;
    constructor Create(AOwner: TComponent; Caption : String = ''; ActionName : String = '');// override;
  end;

implementation

uses frmMain, dmMain, unCommonFunc, unInitApp;

{$R *.DFM}

constructor TMDIChildForm.Create(AOwner: TComponent; Caption : String; ActionName : String);
begin
  if ActionName <> '' then begin
    FActionName := ActionName;
    With TAction(MainForm.FindComponent(FActionName)) do
      Enabled := False;
  end else
    FActionName := '';

  inherited Create(AOwner);

  Left := 0;
  Top := 0;

{  FMenuNode := MainForm.MenuNode;
  if Assigned(FMenuNode) then
    if Assigned(FMenuNode.Data) then begin
      inc(PMenuItemRec(FMenuNode.Data)^.ActionFormCnt);
      PMenuItemRec(FMenuNode.Data)^.ActionForm := Self;
    end;}

  FAutoSizeEnabled := True;
  dxBarButtonEnableAutoSize.Down := True;

  {Добавляем в список открытых окон}
  MainForm.dxBarListWindows.Items.AddObject(Caption, Self);
  {Добавляем в панель открытых окон}
  if Caption = '' then
    MainForm.WindowsPanel.AddWindow(Self, Self.Handle, Self.Caption)
  else
    MainForm.WindowsPanel.AddWindow(Self, Self.Handle, Caption);

  Self.Height := SelfHeight-5;
  Self.Width := SelfWidth;
{  for I := 0 to dxBarManagerChild.Bars.Count - 1 do
  begin
    dxBarManagerChild.Bars[I].AllowCustomizing := True;
    dxBarManagerChild.Bars[I].AllowQuickCustomizing := True;
  end;}
end;

procedure TMDIChildForm.FormActivate(Sender: TObject);
begin
  {Для панели открытых окон}
  MainForm.WindowsPanel.ActivateItem(Self.Handle);
  alChild.State := asNormal;
end;

procedure TMDIChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  if FActionName <> '' then
    With TAction(MainForm.FindComponent(FActionName)) do
      Enabled := True;
end;

procedure TMDIChildForm.FormDeactivate(Sender: TObject);
begin
  alChild.State := asSuspended;
end;

procedure TMDIChildForm.FormDestroy(Sender: TObject);
begin
  {Удаляем из списка открытых окон}
  with MainForm.dxBarListWindows.Items do
    Delete(IndexOfObject(Self));
  {Удаляем из панели открытых окон}
  MainForm.WindowsPanel.DeleteWindow(Self.Handle);
end;

procedure TMDIChildForm.FormShow(Sender: TObject);
begin
  //dxBarButtonEnableAutoSize.Caption := 'Автоподгонка окна';
  //dxBarButtonEnableAutoSize.Hint    := 'Автоподгонка окна';
  GetCustomStyle;
  SetCustomStyle;
end;

procedure TMDIChildForm.GetCustomStyle;
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
            if ValueExists('TabStyle') then
              FTabStyle := TcxPCStyleID(ReadInteger('TabStyle'))
            else begin
              FTabStyle := 4{dxtsFlat};
              WriteInteger('TabStyle', Integer(FTabStyle));
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

            if ValueExists('MenuFontName') then
              FMenuFontName := ReadString('MenuFontName')
            else begin
              FMenuFontName := 'Tahoma';
              WriteString('MenuFontName', FMenuFontName);
            end;
            dxBarManagerChild.Bars[0].Font.Name := FMenuFontName;
            {----------------------------}
            if ValueExists('MenuFontSize') then
              FMenuFontSize := ReadInteger('MenuFontSize')
            else begin
              FMenuFontSize := 9;
              WriteInteger('MenuFontSize', FMenuFontSize);
            end;
            dxBarManagerChild.Bars[0].Font.Size := FMenuFontSize;
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
      MessageDlg(E.Message + #13#10'(occured in TMDIChildForm.GetCustomStyle)', mtInformation, [mbOk], 0);
  end;
end;

procedure TMDIChildForm.SetCustomStyle;
var
  i: Integer;
  str : string;
  CxGridArr : array of TcxGridDBTableView;
begin
  dxBarManagerChild.Style := TdxBarManagerStyle(FToolbarStyle);

  for i := 0 to Self.ComponentCount - 1 do begin
    if Self.Components[i] is TcxPageControl then
      (Self.Components[i] as TcxPageControl).Style := TcxPCStyleID(FTabStyle);
  end;

  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TcxGrid then begin
      (Components[i] as TcxGrid).Font.Name := FGridFontName;
      (Components[i] as TcxGrid).Font.Size := FGridFontSize;
      MainDM.stGridSelectedRow.Font.Name := FGridFontName;
      MainDM.stGridSelectedRow.Font.Size := FGridFontSize;
    end;
    if Components[i] is TcxGridDBTableView then begin
      stlHeader.Font.Name := FGridFontName;
      stlHeader.Font.Size := FGridFontSize;
      (Components[i] as TcxGridDBTableView).Styles.Header := stlHeader;

      //закидываю грид в массив, для дальнейшего восстановления настроек
      SetLength(CxGridArr, High(CxGridArr) + 2);
      CxGridArr[High(CxGridArr)] := (Components[i] as TcxGridDBTableView);
    end;
  end;

  //восстанавливаю настройки гридов
  if High(CxGridArr) <> -1 then begin
    for i := 0 to High(CxGridArr) do begin
      str := Self.name + '-' + CxGridArr[i].name;                          ////
      CxGridArr[i].RestoreFromIniFile('Settings_grid.ini', False, False, [], str);
    end;
  end;
end;

end.

