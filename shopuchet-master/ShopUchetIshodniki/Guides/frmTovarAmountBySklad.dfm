inherited TovarAmountBySkladForm: TTovarAmountBySkladForm
  Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072' '#1085#1072' '#1076#1088#1091#1075#1080#1093' '#1089#1082#1083#1072#1076#1072#1093
  ClientWidth = 572
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 578
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 558
    ExplicitWidth = 558
    object grProduct: TcxGrid
      Left = 2
      Top = 2
      Width = 554
      Height = 317
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      ExplicitLeft = 1
      ExplicitTop = 127
      ExplicitWidth = 452
      ExplicitHeight = 88
      object tvProduct: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsRead
        DataController.KeyFieldNames = 'G_PRODUCT'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Styles.Inactive = MainDM.stGridSelectedRow11
        object tvProductNAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'NAME'
          Width = 225
        end
        object tvProductAMOUNT: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'AMOUNT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          RepositoryItem = riEditRepositoryCurrencyItem
          HeaderAlignmentHorz = taCenter
          Width = 139
        end
        object tvProductAMOUNT_RESERVE: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086' '#1085#1072' '#1088#1077#1079#1077#1088#1074#1077
          DataBinding.FieldName = 'AMOUNT_RESERVE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          RepositoryItem = riEditRepositoryCurrencyItem
          HeaderAlignmentHorz = taCenter
          Width = 136
        end
      end
      object lv1: TcxGridLevel
        GridView = tvProduct
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 403
    ExplicitLeft = 403
  end
  inherited btnCancel: TcxButton
    Left = 490
    ExplicitLeft = 490
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT G.NAME,'
      '       COALESCE(L.AMOUNT, 0) AMOUNT,'
      '       COALESCE(L.AMOUNT_RESERVE, 0) AMOUNT_RESERVE'
      
        '  FROM G_TOCHKA G LEFT OUTER JOIN LT_SKLAD_PRODUCT L ON G.G_TOCH' +
        'KA = L.G_TOCHKA'
      
        '         AND L.G_PRODUCT = :G_PRODUCT_ AND L.G_TOCHKA = G.G_TOCH' +
        'KA'
      ' WHERE G.G_TOCHKA <> :G_TOCHKA_')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 221
    Top = 91
  end
  object dsRead: TDataSource
    DataSet = spRead
    Left = 221
    Top = 128
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 40
    Top = 48
  end
end
