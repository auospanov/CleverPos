inherited ClientAddressForm: TClientAddressForm
  Left = 577
  Top = 455
  Caption = #1040#1076#1088#1077#1089' '#1082#1083#1080#1077#1085#1090#1072'/'#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
  ClientHeight = 233
  ClientWidth = 586
  OnCreate = FormCreate
  ExplicitWidth = 592
  ExplicitHeight = 259
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 572
    Height = 193
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitWidth = 572
    ExplicitHeight = 193
    object Shape7: TShape
      Left = 8
      Top = 109
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape5: TShape
      Left = 8
      Top = 84
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape1: TShape
      Left = 8
      Top = 59
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape25: TShape
      Left = 8
      Top = 9
      Width = 177
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 34
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 40
      Width = 35
      Height = 14
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
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 15
      Width = 65
      Height = 14
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
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 18
      Top = 65
      Width = 53
      Height = 14
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
      Pen.Color = clBtnShadow
    end
    object Label3: TLabel
      Left = 18
      Top = 90
      Width = 28
      Height = 14
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
      Pen.Color = clBtnShadow
    end
    object Label4: TLabel
      Left = 18
      Top = 115
      Width = 31
      Height = 14
      Caption = 'E-mail'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape8: TShape
      Left = 183
      Top = 109
      Width = 382
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Shape9: TShape
      Left = 8
      Top = 134
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label5: TLabel
      Left = 18
      Top = 140
      Width = 46
      Height = 14
      Caption = #1042#1077#1073#1089#1072#1081#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape14: TShape
      Left = 183
      Top = 134
      Width = 382
      Height = 26
      Pen.Color = clBtnShadow
    end
    object SpeedButton1: TSpeedButton
      Left = 537
      Top = 11
      Width = 22
      Height = 22
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
      Left = 190
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'G_ADDRESS_TYPE'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsClientAddressCategory
      Style.StyleController = dxEditStyleController
      Style.ButtonTransparency = ebtNone
      TabOrder = 0
      Width = 341
    end
    object edAddress: TcxTextEdit
      Left = 190
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 500
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 368
    end
    object edPhone: TcxTextEdit
      Left = 190
      Top = 62
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 20
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 2
      Width = 368
    end
    object edFax: TcxTextEdit
      Left = 190
      Top = 87
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 50
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 3
      Width = 368
    end
    object edEmail: TcxTextEdit
      Left = 190
      Top = 112
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 100
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 4
      Width = 368
    end
    object edWebsite: TcxTextEdit
      Left = 190
      Top = 137
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 100
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 5
      Width = 368
    end
    object ceIsDefault: TcxCheckBox
      Left = 8
      Top = 166
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      Style.StyleController = dxEditStyleController
      TabOrder = 6
      Width = 188
    end
  end
  inherited btnOk: TcxButton
    Left = 417
    Top = 201
    ExplicitLeft = 417
    ExplicitTop = 201
  end
  inherited btnCancel: TcxButton
    Left = 503
    Top = 201
    ExplicitLeft = 503
    ExplicitTop = 201
  end
  inherited btHelp: TcxButton
    Left = 7
    Top = 201
    ExplicitLeft = 7
    ExplicitTop = 201
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
      'EXECUTE PROCEDURE G_GET_G_ADDRESS (?G_ADDRESS_)')
    StoredProcName = 'G_GET_G_ADDRESS'
    Left = 312
    Top = 269
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_INS_G_ADDRESS (?G_ADDRESS_TYPE_, ?G_CLIENT_,' +
        ' ?ADDRESS_, ?PHONE_, ?FAX_, ?EMAIL_, ?WEBSITE_, ?IS_DEFAULT_)')
    StoredProcName = 'G_INS_G_ADDRESS'
    Left = 344
    Top = 269
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_ADDRESS (?G_ADDRESS_, ?G_ADDRESS_TYPE_' +
        ', ?G_CLIENT_, ?ADDRESS_, ?PHONE_, ?FAX_, ?EMAIL_, ?WEBSITE_, ?IS' +
        '_DEFAULT_)')
    StoredProcName = 'G_UPD_G_ADDRESS'
    Left = 376
    Top = 269
  end
  object dsClientAddressCategory: TDataSource
    DataSet = spClientAddressCategory
    Left = 375
    Top = 7
  end
  object spClientAddressCategory: TpFIBDataSet
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
