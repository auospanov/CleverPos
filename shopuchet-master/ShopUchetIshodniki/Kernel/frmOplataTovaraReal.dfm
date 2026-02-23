inherited OplataTovaraRealForm: TOplataTovaraRealForm
  Left = 583
  Top = 86
  Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 519
  ClientWidth = 655
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 661
  ExplicitHeight = 545
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 642
    Height = 476
    ExplicitWidth = 642
    ExplicitHeight = 476
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 638
      Height = 308
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 636
        Height = 40
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label10: TLabel
          Left = 8
          Top = 9
          Width = 91
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edBarcode: TEdit
          Left = 104
          Top = 7
          Width = 217
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          CharCase = ecLowerCase
          MaxLength = 13
          TabOrder = 0
          OnChange = edBarcodeChange
          OnKeyDown = edBarcodeKeyDown
        end
        object sbClear: TcxButton
          Left = 326
          Top = 6
          Width = 26
          Height = 23
          Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1080#1089#1082
          LookAndFeel.Kind = lfFlat
          LookAndFeel.NativeStyle = True
          OptionsImage.Glyph.Data = {
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
          OptionsImage.ImageIndex = 150
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btClearClick
        end
      end
      object splMenu: TcxSplitter
        Left = 195
        Top = 41
        Width = 8
        Height = 266
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
        Control = lstCategory
        Color = clBtnFace
        ParentColor = False
      end
      object lstCategory: TcxDBTreeList
        Left = 1
        Top = 41
        Width = 194
        Height = 266
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Bands = <
          item
          end>
        DataController.DataSource = dsReadCategory
        DataController.ParentField = 'G_PRODUCT_PAR'
        DataController.KeyField = 'G_PRODUCT'
        LookAndFeel.Kind = lfFlat
        Navigator.Buttons.CustomButtons = <>
        OptionsSelection.CellSelect = False
        RootValue = -1
        Styles.Inactive = MainDM.stGridSelectedRow
        TabOrder = 1
        OnFocusedNodeChanged = lstCategoryFocusedNodeChanged
        object clmnCategoryNAME: TcxDBTreeListColumn
          Caption.Text = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1090#1086#1074#1072#1088#1072
          DataBinding.FieldName = 'NAME'
          Width = 200
          Position.ColIndex = 0
          Position.RowIndex = 0
          Position.BandIndex = 0
          Summary.FooterSummaryItems = <>
          Summary.GroupFooterSummaryItems = <>
        end
      end
      object grProduct: TcxGrid
        Left = 203
        Top = 41
        Width = 434
        Height = 266
        Align = alClient
        TabOrder = 3
        LookAndFeel.Kind = lfFlat
        object tvProduct: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = tvProductCellDblClick
          OnFocusedRecordChanged = tvProductFocusedRecordChanged
          DataController.DataSource = dsReadProd
          DataController.KeyFieldNames = 'ZAKAZ_NA_REAL'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsSelection.CellSelect = False
          OptionsView.HeaderAutoHeight = True
          Styles.Inactive = MainDM.stGridSelectedRow
          object tvProductOSNOVANIE: TcxGridDBColumn
            Caption = #1053#1086#1084#1077#1088' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
            DataBinding.FieldName = 'OSNOVANIE'
            Visible = False
            GroupIndex = 0
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object tvProductNAME: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'NAME'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object tvProductARTICUL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1091#1083
            DataBinding.FieldName = 'ARTICUL'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object tvProductNOMENCLATUR_NUM: TcxGridDBColumn
            Caption = #1053#1086#1084#1077#1085#1082#1083'. '#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'NOMENCLATUR_NUM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object tvProductBARCODE: TcxGridDBColumn
            Caption = #1064#1090#1088#1080#1093#1082#1086#1076
            DataBinding.FieldName = 'BARCODE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
        end
        object lv1: TcxGridLevel
          GridView = tvProduct
        end
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 310
      Width = 638
      Height = 164
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Shape19: TShape
        Left = 7
        Top = 133
        Width = 146
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
        Visible = False
      end
      object Shape14: TShape
        Left = 7
        Top = 83
        Width = 50
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
        Visible = False
      end
      object Shape4: TShape
        Left = 384
        Top = 9
        Width = 149
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Shape7: TShape
        Left = 7
        Top = 108
        Width = 146
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Shape5: TShape
        Left = 7
        Top = 58
        Width = 146
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Shape1: TShape
        Left = 7
        Top = 9
        Width = 146
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Label1: TLabel
        Left = 17
        Top = 15
        Width = 67
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Shape3: TShape
        Left = 152
        Top = 9
        Width = 218
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object Label3: TLabel
        Left = 17
        Top = 64
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
      end
      object Shape6: TShape
        Left = 152
        Top = 58
        Width = 218
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object Label4: TLabel
        Left = 17
        Top = 114
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
      object Shape8: TShape
        Left = 152
        Top = 108
        Width = 218
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object Label2: TLabel
        Left = 390
        Top = 14
        Width = 128
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1054#1089#1090#1072#1090#1086#1082' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Shape12: TShape
        Left = 532
        Top = 9
        Width = 101
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object Label8: TLabel
        Left = 14
        Top = 89
        Width = 39
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1082#1080#1076#1082#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object Shape16: TShape
        Left = 152
        Top = 83
        Width = 218
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
        Visible = False
      end
      object Label11: TLabel
        Left = 17
        Top = 139
        Width = 78
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object Shape20: TShape
        Left = 152
        Top = 133
        Width = 218
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
        Visible = False
      end
      object GroupBox1: TGroupBox
        Left = 385
        Top = 52
        Width = 249
        Height = 80
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1042' '#1090#1086#1084' '#1095#1080#1089#1083#1077' '#1053#1044#1057
        TabOrder = 4
        object Shape10: TShape
          Left = 8
          Top = 44
          Width = 96
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape9: TShape
          Left = 8
          Top = 19
          Width = 97
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label5: TLabel
          Left = 18
          Top = 25
          Width = 59
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1090#1072#1074#1082#1072'(%)'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape15: TShape
          Left = 103
          Top = 19
          Width = 138
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Label6: TLabel
          Left = 18
          Top = 49
          Width = 64
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1091#1084#1084#1072' ('#1090#1075'.)'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape11: TShape
          Left = 103
          Top = 44
          Width = 138
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object edNDS: TcxCurrencyEdit
          Left = 107
          Top = 22
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
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 129
        end
        object edNDSSumm: TcxCurrencyEdit
          Left = 107
          Top = 47
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
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 1
          Width = 129
        end
      end
      object rbRoznica: TRadioButton
        Left = 8
        Top = 39
        Width = 97
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1056#1086#1079#1085#1080#1095#1085#1072#1103
        Checked = True
        TabOrder = 2
        TabStop = True
        Visible = False
        OnClick = rbRoznicaClick
      end
      object rbOpt: TRadioButton
        Left = 96
        Top = 39
        Width = 73
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1054#1087#1090#1086#1074#1072#1103
        TabOrder = 3
        Visible = False
        OnClick = rbOptClick
      end
      object Panel5: TPanel
        Left = 57
        Top = 84
        Width = 95
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        BevelOuter = bvNone
        TabOrder = 6
        object rbSkidkaInProcent: TRadioButton
          Left = 7
          Top = 5
          Width = 36
          Height = 17
          Hint = #1089#1082#1080#1076#1082#1072' '#1074' '#1087#1088#1086#1094#1077#1085#1090#1072#1093
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '%'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TabStop = True
          Visible = False
          OnClick = rbSkidkaInProcentClick
        end
        object rbSkidkaInTenge: TRadioButton
          Left = 49
          Top = 5
          Width = 37
          Height = 17
          Hint = #1089#1082#1080#1076#1082#1072' '#1074' '#1074#1072#1083#1102#1090#1077
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1074#1072#1083
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Visible = False
          OnClick = rbSkidkaInTengeClick
        end
      end
      inline MyCurrencyFrameForm: TMyCurrencyFrameForm
        Left = 158
        Top = 12
        Width = 206
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Color = clWhite
        ParentColor = False
        TabOrder = 0
        ExplicitLeft = 158
        ExplicitTop = 12
        ExplicitWidth = 206
        ExplicitHeight = 22
        inherited edAmount: TEdit
          Width = 185
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Text = '1.00'
          OnChange = MyCurrencyFrameFormedAmountChange
          ExplicitWidth = 185
          ExplicitHeight = 22
        end
        inherited sbCur: TSpinButton
          Left = 185
          Top = 1
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ExplicitLeft = 185
          ExplicitTop = 1
        end
      end
      object seOstatok: TcxCurrencyEdit
        Left = 537
        Top = 11
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        RepositoryItem = riEditRepositoryCurrencyItem
        EditValue = 0c
        Enabled = False
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 91
      end
      object edPrice: TcxCurrencyEdit
        Left = 156
        Top = 61
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
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 5
        Width = 210
      end
      object seSkidka: TcxCurrencyEdit
        Left = 156
        Top = 86
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
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 7
        Visible = False
        Width = 210
      end
      object edSumm: TcxCurrencyEdit
        Left = 156
        Top = 111
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
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 8
        Width = 210
      end
      object seSkidkaSumm: TcxCurrencyEdit
        Left = 156
        Top = 136
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
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 9
        Visible = False
        Width = 210
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 387
    Top = 486
    Width = 167
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1085#1072#1082#1083#1072#1076#1085#1091#1102
    ExplicitLeft = 387
    ExplicitTop = 486
    ExplicitWidth = 167
  end
  inherited btnCancel: TcxButton
    Left = 568
    Top = 486
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ExplicitLeft = 568
    ExplicitTop = 486
  end
  inherited btHelp: TcxButton
    Top = 486
    ExplicitTop = 486
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Left = 176
    Top = 664
    object aChooseTovar: TAction
      Caption = #1042#1099#1073#1088#1072#1090#1100' (F8)'
      ShortCut = 119
    end
    object aRefreshChd: TAction
      Caption = 'aRefreshChd'
      OnExecute = aRefreshChdExecute
    end
  end
  inherited tranRead: TpFIBTransaction
    Left = 104
    Top = 515
  end
  inherited spGetData: TpFIBStoredProc
    Left = 8
    Top = 515
  end
  inherited tranWrite: TpFIBTransaction
    Left = 136
    Top = 515
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INS_ZAKAZ_DETAILS_TMP_REAL (?G_PRODUCT_, ?AMOU' +
        'NT_, ?PRICE_, ?SUMM_, ?DISCOUNT_PERC_, ?DISCOUNT_TENGE_, ?DISCOU' +
        'NT_SUMM_, ?NDS_, ?NDS_SUMM_, ?COST_PRICE_, ?ZAKAZ_NA_REAL_)')
    StoredProcName = 'INS_ZAKAZ_DETAILS_TMP_REAL'
    Left = 40
    Top = 515
  end
  inherited spUpd: TpFIBStoredProc
    Left = 72
    Top = 515
  end
  object dsReadProd: TDataSource
    DataSet = spReadProd
    Left = 320
    Top = 152
  end
  object dsReadCategory: TDataSource
    DataSet = spReadCategory
    Left = 56
    Top = 104
  end
  object spReadCategory: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_PRODCAT_FOR_REAL_LIST(?G_CLIENT_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 24
    Top = 104
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spReadProd: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      '        T.G_PRODUCT,'
      '        T.G_PRODUCT_PAR,'
      '        T.ARTICUL,'
      '        T.NOMENCLATUR_NUM,'
      '        T.BARCODE,'
      '        T.NAME,'
      
        '        Z.PRICE, -- + Z.DISCOUNT_TENGE,  -- '#1061#1047' '#1047#1040#1063#1045#1052' '#1058#1040#1050' '#1057#1044#1045#1051#1040#1051',' +
        ' 23.05.2016'
      '        T.VOLUME_PRICE,'
      '        T.IS_CATEGORY,'
      '        T.IS_ACTIVE,'
      '        T.PLACE, '
      
        '        (Z.AMOUNT_ALL - COALESCE(Z.AMOUNT_PAYED, 0) - COALESCE(Z' +
        '.AMOUNT_RETURNED, 0)) AMOUNT,'
      '        Z.DISCOUNT_PERC SKIDKA_PROC,'
      '        Z.DISCOUNT_TENGE SKIDKA_SUM,'
      '        Z.ZAKAZ_NA_REAL,'
      '        ZP.OSNOVANIE'
      '    FROM G_PRODUCT T,'
      '         ZAKAZ_REAL_PARENT ZP,'
      '         ZAKAZ_NA_REAL Z'
      
        '    WHERE T.G_PRODUCT_PAR = DECODE(:G_PRODUCT_PAR_, -1, T.G_PROD' +
        'UCT_PAR, :G_PRODUCT_PAR_)'
      '    AND T.IS_CATEGORY = 0'
      '    AND T.G_PRODUCT = Z.G_PRODUCT'
      '    AND Z.IS_PAYED_ALL = 0   -- '#1058#1054#1051#1068#1050#1054' '#1053#1045#1054#1055#1051#1040#1063#1045#1053#1053#1067#1045
      '    AND Z.ZAKAZ_REAL_PARENT = ZP.ZAKAZ_REAL_PARENT'
      '    AND ZP.G_CLIENT = :G_CLIENT_'
      '    AND ZP.G_TOCHKA = :G_tochka_'
      '    ORDER BY T.NAME'
      ' '
      ' '
      ' ')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 288
    Top = 152
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spFindProduct: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_GET_G_PRODUCT_BY_BARCODE (?BARCODE_, ?ARTICU' +
        'L_, ?NOMER_, ?NAME_, ?PREFIX_)')
    StoredProcName = 'G_GET_G_PRODUCT_BY_BARCODE'
    Left = 432
    Top = 16
  end
  object TimerSearch: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerSearchTimer
    Left = 208
    Top = 248
  end
  object GetLastPrice: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE GET_LAST_SELF_PRICE (?G_PRODUCT_, ?G_TOCHKA_, ' +
        '?MODE_)')
    StoredProcName = 'GET_LAST_SELF_PRICE'
    Left = 296
    Top = 443
  end
end
