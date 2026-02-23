inherited ClientDateFilterForm: TClientDateFilterForm
  Left = 468
  Top = 144
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 501
  ClientWidth = 634
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 640
  ExplicitHeight = 527
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 618
    Height = 457
    ExplicitWidth = 618
    ExplicitHeight = 457
    object PageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 614
      Height = 453
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tsDates
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 5
      OnChange = PageControlChange
      ClientRectBottom = 453
      ClientRectRight = 614
      ClientRectTop = 25
      object tsPredzakaz: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1088#1077#1076#1079#1072#1082#1072#1079' '#1090#1086#1074#1072#1088#1086#1074
        ImageIndex = 3
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          614
          428)
        object sh21: TShape
          Left = 15
          Top = 36
          Width = 238
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh19: TShape
          Left = 15
          Top = 112
          Width = 237
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh17: TShape
          Left = 15
          Top = 87
          Width = 237
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh14: TShape
          Left = 15
          Top = 61
          Width = 237
          Height = 27
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh13: TShape
          Left = 15
          Top = 11
          Width = 238
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object lb7: TLabel
          Left = 22
          Top = 17
          Width = 109
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1047#1072#1082#1072#1079#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1076#1086
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lb8: TLabel
          Left = 22
          Top = 67
          Width = 192
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1080#1073#1072#1074#1080#1090#1100' '#1082#1086#1083'-'#1074#1086' '#1090#1086#1074#1072#1088#1086#1074' '#1089#1074#1077#1088#1093#1091
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh15: TShape
          Left = 251
          Top = 11
          Width = 356
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object sh16: TShape
          Left = 251
          Top = 61
          Width = 356
          Height = 27
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Pen.Color = clBtnShadow
        end
        object lb9: TLabel
          Left = 22
          Top = 92
          Width = 186
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1087#1086#1083#1091#1095#1080#1074#1096#1077#1077#1089#1103' '#1082#1086#1083'-'#1074#1086
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh18: TShape
          Left = 251
          Top = 87
          Width = 136
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lb10: TLabel
          Left = 22
          Top = 119
          Width = 221
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1089#1086#1079#1076#1072#1090#1100' '#1087#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh20: TShape
          Left = 251
          Top = 112
          Width = 136
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lbMode0: TLabel
          Left = 16
          Top = 152
          Width = 506
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1056#1077#1078#1080#1084' "'#1047#1072#1082#1072#1079#1072#1090#1100' '#1076#1086' '#1084#1080#1085#1080#1084#1072#1083#1100#1085#1086#1075#1086' '#1086#1089#1090#1072#1090#1082#1072'" - '#1076#1086#1079#1072#1082#1072#1079' '#1090#1086#1074#1072#1088#1072' '#1076#1086' '#1084#1080#1085 +
            #1080#1084#1072#1083#1100#1085#1086#1075#1086' '#1086#1089#1090#1072#1090#1082#1072', '#1082#1086#1090#1086#1088#1099#1081' '#1079#1072#1076#1072#1077#1090#1089#1103' '#1074' "'#1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1077' '#1090#1086#1074#1072#1088#1086#1074'".'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lb12: TLabel
          Left = 22
          Top = 42
          Width = 137
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1052#1077#1090#1086#1076' '#1074#1099#1073#1086#1088#1082#1080' '#1090#1086#1074#1072#1088#1086#1074
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh22: TShape
          Left = 251
          Top = 36
          Width = 356
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lb13: TLabel
          Left = 16
          Top = 285
          Width = 535
          Height = 126
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1055#1088#1080' '#1089#1086#1079#1076#1072#1085#1080#1080' '#1087#1088#1080#1093#1086#1076#1085#1086#1081' '#1085#1072#1082#1083#1072#1076#1085#1086#1081', '#1085#1072#1082#1083#1072#1076#1085#1072#1103' '#1089#1103#1076#1077#1090' '#1082#1072#1082' '#1085#1077#1086#1087#1083#1072#1095#1077#1085#1085 +
            #1072#1103', '#1087#1086#1089#1083#1077' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1086#1089#1091#1097#1077#1089#1090#1074#1083#1077#1085#1080#1103' '#1079#1072#1082#1091#1087#1072', '#1042#1072#1084' '#1085#1091#1078#1085#1086' '#1073#1091#1076#1077#1090' '#1085#1072#1081 +
            #1090#1080' '#1077#1077' '#1080' '#1074#1099#1089#1090#1072#1074#1080#1090#1100' '#1086#1087#1083#1072#1095#1077#1085#1085#1091#1102' '#1089#1091#1084#1084#1091'.'#13#10#1055#1088#1080' '#1089#1086#1079#1076#1072#1085#1080#1080' '#1087#1088#1080#1093#1086#1076#1085#1086#1081' '#1085#1072#1082#1083 +
            #1072#1076#1085#1086#1081', '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1073#1091#1076#1077#1090' '#1086#1088#1080#1077#1085#1090#1080#1088#1086#1074#1072#1090#1100#1089#1103' '#1085#1072' '#1094#1077#1085#1091' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1079#1072#1082#1091#1087#1082#1080 +
            '.'#13#10#13#10#13#10#1045#1089#1083#1080' '#1091' '#1042#1072#1089' '#1085#1077#1089#1082#1086#1083#1100#1082#1086' '#1090#1086#1095#1077#1082'/'#1089#1082#1083#1072#1076#1086#1074', '#1090#1086' '#1087#1088#1086#1094#1077#1089#1089' '#1073#1091#1076#1077#1090' '#1079#1072#1087#1091 +
            #1097#1077#1085' '#1087#1086' '#1090#1077#1082#1091#1097#1077#1084#1091' '#1089#1082#1083#1072#1076#1091', '#1082#1086#1090#1086#1088#1099#1081' '#1074#1099#1073#1088#1072#1085' '#1074' '#1084#1077#1085#1102' "'#1057#1077#1088#1074#1080#1089' - '#1057#1082#1083#1072#1076#1099'".'
          WordWrap = True
        end
        object lbVybor1: TLabel
          Left = 16
          Top = 237
          Width = 494
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1055#1086#1083#1077' "'#1052#1077#1090#1086#1076' '#1074#1099#1073#1086#1088#1082#1080'" - '#1073#1091#1076#1091#1090' '#1074#1099#1073#1088#1072#1085#1099' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099', '#1082#1086#1090#1086#1088#1099#1077' '#1087#1086#1087#1072#1076#1072#1102 +
            #1090' '#1087#1086' '#1091#1089#1083#1086#1074#1080#1102' '#1074' '#1087#1086#1083#1077' "'#1047#1072#1082#1072#1079#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1076#1086'".'
          WordWrap = True
        end
        object lbVybor2: TLabel
          Left = 16
          Top = 229
          Width = 528
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1055#1086#1083#1077' "'#1052#1077#1090#1086#1076' '#1074#1099#1073#1086#1088#1082#1080'" - '#1073#1091#1076#1091#1090' '#1074#1099#1073#1088#1072#1085#1099' '#1090#1086#1074#1072#1088#1099', '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1077' '#1086#1090' '#1082#1086#1085#1082#1088 +
            #1077#1090#1085#1086#1075#1086' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072' '#1080' '#1082#1086#1090#1086#1088#1099#1077' '#1087#1086#1087#1072#1076#1072#1102#1090' '#1074' '#1091#1089#1083#1086#1074#1080#1077' '#1074' '#1087#1086#1083#1077' "'#1047#1072#1082#1072#1079#1072#1090#1100' ' +
            #1090#1086#1074#1072#1088#1099' '#1076#1086'".'
          Visible = False
          WordWrap = True
        end
        object lbVybor3: TLabel
          Left = 16
          Top = 229
          Width = 479
          Height = 42
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1055#1086#1083#1077' "'#1052#1077#1090#1086#1076' '#1074#1099#1073#1086#1088#1082#1080'" - '#1073#1091#1076#1091#1090' '#1074#1099#1073#1088#1072#1085#1099' '#1090#1086#1074#1072#1088#1099', '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1077' '#1086#1090' '#1082#1086#1085#1082#1088 +
            #1077#1090#1085#1086#1075#1086' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072' '#1079#1072' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1074#1088#1077#1084#1077#1085#1080', '#1080' '#1082#1086#1090#1086#1088#1099#1077' '#1087#1086#1087#1072#1076#1072#1102 +
            #1090' '#1074' '#1091#1089#1083#1086#1074#1080#1077' '#1074' '#1087#1086#1083#1077' "'#1047#1072#1082#1072#1079#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1076#1086'".'
          Visible = False
          WordWrap = True
        end
        object lbMode1: TLabel
          Left = 16
          Top = 154
          Width = 564
          Height = 42
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1056#1077#1078#1080#1084' "'#1047#1072#1082#1072#1079#1072#1090#1100' '#1076#1086' '#1085#1091#1083#1077#1074#1086#1075#1086' '#1086#1089#1090#1072#1090#1082#1072'" - '#1076#1086#1079#1072#1082#1072#1079' '#1090#1086#1074#1072#1088#1072' '#1076#1086' '#1085#1091#1083#1077#1074#1086#1075 +
            #1086' '#1086#1089#1090#1072#1090#1082#1072' '#1085#1072' '#1089#1082#1083#1072#1076#1077'. '#1048#1084#1077#1077#1090' '#1089#1084#1099#1089#1083' '#1074' '#1090#1086#1084' '#1089#1083#1091#1095#1072#1077', '#1077#1089#1083#1080' '#1084#1072#1075#1072#1079#1080#1085' '#1087#1088#1086#1076 +
            #1072#1077#1090' '#1090#1086#1074#1072#1088#1099' '#1074' '#1084#1080#1085#1091#1089' '#1080' '#1074' '#1073#1072#1079#1077' '#1080#1084#1077#1102#1090#1089#1103' '#1090#1086#1074#1072#1088#1099' '#1089' '#1084#1080#1085#1091#1089#1086#1074#1099#1084' '#1086#1089#1090#1072#1090#1082#1086#1084'.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
          WordWrap = True
        end
        object rbUnit: TcxRadioButton
          Left = 397
          Top = 64
          Width = 65
          Height = 17
          Hint = #1055#1088#1080#1073#1072#1074#1080#1090#1100' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1096#1090#1091#1082#1072#1093
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1064#1090#1091#1082#1080
          Checked = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          TabStop = True
          OnClick = rbUnitClick
          LookAndFeel.Kind = lfFlat
        end
        object rbProcent: TcxRadioButton
          Left = 470
          Top = 65
          Width = 81
          Height = 17
          Hint = #1055#1088#1080#1073#1072#1074#1080#1090#1100' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1087#1088#1086#1094#1077#1085#1090#1072#1093
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1086#1094#1077#1085#1090#1099
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = rbUnitClick
          LookAndFeel.Kind = lfFlat
        end
        object cbbRound: TcxComboBox
          Left = 255
          Top = 90
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Enabled = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1044#1086' '#1094#1077#1083#1099#1093
            #1044#1086' '#1076#1077#1089#1103#1090#1082#1086#1074
            #1044#1086' '#1089#1086#1090#1077#1085
            #1044#1086' '#1090#1099#1089#1103#1095)
          Style.BorderStyle = ebsFlat
          Style.PopupBorderStyle = epbsDefault
          TabOrder = 5
          Width = 128
        end
        object edAmountAdd: TcxCurrencyEdit
          Left = 255
          Top = 64
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          ParentShowHint = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.UseDisplayFormatWhenEditing = True
          Properties.UseLeftAlignmentOnEditing = False
          Properties.UseThousandSeparator = True
          Properties.ValidateOnEnter = False
          ShowHint = True
          Style.StyleController = dxEditStyleController
          TabOrder = 2
          Width = 128
        end
        object cbDoSklad: TcxComboBox
          Left = 255
          Top = 115
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1053#1077#1090
            #1044#1072)
          Properties.OnChange = cbModeChange
          Style.StyleController = dxEditStyleController
          TabOrder = 6
          Text = #1053#1077#1090
          Width = 128
        end
        object cbMetodVybora: TcxComboBox
          Left = 255
          Top = 38
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
            #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
            #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1087#1088#1080#1096#1077#1076#1096#1080#1077' '#1079#1072' '#1087#1077#1088#1080#1086#1076' '#1076#1072#1090)
          Properties.OnChange = cbMetodVyboraChange
          Style.StyleController = dxEditStyleController
          TabOrder = 1
          Text = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
          Width = 348
        end
        object cbPredzakazMode: TcxComboBox
          Left = 255
          Top = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1084#1080#1085#1080#1084#1072#1083#1100#1085#1086#1075#1086' '#1086#1089#1090#1072#1090#1082#1072
            #1085#1091#1083#1077#1074#1086#1075#1086' '#1086#1089#1090#1072#1090#1082#1072)
          Properties.OnChange = cbPredzakazModeChange
          Style.StyleController = dxEditStyleController
          TabOrder = 0
          Text = #1084#1080#1085#1080#1084#1072#1083#1100#1085#1086#1075#1086' '#1086#1089#1090#1072#1090#1082#1072
          Width = 348
        end
      end
      object tsDates: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1044#1072#1090#1072
        ImageIndex = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnContragent: TPanel
          Left = 110
          Top = 180
          Width = 445
          Height = 27
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object Label9: TLabel
            Left = 8
            Top = 6
            Width = 76
            Height = 16
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object rbClient: TRadioButton
            Left = 114
            Top = 8
            Width = 75
            Height = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1082#1083#1080#1077#1085#1090
            Checked = True
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = True
            OnClick = rbPostavshikClick
          end
          object rbPostavshik: TRadioButton
            Left = 210
            Top = 8
            Width = 102
            Height = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1087#1086#1089#1090#1072#1074#1097#1080#1082
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = rbPostavshikClick
          end
        end
        object pnOfficial: TPanel
          Left = 112
          Top = 237
          Width = 375
          Height = 31
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 5
          object Shape6: TShape
            Left = 2
            Top = 3
            Width = 107
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label4: TLabel
            Left = 12
            Top = 8
            Width = 60
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape5: TShape
            Left = 108
            Top = 3
            Width = 214
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object cbOfficial: TCheckBox
            Left = 327
            Top = 8
            Width = 41
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1089#1077
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = cbOfficialClick
          end
          object leIspolnitel: TcxLookupComboBox
            Left = 112
            Top = 5
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
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
            Width = 205
          end
        end
        object pnClient: TPanel
          Left = 112
          Top = 209
          Width = 375
          Height = 31
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Shape17: TShape
            Left = 2
            Top = 2
            Width = 107
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label3: TLabel
            Left = 12
            Top = 8
            Width = 41
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1050#1083#1080#1077#1085#1090
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape18: TShape
            Left = 108
            Top = 2
            Width = 214
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object cbClient: TCheckBox
            Left = 327
            Top = 8
            Width = 41
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1089#1077
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = cbClientClick
          end
          object peClient: TcxPopupEdit
            Left = 112
            Top = 5
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.PopupAutoSize = False
            Properties.PopupControl = PopupClientMultListForm.Owner
            Properties.PopupHeight = 246
            Properties.PopupWidth = 514
            Properties.OnCloseUp = peClientPropertiesCloseUp
            Properties.OnInitPopup = peClientPropertiesInitPopup
            Style.StyleController = dxEditStyleController
            TabOrder = 0
            OnKeyPress = peClientKeyPress
            Width = 205
          end
        end
        object pnPayment: TPanel
          Left = 112
          Top = 180
          Width = 375
          Height = 29
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object Shape13: TShape
            Left = 2
            Top = 2
            Width = 107
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label7: TLabel
            Left = 11
            Top = 8
            Width = 90
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1057#1087#1086#1089#1086#1073' '#1088#1072#1089#1095#1077#1090#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape14: TShape
            Left = 108
            Top = 2
            Width = 214
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object cbPayment: TCheckBox
            Left = 327
            Top = 4
            Width = 41
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1089#1077
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = cbPaymentClick
          end
          object cbxPayment: TcxComboBox
            Left = 112
            Top = 5
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.Items.Strings = (
              #1053#1072#1083#1080#1095#1085#1099#1081
              #1041#1077#1079#1085#1072#1083#1080#1095#1085#1099#1081)
            Style.BorderStyle = ebsFlat
            Style.ButtonTransparency = ebtNone
            TabOrder = 1
            Width = 205
          end
        end
        object pnTime: TPanel
          Left = 435
          Top = 104
          Width = 108
          Height = 76
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object ceTime: TCheckBox
            Left = 2
            Top = 3
            Width = 102
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1059#1082#1072#1079#1072#1090#1100' '#1074#1088#1077#1084#1103
            TabOrder = 0
            OnClick = ceTimeClick
          end
          object edTimeBegin: TcxTimeEdit
            Left = 2
            Top = 24
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            EditValue = 0.375d
            Enabled = False
            Properties.TimeFormat = tfHourMin
            Style.BorderStyle = ebs3D
            TabOrder = 1
            Width = 76
          end
          object edTimeEnd: TcxTimeEdit
            Left = 2
            Top = 51
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            EditValue = 0.75d
            Enabled = False
            Properties.TimeFormat = tfHourMin
            Style.BorderStyle = ebs3D
            TabOrder = 2
            Width = 76
          end
        end
        object pnDate: TPanel
          Left = 113
          Top = 67
          Width = 322
          Height = 113
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Shape2: TShape
            Left = 1
            Top = 86
            Width = 107
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape1: TShape
            Left = 1
            Top = 61
            Width = 107
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label1: TLabel
            Left = 11
            Top = 67
            Width = 69
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 11
            Top = 92
            Width = 63
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1044#1072#1090#1072' '#1082#1086#1085#1094#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape3: TShape
            Left = 107
            Top = 61
            Width = 214
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object Shape4: TShape
            Left = 107
            Top = 86
            Width = 214
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object byDay: TRadioButton
            Left = 1
            Top = 11
            Width = 99
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1047#1072' '#1076#1077#1085#1100
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = True
            OnClick = byDayClick
          end
          object byMonth: TRadioButton
            Left = 1
            Top = 35
            Width = 99
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1047#1072' '#1084#1077#1089#1103#1094
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = byMonthClick
          end
          object edDate: TcxDateEdit
            Left = 111
            Top = 63
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.Alignment.Horz = taRightJustify
            Properties.InputKind = ikMask
            Properties.UseLeftAlignmentOnEditing = False
            Style.BorderStyle = ebs3D
            Style.ButtonStyle = bts3D
            TabOrder = 4
            OnExit = edDateExit
            Width = 205
          end
          object edEndDate: TcxDateEdit
            Left = 111
            Top = 88
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.Alignment.Horz = taRightJustify
            Properties.InputKind = ikMask
            Properties.UseLeftAlignmentOnEditing = False
            Style.BorderStyle = ebs3D
            Style.ButtonStyle = bts3D
            TabOrder = 5
            Width = 205
          end
          object byYear: TRadioButton
            Left = 121
            Top = 11
            Width = 104
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1047#1072' '#1075#1086#1076
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = byYearClick
          end
          object byPeriod: TRadioButton
            Left = 121
            Top = 35
            Width = 152
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1047#1072' '#1083#1102#1073#1086#1081' '#1087#1077#1088#1080#1086#1076
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = byPeriodClick
          end
        end
        object pnReal: TPanel
          Left = 109
          Top = 297
          Width = 335
          Height = 34
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 7
          object Shape7: TShape
            Left = 5
            Top = 2
            Width = 132
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label5: TLabel
            Left = 12
            Top = 8
            Width = 115
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1072#1082#1083#1072#1076#1085#1099#1077
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape8: TShape
            Left = 136
            Top = 2
            Width = 189
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object ComboBox: TComboBox
            Left = 140
            Top = 4
            Width = 180
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ItemIndex = 0
            TabOrder = 0
            Text = #1053#1077#1086#1087#1083#1072#1095#1077#1085#1085#1099#1077
            Items.Strings = (
              #1053#1077#1086#1087#1083#1072#1095#1077#1085#1085#1099#1077
              #1054#1087#1083#1072#1095#1077#1085#1085#1099#1077
              #1042#1086#1079#1074#1088#1072#1097#1077#1085#1085#1099#1077
              #1042#1089#1077)
          end
        end
        object pnPostavshik: TPanel
          Left = 112
          Top = 268
          Width = 375
          Height = 29
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 6
          object sh11: TShape
            Left = 2
            Top = 2
            Width = 107
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object lb6: TLabel
            Left = 12
            Top = 8
            Width = 61
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object sh12: TShape
            Left = 108
            Top = 2
            Width = 214
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object cbPostavshikAll: TCheckBox
            Left = 327
            Top = 8
            Width = 41
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1089#1077
            Checked = True
            State = cbChecked
            TabOrder = 1
            Visible = False
            OnClick = cbClientClick
          end
          object pePostavshik: TcxPopupEdit
            Left = 112
            Top = 5
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.PopupAutoSize = False
            Properties.PopupControl = PopupClientMultListForm.Owner
            Properties.PopupHeight = 246
            Properties.PopupWidth = 514
            Properties.OnCloseUp = peClientPropertiesCloseUp
            Properties.OnInitPopup = pePostavshikPropertiesInitPopup
            Style.StyleController = dxEditStyleController
            TabOrder = 0
            OnKeyPress = peClientKeyPress
            Width = 205
          end
        end
        object pnActSverki: TPanel
          Left = 109
          Top = 326
          Width = 427
          Height = 84
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 8
          object Shape22: TShape
            Left = 5
            Top = 54
            Width = 167
            Height = 27
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape19: TShape
            Left = 5
            Top = 3
            Width = 167
            Height = 27
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label6: TLabel
            Left = 14
            Top = 9
            Width = 153
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape21: TShape
            Left = 5
            Top = 29
            Width = 167
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label11: TLabel
            Left = 14
            Top = 35
            Width = 65
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1052#1086#1103' '#1092#1080#1088#1084#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label12: TLabel
            Left = 14
            Top = 61
            Width = 111
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1060#1048#1054' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape24: TShape
            Left = 171
            Top = 54
            Width = 237
            Height = 27
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object Shape23: TShape
            Left = 171
            Top = 29
            Width = 237
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object Shape20: TShape
            Left = 171
            Top = 3
            Width = 237
            Height = 27
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object edRukovod: TEdit
            Left = 176
            Top = 58
            Width = 228
            Height = 22
            Hint = #1042#1074#1077#1076#1080#1090#1077' '#1060#1048#1054' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103' '#1042#1072#1096#1077#1081' '#1082#1086#1084#1087#1072#1085#1080#1080
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
          end
          object cbbFirm: TcxLookupComboBox
            Left = 176
            Top = 32
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.GridMode = True
            Properties.KeyFieldNames = 'G_FIRM_REKVIZIT'
            Properties.ListColumns = <
              item
                FieldName = 'NAME'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dsFirm
            Properties.OnChange = cbbFirmPropertiesChange
            Style.BorderStyle = ebsFlat
            Style.ButtonTransparency = ebtNone
            TabOrder = 1
            Width = 228
          end
          object edClientDir: TEdit
            Left = 176
            Top = 6
            Width = 228
            Height = 22
            Hint = #1042#1074#1077#1076#1080#1090#1077' '#1060#1048#1054' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103', '#1077#1089#1083#1080' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090' - '#1102#1088'. '#1083#1080#1094#1086
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
      end
      object tsSetNewPrices: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1059#1089#1083#1086#1074#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1094#1077#1085' '#1085#1072
        ImageIndex = 2
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object shpWhatPrice: TShape
          Left = 240
          Top = 40
          Width = 134
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
          Visible = False
        end
        object sh7: TShape
          Left = 240
          Top = 90
          Width = 134
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh5: TShape
          Left = 240
          Top = 65
          Width = 134
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh3: TShape
          Left = 240
          Top = 15
          Width = 134
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh1: TShape
          Left = 240
          Top = 140
          Width = 134
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object lb1: TLabel
          Left = 247
          Top = 146
          Width = 92
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1094#1077#1085#1099
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh2: TShape
          Left = 373
          Top = 140
          Width = 220
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lb2: TLabel
          Left = 247
          Top = 21
          Width = 39
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1056#1077#1078#1080#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh4: TShape
          Left = 373
          Top = 15
          Width = 220
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lb3: TLabel
          Left = 247
          Top = 71
          Width = 54
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh6: TShape
          Left = 373
          Top = 65
          Width = 220
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lb4: TLabel
          Left = 247
          Top = 96
          Width = 116
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1090#1072#1088#1099#1081' '#1082#1091#1088#1089' '#1074#1072#1083#1102#1090#1099
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh8: TShape
          Left = 373
          Top = 90
          Width = 220
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object sh9: TShape
          Left = 240
          Top = 115
          Width = 134
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object lb5: TLabel
          Left = 247
          Top = 121
          Width = 111
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1053#1086#1074#1099#1081' '#1082#1091#1088#1089' '#1074#1072#1083#1102#1090#1099
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh10: TShape
          Left = 373
          Top = 115
          Width = 220
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object shp1: TShape
          Left = 240
          Top = 213
          Width = 352
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object shp2: TShape
          Left = 240
          Top = 276
          Width = 352
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lbWhatPrice: TLabel
          Left = 247
          Top = 46
          Width = 28
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1062#1077#1085#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object shpWhatPrice1: TShape
          Left = 373
          Top = 40
          Width = 220
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
          Visible = False
        end
        object edValue: TcxCurrencyEdit
          Left = 377
          Top = 68
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          Enabled = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.UseDisplayFormatWhenEditing = True
          Properties.UseLeftAlignmentOnEditing = False
          Properties.UseThousandSeparator = True
          Properties.ValidateOnEnter = False
          Style.StyleController = dxEditStyleController
          TabOrder = 0
          Width = 212
        end
        object edOldCourse: TcxCurrencyEdit
          Left = 377
          Top = 93
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          Enabled = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.UseDisplayFormatWhenEditing = True
          Properties.UseLeftAlignmentOnEditing = False
          Properties.UseThousandSeparator = True
          Properties.ValidateOnEnter = False
          Style.StyleController = dxEditStyleController
          TabOrder = 1
          Width = 213
        end
        object edNewCourse: TcxCurrencyEdit
          Left = 377
          Top = 118
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          Enabled = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.UseDisplayFormatWhenEditing = True
          Properties.UseLeftAlignmentOnEditing = False
          Properties.UseThousandSeparator = True
          Properties.ValidateOnEnter = False
          Style.StyleController = dxEditStyleController
          TabOrder = 2
          Width = 213
        end
        object cbChangePrice: TcxCheckBox
          Left = 16
          Top = 24
          Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1077#1085#1091
          Properties.OnChange = cbChangePricePropertiesChange
          Style.StyleController = dxEditStyleController
          TabOrder = 3
          Width = 121
        end
        object cbChangeCategory: TcxCheckBox
          Left = 16
          Top = 216
          Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1090#1086#1074#1072#1088#1086#1074' '#1085#1072
          Properties.OnChange = cbChangeCategoryPropertiesChange
          Style.StyleController = dxEditStyleController
          TabOrder = 4
          Width = 193
        end
        object cbChangeMinOstatok: TcxCheckBox
          Left = 16
          Top = 272
          Caption = #1057#1076#1077#1083#1072#1090#1100' '#1087#1086#1083#1077' "'#1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1086#1089#1090#1072#1090#1086#1082'" '#1088#1072#1074#1085#1099#1084
          Properties.MultiLine = True
          Properties.OnChange = cbChangeMinOstatokPropertiesChange
          Style.StyleController = dxEditStyleController
          TabOrder = 5
          Width = 201
        end
        object cbMode: TcxComboBox
          Left = 377
          Top = 18
          Enabled = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1085#1072' %'
            #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1085#1072' '#1079#1085#1072#1095#1077#1085#1080#1077
            #1059#1084#1077#1085#1100#1096#1080#1090#1100' '#1085#1072' %'
            #1059#1084#1077#1085#1100#1096#1080#1090#1100' '#1085#1072' '#1079#1085#1072#1095#1077#1085#1080#1077
            #1048#1079#1084#1077#1085#1080#1090#1100' '#1089' '#1087#1088#1080#1074#1103#1079#1082#1086#1081' '#1082' '#1074#1072#1083#1102#1090#1077
            #1053#1072#1094#1077#1085#1082#1072' '#1074' % '#1086#1090' '#1094#1077#1085#1099' '#1079#1072#1082#1091#1087#1082#1080)
          Properties.OnChange = cb1PropertiesChange
          Style.StyleController = dxEditStyleController
          TabOrder = 6
          Text = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1085#1072' %'
          Width = 212
        end
        object cbRoundMode: TcxComboBox
          Left = 377
          Top = 143
          Enabled = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1044#1086' '#1076#1077#1089#1103#1090#1099#1093
            #1044#1086' '#1094#1077#1083#1099#1093
            #1044#1086' '#1076#1077#1089#1103#1090#1082#1086#1074
            #1044#1086' '#1089#1086#1090#1077#1085
            #1044#1086' '#1090#1099#1089#1103#1095)
          Style.StyleController = dxEditStyleController
          TabOrder = 7
          Text = #1044#1086' '#1076#1077#1089#1103#1090#1099#1093
          Width = 213
        end
        object leCategory: TcxLookupComboBox
          Left = 245
          Top = 216
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Enabled = False
          Properties.KeyFieldNames = 'G_PRODUCT'
          Properties.ListColumns = <
            item
              FieldName = 'NAME'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = dsProductCategory
          Style.StyleController = dxEditStyleController
          Style.ButtonStyle = btsFlat
          Style.ButtonTransparency = ebtNone
          TabOrder = 8
          Width = 343
        end
        object edMinAmount: TcxCurrencyEdit
          Left = 246
          Top = 278
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          Enabled = False
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.UseLeftAlignmentOnEditing = False
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 9
          Width = 343
        end
        object cbWhatPrice: TcxComboBox
          Left = 377
          Top = 43
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1056#1086#1079#1085#1080#1095#1085#1072#1103
            #1054#1087#1090#1086#1074#1072#1103)
          Properties.OnChange = cb1PropertiesChange
          Style.StyleController = dxEditStyleController
          TabOrder = 10
          Text = #1056#1086#1079#1085#1080#1095#1085#1072#1103
          Visible = False
          Width = 212
        end
      end
      object tsTovar: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1058#1086#1074#1072#1088#1099'/'#1082#1072#1090#1077#1075#1086#1088#1080#1080
        ImageIndex = 1
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 614
          Height = 428
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Caption = 'Panel3'
          ParentColor = True
          TabOrder = 0
          object Panel4: TPanel
            Left = 313
            Top = 1
            Width = 300
            Height = 426
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            BevelOuter = bvLowered
            Caption = 'Panel4'
            ParentColor = True
            TabOrder = 2
            object Panel6: TPanel
              Left = 1
              Top = 1
              Width = 298
              Height = 41
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              TabOrder = 0
              object Label10: TLabel
                Left = 66
                Top = 12
                Width = 40
                Height = 16
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Caption = #1055#1086#1080#1089#1082
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clNavy
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object cbTovAll: TCheckBox
                Left = 9
                Top = 12
                Width = 40
                Height = 17
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Caption = #1042#1089#1077
                Checked = True
                Enabled = False
                State = cbChecked
                TabOrder = 1
                OnClick = cbTovAllClick
              end
              object edSearchTovar: TEdit
                Left = 109
                Top = 10
                Width = 184
                Height = 22
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                CharCase = ecLowerCase
                MaxLength = 13
                TabOrder = 0
                OnChange = edSearchTovarChange
              end
            end
            inline TovaryFrame: TGridFrame
              Left = 1
              Top = 42
              Width = 298
              Height = 383
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              TabOrder = 1
              ExplicitLeft = 1
              ExplicitTop = 42
              ExplicitWidth = 298
              ExplicitHeight = 383
              inherited grMain: TcxGrid
                Width = 298
                Height = 383
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Enabled = False
                ExplicitWidth = 298
                ExplicitHeight = 383
                inherited tvMain: TcxGridDBTableView
                  DataController.KeyFieldNames = 'ID'
                  inherited clmMainColumn2: TcxGridDBColumn
                    DataBinding.FieldName = 'NAME'
                    Width = 397
                  end
                  inherited clmMainColumn3: TcxGridDBColumn
                    DataBinding.FieldName = 'ID'
                  end
                end
              end
              inherited spReadFrame: TpFIBDataSet
                SelectSQL.Strings = (
                  'SELECT SS.G_PRODUCT ID,'
                  '       SS.NAME,'
                  '       SS.ARTICUL,'
                  '       SS.BARCODE,'
                  '       SS.PLACE'
                  'FROM G_PRODUCT SS'
                  'WHERE SS.IS_CATEGORY = 0'
                  'AND SS.IS_ACTIVE = 1'
                  
                    'AND (CAST(:G_CATEGORY_ AS VARCHAR(1000)) CONTAINING '#39'~'#39'||SS.G_PR' +
                    'ODUCT_PAR||'#39'~'#39
                  '     OR '
                  '     CAST(:G_CATEGORY_ AS VARCHAR(1000)) = '#39'~'#39')'
                  'ORDER BY 2, 1')
              end
            end
          end
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 304
            Height = 426
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            BevelOuter = bvLowered
            Caption = 'Panel4'
            ParentColor = True
            TabOrder = 0
            object Panel7: TPanel
              Left = 1
              Top = 1
              Width = 302
              Height = 41
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              TabOrder = 0
              object cbCatAll: TCheckBox
                Left = 8
                Top = 12
                Width = 41
                Height = 17
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Caption = #1042#1089#1077
                Checked = True
                State = cbChecked
                TabOrder = 0
                OnClick = cbCatAllClick
              end
            end
            inline TovCatFrame: TTreeFrame
              Left = 1
              Top = 42
              Width = 302
              Height = 383
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              TabOrder = 1
              ExplicitLeft = 1
              ExplicitTop = 42
              ExplicitWidth = 302
              ExplicitHeight = 383
              inherited tlCommon: TcxDBTreeList
                Width = 302
                Height = 383
                Margins.Left = 3
                Margins.Top = 3
                Margins.Right = 3
                Margins.Bottom = 3
                DataController.ParentField = 'ID_PAR'
                DataController.KeyField = 'ID'
                Enabled = False
                Styles.Inactive = MainDM.stGridSelectedRow
                OnMouseDown = TovCatFrametlCommonMouseDown
                ExplicitWidth = 302
                ExplicitHeight = 383
                inherited cxDBTreeListColumn2: TcxDBTreeListColumn
                  DataBinding.FieldName = 'NAME'
                end
                inherited tlSkladcxDBTreeListColumn1: TcxDBTreeListColumn
                  DataBinding.FieldName = 'ID'
                end
              end
              inherited spReadFrame: TpFIBDataSet
                SelectSQL.Strings = (
                  '/*SELECT * FROM ('
                  'WITH RECURSIVE TREE'
                  '  AS (SELECT T.G_PRODUCT ID,'
                  '             T.G_PRODUCT_PAR ID_PAR,'
                  '             replace(T.NAME, '#39' '#39', '#39#39') PATH,'
                  '             T.NAME NAME,'
                  '             CAST('#39#39' AS VARCHAR(255)) AS indent'
                  '      FROM G_PRODUCT T'
                  '     WHERE T.G_PRODUCT_PAR IS NULL'
                  '    UNION ALL'
                  '    SELECT T.G_PRODUCT ID,'
                  '             T.G_PRODUCT_PAR ID_PAR,'
                  '           GG.PATH||replace(T.NAME, '#39' '#39', '#39#39') PATH,'
                  '           T.NAME NAME,'
                  '           GG.indent || rpad('#39#39', 3) AS indent'
                  
                    '      FROM G_PRODUCT T INNER JOIN TREE GG ON GG.ID = T.G_PRODUCT' +
                    '_PAR'
                  '     WHERE T.IS_CATEGORY = 1'
                  '    )'
                  ' SELECT ID,'
                  '        ID_PAR,'
                  '        PATH,'
                  '        Indent || NAME AS NAME FROM TREE)'
                  'ORDER BY 3, 1*/'
                  'SELECT'
                  '        DECODE(T.G_PRODUCT, -1, T.G_PRODUCT, 0) SORT,'
                  '        T.G_PRODUCT ID,'
                  '        T.G_PRODUCT_PAR ID_PAR,'
                  '        DECODE(T.G_PRODUCT, -1, '#39#1041#1077#1079' '#1075#1088#1091#1087#1087#1099#39', T.NAME) NAME'
                  '    FROM G_PRODUCT T'
                  'WHERE T.IS_CATEGORY = 1'
                  'ORDER BY 1, 4, 2'
                  ' ')
              end
            end
          end
          object splMenu: TcxSplitter
            Left = 305
            Top = 1
            Width = 8
            Height = 426
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            HotZoneClassName = 'TcxSimpleStyle'
            HotZone.SizePercent = 32
            AutoPosition = False
            PositionAfterOpen = 150
            AutoSnap = True
            ResizeUpdate = True
            Control = Panel4
            Color = clBtnFace
            ParentColor = False
            ExplicitLeft = 613
          end
        end
      end
      object tsSklad: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1082#1083#1072#1076#1099
        ImageIndex = 1
        TabVisible = False
        object Panel2: TPanel
          Left = 0
          Top = 387
          Width = 614
          Height = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btAll: TButton
            Left = 16
            Top = 8
            Width = 97
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
            TabOrder = 0
            OnClick = btAllClick
          end
          object btNone: TButton
            Left = 120
            Top = 8
            Width = 83
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1059#1073#1088#1072#1090#1100' '#1074#1089#1077
            TabOrder = 1
            OnClick = btNoneClick
          end
        end
        inline frmSklad: TGridFrame
          Left = 0
          Top = 0
          Width = 614
          Height = 387
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 614
          ExplicitHeight = 387
          inherited grMain: TcxGrid
            Width = 614
            Height = 387
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ExplicitWidth = 614
            ExplicitHeight = 387
            inherited tvMain: TcxGridDBTableView
              DataController.KeyFieldNames = 'G_TOCHKA'
              inherited clmMainColumn2: TcxGridDBColumn
                Caption = #1057#1082#1083#1072#1076
                DataBinding.FieldName = 'NAME'
              end
              inherited clmMainColumn3: TcxGridDBColumn
                DataBinding.FieldName = 'G_TOCHKA'
              end
            end
          end
          inherited spReadFrame: TpFIBDataSet
            SelectSQL.Strings = (
              'SELECT * FROM G_TOCHKA_READ')
          end
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 460
    Top = 468
    ExplicitLeft = 460
    ExplicitTop = 468
  end
  inherited btnCancel: TcxButton
    Left = 547
    Top = 468
    ExplicitLeft = 547
    ExplicitTop = 468
  end
  inherited btHelp: TcxButton
    Top = 469
    ExplicitTop = 469
  end
  inherited ApplicationEvents1: TApplicationEvents
    OnActivate = nil
    Left = 120
    Top = 608
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Left = 208
    Top = 608
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 280
    Top = 16
  end
  object spIspolnitel: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_OFFICIAL_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 272
    Top = 304
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsIspolnitel: TDataSource
    DataSet = spIspolnitel
    Left = 304
    Top = 303
  end
  object TimerTovar: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerTovarTimer
    Left = 336
    Top = 304
  end
  object dsFirm: TDataSource
    DataSet = spFirm
    Left = 576
    Top = 536
  end
  object spFirm: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_FIRM_REKVIZIT')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 544
    Top = 536
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spProductCategory: TpFIBDataSet
    SelectSQL.Strings = (
      
        'WITH RECURSIVE TREE AS (SELECT DECODE(T.G_PRODUCT, -1, T.G_PRODU' +
        'CT, 0) SORTT,'
      '                               T.G_PRODUCT,'
      '                               T.G_PRODUCT_PAR,'
      
        '                               DECODE(T.G_PRODUCT, -1, '#39#1041#1077#1079' '#1075#1088#1091#1087 +
        #1087#1099#39', T.NAME) NAME,'
      
        '                               T.NAME PATH,       --'#1076#1083#1103' '#1089#1086#1088#1090#1080#1088#1086#1074 +
        #1082#1080
      '                               '#39'  '#39' LVL'
      '                          FROM G_PRODUCT T'
      
        '                         WHERE (T.G_PRODUCT_PAR IS NULL or T.g_p' +
        'roduct = -1)'
      '                        UNION ALL'
      
        '                        SELECT DECODE(T.G_PRODUCT, -1, T.G_PRODU' +
        'CT, 0) SORTT,'
      '                               T.G_PRODUCT,'
      '                               T.G_PRODUCT_PAR,'
      '                               GG.LVL||T.NAME NAME,'
      
        '                               GG.PATH||'#39' - '#39'||T.NAME,     --'#1044#1051#1071 +
        ' '#1057#1054#1056#1058#1048#1056#1054#1042#1050#1048
      '                               GG.LVL||'#39'  '#39' LVL'
      
        '                          FROM G_PRODUCT T INNER JOIN TREE GG ON' +
        ' GG.G_PRODUCT = T.G_PRODUCT_PAR'
      '                         WHERE T.IS_CATEGORY = 1'
      '                        )'
      '    SELECT * FROM TREE ORDER BY 1, 5, 3')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 336
    Top = 200
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsProductCategory: TDataSource
    DataSet = spProductCategory
    Left = 368
    Top = 200
  end
end
