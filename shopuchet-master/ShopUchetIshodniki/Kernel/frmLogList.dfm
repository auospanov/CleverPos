inherited LogListForm: TLogListForm
  Caption = #1046#1091#1088#1085#1072#1083' '#1076#1077#1081#1089#1090#1074#1080#1081
  ExplicitHeight = 353
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    inherited tvMain: TcxGridDBTableView
      OnCellDblClick = tvMainCellDblClick
      object clmMainLOG_OPER: TcxGridDBColumn
        DataBinding.FieldName = 'LOG_OPER'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainODATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'ODATE'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainOPERATION: TcxGridDBColumn
        Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        DataBinding.FieldName = 'OPERATION'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainG_OFFICIAL_FIO: TcxGridDBColumn
        Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
        DataBinding.FieldName = 'G_OFFICIAL_FIO'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainColumn1: TcxGridDBColumn
        Caption = #1058#1080#1087
        DataBinding.FieldName = 'ITEM_TYPE'
        HeaderAlignmentHorz = taCenter
        Width = 141
      end
      object clmMainHEADER: TcxGridDBColumn
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        DataBinding.FieldName = 'HEADER'
        HeaderAlignmentHorz = taCenter
        Width = 250
      end
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    LookAndFeel.SkinName = ''
    DockControlHeights = (
      0
      0
      26
      0)
    inherited dxBarManagerChildBar1: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStaticRecCnt'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonEnableAutoRefresh'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 36
          Visible = True
          ItemName = 'dxBarSpinEditHeaderHeight'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxbrbtn1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dcDateBegin'
        end
        item
          Visible = True
          ItemName = 'dcDateEnd'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
    object dcDateBegin: TdxBarDateCombo
      Caption = #1053#1072#1095#1072#1083#1086
      Category = 0
      Hint = #1053#1072#1095#1072#1083#1086
      Visible = ivAlways
      OnChange = dcDateBeginChange
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD00000000000DDDDD0FFFFFFFFF0D00000F0000000F0D0FFF0FFFFFFF
        FF0D0F000FFF11FFFF0D0FFF0FFF11FFFF0D0FF10FFFF11FFF0D0FF10FFFFF11
        FF0D0FF10FF11111FF0D0FF10FFFFFFFFF0D0FF104444444440D0FFF04444444
        440D044400000000000D04444444440DDDDD00000000000DDDDD}
      ShowCaption = True
    end
    object dcDateEnd: TdxBarDateCombo
      Caption = #1050#1086#1085#1077#1094
      Category = 0
      Hint = #1050#1086#1085#1077#1094
      Visible = ivAlways
      OnChange = dcDateBeginChange
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD00000000000DDDDD0FFFFFFFFF0D00000F0000000F0D0FFF0FFFFFFF
        FF0D0F000FFF11FFFF0D0FFF0FFF11FFFF0D0FF10FFFF11FFF0D0FF10FFFFF11
        FF0D0FF10FF11111FF0D0FF10FFFFFFFFF0D0FF104444444440D0FFF04444444
        440D044400000000000D04444444440DDDDD00000000000DDDDD}
      ShowCaption = True
    end
    object dxbrbtn1: TdxBarButton
      Action = aView
      Category = 0
    end
  end
  inherited alChild: TActionList
    object aView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088
      ImageIndex = 147
      OnExecute = aViewExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from LOG_OPER_READ_LIST(?DATE_BEGIN_, ?DATE_END_)')
    AutoCalcFields = False
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
