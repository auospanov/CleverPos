unit ReVerifyNow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TurboActivateUnit;

type
  TfrmReVerifyNow = class(TForm)
    lblDescr: TLabel;
    btnReverify: TButton;
    btnExit: TButton;
    procedure btnReverifyClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
      ta : TurboActivate;
      inGrace : Boolean;
  public
      GenuineDaysLeft : LongWord;
      noLongerActivated : Boolean;

      constructor Create(AOwner: TComponent; turboAct: TurboActivate; DaysBetweenChecks: LongWord; GracePeriodLength: LongWord); reintroduce;
  end;

var
  frmReVerifyNow: TfrmReVerifyNow;

implementation

{$R *.dfm}

constructor TfrmReVerifyNow.Create(AOwner: TComponent; turboAct: TurboActivate; DaysBetweenChecks: LongWord; GracePeriodLength: LongWord);
begin
  inherited Create(AOwner);
  self.ta := turboAct;

  // Use the days between checks and grace period from
  // the main form
  GenuineDaysLeft := ta.GenuineDays(DaysBetweenChecks, GracePeriodLength, inGrace);

  if GenuineDaysLeft = 0 then
  begin
      lblDescr.Caption := 'Вы должны пройти повторную проверку лицензии, чтобы и дальше пользоваться приложением.';
  end
  else begin
      lblDescr.Caption := 'У Вас осталось ' + IntToStr(GenuineDaysLeft) + ' дней до повторной проверки лицензии.';
  end;

end;


procedure TfrmReVerifyNow.btnReverifyClick(Sender: TObject);
begin
  Try
    case ta.IsGenuine() of
      Genuine, GenuineFeaturesChanged:
      begin
          ModalResult := mrOK;
          exit;
      end;

      NotGenuine, NotGenuineInVM:
      begin
          noLongerActivated := true;
          ModalResult := mrCancel;
          exit;
      end;

      InternetError:
      begin
          ShowMessage('Не удалось установить соединение с сервером активации.');
          exit;
      end;
    end;
  except
    on E : Exception do begin
      ShowMessage('Не удалось пройти повторную проверку лицензии. Ошибка: ' + E.Message);
    end;
  end;
end;

procedure TfrmReVerifyNow.btnExitClick(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

end.
