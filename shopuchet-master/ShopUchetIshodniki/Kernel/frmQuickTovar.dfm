inherited QuickTovarForm: TQuickTovarForm
  Caption = #1041#1099#1089#1090#1088#1099#1077' '#1090#1086#1074#1072#1088#1099
  ClientHeight = 466
  ClientWidth = 591
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  ExplicitWidth = 597
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 577
    Height = 424
    ExplicitWidth = 577
    ExplicitHeight = 424
    object ScrollBox: TcxScrollBox
      Left = 2
      Top = 2
      Width = 573
      Height = 420
      Align = alClient
      LookAndFeel.Kind = lfFlat
      TabOrder = 0
      VertScrollBar.Position = 7
      object fpTovarlist: TFlowPanel
        Left = 0
        Top = -7
        Width = 555
        Height = 425
        Align = alTop
        AutoSize = True
        TabOrder = 0
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 422
    Top = 434
    ExplicitLeft = 422
    ExplicitTop = 434
  end
  inherited btnCancel: TcxButton
    Left = 509
    Top = 434
    ExplicitLeft = 509
    ExplicitTop = 434
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
