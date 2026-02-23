inherited MyAddressBankRekForm: TMyAddressBankRekForm
  Left = 446
  Top = 276
  Caption = #1041#1072#1085#1082#1086#1074#1089#1082#1080#1077' '#1088#1077#1082#1074#1080#1079#1080#1090#1099
  ClientHeight = 191
  ClientWidth = 593
  OnCreate = FormCreate
  ExplicitWidth = 599
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 573
    Height = 146
    ExplicitWidth = 573
    ExplicitHeight = 146
    object Shape1: TShape
      Left = 8
      Top = 83
      Width = 176
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape25: TShape
      Left = 8
      Top = 9
      Width = 177
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
      Width = 176
      Height = 50
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 88
      Width = 91
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape4: TShape
      Left = 183
      Top = 34
      Width = 382
      Height = 50
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 15
      Width = 26
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1041#1072#1085#1082
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape26: TShape
      Left = 183
      Top = 9
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 18
      Top = 49
      Width = 83
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape3: TShape
      Left = 183
      Top = 83
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object SpeedButton1: TSpeedButton
      Left = 535
      Top = 10
      Width = 23
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000E0000000E0000000100
        0400000000007000000000000000000000001000000000000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3300333333333333330033333333333333003333300033333300333330F03333
        3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
        3300333330F033333300333330F0333333003333300033333300333333333333
        33003333333333333300}
      OnClick = SpeedButton1Click
    end
    object leBank: TcxLookupComboBox
      Left = 188
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_BANK'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsBank
      Properties.OnChange = leBankPropertiesChange
      Style.BorderStyle = ebsFlat
      TabOrder = 0
      Width = 342
    end
    object mMemo: TcxMemo
      Left = 188
      Top = 38
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Enabled = False
      Properties.MaxLength = 200
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Height = 42
      Width = 372
    end
    object edAccount: TcxTextEdit
      Left = 188
      Top = 86
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 2
      OnKeyPress = edAccountKeyPress
      Width = 372
    end
    object ceIsDefault: TcxCheckBox
      Left = 8
      Top = 116
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      Style.StyleController = dxEditStyleController
      TabOrder = 3
      Width = 188
    end
  end
  inherited btnOk: TcxButton
    Left = 421
    Top = 159
    ExplicitLeft = 421
    ExplicitTop = 159
  end
  inherited btnCancel: TcxButton
    Left = 506
    Top = 159
    ExplicitLeft = 506
    ExplicitTop = 159
  end
  inherited btHelp: TcxButton
    Top = 159
    ExplicitTop = 159
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 208
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_FIRM_ACCOUNT (?G_ACCOUNT_)')
    StoredProcName = 'G_GET_G_FIRM_ACCOUNT'
    Left = 16
    Top = 205
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_INS_G_FIRM_ACCOUNT (?ACCOUNT_, ?G_FIRM_REKVI' +
        'ZIT_, ?G_BANK_, ?IS_DEFAULT_)')
    StoredProcName = 'G_INS_G_FIRM_ACCOUNT'
    Left = 48
    Top = 205
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_FIRM_ACCOUNT (?G_ACCOUNT_, ?ACCOUNT_, ' +
        '?G_FIRM_REKVIZIT_, ?G_BANK_, ?IS_DEFAULT_)')
    StoredProcName = 'G_UPD_G_FIRM_ACCOUNT'
    Left = 80
    Top = 205
  end
  object dsBank: TDataSource
    DataSet = spBank
    Left = 495
    Top = 7
  end
  object spBank: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_BANK_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 464
    Top = 8
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
