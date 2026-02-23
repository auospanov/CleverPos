unit unMessageTimer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TMessageTimerForm = class(TForm)
    Timer: TTimer;
    PanelText: TPanel;
    LabelMessageText: TLabel;
    PanelBtn: TPanel;
    btnYes: TBitBtn;
    btnNo: TBitBtn;
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
  private
    { Private declarations }
    FMessageText : String; // Текст информационного сообщения в окне
    FButtonYesText : String; // Текст кнопки "Да"
    FButtonNoText : String; // Текст кнопки "Нет"
    FButtonResult : String; // Результат закрытия окна (какая кнопка нажалась, "Yes" или "No")
    FExecuteProcedure : Pointer; // Адрес на процедуру, которая будет вызываться по событию таймера
    FProcedure : Procedure;
    FCounter : Integer;
    FSeconds : Integer;
  public
    { Public declarations }
    //ExecuteProcedure : Pointer;
    property MessageText : String Read FMessageText Write FMessageText; // Текст информационного сообщения в окне
    property ButtonYesText : String Read FButtonYesText Write FButtonYesText; // Текст кнопки "Да"
    property ButtonNoText : String Read FButtonNoText Write FButtonNoText; // Текст кнопки "Нет"
    property ButtonResult : String Read FButtonResult Write FButtonResult; // Результат закрытия окна (какая кнопка нажалась, "Yes" или "No")
    property ExecuteProcedure : Pointer Read FExecuteProcedure Write FExecuteProcedure; // Адрес на процедуру, которая будет вызываться по событию таймера
    property Seconds : Integer Read FSeconds Write FSeconds;

  end;

var
  MessageTimerForm: TMessageTimerForm;

implementation

{$R *.dfm}

procedure TMessageTimerForm.TimerTimer(Sender: TObject);
begin
  FCounter := FCounter + 1;
  btnYes.Caption := FButtonYesText + '(' + IntTostr(FSeconds-FCounter) + ')';
  If FCounter >= FSeconds Then Begin
    If Assigned(FExecuteProcedure) then Begin
      FProcedure := FExecuteProcedure;
      Try
        FProcedure;
      Finally
        Free;
      End;

    End;
  End;
end;

procedure TMessageTimerForm.FormShow(Sender: TObject);
begin
    LabelMessageText.Caption := FMessageText;

    If FButtonYesText = '' Then
      FButtonYesText := 'Да';
    btnYes.Caption := ButtonYesText;

    If FButtonNoText = '' Then
      FButtonNoText := 'Нет';
    btnNo.Caption := ButtonNoText;

    If (FSeconds <= 0) Or (FSeconds > 60) Then
      FSeconds := 30;

    FCounter := 0;

    AutoSize := True;

end;

procedure TMessageTimerForm.btnYesClick(Sender: TObject);
begin
   FButtonResult := 'Yes';
   If Assigned(FExecuteProcedure) then Begin
     FProcedure := FExecuteProcedure;
     Try
       FProcedure;
     Finally
       Free;
     End;
   End;

end;

procedure TMessageTimerForm.btnNoClick(Sender: TObject);
begin
   FButtonResult := 'No';
   If Assigned(FExecuteProcedure) then Begin
     FProcedure := FExecuteProcedure;
     Try
       FProcedure;
     Finally
       Free;
     End;
   End;
  
end;

end.
