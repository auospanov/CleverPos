inherited DBTreeListROForm: TDBTreeListROForm
  Left = 221
  Caption = 'DBTreeListROForm'
  ClientHeight = 360
  ClientWidth = 706
  ExplicitWidth = 712
  ExplicitHeight = 386
  PixelsPerInch = 96
  TextHeight = 14
  object tlMain: TcxDBTreeList [0]
    Left = 0
    Top = 26
    Width = 706
    Height = 334
    Align = alClient
    Bands = <>
    Images = MainDM.imMain
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.IncSearch = True
    PopupMenu = PopupMenu
    RootValue = -1
    Styles.IncSearch = MainDM.stIncSearchStyle
    TabOrder = 1
    OnGetNodeImageIndex = tlMainGetNodeImageIndex
    OnHotTrackNode = tlMainHotTrackNode
  end
  inherited dxBarManagerChild: TdxBarManager
    LookAndFeel.SkinName = ''
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
          ItemName = 'dxBarButtonClose'
        end>
    end
    object dxBarButtonEnableAutoRefresh: TdxBarButton
      Action = aEnableAutoRefresh
      Category = 0
      ImageIndex = 139
    end
    object dxBarStaticRecCnt: TdxBarStatic
      Caption = '0000'
      Category = 0
      Hint = '0000'
      Visible = ivAlways
      BorderStyle = sbsEtched
    end
    object dxBarButtonClose: TdxBarButton
      Action = aClose
      Category = 0
    end
    object dxBarButtonRefresh: TdxBarButton
      Action = aRefresh
      Category = 0
      ImageIndex = 138
    end
  end
  inherited alChild: TActionList
    object aEnableAutoRefresh: TAction
      Caption = #1040#1074#1090#1086#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100'/'#1074#1099#1082#1083#1102#1095#1080#1090#1100' '#1072#1074#1090#1086#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 90
      OnExecute = aEnableAutoRefreshExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100'|'#1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 22
      ShortCut = 116
      OnExecute = aRefreshExecute
    end
    object aClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100'|'#1047#1072#1082#1088#1099#1090#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' ('#1072#1082#1090#1080#1074#1085#1086#1075#1086') '#1086#1082#1085#1072
      ImageIndex = 43
      ShortCut = 16499
      OnExecute = aCloseExecute
    end
    object aExpand: TAction
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1105
      Hint = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1105
      ImageIndex = 87
      OnExecute = aExpandExecute
    end
    object aCollapse: TAction
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1105
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1105
      ImageIndex = 88
      OnExecute = aCollapseExecute
    end
    object aCustomizeColumns: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
      OnExecute = aCustomizeColumnsExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  object tAutoRefresh: TTimer
    Enabled = False
    OnTimer = tAutoRefreshTimer
    Left = 80
    Top = 112
  end
  object PopupMenu: TPopupMenu
    Left = 80
    Top = 144
    object N1: TMenuItem
      Action = aExpand
    end
    object N2: TMenuItem
      Action = aCollapse
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = aCustomizeColumns
    end
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
  object spRead: TpFIBDataSet
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 80
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsRead: TDataSource
    DataSet = spRead
    Left = 48
    Top = 80
  end
end
