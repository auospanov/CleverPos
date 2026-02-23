object frmReVerifyNow: TfrmReVerifyNow
  Left = 803
  Top = 336
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1081#1090#1080' '#1087#1088#1086#1074#1077#1088#1082#1091' '#1089' '#1089#1077#1088#1074#1077#1088#1086#1084' '#1072#1082#1090#1080#1074#1072#1094#1080#1080
  ClientHeight = 106
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 120
  TextHeight = 16
  object lblDescr: TLabel
    Left = 10
    Top = 10
    Width = 323
    Height = 16
    Caption = 'You have X days to re-verify with the activation servers.'
  end
  object btnReverify: TButton
    Left = 20
    Top = 49
    Width = 149
    Height = 41
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1089#1077#1081#1095#1072#1089
    TabOrder = 0
    OnClick = btnReverifyClick
  end
  object btnExit: TButton
    Left = 305
    Top = 49
    Width = 179
    Height = 41
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1087#1086#1079#1078#1077
    TabOrder = 1
    OnClick = btnExitClick
  end
end
