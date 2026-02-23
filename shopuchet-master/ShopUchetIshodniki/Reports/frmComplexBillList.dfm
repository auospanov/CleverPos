inherited ComplexBillListForm: TComplexBillListForm
  Caption = #1057#1088#1077#1076#1085#1077#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072' '#1074' '#1095#1077#1082#1077' ('#1057#1050#1058#1063')'
  ClientHeight = 479
  ClientWidth = 776
  ExplicitWidth = 782
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Left = 401
    Top = 233
    Width = 375
    Height = 246
    ExplicitLeft = 553
    ExplicitTop = 233
    ExplicitWidth = 223
    ExplicitHeight = 453
  end
  object cxSplitter2: TcxSplitter [1]
    Left = 393
    Top = 233
    Width = 8
    Height = 246
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
    Control = pnlLeft
    Color = clBtnFace
    ParentColor = False
    ExplicitLeft = 1
    ExplicitTop = 118
    ExplicitHeight = 358
  end
  object pnlTop: TPanel [2]
    Left = 0
    Top = 26
    Width = 776
    Height = 199
    Align = alTop
    TabOrder = 6
    object pnl1: TPanel
      Left = 1
      Top = 1
      Width = 774
      Height = 41
      Align = alTop
      BevelInner = bvLowered
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 48
      ExplicitTop = 170
      ExplicitWidth = 776
      object lbComplexBill: TLabel
        Left = 14
        Top = 11
        Width = 271
        Height = 21
        Caption = #1057#1088#1077#1076#1085#1077#1077' '#1082#1086#1083'-'#1074#1086' '#1090#1086#1074#1072#1088#1072' '#1074' '#1095#1077#1082#1077':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object dbchtAverageBill: TDBChart
      Left = 1
      Top = 42
      Width = 774
      Height = 156
      AllowPanning = pmNone
      Gradient.EndColor = clWhite
      Gradient.Visible = True
      Title.Font.Color = clBlack
      Title.Text.Strings = (
        #1044#1080#1085#1072#1084#1080#1082#1072' '#1057#1050#1058#1063' '#1087#1086' '#1076#1085#1103#1084)
      BottomAxis.Grid.DrawEvery = 3
      Panning.MouseWheel = pmwNone
      View3D = False
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = -71
      ExplicitWidth = 545
      ExplicitHeight = 158
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        37
        15
        37)
      ColorPaletteIndex = 0
      object lnsrsSeries1: TLineSeries
        Marks.Visible = True
        Marks.DrawEvery = 5
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
  end
  object splSale1: TcxSplitter [3]
    Left = 0
    Top = 225
    Width = 776
    Height = 8
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    HotZoneClassName = 'TcxSimpleStyle'
    HotZone.SizePercent = 32
    AlignSplitter = salTop
    AutoPosition = False
    PositionAfterOpen = 150
    AutoSnap = True
    ResizeUpdate = True
    Control = pnlTop
    Color = clBtnFace
    ParentColor = False
    ExplicitTop = 358
    ExplicitWidth = 8
  end
  object pnlLeft: TPanel [4]
    Left = 0
    Top = 233
    Width = 393
    Height = 246
    Align = alLeft
    TabOrder = 8
    ExplicitTop = 121
    ExplicitHeight = 358
    object pnl3: TPanel
      Left = 1
      Top = 1
      Width = 391
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 206
      ExplicitWidth = 356
      object lbBillsCount: TLabel
        Left = 14
        Top = 11
        Width = 193
        Height = 21
        Caption = #1042#1089#1077#1075#1086' '#1087#1088#1086#1076#1072#1085#1086' '#1095#1077#1082#1086#1074':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object dbchtBillsCount: TDBChart
      Left = 1
      Top = 42
      Width = 391
      Height = 203
      Gradient.EndColor = clWhite
      Gradient.Visible = True
      Title.Color = 16645629
      Title.Font.Color = clBlack
      Title.Text.Strings = (
        #1044#1080#1085#1072#1084#1080#1082#1072' '#1082#1086#1083'-'#1074#1072' '#1095#1077#1082#1086#1074' '#1087#1086' '#1076#1085#1103#1084)
      View3D = False
      Align = alClient
      TabOrder = 1
      ExplicitLeft = -20
      ExplicitTop = 1
      ExplicitWidth = 205
      ExplicitHeight = 356
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        26
        15
        26)
      ColorPaletteIndex = 1
      object brsrsSeries2: TBarSeries
        Marks.DrawEvery = 3
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
  end
  object pnl5: TPanel [5]
    Left = 401
    Top = 233
    Width = 375
    Height = 246
    Align = alClient
    TabOrder = 9
    ExplicitLeft = 432
    ExplicitTop = 320
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pnl6: TPanel
      Left = 1
      Top = 1
      Width = 373
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 9
      object lbProductsCount: TLabel
        Left = 14
        Top = 11
        Width = 214
        Height = 21
        Caption = #1042#1089#1077#1075#1086' '#1087#1088#1086#1076#1072#1085#1086' '#1090#1086#1074#1072#1088#1086#1074':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object dbchtTovsCount: TDBChart
      Left = 1
      Top = 42
      Width = 373
      Height = 203
      Gradient.EndColor = clWhite
      Gradient.Visible = True
      Title.Color = 16645629
      Title.Font.Color = clBlack
      Title.Text.Strings = (
        #1044#1080#1085#1072#1084#1080#1082#1072' '#1082#1086#1083'-'#1074#1072' '#1090#1086#1074#1072#1088#1086#1074' '#1087#1086' '#1076#1085#1103#1084)
      View3D = False
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 43
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 1
      object brsrs1: TBarSeries
        Marks.DrawEvery = 3
        DataSource = spTovsCount
        XValues.DateTime = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        XValues.ValueSource = 'Z_DATE'
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'CNT'
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
      'SELECT Z.Z_DATE,'
      
        '       SUM(ZD.AMOUNT) / (SELECT COUNT(ZZ.ZAKAZ) FROM ZAKAZ ZZ WH' +
        'ERE ZZ.Z_DATE = Z.Z_DATE) Summ'
      'FROM ZAKAZ Z, ZAKAZ_DETAILS ZD'
      'WHERE Z.Z_DATE BETWEEN :DATE_BEGIN_ AND :DATE_END_'
      'AND Z.G_TOCHKA = :G_TOCHKA_'
      'AND Z.ZAKAZ = ZD.ZAKAZ'
      'GROUP BY Z.Z_DATE'
      'ORDER BY Z.Z_DATE')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object spBillsCount: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT COUNT(*) CNT, Z_DATE'
      'FROM ZAKAZ Z'
      'WHERE Z.Z_DATE BETWEEN :DATE_BEGIN_ AND :DATE_END_'
      'AND Z.G_TOCHKA = :G_TOCHKA_'
      'GROUP BY Z.Z_DATE'
      'ORDER BY Z.Z_DATE')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 272
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spRepAvBill: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE P_REP_AVERAGE_TOVBILL (?DATE_BEGIN_, ?DATE_END' +
        '_, ?G_TOCHKA_ARR_)')
    StoredProcName = 'P_REP_AVERAGE_TOVBILL'
    Left = 132
    Top = 200
  end
  object spTovsCount: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT Z.Z_DATE, (SELECT SUM(ZD.AMOUNT) FROM ZAKAZ ZZZ, ZAKAZ_DE' +
        'TAILS ZD'
      
        '                   WHERE ZZZ.Z_DATE = Z.Z_DATE AND ZZZ.G_TOCHKA ' +
        '= :G_TOCHKA_ AND ZZZ.ZAKAZ = ZD.ZAKAZ) CNT'
      'FROM ZAKAZ Z'
      'WHERE Z.Z_DATE BETWEEN :DATE_BEGIN_ AND :DATE_END_'
      'AND Z.G_TOCHKA = :G_TOCHKA_'
      'GROUP BY Z.Z_DATE'
      'ORDER BY Z.Z_DATE')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 416
    Top = 272
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
