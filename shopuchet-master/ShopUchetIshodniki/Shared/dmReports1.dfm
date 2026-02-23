object ReportsDM: TReportsDM
  OldCreateOrder = False
  Height = 422
  Width = 394
  object ReportParams: TFlxMemTable
    Columns = <>
    Left = 224
    Top = 88
  end
  object SaveDialog: TSaveDialog
    Filter = '*.xls||*.xlsx'
    Left = 184
    Top = 32
  end
  object dsReport: TDataSource
    DataSet = spReport
    Left = 168
    Top = 88
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 32
    Top = 88
  end
  object spReport: TpFIBDataSet
    SelectSQL.Strings = (
      '')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 32
    Top = 160
    poSQLINT64ToBCD = True
  end
  object qLoadReport: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM REPORT WHERE REPORT = ?REPORT')
    AllowedUpdateKinds = []
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 264
    Top = 216
    poUseBooleanField = False
    object qLoadReportREPORT: TFIBIntegerField
      FieldName = 'REPORT'
    end
    object qLoadReportBODY: TFIBBlobField
      FieldName = 'BODY'
      Size = 8
    end
    object qLoadReportDESCRIPTION: TFIBStringField
      FieldName = 'DESCRIPTION'
      Size = 50
      Transliterate = False
      EmptyStrToNull = True
    end
    object qLoadReportSQL: TFIBStringField
      FieldName = 'SQL'
      Size = 200
      Transliterate = False
      EmptyStrToNull = True
    end
    object fbstrngfldLoadReportFILENAME: TFIBStringField
      FieldName = 'FILENAME'
      Size = 250
      Transliterate = False
      EmptyStrToNull = True
    end
    object qLoadReportCOORD: TStringField
      FieldName = 'COORD'
      Size = 50
    end
  end
  object Report: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42299.782745405100000000
    ReportOptions.LastChange = 44560.583681932870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = ReportBeforePrint
    OnGetValue = ReportGetValue
    Left = 208
    Top = 280
    Datasets = <
      
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'is_kafe'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 50.000000000000000000
      PaperHeight = 170.000000000000000000
      PaperSize = 256
      TopMargin = 3.000000000000000000
      BottomMargin = 2.000000000000000000
      EndlessHeight = True
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 139.842524570000000000
        Top = 18.897650000000000000
        Width = 188.976500000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 18.126005000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            #1063#1077#1082' '#8470)
          ParentFont = False
        end
        object frxDBDataset1NUM_: TfrxMemoView
          Left = 72.929190000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'NUM_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            '[frxDBDataset1."NUM_"]')
        end
        object Memo2: TfrxMemoView
          Top = 18.897650000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103':')
          ParentFont = False
        end
        object frxDBDataset1DATE_: TfrxMemoView
          Align = baWidth
          Left = 64.252010000000000000
          Top = 18.897650000000000000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          DataField = 'DATE_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."DATE_"]')
          ParentFont = False
        end
        object frxDBDataset1G_OFFICIAL_FM_: TfrxMemoView
          Align = baWidth
          Top = 71.031540000000000000
          Width = 188.976500000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataField = 'G_OFFICIAL_FM_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."G_OFFICIAL_FM_"]')
          ParentFont = False
        end
        object frxDBDataset1G_CLIENT_NAME_: TfrxMemoView
          Align = baWidth
          Top = 84.661417320000000000
          Width = 188.976500000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataField = 'G_CLIENT_NAME_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."G_CLIENT_NAME_"]')
          ParentFont = False
        end
        object frxDBDataset1PAYMENT_TYPE_: TfrxMemoView
          Align = baWidth
          Top = 98.267780000000000000
          Width = 188.976500000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataField = 'PAYMENT_TYPE_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."PAYMENT_TYPE_"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 1.000000000000000000
          Top = 122.944960000000000000
          Width = 13.228346460000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #8470)
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 16.118120000000000000
          Top = 122.944960000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077)
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 84.929190000000000000
          Top = 122.944960000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1062#1077#1085#1072)
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 112.944886770000000000
          Top = 122.944960000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1050#1086#1083'.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 135.960656770000000000
          Top = 122.944960000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1057#1091#1084#1084#1072)
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 119.385900000000000000
          Width = 302.362400000000000000
          Color = clBlack
          Frame.Width = 1.500000000000000000
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Align = baWidth
          Top = 30.393700790000000000
          Width = 188.976500000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataField = 'FIRM_NAME_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."FIRM_NAME_"]')
          ParentFont = False
          WordBreak = True
        end
        object Memo21: TfrxMemoView
          Align = baWidth
          Top = 57.448818900000000000
          Width = 188.976500000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."FIRM_ADDRESS_"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baWidth
          Top = 43.842519690000000000
          Width = 188.976500000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."FIRM_IDN_"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 181.417440000000000000
        Width = 188.976500000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        Stretched = True
        object frxDBDataset1ROW_NUM: TfrxMemoView
          Align = baLeft
          Width = 15.118120000000000000
          Height = 15.118120000000000000
          DataField = 'ROW_NUM'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."ROW_NUM"]')
          ParentFont = False
        end
        object frxDBDataset1NAME: TfrxMemoView
          Align = baLeft
          Left = 15.118120000000000000
          Width = 68.031417950000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataField = 'NAME'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."NAME"]')
          ParentFont = False
          WordBreak = True
        end
        object frxDBDataset1PRICE: TfrxMemoView
          Left = 83.149537950000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          AutoWidth = True
          DataField = 'PRICE'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."PRICE"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1AMOUNT: TfrxMemoView
          Left = 113.724514410000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          AutoWidth = True
          DataField = 'AMOUNT'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."AMOUNT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1SUMM: TfrxMemoView
          Left = 136.401694410000000000
          Width = 34.015745590000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          AutoWidth = True
          DataField = 'SUMM'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 207.874150000000000000
        Top = 257.008040000000000000
        Width = 188.976500000000000000
        Stretched = True
        object Memo12: TfrxMemoView
          Align = baLeft
          Top = 3.779530000000000000
          Width = 64.252010000000000000
          Height = 68.031540000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1057#1091#1084#1084#1072':'
            #1057#1082#1080#1076#1082#1072':'
            #1048#1090#1086#1075#1086':[NDSTR]'
            #1054#1087#1083#1072#1090#1072':'
            #1057#1076#1072#1095#1072':')
          ParentFont = False
        end
        object frxDBDataset1SUMM_VSEGO_: TfrxMemoView
          Left = 68.031540000000000000
          Top = 3.779530000000000000
          Width = 117.165430000000000000
          Height = 68.031540000000000000
          StretchMode = smActualHeight
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_VSEGO_"]'
            '[frxDBDataset1."SUMM_SKIDKA_"]'
            '[frxDBDataset1."SUMM_VSEGO_N_"][NDSUM]'
            '[frxDBDataset1."SUMM_POLUCH_"]'
            '[frxDBDataset1."SUMM_SDACH_"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object MemoBonus: TfrxMemoView
          Top = 72.716574490000000000
          Width = 185.196970000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."BONUS_STR_"]'
            '[frxDBDataset1."DELIVERY_ADDRESS_"]'
            #1057#1087#1072#1089#1080#1073#1086' '#1042#1072#1084' '#1079#1072' '#1087#1086#1082#1091#1087#1082#1091'!'
            '[frxDBDataset1."SLOGAN_"]'
            #1060#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1087#1088#1080#1079#1085#1072#1082': [FNum]'
            #1042#1088#1077#1084#1103': [Date] [Time]'
            #1050#1086#1076' '#1050#1050#1052' '#1050#1043#1044' ('#1056#1053#1052'): [RHM]'
            'Kassa '
            #1054#1087#1077#1088#1072#1090#1086#1088' '#1092#1080#1089#1082#1072#1083#1100#1085#1099#1093' '#1076#1072#1085#1085#1099#1093': '#1040#1054' "'#1058#1088#1072#1085#1089#1090#1077#1083#1077#1082#1086#1084'" '
            #1044#1083#1103' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1095#1077#1082#1072' '#1079#1072#1081#1076#1080#1090#1077' '#1085#1072' '#1089#1072#1081#1090': ofd1.kz')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object Picture1: TfrxPictureView
          Align = baWidth
          Top = 89.952814490000000000
          Width = 188.976500000000000000
          Height = 113.385900000000000000
          Center = True
          FileLink = '[QRLink]'
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
  end
  object BarCode: TfrxBarCodeObject
    Left = 168
    Top = 280
  end
  object RtfAdvExport: TfrxRTFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 168
    Top = 216
  end
  object JPEGExport: TfrxJPEGExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    JPEGQuality = 100
    CropImages = True
    Left = 128
    Top = 216
  end
  object FlexCelReport: TFlexCelReport
    AutoClose = False
    Adapter = XLSAdapter
    DateTimeFormat = 'mm/dd/yyyy hh:mm'
    KeepEmptyPictures = False
    DataModule = Owner
    Left = 32
    Top = 32
  end
  object XLSAdapter: TXLSAdapter
    AllowOverwritingFiles = True
    Left = 104
    Top = 32
  end
  object spReportThread: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM REPORT WHERE REPORT = ?REPORT')
    Transaction = MainDM.tranMainThreadRead
    Database = MainDM.dbMainThread
    Left = 136
    Top = 160
    poSQLINT64ToBCD = True
  end
  object spLoadReportThread: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM REPORT WHERE REPORT = ?REPORT')
    AllowedUpdateKinds = []
    Transaction = MainDM.tranMainThreadRead
    Database = MainDM.dbMainThread
    Left = 200
    Top = 160
    poUseBooleanField = False
    object sp2: TFIBIntegerField
      FieldName = 'REPORT'
    end
    object FIBBlobField1: TFIBBlobField
      FieldName = 'BODY'
      Size = 8
    end
    object FIBStringField1: TFIBStringField
      FieldName = 'DESCRIPTION'
      Size = 50
      Transliterate = False
      EmptyStrToNull = True
    end
    object FIBStringField2: TFIBStringField
      FieldName = 'SQL'
      Size = 100
      Transliterate = False
      EmptyStrToNull = True
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = spReport
    BCDToCurrency = False
    Left = 32
    Top = 216
  end
  object spGetProductList: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT  T.ARTICUL,'
      '        T.NOMENCLATUR_NUM,'
      '        T.BARCODE,'
      '        T.NAME,'
      '        T.PRICE,'
      '        T1.NAME CAT_NAME,'
      '        LT.AMOUNT,'
      '        LT.NAME TOCHKA_NAME,'
      '        P.TOTAL,'
      '        T.G_PRODUCT'
      
        '  FROM G_PRODUCT T LEFT OUTER JOIN (SELECT SUM(AMOUNT) TOTAL, G_' +
        'PRODUCT'
      
        '                                    FROM LT_SKLAD_PRODUCT GROUP ' +
        'BY G_PRODUCT) P ON T.G_PRODUCT = P.G_PRODUCT'
      
        '                   LEFT OUTER JOIN (SELECT G_PRODUCT, AMOUNT, NA' +
        'ME'
      '                                    FROM LT_SKLAD_PRODUCT L,'
      '                                         G_TOCHKA GT'
      
        '                                    WHERE L.G_TOCHKA = GT.G_TOCH' +
        'KA) LT ON T.G_PRODUCT = LT.G_PRODUCT,'
      '       G_PRODUCT T1'
      ' WHERE T.G_PRODUCT_PAR = T1.G_PRODUCT'
      ' ORDER BY T.NAME, T.G_PRODUCT'
      '/*SELECT  T.ARTICUL,'
      '        T.NOMENCLATUR_NUM,'
      '        T.BARCODE,'
      '        T.NAME,'
      '        T.PRICE,'
      '        COALESCE(P.AMOUNT, 0) AMOUNT,'
      '        T1.NAME CAT_NAME'
      
        '    FROM G_PRODUCT T LEFT OUTER JOIN (SELECT * FROM LT_SKLAD_PRO' +
        'DUCT WHERE G_TOCHKA = :G_TOCHKA_) P ON T.G_PRODUCT = P.G_PRODUCT' +
        ','
      '         G_PRODUCT T1'
      '    WHERE T.G_PRODUCT_PAR = T1.G_PRODUCT'
      '    ORDER BY T.NAME, T.G_PRODUCT*/')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 296
    Top = 216
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object frxPDFExport1: TfrxPDFExport
    FileName = '1.pdf'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 128
    Top = 280
  end
  object frxPrintA4: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = spPrintA4
    BCDToCurrency = False
    Left = 272
    Top = 280
  end
  object spPrintA4: TpFIBDataSet
    SelectSQL.Strings = (
      
        'WITH RECURSIVE TREE AS (SELECT g.name, g.barcode, g.price, 1 lev' +
        'l FROM G_PRODUCT g WHERE g.g_product = 2874 UNION ALL SELECT g.n' +
        'ame, g.barcode, g.price, gg.levl + 1 levl FROM G_PRODUCT g INNER' +
        ' JOIN TREE GG ON GG.name = g.name WHERE g.g_product = 2874 and g' +
        'g.levl < 65 ) SELECT * FROM TREE')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 240
    Top = 280
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object FlexCelImport: TFlexCelImport
    Adapter = XLSAdapter
    Left = 240
    Top = 32
  end
  object spUniversal: TpFIBDataSet
    SelectSQL.Strings = (
      
        'WITH RECURSIVE TREE AS (SELECT g.name, g.barcode, g.price, 1 lev' +
        'l FROM G_PRODUCT g WHERE g.g_product = 2874 UNION ALL SELECT g.n' +
        'ame, g.barcode, g.price, gg.levl + 1 levl FROM G_PRODUCT g INNER' +
        ' JOIN TREE GG ON GG.name = g.name WHERE g.g_product = 2874 and g' +
        'g.levl < 65 ) SELECT * FROM TREE')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 128
    Top = 336
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spUniversalWrite: TpFIBDataSet
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 176
    Top = 336
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 136
    Top = 88
  end
  object mdReportX: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 24
    Top = 320
    object strngfldmd1Names: TStringField
      FieldName = 'Names'
      Size = 50
    end
    object strngfldReportXValues: TStringField
      FieldName = 'Values'
      Size = 25
    end
  end
  object frxDBDataset2: TfrxDBDataset
    UserName = 'frxDBReportX'
    CloseDataSource = False
    DataSet = mdReportX
    BCDToCurrency = False
    Left = 56
    Top = 320
  end
  object spRekvizit: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT NAME, IDN'
      'FROM G_FIRM_REKVIZIT'
      'WHERE IS_DEFAULT <> 0')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 368
    poSQLINT64ToBCD = True
  end
end
