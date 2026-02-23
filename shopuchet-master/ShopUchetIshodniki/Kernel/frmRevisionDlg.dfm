inherited RevisionDlgForm: TRevisionDlgForm
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = #1056#1077#1074#1080#1079#1080#1103
  ClientHeight = 570
  ClientWidth = 787
  Constraints.MinWidth = 795
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 795
  ExplicitHeight = 598
  PixelsPerInch = 96
  TextHeight = 14
  inherited btnCancel: TcxButton [0]
    Left = 552
    Top = 530
    Width = 226
    Height = 30
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Height = -16
    ParentFont = False
    ExplicitLeft = 552
    ExplicitTop = 530
    ExplicitWidth = 226
    ExplicitHeight = 30
  end
  inherited Panel1: TPanel [1]
    Width = 772
    Height = 519
    Color = clBtnFace
    ParentBackground = False
    ExplicitWidth = 772
    ExplicitHeight = 519
    object pnl1: TPanel
      Left = 2
      Top = 2
      Width = 768
      Height = 129
      Align = alTop
      TabOrder = 0
      DesignSize = (
        768
        129)
      object shp1: TShape
        Left = 5
        Top = 4
        Width = 161
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shp4: TShape
        Left = 5
        Top = 28
        Width = 161
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shpNote: TShape
        Left = 5
        Top = 52
        Width = 161
        Height = 70
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lb1: TLabel
        Left = 12
        Top = 9
        Width = 119
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1088#1077#1074#1080#1079#1080#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lb2: TLabel
        Left = 12
        Top = 33
        Width = 141
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1088#1077#1074#1080#1079#1080#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lbNote: TLabel
        Left = 12
        Top = 77
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
      object shp2: TShape
        Left = 165
        Top = 4
        Width = 133
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object shp5: TShape
        Left = 165
        Top = 28
        Width = 133
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object shpNote1: TShape
        Left = 165
        Top = 52
        Width = 300
        Height = 70
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object shpTime: TShape
        Left = 297
        Top = 4
        Width = 73
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lbTime: TLabel
        Left = 307
        Top = 9
        Width = 36
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp6: TShape
        Left = 297
        Top = 28
        Width = 73
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lb3: TLabel
        Left = 307
        Top = 33
        Width = 36
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp3: TShape
        Left = 369
        Top = 4
        Width = 96
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object shp7: TShape
        Left = 369
        Top = 28
        Width = 96
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object lb4: TLabel
        Left = 496
        Top = 8
        Width = 266
        Height = 18
        Anchors = [akTop, akRight]
        Caption = #1054#1073#1097#1077#1077' '#1074#1088#1077#1084#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1088#1077#1074#1080#1079#1080#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lb5: TLabel
        Left = 537
        Top = 30
        Width = 168
        Height = 18
        Anchors = [akTop, akRight]
        Caption = '('#1076#1085#1080' : '#1095#1072#1089#1099' : '#1084#1080#1085#1091#1090#1099')'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbHour: TLabel
        Left = 513
        Top = 52
        Width = 58
        Height = 64
        Anchors = [akTop, akRight]
        Caption = '00'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -53
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lb8: TLabel
        Left = 574
        Top = 50
        Width = 19
        Height = 64
        Anchors = [akTop, akRight]
        Caption = ':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -53
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbMin: TLabel
        Left = 593
        Top = 52
        Width = 58
        Height = 64
        Anchors = [akTop, akRight]
        Caption = '00'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -53
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lb9: TLabel
        Left = 657
        Top = 50
        Width = 19
        Height = 64
        Anchors = [akTop, akRight]
        Caption = ':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -53
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbSec: TLabel
        Left = 678
        Top = 52
        Width = 58
        Height = 64
        Anchors = [akTop, akRight]
        Caption = '00'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -53
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object mNote: TcxMemo
        Left = 171
        Top = 56
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Style.StyleController = dxEditStyleController
        TabOrder = 0
        Height = 62
        Width = 287
      end
      object deDateEnd: TcxDateEdit
        Left = 170
        Top = 30
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Enabled = False
        Properties.InputKind = ikMask
        Style.BorderStyle = ebsFlat
        Style.ButtonStyle = bts3D
        Style.ButtonTransparency = ebtNone
        TabOrder = 1
        Width = 124
      end
      object deDateBegin: TcxDateEdit
        Left = 170
        Top = 6
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Enabled = False
        Properties.InputKind = ikMask
        Style.BorderStyle = ebsFlat
        Style.ButtonStyle = bts3D
        Style.ButtonTransparency = ebtNone
        TabOrder = 2
        Width = 124
      end
      object edTimeBegin: TcxTimeEdit
        Left = 375
        Top = 6
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        EditValue = 0d
        Enabled = False
        Properties.BeepOnError = True
        Properties.TimeFormat = tfHourMin
        Style.BorderStyle = ebsFlat
        TabOrder = 3
        Width = 83
      end
      object edTimeEnd: TcxTimeEdit
        Left = 375
        Top = 30
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        EditValue = 0d
        Enabled = False
        Properties.BeepOnError = True
        Properties.TimeFormat = tfHourMin
        Style.BorderStyle = ebsFlat
        TabOrder = 4
        Width = 83
      end
    end
    object pnl2: TPanel
      Left = 2
      Top = 274
      Width = 768
      Height = 143
      Align = alClient
      TabOrder = 1
      object gr1: TcxGrid
        Left = 1
        Top = 1
        Width = 766
        Height = 141
        Align = alClient
        TabOrder = 0
        OnEnter = gr1Enter
        OnExit = gr1Exit
        LookAndFeel.Kind = lfFlat
        object tvMain: TcxGridDBTableView
          PopupMenu = pmMain
          OnKeyDown = tvMainKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnEditing = tvMainEditing
          OnFocusedItemChanged = tvMainFocusedItemChanged
          OnFocusedRecordChanged = tvMainFocusedRecordChanged
          DataController.DataSource = dsRead
          DataController.KeyFieldNames = 'REVISION'
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = clmMainOVER_SUMM
            end
            item
              Kind = skSum
              Column = clmMainLOSS_SUMM
            end
            item
              Kind = skSum
              Column = clmMainAMOUNT
            end
            item
              Kind = skSum
              Column = clmAMOUNT_BD
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          DataController.Summary.OnAfterSummary = tvMainDataControllerSummaryAfterSummary
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.Inactive = MainDM.stGridSelectedRow
          object clmMainPRODUCT_NAME: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'NAME'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 225
          end
          object clmMainARTICUL: TcxGridDBColumn
            Caption = #1040#1088#1090#1080#1082#1091#1083
            DataBinding.FieldName = 'ARTICUL'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 100
          end
          object clmMainBARCODE: TcxGridDBColumn
            Caption = #1064#1090#1088#1080#1093#1082#1086#1076
            DataBinding.FieldName = 'BARCODE'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 100
          end
          object clmPLACE: TcxGridDBColumn
            Caption = #1052#1077#1089#1090#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
            DataBinding.FieldName = 'PLACE'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 110
          end
          object clmMainPRICE: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'PRICE'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.Alignment.Horz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 87
          end
          object clmMainAMOUNT: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1092#1072#1082#1090'.'
            DataBinding.FieldName = 'AMOUNT_REAL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            Properties.Nullable = False
            Properties.UseLeftAlignmentOnEditing = False
            RepositoryItem = riEditRepositoryCurrencyItem
            HeaderAlignmentHorz = taCenter
            Width = 75
          end
          object clmAMOUNT_BD: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1074' '#1073#1072#1079#1077
            DataBinding.FieldName = 'AMOUNT_BD'
            RepositoryItem = riEditRepositoryCurrencyItem
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 75
          end
          object clmDIFF_SUMM: TcxGridDBColumn
            Caption = #1056#1072'c'#1093#1086#1078#1076#1077#1085#1080#1077
            DataBinding.FieldName = 'DIFF_SUMM'
            RepositoryItem = riEditRepositoryCurrencyItem
            OnCustomDrawCell = clmDIFF_SUMMCustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 89
          end
          object clmMainOVER_SUMM: TcxGridDBColumn
            DataBinding.FieldName = 'OVER_SUMM'
            Visible = False
            Options.Editing = False
            Width = 76
          end
          object clmMainLOSS_SUMM: TcxGridDBColumn
            DataBinding.FieldName = 'LOSS_SUMM'
            Visible = False
            Options.Editing = False
          end
        end
        object lvMain: TcxGridLevel
          GridView = tvMain
        end
      end
    end
    object pnl3: TPanel
      Left = 2
      Top = 469
      Width = 768
      Height = 48
      Align = alBottom
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 2
      object pbBarcodeArrUpdate: TcxProgressBar
        Left = 0
        Top = -18
        Align = alBottom
        ParentFont = False
        Properties.BarStyle = cxbsGradient
        Properties.BeginColor = clActiveCaption
        Properties.ShowText = False
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -7
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 0
        Visible = False
        ExplicitTop = -23
        Width = 764
      end
      object pnl4: TPanel
        Left = 0
        Top = -2
        Width = 764
        Height = 46
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          764
          46)
        object lbOverSumm: TLabel
          Left = 10
          Top = 7
          Width = 318
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1058#1086#1074#1072#1088#1086#1074' 0. '#1057#1091#1084#1084#1072' '#1080#1079#1083#1080#1096#1082#1086#1074' 0. '#1057#1091#1084#1084#1072' '#1087#1086#1090#1077#1088#1100' 0.'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblRevisionMark: TLabel
          Left = 662
          Top = 1
          Width = 92
          Height = 25
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = #1063#1077#1088#1085#1086#1074#1080#1082
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clRed
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 885
        end
        object cxProgressBar1: TcxProgressBar
          Left = 1
          Top = 29
          Align = alBottom
          ParentFont = False
          Properties.BarStyle = cxbsGradient
          Properties.BeginColor = clActiveCaption
          Properties.ShowText = False
          Style.Font.Charset = RUSSIAN_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -7
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 0
          Visible = False
          ExplicitTop = 24
          Width = 762
        end
      end
    end
    object pnlActions: TPanel
      Left = 2
      Top = 131
      Width = 768
      Height = 60
      Align = alTop
      TabOrder = 3
      DesignSize = (
        768
        60)
      object lb6: TLabel
        Left = 12
        Top = 22
        Width = 41
        Height = 14
        Caption = #1058#1054#1042#1040#1056
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object peTovar: TcxPopupEdit
        Left = 61
        Top = 18
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ParentFont = False
        Properties.PopupControl = PopupTovListForm.Owner
        Properties.PopupHeight = 246
        Properties.PopupWidth = 514
        Properties.OnCloseUp = peClientPropertiesCloseUp
        Properties.OnInitPopup = peClientPropertiesInitPopup
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 0
        OnKeyPress = peTovarKeyPress
        Width = 404
      end
      object btnOptions: TcxButton
        Left = 640
        Top = 13
        Width = 121
        Height = 35
        Anchors = [akTop, akRight]
        Caption = #1054#1055#1062#1048#1048
        DropDownMenu = pmOptions
        Kind = cxbkOfficeDropDown
        LookAndFeel.Kind = lfFlat
        LookAndFeel.NativeStyle = True
        PopupAlignment = paRight
        TabOrder = 1
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlResult: TPanel
      Left = 2
      Top = 191
      Width = 768
      Height = 83
      Align = alTop
      TabOrder = 4
      Visible = False
      object lblSpisanoTovarovCount: TLabel
        Left = 15
        Top = 17
        Width = 125
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1087#1080#1089#1072#1085#1086' '#1090#1086#1074#1072#1088#1086#1074' 0'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblPrihodTovarovCount: TLabel
        Left = 412
        Top = 17
        Width = 167
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1054#1087#1088#1080#1093#1086#1076#1086#1074#1072#1085#1086' '#1090#1086#1074#1072#1088#1086#1074' 0'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblSpisanoTovarovSumm: TLabel
        Left = 15
        Top = 49
        Width = 76
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1053#1072' '#1089#1091#1084#1084#1091' 0'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblPrihodTovarovSumm: TLabel
        Left = 412
        Top = 49
        Width = 76
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1053#1072' '#1089#1091#1084#1084#1091' 0'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
    end
    object pnl5: TPanel
      Left = 2
      Top = 417
      Width = 768
      Height = 52
      Align = alBottom
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 5
      object lbl3: TLabel
        Left = 12
        Top = 17
        Width = 117
        Height = 14
        Caption = #1055#1054#1048#1057#1050' '#1055#1054' '#1057#1055#1048#1057#1050#1059
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edSearch: TcxTextEdit
        Left = 135
        Top = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ParentFont = False
        Properties.OnChange = edSearchPropertiesChange
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 0
        Width = 341
      end
      object btnClearSearch: TcxButton
        Left = 484
        Top = 13
        Width = 25
        Height = 24
        Action = aClearSearch
        LookAndFeel.Kind = lfFlat
        TabOrder = 1
      end
    end
  end
  inherited btnOk: TcxButton [2]
    Left = 552
    Top = 530
    Width = 226
    Height = 30
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1047#1072#1082#1088#1099#1090#1100
    Default = False
    Enabled = False
    OptionsImage.Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      1800000000000006000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5C524A
      37291E463A31BD8150BC7E4DB97949B67646B37141B06D3DAD6839AB65354236
      2E3D3026554B44FF00FFFF00FF5353532A2A2A3B3B3B8686868484848181817E
      7E7E7A7A7A7676767373737070703838383131314C4C4CFF00FFFF00FF3B2C21
      685C54483C34E8C28BE7C088E6BD85E5BB81E4B87CE3B579E2B276E2B2734439
      3151433A34261DFF00FFFF00FF2E2E2E5E5E5E3E3E3EB9B9B9B7B7B7B5B5B5B3
      B3B3B0B0B0AEAEAEACACACAAAAAA3A3A3A454545282828FF00FFFF00FF3E2F24
      6C60574A3F37D9B27DD8B07BD7AE77D7AB74D6A970D5A66DD4A56AD4A268473B
      335B4F4737291EFF00FFFF00FF313131616161404040ABABABA9A9A9A7A7A7A5
      A5A5A3A3A3A1A1A19F9F9F9E9E9E3D3D3D5151512A2A2AFF00FFFF00FF403126
      6F645C4C4038FFFFFFF7F1EBF7F0EBF7F0EBF7EFEBF6EFEAF6EFEAF6EFE9463B
      345D52493A2C21FF00FFFF00FF333333656565424242FFFFFFF1F1F1F1F1F1F1
      F1F1F1F1F1F0F0F0F0F0F0EFEFEF3D3D3D5353532D2D2DFF00FFFF00FF443429
      73675F4F443CFFFFFFF8F2EDF8F1EDF7F1EDF7F0EDF8F1EBF7F0EBF7F0EC4A40
      375F534B3D2E23FF00FFFF00FF363636696969454545FFFFFFF2F2F2F2F2F2F2
      F2F2F2F2F2F1F1F1F1F1F1F1F1F1404040555555303030FF00FFFF00FF46372C
      776B6350453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4E43
      3B61544C403126FF00FFFF00FF3939396D6D6D464646FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF444444565656333333FF00FFFF00FF493A2F
      796E6650453D61564E60564E60554D5F544C5E544C5E534B5D524A5C52495B51
      4961554D433429FF00FFFF00FF3C3C3C6F6F6F46464657575757575756565655
      5555555555545454535353525252525252575757363636FF00FFFF00FF4C3D32
      7C706A674E44654B42634A4161473F5F473E5C443C5B433A594139584038573F
      3763574F46362DFF00FFFF00FF3F3F3F7373735555555353535252525050504E
      4E4E4C4C4C4A4A4A494949484848474747595959393939FF00FFFF00FF4E3F35
      80746D6B5248F4ECE6E9DACEE9D8CDE9D8CCE9D8CBE8D7CAF3EAE2F3E9E25A41
      39645850483A2FFF00FFFF00FF414141767676595959EDEDEDDBDBDBDBDBDBDA
      DADADADADAD9D9D9EAEAEAEAEAEA4949495A5A5A3B3B3BFF00FFFF00FF514236
      82777070564DF9F5F2F4EAE4F1E6DEEBDCD2E9D9CC4E413D60534CF3EAE35D45
      3C6559514C3D32FF00FFFF00FF4343437979795E5E5EF5F5F5ECECECE7E7E7DE
      DEDEDADADA454545565656EBEBEB4C4C4C5B5B5B3F3F3FFF00FFFF00FF534439
      857A73755A50FAF6F3F5EDE7F4EDE6F4ECE6EFE2DA493D385A4D46F4EBE46048
      3F655A524F3F34FF00FFFF00FF4646467C7C7C626262F6F6F6EEEEEEEDEDEDED
      EDEDE4E4E4404040505050ECECEC4F4F4F5B5B5B414141FF00FFFF00FF55453A
      887D76795E54FAF6F4F5EEE9F5EDE7F4EDE7F4ECE6473A36483D36E9D9CD644C
      43675A52514137FF00FFFF00FF4747477F7F7F666666F7F7F7EFEFEFEEEEEEED
      EDEDEDEDED3E3E3E3F3F3FDBDBDB5353535C5C5C444444FF00FFFF00FF57483D
      8980797C6157FAF7F4FAF6F4FAF6F4FAF6F3FAF6F3FAF5F2F5EEE9F4ECE66950
      4682776F534439FF00FFFF00FF4A4A4A818181696969F7F7F7F7F7F7F7F7F7F6
      F6F6F6F6F6F6F6F6EFEFEFEDEDED575757787878464646FF00FFFF00FF81746D
      58493D7F645A998178967F75937A728E786D8B7269866E6482695F7D645B6E54
      4A56453B7C7068FF00FFFF00FF7777774A4A4A6C6C6C8888888585858282827D
      7D7D7A7A7A7575757070706C6C6C5C5C5C484848727272FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    Visible = False
    Font.Height = -16
    ParentFont = False
    ExplicitLeft = 552
    ExplicitTop = 530
    ExplicitWidth = 226
    ExplicitHeight = 30
  end
  inherited btHelp: TcxButton
    Top = 530
    Width = 105
    Height = 30
    Font.Height = -16
    ParentFont = False
    ExplicitTop = 530
    ExplicitWidth = 105
    ExplicitHeight = 30
  end
  object btnMadeRevision: TcxButton [4]
    Left = 428
    Top = 530
    Width = 118
    Height = 30
    Action = aMadeRevision
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = True
    TabOrder = 4
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnPrint: TcxButton [5]
    Left = 120
    Top = 530
    Width = 95
    Height = 30
    Action = aPrint
    Anchors = [akLeft, akBottom]
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = True
    TabOrder = 5
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 408
    Top = 368
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited cxEditRepository: TcxEditRepository
    Left = 168
    Top = 274
    inherited riEditRepositoryCurrencyItem: TcxEditRepositoryCurrencyItem
      Properties.DisplayFormat = '0.00'
    end
  end
  inherited ActionList: TActionList
    Images = MainDM.imMain
    object aPrint: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      Enabled = False
      ImageIndex = 146
      OnExecute = aPrintExecute
    end
    object aMadeRevision: TAction
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080
      Enabled = False
      ImageIndex = 166
      OnExecute = aMadeRevisionExecute
    end
    object aStartRevision: TAction
      Caption = #1053#1072#1095#1072#1090#1100' '#1088#1077#1074#1080#1079#1080#1102
      Enabled = False
      ImageIndex = 139
      OnExecute = aStartRevisionExecute
    end
    object actAddGoodsMass: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1084#1072#1089#1089#1086#1074#1086
      OnExecute = actAddGoodsMassExecute
    end
    object actAddGoodsFromFile: TAction
      Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1092#1072#1081#1083#1072' Excel'
      OnExecute = actAddGoodsFromFileExecute
    end
    object actDelItem: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = actDelItemExecute
    end
    object aClearSearch: TAction
      ImageIndex = 47
      OnExecute = aClearSearchExecute
    end
    object aInsTovarByScaner: TAction
      Caption = #1044#1086#1073#1072#1074#1083#1103#1090#1100' '#1085#1086#1074#1099#1077' '#1089#1090#1088#1086#1082#1080' '#1089#1082#1072#1085#1077#1088#1086#1084
      OnExecute = aInsTovarByScanerExecute
    end
  end
  inherited tranRead: TpFIBTransaction
    Left = 160
    Top = 608
  end
  inherited spGetData: TpFIBStoredProc
    Transaction = tranWrite
    SQL.Strings = (
      'EXECUTE PROCEDURE REVISION_PARENT_GET (?REVISION_PARENT_)')
    StoredProcName = 'REVISION_PARENT_GET'
    Left = 192
    Top = 608
  end
  inherited tranWrite: TpFIBTransaction
    Left = 224
    Top = 608
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE REVISION_PARENT_INS (?DATE_BEGIN_, ?TIME_BEGIN' +
        '_, ?DATE_END_, ?TIME_END_, ?NOTE_, ?G_TOCHKA_, ?IS_MADE_)')
    StoredProcName = 'REVISION_PARENT_INS'
    Left = 256
    Top = 608
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE REVISION_PARENT_UPD (?REVISION_PARENT_, ?DATE_' +
        'BEGIN_, ?TIME_BEGIN_, ?DATE_END_, ?TIME_END_, ?NOTE_, ?G_TOCHKA_' +
        ', ?IS_MADE_)')
    StoredProcName = 'REVISION_PARENT_UPD'
    Left = 288
    Top = 608
  end
  object tmrLabel: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrLabelTimer
    Left = 638
    Top = 58
  end
  object dsRead: TDataSource
    DataSet = spRead
    Left = 88
    Top = 264
  end
  object spInsItem: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE R_EDIT_REVISION (?REVISION_PARENT_, ?AMOUNT_RE' +
        'AL_, ?G_PRODUCT_, ?DATETIME_, ?G_TOCHKA_, ?BARCODE_, ?PREFIX_,:I' +
        'NS_TOVAR_BY_SCANER_)')
    StoredProcName = 'R_EDIT_REVISION'
    Left = 336
    Top = 360
  end
  object spInsHead: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE REVISION_PARENT_INS (?DATE_BEGIN_, ?TIME_BEGIN' +
        '_, ?DATE_END_, ?TIME_END_, ?NOTE_, ?G_TOCHKA_, ?IS_MADE_)')
    StoredProcName = 'REVISION_PARENT_INS'
    Left = 296
    Top = 360
  end
  object spDel: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE REVISION_PARENT_DEL (?REVISION_PARENT_, ?REVIS' +
        'ION_)')
    StoredProcName = 'REVISION_PARENT_DEL'
    Left = 544
    Top = 336
  end
  object spMadeRevision: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE R_MADE_REVISION (?DATE_BEGIN_, ?TIME_BEGIN_, ?' +
        'DATE_END_, ?TIME_END_, ?NOTE_, ?G_TOCHKA_, ?REVISION_PARENT_)')
    StoredProcName = 'R_MADE_REVISION'
    Left = 336
    Top = 408
  end
  object pmOptions: TPopupMenu
    Alignment = paRight
    Left = 640
    Top = 144
    object N1: TMenuItem
      Action = actAddGoodsMass
    end
    object N2: TMenuItem
      Action = actAddGoodsFromFile
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object NInsTovarByScaner: TMenuItem
      Action = aInsTovarByScaner
    end
  end
  object dlgOpenodlg: TOpenDialog
    Filter = 'Excel (*.xls, *.xlsx)|*.xls;*.xlsx'
    Left = 600
    Top = 144
  end
  object spImport: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE R_IMPORT_REVISION (?REVISION_PARENT_, ?G_TOCHK' +
        'A_, ?BARCODE_, ?AMOUNT_)')
    StoredProcName = 'R_IMPORT_REVISION'
    Left = 584
    Top = 336
  end
  object spFillRevisionMass: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE R_FILL_REVISION (?REVISION_PARENT_, ?G_PRODUCT' +
        '_PAR_, ?G_PRODUCT_, ?SKLAD_, ?G_TOCHKA_, ?TYPE_)')
    StoredProcName = 'R_FILL_REVISION'
    Left = 240
    Top = 360
  end
  object pmMain: TPopupMenu
    Left = 472
    Top = 412
    object N3: TMenuItem
      Action = actDelItem
    end
  end
  object tmrSearch: TTimer
    Enabled = False
    Interval = 400
    OnTimer = tmrSearchTimer
    Left = 192
    Top = 232
  end
  object spRead: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE REVISION'
      '   SET AMOUNT_REAL = :AMOUNT_REAL'
      'WHERE REVISION = :REVISION')
    SelectSQL.Strings = (
      'SELECT R.REVISION,'
      '           R.G_PRODUCT,'
      '           G.NAME,'
      '           G.BARCODE,'
      '           G.ARTICUL,'
      '           G.PRICE,'
      '           R.AMOUNT_BD,'
      '           CAST(R.AMOUNT_REAL AS MY_NUMERIC_5) AMOUNT_REAL,'
      '           G.PLACE,'
      '           R.AMOUNT_REAL - R.AMOUNT_BD DIFF_SUMM'
      
        '           ,CASE WHEN (R.AMOUNT_REAL - R.AMOUNT_BD) > 0 THEN G.P' +
        'RICE*CAST((R.AMOUNT_REAL - R.AMOUNT_BD) AS DOUBLE PRECISION) ELS' +
        'E 0 END OVER_SUMM'
      
        '           ,CASE WHEN (R.AMOUNT_REAL - R.AMOUNT_BD) < 0 THEN G.P' +
        'RICE*CAST((R.AMOUNT_BD - R.AMOUNT_REAL) AS DOUBLE PRECISION) ELS' +
        'E 0 END LOSS_SUMM'
      '    FROM REVISION R, G_PRODUCT G'
      
        '   WHERE R.G_PRODUCT = G.G_PRODUCT AND REVISION_PARENT = :REVISI' +
        'ON_PARENT_'
      '   ORDER BY R.REVISION')
    AfterPost = spReadAfterPost
    Transaction = tranRead
    Database = MainDM.dbMain
    UpdateTransaction = tranWrite
    AutoCommit = True
    Left = 48
    Top = 264
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
