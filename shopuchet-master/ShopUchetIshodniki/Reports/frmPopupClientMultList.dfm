inherited PopupClientMultListForm: TPopupClientMultListForm
  Caption = #1055#1086#1080#1089#1082' '#1082#1083#1080#1077#1085#1090#1072
  ClientHeight = 288
  ClientWidth = 462
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 470
  ExplicitHeight = 316
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 462
    Height = 288
    ExplicitWidth = 462
    ExplicitHeight = 288
    inherited pnlTop: TPanel
      Width = 462
      ExplicitWidth = 462
      object Label10: TLabel [0]
        Left = 58
        Top = 3
        Width = 40
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086#1080#1089#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object sbClear: TSpeedButton [1]
        Left = 367
        Top = 1
        Width = 26
        Height = 22
        Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1080#1089#1082
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
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
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF000000FF000000
          FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF000000FF000000
          FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = sbClearClick
      end
      inherited btnRefresh: TBitBtn
        Left = 709
        Top = 8
        TabOrder = 4
        ExplicitLeft = 709
        ExplicitTop = 8
      end
      inherited btnIns: TBitBtn
        Left = 710
        ExplicitLeft = 710
      end
      inherited btnInsLike: TBitBtn
        Left = 739
        ExplicitLeft = 739
      end
      object edBarcode: TEdit
        Left = 104
        Top = 1
        Width = 259
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        CharCase = ecLowerCase
        MaxLength = 250
        TabOrder = 0
        OnChange = edBarcodeChange
        OnKeyDown = edBarcodeKeyDown
      end
    end
    inherited pnlBottom: TPanel
      Top = 258
      Width = 462
      ExplicitTop = 258
      ExplicitWidth = 462
      inherited btnCancel: TBitBtn
        Left = 382
        ExplicitLeft = 382
      end
      inherited btnOK: TBitBtn
        Left = 302
        ExplicitLeft = 302
      end
    end
    inherited dxPageControl: TcxPageControl
      Width = 462
      Height = 233
      LookAndFeel.Kind = lfFlat
      OnChange = dxPageControlChange
      ExplicitWidth = 462
      ExplicitHeight = 233
      ClientRectBottom = 211
      ClientRectLeft = 1
      ClientRectRight = 461
      ClientRectTop = 1
      inherited ts1: TcxTabSheet
        Caption = #1050#1083#1080#1077#1085#1090#1099
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 460
        ExplicitHeight = 210
        inherited gr1: TcxGrid
          Width = 460
          Height = 210
          ExplicitWidth = 460
          ExplicitHeight = 210
          inherited tvMain: TcxGridDBTableView
            Styles.Inactive = MainDM.stGridSelectedRow
            object tvMainID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
            end
            object tvMainNAME: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              DataBinding.FieldName = 'NAME'
              Width = 251
            end
            object tvMainPHONE: TcxGridDBColumn
              Caption = #1058#1077#1083#1077#1092#1086#1085
              DataBinding.FieldName = 'PHONE'
              HeaderAlignmentHorz = taCenter
              Width = 150
            end
            object tvMainNOTE: TcxGridDBColumn
              Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
              DataBinding.FieldName = 'NOTE'
              HeaderAlignmentHorz = taCenter
              Width = 150
            end
          end
        end
      end
      object tsGroups: TcxTabSheet
        Caption = #1043#1088#1091#1087#1087#1099' '#1082#1083#1080#1077#1085#1090#1086#1074
        ImageIndex = 1
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object tlClientCategory: TcxDBTreeList
          Left = 0
          Top = 0
          Width = 460
          Height = 210
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Bands = <
            item
            end>
          DataController.DataSource = dsGroups
          DataController.ParentField = 'G_CLIENT_PARENT'
          DataController.KeyField = 'ID'
          LookAndFeel.Kind = lfFlat
          Navigator.Buttons.CustomButtons = <>
          OptionsBehavior.Sorting = False
          OptionsSelection.CellSelect = False
          RootValue = -1
          Styles.Inactive = MainDM.stGridSelectedRow
          TabOrder = 0
          OnDblClick = tlClientCategoryDblClick
          OnKeyDown = tlClientCategoryKeyDown
          object clmn1: TcxDBTreeListColumn
            Caption.Text = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'NAME'
            Width = 300
            Position.ColIndex = 0
            Position.RowIndex = 0
            Position.BandIndex = 0
            Summary.FooterSummaryItems = <>
            Summary.GroupFooterSummaryItems = <>
          end
          object clmnClientCategorycxId: TcxDBTreeListColumn
            Visible = False
            DataBinding.FieldName = 'ID'
            Width = 50
            Position.ColIndex = 1
            Position.RowIndex = 0
            Position.BandIndex = 0
            Summary.FooterSummaryItems = <>
            Summary.GroupFooterSummaryItems = <>
          end
        end
      end
    end
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT G_CLIENT ID, NAME, PHONE, NOTE'
      'FROM G_CLIENT '
      'WHERE IS_CATEGORY = 0 '
      'AND IS_SUPPLIER = :Is_supplier_'
      'order by name')
  end
  object spGroups: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT 1 row, -1 ID, null G_CLIENT_PARENT, '#39#1041#1077#1079' '#1075#1088#1091#1087#1087#1099#39' NAME'
      '   from rdb$database'
      'union all'
      'select 2 row, G_CLIENT ID, G_CLIENT_PARENT, NAME'
      'from G_CLIENT t'
      'where T.IS_CATEGORY = 1'
      'AND IS_SUPPLIER = :Is_supplier_'
      'order by 1, 4')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 176
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsGroups: TDataSource
    DataSet = spGroups
    Left = 48
    Top = 176
  end
  object TimerChangeEd: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerChangeEdTimer
    Left = 352
    Top = 152
  end
end
