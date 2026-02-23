object ReportsThreadDM: TReportsThreadDM
  OldCreateOrder = False
  Height = 369
  Width = 333
  object ReportParams: TFlxMemTable
    Columns = <>
    Left = 160
    Top = 88
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMainThread
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
    Database = MainDM.dbMainThread
    Left = 32
    Top = 160
    poSQLINT64ToBCD = True
  end
  object qLoadReport: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM REPORT WHERE REPORT = ?REPORT')
    AllowedUpdateKinds = []
    Transaction = tranRead
    Database = MainDM.dbMainThread
    Left = 104
    Top = 160
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
    end
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
      '        T.G_PRODUCT,'
      '        T.MF_COUNTRY'
      
        '  FROM G_PRODUCT T LEFT OUTER JOIN (SELECT SUM(AMOUNT) TOTAL, G_' +
        'PRODUCT'
      '                                    FROM LT_SKLAD_PRODUCT'
      
        '                                    GROUP BY G_PRODUCT) P ON T.G' +
        '_PRODUCT = P.G_PRODUCT'
      
        '                   LEFT OUTER JOIN (SELECT G_PRODUCT, AMOUNT, NA' +
        'ME'
      '                                    FROM LT_SKLAD_PRODUCT L,'
      '                                         G_TOCHKA GT'
      
        '                                    WHERE L.G_TOCHKA = GT.G_TOCH' +
        'KA) LT ON T.G_PRODUCT = LT.G_PRODUCT,'
      '       G_PRODUCT T1'
      ' WHERE T.G_PRODUCT_PAR = T1.G_PRODUCT'
      ' AND T.IS_ACTIVE = 1'
      ' AND T.IS_CATEGORY = 0'
      ' AND :ITEKA_ = 0'
      'UNION ALL'
      'SELECT  T.ARTICUL,'
      '        T.NOMENCLATUR_NUM,'
      '        T.BARCODE,'
      '        T.NAME,'
      '        T.PRICE,'
      '        '#39#39' CAT_NAME,'
      '        LT.AMOUNT,'
      '        '#39#39' TOCHKA_NAME,'
      '        0 TOTAL,'
      '        T.G_PRODUCT,'
      '        T.MF_COUNTRY'
      '  FROM G_PRODUCT T,'
      '       LT_SKLAD_PRODUCT LT'
      ' WHERE T.IS_ACTIVE = 1'
      ' AND T.IS_CATEGORY = 0'
      ' AND T.G_PRODUCT = LT.G_PRODUCT'
      ' AND LT.G_TOCHKA = :G_TOCHKA_'
      ' AND LT.AMOUNT > 0'
      ' AND :ITEKA_ = 1'
      ' ORDER BY 4, 10')
    Transaction = tranRead
    Database = MainDM.dbMainThread
    Left = 160
    Top = 160
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object FlexCelImport: TFlexCelImport
    Adapter = XLSAdapter
    Left = 160
    Top = 32
  end
  object spUniversalRead: TpFIBDataSet
    Transaction = tranRead
    Database = MainDM.dbMainThread
    Left = 160
    Top = 216
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMainThread
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 72
    Top = 88
  end
  object spUniversalWrite: TpFIBDataSet
    Transaction = tranWrite
    Database = MainDM.dbMainThread
    Left = 208
    Top = 216
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
