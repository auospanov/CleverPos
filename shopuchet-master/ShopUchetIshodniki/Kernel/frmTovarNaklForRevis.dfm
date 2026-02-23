inherited TovarNaklForRevisForm: TTovarNaklForRevisForm
  Left = 529
  Top = 328
  Caption = #1042#1099#1073#1086#1088' '#1090#1086#1074#1072#1088#1085#1086#1081' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
  ClientHeight = 92
  ClientWidth = 499
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 505
  ExplicitHeight = 118
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 483
    Height = 47
    ExplicitWidth = 483
    ExplicitHeight = 47
    object Shape2: TShape
      Left = 8
      Top = 10
      Width = 145
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 16
      Width = 117
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1058#1086#1074#1072#1088#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape6: TShape
      Left = 152
      Top = 10
      Width = 321
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object leNakladnaya: TcxLookupComboBox
      Left = 158
      Top = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.KeyFieldNames = 'G_ADDRESS_TYPE'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 311
    end
  end
  inherited btnOk: TcxButton
    Left = 334
    Top = 60
    ExplicitLeft = 334
    ExplicitTop = 60
  end
  inherited btnCancel: TcxButton
    Left = 416
    Top = 60
    ExplicitLeft = 416
    ExplicitTop = 60
  end
  inherited btHelp: TcxButton
    Top = 60
    ExplicitTop = 60
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object spPrihod: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_SKLAD_LIST_FOR_REVIS')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 160
    Top = 56
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsPrihod: TDataSource
    DataSet = spPrihod
    Left = 192
    Top = 56
  end
end
