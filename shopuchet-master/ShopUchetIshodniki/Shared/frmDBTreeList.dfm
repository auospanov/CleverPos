inherited DBTreeListForm: TDBTreeListForm
  Caption = 'DBTreeListForm'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 14
  inherited tlMain: TcxDBTreeList
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
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
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonEnableAutoSize'
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
          ItemName = 'dxBarButtonInsChild'
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
          ItemName = 'dxBarButtonClose'
        end>
    end
    inherited dxBarButtonEnableAutoSize: TdxBarButton
      ImageIndex = 165
    end
    inherited dxBarButtonClose: TdxBarButton
      ImageIndex = 140
    end
    object dxBarButtonView: TdxBarButton
      Action = aView
      Category = 0
      ImageIndex = 147
    end
    object dxBarButtonIns: TdxBarButton
      Action = aIns
      Category = 0
      ImageIndex = 150
    end
    object dxBarButtonInsLike: TdxBarButton
      Action = aInsLike
      Category = 0
      ImageIndex = 157
    end
    object dxBarButtonInsChild: TdxBarButton
      Action = aInsChild
      Category = 0
      ImageIndex = 158
    end
    object dxBarButtonUpd: TdxBarButton
      Action = aUpd
      Category = 0
      ImageIndex = 148
    end
    object dxBarButtonDel: TdxBarButton
      Action = aDel
      Category = 0
      ImageIndex = 149
    end
  end
  inherited alChild: TActionList
    inherited aCustomizeColumns: TAction
      ImageIndex = 8
    end
    object aView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100'|'#1055#1088#1086#1089#1084#1086#1090#1088' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 39
      ShortCut = 114
      OnExecute = aViewExecute
    end
    object aIns: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100'|'#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 40
      ShortCut = 45
      OnExecute = aInsExecute
    end
    object aInsLike: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1102
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1102'|'#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1086#1087#1080#1080' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 97
      OnExecute = aInsLikeExecute
    end
    object aInsChild: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1086#1095#1077#1088#1085#1102#1102
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1086#1095#1077#1088#1085#1102#1102
      ImageIndex = 98
      OnExecute = aInsChildExecute
    end
    object aUpd: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100'|'#1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 41
      ShortCut = 13
      OnExecute = aUpdExecute
    end
    object aDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100'|'#1059#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 42
      ShortCut = 46
      OnExecute = aDelExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited PopupMenu: TPopupMenu
    Images = MainDM.imMain
    object N10: TMenuItem [3]
      Action = aView
    end
    object N6: TMenuItem [4]
      Action = aIns
    end
    object N7: TMenuItem [5]
      Action = aInsLike
    end
    object N8: TMenuItem [6]
      Action = aInsChild
    end
    object N9: TMenuItem [7]
      Action = aUpd
    end
    object N11: TMenuItem [8]
      Action = aDel
    end
    object N5: TMenuItem [9]
      Caption = '-'
    end
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 128
    Top = 48
  end
  object spDel: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 128
    Top = 80
  end
end
