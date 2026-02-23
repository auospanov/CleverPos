inherited DBListForm: TDBListForm
  Caption = 'DBListForm'
  ClientHeight = 374
  ClientWidth = 674
  ExplicitWidth = 680
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Width = 674
    Height = 348
    inherited tvMain: TcxGridDBTableView
      OnCellDblClick = tvMainCellDblClick
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
          ItemName = 'dxBarButtonView'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonIns'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonInsLike'
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
    object dxBarButtonView: TdxBarButton
      Action = aView
      Category = 0
    end
    object dxBarButtonIns: TdxBarButton
      Action = aIns
      Category = 0
    end
    object dxBarButtonInsLike: TdxBarButton
      Action = aInsLike
      Category = 0
    end
    object dxBarButtonUpd: TdxBarButton
      Action = aUpd
      Category = 0
    end
    object dxBarButtonDel: TdxBarButton
      Action = aDel
      Category = 0
    end
    object dxBarButton1: TdxBarButton
      Action = aHelp
      Category = 0
      Hint = #1042#1099#1079#1086#1074' '#1089#1087#1088#1072#1074#1082#1080
    end
  end
  inherited alChild: TActionList
    object aView: TAction [5]
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100'|'#1055#1088#1086#1089#1084#1086#1090#1088' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 147
      ShortCut = 114
      OnExecute = aViewExecute
    end
    object aIns: TAction [6]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100'|'#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 150
      ShortCut = 45
      OnExecute = aInsExecute
    end
    object aInsLike: TAction [7]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1102
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1102'|'#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1086#1087#1080#1080' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 157
      OnExecute = aInsLikeExecute
    end
    object aUpd: TAction [8]
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100'|'#1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 148
      ShortCut = 13
      OnExecute = aUpdExecute
    end
    object aDel: TAction [9]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100'|'#1059#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 149
      ShortCut = 46
      OnExecute = aDelExecute
    end
    object aHelp: TAction
      ImageIndex = 137
      OnExecute = aHelpExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    Top = 136
    PixelsPerInch = 96
  end
  inherited dxEditStyleController: TcxEditStyleController
    Left = 336
    Top = 280
    PixelsPerInch = 96
  end
  object spDel: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 168
    Top = 80
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 168
    Top = 48
  end
end
