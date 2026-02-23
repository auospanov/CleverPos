object CopyProgressForm: TCopyProgressForm
  Left = 902
  Top = 327
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1094#1077#1089#1089' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1080
  ClientHeight = 101
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 41
    Top = 12
    Width = 233
    Height = 21
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taCenter
    AutoSize = False
    Caption = #1048#1076#1077#1090' '#1088#1077#1079#1077#1088#1074#1085#1086#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077
    Constraints.MaxWidth = 233
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 8
    Top = 48
    Width = 313
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    BevelOuter = bvLowered
    TabOrder = 0
  end
  object pb1: TcxProgressBar
    Left = 13
    Top = 59
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ParentFont = False
    Properties.BarStyle = cxbsGradient
    Properties.BeginColor = clActiveCaption
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -15
    Style.Font.Name = 'MS Sans Serif'
    Style.Font.Style = []
    Style.StyleController = DlgForm.dxEditStyleController
    Style.IsFontAssigned = True
    TabOrder = 1
    Width = 301
  end
  object Timer: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerTimer
    Left = 152
    Top = 56
  end
end
