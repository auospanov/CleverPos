object GridFrameDupl: TGridFrameDupl
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object grMain: TcxGrid
    Left = 0
    Top = 0
    Width = 320
    Height = 240
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    object tvMain: TcxGridDBTableView
      OnMouseDown = tvMainMouseDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsReadFrame
      DataController.KeyFieldNames = 'ZAKAZ_NA_REAL'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.Inactive = MainDM.stGridSelectedRow
      object clmMainColumn1: TcxGridDBColumn
        Caption = #1042#1099#1073#1086#1088
        PropertiesClassName = 'TcxCheckBoxProperties'
        OnCustomDrawCell = clmMainColumn1CustomDrawCell
      end
      object clmMainColumn2: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 231
      end
      object clmMainColumn3: TcxGridDBColumn
        Caption = 'ID'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
      end
    end
    object lvMain: TcxGridLevel
      GridView = tvMain
    end
  end
  object spReadFrame: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM ('
      'WITH RECURSIVE TREE'
      '  AS (SELECT T.G_PRODUCT,'
      '             replace(T.NAME, '#39' '#39', '#39#39') PATH,'
      '             T.NAME NAME,'
      '             CAST('#39#39' AS VARCHAR(255)) AS indent'
      '      FROM G_PRODUCT T'
      '     WHERE T.G_PRODUCT_PAR IS NULL'
      '       AND T.GTYPE = COALESCE(:TYPE_, T.GTYPE)'
      '    UNION ALL'
      '    SELECT T.G_PRODUCT,'
      '           GG.PATH||replace(T.NAME, '#39' '#39', '#39#39') PATH,'
      '           T.NAME NAME,'
      '           GG.indent || rpad('#39#39', 2) AS indent'
      
        '      FROM G_PRODUCT T INNER JOIN TREE GG ON GG.G_PRODUCT = T.G_' +
        'PRODUCT_PAR'
      '     WHERE T.IS_CATEGORY = 1'
      '    )'
      ' SELECT G_PRODUCT,'
      '        PATH,'
      '        Indent || NAME AS NAME FROM TREE)'
      'ORDER BY 2, 1')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 32
    Top = 72
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadFrame: TDataSource
    DataSet = spReadFrame
    Left = 64
    Top = 72
  end
end
