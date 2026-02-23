inherited SalesOstBySkladListForm: TSalesOstBySkladListForm
  Left = 534
  Top = 192
  Caption = #1054#1089#1090#1072#1090#1086#1082' '#1090#1086#1074#1072#1088#1086#1074' '#1080' '#1087#1088#1086#1076#1072#1078#1080' '#1079#1072' '#1087#1077#1088#1080#1086#1076
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    inherited tvMain: TcxGridDBTableView
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = tvMainAMOUNT_SOLD
        end>
      OptionsCustomize.ColumnFiltering = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      object clmMainNAME: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'NAME'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object tvMainBARCODE: TcxGridDBColumn
        Caption = #1064#1090#1088#1080#1093#1082#1086#1076
        DataBinding.FieldName = 'BARCODE'
        HeaderAlignmentHorz = taCenter
      end
      object tvMainARTICUL: TcxGridDBColumn
        Caption = #1040#1088#1090#1080#1082#1091#1083
        DataBinding.FieldName = 'ARTICUL'
        HeaderAlignmentHorz = taCenter
      end
      object tvMainAMOUNT: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1086#1082
        DataBinding.FieldName = 'AMOUNT'
        HeaderAlignmentHorz = taCenter
      end
      object tvMainAMOUNT_SOLD: TcxGridDBColumn
        Caption = #1055#1088#1086#1076#1072#1085#1086' '#1079#1072' '#1087#1077#1088#1080#1086#1076
        DataBinding.FieldName = 'AMOUNT_SOLD'
        HeaderAlignmentHorz = taCenter
        Width = 140
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
          UserWidth = 23
          Visible = True
          ItemName = 'dxBarSpinEditHeaderHeight'
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
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
    object dcDateBegin: TdxBarDateCombo
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072
      Category = 0
      Visible = ivAlways
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
      Visible = ivAlways
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
    object dxBarButton2: TdxBarButton
      Action = aExportToExcel
      Category = 0
    end
  end
  inherited alChild: TActionList
    object aExportToExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      OnExecute = aExportToExcelExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_UNIT_LIST')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_DEL_G_UNIT (?G_UNIT_)')
    StoredProcName = 'G_DEL_G_UNIT'
  end
end
