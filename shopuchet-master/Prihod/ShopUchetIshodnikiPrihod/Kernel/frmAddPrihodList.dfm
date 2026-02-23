inherited AddPrihodListForm: TAddPrihodListForm
  Left = 534
  Top = 192
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 490
  ClientWidth = 853
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 859
  ExplicitHeight = 516
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Top = 137
    Width = 853
    Height = 198
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitTop = 137
    ExplicitWidth = 853
    ExplicitHeight = 198
    inherited tvMain: TcxGridDBTableView
      OnKeyDown = tvMainKeyDown
      OnCellDblClick = nil
      OnEditing = tvMainEditing
      OnEditKeyDown = tvMainEditKeyDown
      DataController.KeyFieldNames = 'SKLAD'
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = clmMainAMOUNT
        end
        item
          Kind = skSum
          Column = clmMainSUMM
        end>
      DataController.Summary.OnAfterSummary = tvMainDataControllerSummaryAfterSummary
      OptionsBehavior.CellHints = True
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.IncSearch = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsSelection.CellSelect = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object clmMainSKLAD: TcxGridDBColumn
        DataBinding.FieldName = 'SKLAD'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 120
      end
      object clmMainG_PRODUCT: TcxGridDBColumn
        Caption = #1058#1086#1074#1072#1088
        DataBinding.FieldName = 'G_PRODUCT'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsEditList
        Properties.KeyFieldNames = 'G_PRODUCT'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsProduct
        Properties.OnEditValueChanged = clmMainG_PRODUCTPropertiesEditValueChanged
        OnGetDisplayText = clmMainG_PRODUCTGetDisplayText
        HeaderAlignmentHorz = taCenter
        Styles.OnGetContentStyle = clmMainG_PRODUCTStylesGetContentStyle
        Width = 270
      end
      object clmMainOSTATOK: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1086#1082' '#1074' '#1073#1072#1079#1077
        DataBinding.FieldName = 'OSTATOK'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 120
      end
      object clmMainBARCODE: TcxGridDBColumn
        Caption = #1064#1090#1088#1080#1093#1082#1086#1076
        DataBinding.FieldName = 'BARCODE'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'G_PRODUCT'
        Properties.ListColumns = <
          item
            FieldName = 'BARCODE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsProduct
        Properties.OnEditValueChanged = clmMainBARCODEPropertiesEditValueChanged
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainARTICUL: TcxGridDBColumn
        Caption = #1040#1088#1090#1080#1082#1091#1083
        DataBinding.FieldName = 'ARTICUL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 120
      end
      object clmMainAMOUNT: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1087#1088#1080#1096#1083#1086
        DataBinding.FieldName = 'AMOUNT'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainPRICE: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080
        DataBinding.FieldName = 'PRICE'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object clmMainSUMM: TcxGridDBColumn
        Caption = #1057#1091#1084#1084#1072
        DataBinding.FieldName = 'SUMM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 120
      end
      object clmMainCHARGE_ROZN_PROC: TcxGridDBColumn
        Caption = #1053#1072#1094#1077#1085#1082#1072' %'
        DataBinding.FieldName = 'CHARGE_ROZN_PROC'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object clmMainCHARGE_ROZN_SUM: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
        DataBinding.FieldName = 'PRICE_ROZN'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Width = 94
      end
      object clmMainCHARGE_OPT_PROC: TcxGridDBColumn
        Caption = #1053#1072#1094#1077#1085#1082#1072' '#1086#1087#1090' (%)'
        DataBinding.FieldName = 'CHARGE_OPT_PROC'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ImmediatePost = True
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object clmMainCHARGE_OPT_SUM: TcxGridDBColumn
        Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080' '#1086#1087#1090
        DataBinding.FieldName = 'PRICE_OPT'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.ImmediatePost = True
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 26
    Width = 853
    Height = 111
    Align = alTop
    TabOrder = 5
    object Shape17: TShape
      Left = 7
      Top = 31
      Width = 117
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape25: TShape
      Left = 7
      Top = 56
      Width = 117
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape12: TShape
      Left = 7
      Top = 7
      Width = 117
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape1: TShape
      Left = 422
      Top = 7
      Width = 131
      Height = 40
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label7: TLabel
      Left = 13
      Top = 12
      Width = 77
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1093#1086#1076#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape13: TShape
      Left = 123
      Top = 7
      Width = 134
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Shape11: TShape
      Left = 256
      Top = 7
      Width = 62
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label10: TLabel
      Left = 268
      Top = 12
      Width = 36
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1088#1077#1084#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape15: TShape
      Left = 317
      Top = 7
      Width = 88
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 431
      Top = 20
      Width = 71
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape2: TShape
      Left = 552
      Top = 7
      Width = 290
      Height = 40
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label9: TLabel
      Left = 13
      Top = 37
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
    object Label13: TLabel
      Left = 13
      Top = 62
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
    object Shape18: TShape
      Left = 123
      Top = 31
      Width = 282
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Shape26: TShape
      Left = 123
      Top = 56
      Width = 282
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object edDate: TcxDateEdit
      Left = 128
      Top = 9
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.InputKind = ikMask
      Properties.OnChange = edDatePropertiesChange
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.ButtonTransparency = ebtNone
      TabOrder = 0
      Width = 125
    end
    object edTime: TcxTimeEdit
      Left = 323
      Top = 9
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 0d
      Properties.BeepOnError = True
      Properties.TimeFormat = tfHourMin
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 77
    end
    object mNote: TcxMemo
      Left = 557
      Top = 11
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style.LookAndFeel.Kind = lfFlat
      Style.StyleController = dxEditStyleController
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.Kind = lfFlat
      TabOrder = 4
      Height = 33
      Width = 281
    end
    object lePostavshik: TcxLookupComboBox
      Left = 128
      Top = 34
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_CLIENT'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsPostavshik
      Properties.OnChange = lePostavshikPropertiesChange
      Style.LookAndFeel.Kind = lfFlat
      Style.StyleController = dxEditStyleController
      Style.TransparentBorder = False
      Style.ButtonTransparency = ebtNone
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.Kind = lfFlat
      TabOrder = 2
      Width = 272
    end
    object lePAYMENT_TYPE: TcxLookupComboBox
      Left = 128
      Top = 58
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_PAYMENT_TYPE'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsPaymentType
      Properties.OnChange = lePAYMENT_TYPEPropertiesChange
      Style.LookAndFeel.Kind = lfFlat
      Style.StyleController = dxEditStyleController
      Style.ButtonTransparency = ebtNone
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.Kind = lfFlat
      TabOrder = 3
      Width = 272
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 335
    Width = 853
    Height = 155
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    DesignSize = (
      853
      155)
    object sh3: TShape
      Left = 7
      Top = 7
      Width = 79
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object sh2: TShape
      Left = 7
      Top = 32
      Width = 78
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object sh1: TShape
      Left = 7
      Top = 57
      Width = 79
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shpCurrency: TShape
      Left = 7
      Top = 82
      Width = 78
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object lb1: TLabel
      Left = 16
      Top = 12
      Width = 35
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1091#1084#1084#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object sh4: TShape
      Left = 84
      Top = 7
      Width = 233
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb2: TLabel
      Left = 16
      Top = 36
      Width = 57
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1054#1087#1083#1072#1095#1077#1085#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object sh5: TShape
      Left = 84
      Top = 32
      Width = 233
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb3: TLabel
      Left = 16
      Top = 61
      Width = 27
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1086#1083#1075
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object sh6: TShape
      Left = 84
      Top = 57
      Width = 233
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lbSummCurrency: TLabel
      Left = 16
      Top = 86
      Width = 60
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1091#1084#1084#1072' '#1091'.'#1077'.'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shpCurrency1: TShape
      Left = 84
      Top = 82
      Width = 233
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object sbEqualSumm: TSpeedButton
      Left = 324
      Top = 33
      Width = 22
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Glyph.Data = {
        7E000000424D7E000000000000003E0000002800000010000000100000000100
        01000000000040000000C40E0000C40E0000020000000000000000000000FFFF
        FF00FFFF0000FFFF0000FFFF0000E00F0000E00F0000F1AF0000F8EF0000F8FF
        0000FC7F0000FD7F0000FA7F0000F6EF0000F40F0000F80F0000FFFF0000FFFF
        0000}
      OnClick = sbEqualSummClick
    end
    object btHelp: TcxButton
      Left = 8
      Top = 122
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&'#1055#1086#1084#1086#1097#1100
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
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
      TabOrder = 0
      OnClick = btHelpClick
    end
    object cxButton1: TcxButton
      Left = 89
      Top = 122
      Width = 107
      Height = 25
      Action = aPrint
      Anchors = [akLeft, akBottom]
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
      TabOrder = 1
    end
    object btnCancel: TcxButton
      Left = 767
      Top = 122
      Width = 75
      Height = 25
      Action = aClose
      Anchors = [akRight, akBottom]
      Cancel = True
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
      OptionsImage.Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00655CA600352892001D0E89001C0E89003427
        9100645AA400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00818181005D5D5D004B4B4B004B4B4B005B5B
        5B007F7F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF006960AB00211593002225AE002430C2002535CB002535CC002430
        C3002225AF00211594006158A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF008585850054545400686868007373730078787800787878007373
        730068686800545454007F7F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF004E44A2002522A6002D3DCC00394BD3003445D1002939CD002839CD003344
        D000394AD4002D3CCD002523A800493F9D00FF00FF00FF00FF00FF00FF00FF00
        FF0072727200646464007C7C7C0086868600828282007B7B7B007A7A7A008181
        8100868686007D7D7D00656565006E6E6E00FF00FF00FF00FF00FF00FF00716A
        B3002A27AA002F41D0003541C7002726AB003137BC00384AD300384BD3003137
        BC002726AB003540C7002E40D0002927AC00685FAC00FF00FF00FF00FF008E8E
        8E00686868007F7F7F007E7E7E00686868007676760085858500858585007676
        7600686868007E7E7E007F7F7F006969690086868600FF00FF00FF00FF00332B
        A4002C3CCC003842C6005F5DBD00EDEDF8008B89CE003337B9003437B9008B89
        CE00EDEDF8005F5DBD003741C6002B3ACD003028A400FF00FF00FF00FF006767
        67007C7C7C007F7F7F008D8D8D00F2F2F200ABABAB007676760076767600ABAB
        AB00F2F2F2008D8D8D007E7E7E007C7C7C0066666600FF00FF007E78BF00373B
        BC003042D0002621A500ECE7EC00F5EBE400F8F2EE009491D1009491D100F8F1
        ED00F3E9E200ECE6EB002621A5002E3FCF00343ABE006F69B5009B9B9B007979
        79008080800063636300E9E9E900ECECEC00F3F3F300B1B1B100B1B1B100F2F2
        F200EAEAEA00E9E9E900636363007E7E7E00797979008E8E8E005049B1003542
        CB003446D1002C2FB5008070AD00EBDBD300F4EAE400F7F2ED00F8F1ED00F4E9
        E200EADAD1007F6FAC002B2EB5003144D0003040CB004B44AF007D7D7D008080
        800082828200707070008E8E8E00DFDFDF00ECECEC00F2F2F200F2F2F200EBEB
        EB00DDDDDD008D8D8D0070707000808080007D7D7D0079797900433CB3003648
        D000374AD3003A4ED5003234B4008A7FB900F6ECE700F5ECE600F4EBE500F6EB
        E500897DB8003233B400384BD3003547D2003446D100433CB300777777008383
        83008585850087878700737373009C9C9C00EEEEEE00EDEDED00ECECEC00EDED
        ED009A9A9A0073737300858585008383830082828200777777004A44B9004557
        D7003B50D5004C5FDA004343B7009189C700F7EFE900F6EEE900F6EFE800F7ED
        E8009087C5004242B700495DD800394CD4003F52D4004944B8007F7F7F008E8E
        8E0088888800939393007D7D7D00A8A8A800F0F0F000EFEFEF00EFEFEF00EFEF
        EF00A6A6A6007C7C7C009090900086868600898989007E7E7E006360C4005967
        DA005B6EDD004F4DBA008F89CA00FBF6F400F7F1EC00EDE1D900EDE0D900F7F0
        EA00FAF5F2008F89CA004E4DB900576ADC005765D9005E5CC200929292009999
        99009C9C9C0083838300A9A9A900F7F7F700F1F1F100E3E3E300E3E3E300F0F0
        F000F6F6F600A9A9A9008383830099999900989898008F8F8F009594D7007C85
        DD008798E800291D9B00E5DADE00F6EEEB00EDDFDA00816EA900816EA900EDDF
        D800F4ECE700E5D9DC00291D9B008494E7007A81DD008684CE00B6B6B600ACAC
        AC00B7B7B7005C5C5C00DFDFDF00F0F0F000E3E3E3008B8B8B008B8B8B00E2E2
        E200EDEDED00DFDFDF005C5C5C00B5B5B500ABABAB00A9A9A900FF00FF006A6B
        D3009EACED00686FCE005646A100CCB6BC007A68A8004C4AB6004D4BB7007A68
        A800CBB5BC005646A100666DCC009BAAEE006B6ED200FF00FF00FF00FF009E9E
        9E00C5C5C5009B9B9B0073737300C1C1C1008888880080808000818181008888
        8800C0C0C0007373730099999900C4C4C4009F9F9F00DCDCDC00FF00FF00A3A3
        E1007D84DF00A5B6F1006D74D0002D219B005151B9008EA2EC008EA1EC005252
        BB002D219B006B72D000A2B3F0008086E0009899DB00FF00FF00FF00FF00C1C1
        C100AEAEAE00CBCBCB009E9E9E005E5E5E0085858500BDBDBD00BDBDBD008686
        86005E5E5E009D9D9D00C9C9C900B0B0B000B9B9B900FF00FF00FF00FF00FF00
        FF009193E0008087E200AEBDF300A3B6F1009DAFF00095A9EE0095A8EE009BAD
        EF00A2B3F000ACBCF300838AE3008D90DE00FF00FF00FF00FF00FF00FF00FF00
        FF00B8B8B800B1B1B100D0D0D000CACACA00C6C6C600C1C1C100C1C1C100C5C5
        C500C9C9C900CFCFCF00B3B3B300B6B6B600FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00B8BAEA007A7FE000929CEA00A1AEEF00B0BFF300B0BFF400A2AE
        EF00939DE9007B80E100B4B6E600FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00D1D1D100ACACAC00BEBEBE00C8C8C800D1D1D100D2D2D200C8C8
        C800BEBEBE00ADADAD00CDCDCD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00ACAFE9008C90E400767BE200767BE2008C90
        E400AAADE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00CBCBCB00B8B8B800ACACAC00ACACAC00B8B8
        B800C9C9C900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OptionsImage.NumGlyphs = 2
      TabOrder = 2
    end
    object edSumm: TcxCurrencyEdit
      Left = 89
      Top = 9
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
      Properties.OnChange = edSummPropertiesChange
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      StyleDisabled.TextColor = clBlack
      TabOrder = 3
      Width = 225
    end
    object edSummFact: TcxCurrencyEdit
      Left = 89
      Top = 34
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
      Properties.OnChange = edSummFactPropertiesChange
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      TabOrder = 4
      Width = 225
    end
    object edSummDolg: TcxCurrencyEdit
      Left = 89
      Top = 59
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
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      StyleDisabled.TextColor = clBlack
      TabOrder = 5
      Width = 225
    end
    object edSummCurrency: TcxCurrencyEdit
      Left = 89
      Top = 84
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
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      StyleDisabled.TextColor = clBlack
      TabOrder = 6
      Width = 225
    end
    object btnOplata: TBitBtn
      Left = 351
      Top = 33
      Width = 23
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Action = aOplata
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object btnSaveAndExit: TcxButton
      Left = 654
      Top = 122
      Width = 107
      Height = 25
      Action = aSaveAndExit
      Anchors = [akRight, akBottom]
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
      OptionsImage.Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0093B0A30051876F00216B4B00216B4B00216C4B004780
        67008AAA9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00A2A2A2006B6B6B004646460046464600464646006363
        63009A9A9A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF003F7E630024805C0029AC7E002CC592002DC894002DC693002AAE
        80002585600045816800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF005E5E5E00525252006A6A6A00787878007A7A7A00797979006C6C
        6C005555550063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0032775A00299D74002FC896002EC9960056D4AC0068DAB5003BCD9D0030C9
        960032CA99002BA4790029775700FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0054545400636363007B7B7B007B7B7B0095959500A1A1A100848484007C7C
        7C007E7E7E006767670050505000FF00FF00FF00FF00FF00FF00FF00FF004986
        6C002EA57C0033CA99002EC896004CD2A80020835C0000673B0045BE960031CB
        990031CB980034CC9C0031AD830047886D00FF00FF00FF00FF00FF00FF006767
        6700696969007E7E7E007B7B7B008F8F8F005151510033333300818181007E7E
        7E007E7E7E00808080006F6F6F0068686800FF00FF00FF00FF00ACC4B9002E8A
        66003BCD9E0030CA97004BD3A9003495710087AF9D00B1CFC100238A600045D3
        A80036CF9F0033CD9B003ED0A300319470008FB2A300FF00FF00B7B7B7005C5C
        5C00848484007D7D7D008F8F8F00646464009B9B9B00C0C0C000565656008C8C
        8C0082828200808080008787870062626200A0A0A000FF00FF00619680003DB3
        8C0039CD9F004BD5A90043A3820069978200F8F1EE00F9F3EE00357F5D0056C4
        A10043D5A8003ED3A4003CD1A40041BC95004D8E7500FF00FF007B7B7B007878
        780083838300909090007373730080808000F3F3F300F3F3F3005A5A5A008D8D
        8D008C8C8C0088888800868686007E7E7E006D6D6D00FF00FF003C8466004BCA
        A40044D2A8004FB392004E826A00F0E9E600C0C3B500EFE3DD00CEDDD4001B75
        4F0060DCB80048D8AC0047D6AA0051D4AC002B815F00FF00FF00606060008A8A
        8A008B8B8B008181810068686800EBEBEB00BCBCBC00E6E6E600D5D5D5004848
        48009E9E9E00909090008E8E8E009292920056565600FF00FF002E7D5D0066D9
        B80046D3A8000B674100D2D2CB006A8F7700116B430073967E00F1E8E30072A2
        8B0046A685005EDFBA004CD9AF006BE2C20027846000FF00FF00555555009F9F
        9F008C8C8C0039393900CECECE007C7C7C003E3E3E0084848400EAEAEA008A8A
        8A00767676009E9E9E0092929200A6A6A60055555500FF00FF00418B6D0078D9
        BE0052DAB1003DBA9200096941002F9C760057DEB8002D99730073967E00F0EA
        E7004F886C005ABB9A005BDEB9007FE2C7002E8A6600FF00FF0066666600A8A8
        A800969696007B7B7B0039393900656565009A9A9A006363630084848400EBEB
        EB006B6B6B008A8A8A009C9C9C00B0B0B0005C5C5C00FF00FF006DA68F0077C8
        B00062E0BC0056DDB70059DFBA005CE1BD005EE2BE005FE4C100288C6700698E
        7600E6E1DC00176B47005FD8B40083D5BD0057A08500FF00FF00898989009F9F
        9F00A1A1A100999999009C9C9C009E9E9E00A0A0A000A1A1A1005A5A5A007B7B
        7B00E1E1E100414141009B9B9B00ACACAC007C7C7C00FF00FF00FF00FF00439C
        7B0095ECD6005ADFBA005EE2BD0061E4BF0064E6C10067E6C50067E8C70039A1
        7E001F6D4A00288B640098EFD9004DAC8C00A2C8BA00FF00FF00CDCDCD006F6F
        6F00C0C0C0009C9C9C00A0A0A000A2A2A200A5A5A500A6A6A600A7A7A7006D6D
        6D004646460059595900C3C3C3007C7C7C00B5B5B500FF00FF00FF00FF0066A9
        900078C6AD009AEED90065E5C00064E7C30069E7C6006BE8C8006CE9C9006BEA
        C9005ED6B60097EDD70086D3BB0050A48600FF00FF00FF00FF00FF00FF008888
        88009F9F9F00C4C4C400A5A5A500A5A5A500A8A8A800A9A9A900AAAAAA00AAAA
        AA009A9A9A00C2C2C200ACACAC007A7A7A00FF00FF00FF00FF00FF00FF00FF00
        FF0049A0800070C1A800B5F2E30098F0DA0085EDD40075EBCE0088EFD6009CF2
        DD00BAF4E70078CDB3003FA58200FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF007575750098989800D3D3D300C4C4C400B9B9B900B0B0B000BBBBBB00C7C7
        C700D7D7D700A2A2A20072727200FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0065B0960044AB870085D2BB00A8E6D600C5F4EB00ABE9D80089D8
        C1004BB6920057B39400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF008A8A8A0077777700ABABAB00C7C7C700DCDCDC00CACACA00B0B0
        B0008080800085858500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF007DC2AA0055B494003DAE880055B897006EC0
        A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00A0A0A0008484840075757500868686009797
        9700C9C9C900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OptionsImage.NumGlyphs = 2
      TabOrder = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    LookAndFeel.SkinName = ''
    DockControlHeights = (
      0
      0
      26
      0)
    inherited dxBarManagerChildBar1: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStaticRecCnt'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonEnableAutoRefresh'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 23
          Visible = True
          ItemName = 'dxBarSpinEditHeaderHeight'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
  end
  inherited alChild: TActionList
    inherited aClose: TAction
      Caption = #1054#1090#1084#1077#1085#1072
    end
    inherited aUpd: TAction
      ShortCut = 0
    end
    object aOplata: TAction
      ImageIndex = 164
      OnExecute = aOplataExecute
    end
    object aPrint: TAction
      Caption = #1069#1090#1080#1082#1077#1090#1082#1080
      ImageIndex = 146
      OnExecute = aPrintExecute
    end
    object aSaveAndExit: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      ShortCut = 16397
      OnExecute = aSaveAndExitExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    UpdateSQL.Strings = (
      'EXECUTE PROCEDURE UPD_SKLAD_TMP1(:G_PRODUCT, '
      '                                 :OLD_G_PRODUCT,'
      '                                 :SKLAD,'
      '                                 :AMOUNT,'
      '                                 :PRICE,'
      '                                 :OLD_PRICE,'
      '                                 0,'
      '                                 0,'
      '                                 0,'
      '                                 :CHARGE_ROZN_PROC,'
      '                                 :OLD_CHARGE_ROZN_PROC,'
      '                                 :CHARGE_OPT_PROC,'
      '                                 :OLD_CHARGE_OPT_PROC,'
      '                                 :PRICE_ROZN,'
      '                                 :OLD_PRICE_ROZN,'
      '                                 :PRICE_OPT,'
      '                                 :OLD_PRICE_OPT,'
      '                                 :PRICE_CURRENCY,'
      '                                 :SUMM_CURRENCY)'
      '')
    DeleteSQL.Strings = (
      'EXECUTE PROCEDURE DEL_SKLAD_TMP1(:SKLAD)')
    InsertSQL.Strings = (
      
        'EXECUTE PROCEDURE INS_SKLAD_TMP1(:SKLAD, COALESCE(:G_PRODUCT, CA' +
        'ST(:BARCODE AS INTEGER)), :SKLAD_PARENT)')
    RefreshSQL.Strings = (
      'SELECT s.sklad, '
      '       S.G_PRODUCT,'
      '       S.G_PRODUCT barcode,'
      '       GP.ARTICUL,'
      '       s.amount,'
      '       s.price,'
      '       s.summ,'
      '       lt.amount ostatok,'
      '       s.charge_rozn_proc,'
      '       s.price_rozn,'
      '       s.charge_opt_proc,'
      '       s.price_opt,'
      '       s.sklad_parent'
      
        '  FROM sklad_tmp S LEFT OUTER JOIN G_PRODUCT GP ON GP.g_product ' +
        '= S.g_product'
      
        '                    LEFT OUTER JOIN lt_sklad_product lt ON S.g_p' +
        'roduct = lt.g_product AND LT.g_tochka = 1'
      'where s.sklad = :sklad'
      '   and s.sklad_parent = :sklad_id_'
      'order by 1')
    SelectSQL.Strings = (
      'SELECT s.sklad, '
      '       S.G_PRODUCT,'
      '       S.G_PRODUCT barcode,'
      '       GP.ARTICUL,'
      '       s.amount,'
      '       s.price,'
      '       s.summ,'
      '       lt.amount ostatok,'
      '       s.charge_rozn_proc,'
      '       s.price_rozn,'
      '       s.charge_opt_proc,'
      '       s.price_opt,'
      '       s.sklad_parent'
      
        '  FROM sklad_tmp S LEFT OUTER JOIN G_PRODUCT GP ON GP.g_product ' +
        '= S.g_product'
      
        '                    LEFT OUTER JOIN lt_sklad_product lt ON S.g_p' +
        'roduct = lt.g_product AND LT.g_tochka = 1'
      'where s.sklad_parent = :sklad_id_'
      'order by 1')
    AutoUpdateOptions.UpdateTableName = 'sklad'
    AutoUpdateOptions.KeyFields = 'sklad'
    AutoUpdateOptions.GeneratorName = 'GEN_DETAILS_TMP'
    AutoUpdateOptions.WhenGetGenID = wgOnNewRecord
    AutoUpdateOptions.AutoParamsToFields = True
    AutoUpdateOptions.UseReturningFields = [rfKeyFields]
    AfterInsert = spReadAfterInsert
    AfterPost = spReadAfterPost
    BeforeDelete = spReadBeforeDelete
    UpdateTransaction = tranWrite
    AutoCommit = True
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE DEL_SKLAD_TMP1 (?SKLAD_, ?SKLAD_PARENT_)')
    StoredProcName = 'DEL_SKLAD_TMP1'
  end
  object spPostavshik: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_CLIENT_LIST(?G_CLIENT_PARENT_)')
    Filter = 'is_supplier = 1'
    Transaction = tranRead
    Database = MainDM.dbMain
    Filtered = True
    Left = 552
    Top = 48
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsPostavshik: TDataSource
    DataSet = spPostavshik
    Left = 575
    Top = 48
  end
  object spPaymentType: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_PAYMENT_TYPE_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 552
    Top = 80
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsPaymentType: TDataSource
    DataSet = spPaymentType
    Left = 575
    Top = 80
  end
  object spProduct: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT G_PRODUCT, NAME, BARCODE FROM G_PRODUCT'
      'WHERE IS_CATEGORY = 0'
      'AND IS_ACTIVE = 1'
      'ORDER BY NAME')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 544
    Top = 168
    poSQLINT64ToBCD = True
    poAskRecordCount = True
    oTrimCharFields = False
    oAutoFormatFields = False
  end
  object dsProduct: TDataSource
    DataSet = spProduct
    Left = 576
    Top = 168
  end
  object spGetData: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_SKLAD (?SKLAD_, ?MODE_, ?SKLAD_PARENT_)')
    StoredProcName = 'GET_SKLAD'
    Left = 496
    Top = 358
  end
  object spIns: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INS_SKLAD (?G_TOCHKA_, ?DATE_RECEIPT_, ?TIME_R' +
        'ECEIPT_, ?G_CLIENT_, ?G_PAYMENT_TYPE_, ?OSNOVANIE_, ?NOTE_, ?IS_' +
        'VOZVRAT_, ?SUMM_, ?SUMM_FACT_, ?G_PRIHOD_, ?SUMM_PRIHOD_, ?PAYME' +
        'NTS_, ?SUMM_CURRENCY_, ?SKLAD_NAKL_ID_)')
    StoredProcName = 'INS_SKLAD'
    Left = 528
    Top = 358
  end
  object spUpd: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UPD_SKLAD (?SKLAD_PARENT_, ?DATE_RECEIPT_, ?TI' +
        'ME_RECEIPT_, ?G_CLIENT_, ?G_PAYMENT_TYPE_, ?OSNOVANIE_, ?NOTE_, ' +
        '?SUMM_, ?SUMM_FACT_, ?G_PRIHOD_, ?SUMM_PRIHOD_, ?PAYMENTS_, ?SUM' +
        'M_CURRENCY_)')
    StoredProcName = 'UPD_SKLAD'
    Left = 560
    Top = 358
  end
  object spUpdPrices: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE PROCEDURE_UPDATE2 ')
    StoredProcName = 'PROCEDURE_UPDATE2'
    Left = 598
    Top = 358
  end
  object spDoReturn: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'insert into sklad_tmp'
      'select GEN_ID(gen_details_tmp, 1),'
      '       zd.g_product,'
      '       zd.amount,'
      '       zd.price - zd.discount_tenge,'
      '       zd.summ,'
      '       0, 0, NULL, 0, 0'
      '  from zakaz_details zd'
      ' where zd.zakaz = :ZAKAZ_')
    Left = 576
    Top = 121
  end
  object spUpdLock: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE DO_UPDATE (?ID_, ?TABLE_NAME_, ?ERR_CODE, ?ERR' +
        '_MSG)')
    StoredProcName = 'DO_UPDATE'
    Left = 616
    Top = 121
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 424
    Top = 375
    PixelsPerInch = 96
    object stlNewRecord: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveCaption
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = cl3DDkShadow
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 304
    Top = 192
  end
  object spFindProduct: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_GET_G_PRODUCT_BY_BARCODE (?BARCODE_, ?ARTICU' +
        'L_, ?NOMER_, ?NAME_, ?PREFIX_)')
    StoredProcName = 'G_GET_G_PRODUCT_BY_BARCODE'
    Left = 263
    Top = 194
  end
end
