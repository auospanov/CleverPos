unit frmFillData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmDlg, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxEdit, cxEditRepositoryItems,
  cxClasses, cxContainer, Vcl.AppEvnts, cxButtons, Vcl.ExtCtrls, cxControls,
  cxCheckBox, Vcl.ComCtrls, FIBDatabase, pFIBDatabase, pFIBScripter, FIB,
  FIBQuery, pFIBQuery, pFIBStoredProc, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxRadioGroup, Registry, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFillDataForm = class(TDlgForm)
    Label1: TLabel;
    tranMainWrite: TpFIBTransaction;
    spFillData: TpFIBStoredProc;
    lb1: TLabel;
    shp1: TShape;
    shp2: TShape;
    lb4: TLabel;
    shp7: TShape;
    shp8: TShape;
    cbConfig: TcxComboBox;
    cbCountry: TcxComboBox;
    pnlFillData: TPanel;
    lbQuestion: TLabel;
    rbYes: TcxRadioButton;
    rbNo: TcxRadioButton;
    btnBack: TcxButton;
    cbProdukty: TcxCheckBox;
    cbHim: TcxCheckBox;
    cbMed: TcxCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnBackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbYesClick(Sender: TObject);
    procedure rbNoClick(Sender: TObject);
    procedure SetVisible(vis : Boolean);
  private
    FConfig  : Integer;
    FCountry : Integer;
    procedure SaveSetup;
    procedure InitPanel;
    procedure DisableFirstPanel;
  public
    property ConfigShop : Integer read FConfig write FConfig;
  end;

var
  FillDataForm: TFillDataForm;

implementation

uses
  unCommonFunc, unInitApp;

{$R *.dfm}

procedure TFillDataForm.btnBackClick(Sender: TObject);
begin
  pnlFillData.Visible := False;
  Panel1.Visible      := True;
  btnOk.Caption       := 'Далее >';
  btnBack.Enabled     := False;

  rbYes.Visible       := False;
  rbNo.Visible        := False;
end;

procedure TFillDataForm.DisableFirstPanel;
begin
  pnlFillData.Visible := True;
  Panel1.Visible      := False;
  btnOk.Caption       := 'OK';
  btnBack.Enabled     := True;
end;

procedure TFillDataForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;

  if (ModalResult = mrOk) then begin
    if Panel1.Visible then begin
      if cbConfig.ItemIndex = -1 then begin
        MessageDlg('Вы не указали тип Вашего магазина!', mtError, [mbOk], 0);
        Exit;
      end;
      FConfig             := cbConfig.ItemIndex;
      FCountry            := cbCountry.ItemIndex;

      InitPanel;

      DisableFirstPanel;
    end
    else begin
      if rbYes.Visible then begin
        if rbYes.Checked then begin
          try
            Screen.Cursor := crHourGlass;

            spFillData.ParamByName('PRODUCTY_').AsInteger := Integer(cbProdukty.Checked);
            spFillData.ParamByName('HIM_').AsInteger := Integer(cbHim.Checked);
            spFillData.ParamByName('APTEKA_').AsInteger := Integer(cbMed.Checked);

            if ExecSPTr(spFillData) then begin
              MessageDlg('Товары внесены успешно!', mtInformation, [mbOk], 0);
              SaveSettingsIni('Common', 'DataAlreadyFilled', 1, '');
            end
            else
              Exit;
          finally
            Screen.Cursor := crDefault;
          end;
        end;
      end;
      if FirstStartup = 0 then
        SaveSettingsIni('Common', 'FirstStartup', 1, '');
      SaveSetup;

      CanClose := True;
    end;
  end;
end;

procedure TFillDataForm.FormShow(Sender: TObject);
begin
  inherited;

  if FirstStartup = 1 then begin
    DisableFirstPanel;
    btnBack.Enabled := False;
    btnBack.Visible := False;

    InitPanel;
  end;
end;

procedure TFillDataForm.InitPanel;
begin
  if FConfig in [0, 1, 2] then begin
    rbYes.Visible := True;
    rbYes.Checked := True;
    rbNo.Visible  := True;

    SetVisible(True);
  end else begin
    lbQuestion.Caption := 'Программа готова к работе. Нажмите кнопку "ОК".';
    rbYes.Checked := False;
    rbNo.Checked  := False;
    SetVisible(False);
  end;
end;

procedure TFillDataForm.rbNoClick(Sender: TObject);
begin
  SetVisible(False);
end;

procedure TFillDataForm.rbYesClick(Sender: TObject);
begin
  SetVisible(True);
end;

procedure TFillDataForm.SetVisible(vis: Boolean);
begin
  if vis then begin
    if FConfig = 0 then begin
      lbQuestion.Caption := 'Заполнить программу товарами для продуктового магазина?';
      cbProdukty.Visible := True;
      cbProdukty.Checked := True;
      cbHim.Visible := True;
      cbHim.Checked := True;
      cbMed.Visible := False;
      cbMed.Checked := False;

    end else if FConfig = 1 then begin
      lbQuestion.Caption := 'Заполнить программу товарами для магазина бытовой химии?';
      cbProdukty.Visible := false;
      cbProdukty.Checked := false;
      cbHim.Visible := True;
      cbHim.Checked := True;
      cbMed.Visible := False;
      cbMed.Checked := False;

    end else begin
      lbQuestion.Caption := 'Заполнить программу товарами для аптеки?';
      cbProdukty.Visible := false;
      cbProdukty.Checked := false;
      cbHim.Visible := True;
      cbHim.Checked := False;
      cbMed.Visible := True;
      cbMed.Checked := True;
    end;
  end
  else begin
    cbProdukty.Visible := false;
    cbHim.Visible := false;
    cbMed.Visible := false;
  end;
end;

procedure TFillDataForm.SaveSetup;
var
  Reg: TRegistry;
begin
  try
    Reg := TRegistry.Create;
    try
      with Reg do begin
        RootKey := RegSetupRoot;
        LazyWrite := False;  {Сохраняем ключи до закрытия}
        if OpenKey(RegSetupKey, True) then
          try
            {Внешний вид и поведение}
            {Валюта 0 - тенге, 1 - рубли, 2 - гривны}
            WriteInteger('Currency', FCountry);

            {конфигурация магазина}
            WriteInteger('ConfigStartup', FConfig);
            if FConfig in [0, 1, 5, 6] then begin
              WriteInteger('Config', 0);
              Config := 0;
            end

            else if FConfig = 2 then begin
              WriteInteger('Config', 1);  //Аптека
              Config := 1
            end
            else if FConfig = 3 then begin
              WriteInteger('Config', 2);  //Магазин автозапчастей
              Config := 2
            end
            else if FConfig = 4 then begin
              WriteInteger('Config', 3);  //Производство (цех, пекарня)
              Config := 3;
            end;
            //*******************************************
            //конфигурация рабочего места кассира
            //*******************************************
            if FConfig = 5 then begin
              //показывать панель с товарами
              WriteInteger('ShowTovarPanel', 1);
              ShowTovarPanel := 1;

              //Показывать товары в виде кнопок
              WriteInteger('KafeTovarView', 1);
              KafeTovarView := 1;
              Config := 5;
            end;
            //************************************************
          finally
            CloseKey;
          end;
      end;
    finally
      Reg.Free;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOk], 0);
  end;
end;

end.
