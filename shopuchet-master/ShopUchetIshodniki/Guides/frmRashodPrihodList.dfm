inherited RashodPrihodListForm: TRashodPrihodListForm
  Left = 519
  Top = 227
  Caption = #1057#1090#1072#1090#1100#1080' '#1088#1072#1089#1093#1086#1076#1072'/'#1087#1088#1080#1093#1086#1076#1072
  ExplicitWidth = 816
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    inherited tvMain: TcxGridDBTableView
      DataController.KeyFieldNames = 'G_PRIHOD_RASHOD'
      object clmMainG_PRIHOD_RASHOD: TcxGridDBColumn
        DataBinding.FieldName = 'G_PRIHOD_RASHOD'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainDO_ACTION: TcxGridDBColumn
        Caption = #1055#1088#1080#1093#1086#1076'/'#1056#1072#1089#1093#1086#1076
        DataBinding.FieldName = 'DO_ACTION'
        HeaderAlignmentHorz = taCenter
        Width = 148
      end
      object clmMainNAME: TcxGridDBColumn
        Caption = #1057#1090#1072#1090#1100#1103
        DataBinding.FieldName = 'NAME'
        HeaderAlignmentHorz = taCenter
        Width = 232
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
          UserDefine = [udWidth]
          UserWidth = 23
          Visible = True
          ItemName = 'dxBarSpinEditHeaderHeight'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarCombo'
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
    object dxBarCombo: TdxBarCombo
      Caption = #1060#1080#1083#1100#1090#1088
      Category = 0
      Hint = #1060#1080#1083#1100#1090#1088
      Visible = ivAlways
      OnChange = dxBarComboChange
      Text = #1042#1089#1077
      Items.Strings = (
        #1055#1088#1080#1093#1086#1076
        #1056#1072#1089#1093#1086#1076
        #1042#1089#1077)
      ItemIndex = 2
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_PRIHOD_RASHOD_LIST(?ACTION_)')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_DEL_G_PRIHOD_RASHOD (?G_PRIHOD_RASHOD_)')
    StoredProcName = 'G_DEL_G_PRIHOD_RASHOD'
  end
end
