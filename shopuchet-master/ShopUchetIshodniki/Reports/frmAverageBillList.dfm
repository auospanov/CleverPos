inherited AverageBillListForm: TAverageBillListForm
  Caption = #1057#1088#1077#1076#1085#1080#1081' '#1095#1077#1082
  ClientHeight = 479
  ClientWidth = 776
  ExplicitWidth = 782
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Left = 553
    Width = 223
    Height = 453
    ExplicitLeft = 553
    ExplicitWidth = 223
    ExplicitHeight = 453
  end
  object pnlChart: TPanel [1]
    Left = 0
    Top = 26
    Width = 545
    Height = 453
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 5
    object dbchAverageBill: TDBChart
      Left = 0
      Top = 41
      Width = 545
      Height = 158
      AllowPanning = pmNone
      Gradient.EndColor = clWhite
      Gradient.Visible = True
      Title.Font.Color = clBlack
      Title.Text.Strings = (
        #1044#1080#1085#1072#1084#1080#1082#1072' '#1057#1063' '#1087#1086' '#1076#1085#1103#1084)
      Panning.MouseWheel = pmwNone
      View3D = False
      Align = alClient
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        37
        15
        37)
      ColorPaletteIndex = 0
      object lnsrsSeries1: TLineSeries
        Marks.Visible = True
        Marks.DrawEvery = 2
        DataSource = spRead
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.DateTime = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        XValues.ValueSource = 'Z_DATE'
        YValues.Name = 'Y'
        YValues.Order = loNone
        YValues.ValueSource = 'SUMM'
      end
    end
    object dbchBillsCount: TDBChart
      Left = 0
      Top = 248
      Width = 545
      Height = 205
      Gradient.EndColor = clWhite
      Gradient.Visible = True
      Title.Color = 16645629
      Title.Font.Color = clBlack
      Title.Text.Strings = (
        #1044#1080#1085#1072#1084#1080#1082#1072' '#1082#1086#1083'-'#1074#1072' '#1095#1077#1082#1086#1074' '#1087#1086' '#1076#1085#1103#1084)
      View3D = False
      Align = alBottom
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 1
      object brsrsSeries2: TBarSeries
        DataSource = spBillsCount
        XValues.DateTime = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        XValues.ValueSource = 'Z_DATE'
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'CNT'
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 240
      Width = 8
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
      Control = dbchBillsCount
      Color = clBtnFace
      ParentColor = False
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 545
      Height = 41
      Align = alTop
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 3
      object lbAverageBill: TLabel
        Left = 14
        Top = 11
        Width = 117
        Height = 21
        Caption = #1057#1088#1077#1076#1085#1080#1081' '#1095#1077#1082':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 207
      Width = 545
      Height = 41
      Align = alBottom
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 4
      object lbBillsCount: TLabel
        Left = 14
        Top = 11
        Width = 112
        Height = 21
        Caption = #1042#1089#1077#1075#1086' '#1095#1077#1082#1086#1074':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlRight: TPanel [2]
    Left = 553
    Top = 26
    Width = 223
    Height = 453
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object splMenu: TcxSplitter
      Left = 0
      Top = 313
      Width = 8
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
      Control = grBillsCount
      Color = clBtnFace
      ParentColor = False
    end
    object grBillsCount: TcxGrid
      Left = 0
      Top = 321
      Width = 223
      Height = 132
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      object tvBillsCount: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsBillsCount
        DataController.KeyFieldNames = 'ZAKAZ_DETAILS'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        Styles.Inactive = MainDM.stGridSelectedRow
        object clmBillsCountZ_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'Z_DATE'
          HeaderAlignmentHorz = taCenter
        end
        object clmBillsCountCNT: TcxGridDBColumn
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          DataBinding.FieldName = 'CNT'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 114
        end
      end
      object lv1: TcxGridLevel
        GridView = tvBillsCount
      end
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 29
      Width = 223
      Height = 255
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 2
      LookAndFeel.Kind = lfFlat
      object tvAverageBill: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsRead
        DataController.KeyFieldNames = 'ZAKAZ_DETAILS'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        Styles.Inactive = MainDM.stGridSelectedRow
        object clmAverageBillZ_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'Z_DATE'
          HeaderAlignmentHorz = taCenter
        end
        object clmAverageBillSUMM: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMM'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 143
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = tvAverageBill
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 292
      Width = 223
      Height = 29
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 3
      object Label3: TLabel
        Left = 7
        Top = 7
        Width = 170
        Height = 14
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1095#1077#1082#1086#1074' '#1087#1086' '#1076#1085#1103#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 223
      Height = 29
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 4
      object Label1: TLabel
        Left = 7
        Top = 7
        Width = 136
        Height = 14
        Caption = #1057#1088#1077#1076#1085#1080#1081' '#1095#1077#1082' '#1087#1086' '#1076#1085#1103#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object cxSplitter2: TcxSplitter [3]
    Left = 545
    Top = 26
    Width = 8
    Height = 453
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
    Control = pnlChart
    Color = clBtnFace
    ParentColor = False
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
          BeginGroup = True
          Visible = True
          ItemName = 'dcBeginDate'
        end
        item
          Visible = True
          ItemName = 'dcEndDate'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxbrbtn1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
    object dcBeginDate: TdxBarDateCombo
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072
      Category = 0
      Hint = #1053#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072
      Visible = ivAlways
      OnChange = dcBeginDateChange
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
    object dcEndDate: TdxBarDateCombo
      Caption = #1050#1086#1085#1077#1094
      Category = 0
      Hint = #1050#1086#1085#1077#1094
      Visible = ivAlways
      OnChange = dcBeginDateChange
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
    object dxbrbtn1: TdxBarButton
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
      
        'SELECT Z.Z_DATE, (SELECT SUM(ZZ.SUMM_FACT) FROM ZAKAZ ZZ WHERE Z' +
        'Z.Z_DATE = Z.Z_DATE) / (SELECT COUNT(ZZZ.ZAKAZ) FROM ZAKAZ ZZZ W' +
        'HERE ZZZ.Z_DATE = Z.Z_DATE) SUMM'
      'FROM ZAKAZ Z'
      'WHERE Z.Z_DATE BETWEEN :DATE_BEGIN_ AND :DATE_END_'
      'AND Z.G_TOCHKA = :G_TOCHKA_'
      'GROUP BY Z.Z_DATE'
      'ORDER BY Z.Z_DATE')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object spBillsCount: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT Z.Z_DATE, (SELECT COUNT(ZZZ.ZAKAZ) FROM ZAKAZ ZZZ WHERE Z' +
        'ZZ.Z_DATE = Z.Z_DATE AND ZZZ.G_TOCHKA = :G_TOCHKA_) CNT'
      'FROM ZAKAZ Z'
      'WHERE Z.Z_DATE BETWEEN :DATE_BEGIN_ AND :DATE_END_'
      'AND Z.G_TOCHKA = :G_TOCHKA_'
      'GROUP BY Z.Z_DATE'
      'ORDER BY Z.Z_DATE')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 232
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsBillsCount: TDataSource
    DataSet = spBillsCount
    Left = 48
    Top = 232
  end
  object spRepAvBill: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE P_REP_AVERAGE_BILL (?DATE_BEGIN_, ?DATE_END_, ' +
        '?G_TOCHKA_ARR_)')
    StoredProcName = 'P_REP_AVERAGE_BILL'
    Left = 100
    Top = 232
  end
end
