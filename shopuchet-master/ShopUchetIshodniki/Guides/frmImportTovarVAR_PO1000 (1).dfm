inherited ImportTovarForm: TImportTovarForm
  Left = 381
  Top = 155
  Caption = #1048#1084#1087#1086#1088#1090' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 489
  ClientWidth = 572
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 14
  inherited btnOk: TBitBtn
    Left = 387
    Top = 456
    Width = 95
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 2
    OnClick = btnOkClick
    Kind = bkYes
  end
  inherited btnCancel: TBitBtn
    Left = 489
    Top = 456
    Caption = #1042#1099#1081#1090#1080
    TabOrder = 3
    OnClick = btnCancelClick
  end
  inherited Panel1: TPanel
    Width = 556
    Height = 441
    TabOrder = 1
    object Shape1: TShape
      Left = 8
      Top = 87
      Width = 159
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape25: TShape
      Left = 8
      Top = 35
      Width = 177
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 10
      Width = 160
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 16
      Width = 76
      Height = 14
      Caption = #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape4: TShape
      Left = 167
      Top = 10
      Width = 382
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 41
      Width = 101
      Height = 14
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1090#1086#1074#1072#1088#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape26: TShape
      Left = 167
      Top = 35
      Width = 382
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 18
      Top = 93
      Width = 61
      Height = 14
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape3: TShape
      Left = 166
      Top = 87
      Width = 382
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Memo1: TMemo
      Left = 8
      Top = 120
      Width = 540
      Height = 313
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyPress = Memo1KeyPress
    end
    object leCategory: TdxLookupEdit
      Left = 172
      Top = 37
      Width = 371
      TabOrder = 1
      ListFieldName = 'NAME'
      KeyFieldName = 'G_PRODUCT'
      ListSource = dsProductCategory
      LookupKeyValue = Null
    end
    object lePostavshik: TdxLookupEdit
      Left = 172
      Top = 89
      Width = 371
      Enabled = False
      TabOrder = 4
      ListFieldName = 'NAME'
      KeyFieldName = 'G_CLIENT'
      ListSource = dsPostavshik
      LookupKeyValue = Null
    end
    object rbPriceListOnly: TRadioButton
      Left = 10
      Top = 66
      Width = 143
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' '#1072#1089#1089#1086#1088#1090#1080#1084#1077#1085#1090
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object rbWithPrihod: TRadioButton
      Left = 162
      Top = 66
      Width = 175
      Height = 17
      Caption = #1040#1089#1089#1086#1088#1090#1080#1084#1077#1085#1090' '#1089' '#1087#1088#1080#1093#1086#1076#1086#1084
      TabOrder = 3
      OnClick = rbWithPrihodClick
    end
  end
  object bedtFileName: TdxButtonEdit [3]
    Left = 180
    Top = 20
    Width = 371
    TabOrder = 0
    OnKeyPress = cbUppRowNoKeyPress
    StyleController = dxEditStyleController
    Buttons = <
      item
        Default = True
      end>
    OnButtonClick = bedtFileNameButtonClick
    ExistButtons = True
  end
  inherited dxEditStyleController: TdxEditStyleController
    Top = 456
  end
  inherited dxCheckEditStyleController: TdxCheckEditStyleController
    Top = 456
  end
  object odlg: TOpenDialog
    Filter = 'Excel (*.xls)|*.xls'
    Left = 176
    Top = 136
  end
  object dsProductCategory: TDataSource
    DataSet = spProductCategory
    Left = 495
    Top = 40
  end
  object dsPostavshik: TDataSource
    DataSet = spPostavshik
    Left = 495
    Top = 88
  end
  object spLoad: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_IMPORT_G_PRODUCT (?G_PRODUCT_PAR_, ?G_CLIENT' +
        '_, ?BODY_)')
    StoredProcName = 'G_IMPORT_G_PRODUCT'
    Left = 144
    Top = 136
  end
  object spProductCategory: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_PRODCAT_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 416
    Top = 40
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 384
    Top = 40
  end
  object spPostavshik: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_CLIENT_LIST(?G_CLIENT_PARENT_)')
    Filter = 'is_supplier = 1'
    Transaction = tranRead
    Database = MainDM.dbMain
    Filtered = True
    Left = 448
    Top = 88
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 112
    Top = 136
  end
end
