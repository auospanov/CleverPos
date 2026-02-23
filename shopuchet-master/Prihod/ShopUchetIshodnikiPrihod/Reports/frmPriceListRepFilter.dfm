inherited PriceListRepFilterForm: TPriceListRepFilterForm
  Left = 780
  Top = 155
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 479
  ClientWidth = 391
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 397
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 372
    Height = 430
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ExplicitWidth = 372
    ExplicitHeight = 430
    object pcMain: TcxPageControl
      Left = 2
      Top = 2
      Width = 368
      Height = 426
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tsCommon
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 5
      ClientRectBottom = 426
      ClientRectRight = 368
      ClientRectTop = 25
      object tsCommon: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1054#1073#1097#1080#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1086#1090#1095#1077#1090#1072
        ImageIndex = 0
        object tlError: TcxDBTreeList
          Left = 0
          Top = 134
          Width = 368
          Height = 236
          Align = alClient
          Bands = <
            item
            end>
          DataController.DataSource = dsReadErr
          DataController.ParentField = 'G_PRODUCT_PAR'
          DataController.KeyField = 'G_PRODUCT'
          Enabled = False
          LookAndFeel.Kind = lfFlat
          Navigator.Buttons.CustomButtons = <>
          OptionsSelection.CellSelect = False
          OptionsView.CheckGroups = True
          RootValue = -1
          TabOrder = 1
          OnCustomDrawDataCell = tlErrorCustomDrawDataCell
          OnMouseDown = tlErrorMouseDown
          object clmnCheckCol: TcxDBTreeListColumn
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Caption.Text = #1042#1099#1073#1086#1088
            Width = 94
            Position.ColIndex = 0
            Position.RowIndex = 0
            Position.BandIndex = 0
            Summary.FooterSummaryItems = <>
            Summary.GroupFooterSummaryItems = <>
          end
          object clmnNAME: TcxDBTreeListColumn
            Caption.Text = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'NAME'
            Width = 265
            Position.ColIndex = 1
            Position.RowIndex = 0
            Position.BandIndex = 0
            Summary.FooterSummaryItems = <>
            Summary.GroupFooterSummaryItems = <>
          end
          object clmnG_PRODUCT: TcxDBTreeListColumn
            Visible = False
            DataBinding.FieldName = 'G_PRODUCT'
            Position.ColIndex = 2
            Position.RowIndex = 0
            Position.BandIndex = 0
            Summary.FooterSummaryItems = <>
            Summary.GroupFooterSummaryItems = <>
          end
        end
        object pn1: TPanel
          Left = 0
          Top = 0
          Width = 368
          Height = 134
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object ceIncludeNol: TcxCheckBox
            Left = 14
            Top = 65
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1053#1077' '#1074#1082#1083#1102#1095#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1089' '#1085#1091#1083#1077#1074#1099#1084' '#1086#1089#1090#1072#1090#1082#1086#1084
            Style.StyleController = dxEditStyleController
            TabOrder = 2
            Width = 279
          end
          object ceIncludeFew: TcxCheckBox
            Left = 14
            Top = 88
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1082#1083#1102#1095#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1090#1086#1074#1072#1088#1099' '#1089' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086#1084' '#1084#1077#1085#1100#1096#1077' 5'
            Style.StyleController = dxEditStyleController
            TabOrder = 3
            Width = 329
          end
          object cbSortByName: TcxCheckBox
            Left = 14
            Top = 112
            Hint = 
              #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1075#1072#1083#1086#1095#1082#1091', '#1095#1090#1086#1073#1099' '#1074#1082#1083#1102#1095#1080#1090#1100' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1091' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102' '#1090#1086#1074 +
              #1072#1088#1072', '#1072' '#1085#1077' '#1087#1086' '#1072#1088#1090#1080#1082#1091#1083#1091
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102' '#1090#1086#1074#1072#1088#1072
            ParentShowHint = False
            ShowHint = False
            Style.StyleController = dxEditStyleController
            TabOrder = 4
            Width = 262
          end
          object rgCategory: TcxRadioGroup
            Left = 16
            Top = 8
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080' '#1090#1086#1074#1072#1088#1086#1074
            ParentFont = False
            Properties.Columns = 2
            Properties.Items = <
              item
                Caption = #1042#1089#1077
              end
              item
                Caption = #1042#1099#1073#1086#1088#1086#1095#1085#1086
              end>
            ItemIndex = 0
            Style.BorderStyle = ebs3D
            Style.Font.Charset = RUSSIAN_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -12
            Style.Font.Name = 'Tahoma'
            Style.Font.Pitch = fpFixed
            Style.Font.Style = []
            Style.StyleController = dxEditStyleController
            Style.IsFontAssigned = True
            TabOrder = 0
            OnClick = rgCategoryClick
            Height = 49
            Width = 337
          end
          object pn2: TPanel
            Left = 456
            Top = 8
            Width = 57
            Height = 113
            TabOrder = 1
            object rbVybor: TRadioButton
              Left = -56
              Top = 47
              Width = 113
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1042#1099#1073#1086#1088#1086#1095#1085#1086
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -17
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object rbService: TRadioButton
              Left = -56
              Top = 26
              Width = 113
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1042#1089#1077' '#1091#1089#1083#1091#1075#1080
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -17
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object rbTovar: TRadioButton
              Left = -56
              Top = 55
              Width = 113
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1042#1089#1077' '#1090#1086#1074#1072#1088#1099
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -17
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object rbRashodniki: TRadioButton
              Left = -97
              Top = 69
              Width = 154
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1042#1089#1077' '#1088#1072#1089#1093#1086#1076'. '#1084'-'#1083#1099
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -17
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object rbAll: TRadioButton
              Left = -56
              Top = 34
              Width = 113
              Height = 17
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = #1042#1089#1077
              Checked = True
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -17
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              TabStop = True
            end
          end
        end
        object pnPostavshik: TPanel
          Left = 0
          Top = 370
          Width = 368
          Height = 31
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alBottom
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 2
          Visible = False
          object lb1: TLabel
            Left = 9
            Top = 9
            Width = 164
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          end
          object pePostavshik: TcxPopupEdit
            Left = 177
            Top = 7
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.PopupAutoSize = False
            Properties.PopupControl = PopupClientMultListForm.Owner
            Properties.PopupHeight = 246
            Properties.PopupWidth = 514
            Properties.OnCloseUp = pePostavshikPropertiesCloseUp
            Properties.OnInitPopup = pePostavshikPropertiesInitPopup
            Style.StyleController = dxEditStyleController
            Style.ButtonTransparency = ebtNone
            TabOrder = 0
            OnKeyPress = pePostavshikKeyPress
            Width = 185
          end
        end
      end
      object tsSklad: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1057#1082#1083#1072#1076#1099
        ImageIndex = 1
        TabVisible = False
        object Panel2: TPanel
          Left = 0
          Top = 361
          Width = 368
          Height = 40
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object btAll: TButton
            Left = 16
            Top = 8
            Width = 97
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
            TabOrder = 0
            OnClick = btAllClick
          end
          object btNone: TButton
            Left = 120
            Top = 8
            Width = 83
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1059#1073#1088#1072#1090#1100' '#1074#1089#1077
            TabOrder = 1
            OnClick = btNoneClick
          end
        end
        inline frmSklad: TGridFrame
          Left = 0
          Top = 0
          Width = 368
          Height = 361
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          ExplicitWidth = 368
          ExplicitHeight = 361
          inherited grMain: TcxGrid
            Width = 368
            Height = 361
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            ExplicitWidth = 368
            ExplicitHeight = 361
            inherited tvMain: TcxGridDBTableView
              DataController.KeyFieldNames = 'G_TOCHKA'
              inherited clmMainColumn2: TcxGridDBColumn
                Caption = #1057#1082#1083#1072#1076
                DataBinding.FieldName = 'NAME'
              end
              inherited clmMainColumn3: TcxGridDBColumn
                DataBinding.FieldName = 'G_TOCHKA'
              end
            end
          end
          inherited spReadFrame: TpFIBDataSet
            SelectSQL.Strings = (
              'SELECT * FROM G_TOCHKA_READ')
          end
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 223
    Top = 443
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ExplicitLeft = 223
    ExplicitTop = 443
  end
  inherited btnCancel: TcxButton
    Left = 305
    Top = 443
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ExplicitLeft = 305
    ExplicitTop = 443
  end
  inherited btHelp: TcxButton
    Top = 443
    ExplicitTop = 443
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 152
    Top = 192
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Top = 448
  end
  object dsReadErr: TDataSource
    DataSet = spRead
    Left = 64
    Top = 208
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 120
    Top = 192
  end
  object spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT SS.G_PRODUCT,'
      '       SS.NAME,'
      '       SS.G_PRODUCT_PAR'
      'FROM G_PRODUCT SS'
      'WHERE SS.IS_CATEGORY = 1'
      'ORDER BY 2, 1'
      ' ')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 32
    Top = 208
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spReadTochka: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_TOCHKA_READ')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 32
    Top = 240
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadTochka: TDataSource
    DataSet = spReadTochka
    Left = 63
    Top = 240
  end
end
