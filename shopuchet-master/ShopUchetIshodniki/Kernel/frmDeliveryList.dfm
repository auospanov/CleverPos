inherited DeliveryListForm: TDeliveryListForm
  Left = 534
  Top = 192
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1077#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1081
  ClientWidth = 753
  ExplicitWidth = 759
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Width = 753
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitWidth = 753
    inherited tvMain: TcxGridDBTableView
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      object clmMainColumn1: TcxGridDBColumn
        Caption = #1047#1072#1082#1072#1079
        DataBinding.FieldName = 'ZAKAZ'
        HeaderAlignmentHorz = taCenter
        Width = 160
      end
      object clmMainDELIVERY: TcxGridDBColumn
        DataBinding.FieldName = 'DELIVERY'
        Visible = False
        Width = 130
      end
      object clmMainG_CLIENT: TcxGridDBColumn
        DataBinding.FieldName = 'G_CLIENT'
        Visible = False
        Width = 130
      end
      object clmMainCLIENT_NAME: TcxGridDBColumn
        Caption = #1050#1083#1080#1077#1085#1090
        DataBinding.FieldName = 'CLIENT_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object clmMainDOSTAVSHIK: TcxGridDBColumn
        DataBinding.FieldName = 'DOSTAVSHIK'
        Visible = False
        Width = 130
      end
      object clmMainDELIVERY_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
        DataBinding.FieldName = 'DELIVERY_DATE'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object clmMainADDRESS: TcxGridDBColumn
        Caption = #1040#1076#1088#1077#1089
        DataBinding.FieldName = 'ADDRESS'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object clmMainPRICE: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
        DataBinding.FieldName = 'PRICE'
        HeaderAlignmentHorz = taCenter
        Width = 86
      end
      object clmMainPHONE: TcxGridDBColumn
        Caption = #1058#1077#1083#1077#1092#1086#1085' '#1082#1083#1080#1077#1085#1090#1072
        DataBinding.FieldName = 'PHONE'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object clmMainDOST_NAME: TcxGridDBColumn
        Caption = #1044#1086#1089#1090#1072#1074#1097#1080#1082
        DataBinding.FieldName = 'DOST_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object clmMainTOVAR_DELIVERY_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'TOVAR_DELIVERY_DATE'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 123
      end
      object clmMainSTATUS: TcxGridDBColumn
        Caption = #1057#1090#1072#1090#1091#1089
        DataBinding.FieldName = 'STATUS'
        HeaderAlignmentHorz = taCenter
        Width = 120
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
          ItemName = 'bdDate'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonView'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonIns'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonUpd'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonDel'
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
    object bdDate: TdxBarDateCombo
      Caption = 'New Item'
      Category = 0
      Hint = #1044#1072#1090#1072
      Visible = ivAlways
      OnChange = bdDateChange
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD00000000000DDDDD0FFFFFFFFF0D00000F0000000F0D0FFF0FFFFFFF
        FF0D0F000FFF11FFFF0D0FFF0FFF11FFFF0D0FF10FFFF11FFF0D0FF10FFFFF11
        FF0D0FF10FF11111FF0D0FF10FFFFFFFFF0D0FF104444444440D0FFF04444444
        440D044400000000000D04444444440DDDDD00000000000DDDDD}
    end
  end
  inherited alChild: TActionList
    object Action1: TAction
      Caption = 'Action1'
    end
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE DELIVERY_DEL (?DELIVERY_)')
    StoredProcName = 'DELIVERY_DEL'
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM DELIVERY_READ(?DATE_)')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
