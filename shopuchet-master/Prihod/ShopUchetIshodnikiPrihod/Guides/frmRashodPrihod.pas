unit frmRashodPrihod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, AppEvnts, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit, system.UITypes,
  System.Actions, cxClasses, cxButtons;

type
  TRashodPrihodForm = class(TDBEditForm)
    Label2: TLabel;
    Shape2: TShape;
    Shape4: TShape;
    Label13: TLabel;
    Shape25: TShape;
    Shape26: TShape;
    cbAction: TComboBox;
    edName: TcxTextEdit;
    procedure cbActionChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    FPrihodRashod : Integer;
  public
    property PrihodRashod : Integer read FPrihodRashod write FPrihodRashod;
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  RashodPrihodForm: TRashodPrihodForm;

implementation

{$R *.dfm}

function TRashodPrihodForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edName.Text) = EmptyStr then begin
    ErrControl := edName;
    MessageDlg('Наименование не введено', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TRashodPrihodForm.GetData;
begin
  cbAction.ItemIndex := FPrihodRashod;    //если идет Insert, то подставляется значение статьи из главной формы

  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      cbAction.ItemIndex := ParamByName('action_').AsInteger;
      edName.Text    := ParamByName('NAME_').AsString;
    end;
  end;
end;

procedure TRashodPrihodForm.SetParams(SP: TpFIBStoredProc);
begin
  inherited;

  with SP do begin
    ParamByName('NAME_').AsString := edName.Text;
    ParamByName('action_').AsInteger := cbAction.ItemIndex;
  end;
end;

procedure TRashodPrihodForm.cbActionChange(Sender: TObject);
begin
  inherited;
  edName.ModifiedAfterEnter := TRUE;  //ИЗМЕНЕНИЕ ЛУКАПА НЕ ЦЕПЛЯЕТСЯ В ДАЛЬНЕЙШЕМ, БУДТО НИЧЕГО НЕ МЕНЯЛИ
end;

procedure TRashodPrihodForm.btHelpClick(Sender: TObject);
begin
  Helpc := 8;
  inherited;
end;

end.
