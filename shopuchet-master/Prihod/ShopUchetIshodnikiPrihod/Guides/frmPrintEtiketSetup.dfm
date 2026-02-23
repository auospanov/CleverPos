inherited PrintEtiketSetupForm: TPrintEtiketSetupForm
  Left = 600
  Top = 158
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1077#1095#1072#1090#1080' '#1101#1090#1080#1082#1077#1090#1086#1082
  ClientHeight = 420
  ClientWidth = 572
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 578
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 555
    Height = 375
    ExplicitWidth = 555
    ExplicitHeight = 375
    object Shape3: TShape
      Left = 9
      Top = 35
      Width = 216
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape13: TShape
      Left = 9
      Top = 97
      Width = 216
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape11: TShape
      Left = 9
      Top = 10
      Width = 216
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label6: TLabel
      Left = 16
      Top = 16
      Width = 177
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1080#1085#1090#1077#1088' '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 16
      Top = 103
      Width = 155
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1072#1079#1084#1077#1088' '#1101#1090#1080#1082#1077#1090#1086#1082
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape14: TShape
      Left = 224
      Top = 97
      Width = 321
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Shape12: TShape
      Left = 224
      Top = 10
      Width = 321
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 15
      Top = 41
      Width = 105
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1086#1087#1080#1081
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape4: TShape
      Left = 224
      Top = 35
      Width = 321
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lblCannot1: TLabel
      Left = 23
      Top = 142
      Width = 476
      Height = 28
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 
        #1053#1072' '#1101#1090#1080#1082#1077#1090#1082#1072#1093' '#1074#1099#1089#1086#1090#1086#1081' '#1084#1077#1085#1100#1096#1077' 30 '#1084#1084' '#1087#1086#1083#1103' "'#1062#1077#1085#1072'" '#1080' "'#1057#1083#1086#1075#1072#1085'" '#1073#1091#1076#1091#1090' '#1085 +
        #1072#1082#1083#1072#1076#1099#1074#1072#1090#1100#1089#1103' '#1076#1088#1091#1075#1072' '#1085#1072' '#1076#1088#1091#1075#1072'.'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object cbChooseLentWidth: TComboBox
      Left = 230
      Top = 99
      Width = 310
      Height = 22
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1096#1080#1088#1080#1085#1091' '#1042#1072#1096#1077#1081' '#1083#1077#1085#1090#1099' '#1090#1077#1088#1084#1086#1101#1090#1080#1082#1077#1090#1082#1080
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ItemIndex = 0
      TabOrder = 4
      Text = '29 '#1093' 20 '#1084#1084
      OnChange = cbChooseLentWidthChange
      Items.Strings = (
        '29 '#1093' 20 '#1084#1084
        '30 '#1093' 15 '#1084#1084
        '43 '#1093' 25 '#1084#1084
        '47 '#1093' 25 '#1084#1084
        '57 '#1093' 45 '#1084#1084
        '58 '#1093' 30 '#1084#1084
        '58 '#1093' 40 '#1084#1084
        '58 '#1093' 60 '#1084#1084
        '58 '#1093' 100 '#1084#1084
        '100 '#1093' 70 '#1084#1084)
    end
    object cbPrinters: TComboBox
      Left = 230
      Top = 12
      Width = 310
      Height = 22
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1080#1085#1090#1077#1088', '#1082#1086#1090#1086#1088#1099#1081' '#1073#1091#1076#1077#1090' '#1087#1077#1095#1072#1090#1072#1090#1100' '#1101#1090#1080#1082#1077#1090#1082#1080
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 2
    end
    object rbPrint: TRadioButton
      Left = 16
      Top = 74
      Width = 201
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1077#1095#1072#1090#1100' '#1085#1072' '#1087#1088#1080#1085#1090#1077#1088#1077' '#1101#1090#1080#1082#1077#1090#1086#1082
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbPrintClick
    end
    object rbPrinterA4: TRadioButton
      Left = 288
      Top = 74
      Width = 217
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1077#1095#1072#1090#1100' '#1085#1072' '#1086#1073#1099#1095#1085#1086#1084' '#1087#1088#1080#1085#1090#1077#1088#1077' '#1040'4'
      TabOrder = 1
      OnClick = rbPrintClick
    end
    object grp1: TGroupBox
      Left = 10
      Top = 223
      Width = 536
      Height = 46
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 6
      object lbl2: TLabel
        Left = 376
        Top = 18
        Width = 88
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
      end
      object cbPrintPrice: TCheckBox
        Left = 8
        Top = 18
        Width = 105
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1094#1077#1085#1091
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = cbPrintPriceClick
      end
      object cbPriceBold: TCheckBox
        Left = 209
        Top = 18
        Width = 112
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
        Enabled = False
        TabOrder = 2
      end
      object spnPriceSize: TcxSpinEdit
        Left = 472
        Top = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Properties.CanEdit = False
        Properties.MaxValue = 15.000000000000000000
        Properties.MinValue = -15.000000000000000000
        Style.BorderStyle = ebs3D
        TabOrder = 0
        Value = 7
        Width = 52
      end
    end
    object grp2: TGroupBox
      Left = 8
      Top = 274
      Width = 538
      Height = 89
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 7
      object shp1: TShape
        Left = 9
        Top = 31
        Width = 192
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lbl1: TLabel
        Left = 15
        Top = 36
        Width = 180
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1083#1086#1075#1072#1085' '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080' '#1085#1072' '#1101#1090#1080#1082#1077#1090#1082#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp2: TShape
        Left = 200
        Top = 31
        Width = 331
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object lbl3: TLabel
        Left = 378
        Top = 64
        Width = 88
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
      end
      object cbPrintSlogan: TCheckBox
        Left = 9
        Top = 11
        Width = 505
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 
          #1055#1077#1095#1072#1090#1072#1090#1100' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1073#1083#1086#1082' ('#1085#1072#1079#1074#1072#1085#1080#1077' '#1080#1083#1080' '#1089#1072#1081#1090' '#1084#1072#1075#1072#1079#1080#1085#1072', '#1092#1080#1088#1084#1077#1085#1085#1099#1081' '#1089 +
          #1083#1086#1075#1072#1085' '#1080' '#1090'.'#1076'.)'
        TabOrder = 0
        OnClick = cbPrintSloganClick
      end
      object cbSloganBold: TCheckBox
        Left = 9
        Top = 63
        Width = 117
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
        Enabled = False
        TabOrder = 3
      end
      object spnSloganSize: TcxSpinEdit
        Left = 474
        Top = 62
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Enabled = False
        Properties.CanEdit = False
        Properties.MaxValue = 15.000000000000000000
        Properties.MinValue = -15.000000000000000000
        Style.BorderStyle = ebs3D
        TabOrder = 2
        Value = 7
        Width = 52
      end
      object edSlogan: TcxTextEdit
        Left = 205
        Top = 34
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Enabled = False
        Properties.MaxLength = 30
        Style.BorderStyle = ebsFlat
        Style.StyleController = dxEditStyleController
        TabOrder = 1
        Width = 324
      end
    end
    object edAmount: TcxCurrencyEdit
      Left = 230
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 1.000000000000000000
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = '0'
      Properties.UseLeftAlignmentOnEditing = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 310
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 172
      Width = 536
      Height = 46
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 5
      object Label1: TLabel
        Left = 376
        Top = 18
        Width = 88
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
      end
      object Label3: TLabel
        Left = 8
        Top = 18
        Width = 125
        Height = 14
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
      end
      object cbNameBold: TCheckBox
        Left = 209
        Top = 18
        Width = 112
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
        TabOrder = 1
      end
      object spnNameSize: TcxSpinEdit
        Left = 472
        Top = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Properties.CanEdit = False
        Properties.MaxValue = 15.000000000000000000
        Properties.MinValue = -15.000000000000000000
        Style.BorderStyle = ebs3D
        TabOrder = 0
        Value = 7
        Width = 52
      end
    end
    object cbA4Size: TComboBox
      Left = 230
      Top = 99
      Width = 310
      Height = 22
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1096#1080#1088#1080#1085#1091' '#1042#1072#1096#1077#1081' '#1083#1077#1085#1090#1099' '#1090#1077#1088#1084#1086#1101#1090#1080#1082#1077#1090#1082#1080
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 8
      Text = '38 x 21,2 '#1084#1084
      Visible = False
      OnChange = cbChooseLentWidthChange
      Items.Strings = (
        '38 x 21,2 '#1084#1084
        '48 x 16,9 '#1084#1084)
    end
  end
  inherited btnOk: TcxButton
    Left = 396
    Top = 388
    Width = 79
    Caption = #1055#1077#1095#1072#1090#1100
    ExplicitLeft = 396
    ExplicitTop = 388
    ExplicitWidth = 79
  end
  inherited btnCancel: TcxButton
    Left = 484
    Top = 388
    ExplicitLeft = 484
    ExplicitTop = 388
  end
  object btHelp: TcxButton [3]
    Left = 7
    Top = 388
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1055#1086#1084#1086#1097#1100
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    OptionsImage.Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333336633
      3333333333333FF3333333330000333333364463333333333333388F33333333
      00003333333E66433333333333338F38F3333333000033333333E66333333333
      33338FF8F3333333000033333333333333333333333338833333333300003333
      3333446333333333333333FF3333333300003333333666433333333333333888
      F333333300003333333E66433333333333338F38F333333300003333333E6664
      3333333333338F38F3333333000033333333E6664333333333338F338F333333
      0000333333333E6664333333333338F338F3333300003333344333E666433333
      333F338F338F3333000033336664333E664333333388F338F338F33300003333
      E66644466643333338F38FFF8338F333000033333E6666666663333338F33888
      3338F3330000333333EE666666333333338FF33333383333000033333333EEEE
      E333333333388FFFFF8333330000333333333333333333333333388888333333
      0000}
    OptionsImage.NumGlyphs = 2
    TabOrder = 3
    OnClick = btHelpClick
  end
  inherited ApplicationEvents1: TApplicationEvents
    OnActionExecute = ApplicationEvents1ActionExecute
    Left = 112
    Top = 424
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
