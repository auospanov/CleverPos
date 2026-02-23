inherited MyFirmAddressForm: TMyFirmAddressForm
  Left = 644
  Top = 229
  Caption = #1040#1076#1088#1077#1089
  ClientHeight = 191
  ClientWidth = 591
  OnCreate = FormCreate
  ExplicitWidth = 597
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 571
    Height = 146
    ExplicitWidth = 571
    ExplicitHeight = 146
    object Shape5: TShape
      Left = 8
      Top = 84
      Width = 176
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape1: TShape
      Left = 8
      Top = 59
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
      Top = 40
      Width = 35
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1040#1076#1088#1077#1089
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
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 15
      Width = 65
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1058#1080#1087' '#1072#1076#1088#1077#1089#1072
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
      Top = 65
      Width = 53
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1058#1077#1083#1077#1092#1086#1085
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
      Top = 59
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label3: TLabel
      Left = 18
      Top = 90
      Width = 28
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1060#1072#1082#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape6: TShape
      Left = 183
      Top = 84
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
      Action = aInsAddressType
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000E0000000E0000000100
        0400000000007000000000000000000000001000000000000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3300333333333333330033333333333333003333300033333300333330F03333
        3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
        3300333330F033333300333330F0333333003333300033333300333333333333
        33003333333333333300}
    end
    object leAddressType: TcxLookupComboBox
      Left = 188
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_ADDRESS_TYPE'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsMyFirmAddressCategory
      Style.BorderStyle = ebsFlat
      TabOrder = 0
      Width = 344
    end
    object edAddress: TcxTextEdit
      Left = 188
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 500
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 372
    end
    object edFax: TcxTextEdit
      Left = 188
      Top = 86
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 20
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 3
      Width = 372
    end
    object edPhone: TcxTextEdit
      Left = 188
      Top = 61
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 20
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 2
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
      TabOrder = 4
      Width = 188
    end
  end
  inherited btnOk: TcxButton
    Left = 423
    Top = 159
    ExplicitLeft = 423
    ExplicitTop = 159
  end
  inherited btnCancel: TcxButton
    Left = 504
    Top = 159
    ExplicitLeft = 504
    ExplicitTop = 159
  end
  inherited btHelp: TcxButton
    Top = 159
    ExplicitTop = 159
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 200
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    object aInsAddressType: TAction
      OnExecute = aInsAddressTypeExecute
    end
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_FIRM_ADDRESS (?G_ADDRESS_)')
    StoredProcName = 'G_GET_G_FIRM_ADDRESS'
    Left = 8
    Top = 197
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_INS_G_FIRM_ADDRESS (?G_ADDRESS_TYPE_, ?G_FIR' +
        'M_REKVIZIT_, ?ADDRESS_, ?PHONE_, ?FAX_, ?IS_DEFAULT_)')
    StoredProcName = 'G_INS_G_FIRM_ADDRESS'
    Left = 40
    Top = 197
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_FIRM_ADDRESS (?G_ADDRESS_, ?G_ADDRESS_' +
        'TYPE_, ?G_FIRM_REKVIZIT_, ?ADDRESS_, ?PHONE_, ?FAX_, ?IS_DEFAULT' +
        '_)')
    StoredProcName = 'G_UPD_G_FIRM_ADDRESS'
    Left = 72
    Top = 197
  end
  object dsMyFirmAddressCategory: TDataSource
    DataSet = spMyFirmAddressCategory
    Left = 375
    Top = 7
  end
  object spMyFirmAddressCategory: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_ADDRESS_TYPE_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 336
    Top = 8
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
