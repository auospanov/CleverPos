inherited DiscountCardListForm: TDiscountCardListForm
  Left = 519
  Top = 170
  Caption = #1053#1072#1082#1086#1087#1080#1090#1077#1083#1100#1085#1099#1077' '#1076#1080#1089#1082#1086#1085#1090#1085#1099#1077' '#1082#1072#1088#1090#1099
  PixelsPerInch = 96
  TextHeight = 14
  inherited dxDBGrid: TdxDBGrid
    Width = 376
    KeyField = 'G_DISCONT_CARD'
    ShowGroupPanel = True
    Filter.Criteria = {00000000}
    RegistryPath = '\Software\ShopUchet\DiscountCard'
    OnChangeNode = dxDBGridChangeNode
    object dxDBGridG_DISCONT_CARD: TdxDBGridMaskColumn
      Alignment = taCenter
      HeaderAlignment = taCenter
      Visible = False
      Width = 120
      BandIndex = 0
      RowIndex = 0
      FieldName = 'G_DISCONT_CARD'
    end
    object dxDBGridCODE: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1050#1086#1076
      HeaderAlignment = taCenter
      Width = 120
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CODE'
    end
    object dxDBGridBARCODE: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1064#1090#1088#1080#1093#1082#1086#1076
      HeaderAlignment = taCenter
      Width = 120
      BandIndex = 0
      RowIndex = 0
      FieldName = 'BARCODE'
    end
    object dxDBGridN_PERCENT: TdxDBGridCurrencyColumn
      Alignment = taRightJustify
      Caption = #1055#1088#1086#1094#1077#1085#1090
      HeaderAlignment = taCenter
      Width = 120
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N_PERCENT'
      DisplayFormat = ',0.00%;-,0.00%'
      Nullable = False
    end
    object dxDBGridSUMM: TdxDBGridCurrencyColumn
      Alignment = taRightJustify
      Caption = #1057#1091#1084#1084#1072' '#1085#1072#1082#1086#1087#1083#1077#1085#1080#1081
      HeaderAlignment = taCenter
      Width = 120
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SUMM'
      DisplayFormat = ',0.00;-,0.00'
      Nullable = False
    end
  end
  object splDiscountCard: TcxSplitter [1]
    Left = 376
    Top = 26
    Width = 8
    Height = 395
    HotZoneClassName = 'TcxSimpleStyle'
    HotZone.SizePercent = 32
    AlignSplitter = salRight
    AutoPosition = False
    PositionAfterOpen = 150
    AutoSnap = True
    ResizeUpdate = True
    Control = Panel1
    Color = clBtnFace
    ParentColor = False
  end
  object Panel1: TPanel [2]
    Left = 384
    Top = 26
    Width = 246
    Height = 395
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 6
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 246
      Height = 177
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object dxDBGrid1: TdxDBGrid
        Left = 0
        Top = 0
        Width = 246
        Height = 177
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'LT_CLIENT_DCARD'
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        TabOrder = 0
        DataSource = dsNotRelClients
        Filter.Criteria = {00000000}
        OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMouseScroll, edgoMultiSelect, edgoMultiSort, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
        OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        RegistryPath = '\Software\ShopUchet\DiscountCard\grRelClients'
        object dxDBGridMaskColumn2: TdxDBGridMaskColumn
          Alignment = taLeftJustify
          Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1082#1083#1080#1077#1085#1090#1099
          HeaderAlignment = taCenter
          Width = 150
          BandIndex = 0
          RowIndex = 0
          HeaderMaxLineCount = 2
          FieldName = 'CLIENT_NAME'
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 185
      Width = 246
      Height = 210
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 1
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 246
        Height = 41
        Align = alTop
        TabOrder = 0
        object SpeedButton1: TSpeedButton
          Left = 8
          Top = 7
          Width = 31
          Height = 30
          Action = aAddClient
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF000000000000000000000000000000000000000000000000000000
            00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        end
        object SpeedButton2: TSpeedButton
          Left = 47
          Top = 7
          Width = 31
          Height = 30
          Action = aDelClient
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF000000000000000000000000000000000000000000000000000000
            00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 41
        Width = 246
        Height = 169
        Align = alClient
        Caption = 'Panel3'
        TabOrder = 1
        object grRelClients: TdxDBGrid
          Left = 1
          Top = 1
          Width = 244
          Height = 167
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'LT_CLIENT_DCARD'
          SummaryGroups = <>
          SummarySeparator = ', '
          Align = alClient
          TabOrder = 0
          DataSource = dsRelClients
          Filter.Criteria = {00000000}
          OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMouseScroll, edgoMultiSelect, edgoMultiSort, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
          OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          RegistryPath = '\Software\ShopUchet\DiscountCard\grRelClients'
          object dxDBGridMaskColumn1: TdxDBGridMaskColumn
            Alignment = taLeftJustify
            Caption = #1057#1074#1103#1079#1072#1085#1085#1099#1077' '#1082#1083#1080#1077#1085#1090#1099
            HeaderAlignment = taCenter
            Sorted = csUp
            Width = 150
            BandIndex = 0
            RowIndex = 0
            HeaderMaxLineCount = 2
            FieldName = 'CLIENT_NAME'
          end
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 177
      Width = 246
      Height = 8
      HotZoneClassName = 'TcxSimpleStyle'
      HotZone.SizePercent = 32
      AlignSplitter = salBottom
      AutoPosition = False
      PositionAfterOpen = 150
      AutoSnap = True
      ResizeUpdate = True
      Control = Panel3
      Color = clBtnFace
      ParentColor = False
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    Bars = <
      item
        AllowClose = False
        AllowCustomizing = False
        AllowQuickCustomizing = False
        Caption = 'Main'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 271
        FloatTop = 138
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = dxBarStaticRecCnt
            Visible = True
          end
          item
            Item = dxBarButtonRefresh
            Visible = True
          end
          item
            Item = dxBarButtonEnableAutoRefresh
            Visible = True
          end
          item
            BeginGroup = True
            Visible = True
          end
          item
            Item = dxBarSpinEditHeaderHeight
            UserDefine = [udWidth]
            UserWidth = 23
            Visible = True
          end
          item
            BeginGroup = True
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButtonView
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButtonIns
            Visible = True
          end
          item
            Item = dxBarButtonUpd
            Visible = True
          end
          item
            Item = dxBarButtonDel
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButtonClose
            Visible = True
          end>
        Name = 'Main'
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      26
      0)
  end
  inherited alChild: TActionList
    object aAddClient: TAction
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
      ImageIndex = 62
      OnExecute = aAddClientExecute
    end
    object aDelClient: TAction
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
      ImageIndex = 61
      OnExecute = aDelClientExecute
    end
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_DISCONT_CARD_LIST')
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_DEL_G_DISCONT_CARD (?G_DISCONT_CARD_)')
    StoredProcName = 'G_DEL_G_DISCONT_CARD'
  end
  object spRelClients: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM LT_READ_CLIENT_DCARD_LIST(?G_CLIENT_, ?D_CARD_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 232
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsRelClients: TDataSource
    DataSet = spRelClients
    Left = 48
    Top = 232
  end
  object spNotRelClients: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM LT_READ_CLIENT_DCARD_LIST(?G_CLIENT_, ?D_CARD_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 264
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsNotRelClients: TDataSource
    DataSet = spNotRelClients
    Left = 48
    Top = 264
  end
  object spAddDelClient: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE LT_INS_DEL_CLIENT_DCARD (?MODE_, ?G_CLIENT_, ?' +
        'D_CARD_)')
    StoredProcName = 'LT_INS_DEL_CLIENT_DCARD'
    Left = 128
    Top = 120
  end
end
