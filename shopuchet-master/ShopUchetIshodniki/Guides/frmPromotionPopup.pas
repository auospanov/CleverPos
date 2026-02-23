unit frmPromotionPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPopupList, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase, ActnList,
  Menus, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, StdCtrls, Buttons, ExtCtrls,
  cxNavigator, System.Actions, system.UITypes, cxButtons, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint;

type
  TPromotionPopupForm = class(TPopupListForm)
    tvMainG_PROMOTION: TcxGridDBColumn;
    tvMainNAME: TcxGridDBColumn;
    tvMainIS_ACTIVE: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
  protected
    procedure ReadList; override;
    procedure InsData; override;
    procedure UpdData; override;
    procedure DelData; override;
  end;

var
  PromotionPopupForm: TPromotionPopupForm;

implementation

uses
  frmPromotion;

{$R *.dfm}

procedure TPromotionPopupForm.DelData;
begin
  if MessageDlg(Format('Удалить "%s" ?',
    [spRead.FieldByName('Name').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  inherited;
end;

procedure TPromotionPopupForm.FormShow(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'id';
  KeyFieldClass := 'g_promotion_';
  aRefresh.Execute;
end;

procedure TPromotionPopupForm.InsData;
begin
  ClassForm := TPromotionForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TPromotionPopupForm.ReadList;
begin
  inherited;
  aUpd.Enabled := spRead.RecordCount > 0;
  aDel.Enabled := spRead.RecordCount > 0;
end;

procedure TPromotionPopupForm.UpdData;
begin
  ClassForm := TPromotionForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

end.
