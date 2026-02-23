inherited RevisionListForm: TRevisionListForm
  Left = 534
  Top = 192
  Caption = #1057#1087#1080#1089#1086#1082' '#1088#1077#1074#1080#1079#1080#1081' '#1087#1086' '#1076#1072#1090#1072#1084
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Height = 179
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitHeight = 179
    inherited tvMain: TcxGridDBTableView
      OnFocusedRecordChanged = tvMainFocusedRecordChanged
      OptionsCustomize.ColumnFiltering = False
      OptionsView.GroupByBox = False
      object tvMainREVISION_PARENT: TcxGridDBColumn
        DataBinding.FieldName = 'REVISION_PARENT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object tvMainDATE_BEGIN: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072
        DataBinding.FieldName = 'DATE_BEGIN'
        HeaderAlignmentHorz = taCenter
        Width = 143
      end
      object tvMainDATE_END: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1082#1086#1085#1094#1072
        DataBinding.FieldName = 'DATE_END'
        HeaderAlignmentHorz = taCenter
        Width = 140
      end
      object tvMainNOTE: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        DataBinding.FieldName = 'NOTE'
        HeaderAlignmentHorz = taCenter
        Width = 149
      end
      object tvMainG_TOCHKA: TcxGridDBColumn
        DataBinding.FieldName = 'G_TOCHKA'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmMainIS_MADE: TcxGridDBColumn
        Caption = #1047#1072#1074#1077#1088#1096#1077#1085#1072
        DataBinding.FieldName = 'IS_MADE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayChecked = '1'
        Properties.DisplayUnchecked = '0'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
    end
  end
  object splSaleMenu: TcxSplitter [1]
    Left = 0
    Top = 205
    Width = 674
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
    Control = grRevisionDetails
    Color = clBtnFace
    ParentColor = False
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 213
    Width = 674
    Height = 29
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 6
    object txtDetailsCount: TStaticText
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
  object grRevisionDetails: TcxGrid [3]
    Left = 0
    Top = 242
    Width = 674
    Height = 132
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    TabOrder = 7
    LookAndFeel.Kind = lfFlat
    object tvDetails: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsRevisionDetails
      DataController.KeyFieldNames = 'Revision'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      Styles.Inactive = MainDM.stGridSelectedRow
      object clmDetailsNAME: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'NAME'
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsBARCODE: TcxGridDBColumn
        Caption = #1064#1090#1088#1080#1093#1082#1086#1076
        DataBinding.FieldName = 'BARCODE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsARTICUL: TcxGridDBColumn
        Caption = #1040#1088#1090#1080#1082#1091#1083
        DataBinding.FieldName = 'ARTICUL'
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsREVISION: TcxGridDBColumn
        DataBinding.FieldName = 'REVISION'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsSKLAD: TcxGridDBColumn
        DataBinding.FieldName = 'SKLAD'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsAMOUNT_BD: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1082#1080' '#1074' '#1073#1072#1079#1077
        DataBinding.FieldName = 'AMOUNT_BD'
        PropertiesClassName = 'TcxCalcEditProperties'
        RepositoryItem = riEditRepositoryCurrencyItem
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsAMOUNT_REAL: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1082#1080' '#1092#1072#1082#1090'.'
        DataBinding.FieldName = 'AMOUNT_REAL'
        PropertiesClassName = 'TcxCalcEditProperties'
        RepositoryItem = riEditRepositoryCurrencyItem
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsColumn1: TcxGridDBColumn
        Caption = #1052#1077#1089#1090#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
        DataBinding.FieldName = 'PLACE'
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsColumn2: TcxGridDBColumn
        Caption = #1041#1088#1077#1085#1076
        DataBinding.FieldName = 'BRAND'
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
      object clmDetailsColumn3: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1088#1086#1079#1085'.'
        DataBinding.FieldName = 'PRICE'
        PropertiesClassName = 'TcxCalcEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 115
      end
    end
    object lv1: TcxGridLevel
      GridView = tvDetails
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
          ItemName = 'dcBegin'
        end
        item
          Visible = True
          ItemName = 'dcEnd'
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
          ItemName = 'btn1'
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
    object dcBegin: TdxBarDateCombo
      Caption = #1053#1072#1095#1072#1083#1086
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
    object btn1: TdxBarButton
      Action = aPrint
      Category = 0
    end
  end
  inherited alChild: TActionList
    object aPrint: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      ImageIndex = 146
      OnExecute = aPrintExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT * FROM REVISION_PARENT_READ(?DATE_BEGIN_, ?DATE_END_, ?G_' +
        'TOCHKA_)')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE REVISION_PARENT_DEL (?REVISION_PARENT_, ?REVIS' +
        'ION_)')
    StoredProcName = 'REVISION_PARENT_DEL'
  end
  object spRevisionDetails: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT REVISION, SKLAD, AMOUNT_BD, AMOUNT_REAL, G.NAME, G.BARCOD' +
        'E, G.ARTICUL, G.BRAND, G.PLACE, G.PRICE'
      'FROM REVISION R, G_PRODUCT G'
      'WHERE R.REVISION_PARENT = :REVISION_PARENT_'
      'AND R.G_PRODUCT = G.G_PRODUCT')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 24
    Top = 272
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsRevisionDetails: TDataSource
    DataSet = spRevisionDetails
    Left = 56
    Top = 272
  end
end
