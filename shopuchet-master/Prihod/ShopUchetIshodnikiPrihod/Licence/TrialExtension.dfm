object frmTrialExtension: TfrmTrialExtension
  Left = 720
  Top = 363
  ActiveControl = txtExtension
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1076#1083#1080#1090#1100' '#1090#1077#1089#1090#1086#1074#1099#1081' '#1087#1077#1088#1080#1086#1076
  ClientHeight = 166
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 162
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1081' '#1082#1086#1076' '#1079#1076#1077#1089#1100':'
  end
  object btnOK: TButton
    Left = 144
    Top = 136
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'OK'
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 226
    Top = 136
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object txtExtension: TMemo
    Left = 8
    Top = 32
    Width = 289
    Height = 97
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
