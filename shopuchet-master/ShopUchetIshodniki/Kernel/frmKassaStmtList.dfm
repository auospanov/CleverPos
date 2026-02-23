inherited KassaStmtListForm: TKassaStmtListForm
  Caption = #1044#1074#1080#1078#1077#1085#1080#1077' '#1076#1077#1085#1077#1075' '#1087#1086' '#1082#1072#1089#1089#1077
  ClientWidth = 610
  ExplicitWidth = 616
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Width = 610
    ExplicitWidth = 610
    inherited tvMain: TcxGridDBTableView
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      object clmMainKASSA_STATE: TcxGridDBColumn
        DataBinding.FieldName = 'KASSA_STATE'
        Visible = False
      end
      object clmMainK_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'K_DATE'
        HeaderAlignmentHorz = taCenter
      end
      object clmMainINPUT: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1086#1082' '#1085#1072' '#1085#1072#1095#1072#1083#1086
        DataBinding.FieldName = 'INPUT'
        HeaderAlignmentHorz = taCenter
        Width = 133
      end
      object clmMainDEBET: TcxGridDBColumn
        Caption = #1056#1072#1089#1093#1086#1076
        DataBinding.FieldName = 'DEBET'
        HeaderAlignmentHorz = taCenter
        Width = 109
      end
      object clmMainCREDIT: TcxGridDBColumn
        Caption = #1055#1088#1080#1093#1086#1076
        DataBinding.FieldName = 'CREDIT'
        HeaderAlignmentHorz = taCenter
        Width = 121
      end
      object clmMainOUTPUT: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1086#1082' '#1085#1072' '#1082#1086#1085#1077#1094
        DataBinding.FieldName = 'OUTPUT'
        HeaderAlignmentHorz = taCenter
        Width = 128
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
          UserDefine = [udWidth]
          UserWidth = 122
          Visible = True
          ItemName = 'cbPaymentType'
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
    object cbPaymentType: TdxBarCombo
      Caption = #1050#1072#1089#1089#1072
      Category = 0
      Hint = #1050#1072#1089#1089#1072
      Visible = ivAlways
      OnChange = cbPaymentTypeChange
      ShowCaption = True
      Text = #1053#1072#1083#1080#1095#1085#1072#1103
      Items.Strings = (
        #1053#1072#1083#1080#1095#1085#1072#1103
        #1041#1077#1079#1085#1072#1083#1080#1095#1085#1072#1103)
      ItemIndex = 0
    end
    object dcDateBegin: TdxBarDateCombo
      Caption = #1055#1077#1088#1080#1086#1076' '#1089
      Category = 0
      Hint = #1055#1077#1088#1080#1086#1076' '#1089
      Visible = ivAlways
      OnChange = cbPaymentTypeChange
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
      Caption = ' '#1087#1086' '
      Category = 0
      Hint = ' '#1087#1086' '
      Visible = ivAlways
      OnChange = cbPaymentTypeChange
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
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select * from K_READ_KASSASTMT_LIST(?DATE_BEGIN_, ?DATE_END_, ?G' +
        '_PAYMENT_TYPE_, ?G_TOCHKA_)')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
