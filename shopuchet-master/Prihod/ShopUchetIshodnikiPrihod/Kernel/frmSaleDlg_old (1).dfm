inherited SaleDlgForm: TSaleDlgForm
  Left = 635
  Top = 184
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
  ClientHeight = 488
  ClientWidth = 464
  Color = clBtnFace
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 14
  inherited btnOk: TBitBtn
    Left = 242
    Top = 451
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
  end
  inherited btnCancel: TBitBtn
    Left = 346
    Top = 451
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
  end
  inherited Panel1: TPanel
    Left = 21
    Top = 6
    Width = 420
    Height = 437
    Anchors = []
    Color = clBtnFace
    object lb4: TLabel
      Left = 9
      Top = 80
      Width = 49
      Height = 23
      Caption = #1062#1077#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lb1: TLabel
      Left = 9
      Top = 118
      Width = 116
      Height = 23
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lb3: TLabel
      Left = 10
      Top = 154
      Width = 70
      Height = 23
      Caption = #1057#1082#1080#1076#1082#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lb2: TLabel
      Left = 9
      Top = 192
      Width = 63
      Height = 23
      Caption = #1057#1091#1084#1084#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lb6: TLabel
      Left = 9
      Top = 226
      Width = 137
      Height = 23
      Caption = #1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edPrice: TdxCurrencyEdit
      Left = 175
      Top = 79
      Width = 186
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Style.BorderStyle = xbsFlat
      TabOrder = 0
      Alignment = taRightJustify
      OnChange = edPriceChange
      DisplayFormat = ',0.00;-,0.00'
      StoredValues = 1
    end
    object edSkidka: TdxCurrencyEdit
      Left = 175
      Top = 154
      Width = 186
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Style.BorderStyle = xbsFlat
      TabOrder = 2
      Alignment = taRightJustify
      OnChange = edSkidkaChange
      DisplayFormat = '0.00%'
      StoredValues = 1
    end
    object edSumm: TdxCurrencyEdit
      Left = 175
      Top = 190
      Width = 186
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Style.BorderStyle = xbsFlat
      TabOrder = 4
      Alignment = taRightJustify
      DisplayFormat = ',0.00;-,0.00'
      StoredValues = 1
    end
    object edSkidkaSumm: TdxCurrencyEdit
      Left = 175
      Top = 227
      Width = 186
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Style.BorderStyle = xbsFlat
      TabOrder = 5
      Alignment = taRightJustify
      DisplayFormat = ',0.00;-,0.00'
      StoredValues = 1
    end
    inline MyCurrencyFrameForm: TMyCurrencyFrameForm
      Left = 174
      Top = 116
      Width = 198
      Height = 34
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      inherited sbCur: TSpinButton [0]
        Left = 128
        Width = 29
        Height = 32
      end
      inherited edAmount: TEdit [1]
        Left = 2
        Width = 186
        Height = 33
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -21
        Font.Name = 'Tahoma'
        ParentFont = False
        Text = '1.00'
        OnChange = MyCurrencyFrameFormedAmountChange
      end
    end
    object pnName: TPanel
      Left = 11
      Top = 9
      Width = 400
      Height = 65
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clGreen
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object lbName: TLabel
        Left = 0
        Top = 0
        Width = 400
        Height = 65
        Align = alClient
        Caption = 'lbName'
        WordWrap = True
      end
    end
    object pn1: TPanel
      Left = 2
      Top = 280
      Width = 416
      Height = 114
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 6
      DesignSize = (
        416
        114)
      object lb5: TLabel
        Left = 9
        Top = 15
        Width = 40
        Height = 21
        Caption = #1062#1077#1085#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clActiveCaption
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
        Caption = #1057#1082#1080#1076#1082#1072' '#1074
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object cbPrice: TComboBox
        Left = 88
        Top = 11
        Width = 147
        Height = 29
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 21
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = #1056#1086#1079#1085#1080#1094#1072
        OnChange = cbPriceChange
        Items.Strings = (
          #1056#1086#1079#1085#1080#1094#1072
          #1054#1087#1090#1086#1074#1072#1103)
      end
      object cbSkidka: TComboBox
        Left = 88
        Top = 65
        Width = 147
        Height = 29
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 21
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = #1055#1088#1086#1094#1077#1085#1090#1072#1093
        OnChange = cbSkidkaChange
        Items.Strings = (
          #1055#1088#1086#1094#1077#1085#1090#1072#1093
          #1044#1077#1085#1077#1078#1085#1099#1093' '#1077#1076'.')
      end
      object btnBreakTovar: TButton
        Left = 283
        Top = 11
        Width = 121
        Height = 86
        Action = aBreakTovar
        Anchors = [akTop, akRight]
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        WordWrap = True
      end
    end
    object pn2: TPanel
      Left = 2
      Top = 394
      Width = 416
      Height = 41
      Align = alBottom
      TabOrder = 7
      DesignSize = (
        416
        41)
      object cbShowForm: TCheckBox
        Left = 6
        Top = 6
        Width = 405
        Height = 28
        Hint = #1053#1072#1078#1084#1080#1090#1077', '#1077#1089#1083#1080' '#1085#1077' '#1093#1086#1090#1080#1090#1077' '#1073#1086#1083#1100#1096#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1076#1072#1085#1085#1086#1077' '#1086#1082#1085#1086
        Anchors = [akRight, akBottom]
        Caption = #1042#1089#1077#1075#1076#1072' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1101#1090#1086' '#1086#1082#1085#1086
        Checked = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  inherited btHelp: TBitBtn
    Top = 515
  end
  inherited dxEditStyleController: TdxEditStyleController
    Left = 25
    Top = 457
  end
  inherited dxCheckEditStyleController: TdxCheckEditStyleController
    Left = 55
    Top = 456
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 60
    Top = 186
  end
  inherited ActionList: TActionList
    Left = 88
    Top = 457
    object aBreakTovar: TAction
      Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1087#1086#1096#1090#1091#1095#1085#1086' (F1)'
      ShortCut = 112
      OnExecute = aBreakTovarExecute
    end
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 135
    Top = 450
  end
  object spGetData: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_GET_G_PRODUCT_SALEMODE (?G_PRODUCT_, ?G_TOCH' +
        'KA_)')
    StoredProcName = 'G_GET_G_PRODUCT_SALEMODE'
    Left = 168
    Top = 451
  end
end
