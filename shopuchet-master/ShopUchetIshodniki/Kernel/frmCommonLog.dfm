inherited CommonLogForm: TCommonLogForm
  Caption = #1046#1091#1088#1085#1072#1083' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
  ClientHeight = 315
  ExplicitWidth = 527
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Height = 273
    ExplicitHeight = 273
    object mMain: TcxMemo
      Left = 2
      Top = 2
      Align = alClient
      Properties.ScrollBars = ssVertical
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Height = 269
      Width = 503
    end
  end
  inherited btnOk: TcxButton
    Left = 333
    Top = 283
    ExplicitLeft = 333
    ExplicitTop = 283
  end
  inherited btnCancel: TcxButton
    Left = 417
    Top = 283
    Width = 96
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ExplicitLeft = 417
    ExplicitTop = 283
    ExplicitWidth = 96
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
