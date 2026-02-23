inherited ProdazhaTovaraForm: TProdazhaTovaraForm
  Left = 621
  Top = 107
  Anchors = [akLeft, akTop, akRight]
  BorderStyle = bsSizeable
  BorderWidth = 1
  Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 478
  ClientWidth = 611
  Constraints.MinHeight = 505
  Constraints.MinWidth = 611
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 621
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 598
    Height = 434
    ExplicitWidth = 598
    ExplicitHeight = 434
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 594
      Height = 265
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Caption = 'Panel3'
      TabOrder = 0
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 592
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
          Top = 8
          Width = 217
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          MaxLength = 250
          TabOrder = 0
          OnChange = edBarcodeChange
          OnKeyDown = edBarcodeKeyDown
        end
        object sbClear: TcxButton
          Left = 327
          Top = 8
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
          OnClick = sbClearClick
        end
      end
      object splMenu: TcxSplitter
        Left = 195
        Top = 41
        Width = 8
        Height = 223
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
        Control = tlCategory
        Color = clBtnFace
        ParentColor = False
      end
      object grProduct: TcxGrid
        Left = 203
        Top = 41
        Width = 390
        Height = 223
        Align = alClient
        TabOrder = 3
        LookAndFeel.Kind = lfFlat
        object tvProduct: TcxGridDBTableView
          PopupMenu = pmGrid
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = tvProductCellDblClick
          OnFocusedRecordChanged = tvProductFocusedRecordChanged
          DataController.DataSource = dsRead
          DataController.KeyFieldNames = 'G_PRODUCT'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.Inactive = MainDM.stGridSelectedRow
          object clmtv1NAME: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'NAME'
            HeaderAlignmentHorz = taCenter
            Width = 243
          end
          object clmtv1ARTICUL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1091#1083
            DataBinding.FieldName = 'ARTICUL'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmtv1BARCODE: TcxGridDBColumn
            Caption = #1064#1090#1088#1080#1093#1082#1086#1076
            DataBinding.FieldName = 'BARCODE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmProductBARCODE_DOP: TcxGridDBColumn
            Caption = #1044#1086#1087'. '#1096#1090#1088#1080#1093#1082#1086#1076
            DataBinding.FieldName = 'BARCODE_DOP'
            HeaderAlignmentHorz = taCenter
            Width = 97
          end
          object clmtv1NOMENCLATUR_NUM: TcxGridDBColumn
            Caption = #1053'/'#1085#1086#1084#1077#1088
            DataBinding.FieldName = 'NOMENCLATUR_NUM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmtv1PRICE: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmtv1VOLUME_PRICE: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1086#1087#1090
            DataBinding.FieldName = 'VOLUME_PRICE'
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmtv1NOTE: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'NOTE'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object clmtv1PLACE: TcxGridDBColumn
            Caption = #1052#1077#1089#1090#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
            DataBinding.FieldName = 'PLACE'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 150
          end
          object tvProductUNIT_NAME: TcxGridDBColumn
            Caption = #1045#1076'. '#1080#1079#1084'.'
            DataBinding.FieldName = 'UNIT_NAME'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object clmProductAMOUNT: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082
            DataBinding.FieldName = 'AMOUNT'
            RepositoryItem = riEditRepositoryCalcItem
            HeaderAlignmentHorz = taCenter
            Width = 81
          end
        end
        object lv1: TcxGridLevel
          GridView = tvProduct
        end
      end
      object tlCategory: TcxDBTreeList
        Left = 1
        Top = 41
        Width = 194
        Height = 223
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
        OnFocusedNodeChanged = tlCategoryFocusedNodeChanged
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
    end
    object Panel2: TPanel
      Left = 2
      Top = 267
      Width = 594
      Height = 165
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        594
        165)
      object shpCostPrice: TShape
        Left = 359
        Top = 34
        Width = 109
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
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
      end
      object Shape4: TShape
        Left = 359
        Top = 9
        Width = 109
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
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
        Width = 186
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
        Width = 186
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
        Width = 186
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object Label2: TLabel
        Left = 366
        Top = 14
        Width = 46
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Caption = #1054#1089#1090#1072#1090#1086#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Shape12: TShape
        Left = 467
        Top = 9
        Width = 123
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
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
      end
      object Shape16: TShape
        Left = 152
        Top = 83
        Width = 186
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
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
      end
      object Shape20: TShape
        Left = 152
        Top = 133
        Width = 186
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object lbCostPrice: TLabel
        Left = 366
        Top = 39
        Width = 75
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shpCostPrice1: TShape
        Left = 467
        Top = 34
        Width = 123
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object grpNDS: TGroupBox
        Left = 360
        Top = 80
        Width = 230
        Height = 80
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Caption = #1042' '#1090#1086#1084' '#1095#1080#1089#1083#1077' '#1053#1044#1057
        TabOrder = 5
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
          Width = 121
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
        object Shape11: TShape
          Left = 103
          Top = 44
          Width = 121
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
          Properties.OnChange = edNDSPropertiesChange
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 114
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
          StyleDisabled.TextColor = cl3DDkShadow
          TabOrder = 1
          Width = 114
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
        TabOrder = 3
        TabStop = True
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
        TabOrder = 4
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
        TabOrder = 8
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
          OnClick = rbSkidkaInTengeClick
        end
      end
      inline MyCurrencyFrameForm: TMyCurrencyFrameForm
        Left = 158
        Top = 11
        Width = 173
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Color = clWindow
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitLeft = 158
        ExplicitTop = 11
        ExplicitWidth = 173
        ExplicitHeight = 22
        inherited edAmount: TEdit
          Left = 0
          Width = 149
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BevelInner = bvNone
          BevelOuter = bvNone
          OnChange = MyCurrencyFrameFormedAmountChange
          ExplicitLeft = 0
          ExplicitWidth = 149
          ExplicitHeight = 22
        end
        inherited sbCur: TSpinButton
          Left = 152
          Top = 1
          Width = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ExplicitLeft = 152
          ExplicitTop = 1
          ExplicitWidth = 20
        end
      end
      object btnChooseTovar: TcxButton
        Left = 119
        Top = 10
        Width = 33
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Action = aBreakTovar
        LookAndFeel.Kind = lfStandard
        OptionsImage.Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A8866300AD71
          3500AD713500AD713500AD713500FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00AD713500AD713500AD713500AD713500A8866300FF00FF00B0743700FFC2
          2F00E8A01100FFC02900C0802A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C0802A00FFB91500E8A01100FFB91400B0743700FF00FF00B4783A00E9A4
          1800FFB70F00C8892F00CDA67F00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00CDA67F00C8892F00FFB70F00E9A41800B4783A00FF00FF00B97D3D00FFCD
          4F00C88A3100FFBA1900C7883400D9B89500FF00FF00FF00FF00FF00FF00D9B8
          9500C7883400FFBA1900C88A3100FFC12E00B97D3D00FF00FF00BD814100CB8D
          3A00D4AD8300CB8D3A00FFC73E00CA904500DBBA9700FF00FF00DBBA9700CA90
          4200FFC43600CB8D3A00D4AD8300CB8D3A00BD814100FF00FF00FF00FF00FF00
          FF00FF00FF00DEBD9900CF964A00FFD36400C3874500FF00FF00C3874500FFD0
          5900CF954600DEBD9900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00E0BF9B00C88C4900FF00FF00FF00FF00FF00FF00C88C
          4900E0BF9B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00E5C49A00CF934700FF00FF00FF00FF00FF00FF00CF93
          4700E5C49A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00E8C79D00DCA65800FFE28F00D99D5600FF00FF00D99D5600FFE1
          8B00DCA65700E8C79D00FF00FF00FF00FF00FF00FF00FF00FF00D99D5100E1AA
          5900E7C08E00E1AA5900FFE08800E5AF6500EDCCA400FF00FF00EDCCA400E5AF
          6400FFDF8500E1AA5900E7C08E00E1AA5900D99D5100FF00FF00E1A55900FFE5
          9900D19C5100FFDF8600E9B26400EFCEA600FF00FF00FF00FF00FF00FF00EFCE
          A600E9B26400FFDF8600D19C5100FFE39400E1A55900FF00FF00E7AB5F00F8D1
          8100FFE29000D19C5300EFC89800FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00EFC89800D19C5300FFE29000F8D18100E7AB5F00FF00FF00ECB06400FFE5
          9900F9D48700FFE59900EFBA6D00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00EFBA6D00FFE59900F9D48700FFE59900ECB06400FF00FF00F2C58C00EDB1
          6600EDB16600EDB16600EDB16600FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00EDB16600EDB16600EDB16600EDB16600F2C58C00FF00FF00}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
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
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 9
        Width = 178
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
        Properties.MaxLength = 15
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
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 6
        Width = 178
      end
      object seSkidka: TcxCurrencyEdit
        Left = 156
        Top = 86
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        EditValue = 0c
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Properties.MaxLength = 15
        Properties.UseDisplayFormatWhenEditing = True
        Properties.UseLeftAlignmentOnEditing = False
        Properties.UseThousandSeparator = True
        Properties.ValidateOnEnter = False
        Properties.OnChange = seSkidkaPropertiesChange
        Properties.OnValidate = seSkidkaPropertiesValidate
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 7
        Width = 178
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
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 10
        Width = 178
      end
      object seOstatok: TcxCurrencyEdit
        Left = 474
        Top = 12
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        RepositoryItem = riEditRepositoryCurrencyItem
        Anchors = [akTop, akRight]
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
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 2
        Width = 112
      end
      object edCostPrice: TcxCurrencyEdit
        Left = 474
        Top = 37
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
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
        StyleDisabled.TextColor = cl3DDkShadow
        TabOrder = 11
        Width = 112
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 439
    Top = 449
    Width = 86
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    ExplicitLeft = 439
    ExplicitTop = 449
    ExplicitWidth = 86
  end
  inherited btnCancel: TcxButton
    Left = 530
    Top = 449
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    ExplicitLeft = 530
    ExplicitTop = 449
  end
  object cbClose: TcxCheckBox [3]
    Left = 4
    Top = 449
    Hint = 
      #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1075#1072#1083#1086#1095#1082#1091', '#1077#1089#1083#1080' '#1093#1086#1090#1080#1090#1077' '#1080#1079#1084#1077#1085#1080#1090#1100' '#1086#1087#1090#1086#1074#1091#1102' '#1094#1077#1085#1091#13#10#1090#1086#1074#1072#1088#1072' '#1074' '#1072 +
      #1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1084' '#1088#1077#1078#1080#1084#1077'. '#1062#1077#1085#1072' '#1080#1079#1084#1077#1085#1080#1090#1089#1103' '#1090#1086#1074#1072#1088#1072#13#10#1080#1079#1084#1077#1085#1080#1090#1089#1103' '#1087#1088#1080' '#1089#1086#1093#1088#1072 +
      #1085#1077#1085#1080#1080' '#1085#1072#1082#1083#1072#1076#1085#1086#1081'.'
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akBottom]
    Caption = #1047#1072#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086' '#1087#1086#1089#1083#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1090#1086#1074#1072#1088#1072' '#1074' '#1085#1072#1082#1083#1072#1076#1085#1091#1102
    Style.StyleController = dxEditStyleController
    TabOrder = 1
    Width = 341
  end
  inherited btHelp: TcxButton
    Left = 356
    Top = 449
    Anchors = [akRight, akBottom]
    TabOrder = 4
    ExplicitLeft = 356
    ExplicitTop = 449
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = MainDM.imMain
    Left = 176
    Top = 664
    object aChooseTovar: TAction
      Caption = #1042#1099#1073#1088#1072#1090#1100' (F8)'
      ShortCut = 119
      OnExecute = aChooseTovarExecute
    end
    object aRefreshChd: TAction
      Caption = 'aRefreshChd'
      OnExecute = aRefreshChdExecute
    end
    object aBreakTovar: TAction
      Hint = #1053#1072#1078#1084#1080#1090#1077', '#1095#1090#1086#1073#1099' '#1087#1088#1086#1076#1072#1090#1100' '#1090#1086#1074#1072#1088' '#1085#1077' '#1091#1087#1072#1082#1086#1074#1082#1086#1081', '#1072' '#1087#1086#1096#1090#1091#1095#1085#1086
      ImageIndex = 165
      OnExecute = aBreakTovarExecute
    end
    object aCustomizeColumns: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1086#1083#1073#1094#1086#1074
      OnExecute = aCustomizeColumnsExecute
    end
  end
  inherited tranRead: TpFIBTransaction
    Left = 184
    Top = 579
  end
  inherited spGetData: TpFIBStoredProc
    Left = 88
    Top = 579
  end
  inherited tranWrite: TpFIBTransaction
    Left = 216
    Top = 579
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INS_ZAKAZ_DETAILS_TMP (?G_PRODUCT_, ?AMOUNT_, ' +
        '?PRICE_, ?SUMM_, ?DISCOUNT_PERC_, ?DISCOUNT_TENGE_, ?DISCOUNT_SU' +
        'MM_, ?NDS_, ?NDS_SUMM_, ?COST_PRICE_, ?ALLOW_SELL_ABSENT_GOODS_,' +
        ' ?IS_SPISANIE_, ?NEW_LINE_SALE_, ?MODE_, ?USE_SELF_PRICE_ONTRANS' +
        'FER_, ?DO_PRODUCT_IN_SALE_, ?MARK_CODE_, ?VES_GRAMM_PRICE_, ?NOT' +
        '_MINUS_OSTATOK_)')
    StoredProcName = 'INS_ZAKAZ_DETAILS_TMP'
    Left = 120
    Top = 579
  end
  inherited spUpd: TpFIBStoredProc
    Left = 152
    Top = 579
  end
  object dsRead: TDataSource
    DataSet = spRead
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
      'SELECT * FROM G_READ_G_PRODCAT_LIST(?Type_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 24
    Top = 104
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'WITH DOPBAR AS (SELECT LIST(B.BARCODE) BARCODE_DOP, B.G_PRODUCT ' +
        'FROM LT_BARCODE B GROUP BY B.G_PRODUCT)'
      'SELECT T.G_PRODUCT,'
      '        T.ARTICUL,'
      '        T.BARCODE,'
      '        T.NOMENCLATUR_NUM,'
      '        T.NAME,'
      '        T.PRICE,'
      '        T.VOLUME_PRICE,'
      '        T.PACK_AMOUNT,'
      
        '        COALESCE(P.AMOUNT, 0) - COALESCE(P.AMOUNT_RESERVE, 0) AM' +
        'OUNT,'
      '        PP.SKIDKA_PROC,'
      '        PP.SKIDKA_SUM'
      '        ,T.NOTE'
      '        ,T.CROSSCODE'
      '        ,T.PLACE'
      '        ,G.SHORT_NAME UNIT_NAME'
      '        ,T.IS_MARKED'
      '        ,DB.BARCODE_DOP'
      
        'FROM G_PRODUCT T LEFT OUTER JOIN LT_SKLAD_PRODUCT P ON T.G_PRODU' +
        'CT = P.G_PRODUCT AND P.G_TOCHKA = :G_TOCHKA_'
      
        '                 LEFT OUTER JOIN DOPBAR DB ON T.G_PRODUCT = DB.G' +
        '_PRODUCT'
      
        '                 LEFT OUTER JOIN (SELECT G_PRODUCT, D.SKIDKA_PRO' +
        'C, D.SKIDKA_SUM'
      '                                    FROM G_DISCOUNT D'
      
        '                                    WHERE ((D.DATE_BEGIN <= CURR' +
        'ENT_TIMESTAMP  -- '#1058#1054#1051#1068#1050#1054' '#1040#1050#1058#1048#1042#1053#1067#1045
      
        '                                            AND D.DATE_END >= CU' +
        'RRENT_TIMESTAMP'
      
        '                                            AND D.DATE_BEGIN IS ' +
        'NOT NULL AND D.DATE_END IS NOT NULL'
      '                                          )'
      '                                          OR'
      
        '                                          (D.DATE_BEGIN IS NULL ' +
        'AND D.DATE_END IS NULL))'
      
        '                                    AND COALESCE(D.G_TOCHKA, :G_' +
        'TOCHKA_) = :G_TOCHKA_'
      
        '                                 ) PP ON T.G_PRODUCT = PP.G_PROD' +
        'UCT,'
      '     G_UNIT G'
      
        'WHERE T.G_PRODUCT_PAR = DECODE(CAST(:G_PRODUCT_PAR_ AS BIGINT), ' +
        '-1, T.G_PRODUCT_PAR, CAST(:G_PRODUCT_PAR_ AS BIGINT))'
      ' AND T.IS_CATEGORY = 0'
      ' AND T.IS_ACTIVE = 1'
      ' AND T.G_UNIT = G.G_UNIT'
      'ORDER BY 5'
      ''
      '/*SELECT'
      '        T.G_PRODUCT,'
      '        T.ARTICUL,'
      '        T.BARCODE,'
      '        T.NOMENCLATUR_NUM,'
      '        T.NAME,'
      '        T.PRICE,'
      '        T.VOLUME_PRICE,'
      '        T.PACK_AMOUNT,'
      
        '        COALESCE(P.AMOUNT, 0) - COALESCE(P.AMOUNT_RESERVE, 0) AM' +
        'OUNT,'
      '        PP.SKIDKA_PROC,'
      '        PP.SKIDKA_SUM'
      '        ,T.NOTE'
      '        ,T.CROSSCODE'
      '        ,T.PLACE'
      '        ,T.UNIT_NAME'
      '        ,T.IS_MARKED'
      '    FROM (SELECT G_PRODUCT,'
      '                 G_PRODUCT_PAR,'
      '                 ARTICUL,'
      '                 BARCODE,'
      '                 NOMENCLATUR_NUM,'
      '                 G.NAME,'
      '                 PRICE,'
      '                 VOLUME_PRICE,'
      '                 PACK_AMOUNT'
      '                 ,NOTE'
      '                 ,CROSSCODE'
      '                 ,PLACE'
      '                 ,GG.SHORT_NAME UNIT_NAME'
      '                 ,G.IS_MARKED'
      '            FROM G_PRODUCT G,'
      '                 G_UNIT GG'
      '           WHERE IS_CATEGORY = 0'
      '             AND IS_ACTIVE = 1'
      '             AND G.G_UNIT = GG.G_UNIT'
      '          UNION ALL'
      '          SELECT T1.G_PRODUCT,'
      '                 T1.G_PRODUCT_PAR,'
      '                 T1.ARTICUL,'
      '                 B.BARCODE,'
      '                 T1.NOMENCLATUR_NUM,'
      '                 T1.NAME||'#39' ('#1076#1086#1087'.'#1096#1090#1088#1080#1093#1082#1086#1076')'#39','
      '                 T1.PRICE,'
      '                 T1.VOLUME_PRICE,'
      '                 T1.PACK_AMOUNT'
      '                 ,T1.NOTE'
      '                 ,T1.CROSSCODE'
      '                 ,T1.PLACE'
      '                 ,GG.SHORT_NAME UNIT_NAME'
      '                 ,T1.IS_MARKED'
      '            FROM G_PRODUCT T1, LT_BARCODE B,'
      '                 G_UNIT GG'
      '           WHERE IS_CATEGORY = 0'
      '             AND IS_ACTIVE = 1'
      '             AND T1.G_UNIT = GG.G_UNIT'
      
        '             AND B.G_PRODUCT = T1.G_PRODUCT) T LEFT OUTER JOIN (' +
        'SELECT G_PRODUCT, AMOUNT, AMOUNT_RESERVE FROM LT_SKLAD_PRODUCT W' +
        'HERE G_TOCHKA = :G_TOCHKA_)  P ON T.G_PRODUCT = P.G_PRODUCT'
      
        '         LEFT OUTER JOIN (SELECT G_PRODUCT, D.SKIDKA_PROC, D.SKI' +
        'DKA_SUM'
      '                            FROM G_DISCOUNT D'
      
        '                            WHERE ((D.DATE_BEGIN <= CURRENT_TIME' +
        'STAMP  -- '#1058#1054#1051#1068#1050#1054' '#1040#1050#1058#1048#1042#1053#1067#1045
      
        '                                    AND D.DATE_END >= CURRENT_TI' +
        'MESTAMP'
      
        '                                    AND D.DATE_BEGIN IS NOT NULL' +
        ' AND D.DATE_END IS NOT NULL'
      '                                  )'
      '                                  OR'
      
        '                                  (D.DATE_BEGIN IS NULL AND D.DA' +
        'TE_END IS NULL))'
      
        '                            AND COALESCE(D.G_TOCHKA, :G_TOCHKA_)' +
        ' = :G_TOCHKA_'
      '                         ) PP ON T.G_PRODUCT = PP.G_PRODUCT'
      
        '    WHERE T.G_PRODUCT_PAR = DECODE(CAST(:G_PRODUCT_PAR_ AS BIGIN' +
        'T), -1, T.G_PRODUCT_PAR, CAST(:G_PRODUCT_PAR_ AS BIGINT))'
      '    ORDER BY 5'
      '*/')
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
    Left = 600
    Top = 56
  end
  object TimerChangeEd: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerChangeEdTimer
    Left = 352
    Top = 152
  end
  object aeScanner: TApplicationEvents
    OnMessage = aeScannerMessage
    Left = 192
    Top = 240
  end
  object GetLastPrice: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE GET_LAST_SELF_PRICE (?G_PRODUCT_, ?G_TOCHKA_, ' +
        '?MODE_)')
    StoredProcName = 'GET_LAST_SELF_PRICE'
    Left = 384
    Top = 459
  end
  object pmGrid: TPopupMenu
    Left = 248
    Top = 576
    object pmCustomizeColumns: TMenuItem
      Action = aCustomizeColumns
    end
  end
end
