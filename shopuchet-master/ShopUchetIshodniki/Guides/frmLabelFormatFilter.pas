unit frmLabelFormatFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TLabelFormatFilterForm = class(TForm)
    rbJpeg: TRadioButton;
    rbWord: TRadioButton;
    rbExcel: TRadioButton;
    BitBtn1: TBitBtn;
    procedure rbJpegClick(Sender: TObject);
    procedure rbWordClick(Sender: TObject);
    procedure rbExcelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FLabelFormat : Integer;
  public
    property LabelFormat : Integer read FLabelFormat write FLabelFormat;
  end;

var
  LabelFormatFilterForm: TLabelFormatFilterForm;

implementation

{$R *.dfm}

procedure TLabelFormatFilterForm.rbJpegClick(Sender: TObject);
begin
  FLabelFormat := 0;
end;

procedure TLabelFormatFilterForm.rbWordClick(Sender: TObject);
begin
  FLabelFormat := 1;
end;

procedure TLabelFormatFilterForm.rbExcelClick(Sender: TObject);
begin
  FLabelFormat := 2;
end;

procedure TLabelFormatFilterForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  LabelFormat := FLabelFormat;
end;

end.
