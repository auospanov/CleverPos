inherited GetTovarAsideSpisForm: TGetTovarAsideSpisForm
  Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1083#1086#1078#1077#1085#1085#1099#1093' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 320
  ClientWidth = 677
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 683
  ExplicitHeight = 346
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 663
    Height = 278
    ExplicitWidth = 663
    ExplicitHeight = 278
    object gr1: TcxGrid
      Left = 2
      Top = 2
      Width = 659
      Height = 274
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      ExplicitLeft = 0
      ExplicitTop = 32
      ExplicitWidth = 494
      ExplicitHeight = 160
      object tvMain: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = tvMainCellDblClick
        DataController.DataSource = dsMemData
        DataController.KeyFieldNames = 'RecId'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'AMOUNT'
          end
          item
            Kind = skSum
            FieldName = 'SUMM'
          end
          item
            Kind = skSum
            FieldName = 'NDS_SUMM'
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        Styles.Inactive = MainDM.stGridSelectedRow
        object clmMainRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object clmMainCheck: TcxGridDBColumn
          Caption = #1063#1077#1082' '#8470
          DataBinding.FieldName = 'Check'
          HeaderAlignmentHorz = taCenter
          Width = 65
        end
        object clmMainSumm: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'Summ'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          Width = 120
        end
        object clmMainDetails: TcxGridDBColumn
          Caption = #1058#1086#1074#1072#1088#1099
          DataBinding.FieldName = 'Details'
          HeaderAlignmentHorz = taCenter
          Width = 471
        end
      end
      object lvMain: TcxGridLevel
        GridView = tvMain
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 508
    Top = 288
    ExplicitLeft = 508
    ExplicitTop = 288
  end
  inherited btnCancel: TcxButton
    Left = 595
    Top = 288
    ExplicitLeft = 595
    ExplicitTop = 288
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object dsMemData: TDataSource
    DataSet = dxMemData
    Left = 68
    Top = 249
  end
  object dxMemData: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 30
    Top = 250
    object dxMemDataSumm: TFloatField
      FieldName = 'Summ'
    end
    object dxMemDataDetails: TStringField
      FieldName = 'Details'
      Size = 500
    end
    object dxMemDataCheck: TIntegerField
      FieldName = 'Check'
    end
    object intgrfldMemDataId: TIntegerField
      FieldName = 'Id'
    end
  end
end
