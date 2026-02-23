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
    ReportOptions.LastChange = 44938.997047893520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var t : double;'
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<frxDBDataset1."DISCOUNT"> = '#39'0.00'#39' ) then begin'
      '     ChildDiscount.Visible := false;'
      '  end else begin'
      '     ChildDiscount.Visible := true;'
      '  end;'
      'end;'
      ''
      'procedure Footer1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxDBDataset1."SUMM_SERVICE_"> = '#39'0.00'#39' then'
      '    ChildService.Visible := False;'
      ''
      
        '  if (<frxDBDataset1."SUMM_POLUCH_"> <> '#39'0.00'#39') or (<frxDBDatase' +
        't1."SUMM_NONCASH_"> <> '#39'0.00'#39') then begin'
      '    if <frxDBDataset1."SUMM_POLUCH_"> = '#39'0.00'#39' then begin'
      '      ChildCash.Visible := False;'
      '      ChildSdacha.Visible := False;'
      '    end;'
      ''
      '    if <frxDBDataset1."SUMM_NONCASH_"> = '#39'0.00'#39' then begin'
      '      ChildNonCash.Visible := False;'
      '    end;'
      '  end;'
      ''
      '  if <frxDBDataset1."SUMM_BONUS_"> = '#39'0.00'#39' then'
      '    ChildOplataBonusami.Visible := False;'
      ''
      '  if <frxDBDataset1."SUMM_NDS_"> = '#39'0.00'#39' then'
      '    ChildNDS.Visible := False;'
      ''
      
        '  if ((<frxDBDataset1."BONUS_STR_"> = '#39#39') and (<frxDBDataset1."B' +
        'ONUSALL_STR_"> = '#39#39')) then'
      '  begin'
      '    ChildBonus.Visible := False;'
      '  end;'
      ''
      '  if <frxDBDataset1."DELIVERY_ADDRESS_"> = '#39#39' then begin'
      '    ChildDeliveryAddress.Visible := False;'
      '  end;'
      ''
      
        '  if (<print_barcode> = '#39'0'#39') or (<frxDBDataset1."BILL_BARCODE_">' +
        ' = '#39#39') then'
      '    ChildBarcode.Visible := False;'
      ''
      'end;'
      ''
      'begin'
      ''
      '  {if <frxDBDataset1."SUMM_SERVICE_"> = '#39'0.00'#39' then begin'
      '    MemoSumm.Visible := False;'
      '    MemoDBSumm.Visible := False;'
      '    MemoService.Visible := False;'
      '    MemoServiceSum.Visible := False;'
      ''
      '    t := MemoItog.Top - MemoSumm.Top;'
      ''
      '    MemoOplata.Top := MemoOplata.Top - t;'
      '    MemoOplataSum.Top := MemoOplataSum.Top - t;'
      '    MemoOplataBeznal.Top := MemoOplataBeznal.Top - t;'
      '    MemoOplataSumBeznal.Top := MemoOplataSumBeznal.Top - t;'
      '    MemoSdacha.Top := MemoSdacha.Top - t;'
      '    MemoSdachaSum.Top := MemoSdachaSum.Top - t;'
      '    MemoThanks.Top := MemoThanks.Top - t;'
      '    MemoSlogan.Top := MemoSlogan.Top - t;'
      '    MemoBonus.Top := MemoBonus.Top - t;'
      '    MemoAddress.Top := MemoAddress.Top - t;'
      '  end;'
      ''
      '  {if <frxDBDataset1."SUMM_POLUCH_"> = '#39'0.00'#39' then begin'
      '    MemoOplata.Visible := False;'
      '    MemoOplataSum.Visible := False;'
      ''
      '    t := MemoOplataBeznal.Top - MemoOplata.Top;'
      '    MemoOplataSumBeznal.Top := MemoOplataSumBeznal.Top - t;'
      '    MemoOplataBeznal.Top := MemoOplataBeznal.Top - t;'
      '  end;}'
      ''
      '  {if <frxDBDataset1."SUMM_NONCASH_"> = '#39'0.00'#39' then begin'
      '    MemoOplataBeznal.Visible := False;'
      '    MemoOplataSumBeznal.Visible := False;'
      '  end;'
      ''
      '  if <frxDBDataset1."SUMM_SDACH_"> = '#39'0.00'#39' then begin'
      '    MemoSdacha.Visible := False;'
      '    MemoSdachaSum.Visible := False;'
      '  end;'
      ''
      
        '  if ((<frxDBDataset1."BONUS_STR_"> = '#39#39') and (<frxDBDataset1."B' +
        'ONUSALL_STR_"> = '#39#39')) then'
      '  begin'
      '    MemoBonus.Visible := False;'
      '    t := MemoAddress.Top - MemoBonus.Top;'
      ''
      '    MemoThanks.Top := MemoThanks.Top - t;'
      '    MemoSlogan.Top := MemoSlogan.Top - t;'
      '    MemoAddress.Top := MemoAddress.Top - t;'
      '  end;'
      ''
      '  if <frxDBDataset1."DELIVERY_ADDRESS_"> = '#39#39' then begin'
      '    MemoAddress.Visible := False;'
      '    t := MemoThanks.Top - MemoAddress.Top;'
      ''
      '    MemoThanks.Top := MemoThanks.Top - t;'
      '    MemoSlogan.Top := MemoSlogan.Top - t;'
      '  end;}'
      ''
      'end.')
    OnBeforePrint = ReportBeforePrint
    OnGetValue = ReportGetValue
    Left = 208
    Top = 280
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'is_kafe'
        Value = Null
      end
      item
        Name = 'print_barcode'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 65.000000000000000000
      PaperHeight = 230.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 130.181200000000000000
        Top = 18.897650000000000000
        Width = 245.669450000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 23.811070000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1063#1077#1082' '#8470'444')
          ParentFont = False
        end
        object frxDBDataset1NUM_: TfrxMemoView
          Left = 106.960730000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataField = 'NUM_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."NUM_"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 15.897650000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103':')
          ParentFont = False
        end
        object frxDBDataset1DATE_: TfrxMemoView
          Align = baLeft
          Left = 94.488250000000000000
          Top = 15.897650000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          DataField = 'DATE_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."DATE_"]')
          ParentFont = False
        end
        object frxDBDataset1G_OFFICIAL_FM_: TfrxMemoView
          Align = baWidth
          Top = 80.590600000000000000
          Width = 245.669450000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataField = 'G_OFFICIAL_FM_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."G_OFFICIAL_FM_"]')
          ParentFont = False
        end
        object frxDBDataset1G_CLIENT_NAME_: TfrxMemoView
          Align = baWidth
          Top = 96.488250000000000000
          Width = 245.669450000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataField = 'G_CLIENT_NAME_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."G_CLIENT_NAME_"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baCenter
          Left = 9.448825000000000000
          Top = 115.826840000000000000
          Width = 226.771800000000000000
          Color = clBlack
          Frame.Width = 1.500000000000000000
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Align = baWidth
          Top = 31.574830000000000000
          Width = 245.669450000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataField = 'FIRM_NAME_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."FIRM_NAME_"]')
          ParentFont = False
          WordBreak = True
        end
        object Memo19: TfrxMemoView
          Align = baWidth
          Top = 48.252010000000000000
          Width = 245.669450000000000000
          Height = 15.118120000000000000
          DataField = 'FIRM_IDN_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."FIRM_IDN_"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Align = baWidth
          Top = 64.590600000000000000
          Width = 245.669450000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."FIRM_ADDRESS_"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baWidth
          Top = 116.842610000000000000
          Width = 245.669450000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 28.346466460000000000
        Top = 173.858380000000000000
        Width = 245.669450000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = Report.ChildDiscount
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        PrintChildIfInvisible = True
        RowCount = 0
        Stretched = True
        object frxDBDataset1NAME: TfrxMemoView
          Align = baWidth
          Width = 245.669450000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataField = 'NAME'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."NAME"]')
          ParentFont = False
          WordBreak = True
        end
        object frxDBDataset1SUMM: TfrxMemoView
          Align = baRight
          Top = 14.118120000000000000
          Width = 245.669450000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          AutoWidth = True
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_TXT"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 10.338590000000000000
        Top = 264.567100000000000000
        Width = 245.669450000000000000
        OnBeforePrint = 'Footer1OnBeforePrint'
        Child = Report.ChildService
        PrintChildIfInvisible = True
        object Line2: TfrxLineView
          Align = baCenter
          Left = 9.448898228346500000
          Top = 5.669118030000000000
          Width = 226.771653543307000000
          Color = clBlack
          Frame.Width = 1.500000000000000000
          Diagonal = True
        end
      end
      object ChildDiscount: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 226.771800000000000000
        Width = 245.669450000000000000
        object Memo4: TfrxMemoView
          Align = baRight
          Left = 79.370130000000000000
          Width = 166.299320000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          AutoWidth = True
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxDBDataset1."DISCOUNT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1057#1082#1080#1076#1082#1072)
          ParentFont = False
        end
      end
      object ChildService: TfrxChild
        FillType = ftBrush
        Height = 34.015745590000000000
        Top = 298.582870000000000000
        Width = 245.669450000000000000
        Child = Report.ChildItogo
        PrintChildIfInvisible = True
        object MemoService: TfrxMemoView
          Align = baLeft
          Top = 16.677180000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1054#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077' 10%:')
          ParentFont = False
          VAlign = vaCenter
        end
        object MemoServiceSum: TfrxMemoView
          Align = baRight
          Left = 132.283550000000000000
          Top = 16.677180000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_SERVICE_"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object MemoSumm: TfrxMemoView
          Align = baLeft
          Top = 0.661410000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1057#1091#1084#1084#1072':')
          ParentFont = False
          VAlign = vaCenter
        end
        object MemoDBSumm: TfrxMemoView
          Align = baRight
          Left = 132.283550000000000000
          Top = 0.661410000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_VSEGO_WITHOUT_SERVICE_"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildItogo: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 355.275820000000000000
        Width = 245.669450000000000000
        Child = Report.ChildNDS
        KeepChild = True
        PrintChildIfInvisible = True
        object MemoItog: TfrxMemoView
          Align = baLeft
          Top = 0.338590000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1048#1090#1086#1075#1086':')
          ParentFont = False
          VAlign = vaCenter
        end
        object MemoItogSum: TfrxMemoView
          Align = baRight
          Left = 132.283550000000000000
          Top = 0.338590000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_VSEGO_N_"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildCash: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 430.866420000000000000
        Width = 245.669450000000000000
        Child = Report.ChildNonCash
        KeepChild = True
        PrintChildIfInvisible = True
        object MemoOplataSum: TfrxMemoView
          Align = baRight
          Left = 132.283550000000000000
          Top = 0.661410000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataField = 'SUMM_POLUCH_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_POLUCH_"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object MemoOplata: TfrxMemoView
          Align = baLeft
          Top = 0.661410000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1053#1072#1083#1080#1095#1085#1099#1084#1080':')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildBonus: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 582.047620000000000000
        Width = 245.669450000000000000
        Child = Report.ChildDeliveryAddress
        KeepChild = True
        PrintChildIfInvisible = True
        object MemoBonus: TfrxMemoView
          Align = baWidth
          Top = 1.543290000000000000
          Width = 245.669450000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."BONUS_STR_"]'
            '[frxDBDataset1."BONUSALL_STR_"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ChildDeliveryAddress: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 642.520100000000000000
        Width = 245.669450000000000000
        Child = Report.ChildThanks
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object MemoAddress: TfrxMemoView
          Align = baWidth
          Top = 6.220470000000000000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDataset1."DELIVERY_ADDRESS_"]')
          ParentFont = False
          WordBreak = True
          VAlign = vaCenter
        end
      end
      object ChildThanks: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 702.992580000000000000
        Width = 245.669450000000000000
        Child = Report.ChildSlogan
        KeepChild = True
        PrintChildIfInvisible = True
        object MemoThanks: TfrxMemoView
          Top = 9.527520000000000000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1057#1087#1072#1089#1080#1073#1086' '#1042#1072#1084' '#1079#1072' '#1087#1086#1082#1091#1087#1082#1091'!')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildSlogan: TfrxChild
        FillType = ftBrush
        Height = 33.259847400000000000
        Top = 763.465060000000000000
        Width = 245.669450000000000000
        Child = Report.ChildBarcode
        KeepChild = True
        PrintChildIfInvisible = True
        object MemoSlogan: TfrxMemoView
          Align = baWidth
          Top = 1.322820000000000000
          Width = 245.669450000000000000
          Height = 22.677180000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."SLOGAN_"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildNonCash: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 468.661720000000000000
        Width = 245.669450000000000000
        Child = Report.ChildOplataBonusami
        KeepChild = True
        PrintChildIfInvisible = True
        object MemoOplataSumBeznal: TfrxMemoView
          Align = baRight
          Left = 109.606370000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DataField = 'SUMM_NONCASH_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_NONCASH_"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object MemoOplataBeznal: TfrxMemoView
          Align = baLeft
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1041#1072#1085#1082'. '#1082#1072#1088#1090#1086#1081':')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildSdacha: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 544.252320000000000000
        Width = 245.669450000000000000
        Child = Report.ChildBonus
        KeepChild = True
        PrintChildIfInvisible = True
        object MemoSdacha: TfrxMemoView
          Align = baLeft
          Top = 0.307050000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1057#1076#1072#1095#1072':')
          ParentFont = False
          VAlign = vaCenter
        end
        object MemoSdachaSum: TfrxMemoView
          Align = baRight
          Left = 132.283550000000000000
          Top = 0.307050000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataField = 'SUMM_SDACH_'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_SDACH_"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildOplataBonusami: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 506.457020000000000000
        Width = 245.669450000000000000
        Child = Report.ChildSdacha
        KeepChild = True
        PrintChildIfInvisible = True
        object Memo6: TfrxMemoView
          Align = baRight
          Left = 132.283550000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_BONUS_"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1041#1086#1085#1091#1089#1072#1084#1080':')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildNDS: TfrxChild
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 393.071120000000000000
        Width = 245.669450000000000000
        Child = Report.ChildCash
        KeepChild = True
        PrintChildIfInvisible = True
        object Memo8: TfrxMemoView
          Align = baLeft
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            #1074' '#1090#1086#1084' '#1095#1080#1089#1083#1077' '#1053#1044#1057':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 132.283550000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."SUMM_NDS_"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildBarcode: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 820.158010000000000000
        Width = 245.669450000000000000
        PrintChildIfInvisible = True
        object BarCode1: TfrxBarCodeView
          Align = baCenter
          Left = 50.334725000000000000
          Top = 3.779530000000000000
          Width = 145.000000000000000000
          Height = 30.236240000000000000
          BarType = bcCode128
          Expression = '<frxDBDataset1."BILL_BARCODE_">'
          Rotation = 0
          ShowText = False
          Text = 'SHO123456789012'
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
      DisplayWidth = 255
      FieldName = 'Names'
      Size = 255
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
      'SELECT A.Adr, NAME, IDN'
      '    FROM G_FIRM_REKVIZIT F LEFT OUTER JOIN'
      
        '    (SELECT R.address as Adr, r.G_FIRM_REKVIZIT FROM G_FIRM_ADDR' +
        'ESS R WHERE R.IS_DEFAULT=1) as A on f.G_FIRM_REKVIZIT = A.G_FIRM' +
        '_REKVIZIT'
      '   WHERE f.IS_DEFAULT = 1')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 16
    Top = 368
    poSQLINT64ToBCD = True
  end
  object spReadDiscount: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_DISCOUNT_LIST(1)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 64
    Top = 368
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
