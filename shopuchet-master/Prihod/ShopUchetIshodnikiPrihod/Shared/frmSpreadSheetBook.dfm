inherited SpreadSheetBookForm: TSpreadSheetBookForm
  Left = 219
  Caption = 'SpreadSheetBookForm'
  ExplicitWidth = 441
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 14
  object SpreadSheetBook: TdxSpreadSheet [0]
    Left = 0
    Top = 26
    Width = 435
    Height = 270
    Align = alClient
    BorderStyle = cxcbsNone
    ExplicitLeft = 80
    ExplicitTop = 72
    ExplicitWidth = 460
    ExplicitHeight = 240
    Data = {
      4F01000044585353763242460300000042465320000000000000000001000101
      01010000000000004246532000000000424653200100000001000000200B0000
      0007000000430061006C00690062007200690000000000002000000020000000
      00200000000020000000002000000000200007000000470045004E0045005200
      41004C0000000000000200000000000000000142465320010000004246532017
      0000005400640078005300700072006500610064005300680065006500740054
      00610062006C0065005600690065007700060000005300680065006500740031
      0001FFFFFFFFFFFFFFFF64000000020000000200000002000000550000001400
      0000020000000200000000020000004246532055000000000000004246532014
      0000000000000000000000000000000100000000000000000000000000000000
      00000000000000000000004246532000000000}
  end
  inherited dxBarManagerChild: TdxBarManager
    DockControlHeights = (
      0
      0
      26
      0)
    inherited dxBarManagerChildBar1: TdxBar
      AllowCustomizing = False
      AllowQuickCustomizing = False
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonEnableAutoSize'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonPageSetup'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonPrintPreview'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonPrint'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonOpenInExcel'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
    object dxBarButtonClose: TdxBarButton
      Action = aClose
      Category = 0
    end
    object dxBarButtonPageSetup: TdxBarButton
      Action = aPageSetup
      Category = 0
    end
    object dxBarButtonPrintPreview: TdxBarButton
      Action = aPrintPreview
      Category = 0
    end
    object dxBarButtonPrint: TdxBarButton
      Action = aPrint
      Category = 0
    end
    object dxBarButtonOpenInExcel: TdxBarButton
      Action = aOpenInExcel
      Category = 0
    end
  end
  inherited alChild: TActionList
    object aFormatCell: TAction
      Caption = #1060#1086#1088#1084#1072#1090' '#1103#1095#1077#1077#1082
      Hint = #1060#1086#1088#1084#1072#1090' '#1103#1095#1077#1077#1082
      ImageIndex = 8
      OnExecute = aFormatCellExecute
    end
    object aOpenInExcel: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1074' Excel'
      ImageIndex = 117
      OnExecute = aOpenInExcelExecute
    end
    object aClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 43
      OnExecute = aCloseExecute
    end
    object aPrintPreview: TAction
      Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088
      Hint = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088
      ImageIndex = 105
      OnExecute = aPrintPreviewExecute
    end
    object aPrint: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
      ImageIndex = 19
      OnExecute = aPrintExecute
    end
    object aPageSetup: TAction
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1090#1088#1072#1085#1080#1094#1099
      Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1090#1088#1072#1085#1080#1094#1099
      ImageIndex = 20
      OnExecute = aPageSetupExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  object pmSheet: TPopupMenu
    Left = 16
    Top = 144
    object N1: TMenuItem
      Action = aFormatCell
    end
  end
  object dxComponentPrinter: TdxComponentPrinter
    Version = 0
    Left = 16
    Top = 176
  end
end
