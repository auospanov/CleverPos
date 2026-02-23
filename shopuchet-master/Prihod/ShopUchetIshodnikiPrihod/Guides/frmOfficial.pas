unit frmOfficial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBEdit, DB, ExtCtrls, StdCtrls, Menus, ActnList,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, FIBQuery, pFIBQuery,
  pFIBStoredProc, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet,
  AppEvnts, cxPC,
  cxSplitter, ComCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  cxRadioGroup, cxInplaceContainer, cxDBTL, cxTLData, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxCheckBox, System.Types, System.UITypes,
  dxBarBuiltInMenu, dxCore, cxDateUtils, System.Actions, cxClasses, cxButtons;

type
  TOfficialForm = class(TDBEditForm)
    dsAppoint: TDataSource;
    spAppoint: TpFIBDataSet;
    pcMain: TcxPageControl;
    tsCommon: TcxTabSheet;
    tsRights: TcxTabSheet;
    Shape8: TShape;
    Shape7: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape26: TShape;
    Shape25: TShape;
    Shape24: TShape;
    Shape23: TShape;
    Shape22: TShape;
    Shape21: TShape;
    Shape20: TShape;
    Shape2: TShape;
    Shape19: TShape;
    Shape18: TShape;
    Shape17: TShape;
    Shape16: TShape;
    Shape15: TShape;
    Shape14: TShape;
    Shape13: TShape;
    Shape12: TShape;
    Shape11: TShape;
    Shape1: TShape;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    edId_date: TcxDateEdit;
    edDT: TcxDateEdit;
    SpeedButton1: TSpeedButton;
    spReadRights: TpFIBDataSet;
    dsReadRights: TDataSource;
    Panel2: TPanel;
    btAll: TButton;
    btNone: TButton;
    lbSklad: TLabel;
    shapSklad: TShape;
    shapeSklad1: TShape;
    spSklad: TpFIBDataSet;
    dsSklad: TDataSource;
    edFT: TcxTextEdit;
    edFM: TcxTextEdit;
    edNM: TcxTextEdit;
    edFIO: TcxTextEdit;
    edIDN: TcxTextEdit;
    edGIdKind: TcxTextEdit;
    edNum: TcxTextEdit;
    leAppointment: TcxLookupComboBox;
    cbIssuer: TcxComboBox;
    edPassword: TcxTextEdit;
    leSklad: TcxLookupComboBox;
    ceIsRukovod: TcxRadioButton;
    ceGlavBuh: TcxRadioButton;
    cbIspolnitel: TcxRadioButton;
    tlRights: TcxDBTreeList;
    clmnCheckCol: TcxDBTreeListColumn;
    clmnDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    clmnDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edPasswordChange(Sender: TObject);
    procedure edPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure btAllClick(Sender: TObject);
    procedure btNoneClick(Sender: TObject);
    procedure edFIOEnter(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure cbSkladChange(Sender: TObject);
    procedure tlRightsCustomDrawDataCell(Sender: TcxCustomTreeList;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
      var ADone: Boolean);
    procedure tlRightsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ceIsRukovodClick(Sender: TObject);
    procedure ceGlavBuhClick(Sender: TObject);
    procedure cbIspolnitelClick(Sender: TObject);
    procedure edFMKeyPress(Sender: TObject; var Key: Char);
    procedure pcMainChange(Sender: TObject);
  private
    { Private declarations }
    FPassword : String;
  public
    { Public declarations }
  protected
    procedure GetData; override;
    function  CheckParams(var ErrControl: TWinControl): Boolean; override;
    procedure SetParams(SP: TpFIBStoredProc); override;
  end;

var
  OfficialForm: TOfficialForm;
  P : Pboolean;

implementation

uses frmAppointment, unCommonFunc;

{$R *.dfm}

function TOfficialForm.CheckParams(var ErrControl: TWinControl): Boolean;
begin
  Result := inherited CheckParams(ErrControl);

  if Trim(edFIO.Text) = EmptyStr then begin
    pcMain.ActivePage := tsCommon;
    ErrControl := edFIO;
    MessageDlg('ФИО для документов не введено!', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(leAppointment.Text) = EmptyStr then begin
    pcMain.ActivePage := tsCommon;
    ErrControl := leAppointment;
    MessageDlg('Должность не введена', mtInformation, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TOfficialForm.GetData;
var i : Integer;
  Arr : String;
begin
  inherited;
  if OpenMode in [omView, omUpdate, omInsertLike] then begin
    with spGetData do begin
      edFM.Text := ParamByName('FM_').AsString;
      edNM.Text := ParamByName('NM_').AsString;
      edFT.Text := ParamByName('FT_').AsString;
      edFIO.Text := ParamByName('FIO_DOC_').AsString;
      edIDN.Text := ParamByName('IDN_').AsString;
      if DateToStr(ParamByName('DT_').AsDate) <> '30.12.1899' then
        edDT.Date  := ParamByName('DT_').AsDate;
      edGIdKind.Text := ParamByName('G_ID_KIND_').AsString;
      edNum.Text := ParamByName('ID_NUM_').AsString;
      if DateToStr(ParamByName('ID_DATE_').AsDate) <> '30.12.1899' then
        edId_date.Date := ParamByName('ID_DATE_').AsDate;
      cbIssuer.Text := ParamByName('ID_ISSUER_').AsString;
      leAppointment.EditValue := ParamByName('G_APPOINTMENT_').AsInteger;
      ceIsRukovod.Checked := ParamByName('IS_RUKOVODITEL_').AsInteger = 1;
      ceGlavBuh.Checked := ParamByName('IS_GLAVBUH_').AsInteger = 1;
      cbIspolnitel.Checked := ParamByName('IS_ISPOLNITEL_').AsInteger = 1;
      edPassword.Text      := ParamByName('PASSWORD_').AsSTRING;
      leSklad.EditValue := ParamByName('g_tochka_').AsInteger;

      //ЗАПОЛНЯЮ ПРАВА ТЕКУЩЕГО ПОЛЬЗОВАТЕЛЯ
      Arr := copy(ParamByName('Rights_arr_').AsSTRING, 2, MaxInt);
      while Length(Arr) > 1 do begin
        i := pos('-', Arr);
        spReadRights.Locate('rights_item', StrToInt(Copy(Arr, 1, i-1)), []);
        SetCheckRoutine(tlRights.FocusedNode, tlRights.FocusedNode, True);
        if tlRights.FocusedNode.Parent <> nil then begin
          if tlRights.FocusedNode.Parent.Data = nil then begin
            New(P);
            P^ := True;
            tlRights.FocusedNode.Parent.Data := P;
          end
          else begin
            PBoolean(tlRights.FocusedNode.Parent.Data)^ := True;
            tlRights.Repaint;
          end;
        end;
        Arr := copy(Arr, i+1, MaxInt);
      end;
      tlRights.FullCollapse;  //иначе почему-то весь раскрывается
      tlRights.TopNode.Focused := True;
    end;
  end;
end;

procedure TOfficialForm.pcMainChange(Sender: TObject);
begin
  inherited;
  if pcMain.ActivePage = tsRights then
    tlRights.FullExpand;
end;

procedure TOfficialForm.SetParams(SP: TpFIBStoredProc);
var ANode: TcxTreeListNode;
begin
  inherited;

  with SP do begin
    ParamByName('FM_').AsString := edFM.Text;
    ParamByName('NM_').AsString := edNM.Text;
    ParamByName('FT_').AsString := edFT.Text;
    ParamByName('FIO_DOC_').AsString := edFIO.Text;
    ParamByName('IDN_').AsString := edIDN.Text;
    if (edDT.Text <> '  .  .    ') and (edDT.Text <> '00.00.0000') then
      ParamByName('DT_').AsDate := edDT.Date;
    ParamByName('G_ID_KIND_').AsString := edGIdKind.Text;
    ParamByName('ID_NUM_').AsString := edNum.Text;
    if (edId_date.Text <> '  .  .    ') and (edId_date.Text <> '00.00.0000') then
      ParamByName('ID_DATE_').AsDate := edId_date.Date;
    ParamByName('ID_ISSUER_').AsString := cbIssuer.Text;
    ParamByName('G_APPOINTMENT_').AsInteger := leAppointment.EditValue;
    ParamByName('IS_RUKOVODITEL_').AsInteger := Integer(ceIsRukovod.Checked);
    ParamByName('IS_GLAVBUH_').AsInteger := Integer(ceGlavBuh.Checked);
    ParamByName('IS_ISPOLNITEL_').AsInteger := Integer(cbIspolnitel.Checked);
    ParamByName('PASSWORD_').AsSTRING := TRIM(edPassword.Text);
    if leSklad.EditValue > 0 then
      ParamByName('g_tochka_').AsInteger := leSklad.EditValue;

    //ЗАПОЛНЯЮ МАССИВ ПРАВ ДЛЯ ДАННОГО ПОЛЬЗОВАТЕЛЯ
    ParamByName('Rights_Arr_').AsSTRING := '-';
    tlRights.FullExpand;
    tlRights.TopNode.Focused := True;
    ANode := tlRights.FocusedNode;
    while ANode <> nil do begin
      if not ANode.HasChildren then begin
        if ANode.Data <> nil then
          if PBoolean(ANode.Data)^ then
            ParamByName('Rights_Arr_').AsSTRING := ParamByName('Rights_Arr_').AsSTRING + IntToStr(ANode.Values[2]) + '-';
      end;

      ANode := ANode.GetNext;
      if ANode = nil then BEGIN
        Break;
      END;
    end;
  end;
end;

procedure TOfficialForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenSP(spAppoint, False);
  OpenSP(spReadRights, False);

  if High(SkladArr) > 0 then begin
    shapSklad.Visible := True;
    shapeSklad1.Visible := True;
    lbSklad.Visible := True;
    leSklad.Visible := True;
    OpenSP(spSklad, True);
    spSklad.First;
  end else begin
    shapSklad.Visible := False;
    shapeSklad1.Visible := False;
  end;

  if OpenMode = omInsert then   //если заводится новый сотрудник, то по умолчанию даю ему все права
    btAll.Click;

  edFm.SetFocus;
end;

procedure TOfficialForm.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  AppointmentForm := TAppointmentForm.Create(Self);
  try
    AppointmentForm.OpenMode := omInsert;
    if AppointmentForm.ShowModal = mrOk then begin
      OpenSp(spAppoint, False);
      leAppointment.EditValue := AppointmentForm.RecID;
    end;
  finally
    FreeAndNil(AppointmentForm);
  end;
end;

procedure TOfficialForm.ceIsRukovodClick(Sender: TObject);
begin
  inherited;
  edFm.ModifiedAfterEnter := True;
end;

procedure TOfficialForm.ceGlavBuhClick(Sender: TObject);
begin
  inherited;
  edFm.ModifiedAfterEnter := True;
end;

procedure TOfficialForm.edPasswordChange(Sender: TObject);
begin
  inherited;
  FPassword := edPassword.Text;
end;

procedure TOfficialForm.edPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If not (Key in ['A'..'Z', 'a'..'z', '0'..'9', '-', '/', '=', '(', ')', '!', '+', #8]) Then
    Key := #0;
end;

procedure TOfficialForm.tlRightsCustomDrawDataCell(
  Sender: TcxCustomTreeList; ACanvas: TcxCanvas;
  AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
begin
  with TcxDBTreeListColumn(AViewInfo.Column) do
    if (DataBinding.FieldName = '') and (Properties is TcxCheckBoxProperties) then
      with AViewInfo.Node do
        TcxCustomCheckBoxViewInfo(AViewInfo.EditViewInfo).State :=
          TcxCheckBoxState(not((Data = nil) or ((Data <> nil) and (PBoolean(Data)^ = False))))
end;

procedure TOfficialForm.tlRightsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ANode: TcxTreeListNode;
  AColumn: TcxTreeListColumn;
begin
  edFM.ModifiedAfterEnter := True;
  with TcxTreeList(Sender) do
  begin
    HitTest.ReCalculate(Point(X, Y));
    if HitTest.HitAtNode and (HitTest.HitColumn <> nil) then
    begin
      ANode := HitTest.HitNode;
      AColumn := HitTest.HitColumn;
      if AColumn.Properties is TcxCheckBoxProperties then
        SetChecks(TcxTreeList(Sender), ANode, AColumn);
    end;
  end;
end;

procedure TOfficialForm.btAllClick(Sender: TObject);
var ANode: TcxTreeListNode;
begin
  edFM.ModifiedAfterEnter := True;  //иначе не вызовается Update
  spReadRights.First;
  ANode := tlRights.FocusedNode;
  while ANode <> nil do begin
    if ANode.Data = nil then
    begin
      New(P);
      P^ := True;
      ANode.Data := P;
      PBoolean(ANode.Data)^ := True;
    end
    else
      PBoolean(ANode.Data)^ := True;

    if ANode.HasChildren then ANode.Expand(False);
    ANode := ANode.GetNext;
    if ANode = nil then Break;
  end;
end;

procedure TOfficialForm.btNoneClick(Sender: TObject);
var ANode: TcxTreeListNode;
begin
  edFM.ModifiedAfterEnter := True;  //иначе не вызовается Update
  spReadRights.First;
  ANode := tlRights.FocusedNode;
  while ANode <> nil do begin
    if ANode.Data = nil then
    begin
      New(P);
      P^ := True;
      ANode.Data := P;
      PBoolean(ANode.Data)^ := False;
    end
    else
      PBoolean(ANode.Data)^ := False;
    if ANode.HasChildren then ANode.Expand(False);
    ANode := ANode.GetNext;
    if ANode = nil then Break;
  end;
  tlRights.FullCollapse;  //иначе почему-то весь раскрывается
end;

procedure TOfficialForm.edFIOEnter(Sender: TObject);
var n : integer;
    S : String;
begin
  inherited;
  //автоматом приведу Темеков Айдын Айдарович к виду Темеков А.А.
    S := Trim(edFM.Text);
    if Length(Trim(edNM.Text)) > 0 then
      S := S + ' ' + Trim(edNM.Text);

    if Length(Trim(edFT.Text)) > 0 then
      S := S + ' ' + Trim(edFT.Text);

    n := pos(' ', Trim(S));
    if n > 0 then begin
      edFIO.Text := copy(S, 1, n);
      Delete(S, 1, n);

      n := pos(' ', S);
      edFIO.Text := edFIO.Text + copy(S, 1, 1) + '.';
      if n > 0 then begin
        Delete(S, 1, n);

        edFIO.Text := edFIO.Text + ' ' + copy(S, 1, 1) + '.';
      end;
    end else
      edFIO.Text := edFM.Text;
end;

procedure TOfficialForm.edFMKeyPress(Sender: TObject; var Key: Char);
Var S : String;
begin
  if ((Sender as TcxTextEdit).SelStart = 0) then begin
    S := AnsiUpperCase(Key);
    Key := S[1];
  end;
end;

procedure TOfficialForm.btHelpClick(Sender: TObject);
begin
  Helpc := 9;
  inherited;
end;

procedure TOfficialForm.cbIspolnitelClick(Sender: TObject);
begin
  inherited;
  edFM.ModifiedAfterEnter := True;
end;

procedure TOfficialForm.cbSkladChange(Sender: TObject);
begin
  edFm.ModifiedAfterEnter := True;
end;

end.
