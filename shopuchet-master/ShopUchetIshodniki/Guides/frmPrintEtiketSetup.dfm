inherited PrintEtiketSetupForm: TPrintEtiketSetupForm
  Left = 600
  Top = 158
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1077#1095#1072#1090#1080' '#1101#1090#1080#1082#1077#1090#1086#1082
  ClientHeight = 511
  ClientWidth = 572
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 578
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 555
    Height = 466
    ExplicitWidth = 555
    ExplicitHeight = 466
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
    object lb7: TLabel
      Left = 16
      Top = 534
      Width = 147
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1076#1074#1080#1075' '#1095#1077#1082#1072' ('#1086#1090' -60 '#1076#1086' 60)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
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
      TabOrder = 0
      Width = 310
    end
    object seSdvig: TcxSpinEdit
      Left = 188
      Top = 530
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.CanEdit = False
      Properties.MaxValue = 60.000000000000000000
      Properties.MinValue = -60.000000000000000000
      Properties.SpinButtons.ShowFastButtons = True
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Visible = False
      Width = 351
    end
    object pcPrintMode: TcxPageControl
      Left = 2
      Top = 71
      Width = 551
      Height = 393
      Align = alBottom
      TabOrder = 2
      Properties.ActivePage = tsCennik
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 393
      ClientRectRight = 551
      ClientRectTop = 25
      object tsEtiket: TcxTabSheet
        Caption = #1069#1090#1080#1082#1077#1090#1082#1080
        ImageIndex = 0
        object Shape13: TShape
          Left = 7
          Top = 33
          Width = 216
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label7: TLabel
          Left = 17
          Top = 39
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
          Left = 222
          Top = 33
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
          Top = 68
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
        object grp1: TGroupBox
          Left = 7
          Top = 105
          Width = 536
          Height = 46
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 0
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
          object spnPriceSize: TcxSpinEdit
            Left = 472
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.CanEdit = False
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 4.000000000000000000
            Style.BorderStyle = ebsFlat
            TabOrder = 0
            Value = 7
            Width = 52
          end
          object cbPrintPrice: TcxCheckBox
            Left = 5
            Top = 15
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1094#1077#1085#1091
            ParentShowHint = False
            ShowHint = True
            State = cbsChecked
            Style.StyleController = dxEditStyleController
            TabOrder = 1
            OnClick = cbPrintPriceClick
            Width = 132
          end
          object cbPriceBold: TcxCheckBox
            Left = 205
            Top = 15
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 2
            Width = 132
          end
        end
        object grp3: TGroupBox
          Left = 7
          Top = 159
          Width = 536
          Height = 46
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 1
          object lb1: TLabel
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
          object spnArticulSize: TcxSpinEdit
            Left = 472
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.CanEdit = False
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 4.000000000000000000
            Style.BorderStyle = ebsFlat
            TabOrder = 0
            Value = 7
            Width = 52
          end
          object cbPrintArticul: TcxCheckBox
            Left = 5
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1072#1088#1090#1080#1082#1091#1083
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 1
            OnClick = cbPrintArticulClick
            Width = 132
          end
          object cbArticulBold: TcxCheckBox
            Left = 205
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 2
            Width = 132
          end
        end
        object grp4: TGroupBox
          Left = 7
          Top = 209
          Width = 536
          Height = 46
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 2
          object lb2: TLabel
            Left = 376
            Top = 20
            Width = 88
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
          end
          object lb3: TLabel
            Left = 8
            Top = 20
            Width = 125
            Height = 14
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
          end
          object spnNameSize: TcxSpinEdit
            Left = 472
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.CanEdit = False
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 4.000000000000000000
            Style.BorderStyle = ebsFlat
            TabOrder = 0
            Value = 7
            Width = 52
          end
          object cbNameBold: TcxCheckBox
            Left = 205
            Top = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 1
            Width = 132
          end
        end
        object grp2: TGroupBox
          Left = 7
          Top = 259
          Width = 536
          Height = 101
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 3
          object shp1: TShape
            Left = 9
            Top = 35
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
            Top = 40
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
            Top = 35
            Width = 331
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object lbl3: TLabel
            Left = 376
            Top = 73
            Width = 88
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
          end
          object spnSloganSize: TcxSpinEdit
            Left = 472
            Top = 70
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.CanEdit = False
            Properties.MaxValue = 15.000000000000000000
            Properties.MinValue = -15.000000000000000000
            Style.BorderStyle = ebsFlat
            TabOrder = 1
            Value = 7
            Width = 52
          end
          object edSlogan: TcxTextEdit
            Left = 205
            Top = 38
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.MaxLength = 30
            Style.BorderStyle = ebsFlat
            Style.StyleController = dxEditStyleController
            TabOrder = 0
            Width = 324
          end
          object cbPrintSlogan: TcxCheckBox
            Left = 5
            Top = 9
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 
              #1055#1077#1095#1072#1090#1072#1090#1100' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1073#1083#1086#1082' ('#1085#1072#1079#1074#1072#1085#1080#1077' '#1080#1083#1080' '#1089#1072#1081#1090' '#1084#1072#1075#1072#1079#1080#1085#1072', '#1092#1080#1088#1084#1077#1085#1085#1099#1081' '#1089 +
              #1083#1086#1075#1072#1085' '#1080' '#1090'.'#1076'.)'
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 2
            OnClick = cbPrintSloganClick
            Width = 518
          end
          object cbSloganBold: TcxCheckBox
            Left = 5
            Top = 69
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 3
            Width = 132
          end
        end
        object rbPrint: TcxRadioButton
          Left = 12
          Top = 9
          Width = 224
          Height = 17
          Caption = #1055#1077#1095#1072#1090#1100' '#1085#1072' '#1087#1088#1080#1085#1090#1077#1088#1077' '#1101#1090#1080#1082#1077#1090#1086#1082
          Checked = True
          TabOrder = 4
          TabStop = True
          OnClick = rbPrintClick
          LookAndFeel.Kind = lfFlat
        end
        object rbPrinterA4: TcxRadioButton
          Left = 304
          Top = 9
          Width = 224
          Height = 17
          Caption = #1055#1077#1095#1072#1090#1100' '#1085#1072' '#1086#1073#1099#1095#1085#1086#1084' '#1087#1088#1080#1085#1090#1077#1088#1077' '#1040'4'
          TabOrder = 5
          OnClick = rbPrintClick
          LookAndFeel.Kind = lfFlat
        end
        object cbA4Size: TcxComboBox
          Left = 228
          Top = 36
          Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1072#1079#1084#1077#1088' '#1101#1090#1080#1082#1077#1090#1082#1080' '#1085#1072' '#1083#1080#1089#1090#1077' '#1040'4'
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ParentFont = False
          ParentShowHint = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '38 x 21,2 '#1084#1084
            '48 x 16,9 '#1084#1084
            '50 '#1093' 70 '#1084#1084
            '70 x 35 '#1084#1084)
          Properties.OnChange = cbChooseLentWidthChange
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
          TabOrder = 6
          Width = 310
        end
        object cbChooseLentWidth: TcxComboBox
          Left = 228
          Top = 36
          Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1096#1080#1088#1080#1085#1091' '#1042#1072#1096#1077#1081' '#1083#1077#1085#1090#1099' '#1090#1077#1088#1084#1086#1101#1090#1080#1082#1077#1090#1082#1080
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ParentFont = False
          ParentShowHint = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '29 '#1093' 20 '#1084#1084
            '30 '#1093' 15 '#1084#1084
            '43 '#1093' 25 '#1084#1084
            '47 '#1093' 25 '#1084#1084
            '57 '#1093' 45 '#1084#1084
            '58 '#1093' 30 '#1084#1084
            '58 '#1093' 40 '#1084#1084
            '58 '#1093' 60 '#1084#1084
            '58 '#1093' 100 '#1084#1084
            '100 '#1093' 70 '#1084#1084
            '66 '#1093' 15 '#1084#1084' ('#1102#1074#1077#1083#1080#1088#1085#1099#1077' '#1091#1082#1088#1072#1096#1077#1085#1080#1103')')
          Properties.OnChange = cbChooseLentWidthChange
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
          TabOrder = 7
          Width = 309
        end
      end
      object tsCennik: TcxTabSheet
        Caption = #1062#1077#1085#1085#1080#1082#1080
        ImageIndex = 1
        object Shape1: TShape
          Left = 7
          Top = 33
          Width = 216
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label4: TLabel
          Left = 17
          Top = 39
          Width = 158
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1072#1079#1084#1077#1088' '#1094#1077#1085#1085#1080#1082#1086#1074
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape2: TShape
          Left = 222
          Top = 33
          Width = 321
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object grp5: TGroupBox
          Left = 7
          Top = 105
          Width = 536
          Height = 46
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 0
          object lb4: TLabel
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
          object spnCennikPriceSize: TcxSpinEdit
            Left = 472
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.AssignedValues.MaxValue = True
            Properties.CanEdit = False
            Properties.MinValue = 4.000000000000000000
            Style.BorderStyle = ebsFlat
            TabOrder = 0
            Value = 7
            Width = 52
          end
          object cbCennikPrintPrice: TcxCheckBox
            Left = 5
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1094#1077#1085#1091
            ParentShowHint = False
            ShowHint = True
            State = cbsChecked
            Style.StyleController = dxEditStyleController
            TabOrder = 1
            OnClick = cbCennikPrintPriceClick
            Width = 132
          end
          object cbCennikPriceBold: TcxCheckBox
            Left = 205
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 2
            Width = 132
          end
        end
        object grp6: TGroupBox
          Left = 7
          Top = 209
          Width = 536
          Height = 46
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 1
          object lb5: TLabel
            Left = 376
            Top = 20
            Width = 88
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
          end
          object lb6: TLabel
            Left = 8
            Top = 20
            Width = 125
            Height = 14
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
          end
          object spnCennikNameSize: TcxSpinEdit
            Left = 472
            Top = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.AssignedValues.MaxValue = True
            Properties.CanEdit = False
            Properties.MinValue = 4.000000000000000000
            Style.BorderStyle = ebsFlat
            TabOrder = 0
            Value = 7
            Width = 52
          end
          object cbCennikNameBold: TcxCheckBox
            Left = 205
            Top = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 1
            Width = 132
          end
        end
        object grp7: TGroupBox
          Left = 7
          Top = 259
          Width = 536
          Height = 100
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 2
          object shp3: TShape
            Left = 9
            Top = 36
            Width = 192
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object lb8: TLabel
            Left = 15
            Top = 41
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
          object shp4: TShape
            Left = 200
            Top = 36
            Width = 331
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object lb9: TLabel
            Left = 376
            Top = 72
            Width = 88
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
          end
          object spnCennikSloganSize: TcxSpinEdit
            Left = 474
            Top = 69
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.AssignedValues.MaxValue = True
            Properties.CanEdit = False
            Properties.MinValue = 4.000000000000000000
            Style.BorderStyle = ebsFlat
            TabOrder = 1
            Value = 7
            Width = 52
          end
          object edCennikSlogan: TcxTextEdit
            Left = 205
            Top = 39
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.MaxLength = 30
            Style.BorderStyle = ebsFlat
            Style.StyleController = dxEditStyleController
            TabOrder = 0
            Width = 324
          end
          object cbCennikPrintSlogan: TcxCheckBox
            Left = 5
            Top = 9
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 
              #1055#1077#1095#1072#1090#1072#1090#1100' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1073#1083#1086#1082' ('#1085#1072#1079#1074#1072#1085#1080#1077' '#1080#1083#1080' '#1089#1072#1081#1090' '#1084#1072#1075#1072#1079#1080#1085#1072', '#1092#1080#1088#1084#1077#1085#1085#1099#1081' '#1089 +
              #1083#1086#1075#1072#1085' '#1080' '#1090'.'#1076'.)'
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 2
            OnClick = cbCennikPrintSloganClick
            Width = 518
          end
          object cbCennikSloganBold: TcxCheckBox
            Left = 5
            Top = 68
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
            ParentShowHint = False
            ShowHint = True
            Style.StyleController = dxEditStyleController
            TabOrder = 3
            Width = 132
          end
        end
        object cbCennikSize: TcxComboBox
          Left = 226
          Top = 36
          Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1072#1079#1084#1077#1088' '#1094#1077#1085#1085#1080#1082#1072
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ParentFont = False
          ParentShowHint = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '35 x 60 '#1084#1084
            '40 x 60 '#1084#1084
            '70 x 24.5 '#1084#1084
            '70 x 35 '#1084#1084
            #1051#1080#1089#1090' '#1040'5')
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
          TabOrder = 3
          Width = 314
        end
      end
    end
    object cbPrinters: TcxComboBox
      Left = 230
      Top = 13
      Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1080#1085#1090#1077#1088', '#1082#1086#1090#1086#1088#1099#1081' '#1073#1091#1076#1077#1090' '#1087#1077#1095#1072#1090#1072#1090#1100' '#1101#1090#1080#1082#1077#1090#1082#1080
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ParentFont = False
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
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
      TabOrder = 3
      Width = 310
    end
  end
  inherited btnOk: TcxButton
    Left = 396
    Top = 479
    Width = 79
    Caption = #1055#1077#1095#1072#1090#1100
    ExplicitLeft = 396
    ExplicitTop = 479
    ExplicitWidth = 79
  end
  inherited btnCancel: TcxButton
    Left = 484
    Top = 479
    ExplicitLeft = 484
    ExplicitTop = 479
  end
  object btHelp: TcxButton [3]
    Left = 7
    Top = 479
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
    Left = 120
    Top = 512
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
