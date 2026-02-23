unit frmSmsRecips;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBDlg, ActnList, cxContainer, cxEdit, AppEvnts, ExtCtrls,
  StdCtrls, Buttons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxGDIPlusClasses, cxSplitter, frmTreeFrame, frmGridFrame,
  cxTl, cxRadioGroup, unCommonFunc, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  System.Actions, cxClasses, Vcl.Menus, cxButtons, cxEditRepositoryItems,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TSmsRecipsForm = class(TDBDlgForm)
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    cbClientAll: TCheckBox;
    edSearch: TEdit;
    frmClientFrame: TGridFrame;
    Panel5: TPanel;
    Panel7: TPanel;
    cbCatAll: TCheckBox;
    ClientCatFrame: TTreeFrame;
    splMenu: TcxSplitter;
    Image1: TImage;
    pn1: TPanel;
    cbChoice: TcxComboBox;
    tmrClient: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbCatAllClick(Sender: TObject);
    procedure ClientCatFrametlCommonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbClientAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbChoiceClick(Sender: TObject);
    procedure cb1PropertiesChange(Sender: TObject);
    procedure tmrClientTimer(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
  private
    FClientCatArr : String;
    FClientArr : String;
    function FillCatArr(CatFrame: TTreeFrame) : STRING;
    procedure DisableControls;
  public
    property ClientCatArr : string read FClientCatArr write FClientCatArr;
    property ClientArr : string read FClientArr write FClientArr;
  end;

var
  SmsRecipsForm: TSmsRecipsForm;

implementation

{$R *.dfm}

procedure TSmsRecipsForm.cb1PropertiesChange(Sender: TObject);
begin
  DisableControls;
end;

procedure TSmsRecipsForm.cbCatAllClick(Sender: TObject);
begin
  if cbCatAll.Checked then begin
    ClientCatFrame.spReadFrame.Close;
    ClientCatFrame.tlCommon.Clear;
    ClientCatFrame.tlCommon.Enabled := False;

    cbClientAll.Checked := True;
    cbClientAll.Enabled := False;
  end else begin
    OpenSp(ClientCatFrame.spReadFrame, False);
    ClientCatFrame.tlCommon.Enabled := True;
    ClientCatFrame.tlCommon.FullExpand;
    cbClientAll.Enabled := True;
  end;
end;

procedure TSmsRecipsForm.cbClientAllClick(Sender: TObject);
begin
  if cbClientAll.Checked then begin
    frmClientFrame.spReadFrame.Close;
    frmClientFrame.grMain.Enabled := False;
  end else begin
    Screen.Cursor := crHourGlass;
    frmClientFrame.spReadFrame.ParamByName('g_category_').AsString := FillCatArr(ClientCatFrame);
    OpenSp(frmClientFrame.spReadFrame, False);
    frmClientFrame.grMain.Enabled := True;
    Screen.Cursor := crDefault;
  end;
  edSearch.Enabled := not cbClientAll.Checked;
end;

procedure TSmsRecipsForm.ClientCatFrametlCommonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ClientCatFrame.tlCommonMouseDown(Sender, Button, Shift, X, Y);
  if not cbClientAll.Checked then begin
    Screen.Cursor := crHourGlass;
    frmClientFrame.spReadFrame.ParamByName('g_category_').AsString := FillCatArr(ClientCatFrame);
    OpenSp(frmClientFrame.spReadFrame, False);
    Screen.Cursor := crDefault;
  end;
end;

procedure TSmsRecipsForm.DisableControls;
begin
  if cbChoice.ItemIndex <> 2 then begin
    cbCatAll.Checked := True;
    cbCatAll.Enabled := False;
    edSearch.Enabled := False;
  end else begin
    cbCatAll.Enabled := True;
    cbCatAll.Checked := False;
    cbClientAll.Checked := False;
  end;
end;

procedure TSmsRecipsForm.edSearchChange(Sender: TObject);
begin
  tmrClient.Enabled := False;
  // здесь буду перезапускать таймер, а на его событие - уже включать фильтр
  if edSearch.Text <> '' then
    tmrClient.Enabled := True
  else BEGIN
    with frmClientFrame.spReadFrame do begin
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Open;
    end;
  END;
end;

function TSmsRecipsForm.FillCatArr(CatFrame: TTreeFrame): STRING;
var ANode, ANodeOld: TcxTreeListNode;
begin
  ANodeOld := CatFrame.tlCommon.FocusedNode;
  //«јѕќЋЌяё ћј——»¬  ј“≈√ќ–»…
  Result := '~';
  CatFrame.tlCommon.GotoBOF;
  CatFrame.tlCommon.TopNode.Focused := True;
  ANode := CatFrame.tlCommon.FocusedNode;
  while ANode <> nil do begin
    if ANode.Data <> nil then
      if PBoolean(ANode.Data)^ then
        Result  := Result + IntToStr(ANode.Values[2]) + '~';

    ANode := ANode.GetNext;
    if ANode = nil then BEGIN
      Break;
    END;
  end;

  ANodeOld.Focused := True;
end;

procedure TSmsRecipsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmClientFrame.FreeList;
  SaveSettingsIni('SendSmsList', 'SmsRecipsChoice', cbChoice.ItemIndex, '');
end;

procedure TSmsRecipsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ModalResult = mrOK then begin
    if not cbCatAll.Checked then begin
      FClientCatArr := FillCatArr(ClientCatFrame);
      if FClientCatArr = '~' then
        FClientCatArr := '';
    end;

    if not cbClientAll.Checked then begin
      FClientArr := '~';
      FClientArr := FClientArr + frmClientFrame.FillArr;

      if FClientArr = '~' then
        FClientArr := '';
    END;
  end;
end;

procedure TSmsRecipsForm.FormCreate(Sender: TObject);
begin
  inherited;
  frmClientFrame.CreateList;
end;

procedure TSmsRecipsForm.FormShow(Sender: TObject);
begin
  inherited;
  cbChoice.ItemIndex := ReadIntSettingsIni('SendSmsList', 'SmsRecipsChoice', 0);
  DisableControls;
end;

procedure TSmsRecipsForm.rbChoiceClick(Sender: TObject);
begin
  DisableControls;
end;

procedure TSmsRecipsForm.tmrClientTimer(Sender: TObject);
var s : string;
begin
  tmrClient.Enabled := False;
  if (edSearch.text<>'') then begin
    with frmClientFrame.spReadFrame do begin
      s := '(NAME CONTAINING ''' + edSearch.text + ''') OR (PHONE CONTAINING ''' + edSearch.text + ''')';
      if Active then Close;
      CancelConditions;
      Conditions.Clear;
      Conditions.AddCondition('by_customer', S, True);
      ApplyConditions;
      Open;
    end;
    if Assigned(frmClientFrame.tvMain.Controller.FocusedRow) then
      frmClientFrame.tvMain.Controller.FocusedRow.Selected := True;
  END;
end;

end.
