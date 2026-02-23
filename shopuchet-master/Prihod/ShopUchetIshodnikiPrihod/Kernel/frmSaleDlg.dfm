inherited SaleDlgForm: TSaleDlgForm
  Left = 730
  Top = 156
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
  ClientHeight = 488
  ClientWidth = 407
  Color = clBtnFace
  OnClose = FormClose
  ExplicitWidth = 413
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Left = 15
    Width = 378
    Height = 437
    Color = clBtnFace
    ExplicitLeft = 15
    ExplicitWidth = 378
    ExplicitHeight = 437
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
      Left = 10
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
      TabOrder = 2
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
        ExplicitLeft = 2
        ExplicitWidth = 155
        ExplicitHeight = 33
      end
    end
    object pnName: TPanel
      Left = 11
      Top = 9
      Width = 358
      Height = 65
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clGreen
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lbName: TLabel
        Left = 0
        Top = 0
        Width = 358
        Height = 65
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
    object pn1: TPanel
      Left = 2
      Top = 280
      Width = 374
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
      TabOrder = 6
      DesignSize = (
        374
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
        Left = 249
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
    object pnShowDlg: TPanel
      Left = 2
      Top = 394
      Width = 374
      Height = 41
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      TabOrder = 7
      object cbShowForm: TcxCheckBox
        Left = 6
        Top = 6
        Hint = #1053#1072#1078#1084#1080#1090#1077', '#1077#1089#1083#1080' '#1085#1077' '#1093#1086#1090#1080#1090#1077' '#1073#1086#1083#1100#1096#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1076#1072#1085#1085#1086#1077' '#1086#1082#1085#1086
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1042#1089#1077#1075#1076#1072' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1101#1090#1086' '#1086#1082#1085#1086
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        State = cbsChecked
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -20
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 0
        Width = 281
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
      TabOrder = 1
      Width = 186
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
      TabOrder = 3
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
      TabOrder = 4
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
      TabOrder = 5
      Width = 186
    end
  end
  inherited btnOk: TcxButton
    Left = 195
    Top = 449
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 195
    ExplicitTop = 449
    ExplicitWidth = 95
    ExplicitHeight = 30
  end
  inherited btnCancel: TcxButton
    Left = 299
    Top = 449
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 299
    ExplicitTop = 449
    ExplicitWidth = 95
    ExplicitHeight = 30
  end
  inherited btHelp: TcxButton
    Left = 15
    Top = 449
    Width = 97
    Height = 30
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 15
    ExplicitTop = 449
    ExplicitWidth = 97
    ExplicitHeight = 30
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 60
    Top = 186
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Left = 103
    Top = 399
    object aBreakTovar: TAction
      Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1087#1086#1096#1090#1091#1095#1085#1086' (F1)'
      ShortCut = 112
      OnExecute = aBreakTovarExecute
    end
  end
  inherited tranRead: TpFIBTransaction
    Left = 105
    Top = 448
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_GET_G_PRODUCT_SALEMODE (?G_PRODUCT_, ?G_TOCH' +
        'KA_)')
    StoredProcName = 'G_GET_G_PRODUCT_SALEMODE'
    Left = 138
    Top = 449
  end
  inherited tranWrite: TpFIBTransaction
    Left = 172
    Top = 450
  end
  inherited spIns: TpFIBStoredProc
    Left = 207
    Top = 450
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UPDATE_ZAKAZ_DETAILS_TMP (?ZAKAZ_DETAILS_, ?AM' +
        'OUNT_, ?PRICE_, ?SUMM_, ?DISCOUNT_PERC_, ?DISCOUNT_TENGE_, ?DISC' +
        'OUNT_SUMM_, ?NDS_, ?NDS_SUMM_, ?ALLOW_SELL_ABSENT_GOODS_)')
    StoredProcName = 'UPDATE_ZAKAZ_DETAILS_TMP'
    Left = 242
    Top = 450
  end
end
