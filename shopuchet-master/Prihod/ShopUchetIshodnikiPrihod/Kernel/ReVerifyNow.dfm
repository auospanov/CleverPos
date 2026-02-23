object frmReVerifyNow: TfrmReVerifyNow
  Left = 728
  Top = 335
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Re-verify with the activation servers'
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
    Width = 129
    Height = 41
    Caption = 'Re-verify now'
    TabOrder = 0
    OnClick = btnReverifyClick
  end
  object btnExit: TButton
    Left = 305
    Top = 49
    Width = 179
    Height = 41
    Caption = 'Exit application'
    TabOrder = 1
    OnClick = btnExitClick
  end
end
