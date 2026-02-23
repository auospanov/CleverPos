inherited PrihodTovaraNForm: TPrihodTovaraNForm
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 645
  ClientWidth = 770
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 776
  ExplicitHeight = 671
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 754
    Height = 600
    ExplicitWidth = 754
    ExplicitHeight = 600
    object pnlTop: TPanel
      Left = 2
      Top = 2
      Width = 750
      Height = 215
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        750
        215)
      object shpNonCashPayType1: TShape
        Left = 137
        Top = 115
        Width = 608
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object shpNonCashPayType: TShape
        Left = 7
        Top = 115
        Width = 131
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shpSklad: TShape
        Left = 7
        Top = 181
        Width = 131
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Shape11: TShape
        Left = 542
        Top = 7
        Width = 74
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shpNote: TShape
        Left = 7
        Top = 141
        Width = 131
        Height = 41
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shpPayType: TShape
        Left = 7
        Top = 89
        Width = 131
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Shape17: TShape
        Left = 7
        Top = 59
        Width = 131
        Height = 31
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Shape14: TShape
        Left = 7
        Top = 33
        Width = 131
        Height = 27
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
        Width = 131
        Height = 27
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
      object Label8: TLabel
        Left = 13
        Top = 39
        Width = 119
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090'-'#1086#1089#1085#1086#1074#1072#1085#1080#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 13
        Top = 68
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
      object lbPayment: TLabel
        Left = 13
        Top = 95
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
      object lbNote: TLabel
        Left = 13
        Top = 155
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
      object Shape13: TShape
        Left = 137
        Top = 7
        Width = 406
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object Label10: TLabel
        Left = 551
        Top = 12
        Width = 36
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Caption = #1042#1088#1077#1084#1103
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExplicitLeft = 279
      end
      object Shape15: TShape
        Left = 615
        Top = 7
        Width = 130
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object Shape16: TShape
        Left = 137
        Top = 33
        Width = 608
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object Shape18: TShape
        Left = 137
        Top = 59
        Width = 608
        Height = 31
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object Shape26: TShape
        Left = 137
        Top = 89
        Width = 608
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object shpNote1: TShape
        Left = 137
        Top = 141
        Width = 608
        Height = 41
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object lbSklad: TLabel
        Left = 13
        Top = 187
        Width = 33
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1082#1083#1072#1076
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shpSklad1: TShape
        Left = 137
        Top = 181
        Width = 608
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object lbNonCashPayType: TLabel
        Left = 13
        Top = 122
        Width = 71
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1058#1080#1087' '#1088#1072#1089#1095#1077#1090#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object edDate: TcxDateEdit
        Left = 142
        Top = 9
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Properties.InputKind = ikMask
        Properties.OnChange = edDatePropertiesChange
        Style.BorderStyle = ebsFlat
        Style.StyleController = dxEditStyleController
        Style.TransparentBorder = False
        Style.ButtonStyle = bts3D
        Style.ButtonTransparency = ebtNone
        TabOrder = 0
        Width = 397
      end
      object edTime: TcxTimeEdit
        Left = 621
        Top = 9
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        EditValue = 0d
        Properties.BeepOnError = True
        Properties.TimeFormat = tfHourMin
        Properties.OnChange = edTimePropertiesChange
        Style.BorderStyle = ebsFlat
        Style.StyleController = dxEditStyleController
        Style.TransparentBorder = False
        TabOrder = 1
        Width = 119
      end
      object edOsnovanie: TcxTextEdit
        Left = 142
        Top = 35
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Properties.MaxLength = 150
        Style.BorderStyle = ebsFlat
        Style.LookAndFeel.Kind = lfFlat
        Style.StyleController = dxEditStyleController
        Style.TransparentBorder = False
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.Kind = lfFlat
        TabOrder = 2
        Width = 598
      end
      object lePostavshik: TcxLookupComboBox
        Left = 142
        Top = 64
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Properties.DropDownListStyle = lsFixedList
        Properties.GridMode = True
        Properties.KeyFieldNames = 'G_CLIENT'
        Properties.ListColumns = <
          item
            Width = 64
            FieldName = 'NAME_PHONE_'
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
        TabOrder = 3
        Width = 480
      end
      object lePAYMENT_TYPE: TcxLookupComboBox
        Left = 142
        Top = 92
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Properties.DropDownListStyle = lsFixedList
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
        TabOrder = 4
        Width = 598
      end
      object mNote: TcxMemo
        Left = 142
        Top = 145
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Style.LookAndFeel.Kind = lfFlat
        Style.StyleController = dxEditStyleController
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.Kind = lfFlat
        TabOrder = 5
        Height = 34
        Width = 598
      end
      object leSklad: TcxLookupComboBox
        Left = 142
        Top = 184
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Properties.DropDownListStyle = lsFixedList
        Properties.GridMode = True
        Properties.KeyFieldNames = 'G_TOCHKA'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsReadSklad
        Style.LookAndFeel.Kind = lfFlat
        Style.StyleController = dxEditStyleController
        Style.TransparentBorder = False
        Style.ButtonTransparency = ebtNone
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.Kind = lfFlat
        TabOrder = 6
        Width = 598
      end
      object btnSearchClient: TcxButton
        Left = 630
        Top = 61
        Width = 107
        Height = 25
        Action = aSearchClient
        Anchors = [akTop, akRight]
        LookAndFeel.Kind = lfFlat
        LookAndFeel.NativeStyle = False
        TabOrder = 7
      end
      object leNonCashPayType: TcxLookupComboBox
        Left = 142
        Top = 118
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'G_NONCASH_PAY_TYPE'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsNonCashPayTypes
        Style.StyleController = dxEditStyleController
        Style.ButtonTransparency = ebtNone
        TabOrder = 8
        Width = 598
      end
    end
    object pcMain: TcxPageControl
      Left = 2
      Top = 217
      Width = 750
      Height = 381
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      Properties.ActivePage = tsCommon
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 5
      ClientRectBottom = 381
      ClientRectRight = 750
      ClientRectTop = 26
      object tsCommon: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1044#1077#1090#1072#1083#1080
        ImageIndex = 0
        object pn1: TPanel
          Left = 0
          Top = 0
          Width = 750
          Height = 355
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object pn2: TPanel
            Left = 0
            Top = 0
            Width = 750
            Height = 39
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              750
              39)
            object btnIns: TBitBtn
              Left = 5
              Top = 8
              Width = 119
              Height = 24
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Action = aIns
              Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
              Glyph.Data = {
                36080000424D3608000000000000360000002800000020000000100000000100
                20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00BF988300AF745400A8653F00A9664100AE74
                5400BE988300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF007F7F7F00A1A1A1008181810073737300757575008181
                8100A0A0A0007F7F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00C1998300AE673E00C5895700D6A36D00DDAF7500DDAF7400D6A4
                6B00C5895600AE6B4100C8AD9E00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00A2A2A200767676008E8E8E00A1A1A100A9A9A900A8A8A800A0A0
                A0008D8D8D0077777700B3B3B300FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00BA886C00BC7C4D00DDAE7700DEB07600E2B78200E3BB8700E3BC8600E1B7
                8200DEAF7400DBAB7200BD7E4E00B9886E00FF00FF00FF00FF00FF00FF00FF00
                FF009393930084848400AAAAAA00AAAAAA00B2B2B200B5B5B500B4B4B400B1B1
                B100A9A9A900A6A6A6008585850093939300FF00FF00FF00FF00FF00FF00C6A0
                8A00BE805300E0B37C00DFB07600DEB17700B7825400AA714400AB724500BC88
                5900DFB27900DFB27700DEB07700C0825300C29F8A00FF00FF00FF00FF00A8A8
                A80088888800AEAEAE00AAAAAA00AAAAAA008585850077777700787878008A8A
                8A00ACACAC00ABABAB00AAAAAA0089898900A6A6A600FF00FF00FF00FF00B575
                4C00DFB27D00DFB27A00E0B37B00E0B57D00A56B3F00F5EFEA00F8F3EE00AB72
                4500E2B67E00E0B47C00E0B47B00DEB07900B7774E00FF00FF007F7F7F008080
                8000AEAEAE00ACACAC00ADADAD00AEAEAE0072727200EFEFEF00F3F3F3007878
                7800B0B0B000AEAEAE00ADADAD00ABABAB00828282007F7F7F00CBA69100CD9B
                6F00E2B78000E5BD8900E7C29100E8C39300A56B3F00F1E6DE00F9F5F100AA71
                4400E8C49400E8C39300E5BF8C00E1B77F00D09C6E00C8A89500AEAEAE009E9E
                9E00B1B1B100B7B7B700BCBCBC00BDBDBD0072727200E7E7E700F5F5F5007777
                7700BEBEBE00BDBDBD00B8B8B800B0B0B0009F9F9F00AEAEAE00C08B6A00DCB3
                8300E3B78100BA865900A9704300AB724500AC734600F5EDE600FAF6F300AD75
                4700B0784A00B17A4B00C2916200E4B98300DEB17E00BD8A6A0095959500AFAF
                AF00B2B2B20089898900767676007878780079797900EDEDED00F6F6F6007A7A
                7A007D7D7D007E7E7E0092929200B3B3B300AEAEAE0093939300BD815900E3BF
                8F00E4BB8400A56B3F00F3EBE600FAF6F300F6EFE800F7F0EA00FBF7F500FAF7
                F400FAF7F300FAF6F200AB724500E5BD8700E5BE8B00BC825D008B8B8B00B9B9
                B900B4B4B40072727200ECECEC00F6F6F600EFEFEF00F0F0F000F8F8F800F7F7
                F700F6F6F600F6F6F60078787800B6B6B600B8B8B8008C8C8C00C1896200E9C9
                A000E5BE8900A56B3F00E0D2CA00E1D3CC00E3D5CF00F2EAE400F8F3EF00EADF
                D900E6DAD400E9DED900AA714400E7C08C00EACA9D00BF87600091919100C4C4
                C400B7B7B70072727200D5D5D500D6D6D600D9D9D900EBEBEB00F3F3F300E1E1
                E100DDDDDD00E1E1E10077777700B9B9B900C3C3C3008F8F8F00C9997800E9CD
                AC00EAC79600B7845600A56B3F00A56B3F00A56B3F00F1EAE500FAF6F300A56B
                3F00A56B3F00A56B3F00B7845700EACA9900EBD1AD00C4957400A0A0A000CACA
                CA00C0C0C00086868600727272007272720072727200EBEBEB00F6F6F6007272
                7200727272007272720087878700C1C1C100CCCCCC009C9C9C00D6B69E00DDBB
                9D00EED3A900EECFA200EED2A500F0D6A900A56B3F00F0EAE700FDFCFB00A56B
                3F00F1D6AA00F0D5A800EED2A500EFD4A700E0C2A200D2B6A100BABABA00BDBD
                BD00CBCBCB00C8C8C800C9C9C900CCCCCC0072727200EBEBEB00FCFCFC007272
                7200CDCDCD00CCCCCC00C9C9C900CBCBCB00C1C1C100B9B9B900FF00FF00CA97
                6F00F5E8CC00EFD6AB00F1D8AE00F2DAB000A56B3F00DECFC900DFD1CB00A56B
                3F00F3DCB200F1DBB000F1D8AD00F7EACD00CB997500FF00FF00FF00FF009C9C
                9C00E0E0E000CDCDCD00CFCFCF00D1D1D10072727200D3D3D300D5D5D5007272
                7200D2D2D200D0D0D000CFCFCF00E2E2E200A0A0A000FF00FF00FF00FF00DCBF
                A900D7B08C00F8EFD300F3E0B900F3DFB700B98A5F00A56B3F00A56B3F00BA8A
                5F00F4E1B900F4E2BD00FAF1D500D9B39000D9BEA900FF00FF00FF00FF00C2C2
                C200B1B1B100E5E5E500D6D6D600D5D5D5008C8C8C0072727200727272008C8C
                8C00D6D6D600D8D8D800E7E7E700B4B4B400C1C1C100FF00FF00FF00FF00FF00
                FF00D7B39500D9B38F00F7EDD300F8EED000F7EBC900F6E8C400F6E8C500F7EC
                CA00F8EED000F4E8CD00D7AF8B00D4B29600FF00FF00FF00FF00FF00FF00FF00
                FF00B6B6B600B4B4B400E5E5E500E4E4E400E0E0E000DDDDDD00DDDDDD00E0E0
                E000E4E4E400E0E0E000B1B1B100B5B5B500FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00E0C4AF00D2A37B00E2C4A200EBD7B800F4E9CD00F4EACE00ECD8
                B900E3C5A300D2A68000E4D1C200FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00C7C7C700A6A6A600C2C2C200D1D1D100E0E0E000E1E1E100D2D2
                D200C3C3C300A9A9A900D3D3D300FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00E2CAB400D7B19200D3A57E00D2A68100D6B0
                9200E0C8B300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00CBCBCB00B4B4B400A8A8A800A9A9A900B4B4
                B400C9C9C900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
              NumGlyphs = 2
              TabOrder = 1
            end
            object btnUpd: TBitBtn
              Left = 124
              Top = 8
              Width = 88
              Height = 24
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Action = aUpd
              Caption = #1048#1079#1084#1077#1085#1080#1090#1100
              Glyph.Data = {
                36080000424D3608000000000000360000002800000020000000100000000100
                20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001340
                580015425E0025699C002C76B4007AB0D000FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003535
                3500393939006060600070707000A5A5A500FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001242
                59005D9CD400A6CFF500A9CFEC00488BC1002C76B400FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003535
                350098989800CDCDCD00CACACA008484840070707000FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001E6D
                9300CBE3F90061AAEC004098E8001567C2001660AA002C76B400FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005858
                5800E2E2E200A6A6A600949494006B6B6B006060600070707000FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001E6D
                9300C8E1F200D1E7FA00347DB5003199C3006DC4DC004A9CCF003483C700FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005858
                5800DDDDDD00E5E5E500747474007A7A7A00A4A4A4008C8C8C007D7D7D00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF002689B900B0CBE10067A9C80060DCF50044D6F4008EEEFA005DB4E6003B8F
                D900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF006F6F6F00C8C8C80097979700AAAAAA009C9C9C00C4C4C400A1A1A1008A8A
                8A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF002689B900BEE6F200B3F4FC0060DCF50044D6F4008EEEFA005DB4
                E6003B8FD900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF006F6F6F00D8D8D800D7D7D700AAAAAA009C9C9C00C4C4C400A1A1
                A1008A8A8A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF002790BF00C3EDF800B3F4FC0060DCF50044D6F4008EEE
                FA005DB4E6003B8FD900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF0073737300DDDDDD00D7D7D700AAAAAA009C9C9C00C4C4
                C400A1A1A1008A8A8A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF002FBAE400C3EDF800B3F4FC0060DCF50044D6
                F4008EEEFA005DB4E6003B8FD900FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF0089898900DDDDDD00D7D7D700AAAAAA009C9C
                9C00C4C4C400A1A1A1008A8A8A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF002FBAE400C3EDF800B3F4FC0060DC
                F50044D6F4008EEEFA005DB4E6003B8FD900FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF0089898900DDDDDD00D7D7D700AAAA
                AA009C9C9C00C4C4C400A1A1A1008A8A8A00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002FBAE400C3EDF800B3F4
                FC0068D9F5006FCFF300599DD00073ABDD004F91C900FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0089898900DDDDDD00D7D7
                D700AEAEAE00B1B1B10094949400A8A8A8008C8C8C00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002FBAE400C3ED
                F800A8E2F8006CAEDD00A5CFF400A5CFF400BDDBF7005896CD00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0089898900DDDD
                DD00D0D0D000A4A4A400CCCCCC00CCCCCC00DADADA0092929200FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002FBA
                E400A7D4F400C5E1F800CCE3F900CCE3F900BDDBF7005091C900FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008989
                8900CDCDCD00DEDEDE00E2E2E200E2E2E200DADADA008C8C8C00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF0050A8D9006AA5D800C9E1F700CBE3F8004295CA0072AAD500FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF0094949400A1A1A100E0E0E000E1E1E10086868600A3A3A300FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF005DB1DE005194CA004E90C80049A9D800FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF009D9D9D008D8D8D008B8B8B0090909000FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
              NumGlyphs = 2
              TabOrder = 2
            end
            object btnDel: TBitBtn
              Left = 212
              Top = 8
              Width = 96
              Height = 24
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Action = aDel
              Caption = #1059#1076#1072#1083#1080#1090#1100
              Glyph.Data = {
                36080000424D3608000000000000360000002800000020000000100000000100
                20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00BF988300AF745400A8653F00A9664100AE74
                5400BE988300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00A1A1A1008181810073737300757575008181
                8100A0A0A000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00C1998300AE673E00C5895700D6A36D00DDAF7500DDAF7400D6A4
                6B00C5895600AE6B4100C8AD9E00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00A2A2A200767676008E8E8E00A1A1A100A9A9A900A8A8A800A0A0
                A0008D8D8D0077777700B3B3B300FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00BA886C00BC7C4D00DDAE7700DEB07600DEAF7500DEAF7500DEB07400DDAF
                7500DEAF7400DBAB7200BD7E4E00B9886E00FF00FF00FF00FF00FF00FF00FF00
                FF009393930084848400AAAAAA00AAAAAA00A9A9A900A9A9A900A9A9A900A9A9
                A900A9A9A900A6A6A6008585850093939300FF00FF00FF00FF00FF00FF00C6A0
                8A00BE805300E0B37C00DFB07600DEB17700DFB27900E0B37900E0B27A00E0B2
                7900DFB27900DFB27700DEB07700C0825300C29F8A00FF00FF00FF00FF00A8A8
                A80088888800AEAEAE00AAAAAA00AAAAAA00ACACAC00ACACAC00ADADAD00ACAC
                AC00ACACAC00ABABAB00AAAAAA0089898900A6A6A600FF00FF00FF00FF00B575
                4C00DFB27D00DFB27A00E0B37B00E0B57D00E1B67E00E2B67F00E2B77F00E2B7
                7F00E2B67E00E0B47C00E0B47B00DEB07900B7774E00FF00FF00FF00FF008080
                8000AEAEAE00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B0B0B000B0B0
                B000B0B0B000AEAEAE00ADADAD00ABABAB0082828200FF00FF00CBA69100CD9B
                6F00E2B78000E5BD8900E7C29100E8C39300E8C49400E8C59400E8C49500E8C4
                9500E8C49400E8C39300E5BF8C00E1B77F00D09C6E00C8A89500AEAEAE009E9E
                9E00B1B1B100B7B7B700BCBCBC00BDBDBD00BEBEBE00BEBEBE00BEBEBE00BEBE
                BE00BEBEBE00BDBDBD00B8B8B800B0B0B0009F9F9F00AEAEAE00C08B6A00DCB3
                8300E3B78100BA865900A9704300AB724500AC734600B0794A00AB724500AD75
                4700B0784A00B17A4B00C2916200E4B98300DEB17E00BD8A6A0095959500AFAF
                AF00B2B2B200898989007676760078787800797979007D7D7D00787878007A7A
                7A007D7D7D007E7E7E0092929200B3B3B300AEAEAE0093939300BD815900E3BF
                8F00E4BB8400A56B3F00F5EEE900FAF6F300FAF7F300FBF7F400FBF7F500FAF7
                F400FAF7F300FAF6F200AB724500E5BD8700E5BE8B00BC825D008B8B8B00B9B9
                B900B4B4B40072727200EFEFEF00F6F6F600F6F6F600F7F7F700F8F8F800F7F7
                F700F6F6F600F6F6F60078787800B6B6B600B8B8B8008C8C8C00C1896200E9C9
                A000E5BE8900A56B3F00E6D9D200E7DBD400E9DED700EAE0D900EAE0DA00EBE1
                DB00EBE0DB00EEE5E100AA714400E7C08C00EACA9D00BF87600091919100C4C4
                C400B7B7B70072727200DCDCDC00DDDDDD00E0E0E000E1E1E100E2E2E200E3E3
                E300E3E3E300E7E7E70077777700B9B9B900C3C3C3008F8F8F00C9997800E9CD
                AC00EAC79600B7845600A56B3F00A56B3F00A56B3F00A56B3F00A56B3F00A56B
                3F00A56B3F00A56B3F00B7845700EACA9900EBD1AD00C4957400A0A0A000CACA
                CA00C0C0C0008686860072727200727272007272720072727200727272007272
                7200727272007272720087878700C1C1C100CCCCCC009C9C9C00D6B69E00DDBB
                9D00EED3A900EECFA200EED2A500F0D6A900F1D7AB00F1D8AD00F1D8AD00F1D8
                AD00F1D6AA00F0D5A800EED2A500EFD4A700E0C2A200D2B6A100BABABA00BDBD
                BD00CBCBCB00C8C8C800C9C9C900CCCCCC00CECECE00CFCFCF00CFCFCF00CFCF
                CF00CDCDCD00CCCCCC00C9C9C900CBCBCB00C1C1C100B9B9B900FF00FF00CA97
                6F00F5E8CC00EFD6AB00F1D8AE00F2DAB000F3DCB300F3DEB400F3DEB400F3DE
                B400F3DCB200F1DBB000F1D8AD00F7EACD00CB997500FF00FF00FF00FF009C9C
                9C00E0E0E000CDCDCD00CFCFCF00D1D1D100D3D3D300D3D3D300D3D3D300D3D3
                D300D2D2D200D0D0D000CFCFCF00E2E2E200A0A0A000FF00FF00FF00FF00DCBF
                A900D7B08C00F8EFD300F3E0B900F3DFB700F4E1B900F5E3BB00F5E2BB00F5E2
                BB00F4E1B900F4E2BD00FAF1D500D9B39000D9BEA900FF00FF00FF00FF00C2C2
                C200B1B1B100E5E5E500D6D6D600D5D5D500D6D6D600D8D8D800D8D8D800D8D8
                D800D6D6D600D8D8D800E7E7E700B4B4B400C1C1C100FF00FF00FF00FF00FF00
                FF00D7B39500D9B38F00F7EDD300F8EED000F7EBC900F6E8C400F6E8C500F7EC
                CA00F8EED000F4E8CD00D7AF8B00D4B29600FF00FF00FF00FF00FF00FF00FF00
                FF00B6B6B600B4B4B400E5E5E500E4E4E400E0E0E000DDDDDD00DDDDDD00E0E0
                E000E4E4E400E0E0E000B1B1B100B5B5B500FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00E0C4AF00D2A37B00E2C4A200EBD7B800F4E9CD00F4EACE00ECD8
                B900E3C5A300D2A68000E4D1C200FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00C7C7C700A6A6A600C2C2C200D1D1D100E0E0E000E1E1E100D2D2
                D200C3C3C300A9A9A900D3D3D300FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00E2CAB400D7B19200D3A57E00D2A68100D6B0
                9200E0C8B300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00CBCBCB00B4B4B400A8A8A800A9A9A900B4B4
                B400C9C9C900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
              NumGlyphs = 2
              TabOrder = 3
            end
            object pnRowCnt: TPanel
              Left = 787
              Top = 7
              Width = 48
              Height = 23
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akTop, akRight]
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Caption = '0'
              TabOrder = 0
            end
            object btnNacenka: TcxButton
              Left = 308
              Top = 8
              Width = 107
              Height = 24
              Anchors = [akLeft, akBottom]
              Caption = #1053#1072#1094#1077#1085#1082#1072
              DropDownMenu = pmNakrutka
              Kind = cxbkOfficeDropDown
              LookAndFeel.Kind = lfOffice11
              LookAndFeel.NativeStyle = True
              TabOrder = 4
              OnClick = aPrintExecute
            end
            object btnIns1: TBitBtn
              Left = 416
              Top = 8
              Width = 119
              Height = 24
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Action = aInsNewTovar
              Caption = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
              Glyph.Data = {
                36080000424D3608000000000000360000002800000020000000100000000100
                20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00BF988300AF745400A8653F00A9664100AE74
                5400BE988300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF007F7F7F00A1A1A1008181810073737300757575008181
                8100A0A0A0007F7F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00C1998300AE673E00C5895700D6A36D00DDAF7500DDAF7400D6A4
                6B00C5895600AE6B4100C8AD9E00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00A2A2A200767676008E8E8E00A1A1A100A9A9A900A8A8A800A0A0
                A0008D8D8D0077777700B3B3B300FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00BA886C00BC7C4D00DDAE7700DEB07600E2B78200E3BB8700E3BC8600E1B7
                8200DEAF7400DBAB7200BD7E4E00B9886E00FF00FF00FF00FF00FF00FF00FF00
                FF009393930084848400AAAAAA00AAAAAA00B2B2B200B5B5B500B4B4B400B1B1
                B100A9A9A900A6A6A6008585850093939300FF00FF00FF00FF00FF00FF00C6A0
                8A00BE805300E0B37C00DFB07600DEB17700B7825400AA714400AB724500BC88
                5900DFB27900DFB27700DEB07700C0825300C29F8A00FF00FF00FF00FF00A8A8
                A80088888800AEAEAE00AAAAAA00AAAAAA008585850077777700787878008A8A
                8A00ACACAC00ABABAB00AAAAAA0089898900A6A6A600FF00FF00FF00FF00B575
                4C00DFB27D00DFB27A00E0B37B00E0B57D00A56B3F00F5EFEA00F8F3EE00AB72
                4500E2B67E00E0B47C00E0B47B00DEB07900B7774E00FF00FF007F7F7F008080
                8000AEAEAE00ACACAC00ADADAD00AEAEAE0072727200EFEFEF00F3F3F3007878
                7800B0B0B000AEAEAE00ADADAD00ABABAB00828282007F7F7F00CBA69100CD9B
                6F00E2B78000E5BD8900E7C29100E8C39300A56B3F00F1E6DE00F9F5F100AA71
                4400E8C49400E8C39300E5BF8C00E1B77F00D09C6E00C8A89500AEAEAE009E9E
                9E00B1B1B100B7B7B700BCBCBC00BDBDBD0072727200E7E7E700F5F5F5007777
                7700BEBEBE00BDBDBD00B8B8B800B0B0B0009F9F9F00AEAEAE00C08B6A00DCB3
                8300E3B78100BA865900A9704300AB724500AC734600F5EDE600FAF6F300AD75
                4700B0784A00B17A4B00C2916200E4B98300DEB17E00BD8A6A0095959500AFAF
                AF00B2B2B20089898900767676007878780079797900EDEDED00F6F6F6007A7A
                7A007D7D7D007E7E7E0092929200B3B3B300AEAEAE0093939300BD815900E3BF
                8F00E4BB8400A56B3F00F3EBE600FAF6F300F6EFE800F7F0EA00FBF7F500FAF7
                F400FAF7F300FAF6F200AB724500E5BD8700E5BE8B00BC825D008B8B8B00B9B9
                B900B4B4B40072727200ECECEC00F6F6F600EFEFEF00F0F0F000F8F8F800F7F7
                F700F6F6F600F6F6F60078787800B6B6B600B8B8B8008C8C8C00C1896200E9C9
                A000E5BE8900A56B3F00E0D2CA00E1D3CC00E3D5CF00F2EAE400F8F3EF00EADF
                D900E6DAD400E9DED900AA714400E7C08C00EACA9D00BF87600091919100C4C4
                C400B7B7B70072727200D5D5D500D6D6D600D9D9D900EBEBEB00F3F3F300E1E1
                E100DDDDDD00E1E1E10077777700B9B9B900C3C3C3008F8F8F00C9997800E9CD
                AC00EAC79600B7845600A56B3F00A56B3F00A56B3F00F1EAE500FAF6F300A56B
                3F00A56B3F00A56B3F00B7845700EACA9900EBD1AD00C4957400A0A0A000CACA
                CA00C0C0C00086868600727272007272720072727200EBEBEB00F6F6F6007272
                7200727272007272720087878700C1C1C100CCCCCC009C9C9C00D6B69E00DDBB
                9D00EED3A900EECFA200EED2A500F0D6A900A56B3F00F0EAE700FDFCFB00A56B
                3F00F1D6AA00F0D5A800EED2A500EFD4A700E0C2A200D2B6A100BABABA00BDBD
                BD00CBCBCB00C8C8C800C9C9C900CCCCCC0072727200EBEBEB00FCFCFC007272
                7200CDCDCD00CCCCCC00C9C9C900CBCBCB00C1C1C100B9B9B900FF00FF00CA97
                6F00F5E8CC00EFD6AB00F1D8AE00F2DAB000A56B3F00DECFC900DFD1CB00A56B
                3F00F3DCB200F1DBB000F1D8AD00F7EACD00CB997500FF00FF00FF00FF009C9C
                9C00E0E0E000CDCDCD00CFCFCF00D1D1D10072727200D3D3D300D5D5D5007272
                7200D2D2D200D0D0D000CFCFCF00E2E2E200A0A0A000FF00FF00FF00FF00DCBF
                A900D7B08C00F8EFD300F3E0B900F3DFB700B98A5F00A56B3F00A56B3F00BA8A
                5F00F4E1B900F4E2BD00FAF1D500D9B39000D9BEA900FF00FF00FF00FF00C2C2
                C200B1B1B100E5E5E500D6D6D600D5D5D5008C8C8C0072727200727272008C8C
                8C00D6D6D600D8D8D800E7E7E700B4B4B400C1C1C100FF00FF00FF00FF00FF00
                FF00D7B39500D9B38F00F7EDD300F8EED000F7EBC900F6E8C400F6E8C500F7EC
                CA00F8EED000F4E8CD00D7AF8B00D4B29600FF00FF00FF00FF00FF00FF00FF00
                FF00B6B6B600B4B4B400E5E5E500E4E4E400E0E0E000DDDDDD00DDDDDD00E0E0
                E000E4E4E400E0E0E000B1B1B100B5B5B500FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00E0C4AF00D2A37B00E2C4A200EBD7B800F4E9CD00F4EACE00ECD8
                B900E3C5A300D2A68000E4D1C200FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00C7C7C700A6A6A600C2C2C200D1D1D100E0E0E000E1E1E100D2D2
                D200C3C3C300A9A9A900D3D3D300FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00E2CAB400D7B19200D3A57E00D2A68100D6B0
                9200E0C8B300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                FF00FF00FF00FF00FF00FF00FF00CBCBCB00B4B4B400A8A8A800A9A9A900B4B4
                B400C9C9C900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
              NumGlyphs = 2
              TabOrder = 5
            end
          end
          object pn3: TPanel
            Left = 0
            Top = 242
            Width = 750
            Height = 113
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            DesignSize = (
              750
              113)
            object shpCurrency: TShape
              Left = 7
              Top = 81
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
              Top = 56
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
              Top = 31
              Width = 79
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Brush.Color = 16577773
              Pen.Color = clBtnShadow
            end
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
              Width = 505
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
              Pen.Color = clBtnShadow
              ExplicitWidth = 233
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
              Width = 505
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
              Pen.Color = clBtnShadow
              ExplicitWidth = 233
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
              Top = 56
              Width = 505
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
              Pen.Color = clBtnShadow
              ExplicitWidth = 233
            end
            object sbEqualSumm: TSpeedButton
              Left = 596
              Top = 33
              Width = 22
              Height = 21
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akTop, akRight]
              Glyph.Data = {
                7E000000424D7E000000000000003E0000002800000010000000100000000100
                01000000000040000000C40E0000C40E0000020000000000000000000000FFFF
                FF00FFFF0000FFFF0000FFFF0000E00F0000E00F0000F1AF0000F8EF0000F8FF
                0000FC7F0000FD7F0000FA7F0000F6EF0000F40F0000F80F0000FFFF0000FFFF
                0000}
              OnClick = sbEqualSummClick
              ExplicitLeft = 324
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
              Top = 81
              Width = 505
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
              Pen.Color = clBtnShadow
              ExplicitWidth = 233
            end
            object btnOplata: TBitBtn
              Left = 623
              Top = 33
              Width = 23
              Height = 21
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Action = aOplata
              Anchors = [akTop, akRight]
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
            end
            object edSumm: TcxCurrencyEdit
              Left = 89
              Top = 9
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
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
              TabOrder = 0
              Width = 497
            end
            object edSummFact: TcxCurrencyEdit
              Left = 89
              Top = 34
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
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
              TabOrder = 2
              Width = 497
            end
            object edSummDolg: TcxCurrencyEdit
              Left = 89
              Top = 58
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
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
              TabOrder = 3
              Width = 497
            end
            object edSummCurrency: TcxCurrencyEdit
              Left = 89
              Top = 83
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
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
              TabOrder = 4
              Width = 497
            end
          end
          object gr1: TcxGrid
            Left = 0
            Top = 39
            Width = 750
            Height = 203
            Align = alClient
            TabOrder = 1
            LookAndFeel.Kind = lfFlat
            object tvMain: TcxGridDBTableView
              PopupMenu = pmGrid
              Navigator.Buttons.CustomButtons = <>
              OnCellDblClick = tvMainCellDblClick
              OnFocusedRecordChanged = tvMainFocusedRecordChanged
              DataController.DataSource = dsZakazTemp
              DataController.KeyFieldNames = 'SKLAD'
              DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skSum
                  FieldName = 'AMOUNT'
                  Column = clmMainAMOUNT
                end
                item
                  Kind = skSum
                  FieldName = 'SUMM'
                  Column = clmMainSUMM
                end
                item
                  Kind = skSum
                  Column = clmMainSummCurrency
                end>
              DataController.Summary.SummaryGroups = <>
              DataController.Summary.OnAfterSummary = tvMainDataControllerSummaryAfterSummary
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.IncSearch = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnSorting = False
              OptionsView.Footer = True
              OptionsView.GroupByBox = False
              Styles.Inactive = MainDM.stGridSelectedRow
              object clmMainPRODUCT_NAME: TcxGridDBColumn
                Caption = #1058#1086#1074#1072#1088
                DataBinding.FieldName = 'PRODUCT_NAME'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 252
              end
              object clmMainARTICUL: TcxGridDBColumn
                Caption = #1040#1088#1090#1080#1082#1091#1083
                DataBinding.FieldName = 'ARTICUL'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 100
              end
              object clmMainG_UNIT_NAME: TcxGridDBColumn
                Caption = #1045#1076'. '#1080#1079#1084'.'
                DataBinding.FieldName = 'G_UNIT_NAME'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
              end
              object clmMainAMOUNT: TcxGridDBColumn
                Caption = #1050#1086#1083'-'#1074#1086
                DataBinding.FieldName = 'AMOUNT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                Properties.UseLeftAlignmentOnEditing = False
                RepositoryItem = riEditRepositoryCurrencyItem
                HeaderAlignmentHorz = taCenter
                Width = 82
              end
              object clmVES_GRAMM: TcxGridDBColumn
                Caption = #1042#1077#1089
                DataBinding.FieldName = 'VES_GRAMM'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 75
              end
              object clmVES_GRAMM_PRICE: TcxGridDBColumn
                Caption = #1062#1077#1085#1072' '#1079#1072' '#1075#1088'.'
                DataBinding.FieldName = 'VES_GRAMM_PRICE'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 90
              end
              object clmMainPRICE: TcxGridDBColumn
                Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1072
                DataBinding.FieldName = 'PRICE'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                Properties.UseLeftAlignmentOnEditing = False
                HeaderAlignmentHorz = taCenter
                Width = 87
              end
              object clmMainSUMM: TcxGridDBColumn
                Caption = #1057#1091#1084#1084#1072
                DataBinding.FieldName = 'SUMM'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 108
              end
              object clmMainSummCurrency: TcxGridDBColumn
                Caption = #1057#1091#1084#1084#1072' '#1074' '#1091'.'#1077'.'
                DataBinding.FieldName = 'SUMM_Currency'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 80
              end
              object clmMainBARCODE: TcxGridDBColumn
                Caption = #1064#1090#1088#1080#1093#1082#1086#1076
                DataBinding.FieldName = 'BARCODE'
                Visible = False
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 100
              end
              object clmMARGIN_PERCENT: TcxGridDBColumn
                Caption = #1053#1072#1094#1077#1085#1082#1072' %'
                DataBinding.FieldName = 'CHARGE_ROZN_PROC'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00%'
                Properties.UseLeftAlignmentOnEditing = False
                HeaderAlignmentHorz = taCenter
                Width = 112
              end
              object clmMainSALE_PRICE: TcxGridDBColumn
                Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
                DataBinding.FieldName = 'PRICE_ROZN'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                Properties.UseLeftAlignmentOnEditing = False
                HeaderAlignmentHorz = taCenter
                Width = 120
              end
            end
            object lvMain: TcxGridLevel
              GridView = tvMain
            end
          end
        end
      end
      object tsRashod: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1086#1087#1091#1090#1089#1090#1074#1091#1102#1097#1072#1103' '#1089#1090#1072#1090#1100#1103' '#1088#1072#1089#1093#1086#1076#1072
        Color = clBtnFace
        ImageIndex = 1
        ParentColor = False
        DesignSize = (
          750
          355)
        object lbStatya: TLabel
          Left = 16
          Top = 16
          Width = 670
          Height = 48
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            #1045#1089#1083#1080' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086' '#1082' '#1086#1087#1083#1072#1090#1077' '#1079#1072' '#1087#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072', '#1042#1099' '#1085#1077#1089#1077#1090#1077' '#1077#1097#1077' '#1082#1072#1082#1080 +
            #1077'-'#1083#1080#1073#1086' '#1088#1072#1089#1093#1086#1076#1099', '#1090#1086' '#1091#1082#1072#1078#1080#1090#1077' '#1085#1080#1078#1077' '#1089#1090#1072#1090#1100#1102' '#1088#1072#1089#1093#1086#1076#1072' '#1080' '#1089#1091#1084#1084#1091' '#1076#1077#1085#1077#1075'.'#13#10#1053 +
            #1072#1087#1088#1080#1084#1077#1088', '#1101#1090#1086' '#1084#1086#1078#1077#1090' '#1073#1099#1090#1100' '#1088#1072#1089#1093#1086#1076' '#1085#1072' '#1076#1086#1089#1090#1072#1074#1082#1091' '#1090#1086#1074#1072#1088#1072'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object sbClear: TSpeedButton
          Left = 752
          Top = 82
          Width = 25
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akTop, akRight]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF000000
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF000000FF000000
            FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF000000FF000000
            FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF000000
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          ExplicitLeft = 481
        end
        object edSummPrihod: TcxCurrencyEdit
          Left = 17
          Top = 110
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
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 1
          Width = 423
        end
        object leStatya: TcxLookupComboBox
          Left = 17
          Top = 82
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.KeyFieldNames = 'G_PRIHOD_RASHOD'
          Properties.ListColumns = <
            item
              FieldName = 'NAME'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = dsReadStatya
          Properties.UseLeftAlignmentOnEditing = False
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.ButtonTransparency = ebtNone
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 423
        end
      end
      object tsExpected: TcxTabSheet
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        ImageIndex = 2
        DesignSize = (
          750
          355)
        object lbRecalc: TLabel
          Left = 16
          Top = 40
          Width = 665
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            #1045#1089#1083#1080' '#1090#1086#1074#1072#1088' '#1079#1072#1082#1072#1079#1099#1074#1072#1077#1090#1089#1103' '#1091' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072' '#1087#1086' '#1087#1088#1077#1076#1086#1087#1083#1072#1090#1077', '#1090#1086' '#1087#1086#1089#1090#1072#1074#1100#1090#1077 +
            ' '#1101#1090#1091' '#1075#1072#1083#1086#1095#1082#1091' - '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072' '#1085#1072' '#1089#1082#1083#1072#1076#1077' '#1085#1077' '#1080#1079#1084#1077#1085#1080#1090#1089#1103' '#1076#1086' '#1090#1077#1093' '#1087 +
            #1086#1088', '#1087#1086#1082#1072' '#1076#1072#1085#1085#1072#1103' '#1075#1072#1083#1086#1095#1082#1072' '#1086#1090#1084#1077#1095#1077#1085#1072'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object cbIsExpected: TcxCheckBox
          Left = 16
          Top = 11
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1058#1086#1074#1072#1088' '#1074' '#1087#1091#1090#1080
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 102
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 572
    Top = 610
    Width = 107
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    ExplicitLeft = 572
    ExplicitTop = 610
    ExplicitWidth = 107
  end
  inherited btnCancel: TcxButton
    Left = 687
    Top = 610
    TabOrder = 3
    ExplicitLeft = 687
    ExplicitTop = 610
  end
  inherited btHelp: TcxButton
    Left = 6
    Top = 610
    TabOrder = 1
    ExplicitLeft = 6
    ExplicitTop = 610
  end
  object cxButton2: TcxButton [4]
    Left = 455
    Top = 610
    Width = 107
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100
    DropDownMenu = pmEtiket
    Kind = cxbkOfficeDropDown
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = True
    OptionsImage.Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69F93FFBD8A77FFBE8A77FFBD8A77FFBD8977FFBD89
      77FFBE8977FFC39F92FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C08D7BFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
      E8FFF5ECE7FFBF8D7AFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B58A
      7BFFA76D5AFF9F6654FFC2917EFFF7F0ECFFE2B47CFFE2B379FFE1B076FFE0AE
      71FFF6EEEAFFC2907EFF845444FF895746FF997569FFFF00FF00FF00FF00BB7D
      6AFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47BFFE0B1
      75FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67662FFFF00FF00FF00FF00BE85
      70FFF1E5DAFFECDBD0FF794734FF794734FF794734FF794734FF794734FF7947
      34FF794734FF794734FFEBDBCFFFF1E2D8FFB97B68FFFF00FF00FF00FF00C28B
      77FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
      DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826DFFFF00FF00FF00FF00C793
      7EFFFAF4F1FFCDBEB8FF6E5347FF604236FF603F34FF5E3E33FF5D3E32FF5C3C
      31FF5C3C33FF694B43FFCABCB6FFF9F5F1FFC18874FFFF00FF00FF00FF00CC99
      86FFFDFAFAFF7C5F53FF734F42FF734E42FF734D42FF724D42FF724D41FF714C
      41FF714B40FF714B3FFF72574CFFFDFAFAFFC58F7BFFFF00FF00FF00FF00CF9F
      8DFFFFFFFFFF79594BFF8E6859FFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
      DEFFF6EFEBFF866152FF6F4E42FFFFFFFFFFCA9683FFFF00FF00FF00FF00D4AB
      9AFFF5ECE8FF866555FF977161FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
      E1FFF8F2EEFF8E695AFF795A4BFFF5EAE6FFCFA392FFFF00FF00FF00FF00EEE3
      DFFFDAB6A8FF947161FFA07A69FFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
      E3FFF9F5F3FF977162FF876557FFD7B1A3FFEBDFDAFFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
      E7FFFBF7F6FFC59685FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
      EAFFFCFAF8FFC89A89FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
      FBFFFDFBFAFFCB9F8DFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00DAB9ADFFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
      91FFCDA391FFD6B6A9FFFF00FF00FF00FF00FF00FF00FF00FF00}
    TabOrder = 4
    OnClick = aPrintExecute
  end
  object cbFiscalMode: TcxCheckBox [5]
    Left = 93
    Top = 611
    Hint = 
      #1059#1073#1077#1088#1080#1090#1077' '#1075#1072#1083#1086#1095#1082#1091', '#1077#1089#1083#1080' '#1074#1086#1079#1074#1088#1072#1090' '#1080#1076#1077#1090' '#1074' '#1090#1077#1089#1090#1086#1074#1086#1084' '#1088#1077#1078#1080#1084#1077','#13#10#1087#1088#1080' '#1087#1086#1076#1082#1083 +
      #1102#1095#1077#1085#1085#1086#1084' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1084' '#1088#1077#1075#1080#1089#1090#1088#1072#1090#1086#1088#1077
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akBottom]
    Caption = ' '#1060#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1088#1077#1078#1080#1084
    ParentFont = False
    ParentShowHint = False
    Properties.MultiLine = True
    ShowHint = True
    State = cbsChecked
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.StyleController = dxEditStyleController
    Style.IsFontAssigned = True
    TabOrder = 5
    Width = 154
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 600
    Top = 312
  end
  inherited dxEditStyleController: TcxEditStyleController
    Left = 248
    Top = 608
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = MainDM.imMain
    Left = 280
    Top = 608
    object aIns: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
      OnExecute = aInsExecute
    end
    object aUpd: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnExecute = aUpdExecute
    end
    object aDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = aDelExecute
    end
    object aOplata: TAction
      Hint = #1057#1087#1080#1089#1086#1082' '#1087#1083#1072#1090#1077#1078#1077#1081
      ImageIndex = 164
      OnExecute = aOplataExecute
    end
    object aPrint: TAction
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
      ImageIndex = 146
      OnExecute = aPrintExecute
    end
    object aCustomizeColumns: TAction
      Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
      OnExecute = aCustomizeColumnsExecute
    end
    object aSaveAllToXLS: TAction
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1077
      OnExecute = aSaveAllToXLSExecute
    end
    object aSaveSelectedToXLS: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' &'#1074#1099#1076#1077#1083#1077#1085#1085#1086#1077
      OnExecute = aSaveSelectedToXLSExecute
    end
    object aPrintCur: TAction
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1090#1086#1074#1072#1088
      OnExecute = aPrintCurExecute
    end
    object aFindAndIns: TAction
      Caption = 'aFindAndIns'
      OnExecute = aFindAndInsExecute
    end
    object aNacenka: TAction
      Caption = #1053#1072#1094#1077#1085#1082#1072' '#1085#1072' '#1074#1089#1077
      OnExecute = aNacenkaExecute
    end
    object aRound: TAction
      Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1076#1086' '#1094#1077#1083#1099#1093
      OnExecute = aRoundExecute
    end
    object aRoundTen: TAction
      Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1076#1086' '#1076#1077#1089#1103#1090#1082#1086#1074
      OnExecute = aRoundTenExecute
    end
    object aRoundHundred: TAction
      Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1076#1086' '#1089#1086#1090#1077#1085
      OnExecute = aRoundHundredExecute
    end
    object aRoundThousand: TAction
      Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1076#1086' '#1090#1099#1089#1103#1095
      OnExecute = aRoundThousandExecute
    end
    object aRoundDrob: TAction
      Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1076#1086' '#1076#1077#1089#1103#1090#1099#1093
      OnExecute = aRoundDrobExecute
    end
    object aSearchClient: TAction
      Caption = #1055#1086#1080#1089#1082
      ImageIndex = 153
      Visible = False
      OnExecute = aSearchClientExecute
    end
    object aInsNewTovar: TAction
      Caption = #1053#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
      OnExecute = aInsNewTovarExecute
    end
  end
  inherited tranRead: TpFIBTransaction
    Left = 120
    Top = 608
  end
  inherited spGetData: TpFIBStoredProc
    Transaction = tranWrite
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_SKLAD (?SKLAD_, ?MODE_)')
    StoredProcName = 'GET_SKLAD'
    Left = 152
    Top = 608
  end
  inherited tranWrite: TpFIBTransaction
    Left = 184
    Top = 608
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INS_SKLAD (?G_TOCHKA_, ?DATE_RECEIPT_, ?TIME_R' +
        'ECEIPT_, ?G_CLIENT_, ?G_PAYMENT_TYPE_, ?OSNOVANIE_, ?NOTE_, ?IS_' +
        'VOZVRAT_, ?SUMM_, ?SUMM_FACT_, ?G_PRIHOD_, ?SUMM_PRIHOD_, ?PAYME' +
        'NTS_, ?SUMM_CURRENCY_, ?IS_EXPECTED_, ?UPLOAD_TO_EXT_APP_, ?USER' +
        '_ID_, ?LOG_BODY_, ?G_OFFICIAL_, ?REC_ID_, ?G_NONCASH_PAY_TYPE_, ' +
        '?ZAKAZ_)')
    StoredProcName = 'INS_SKLAD'
    Left = 216
    Top = 608
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UPD_SKLAD (?SKLAD_PARENT_, ?DATE_RECEIPT_, ?TI' +
        'ME_RECEIPT_, ?G_CLIENT_, ?G_PAYMENT_TYPE_, ?OSNOVANIE_, ?NOTE_, ' +
        '?SUMM_, ?SUMM_FACT_, ?G_PRIHOD_, ?SUMM_PRIHOD_, ?PAYMENTS_, ?SUM' +
        'M_CURRENCY_, ?IS_EXPECTED_, ?UPLOAD_TO_EXT_APP_, ?USER_ID_, ?LOG' +
        '_BODY_, ?G_NONCASH_PAY_TYPE_)')
    StoredProcName = 'UPD_SKLAD'
    Left = 248
    Top = 608
  end
  object spUpdLock: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE DO_UPDATE (?ID_, ?TABLE_NAME_, ?ERR_CODE, ?ERR' +
        '_MSG)')
    StoredProcName = 'DO_UPDATE'
    Left = 326
    Top = 606
  end
  object spUpdPrices: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE PROCEDURE_UPDATE1 (?ARR_)')
    StoredProcName = 'PROCEDURE_UPDATE1'
    Left = 366
    Top = 606
  end
  object spReadStatya: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from G_READ_G_PRIHOD_RASHOD_LIST(?ACTION_)')
    Filter = 'G_PRIHOD_RASHOD > 3'
    Transaction = tranRead
    Database = MainDM.dbMain
    Filtered = True
    Left = 520
    Top = 264
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadStatya: TDataSource
    DataSet = spReadStatya
    Left = 560
    Top = 264
  end
  object spDel: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE DEL_SKLAD_TMP (?SKLAD_, ?ALLOW_SELL_ABSENT_GOO' +
        'DS_)')
    StoredProcName = 'DEL_SKLAD_TMP'
    Left = 261
    Top = 272
  end
  object dsZakazTemp: TDataSource
    DataSet = spZakazTemp
    Left = 191
    Top = 272
  end
  object spZakazTemp: TpFIBDataSet
    UpdateSQL.Strings = (
      'EXECUTE PROCEDURE UPD_SKLAD_TMP1(:G_PRODUCT, '
      '                                 :OLD_G_PRODUCT,'
      '                                 :SKLAD,'
      
        '                                 (CASE WHEN :AMOUNT <= 0 THEN 1 ' +
        'ELSE CAST(:AMOUNT AS MY_NUMERIC_5) END),'
      
        '                                 (CASE WHEN :PRICE < 0 THEN 0 EL' +
        'SE CAST(:PRICE AS MY_NUMERIC_5) END),'
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
      '                                 :SUMM_CURRENCY,'
      '                                 :CHANGE_SALE_PRICE)')
    SelectSQL.Strings = (
      'SELECT * FROM READ_SKLAD_LIST_TMP')
    AfterPost = spZakazTempAfterPost
    Transaction = tranRead
    Database = MainDM.dbMain
    UpdateTransaction = tranWrite
    AutoCommit = True
    Left = 128
    Top = 272
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spPaymentType: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_PAYMENT_TYPE_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 304
    Top = 96
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsPaymentType: TDataSource
    DataSet = spPaymentType
    Left = 327
    Top = 96
  end
  object spPostavshik: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT * FROM G_READ_G_CLIENT_LIST(?G_CLIENT_PARENT_, ?IS_SUPPLI' +
        'ER_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 304
    Top = 64
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsPostavshik: TDataSource
    DataSet = spPostavshik
    Left = 327
    Top = 64
  end
  object spDoReturn: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INS_SKLAD_BASED_ON_ZAKAZ (?ZAKAZ_, ?SKLAD_PARE' +
        'NT_, ?ROZN_OR_COST_PRICE_)')
    StoredProcName = 'INS_SKLAD_BASED_ON_ZAKAZ'
    Left = 576
    Top = 121
  end
  object pmGrid: TPopupMenu
    Left = 16
    Top = 320
    object pmCustomizeColumns: TMenuItem
      Action = aCustomizeColumns
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = '*.xls'
    Filter = #1060#1072#1081#1083#1099' Microsoft Excel (*.xls)|*.xls|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = #1042#1099#1073#1086#1088' '#1080#1084#1077#1085#1080' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
    Left = 48
    Top = 320
  end
  object pmEtiket: TPopupMenu
    Left = 456
    Top = 488
    object N3: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099
      object N7: TMenuItem
        Caption = #1069#1090#1080#1082#1077#1090#1082#1080
        OnClick = N7Click
      end
      object N8: TMenuItem
        Tag = 4
        Caption = #1062#1077#1085#1085#1080#1082#1080
        OnClick = N7Click
      end
    end
    object N1: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1074#1089#1077' '#1090#1086#1074#1072#1088#1099' '#1087#1086' 1 '#1096#1090'.'
      object N9: TMenuItem
        Tag = 1
        Caption = #1069#1090#1080#1082#1077#1090#1082#1080
        OnClick = N7Click
      end
      object N10: TMenuItem
        Tag = 5
        Caption = #1062#1077#1085#1085#1080#1082#1080
        OnClick = N7Click
      end
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1090#1086#1074#1072#1088
      object N12: TMenuItem
        Tag = 2
        Caption = #1069#1090#1080#1082#1077#1090#1082#1080
        OnClick = N7Click
      end
      object N13: TMenuItem
        Tag = 6
        Caption = #1062#1077#1085#1085#1080#1082#1080
        OnClick = N7Click
      end
    end
    object N11: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1090#1086#1074#1072#1088' 1 '#1096#1090'.'
      object N14: TMenuItem
        Tag = 3
        Caption = #1069#1090#1080#1082#1077#1090#1082#1080
        OnClick = N7Click
      end
      object N15: TMenuItem
        Tag = 7
        Caption = #1062#1077#1085#1085#1080#1082#1080
        OnClick = N7Click
      end
    end
  end
  object spFindAndInsProduct: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INS_SKLAD_TMP_BY_BARCODE (?BARCODE_, ?G_TOCHKA' +
        '_, ?IS_VOZVRAT_)')
    StoredProcName = 'INS_SKLAD_TMP_BY_BARCODE'
    Left = 343
    Top = 185
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 384
    Top = 184
  end
  object spReadSklad: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_tochka')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 176
    Top = 144
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadSklad: TDataSource
    DataSet = spReadSklad
    Left = 199
    Top = 144
  end
  object pmNakrutka: TPopupMenu
    Left = 488
    Top = 489
    object mniNacenka: TMenuItem
      Action = aNacenka
    end
    object mniN4: TMenuItem
      Caption = '-'
    end
    object mniRoundDrob: TMenuItem
      Action = aRoundDrob
    end
    object N4: TMenuItem
      Action = aRound
    end
    object N5: TMenuItem
      Action = aRoundTen
    end
    object mniRoundHundred: TMenuItem
      Action = aRoundHundred
    end
    object mniRoundThousand: TMenuItem
      Action = aRoundThousand
    end
  end
  object spUpdateTmpAll: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UPD_SKLAD_TMP_ALL (?ROUND_MODE_, ?CHANGE_SALE_' +
        'PRICE_, ?CHARGE_ROZN_PROC_, ?MODE_)')
    StoredProcName = 'UPD_SKLAD_TMP_ALL'
    Left = 431
    Top = 217
  end
  object mdOldTovar: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 432
    Top = 332
  end
  object mdNewTovar: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 472
    Top = 332
  end
  object spFindProduct: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_GET_G_PRODUCT_BY_BARCODE (?BARCODE_, ?ARTICU' +
        'L_, ?NOMER_, ?NAME_, ?PREFIX_)')
    StoredProcName = 'G_GET_G_PRODUCT_BY_BARCODE'
    Left = 535
    Top = 122
  end
  object spInsByScaner: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INS_SKLAD_TMP (?G_PRODUCT_, ?AMOUNT_, ?PRICE_,' +
        ' ?SUMM_, ?NDS_, ?NDS_SUMM_, ?PRICE_CURRENCY_, ?SUMM_CURRENCY_, ?' +
        'CHARGE_ROZN_PROC_, ?PRICE_ROZN_, ?CHARGE_OPT_PROC_, ?PRICE_OPT_,' +
        ' ?CHANGE_SALE_PRICE_, ?MARK_CODE_)')
    StoredProcName = 'INS_SKLAD_TMP'
    Left = 312
    Top = 528
  end
  object spNonCashPayTypes: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from G_NONCASH_PAY_TYPE_READ')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 656
    Top = 104
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsNonCashPayTypes: TDataSource
    DataSet = spNonCashPayTypes
    Left = 688
    Top = 104
  end
  object SQLTransaction: TpFIBDataSet
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
      '                                 :SUMM_CURRENCY,'
      '                                 :CHANGE_SALE_PRICE)')
    SelectSQL.Strings = (
      'SELECT ID_TRANSACTION FROM TRANSACTION_ZAKAZ'
      'WHERE ZAKAZ=:ZAKAZ AND TERMINAL=:TERMINAL')
    Transaction = tranRead
    Database = MainDM.dbMain
    UpdateTransaction = tranWrite
    AutoCommit = True
    Left = 232
    Top = 364
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
