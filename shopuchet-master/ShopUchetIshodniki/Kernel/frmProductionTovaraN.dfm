inherited ProductionTovaraNForm: TProductionTovaraNForm
  Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 538
  ClientWidth = 552
  ExplicitWidth = 558
  ExplicitHeight = 564
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Left = 7
    Width = 537
    Height = 493
    ExplicitLeft = 7
    ExplicitWidth = 537
    ExplicitHeight = 493
    object ShapeNote: TShape
      Left = 7
      Top = 31
      Width = 131
      Height = 42
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
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label7: TLabel
      Left = 16
      Top = 12
      Width = 107
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1072#1090#1072' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbContent: TLabel
      Left = 9
      Top = 279
      Width = 265
      Height = 18
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akBottom]
      Caption = #1057#1086#1089#1090#1072#1074#1083#1103#1102#1097#1080#1077' '#1076#1083#1103' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 326
    end
    object lbNote: TLabel
      Left = 16
      Top = 45
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
      Width = 391
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
      ExplicitWidth = 299
    end
    object ShapeNote1: TShape
      Left = 137
      Top = 32
      Width = 391
      Height = 41
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
      ExplicitWidth = 299
    end
    object edDate: TcxDateEdit
      Left = 142
      Top = 10
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      Properties.InputKind = ikMask
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      Style.ButtonStyle = btsFlat
      TabOrder = 0
      Width = 382
    end
    object Panel2: TPanel
      Left = 2
      Top = 305
      Width = 533
      Height = 186
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 2
      object gr1: TcxGrid
        Left = 0
        Top = 0
        Width = 533
        Height = 186
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object tvMain: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsReadSost
          DataController.KeyFieldNames = 'G_PRODUCT_ITEM'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'AMOUNT'
            end
            item
              Kind = skSum
              FieldName = 'SUMM'
            end
            item
              Kind = skSum
              FieldName = 'NDS_SUMM'
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.Inactive = MainDM.stGridSelectedRow
          object clmMainG_PRODUCT_ITEM: TcxGridDBColumn
            DataBinding.FieldName = 'G_PRODUCT_ITEM'
            Visible = False
            Width = 200
          end
          object clmMainNAME: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'NAME'
            HeaderAlignmentHorz = taCenter
            Width = 224
          end
          object clmMainAMOUNT: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'AMOUNT'
            RepositoryItem = riEditRepositoryCurrencyItem
            HeaderAlignmentHorz = taCenter
            Width = 115
          end
          object clmMainOSTATOK: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1085#1072' '#1089#1082#1083#1072#1076#1077
            DataBinding.FieldName = 'OSTATOK'
            RepositoryItem = riEditRepositoryCurrencyItem
            HeaderAlignmentHorz = taCenter
            Width = 102
          end
          object clmMainOSTATOK_AFTER: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1087#1086#1089#1083#1077
            DataBinding.FieldName = 'OSTATOK_AFTER'
            RepositoryItem = riEditRepositoryCurrencyItem
            HeaderAlignmentHorz = taCenter
            Width = 84
          end
        end
        object lvMain: TcxGridLevel
          GridView = tvMain
        end
      end
    end
    object mNote: TcxMemo
      Left = 142
      Top = 36
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Height = 33
      Width = 382
    end
    object Panel5: TPanel
      Left = 2
      Top = 85
      Width = 535
      Height = 187
      TabOrder = 3
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 533
        Height = 32
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          533
          32)
        object BitBtn12: TBitBtn
          Left = 6
          Top = 5
          Width = 119
          Height = 23
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aIns
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object pnRowCnt: TPanel
          Left = 571
          Top = 3
          Width = 49
          Height = 23
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akTop, akRight]
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = '0'
          TabOrder = 2
        end
        object btnDel: TBitBtn
          Left = 124
          Top = 5
          Width = 96
          Height = 23
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object cxGrid1: TcxGrid
        Left = 1
        Top = 33
        Width = 533
        Height = 153
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsZakazTemp
          DataController.KeyFieldNames = 'ZAKAZ_DETAILS'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'AMOUNT'
              Column = cxGridDBColumn1
            end
            item
              Kind = skSum
              FieldName = 'SUMM'
            end
            item
              Kind = skSum
              FieldName = 'NDS_SUMM'
            end
            item
              Kind = skSum
              Column = clmGridDBSebes
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsSelection.CellSelect = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Styles.Inactive = MainDM.stGridSelectedRow
          object clmMainPRODUCT_NAME: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'PRODUCT_NAME'
            HeaderAlignmentHorz = taCenter
            Width = 252
          end
          object clmMainARTICUL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1091#1083
            DataBinding.FieldName = 'ARTICUL'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'AMOUNT'
            RepositoryItem = riEditRepositoryCalcItem
            HeaderAlignmentHorz = taCenter
            Width = 82
          end
          object clmMainBARCODE: TcxGridDBColumn
            Caption = #1064#1090#1088#1080#1093#1082#1086#1076
            DataBinding.FieldName = 'BARCODE'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object clmGridDBSebes: TcxGridDBColumn
            Caption = #1057#1077#1073#1077#1089#1090'-'#1090#1100
            DataBinding.FieldName = 'COST_PRICE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            Width = 84
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 388
    Top = 503
    ExplicitLeft = 388
    ExplicitTop = 503
  end
  inherited btnCancel: TcxButton
    Left = 469
    Top = 503
    ExplicitLeft = 469
    ExplicitTop = 503
  end
  inherited btHelp: TcxButton
    Top = 503
    ExplicitTop = 503
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 280
    Top = 536
  end
  inherited dxEditStyleController: TcxEditStyleController
    Left = 64
    Top = 560
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Left = 152
    Top = 528
    object aIns: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = aInsExecute
    end
    object aDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = aDelExecute
    end
    object aUpd: TAction
      Caption = 'aUpd'
    end
  end
  inherited tranRead: TpFIBTransaction
    Top = 528
  end
  inherited spGetData: TpFIBStoredProc
    Top = 528
  end
  inherited tranWrite: TpFIBTransaction
    Top = 528
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE DO_PRODUCT (?G_TOCHKA_, ?DATE_, ?G_PRODUCT_IN_' +
        ', ?AMOUNT_IN_, ?NOTE_, ?USER_ID_, ?LOG_BODY_, ?UPLOAD_TO_EXT_APP' +
        '_)')
    StoredProcName = 'DO_PRODUCT'
    Top = 528
  end
  inherited spUpd: TpFIBStoredProc
    Top = 528
  end
  object spReadSost: TpFIBDataSet
    SelectSQL.Strings = (
      'select k.g_product_item,'
      '      g.name,'
      '      k.amount * tmp.amount as amount,'
      '      COALESCE(lt.AMOUNT, 0) as ostatok,'
      
        '      COALESCE(lt.AMOUNT, 0) - k.amount * tmp.amount as ostatok_' +
        'after'
      '  from g_product_kit k'
      
        '       ,g_product g left outer join lt_sklad_product lt on g.G_P' +
        'RODUCT = lt.G_PRODUCT and lt.G_TOCHKA = :g_tochka_'
      '       ,zakaz_details_tmp tmp'
      ' where k.g_product = tmp.g_product'
      '   and k.g_product_item = g.g_product'
      'order by g.name')
    OnCalcFields = spReadSostCalcFields
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 80
    Top = 416
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spUpdLock: TpFIBStoredProc
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE DO_UPDATE (?ID_, ?TABLE_NAME_, ?ERR_CODE, ?ERR' +
        '_MSG)')
    StoredProcName = 'DO_UPDATE'
    Left = 328
    Top = 540
  end
  object dsReadSost: TDataSource
    DataSet = spReadSost
    Left = 125
    Top = 416
  end
  object spZakazTemp: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_ZAKAZ_DETAILS_LIST_TMP')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 74
    Top = 201
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsZakazTemp: TDataSource
    DataSet = spZakazTemp
    Left = 113
    Top = 196
  end
  object spInsTmp: TpFIBDataSet
    SelectSQL.Strings = (
      
        'INSERT INTO ZAKAZ_DETAILS_TMP (ZAKAZ_DETAILS, G_PRODUCT, AMOUNT,' +
        'COST_PRICE)'
      
        'VALUES ( GEN_ID(GEN_DETAILS_TMP, 1), :G_PRODUCT, :AMOUNT, (SELEC' +
        'T * FROM GET_PRODUCTION_SELF_PRICE(:G_PRODUCT, :G_TOCHKA)))')
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 178
    Top = 201
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spDel: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE DEL_DETAILS_TMP (?ZAKAZ_DETAILS_)')
    StoredProcName = 'DEL_DETAILS_TMP'
    Left = 263
    Top = 356
  end
end
