inherited PsevdLogonForm: TPsevdLogonForm
  Left = 323
  Top = 326
  Caption = #1042#1099#1073#1086#1088' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
  ClientHeight = 145
  ClientWidth = 351
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 357
  ExplicitHeight = 171
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Top = 8
    Width = 338
    Height = 97
    ExplicitTop = 8
    ExplicitWidth = 338
    ExplicitHeight = 97
    object Shape3: TShape
      Left = 8
      Top = 60
      Width = 65
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 34
      Width = 65
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 313
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1077#1073#1103' '#1074' '#1089#1087#1080#1089#1082#1077' '#1080' '#1074#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 18
      Top = 40
      Width = 27
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1060#1048#1054
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape4: TShape
      Left = 72
      Top = 34
      Width = 260
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label3: TLabel
      Left = 18
      Top = 66
      Width = 41
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1072#1088#1086#1083#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape1: TShape
      Left = 72
      Top = 60
      Width = 260
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object leIspolnitel: TcxLookupComboBox
      Left = 77
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_OFFICIAL'
      Properties.ListColumns = <
        item
          FieldName = 'FIO_DOC'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsIspolnitel
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 250
    end
    object edPassword: TcxTextEdit
      Left = 77
      Top = 62
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.EchoMode = eemPassword
      Properties.PasswordChar = '*'
      Properties.OnChange = edPasswordPropertiesChange
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 250
    end
  end
  inherited btnOk: TcxButton
    Left = 188
    Top = 112
    ExplicitLeft = 188
    ExplicitTop = 112
  end
  inherited btnCancel: TcxButton
    Left = 270
    Top = 112
    ExplicitLeft = 270
    ExplicitTop = 112
  end
  inherited btHelp: TcxButton
    Top = 154
    ExplicitTop = 154
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object spIspolnitel: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_OFFICIAL_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 152
    Top = 32
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsIspolnitel: TDataSource
    DataSet = spIspolnitel
    Left = 184
    Top = 31
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 72
    Top = 160
  end
end
