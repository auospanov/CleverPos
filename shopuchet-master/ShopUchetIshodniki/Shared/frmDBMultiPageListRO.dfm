inherited DBMultiPageListROForm: TDBMultiPageListROForm
  Caption = 'DBMultiPageListROForm'
  ClientHeight = 360
  ClientWidth = 743
  OnCreate = FormCreate
  ExplicitWidth = 749
  ExplicitHeight = 386
  PixelsPerInch = 96
  TextHeight = 14
  object dxPageControl1: TcxPageControl [0]
    Left = 0
    Top = 26
    Width = 743
    Height = 334
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = ts1
    Properties.CustomButtons.Buttons = <>
    Properties.TabPosition = tpBottom
    ClientRectBottom = 309
    ClientRectRight = 743
    ClientRectTop = 0
    object ts1: TcxTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'ts1'
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gr1: TcxGrid
        Left = 0
        Top = 0
        Width = 743
        Height = 309
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object tvMain: TcxGridDBTableView
          PopupMenu = pmGrid
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsRead
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsSelection.CellSelect = False
          Styles.Inactive = MainDM.stGridSelectedRow
          Styles.IncSearch = MainDM.stIncSearchStyle
        end
        object lvMain: TcxGridLevel
          GridView = tvMain
        end
      end
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    Categories.Strings = (
      #1054#1073#1097#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1041#1044)
    ImageOptions.DisabledImages = MainDM.imMainDisabled
    LookAndFeel.SkinName = ''
    ShowShortCutInHint = True
    Top = 120
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
          ItemName = 'dxBarButtonEnableAutoSize'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 25
          Visible = True
          ItemName = 'dxBarSpinEditHeaderHeight'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
    inherited dxBarButtonEnableAutoSize: TdxBarButton
      ImageIndex = 160
    end
    object dxBarButtonEnableAutoRefresh: TdxBarButton
      Action = aEnableAutoRefresh
      Category = 0
      ButtonStyle = bsChecked
    end
    object dxBarSpinEditHeaderHeight: TdxBarSpinEdit
      Caption = #1042#1099#1089#1086#1090#1072' '#1079#1072#1075#1086#1083#1086#1074#1082#1072
      Category = 0
      Hint = #1042#1099#1089#1086#1090#1072' '#1079#1072#1075#1086#1083#1086#1074#1082#1072
      Visible = ivAlways
      OnCurChange = dxBarSpinEditHeaderHeightCurChange
      OnKeyPress = dxBarSpinEditHeaderHeightKeyPress
      ImageIndex = 99
      MaxValue = 3.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      OnButtonClick = dxBarSpinEditHeaderHeightButtonClick
    end
    object dxBarStaticRecCnt: TdxBarStatic
      Caption = '00000'
      Category = 0
      Hint = '00000'
      Visible = ivAlways
      Alignment = taRightJustify
      BorderStyle = sbsEtched
    end
    object dxBarButtonRefresh: TdxBarButton
      Action = aRefresh
      Category = 0
    end
    object dxBarButtonClose: TdxBarButton
      Action = aClose
      Category = 0
    end
  end
  inherited dxBarPopupMenuChild: TdxBarPopupMenu
    Top = 152
  end
  inherited alChild: TActionList
    Top = 120
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100'|'#1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 138
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100'|'#1047#1072#1082#1088#1099#1090#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' ('#1072#1082#1090#1080#1074#1085#1086#1075#1086') '#1086#1082#1085#1072
      ImageIndex = 140
      ShortCut = 16499
      OnExecute = aCloseExecute
    end
    object aCustomizeColumns: TAction
      Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
      OnExecute = aCustomizeColumnsExecute
    end
    object aSaveAllToXLS: TAction
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1077
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1077
      OnExecute = aSaveAllToXLSExecute
    end
    object aSaveSelectedToXLS: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' &'#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      OnExecute = aSaveSelectedToXLSExecute
    end
    object aEnableAutoRefresh: TAction
      Caption = #1040#1074#1090#1086#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100'/'#1074#1099#1082#1083#1102#1095#1080#1090#1100' '#1072#1074#1090#1086#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 139
      OnExecute = aEnableAutoRefreshExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  object dsRead: TDataSource
    DataSet = spRead
    Left = 48
    Top = 80
  end
  object pmGrid: TPopupMenu
    Left = 16
    Top = 192
    object pmCustomizeColumns: TMenuItem
      Action = aCustomizeColumns
    end
    object pmDivider1: TMenuItem
      Caption = '-'
    end
    object pmSaveAllToXLS: TMenuItem
      Action = aSaveAllToXLS
    end
    object pmSaveSelectedToXLS: TMenuItem
      Action = aSaveSelectedToXLS
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = '*.xls'
    Filter = #1060#1072#1081#1083#1099' Microsoft Excel (*.xls)|*.xls|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = #1042#1099#1073#1086#1088' '#1080#1084#1077#1085#1080' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
    Left = 48
    Top = 192
  end
  object tAutoRefresh: TTimer
    Enabled = False
    OnTimer = tAutoRefreshTimer
    Left = 80
    Top = 120
  end
  object spRead: TpFIBDataSet
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 80
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 16
    Top = 48
  end
  object cxEditRepository: TcxEditRepository
    Left = 248
    Top = 122
    object riEditRepositoryCurrencyItem1: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 2
      Properties.DisplayFormat = ',0.00'
    end
    object riEditRepositoryCurrencyItem: TcxEditRepositoryCalcItem
      Properties.DisplayFormat = ',0.00'
    end
  end
end
