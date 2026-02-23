object MessageTimerForm: TMessageTimerForm
  Left = 365
  Top = 317
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1042#1085#1080#1084#1072#1085#1080#1077
  ClientHeight = 87
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBtn: TPanel
    Left = 0
    Top = 53
    Width = 419
    Height = 34
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      419
      34)
    object btnYes: TBitBtn
      Left = 110
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1044#1072
      TabOrder = 0
      OnClick = btnYesClick
    end
    object btnNo: TBitBtn
      Left = 238
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1053#1077#1090
      TabOrder = 1
      OnClick = btnNoClick
    end
  end
  object PanelText: TPanel
    Left = 0
    Top = 0
    Width = 419
    Height = 53
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    BorderWidth = 20
    TabOrder = 0
    object LabelMessageText: TLabel
      Left = 20
      Top = 20
      Width = 90
      Height = 13
      Caption = 'LabelMessageText'
    end
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 16
    Top = 40
  end
end
