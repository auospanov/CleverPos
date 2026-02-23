unit frmGNonCashPayType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  AppEvnts, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, System.UITypes,
  System.Actions, cxClasses, cxButtons, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  cxEditRepositoryItems, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  dxmdaset;

type
  TGNonCashPayTypeForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    edName: TcxTextEdit;
    lblTIS: TLabel;
    shpTIS: TShape;
    shpTIS2: TShape;
    cbbTIS: TcxLookupComboBox;
    dsTIS: TDataSource;
    Shape1: TShape;
    Shape3: TShape;
    Label1: TLabel;
    dsTerminal: TDataSource;
    cbbTerminal: TcxComboBox;
    procedure btHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  GNonCashPayTypeForm: TGNonCashPayTypeForm;

implementation

uses
  dmMain, unCommonFunc;


{$R *.dfm}

function TGNonCashPayTypeForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edName.Text) = EmptyStr then
  begin
    ErrControl := edName;
    MessageDlg('Наименование не введено!', mtInformation, [mbOK], 0);
    Exit;
  end;

  if cbbTIS.Visible then
  begin
    if Trim(cbbTIS.Text) = EmptyStr then
    begin
      cbbTIS.EditValue := 0;
    end;
  end;

  if cbbTerminal.Visible then begin
    if Trim(cbbTerminal.Text) = EmptyStr then
    begin
      ErrControl := cbbTerminal;
      MessageDlg('Терминал не выбран!', mtInformation, [mbOK], 0);
      Exit;
    end;
  end;

  Result := True;
end;

procedure TGNonCashPayTypeForm.FormCreate(Sender: TObject);
begin
  KeyField := 'g_unit_';

  inherited;
end;

procedure TGNonCashPayTypeForm.FormShow(Sender: TObject);
var I, x : integer;
begin

  inherited;

  Label1.Visible := UsePosTerminal = 1;
  Shape1.Visible := UsePosTerminal = 1;
  Shape3.Visible := UsePosTerminal = 1;
  cbbTerminal.Visible := UsePosTerminal = 1;
  cbbTerminal.Enabled := cbbTerminal.Visible;

  if UsePosTerminal = 1 then begin
    cbbTerminal.Properties.Items.Clear;
    for i := 0 to High(PosTerminalArr) do begin
      cbbTerminal.Properties.Items.Add(PosTerminalArr[i].Name);
    end;

    cbbTerminal.ItemIndex := 0;
  end;

end;

procedure TGNonCashPayTypeForm.GetData;
var i : integer;
begin
  inherited;

  lblTIS.Visible := MainDM.dxMemDataTIS.Active;
  cbbTIS.Visible := MainDM.dxMemDataTIS.Active;
  cbbTIS.Enabled := cbbTIS.Visible;
  shpTIS.Visible := MainDM.dxMemDataTIS.Active;
  shpTIS2.Visible := MainDM.dxMemDataTIS.Active;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do
    begin
      edName.Text := ParamByName('Name_').AsString;

      if MainDM.dxMemDataTIS.Active then
        cbbTIS.EditValue := ParamByName('IS_TIS_TYPE_').AsInteger;

      if cbbTerminal.Visible then begin
        if spGetData.ParamByName('POS_TERMINAL_TYPE_').AsInteger <> 0 then begin
          for i := Low(PosTerminalArr) to High(PosTerminalArr) do
            if PosTerminalArr[i].Model = spGetData.ParamByName('POS_TERMINAL_TYPE_').AsInteger then
              Break;

          cbbTerminal.ItemIndex := i;
        end else
          cbbTerminal.ItemIndex := 0;
      end;
    end;
  end;
end;

procedure TGNonCashPayTypeForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;
  with SP do
  begin
    ParamByName('Name_').AsString := edName.Text;
    if UsePosTerminal = 1 then
      ParamByName('POS_TERMINAL_TYPE_').AsInteger := PosTerminalArr[cbbTerminal.ItemIndex].Model
    else
      ParamByName('POS_TERMINAL_TYPE_').AsInteger := 0;

    if MainDM.dxMemDataTIS.Active then
      ParamByName('IS_TIS_TYPE_').AsInteger := cbbTIS.EditValue
    else
    begin
      if cbbTIS.EditValue > 0 then
        ParamByName('IS_TIS_TYPE_').AsInteger := cbbTIS.EditValue
      else
        ParamByName('IS_TIS_TYPE_').AsInteger := 0;
    end;
  end;
end;

procedure TGNonCashPayTypeForm.btHelpClick(Sender: TObject);
begin
  Helpc := 4;
  inherited;
end;

end.
