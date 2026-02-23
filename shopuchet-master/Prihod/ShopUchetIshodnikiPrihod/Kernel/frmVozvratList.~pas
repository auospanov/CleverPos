unit frmVozvratList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDBList, dxExEdtr, Oracle, DB, OracleData, ExtCtrls, Menus,
  ActnList, dxBar, dxBarExtItems, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase;

type
  TVozvratListForm = class(TDBListForm)
    dxDBGridSKLAD: TdxDBGridMaskColumn;
    dxDBGridDATE_RECEIPT: TdxDBGridDateColumn;
    dxDBGridG_PRODUCT: TdxDBGridMaskColumn;
    dxDBGridAMOUNT: TdxDBGridMaskColumn;
    dxDBGridPRICE: TdxDBGridMaskColumn;
    dxDBGridSUMM: TdxDBGridMaskColumn;
    dxDBGridOSNOVANIE: TdxDBGridMaskColumn;
    dxDBGridIS_VOZVRAT: TdxDBGridMaskColumn;
    dxDBGridPRODUCT_NAME: TdxDBGridMaskColumn;
    procedure FormCreate(Sender: TObject);
    procedure aDelExecute(Sender: TObject);
  private
  public
    procedure ViewData; override;
    procedure InsData; override;
    procedure UpdData; override;
    procedure ReadList; override;
  end;

var
  VozvratListForm: TVozvratListForm;

implementation

uses frmPrihodTovaraN, frmUpdPrihodTovara;

{$R *.dfm}
procedure TVozvratListForm.ReadList;
begin
  spRead.ParamByName('IS_VOZVRAT_').AsInteger := 1;
  inherited;
  aInsLike.Visible := False;
  aView.Visible := False;

  // убрал, чтобы пользователь не мог менять возврат товара, пусть удаляет и вставляет новый
  // связано с наличным и безналичным расчетом, вдруг покупка была по безналу,
  // возврат был сделан, а юзер забыл поставить галочку "Товар был куплен по безналу"
  // затем решил тут изменить и т.д., расчет получался слишком сложным, не стал заморачиваться
  aUpd.Visible := False;
end;

procedure TVozvratListForm.FormCreate(Sender: TObject);
begin
  inherited;
  KeyFieldList := 'sklad';
  KeyFieldClass := 'sklad_';
end;

procedure TVozvratListForm.ViewData;
begin
  ClassForm := TUpdPrihodTovaraForm.Create(Self);
  try
    {Вызываем метод предка}
    inherited;
  finally
    ClassForm.Free;
  end;
end;

procedure TVozvratListForm.InsData;
begin
  PrihodTovaraNForm := TPrihodTovaraNForm.Create(Self);
  try
    PrihodTovaraNForm.OpenMode := omInsert;
    PrihodTovaraNForm.Is_vozvrat := 1;
    if PrihodTovaraNForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('sklad', PrihodTovaraNForm.RecID, []);
      if dxDBGrid.FocusedNode <> Nil then
      begin
        if dxDBGrid.SelectedCount > 0 then
          dxDBGrid.SelectedNodes[0].Selected := False;
        dxDBGrid.FocusedNode.Selected := True;
      end;
    end;
  finally
    PrihodTovaraNForm.Free;
  end;
end;

procedure TVozvratListForm.UpdData;
begin
  UpdPrihodTovaraForm := TUpdPrihodTovaraForm.Create(Self);
  try
    UpdPrihodTovaraForm.OpenMode := omUpdate;
    UpdPrihodTovaraForm.RecId := spRead.FieldByName('sklad').AsInteger;
    UpdPrihodTovaraForm.Is_vozvrat := 1;
    if UpdPrihodTovaraForm.ShowModal = mrOK then begin
      Readlist;
      spRead.Locate('sklad', UpdPrihodTovaraForm.RecID, []);
    end;
  finally
    UpdPrihodTovaraForm.Free;
  end;
end;

procedure TVozvratListForm.aDelExecute(Sender: TObject);
begin
  if MessageDlg(Format('Удалить возврат товара за "%s" ?',
    [DateToStr(spRead.FieldByName('date_receipt').AsDateTime)]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  inherited;
  {spDel.SetVariable('sklad_', spRead.FieldByName('sklad').AsInteger);
  if ExecSP(spDel) then
    Readlist;}
end;

end.
