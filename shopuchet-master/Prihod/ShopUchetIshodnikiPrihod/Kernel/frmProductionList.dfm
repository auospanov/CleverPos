inherited ProductionListForm: TProductionListForm
  Left = 527
  Top = 236
  Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072
  ClientWidth = 708
  ExplicitWidth = 714
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Width = 708
    ExplicitWidth = 708
    inherited tvMain: TcxGridDBTableView
      OnCellDblClick = nil
      object clmMainSKLAD: TcxGridDBColumn
        DataBinding.FieldName = 'SKLAD'
        Visible = False
        Width = 150
      end
      object clmMainOP_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'OP_DATE'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainSTRING_DTLS: TcxGridDBColumn
        Caption = #1044#1077#1090#1072#1083#1080
        DataBinding.FieldName = 'STRING_DTLS'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainNOTE: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        DataBinding.FieldName = 'NOTE'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
    end
  end
  inherited dxBarManagerChild: TdxBarManager
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
          UserDefine = [udWidth]
          UserWidth = 111
          Visible = True
          ItemName = 'dcBegin'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 109
          Visible = True
          ItemName = 'dcEnd'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonIns'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonDel'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxbrbtn2'
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
    object dcBegin: TdxBarDateCombo
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072
      Category = 0
      Hint = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072
      Visible = ivAlways
      OnChange = dcBeginChange
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
    object dcEnd: TdxBarDateCombo
      Caption = #1050#1086#1085#1077#1094
      Category = 0
      Hint = #1050#1086#1085#1077#1094
      Visible = ivAlways
      OnChange = dcBeginChange
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
      Action = aCalcPreCost
      Category = 0
    end
    object dxbrbtn2: TdxBarButton
      Action = aPrint
      Category = 0
    end
  end
  inherited alChild: TActionList
    object aCalcPreCost: TAction
      Caption = #1056#1072#1089#1089#1095#1077#1090' '#1082#1083#1080#1077#1085#1090#1091
      Hint = #1056#1072#1089#1089#1095#1077#1090' '#1087#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1086#1081' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1082#1083#1080#1077#1085#1090#1091
      ImageIndex = 166
    end
    object aPrint: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      ImageIndex = 146
      OnExecute = aPrintExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT * FROM OTHER_READ(?DATE_BEGIN_, ?DATE_END_, ?OP_TYPE_, ?A' +
        'RRIVAL_TYPE_)')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE DEL_PRODUCT (?SKLAD_)')
    StoredProcName = 'DEL_PRODUCT'
  end
end
