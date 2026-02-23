unit frmDBTreeEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DB,
  frmDBEdit, registry, cxPC,
  ActnList, FIB, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase, pFIBDatabase,
  cxContainer, cxEdit, AppEvnts, System.UITypes, System.Actions, cxClasses,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
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
  dxSkinXmas2008Blue, cxButtons, cxEditRepositoryItems;

type
  TDBTreeEditForm = class(TDBEditForm)
    spGetParentData: TpFIBStoredProc;
  private
    FParentKeyField   : String;
    FParentKeyFieldIsStr: Boolean;
    FParentRecID      : Int64;
    FParentRecIDStr   : String;
  protected
    procedure GetData; override;
    function InsData: Boolean; override;
//    function UpdData: Boolean; override;
  public
    property ParentKeyField: String read FParentKeyField write FParentKeyField;
    property ParentKeyFieldIsStr: Boolean read FParentKeyFieldIsStr write FParentKeyFieldIsStr default False;
    property ParentRecID: Int64 read FParentRecID write FParentRecID default 0;
    property ParentRecIDStr: String read FParentRecIDStr write FParentRecIDStr;
  end;

implementation

uses dmMain, unErrorHandlers, unInitApp, Variants;

{$R *.DFM}

procedure TDBTreeEditForm.GetData;
{Выполняет spGetData}
begin
  {Полностью переопределяем метод}
//  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike, omInsertChild] then begin
    try
      if not spGetData.Transaction.InTransaction then
        spGetData.Transaction.StartTransaction;

      if KeyFieldIsStr then
        spGetData.ParamByName(KeyField).AsString := RecIDStr
      else
        spGetData.ParamByName(KeyField).AsInt64 := RecID;

      Screen.Cursor := crSQLWait;
      try
        ExecSP(spGetData);
      finally
        Screen.Cursor := crDefault;
      end;

      if spGetData.Transaction.InTransaction then
        spGetData.Transaction.CommitRetaining;
    except
      on E: EFIBError do begin
        if spGetData.Transaction.InTransaction then
          spGetData.Transaction.RollbackRetaining;
        DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBTreeEditForm.GetData (1))');
      end;
      on E: Exception do begin
        if spGetData.Transaction.InTransaction then
          spGetData.Transaction.RollbackRetaining;
        MessageDlg(E.Message + #13#10'(occured in TDBTreeEditForm.GetData (1))', mtError, [mbOk], 0);
      end;
    end;
  end;
end;

function TDBTreeEditForm.InsData: Boolean;
begin
  {Полностью переопределяем метод}
  Result := False;
  try
    if FParentKeyFieldIsStr then
      if FParentRecIdStr <> '' then
        spIns.ParamByName(FParentKeyField).AsString := FParentRecIdStr
      else
        spIns.ParamByName(FParentKeyField).Value := Null
    else
      if FParentRecId > 0 then
        spIns.ParamByName(FParentKeyField).AsInt64 := FParentRecId
      else
        spIns.ParamByName(FParentKeyField).Value := Null;
{
    if FParentKeyFieldIsStr then
      spIns.ParamByName(FParentKeyField).AsString := FParentRecIdStr
    else
      spIns.ParamByName(FParentKeyField).AsInteger := FParentRecId;
}

    if CallSP(spIns) then
    begin
      if KeyFieldIsStr then
        RecIdStr := spIns.ParamByName(KeyField).AsString
      else
        RecId := spIns.ParamByName(KeyField).AsInt64;
      Result := True;
    end
    else
      Exit;
  except
    on E: EFIBError do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.Rollback;
      DBErrorHandler(E.SQLCode, E.Message + #13#10'(occured in TDBTreeEditForm.InsData)');
    end;
    on E: Exception do begin
      if spIns.Transaction.InTransaction then
        spIns.Transaction.Rollback;
      MessageDlg(E.Message + #13#10'(occured in TDBTreeEditForm.InsData)', mtError, [mbOk], 0);
    end;
  end;
end;

end.
