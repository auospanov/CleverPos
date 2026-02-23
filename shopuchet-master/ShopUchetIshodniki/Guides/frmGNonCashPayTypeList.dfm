inherited GNonCashPayTypeListForm: TGNonCashPayTypeListForm
  Left = 534
  Top = 192
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1073#1077#1079#1085#1072#1083#1080#1095#1085#1099#1093' '#1086#1087#1083#1072#1090
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    inherited tvMain: TcxGridDBTableView
      OptionsCustomize.ColumnFiltering = False
      OptionsSelection.MultiSelect = True
      OptionsView.GroupByBox = False
      object clmMainG_NONCASH_PAY_TYPE: TcxGridDBColumn
        DataBinding.FieldName = 'G_NONCASH_PAY_TYPE'
        Visible = False
        Width = 120
      end
      object clmMainNAME: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'NAME'
        HeaderAlignmentHorz = taCenter
        Width = 247
      end
      object clmMainIS_ACTIVE: TcxGridDBColumn
        Caption = #1040#1082#1090#1080#1074#1077#1085
        DataBinding.FieldName = 'IS_ACTIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayChecked = '1'
        Properties.DisplayUnchecked = '0'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainPOS_TERMINAL_TYPE: TcxGridDBColumn
        Caption = #1058#1077#1088#1084#1080#1085#1072#1083
        DataBinding.FieldName = 'POS_TERMINAL_TYPE'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'TypeTerminal'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsTerminal
        HeaderAlignmentHorz = taCenter
        Width = 125
      end
      object clmMainIS_TIS_TYPE: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099' '#1058#1048#1057
        DataBinding.FieldName = 'IS_TIS_TYPE'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsTIS
        HeaderAlignmentHorz = taCenter
        Width = 125
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
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_NONCASH_PAY_TYPE_READ')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_NONCASH_PAY_TYPE_DEL (?G_NONCASH_PAY_TYPE_)')
    StoredProcName = 'G_NONCASH_PAY_TYPE_DEL'
  end
  object dsTIS: TDataSource
    DataSet = MainDM.dxMemDataTIS
    Left = 472
    Top = 160
  end
  object dsTerminal: TDataSource
    DataSet = mdPosTerminal
    Left = 440
    Top = 112
  end
  object mdPosTerminal: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F03000000040000000C000300494400140000000100
      03004950000400000003000D00547970655465726D696E616C00}
    SortOptions = []
    Left = 397
    Top = 115
    object atncfldMemDataPosTerminalID: TAutoIncField
      FieldName = 'ID'
    end
    object strngfldMemDataPosTerminalIP: TStringField
      FieldName = 'IP'
    end
    object mdMemDataPosTerminalTypeTerminal: TIntegerField
      FieldName = 'TypeTerminal'
    end
    object strngfldPosTerminalName: TStringField
      FieldName = 'Name'
    end
  end
end
