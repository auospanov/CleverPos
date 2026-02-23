object ReportsDM: TReportsDM
  OldCreateOrder = False
  Height = 422
  Width = 367
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
    ReportOptions.CreateDate = 42142.401154432900000000
    ReportOptions.LastChange = 43251.654917777780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure m_SloganOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <slogan_bold> = 1 then'
      '    m_Slogan.font.style := fsbold;'
      
        '  m_Slogan.font.size := <slogan_size>;                          ' +
        '                                        '
      'end;'
      ''
      'procedure m_PriceOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <price_bold> = 1 then           '
      '    m_Price.font.style := fsbold;'
      '  m_Price.font.size := <price_size>;      '
      'end;    '
      ''
      'procedure m_NameOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <name_bold> = 1 then           '
      '    m_Name.font.style := fsbold;'
      '  m_Name.font.size := <name_size>;  '
      'end;'
      ''
      'begin'
      '  if <name_t> = null then'
      '    m_Name.Visible := False;'
      ''
      '  if (<slogan> = null) then'
      '    m_Slogan.Visible := False;                       '
      ''
      '  if (<price> = null) then'
      
        '    m_Price.Visible := False;                                   ' +
        '                                            '
      '        '
      '  if <barcode8> = null'#39' then'
      '    BarCode8.Visible := False;'
      '  if <barcode13> = null'#39' then'
      '    BarCode13.Visible := False;      '
      'end.')
    OnBeforePrint = ReportBeforePrint
    Left = 208
    Top = 280
    Datasets = <>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'barcode13'
        Value = Null
      end
      item
        Name = 'barcode8'
        Value = Null
      end
      item
        Name = 'name_t'
        Value = Null
      end
      item
        Name = 'price'
        Value = Null
      end
      item
        Name = 'slogan'
        Value = Null
      end
      item
        Name = 'print_price'
        Value = Null
      end
      item
        Name = 'print_slogan'
        Value = Null
      end
      item
        Name = 'price_bold'
        Value = Null
      end
      item
        Name = 'slogan_bold'
        Value = Null
      end
      item
        Name = 'price_size'
        Value = Null
      end
      item
        Name = 'slogan_size'
        Value = Null
      end
      item
        Name = 'name_bold'
        Value = Null
      end
      item
        Name = 'New Variable2'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      PaperWidth = 30.000000000000000000
      PaperHeight = 20.000000000000000000
      PaperSize = 256
      object m_Slogan: TfrxMemoView
        Align = baCenter
        Left = 1.889765000000003000
        Top = 56.692913385826800000
        Width = 109.606370000000000000
        Height = 18.519685039370100000
        OnBeforePrint = 'm_SloganOnBeforePrint'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[slogan]')
        ParentFont = False
        VAlign = vaCenter
      end
      object m_Name: TfrxMemoView
        Align = baCenter
        Left = 0.000000000000003286
        Top = 0.779530000000000000
        Width = 113.385900000000000000
        Height = 18.897650000000000000
        OnBeforePrint = 'm_NameOnBeforePrint'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[name_t]')
        ParentFont = False
        VAlign = vaCenter
      end
      object m_Price: TfrxMemoView
        Align = baCenter
        Left = 1.889765000000003000
        Top = 56.692950000000000000
        Width = 109.606370000000000000
        Height = 18.519685040000000000
        OnBeforePrint = 'm_PriceOnBeforePrint'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[price]')
        ParentFont = False
        VAlign = vaCenter
      end
      object BarCode8: TfrxBarCodeView
        Align = baCenter
        Left = 23.192950000000000000
        Top = 21.629918820000000000
        Width = 67.000000000000000000
        Height = 37.795275590000000000
        BarType = bcCodeEAN8
        Expression = '<barcode8>'
        Rotation = 0
        Text = '20001186'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
      object BarCode13: TfrxBarCodeView
        Left = 4.192950000000000000
        Top = 21.677180000000000000
        Width = 103.000000000000000000
        Height = 37.795263390000000000
        BarType = bcCodeEAN13
        Expression = '<barcode13>'
        Rotation = 0
        Text = '12345678'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
    AllowOverwritingFiles = False
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
      '        COALESCE(P.AMOUNT, 0) AMOUNT,'
      '        T1.NAME CAT_NAME'
      
        '    FROM G_PRODUCT T LEFT OUTER JOIN (SELECT * FROM LT_SKLAD_PRO' +
        'DUCT WHERE G_TOCHKA = :G_TOCHKA_) P ON T.G_PRODUCT = P.G_PRODUCT' +
        ','
      '         G_PRODUCT T1'
      '    WHERE T.G_PRODUCT_PAR = T1.G_PRODUCT'
      '    ORDER BY T.NAME, T.G_PRODUCT')
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
end
