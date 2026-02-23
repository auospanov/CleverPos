inherited PayDetailsForm: TPayDetailsForm
  Left = 822
  Top = 278
  Caption = #1044#1077#1090#1072#1083#1080' '#1087#1083#1072#1090#1077#1078#1072
  ClientHeight = 204
  ClientWidth = 320
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 326
  ExplicitHeight = 230
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 304
    Height = 159
    Font.Height = -13
    ParentFont = False
    ExplicitWidth = 304
    ExplicitHeight = 159
    object sh5: TShape
      Left = 11
      Top = 119
      Width = 94
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object sh3: TShape
      Left = 11
      Top = 79
      Width = 94
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object sh1: TShape
      Left = 11
      Top = 49
      Width = 94
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shPayment: TShape
      Left = 11
      Top = 19
      Width = 94
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shPayment1: TShape
      Left = 104
      Top = 19
      Width = 157
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lbPayment: TLabel
      Left = 22
      Top = 24
      Width = 35
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1072#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lb1: TLabel
      Left = 22
      Top = 54
      Width = 46
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1091#1084#1084#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object sh2: TShape
      Left = 104
      Top = 49
      Width = 157
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb2: TLabel
      Left = 22
      Top = 84
      Width = 49
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1056#1072#1089#1095#1077#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object sh4: TShape
      Left = 104
      Top = 79
      Width = 157
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb3: TLabel
      Left = 22
      Top = 124
      Width = 36
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1086#1083#1075
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object sh6: TShape
      Left = 104
      Top = 119
      Width = 157
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object sbEqualSumm: TSpeedButton
      Left = 266
      Top = 51
      Width = 27
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Constraints.MaxHeight = 27
      Constraints.MaxWidth = 27
      Constraints.MinHeight = 17
      Constraints.MinWidth = 18
      Glyph.Data = {
        7E000000424D7E000000000000003E0000002800000010000000100000000100
        01000000000040000000C40E0000C40E0000020000000000000000000000FFFF
        FF00FFFF0000FFFF0000FFFF0000E00F0000E00F0000F1AF0000F8EF0000F8FF
        0000FC7F0000FD7F0000FA7F0000F6EF0000F40F0000F80F0000FFFF0000FFFF
        0000}
      OnClick = sbEqualSummClick
    end
    object deDate: TcxDateEdit
      Left = 109
      Top = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.InputKind = ikMask
      Properties.UseLeftAlignmentOnEditing = False
      Style.BorderStyle = ebsFlat
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.ButtonStyle = bts3D
      Style.ButtonTransparency = ebtNone
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 147
    end
    object cbPayment: TcxComboBox
      Left = 109
      Top = 82
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1053#1072#1083#1080#1095#1085#1099#1081
        #1041#1077#1079#1085#1072#1083#1080#1095#1085#1099#1081)
      Style.BorderStyle = ebsFlat
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.ButtonTransparency = ebtNone
      Style.IsFontAssigned = True
      TabOrder = 2
      Text = #1053#1072#1083#1080#1095#1085#1099#1081
      Width = 147
    end
    object edSumm: TcxCurrencyEdit
      Left = 109
      Top = 51
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 0c
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.UseThousandSeparator = True
      Properties.ValidateOnEnter = False
      Properties.OnChange = edSummPropertiesChange
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 147
    end
  end
  inherited btnOk: TcxButton
    Left = 155
    Top = 172
    TabOrder = 2
    ExplicitLeft = 155
    ExplicitTop = 172
  end
  inherited btnCancel: TcxButton
    Left = 237
    Top = 172
    TabOrder = 3
    ExplicitLeft = 237
    ExplicitTop = 172
  end
  object edDolg: TcxCurrencyEdit [3]
    Left = 115
    Top = 123
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    EditValue = 0c
    Enabled = False
    ParentFont = False
    Properties.Alignment.Horz = taRightJustify
    Properties.DisplayFormat = '0.00'
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.StyleController = dxEditStyleController
    Style.IsFontAssigned = True
    TabOrder = 1
    Width = 147
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 72
    Top = 216
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
