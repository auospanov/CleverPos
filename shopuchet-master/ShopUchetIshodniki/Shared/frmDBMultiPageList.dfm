inherited DBMultiPageListForm: TDBMultiPageListForm
  Caption = 'DBMultiPageListForm'
  ClientHeight = 439
  ExplicitHeight = 465
  PixelsPerInch = 96
  TextHeight = 14
  inherited dxPageControl1: TcxPageControl
    Height = 413
    ExplicitHeight = 413
    ClientRectBottom = 388
    inherited ts1: TcxTabSheet
      ExplicitWidth = 743
      ExplicitHeight = 388
      inherited gr1: TcxGrid
        Height = 388
        ExplicitHeight = 388
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
          ItemName = 'dxBarButton2'
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
    object dxBarButtonUpd: TdxBarButton
      Action = aUpd
      Category = 0
    end
    object dxBarButtonDel: TdxBarButton
      Action = aDel
      Category = 0
    end
    object dxBarButton1: TdxBarButton
      Action = aInsLike
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = aHelp
      Category = 0
    end
  end
  object tranWrite: TpFIBTransaction [3]
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
  object spDel: TpFIBStoredProc [4]
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 128
    Top = 80
  end
  inherited alChild: TActionList
    object aView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100'|'#1055#1088#1086#1089#1084#1086#1090#1088' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 147
      ShortCut = 114
      OnExecute = aViewExecute
    end
    object aIns: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100'|'#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 150
      ShortCut = 45
      OnExecute = aInsExecute
    end
    object aUpd: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100'|'#1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 148
      ShortCut = 13
      OnExecute = aUpdExecute
    end
    object aDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100'|'#1059#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 149
      ShortCut = 46
      OnExecute = aDelExecute
    end
    object aInsLike: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1102
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1102'|'#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1086#1087#1080#1080' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 157
      OnExecute = aInsLikeExecute
    end
    object aHelp: TAction
      Hint = #1042#1099#1079#1086#1074' '#1089#1087#1088#1072#1074#1082#1080
      ImageIndex = 137
      OnExecute = aHelpExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  object dxEditStyleController: TcxEditStyleController
    Style.BorderStyle = ebsFlat
    Left = 336
    Top = 280
    PixelsPerInch = 96
  end
end
