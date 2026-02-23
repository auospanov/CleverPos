inherited ChooseFirmAndAddressForm: TChooseFirmAndAddressForm
  Caption = #1042#1099#1073#1086#1088' '#1092#1080#1088#1084#1099' '#1080' '#1072#1076#1088#1077#1089#1072' '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080
  ClientHeight = 148
  ClientWidth = 533
  OnCreate = FormCreate
  ExplicitWidth = 539
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 519
    Height = 106
    object shp25: TShape
      Left = 10
      Top = 36
      Width = 156
      Height = 28
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shpsh1: TShape
      Left = 10
      Top = 10
      Width = 156
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object lbPostavshik: TLabel
      Left = 17
      Top = 16
      Width = 98
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1080#1088#1084#1091
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shpsh2: TShape
      Left = 165
      Top = 10
      Width = 342
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb14: TLabel
      Left = 17
      Top = 43
      Width = 93
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1072#1076#1088#1077#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shp29: TShape
      Left = 165
      Top = 36
      Width = 342
      Height = 28
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object leFirm: TcxLookupComboBox
      Left = 171
      Top = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_FIRM_REKVIZIT'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsFirm
      Properties.OnChange = leFirmPropertiesChange
      Style.BorderStyle = ebsFlat
      Style.ButtonTransparency = ebtNone
      TabOrder = 0
      Width = 332
    end
    object leAddress: TcxLookupComboBox
      Left = 171
      Top = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_ADDRESS'
      Properties.ListColumns = <
        item
          FieldName = 'ADDRESS'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsAddress
      Style.StyleController = dxEditStyleController
      Style.ButtonTransparency = ebtNone
      TabOrder = 1
      Width = 332
    end
  end
  inherited btnOk: TcxButton
    Left = 364
    Top = 116
  end
  inherited btnCancel: TcxButton
    Left = 451
    Top = 116
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object spAddress: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM g_read_g_firm_address_list(?G_FIRM_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 400
    Top = 40
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsAddress: TDataSource
    DataSet = spAddress
    Left = 432
    Top = 40
  end
  object spFirm: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_FIRM_REKVIZIT')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 264
    Top = 8
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsFirm: TDataSource
    DataSet = spFirm
    Left = 296
    Top = 8
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 144
    Top = 88
  end
end
