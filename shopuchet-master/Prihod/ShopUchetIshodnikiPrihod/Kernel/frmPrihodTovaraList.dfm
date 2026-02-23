inherited PrihodTovaraListForm: TPrihodTovaraListForm
  Left = 348
  Top = 203
  Caption = #1055#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 487
  ClientWidth = 713
  ExplicitWidth = 719
  ExplicitHeight = 513
  PixelsPerInch = 96
  TextHeight = 14
  inherited dxPageControl1: TcxPageControl
    Width = 713
    Height = 461
    Properties.Style = 5
    OnChange = dxPageControl1Change
    ExplicitWidth = 713
    ExplicitHeight = 461
    ClientRectBottom = 436
    ClientRectRight = 713
    inherited ts1: TcxTabSheet
      Caption = #1055#1088#1080#1093#1086#1076' '#1087#1086' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072#1084
      ExplicitWidth = 713
      ExplicitHeight = 436
      inherited gr1: TcxGrid
        Width = 713
        Height = 236
        ExplicitWidth = 713
        ExplicitHeight = 236
        inherited tvMain: TcxGridDBTableView
          OnMouseDown = tvMainMouseDown
          OnCellDblClick = tvMainCellDblClick
          OnCustomDrawCell = tvMainCustomDrawCell
          OnFocusedRecordChanged = tvMainFocusedRecordChanged
          DataController.KeyFieldNames = 'SKLAD'
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              Column = clmMainSUMM
            end
            item
              Kind = skSum
              Column = clmMainSUMM_FACT
            end>
          OptionsView.Footer = True
          object clmMainDATE_RECEIPT: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'DATE_RECEIPT'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainCLIENT_NAME: TcxGridDBColumn
            Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
            DataBinding.FieldName = 'CLIENT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainPAYMENT_NAME: TcxGridDBColumn
            Caption = #1057#1087#1086#1089#1086#1073' '#1086#1087#1083#1072#1090#1099
            DataBinding.FieldName = 'PAYMENT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainOSNOVANIE: TcxGridDBColumn
            Caption = #1044#1086#1082#1091#1084#1077#1085#1090'-'#1086#1089#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'OSNOVANIE'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainNOTE: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'NOTE'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainSUMM: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.FieldName = 'SUMM'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainSUMM_FACT: TcxGridDBColumn
            Caption = #1060#1072#1082#1090'. '#1086#1087#1083#1072#1095#1077#1085#1086
            DataBinding.FieldName = 'SUMM_FACT'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainIS_PAYED_ALL: TcxGridDBColumn
            Caption = #1054#1087#1083#1072#1095#1077#1085#1086
            DataBinding.FieldName = 'IS_PAYED_ALL'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainDETAILS_STR: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088#1099
            DataBinding.FieldName = 'DETAILS_STR'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmMainColumnSKLAD: TcxGridDBColumn
            DataBinding.FieldName = 'SKLAD'
            Visible = False
          end
          object clmMainG_OFFICIAL_FIO: TcxGridDBColumn
            Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
            DataBinding.FieldName = 'G_OFFICIAL_FIO'
            Visible = False
            Width = 120
          end
        end
      end
      object splMenu: TcxSplitter
        Left = 0
        Top = 236
        Width = 713
        Height = 8
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        HotZoneClassName = 'TcxSimpleStyle'
        HotZone.SizePercent = 32
        AlignSplitter = salBottom
        AutoPosition = False
        PositionAfterOpen = 150
        AutoSnap = True
        ResizeUpdate = True
        Control = grSklad
        Color = clBtnFace
        ParentColor = False
      end
      object Panel1: TPanel
        Left = 0
        Top = 244
        Width = 713
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object stDetailsCount: TStaticText
          Left = 8
          Top = 6
          Width = 39
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          BevelKind = bkFlat
          Caption = '00000'
          TabOrder = 0
        end
      end
      object grSklad: TcxGrid
        Left = 0
        Top = 273
        Width = 713
        Height = 163
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        TabOrder = 3
        LookAndFeel.Kind = lfFlat
        object tv1: TcxGridDBTableView
          PopupMenu = pmGrid
          OnMouseDown = tvMainMouseDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsSkladDetails
          DataController.KeyFieldNames = 'SKLAD'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          Styles.Inactive = MainDM.stGridSelectedRow
          Styles.IncSearch = MainDM.stIncSearchStyle
          object clmtv1PRODUCT_NAME: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'PRODUCT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 231
          end
          object clmtv1AMOUNT: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'AMOUNT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taCenter
            Width = 83
          end
          object clmtv1G_UNIT_NAME: TcxGridDBColumn
            Caption = #1045#1076'.'#1080#1079#1084'.'
            DataBinding.FieldName = 'G_UNIT_NAME'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
          end
          object clmtv1PRICE: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            HeaderAlignmentHorz = taCenter
            Width = 87
          end
          object clmtv1SUMM: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.FieldName = 'SUMM'
            HeaderAlignmentHorz = taCenter
            Width = 81
          end
          object clmtv1ARTICUL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1091#1083
            DataBinding.FieldName = 'ARTICUL'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 95
          end
          object clmtv1NOMENCLATUR_NUM: TcxGridDBColumn
            Caption = #1053#1086#1084#1077#1085#1082#1083'. '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'NOMENCLATUR_NUM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmtv1BARCODE: TcxGridDBColumn
            Caption = #1064#1090#1088#1080#1093#1082#1086#1076
            DataBinding.FieldName = 'BARCODE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmtv1PRICE_CURRENCY: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1074' '#1091'.'#1077'.'
            DataBinding.FieldName = 'PRICE_CURRENCY'
            HeaderAlignmentHorz = taCenter
            Width = 88
          end
          object clmtv1SUMM_CURRENCY: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1074' '#1091'.'#1077'.'
            DataBinding.FieldName = 'SUMM_CURRENCY'
            HeaderAlignmentHorz = taCenter
            Width = 96
          end
        end
        object lv1: TcxGridLevel
          GridView = tv1
        end
      end
    end
    object tsPoTovaram: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1088#1080#1093#1086#1076' '#1087#1086' '#1090#1086#1074#1072#1088#1072#1084
      ImageIndex = 1
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grPrihod: TcxGrid
        Left = 0
        Top = 0
        Width = 713
        Height = 436
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object tvPrihodAll: TcxGridDBTableView
          PopupMenu = pmGrid
          OnMouseDown = tvMainMouseDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsSkladDetails
          DataController.KeyFieldNames = 'SKLAD'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsSelection.CellSelect = False
          Styles.Inactive = MainDM.stGridSelectedRow
          Styles.IncSearch = MainDM.stIncSearchStyle
          object clmGridDBDATE_RECEIPT: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'DATE_RECEIPT'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmGridDBCLIENT_NAME: TcxGridDBColumn
            Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
            DataBinding.FieldName = 'CLIENT_NAME'
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'PRODUCT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 231
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'AMOUNT'
            HeaderAlignmentHorz = taCenter
            Width = 83
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            HeaderAlignmentHorz = taCenter
            Width = 87
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.FieldName = 'SUMM'
            HeaderAlignmentHorz = taCenter
            Width = 81
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1091#1083
            DataBinding.FieldName = 'ARTICUL'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 95
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = #1053#1086#1084#1077#1085#1082#1083'. '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'NOMENCLATUR_NUM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = #1064#1090#1088#1080#1093#1082#1086#1076
            DataBinding.FieldName = 'BARCODE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmGridDBPAYMENT_NAME: TcxGridDBColumn
            Caption = #1057#1087#1086#1089#1086#1073' '#1086#1087#1083#1072#1090#1099
            DataBinding.FieldName = 'PAYMENT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmPrihodAllPriceCurrency: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1074' '#1091'.'#1077'.'
            DataBinding.FieldName = 'PRICE_CURRENCY'
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object clmPrihodAllSummCurrency: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1074' '#1091'.'#1077'.'
            DataBinding.FieldName = 'SUMM_CURRENCY'
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = tvPrihodAll
        end
      end
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    Categories.Strings = (
      #1054#1073#1097#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1041#1044
      #1044#1086#1082#1091#1084#1077#1085#1090#1099)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
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
          BeginGroup = True
          Visible = True
          ItemName = 'dcBegin'
        end
        item
          Visible = True
          ItemName = 'dcEnd'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonIns'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
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
          ItemName = 'dxBarSubItem'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
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
    object dxBarSubItem: TdxBarSubItem
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxbrbtn1'
        end>
    end
    object dxbrbtn1: TdxBarButton
      Action = aPrintExcel
      Category = 1
    end
  end
  inherited alChild: TActionList
    inherited aView: TAction
      ShortCut = 0
    end
    object aPrintExcel: TAction
      Category = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      Caption = #1055#1077#1095#1072#1090#1100' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
      OnExecute = aPrintExcelExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited pmGrid: TPopupMenu
    Left = 112
    Top = 168
  end
  inherited dlgSave: TSaveDialog
    Left = 144
    Top = 176
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT * FROM READ_SKLAD_PARENT_LIST(?DATE_BEGIN_, ?DATE_END_, ?' +
        'IS_VOZVRAT_)')
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE DEL_SKLAD (?SKLAD_, ?ALLOW_SELL_ABSENT_GOODS_)')
    StoredProcName = 'DEL_SKLAD'
  end
  object spSkladDetails: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT * FROM READ_SKLAD_LIST(?DATE_BEGIN_, ?DATE_END_, ?SKLAD_P' +
        'ARENT_, ?IS_VOZVRAT_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 48
    Top = 320
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsSkladDetails: TDataSource
    DataSet = spSkladDetails
    Left = 80
    Top = 320
  end
end
