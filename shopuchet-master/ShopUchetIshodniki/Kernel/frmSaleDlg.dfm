inherited SaleDlgForm: TSaleDlgForm
  Left = 730
  Top = 156
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
  ClientHeight = 526
  ClientWidth = 643
  Color = clBtnFace
  OnClose = FormClose
  ExplicitWidth = 649
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Left = 15
    Width = 615
    Height = 477
    BevelOuter = bvNone
    Color = clBtnFace
    ExplicitLeft = 15
    ExplicitWidth = 615
    ExplicitHeight = 477
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 382
      Height = 475
      Align = alClient
      TabOrder = 0
      object lb4: TLabel
        Left = 9
        Top = 84
        Width = 44
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1062#1077#1085#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clDefault
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lb1: TLabel
        Left = 9
        Top = 122
        Width = 104
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clDefault
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lbSkidka: TLabel
        Left = 9
        Top = 158
        Width = 104
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1082#1080#1076#1082#1072' (%)'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clDefault
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lb2: TLabel
        Left = 9
        Top = 196
        Width = 57
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1091#1084#1084#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clDefault
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lb6: TLabel
        Left = 9
        Top = 230
        Width = 124
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clDefault
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lbVesGrammPrice: TLabel
        Left = 9
        Top = 282
        Width = 128
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1062#1077#1085#1072' '#1079#1072' '#1075#1088#1072#1084#1084
        Enabled = False
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clDefault
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object lbVesGramm: TLabel
        Left = 9
        Top = 319
        Width = 149
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1042#1077#1089' '#1080#1079#1076#1077#1083#1080#1103' ('#1075#1088')'
        Enabled = False
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clDefault
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object pn1: TPanel
        Left = 1
        Top = 360
        Width = 380
        Height = 114
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          380
          114)
        object lb5: TLabel
          Left = 9
          Top = 15
          Width = 40
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1062#1077#1085#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lb7: TLabel
          Left = 9
          Top = 69
          Width = 68
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1082#1080#1076#1082#1072' '#1074
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object btnBreakTovar: TButton
          Left = 248
          Top = 11
          Width = 120
          Height = 86
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aBreakTovar
          Anchors = [akTop, akRight]
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          WordWrap = True
        end
        object cbSkidka: TcxComboBox
          Left = 88
          Top = 68
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          AutoSize = False
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1055#1088#1086#1094#1077#1085#1090#1072#1093
            #1044#1077#1085#1077#1078'. '#1077#1076'.')
          Properties.OnChange = cbSkidkaPropertiesChange
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -17
          Style.Font.Name = 'Arial'
          Style.Font.Style = []
          Style.LookAndFeel.Kind = lfStandard
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.Kind = lfStandard
          StyleFocused.LookAndFeel.Kind = lfStandard
          StyleHot.LookAndFeel.Kind = lfStandard
          TabOrder = 2
          Text = #1055#1088#1086#1094#1077#1085#1090#1072#1093
          Height = 28
          Width = 147
        end
        object cbPrice: TcxComboBox
          Left = 88
          Top = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          AutoSize = False
          ParentFont = False
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1056#1086#1079#1085#1080#1094#1072
            #1054#1087#1090#1086#1074#1072#1103)
          Properties.OnChange = cbPricePropertiesChange
          Style.BorderStyle = ebs3D
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -17
          Style.Font.Name = 'Arial'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 1
          Text = #1056#1086#1079#1085#1080#1094#1072
          Height = 27
          Width = 147
        end
      end
      object pnName: TPanel
        Left = 11
        Top = 6
        Width = 360
        Height = 63
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        BevelOuter = bvNone
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clGreen
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lbName: TLabel
          Left = 0
          Top = 0
          Width = 360
          Height = 63
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Caption = 'lbName'
          WordWrap = True
          ExplicitWidth = 68
          ExplicitHeight = 24
        end
      end
      object edPrice: TcxCurrencyEdit
        Left = 175
        Top = 79
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
        Properties.OnChange = edPricePropertiesChange
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -21
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 2
        OnEnter = edPriceEnter
        Width = 186
      end
      inline MyCurrencyFrameForm: TMyCurrencyFrameForm
        Left = 174
        Top = 116
        Width = 198
        Height = 34
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Color = clBtnFace
        ParentColor = False
        TabOrder = 3
        ExplicitLeft = 174
        ExplicitTop = 116
        ExplicitWidth = 198
        ExplicitHeight = 34
        inherited sbCur: TSpinButton [0]
          Left = 158
          Top = 1
          Width = 29
          Height = 32
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ExplicitLeft = 158
          ExplicitTop = 1
          ExplicitWidth = 29
          ExplicitHeight = 32
        end
        inherited edAmount: TEdit [1]
          Left = 2
          Width = 155
          Height = 33
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -21
          ParentFont = False
          Text = '1.00'
          OnChange = MyCurrencyFrameFormedAmountChange
          OnEnter = MyCurrencyFrameFormedAmountEnter
          ExplicitLeft = 2
          ExplicitWidth = 155
          ExplicitHeight = 33
        end
      end
      object edSkidka: TcxCurrencyEdit
        Left = 175
        Top = 154
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        EditValue = 0c
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Properties.EditFormat = '0.00'
        Properties.UseDisplayFormatWhenEditing = True
        Properties.UseLeftAlignmentOnEditing = False
        Properties.UseThousandSeparator = True
        Properties.ValidateOnEnter = False
        Properties.OnChange = edSkidkaPropertiesChange
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -21
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 4
        OnEnter = edSkidkaEnter
        Width = 186
      end
      object edSumm: TcxCurrencyEdit
        Left = 175
        Top = 190
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
        Style.Font.Color = clNavy
        Style.Font.Height = -21
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 5
        Width = 186
      end
      object edSkidkaSumm: TcxCurrencyEdit
        Left = 175
        Top = 227
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
        Style.Font.Color = clNavy
        Style.Font.Height = -21
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 6
        Width = 186
      end
      object edVesGrammPrice: TcxCurrencyEdit
        Left = 175
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
        Properties.UseDisplayFormatWhenEditing = True
        Properties.UseLeftAlignmentOnEditing = False
        Properties.UseThousandSeparator = True
        Properties.ValidateOnEnter = False
        Properties.OnChange = edVesGrammPricePropertiesChange
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -21
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 7
        Visible = False
        Width = 186
      end
      object edVesGramm: TcxCurrencyEdit
        Left = 175
        Top = 315
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
        Style.Font.Color = clNavy
        Style.Font.Height = -21
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 8
        Visible = False
        Width = 186
      end
    end
    object pnlButton: TPanel
      Left = 383
      Top = 1
      Width = 231
      Height = 475
      Align = alRight
      TabOrder = 1
      DesignSize = (
        231
        475)
      object btn7: TcxButton
        Left = 19
        Top = 61
        Width = 60
        Height = 55
        Caption = '7'
        LookAndFeel.Kind = lfFlat
        TabOrder = 0
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn8: TcxButton
        Left = 84
        Top = 61
        Width = 60
        Height = 55
        Caption = '8'
        LookAndFeel.Kind = lfFlat
        TabOrder = 1
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn9: TcxButton
        Left = 149
        Top = 61
        Width = 60
        Height = 55
        Caption = '9'
        LookAndFeel.Kind = lfFlat
        TabOrder = 2
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn4: TcxButton
        Left = 19
        Top = 125
        Width = 60
        Height = 55
        Caption = '4'
        LookAndFeel.Kind = lfFlat
        TabOrder = 3
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn5: TcxButton
        Left = 84
        Top = 125
        Width = 60
        Height = 55
        Caption = '5'
        LookAndFeel.Kind = lfFlat
        TabOrder = 4
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn6: TcxButton
        Left = 149
        Top = 125
        Width = 60
        Height = 55
        Caption = '6'
        LookAndFeel.Kind = lfFlat
        TabOrder = 5
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn1: TcxButton
        Left = 19
        Top = 188
        Width = 60
        Height = 55
        Caption = '1'
        LookAndFeel.Kind = lfFlat
        TabOrder = 6
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn2: TcxButton
        Left = 84
        Top = 188
        Width = 60
        Height = 55
        Caption = '2'
        LookAndFeel.Kind = lfFlat
        TabOrder = 7
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn3: TcxButton
        Left = 149
        Top = 188
        Width = 60
        Height = 55
        Caption = '3'
        LookAndFeel.Kind = lfFlat
        TabOrder = 8
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btn0: TcxButton
        Left = 19
        Top = 251
        Width = 60
        Height = 55
        Caption = '0'
        LookAndFeel.Kind = lfFlat
        TabOrder = 9
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object btnBcksp: TcxButton
        Left = 149
        Top = 251
        Width = 60
        Height = 55
        Hint = #1059#1076#1072#1083#1080#1090#1100
        Caption = '<<'
        LookAndFeel.Kind = lfFlat
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnBckspClick
      end
      object btnPnt: TcxButton
        Left = 84
        Top = 251
        Width = 60
        Height = 55
        Caption = '.'
        LookAndFeel.Kind = lfFlat
        TabOrder = 11
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btn0Click
      end
      object cbShowSaleDlgKeys: TcxCheckBox
        Left = 11
        Top = 436
        Hint = 
          #1059#1073#1077#1088#1080#1090#1077' '#1075#1072#1083#1086#1095#1082#1091', '#1077#1089#1083#1080' '#1085#1077' '#1093#1086#1090#1080#1090#1077' '#1073#1086#1083#1100#1096#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100#13#10#1087#1072#1085#1077#1083#1100' '#1089' '#1094#1080#1092#1088 +
          #1072#1084#1080
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akRight, akBottom]
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1094#1080#1092#1088#1099
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -17
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 12
        Width = 182
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 429
    Top = 489
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 429
    ExplicitTop = 489
    ExplicitWidth = 95
    ExplicitHeight = 30
  end
  inherited btnCancel: TcxButton
    Left = 535
    Top = 489
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 535
    ExplicitTop = 489
    ExplicitWidth = 95
    ExplicitHeight = 30
  end
  inherited btHelp: TcxButton
    Left = 294
    Top = 489
    Width = 97
    Height = 30
    Visible = False
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 294
    ExplicitTop = 489
    ExplicitWidth = 97
    ExplicitHeight = 30
  end
  object cbShowForm: TcxCheckBox [4]
    Left = 11
    Top = 479
    Hint = #1053#1072#1078#1084#1080#1090#1077', '#1077#1089#1083#1080' '#1085#1077' '#1093#1086#1090#1080#1090#1077' '#1073#1086#1083#1100#1096#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1076#1072#1085#1085#1086#1077' '#1086#1082#1085#1086
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akBottom]
    Caption = #1042#1089#1077#1075#1076#1072' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1101#1090#1086' '#1086#1082#1085#1086
    ParentFont = False
    ParentShowHint = False
    Properties.MultiLine = True
    ShowHint = False
    State = cbsChecked
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -15
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.StyleController = dxEditStyleController
    Style.IsFontAssigned = True
    TabOrder = 4
    Width = 163
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 60
    Top = 186
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Left = 183
    Top = 543
    object aBreakTovar: TAction
      Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1087#1086#1096#1090#1091#1095#1085#1086' (F1)'
      ShortCut = 112
      OnExecute = aBreakTovarExecute
    end
  end
  inherited tranRead: TpFIBTransaction
    Left = 225
    Top = 544
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_GET_G_PRODUCT_SALEMODE (?G_PRODUCT_, ?G_TOCH' +
        'KA_)')
    StoredProcName = 'G_GET_G_PRODUCT_SALEMODE'
    Left = 258
    Top = 545
  end
  inherited tranWrite: TpFIBTransaction
    Left = 292
    Top = 546
  end
  inherited spIns: TpFIBStoredProc
    Left = 327
    Top = 546
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UPDATE_ZAKAZ_DETAILS_TMP (?ZAKAZ_DETAILS_, ?AM' +
        'OUNT_, ?PRICE_, ?SUMM_, ?DISCOUNT_PERC_, ?DISCOUNT_TENGE_, ?DISC' +
        'OUNT_SUMM_, ?NDS_, ?NDS_SUMM_, ?ALLOW_SELL_ABSENT_GOODS_, ?VES_G' +
        'RAMM_PRICE_, ?DO_PRODUCT_IN_SALE_)')
    StoredProcName = 'UPDATE_ZAKAZ_DETAILS_TMP'
    Left = 362
    Top = 546
  end
end
