object TreeFrame: TTreeFrame
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object tlCommon: TcxDBTreeList
    Left = 0
    Top = 0
    Width = 320
    Height = 240
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Bands = <
      item
      end>
    DataController.DataSource = dsReadFrame
    DataController.ParentField = 'G_TOCHKA'
    DataController.KeyField = 'G_TOCHKA'
    LookAndFeel.Kind = lfFlat
    Navigator.Buttons.CustomButtons = <>
    OptionsSelection.CellSelect = False
    OptionsView.CheckGroups = True
    RootValue = -1
    TabOrder = 0
    OnCustomDrawDataCell = tlCommonCustomDrawDataCell
    OnMouseDown = tlCommonMouseDown
    object cxDBTreeListColumn1: TcxDBTreeListColumn
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Caption.Text = #1042#1099#1073#1086#1088
      Width = 94
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxDBTreeListColumn2: TcxDBTreeListColumn
      Caption.Text = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Width = 265
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object tlSkladcxDBTreeListColumn1: TcxDBTreeListColumn
      Visible = False
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
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
