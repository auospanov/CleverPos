inherited TerminalSetupForm: TTerminalSetupForm
  Caption = #1042#1099#1073#1086#1088' '#1090#1077#1088#1084#1080#1085#1072#1083#1072
  ClientHeight = 131
  ClientWidth = 393
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 399
  ExplicitHeight = 157
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Left = 7
    Top = 5
    Width = 379
    Height = 89
    ExplicitLeft = 7
    ExplicitTop = 5
    ExplicitWidth = 379
    ExplicitHeight = 89
    object shp11: TShape
      Left = 14
      Top = 44
      Width = 141
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shp10: TShape
      Left = 14
      Top = 19
      Width = 141
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object lb5: TLabel
      Left = 22
      Top = 50
      Width = 87
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1074#1077#1089#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shp12: TShape
      Left = 154
      Top = 44
      Width = 209
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object shp13: TShape
      Left = 154
      Top = 19
      Width = 209
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb1: TLabel
      Left = 22
      Top = 24
      Width = 48
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'IP-'#1072#1076#1088#1077#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edIp: TcxTextEdit
      Left = 158
      Top = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 15
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Text = '192.168.0.0'
      Width = 199
    end
    object cbTerminal: TcxComboBox
      Left = 158
      Top = 46
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1073#1088#1077#1085#1076' '#1074#1077#1089#1086#1074
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ParentFont = False
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Kaspi '#1090#1077#1088#1084#1080#1085#1072#1083
        'Jusan '#1090#1077#1088#1084#1080#1085#1072#1083)
      ShowHint = True
      Style.BorderStyle = ebsFlat
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.ButtonTransparency = ebtNone
      Style.IsFontAssigned = True
      TabOrder = 1
      Text = 'Kaspi '#1090#1077#1088#1084#1080#1085#1072#1083
      Width = 199
    end
  end
  inherited btnOk: TcxButton
    Left = 224
    Top = 99
    ExplicitLeft = 224
    ExplicitTop = 99
  end
  inherited btnCancel: TcxButton
    Left = 311
    Top = 99
    ExplicitLeft = 311
    ExplicitTop = 99
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
