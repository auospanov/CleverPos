inherited PriceListUnForm: TPriceListUnForm
  Left = 458
  Top = 126
  Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 344
  ClientWidth = 594
  OnCreate = FormCreate
  ExplicitWidth = 600
  ExplicitHeight = 370
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 574
    Height = 299
    ExplicitWidth = 574
    ExplicitHeight = 299
    object cxPageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 570
      Height = 295
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tsCommon
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 5
      LookAndFeel.Kind = lfUltraFlat
      OnChange = cxPageControlChange
      ClientRectBottom = 295
      ClientRectRight = 570
      ClientRectTop = 25
      object tsCommon: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1054#1073#1097#1080#1077' '#1088#1077#1082#1074#1080#1079#1080#1090#1099
        ImageIndex = 0
        object ShapeNote: TShape
          Left = 8
          Top = 220
          Width = 176
          Height = 42
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape25: TShape
          Left = 8
          Top = 9
          Width = 177
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape3: TShape
          Left = 183
          Top = 59
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape8: TShape
          Left = 183
          Top = 109
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object SpeedButton4: TSpeedButton
          Left = 535
          Top = 61
          Width = 26
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aClearArticul
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
        end
        object SpeedButton3: TSpeedButton
          Left = 505
          Top = 61
          Width = 26
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aGenArticul
          Glyph.Data = {
            E6000000424DE60000000000000076000000280000000E0000000E0000000100
            0400000000007000000000000000000000001000000000000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3300333333333333330033333333333333003333300033333300333330F03333
            3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
            3300333330F033333300333330F0333333003333300033333300333333333333
            33003333333333333300}
        end
        object btnGenBarcode: TSpeedButton
          Left = 505
          Top = 111
          Width = 26
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Glyph.Data = {
            E6000000424DE60000000000000076000000280000000E0000000E0000000100
            0400000000007000000000000000000000001000000000000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3300333333333333330033333333333333003333300033333300333330F03333
            3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
            3300333330F033333300333330F0333333003333300033333300333333333333
            33003333333333333300}
          OnClick = btnGenBarcodeClick
        end
        object SpeedButton1: TSpeedButton
          Left = 535
          Top = 111
          Width = 26
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aClearBarcode
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
        end
        object Shape9: TShape
          Left = 8
          Top = 145
          Width = 177
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape7: TShape
          Left = 8
          Top = 109
          Width = 176
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape6: TShape
          Left = 183
          Top = 84
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape5: TShape
          Left = 8
          Top = 84
          Width = 176
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape4: TShape
          Left = 183
          Top = 34
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape26: TShape
          Left = 183
          Top = 9
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape2: TShape
          Left = 8
          Top = 34
          Width = 176
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape14: TShape
          Left = 183
          Top = 195
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape13: TShape
          Left = 8
          Top = 195
          Width = 176
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape12: TShape
          Left = 183
          Top = 170
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape11: TShape
          Left = 8
          Top = 170
          Width = 176
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape10: TShape
          Left = 183
          Top = 145
          Width = 382
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape1: TShape
          Left = 8
          Top = 59
          Width = 176
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label7: TLabel
          Left = 18
          Top = 201
          Width = 79
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1087#1090#1086#1074#1072#1103' '#1094#1077#1085#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 18
          Top = 176
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
        object Label5: TLabel
          Left = 18
          Top = 151
          Width = 114
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 18
          Top = 115
          Width = 56
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1064#1090#1088#1080#1093#1082#1086#1076
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label3: TLabel
          Left = 18
          Top = 90
          Width = 137
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1085#1099#1081' '#1085#1086#1084#1077#1088
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label2: TLabel
          Left = 18
          Top = 40
          Width = 83
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label13: TLabel
          Left = 18
          Top = 15
          Width = 88
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label1: TLabel
          Left = 18
          Top = 65
          Width = 47
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1040#1088#1090#1080#1082#1091#1083
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sbInsCategory: TSpeedButton
          Left = 533
          Top = 11
          Width = 26
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aInsCategory
          Glyph.Data = {
            E6000000424DE60000000000000076000000280000000E0000000E0000000100
            0400000000007000000000000000000000001000000000000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3300333333333333330033333333333333003333300033333300333330F03333
            3300333330F033333300330000F000033300330FFFFFFF033300330000F00003
            3300333330F033333300333330F0333333003333300033333300333333333333
            33003333333333333300}
        end
        object lbNote: TLabel
          Left = 18
          Top = 234
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
        object ShapeNote1: TShape
          Left = 183
          Top = 220
          Width = 382
          Height = 42
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object rb8: TRadioButton
          Left = 442
          Top = 114
          Width = 57
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'EAN-8'
          TabOrder = 6
          OnClick = rb8Click
        end
        object rb13: TRadioButton
          Left = 362
          Top = 114
          Width = 65
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'EAN-13'
          Checked = True
          TabOrder = 5
          TabStop = True
          OnClick = rb13Click
        end
        object leCategory: TcxLookupComboBox
          Left = 190
          Top = 12
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
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
          TabOrder = 0
          Width = 339
        end
        object edName: TcxTextEdit
          Left = 190
          Top = 37
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 250
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 1
          OnKeyPress = edNameKeyPress
          Width = 368
        end
        object edArticul: TcxTextEdit
          Left = 190
          Top = 62
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 30
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 2
          Width = 309
        end
        object edNomenclatur: TcxTextEdit
          Left = 190
          Top = 87
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 3
          Width = 368
        end
        object edBarcode: TcxTextEdit
          Left = 190
          Top = 112
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 30
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 4
          Width = 165
        end
        object leGUnit: TcxLookupComboBox
          Left = 190
          Top = 148
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.KeyFieldNames = 'G_UNIT'
          Properties.ListColumns = <
            item
              FieldName = 'NAME'
            end>
          Properties.ListSource = dsGUnit
          Style.StyleController = dxEditStyleController
          TabOrder = 7
          Width = 371
        end
        object edPrice: TcxCurrencyEdit
          Left = 190
          Top = 173
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.MaxLength = 15
          Properties.UseLeftAlignmentOnEditing = False
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 8
          Width = 371
        end
        object edVolPrice: TcxCurrencyEdit
          Left = 190
          Top = 198
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          ParentFont = False
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.MaxLength = 15
          Properties.UseLeftAlignmentOnEditing = False
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 9
          Width = 371
        end
        object mNote: TcxMemo
          Left = 190
          Top = 222
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 300
          Style.StyleController = dxEditStyleController
          TabOrder = 10
          Height = 35
          Width = 371
        end
      end
      object tsMisc: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1088#1086#1095#1077#1077
        ImageIndex = 4
        object Shape15: TShape
          Left = 8
          Top = 84
          Width = 218
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh3: TShape
          Left = 8
          Top = 59
          Width = 218
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object sh1: TShape
          Left = 8
          Top = 34
          Width = 218
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape19: TShape
          Left = 8
          Top = 9
          Width = 218
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label10: TLabel
          Left = 18
          Top = 15
          Width = 192
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1086#1089#1090#1072#1090#1086#1082' '#1076#1083#1103' '#1079#1072#1082#1091#1087#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape20: TShape
          Left = 225
          Top = 9
          Width = 334
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lb1: TLabel
          Left = 18
          Top = 40
          Width = 132
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1091#1087#1072#1082#1086#1074#1082#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh2: TShape
          Left = 225
          Top = 34
          Width = 334
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lb2: TLabel
          Left = 18
          Top = 65
          Width = 129
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1090#1088#1072#1085#1072'-'#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object sh4: TShape
          Left = 225
          Top = 59
          Width = 334
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Label8: TLabel
          Left = 18
          Top = 90
          Width = 95
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1052#1077#1089#1090#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape16: TShape
          Left = 225
          Top = 84
          Width = 334
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object edMinAmount: TcxCurrencyEdit
          Left = 230
          Top = 12
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
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
          TabOrder = 0
          Width = 325
        end
        object edPackAmount: TcxCurrencyEdit
          Left = 230
          Top = 37
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
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
          TabOrder = 1
          Width = 325
        end
        object edMFCountry: TcxTextEdit
          Left = 230
          Top = 62
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 2
          OnKeyPress = edMFCountryKeyPress
          Width = 325
        end
        object edPlace: TcxTextEdit
          Left = 230
          Top = 87
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 250
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 3
          Width = 325
        end
      end
      object tsBarcode: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1044#1086#1087'. '#1096#1090#1088#1080#1093#1082#1086#1076#1072
        ImageIndex = 1
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 570
          Height = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object btnIns: TBitBtn
            Left = 5
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
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
            TabOrder = 0
            OnClick = btnInsClick
          end
          object btnDel: TBitBtn
            Left = 107
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
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
            TabOrder = 1
            OnClick = btnDelClick
          end
        end
        object grBarcode: TcxGrid
          Left = 0
          Top = 41
          Width = 570
          Height = 229
          Align = alClient
          TabOrder = 1
          LookAndFeel.Kind = lfFlat
          object tvBarcode: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsBarcode
            DataController.KeyFieldNames = 'LT_BARCODE'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsSelection.CellSelect = False
            OptionsView.GroupByBox = False
            OptionsView.Header = False
            Styles.Inactive = MainDM.stGridSelectedRow
            object clmMainBARCODE: TcxGridDBColumn
              Caption = #1064#1090#1088#1080#1093#1082#1086#1076
              DataBinding.FieldName = 'BARCODE'
            end
          end
          object lvMain: TcxGridLevel
            GridView = tvBarcode
          end
        end
      end
      object tsCross: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1050#1088#1086#1089#1089'-'#1082#1086#1076#1099
        ImageIndex = 2
        TabVisible = False
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 570
          Height = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object bbAddCross: TBitBtn
            Left = 5
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
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
            TabOrder = 0
            OnClick = bbAddCrossClick
          end
          object bbDelCross: TBitBtn
            Left = 107
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
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
            TabOrder = 1
            OnClick = bbDelCrossClick
          end
        end
        object lbCross: TListBox
          Left = 0
          Top = 41
          Width = 570
          Height = 229
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          ItemHeight = 14
          TabOrder = 1
        end
      end
      object tsPhoto: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1060#1086#1090#1086#1075#1088#1072#1092#1080#1080
        Color = clAppWorkSpace
        ImageIndex = 2
        ParentColor = False
        object img1: TImage
          Left = 0
          Top = 41
          Width = 570
          Height = 195
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Center = True
          Proportional = True
          Stretch = True
          ExplicitWidth = 571
          ExplicitHeight = 199
        end
        object pn1: TPanel
          Left = 0
          Top = 0
          Width = 570
          Height = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object btnInsPic: TBitBtn
            Left = 5
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
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
            TabOrder = 0
            OnClick = btnInsPicClick
          end
          object btnDelPic: TBitBtn
            Left = 107
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
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
            TabOrder = 1
            OnClick = btnDelPicClick
          end
        end
        object pn2: TPanel
          Left = 0
          Top = 236
          Width = 570
          Height = 34
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alBottom
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object lbPhotoNum: TLabel
            Left = 256
            Top = 8
            Width = 30
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1060#1086#1090#1086
          end
          object sbPrev: TSpeedButton
            Left = 158
            Top = 6
            Width = 23
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00000000000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            OnClick = sbPrevClick
          end
          object sbNext: TSpeedButton
            Left = 374
            Top = 6
            Width = 23
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            OnClick = sbNextClick
          end
        end
      end
      object tsSostav: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1086#1089#1090#1072#1074#1085#1086#1081' '#1090#1086#1074#1072#1088
        ImageIndex = 3
        object pn3: TPanel
          Left = 0
          Top = 0
          Width = 570
          Height = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object btnInsKit: TBitBtn
            Left = 5
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Action = aInsKit
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
            TabOrder = 0
          end
          object btnDelKit: TBitBtn
            Left = 211
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Action = aDelKit
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
            TabOrder = 2
          end
          object btnUpdKit: TBitBtn
            Left = 108
            Top = 8
            Width = 103
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Action = aUpdKit
            Caption = #1048#1079#1084#1077#1085#1080#1090#1100
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
            TabOrder = 1
          end
        end
        object pn4: TPanel
          Left = 0
          Top = 172
          Width = 570
          Height = 98
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 2
          object lbUsual: TLabel
            Left = 12
            Top = 36
            Width = 421
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 
              #1054#1073#1099#1095#1085#1099#1081' '#1090#1086#1074#1072#1088', '#1085#1077' '#1089#1086#1089#1090#1086#1103#1097#1080#1081' '#1080#1079' '#1082#1072#1082#1080#1093'-'#1083#1080#1073#1086' '#1076#1077#1090#1072#1083#1077#1081' '#1080' '#1082#1086#1084#1087#1083#1077#1082#1090#1091#1102#1097#1080 +
              #1093'.'
            WordWrap = True
          end
          object lbSostav: TLabel
            Left = 12
            Top = 36
            Width = 481
            Height = 42
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 
              #1057#1086#1089#1090#1072#1074#1085#1086#1081' '#1090#1086#1074#1072#1088' ('#1085#1072#1073#1086#1088') '#1089#1086#1089#1090#1086#1103#1097#1080#1081' '#1080#1079' '#1085#1077#1089#1082#1086#1083#1100#1082#1080#1093' '#1087#1088#1086#1089#1090#1099#1093' '#1090#1086#1074#1072#1088#1086#1074'.' +
              #13#10#1053#1072#1087#1088#1080#1084#1077#1088', '#1074' '#1082#1086#1092#1077#1081#1085#1086#1081' '#1083#1072#1074#1082#1077' '#1090#1086#1074#1072#1088' "'#1050#1086#1092#1077'" - '#1101#1090#1086' '#1089#1072#1084#1086' '#1082#1086#1092#1077' '#1087#1083#1102#1089' '#1089 +
              #1090#1072#1082#1072#1085' '#1080' '#1082#1088#1099#1096#1082#1072'.'#13#10#1055#1088#1080' '#1087#1088#1086#1076#1072#1078#1077' '#1090#1086#1074#1072#1088#1072' "'#1050#1086#1092#1077'" '#1074' '#1085#1072#1082#1083#1072#1076#1085#1091#1102' '#1073#1091#1076#1091#1090' '#1076#1086#1073 +
              #1072#1074#1083#1077#1085#1099' - '#1082#1086#1092#1077', '#1089#1090#1072#1082#1072#1085', '#1082#1088#1099#1096#1082#1072'.'
            Visible = False
            WordWrap = True
          end
          object lbSostavProduct: TLabel
            Left = 12
            Top = 36
            Width = 544
            Height = 42
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 
              #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1087#1088#1086#1076#1091#1082#1090', '#1089#1086#1089#1090#1086#1103#1097#1080#1081' '#1080#1079' '#1076#1088#1091#1075#1080#1093' '#1087#1088#1086#1076#1091#1082#1090#1086#1074' ('#1087#1086#1083#1091#1092#1072#1073 +
              #1088#1080#1082#1072#1090#1086#1074'). '#1053#1072#1087#1088#1080#1084#1077#1088', '#1090#1086#1074#1072#1088' "'#1055#1080#1088#1086#1078#1086#1082'" '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1089#1103' '#1080#1079' '#1090#1086#1074#1072#1088#1072' "'#1058#1077#1089#1090 +
              #1086'", '#1082#1086#1090#1086#1088#1099#1081' '#1074' '#1089#1074#1086#1102' '#1086#1095#1077#1088#1077#1076#1100', '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1089#1103' '#1080#1079' "'#1052#1091#1082#1072'" '#1080' "'#1071#1081#1094#1072'".'
            Visible = False
            WordWrap = True
          end
          object lbProduct: TLabel
            Left = 12
            Top = 36
            Width = 495
            Height = 42
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 
              #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1087#1088#1086#1076#1091#1082#1090', '#1089#1086#1089#1090#1086#1103#1097#1080#1081' '#1080#1079' '#1085#1077#1089#1082#1086#1083#1100#1082#1080#1093' '#1076#1077#1090#1072#1083#1077#1081' '#1080#1083#1080' '#1082#1086 +
              #1084#1087#1083#1077#1082#1090#1091#1102#1097#1080#1093'. '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072' '#1086#1089#1091#1097#1077#1089#1090#1074#1083#1103#1077#1090#1089#1103' '#1074' '#1084#1077#1085#1102' "'#1058#1086#1088#1075#1086#1074#1083#1103 +
              ' - '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086'". '#1053#1072#1087#1088#1080#1084#1077#1088', '#1087#1086#1083#1091#1092#1072#1073#1088#1080#1082#1072#1090' "'#1058#1077#1089#1090#1086'" - '#1087#1086#1083#1091#1095#1072#1077#1090#1089#1103' '#1080#1079 +
              ' '#1090#1086#1074#1072#1088#1086#1074' "'#1052#1091#1082#1072'" '#1080' "'#1071#1081#1094#1072'".'
            Visible = False
            WordWrap = True
          end
          object cbTovar: TComboBox
            Left = 13
            Top = 8
            Width = 268
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            TabOrder = 0
            Text = #1054#1073#1099#1095#1085#1099#1081' '#1090#1086#1074#1072#1088
            OnChange = cbTovarChange
            OnClick = cbTovarClick
            Items.Strings = (
              #1054#1073#1099#1095#1085#1099#1081' '#1090#1086#1074#1072#1088
              #1053#1072#1073#1086#1088' ('#1089#1086#1089#1090#1072#1074#1085#1086#1081')'
              #1055#1088#1086#1076#1091#1082#1090' ('#1087#1086#1083#1091#1092#1072#1073#1088#1080#1082#1072#1090')'
              #1057#1086#1089#1090#1072#1074#1085#1086#1081' '#1087#1088#1086#1076#1091#1082#1090)
          end
        end
        object grSostav: TcxGrid
          Left = 0
          Top = 41
          Width = 570
          Height = 131
          Align = alClient
          TabOrder = 1
          LookAndFeel.Kind = lfFlat
          object cxGridDBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsReadKit
            DataController.KeyFieldNames = 'G_PRODUCT'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsSelection.CellSelect = False
            OptionsView.GroupByBox = False
            Styles.Inactive = MainDM.stGridSelectedRow
            object clmGridDBTableView1NAME: TcxGridDBColumn
              Caption = #1058#1086#1074#1072#1088
              DataBinding.FieldName = 'NAME'
              Width = 293
            end
            object clmGridDBTableView1AMOUNT: TcxGridDBColumn
              Caption = #1050#1086#1083'-'#1074#1086
              DataBinding.FieldName = 'AMOUNT'
              HeaderAlignmentHorz = taCenter
              Width = 100
            end
            object clmGridDBTableView1PRICE: TcxGridDBColumn
              Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
              DataBinding.FieldName = 'PRICE'
              HeaderAlignmentHorz = taCenter
              Width = 128
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBTableView1
          end
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 425
    Top = 313
    Anchors = []
    ExplicitLeft = 425
    ExplicitTop = 313
  end
  inherited btnCancel: TcxButton
    Left = 507
    Top = 313
    Anchors = []
    ExplicitLeft = 507
    ExplicitTop = 313
  end
  inherited btHelp: TcxButton
    Top = 313
    ExplicitTop = 313
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = MainDM.imMain
    Top = 372
    object aGenBarcode: TAction
    end
    object aClearBarcode: TAction
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1096#1090#1088#1080#1093#1082#1086#1076
      ImageIndex = 47
      OnExecute = aClearBarcodeExecute
    end
    object aGenArticul: TAction
      Hint = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1072#1088#1090#1080#1082#1091#1083
      OnExecute = aGenArticulExecute
    end
    object aClearArticul: TAction
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1072#1088#1090#1080#1082#1091#1083
      ImageIndex = 47
      OnExecute = aClearArticulExecute
    end
    object aRefreshBarcode: TAction
      Caption = 'aRefreshBarcode'
      OnExecute = aRefreshBarcodeExecute
    end
    object aInsCategory: TAction
      OnExecute = aInsCategoryExecute
    end
    object aRefreshCross: TAction
      Caption = 'aRefreshCross'
      OnExecute = aRefreshCrossExecute
    end
    object aInsKit: TAction
      Category = 'Kit'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      ImageIndex = 150
      OnExecute = aInsKitExecute
    end
    object aUpdKit: TAction
      Category = 'Kit'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Enabled = False
      ImageIndex = 148
      OnExecute = aUpdKitExecute
    end
    object aDelKit: TAction
      Category = 'Kit'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      ImageIndex = 149
      OnExecute = aDelKitExecute
    end
  end
  inherited tranRead: TpFIBTransaction
    Top = 372
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_PRODUCT (?G_PRODUCT_)')
    StoredProcName = 'G_GET_G_PRODUCT'
    Top = 372
  end
  inherited tranWrite: TpFIBTransaction
    Top = 372
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_INS_G_PRODUCT (?G_PRODUCT_PAR_, ?ARTICUL_, ?' +
        'NOMENCLATUR_NUM_, ?BARCODE_, ?NAME_, ?G_UNIT_, ?PRICE_, ?VOLUME_' +
        'PRICE_, ?PACK_AMOUNT_, ?MF_COUNTRY_, ?NOTE_, ?CROSSCODE_, ?IS_KI' +
        'T_, ?MIN_AMOUNT_, ?PLACE_, ?IS_CATEGORY_)')
    StoredProcName = 'G_INS_G_PRODUCT'
    Top = 372
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_PRODUCT (?G_PRODUCT_, ?G_PRODUCT_PAR_,' +
        ' ?ARTICUL_, ?NOMENCLATUR_NUM_, ?BARCODE_, ?NAME_, ?G_UNIT_, ?PRI' +
        'CE_, ?VOLUME_PRICE_, ?PACK_AMOUNT_, ?MF_COUNTRY_, ?NOTE_, ?CROSS' +
        'CODE_, ?IS_KIT_, ?IS_CATEGORY_, ?MIN_AMOUNT_, ?PLACE_)')
    StoredProcName = 'G_UPD_G_PRODUCT'
    Top = 372
  end
  object spGUnit: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_UNIT_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 480
    Top = 176
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
    Left = 304
    Top = 40
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsProductCategory: TDataSource
    DataSet = spProductCategory
    Left = 336
    Top = 40
  end
  object dsGUnit: TDataSource
    DataSet = spGUnit
    Left = 512
    Top = 176
  end
  object spGetArticul: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_FREE_ARTICUL ')
    StoredProcName = 'GET_FREE_ARTICUL'
    Left = 536
    Top = 112
  end
  object spGetBarcode: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_FREE_BARCODE (?MODE_, ?PREFIX_)')
    StoredProcName = 'GET_FREE_BARCODE'
    Left = 536
    Top = 144
  end
  object spBarcode: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM LT_BARCODE_TMP_READ')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 242
    Top = 107
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsBarcode: TDataSource
    DataSet = spBarcode
    Left = 272
    Top = 120
  end
  object spInsBarcode: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE LT_BARCODE_TMP_INS (?G_PRODUCT_, ?BARCODE_)')
    StoredProcName = 'LT_BARCODE_TMP_INS'
    Left = 352
    Top = 100
  end
  object spDelBarcode: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE LT_BARCODE_TMP_DEL (?LT_BARCODE_)')
    StoredProcName = 'LT_BARCODE_TMP_DEL'
    Left = 384
    Top = 100
  end
  object dlgOpenPic: TOpenPictureDialog
    Left = 440
    Top = 112
  end
  object spReadPics: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from G_PRODUCT_IMAGE_TMP')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 240
    Top = 168
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object ds1: TDataSource
    DataSet = spReadPics
    Left = 272
    Top = 168
  end
  object spUpdatePics: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 304
    Top = 169
  end
  object spReadKit: TpFIBDataSet
    SelectSQL.Strings = (
      'select k.g_product g_product_prod,'
      '       k.g_product_item g_product,'
      '       k.amount,'
      '       k.price,'
      '       k.price1 price_vol,'
      '       g.name'
      '  from G_PRODUCT_kit_tmp k,'
      '       g_product g'
      ' where k.g_product_item = g.g_product')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 240
    Top = 200
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadKit: TDataSource
    DataSet = spReadKit
    Left = 272
    Top = 200
  end
  object pmBarcode: TPopupMenu
    Left = 160
    Top = 296
    object NUsualBarcode: TMenuItem
      Caption = #1054#1073#1099#1095#1085#1099#1081' '#1096#1090#1088#1080#1093#1082#1086#1076
      OnClick = NUsualBarcodeClick
    end
    object NScaleBarcode: TMenuItem
      Caption = #1042#1077#1089#1086#1074#1086#1081' '#1096#1090#1088#1080#1093#1082#1086#1076
      OnClick = NScaleBarcodeClick
    end
  end
end
