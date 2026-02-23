inherited GNonCashPayTypeForm: TGNonCashPayTypeForm
  Left = 558
  Top = 219
  Caption = #1058#1080#1087' '#1073#1077#1079#1085#1072#1083#1080#1095#1085#1086#1081' '#1086#1087#1083#1072#1090#1099
  ClientHeight = 139
  ClientWidth = 496
  OnCreate = FormCreate
  ExplicitWidth = 502
  ExplicitHeight = 165
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 476
    Height = 94
    ExplicitWidth = 476
    ExplicitHeight = 94
    object Shape2: TShape
      Left = 10
      Top = 10
      Width = 119
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 20
      Top = 16
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
    object Shape4: TShape
      Left = 128
      Top = 10
      Width = 339
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object shpTIS: TShape
      Left = 10
      Top = 59
      Width = 119
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shpTIS2: TShape
      Left = 128
      Top = 59
      Width = 339
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lblTIS: TLabel
      Left = 20
      Top = 65
      Width = 94
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099' '#1058#1048#1057
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape1: TShape
      Left = 10
      Top = 34
      Width = 119
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape3: TShape
      Left = 128
      Top = 34
      Width = 339
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 20
      Top = 40
      Width = 57
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1058#1077#1088#1084#1080#1085#1072#1083
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edName: TcxTextEdit
      Left = 133
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 150
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 330
    end
    object cbbTIS: TcxLookupComboBox
      Left = 133
      Top = 61
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsTIS
      Properties.ReadOnly = False
      Style.BorderStyle = ebsFlat
      TabOrder = 1
      Width = 330
    end
    object cbbTerminal: TcxComboBox
      Left = 133
      Top = 36
      Properties.DropDownListStyle = lsFixedList
      Style.BorderStyle = ebsFlat
      TabOrder = 2
      Width = 330
    end
  end
  inherited btnOk: TcxButton
    Left = 326
    Top = 107
    ExplicitLeft = 326
    ExplicitTop = 107
  end
  inherited btnCancel: TcxButton
    Left = 409
    Top = 107
    ExplicitLeft = 409
    ExplicitTop = 107
  end
  inherited btHelp: TcxButton
    Top = 107
    ExplicitTop = 107
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_NONCASH_PAY_TYPE_GET (?G_NONCASH_PAY_TYPE_)')
    StoredProcName = 'G_NONCASH_PAY_TYPE_GET'
    Left = 14
    Top = 324
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_NONCASH_PAY_TYPE_INS (?NAME_, ?IS_TIS_TYPE_,' +
        ' ?POS_TERMINAL_TYPE_)')
    StoredProcName = 'G_NONCASH_PAY_TYPE_INS'
    Left = 46
    Top = 324
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_NONCASH_PAY_TYPE_UPD (?G_NONCASH_PAY_TYPE_, ' +
        '?NAME_, ?IS_TIS_TYPE_, ?POS_TERMINAL_TYPE_)')
    StoredProcName = 'G_NONCASH_PAY_TYPE_UPD'
    Left = 78
    Top = 324
  end
  object dsTIS: TDataSource
    DataSet = MainDM.dxMemDataTIS
    Left = 292
    Top = 408
  end
  object dsTerminal: TDataSource
    Left = 336
    Top = 408
  end
end
