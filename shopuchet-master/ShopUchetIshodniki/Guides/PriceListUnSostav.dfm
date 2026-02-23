inherited PriceListUnSostavForm: TPriceListUnSostavForm
  Left = 582
  Top = 247
  Caption = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1072' '#1076#1083#1103' '#1082#1086#1084#1087#1083#1077#1082#1090#1072
  ClientHeight = 494
  ClientWidth = 653
  Position = poMainFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 659
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 637
    Height = 449
    ExplicitWidth = 637
    ExplicitHeight = 449
    object cxspltrMenu: TcxSplitter
      Left = 196
      Top = 37
      Width = 8
      Height = 313
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      HotZoneClassName = 'TcxSimpleStyle'
      HotZone.SizePercent = 32
      AutoPosition = False
      PositionAfterOpen = 150
      AutoSnap = True
      ResizeUpdate = True
      Control = tlCategory
      Color = clBtnFace
      ParentColor = False
    end
    object pn1: TPanel
      Left = 2
      Top = 350
      Width = 633
      Height = 97
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      TabOrder = 4
      object Shape1: TShape
        Left = 350
        Top = 9
        Width = 137
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shp5: TShape
        Left = 7
        Top = 59
        Width = 161
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shp3: TShape
        Left = 7
        Top = 34
        Width = 161
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shp1: TShape
        Left = 7
        Top = 9
        Width = 161
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lb1: TLabel
        Left = 17
        Top = 15
        Width = 67
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp2: TShape
        Left = 167
        Top = 9
        Width = 167
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object lb2: TLabel
        Left = 17
        Top = 40
        Width = 139
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086' '#1094#1077#1085#1077' '#1079#1072' 1 '#1077#1076'. ('#1088#1086#1079#1085'.)'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp4: TShape
        Left = 167
        Top = 34
        Width = 167
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object lb3: TLabel
        Left = 17
        Top = 65
        Width = 129
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086' '#1094#1077#1085#1077' '#1079#1072' 1 '#1077#1076'. ('#1086#1087#1090')'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp6: TShape
        Left = 167
        Top = 59
        Width = 167
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object Label1: TLabel
        Left = 360
        Top = 15
        Width = 118
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1050#1086#1083'-'#1074#1086' '#1074' '#1091#1087'. / '#1086#1073#1098#1077#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Shape2: TShape
        Left = 486
        Top = 9
        Width = 142
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object edPrice: TcxCurrencyEdit
        Left = 172
        Top = 37
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        EditValue = 0c
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Properties.MaxLength = 15
        Properties.UseLeftAlignmentOnEditing = False
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 158
      end
      object edPriceVol: TcxCurrencyEdit
        Left = 172
        Top = 63
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        EditValue = 0c
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Properties.MaxLength = 15
        Properties.UseLeftAlignmentOnEditing = False
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 0
        Width = 158
      end
      inline MyCurrencyFrameForm: TMyCurrencyFrameForm
        Left = 173
        Top = 11
        Width = 159
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Color = clWindow
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 173
        ExplicitTop = 11
        ExplicitWidth = 159
        ExplicitHeight = 22
        inherited edAmount: TEdit
          Left = 0
          Width = 135
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelInner = bvNone
          BevelOuter = bvNone
          ExplicitLeft = 0
          ExplicitWidth = 135
          ExplicitHeight = 22
        end
        inherited sbCur: TSpinButton
          Left = 137
          Top = 1
          Width = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ExplicitLeft = 137
          ExplicitTop = 1
          ExplicitWidth = 20
        end
      end
      object edVolume: TcxTextEdit
        Left = 491
        Top = 11
        Enabled = False
        Properties.Alignment.Horz = taRightJustify
        Style.StyleController = dxEditStyleController
        StyleDisabled.TextColor = clBtnText
        TabOrder = 3
        Text = #1053#1077' '#1079#1072#1076#1072#1085#1086
        Width = 134
      end
      object btnCalc: TcxButton
        Left = 376
        Top = 48
        Width = 153
        Height = 33
        Hint = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088' '#1088#1072#1089#1089#1095#1077#1090#1072' '#1094#1077#1085#1099' '#1079#1072' 1 '#1077#1076#1080#1085#1080#1094#1091
        Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
        LookAndFeel.Kind = lfFlat
        TabOrder = 4
        OnClick = btnCalcClick
      end
    end
    object Panel4: TPanel
      Left = 2
      Top = 2
      Width = 633
      Height = 35
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label10: TLabel
        Left = 8
        Top = 9
        Width = 91
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object sbClear: TSpeedButton
        Left = 325
        Top = 7
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
      object edBarcode: TEdit
        Left = 104
        Top = 7
        Width = 217
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        MaxLength = 250
        TabOrder = 0
        OnChange = edBarcodeChange
      end
    end
    object grProduct: TcxGrid
      Left = 204
      Top = 37
      Width = 431
      Height = 313
      Align = alClient
      TabOrder = 3
      LookAndFeel.Kind = lfFlat
      object tvProduct: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = tvProductCellDblClick
        OnFocusedRecordChanged = tvProductFocusedRecordChanged
        DataController.DataSource = dsRead
        DataController.KeyFieldNames = 'G_PRODUCT'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Styles.Inactive = MainDM.stGridSelectedRow
        object clmtv1NAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'NAME'
          HeaderAlignmentHorz = taCenter
          Width = 228
        end
        object clmtv1PRICE: TcxGridDBColumn
          Caption = #1062#1077#1085#1072
          DataBinding.FieldName = 'PRICE'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
      end
      object lv1: TcxGridLevel
        GridView = tvProduct
      end
    end
    object tlCategory: TcxDBTreeList
      Left = 2
      Top = 37
      Width = 194
      Height = 313
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Bands = <
        item
        end>
      DataController.DataSource = dsReadCategory
      DataController.ParentField = 'G_PRODUCT_PAR'
      DataController.KeyField = 'G_PRODUCT'
      LookAndFeel.Kind = lfFlat
      Navigator.Buttons.CustomButtons = <>
      OptionsSelection.CellSelect = False
      RootValue = -1
      Styles.Inactive = MainDM.stGridSelectedRow
      Styles.BandHeader = MainDM.stBandStyle
      Styles.ColumnHeader = MainDM.stColumnHeaderStyle
      TabOrder = 1
      OnFocusedNodeChanged = tlCategoryFocusedNodeChanged
      object clmnCategoryNAME: TcxDBTreeListColumn
        Caption.Text = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'NAME'
        Width = 200
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 488
    Top = 462
    ExplicitLeft = 488
    ExplicitTop = 462
  end
  inherited btnCancel: TcxButton
    Left = 570
    Top = 462
    ExplicitLeft = 570
    ExplicitTop = 462
  end
  object btHelp: TcxButton [3]
    Left = 8
    Top = 462
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1055#1086#1084#1086#1097#1100
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    OptionsImage.Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333336633
      3333333333333FF3333333330000333333364463333333333333388F33333333
      00003333333E66433333333333338F38F3333333000033333333E66333333333
      33338FF8F3333333000033333333333333333333333338833333333300003333
      3333446333333333333333FF3333333300003333333666433333333333333888
      F333333300003333333E66433333333333338F38F333333300003333333E6664
      3333333333338F38F3333333000033333333E6664333333333338F338F333333
      0000333333333E6664333333333338F338F3333300003333344333E666433333
      333F338F338F3333000033336664333E664333333388F338F338F33300003333
      E66644466643333338F38FFF8338F333000033333E6666666663333338F33888
      3338F3330000333333EE666666333333338FF33333383333000033333333EEEE
      E333333333388FFFFF8333330000333333333333333333333333388888333333
      0000}
    OptionsImage.NumGlyphs = 2
    TabOrder = 3
    OnClick = btnHelpClick
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object spReadCategory: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_PRODCAT_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 24
    Top = 104
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadCategory: TDataSource
    DataSet = spReadCategory
    Left = 56
    Top = 104
  end
  object dsRead: TDataSource
    DataSet = spRead
    Left = 320
    Top = 152
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 336
    Top = 403
  end
  object tmrChangeEd: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrChangeEdTimer
    Left = 352
    Top = 152
  end
  object spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT  T.G_PRODUCT, T.ARTICUL, T.BARCODE, T.NAME, T.PRICE, T.VO' +
        'LUME_PRICE, T.PLACE, T.PACK_AMOUNT'
      'FROM G_PRODUCT T WHERE T.IS_CATEGORY = 0 AND T.IS_ACTIVE = 1 '
      
        'AND T.G_PRODUCT_PAR = DECODE(CAST(:G_PRODUCT_PAR_ AS BIGINT), -1' +
        ', T.G_PRODUCT_PAR, CAST(:G_PRODUCT_PAR_ AS BIGINT))'
      'AND T.G_PRODUCT <> :EXCEPT_PROD_'
      'AND T.IS_KIT IN (0, 2)')
    FilterOptions = [foCaseInsensitive]
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 288
    Top = 152
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
