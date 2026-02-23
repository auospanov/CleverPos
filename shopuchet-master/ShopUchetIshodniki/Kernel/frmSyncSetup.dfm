inherited SyncSetupForm: TSyncSetupForm
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1080
  ClientHeight = 475
  ClientWidth = 617
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 623
  ExplicitHeight = 501
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 603
    Height = 433
    ExplicitWidth = 603
    ExplicitHeight = 433
    object pnlSecond: TPanel
      Left = 2
      Top = 2
      Width = 599
      Height = 429
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object Shape1: TShape
        Left = 6
        Top = 35
        Width = 176
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object shp7: TShape
        Left = 6
        Top = 11
        Width = 176
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lb4: TLabel
        Left = 13
        Top = 16
        Width = 159
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1086#1073#1084#1077#1085#1072' '#1092#1072#1081#1083#1072#1084#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp8: TShape
        Left = 181
        Top = 11
        Width = 407
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object Label2: TLabel
        Left = 13
        Top = 41
        Width = 100
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1086#1073#1084#1077#1085#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Shape2: TShape
        Left = 181
        Top = 36
        Width = 407
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object cbInterval: TcxComboBox
        Left = 186
        Top = 38
        ParentFont = False
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #1050#1072#1078#1076#1099#1077' 5 '#1084#1080#1085#1091#1090
          #1050#1072#1078#1076#1099#1077' 10 '#1084#1080#1085#1091#1090
          #1050#1072#1078#1076#1099#1077' 15 '#1084#1080#1085#1091#1090
          #1050#1072#1078#1076#1099#1077' 30 '#1084#1080#1085#1091#1090
          #1050#1072#1078#1076#1099#1081' 1 '#1095#1072#1089
          #1050#1072#1078#1076#1099#1077' 2 '#1095#1072#1089#1072
          #1050#1072#1078#1076#1099#1077' 4 '#1095#1072#1089#1072
          #1050#1072#1078#1076#1099#1077' 8 '#1095#1072#1089#1086#1074)
        Properties.ReadOnly = False
        Properties.OnChange = cbIntervalPropertiesChange
        Style.BorderStyle = ebsFlat
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.IsFontAssigned = True
        TabOrder = 0
        Text = #1050#1072#1078#1076#1099#1077' 10 '#1084#1080#1085#1091#1090
        Width = 399
      end
      object btnSyncFileName: TcxButtonEdit
        Left = 186
        Top = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ParentFont = False
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = btnSyncFileNamePropertiesButtonClick
        Style.Color = clWindow
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.StyleController = dxEditStyleController
        Style.ButtonTransparency = ebtNone
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 399
      end
    end
    object pnlFirst: TPanel
      Left = 2
      Top = 2
      Width = 599
      Height = 429
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object shp15: TShape
        Left = 9
        Top = 204
        Width = 212
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Label1: TLabel
        Left = 9
        Top = 246
        Width = 581
        Height = 168
        Caption = 
          #1047#1076#1077#1089#1100' '#1085#1091#1078#1085#1086' '#1074#1085#1077#1089#1090#1080' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1099', '#1082#1086#1090#1086#1088#1099#1077' '#1073#1091#1076#1091#1090' '#1091#1095#1072#1089#1090#1074#1086#1074#1072#1090#1100' '#1074' '#1086#1073#1084#1077#1085 +
          #1077' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1084#1077#1078#1076#1091' '#1089#1086#1073#1086#1081'. '#1055#1086#1088#1103#1076#1086#1082' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1086#1074' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1085#1077' '#1080#1084#1077#1077#1090'.' +
          #13#10#13#10#1044#1083#1103' '#1082#1072#1078#1076#1086#1075#1086' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072' '#1073#1091#1076#1077#1090' '#1087#1086#1076#1075#1086#1090#1086#1074#1083#1077#1085#1072' '#1086#1090#1076#1077#1083#1100#1085#1072#1103' '#1073#1072#1079#1072' '#1076#1072#1085 +
          #1085#1099#1093', '#1082#1086#1090#1086#1088#1091#1102' '#1087#1086#1090#1086#1084' '#1085#1091#1078#1085#1086' '#1073#1091#1076#1077#1090' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1085#1072' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1080#1081' '#1082#1086 +
          #1084#1087#1100#1102#1090#1077#1088'.'#13#10#13#10#1050#1088#1072#1090#1082#1072#1103' '#1080#1085#1089#1090#1088#1091#1082#1094#1080#1103':'#13#10'1. '#1044#1086#1073#1072#1074#1100#1090#1077' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1099', '#1082#1086#1090#1086#1088#1099#1077 +
          ' '#1074#1099' '#1093#1086#1090#1080#1090#1077' '#1089#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100'. '#1053#1072#1079#1099#1074#1072#1081#1090#1077' '#1080#1093', '#1090#1072#1082', '#1095#1090#1086#1073#1099' '#1042#1072#1084' '#1089#1072#1084#1080#1084' ' +
          #1074' '#1073#1091#1076#1091#1097#1077#1084' '#1073#1099#1083#1086' '#1087#1086#1085#1103#1090#1085#1086', '#1095#1090#1086' '#1101#1090#1086' '#1079#1072' '#1082#1086#1084#1087#1100#1102#1090#1077#1088';'#13#10'2. '#1053#1072#1078#1072#1074' '#1082#1085#1086#1087#1082#1091' "' +
          #1057#1076#1077#1083#1072#1090#1100' '#1090#1077#1082#1091#1097#1080#1084'", '#1091#1082#1072#1078#1080#1090#1077' '#1082#1086#1084#1087#1100#1102#1090#1077#1088', '#1079#1072' '#1082#1086#1090#1086#1088#1099#1084' '#1042#1099' '#1074' '#1076#1072#1085#1085#1099#1081' '#1084#1086#1084#1077 +
          #1085#1090' '#1089#1080#1076#1080#1090#1077';'#13#10'3. '#1059#1082#1072#1078#1080#1090#1077' '#1087#1072#1087#1082#1091' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1087#1086#1076#1075#1086#1090#1086#1074#1083#1077#1085#1099#1093' '#1073#1072#1079' '#1076#1072 +
          #1085#1085#1099#1093';'#13#10'4. '#1053#1072#1078#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' "'#1057#1086#1093#1088#1072#1085#1080#1090#1100'".'
        WordWrap = True
      end
      object lb9: TLabel
        Left = 16
        Top = 210
        Width = 196
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1073#1072#1079' '#1076#1072#1085#1085#1099#1093
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp18: TShape
        Left = 220
        Top = 204
        Width = 372
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object bedtFileName: TcxButtonEdit
        Left = 225
        Top = 207
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = bedtFileNamePropertiesButtonClick
        Style.StyleController = dxEditStyleController
        TabOrder = 0
        Width = 365
      end
      object gr1: TcxGrid
        Left = 0
        Top = 36
        Width = 599
        Height = 155
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object tvMain: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsRead
          DataController.KeyFieldNames = 'RecId'
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
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.GroupByBox = False
          Styles.Inactive = MainDM.stGridSelectedRow
          Styles.IncSearch = MainDM.stIncSearchStyle
          object tvMainColumn1: TcxGridDBColumn
            Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088
            DataBinding.FieldName = 'Name'
            Width = 314
          end
        end
        object lvMain: TcxGridLevel
          GridView = tvMain
        end
      end
      object pn3: TPanel
        Left = 0
        Top = 0
        Width = 599
        Height = 36
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        object btnIns: TBitBtn
          Left = 12
          Top = 5
          Width = 103
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aCompIns
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 0
        end
        object btnDel: TBitBtn
          Left = 115
          Top = 5
          Width = 103
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Action = aCompDel
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 1
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 411
    Top = 443
    Width = 112
    Caption = #1044#1072#1083#1077#1077' >'
    ExplicitLeft = 411
    ExplicitTop = 443
    ExplicitWidth = 112
  end
  inherited btnCancel: TcxButton
    Left = 535
    Top = 443
    ExplicitLeft = 535
    ExplicitTop = 443
  end
  object btBack: TcxButton [3]
    Left = 318
    Top = 443
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '< '#1053#1072#1079#1072#1076
    Enabled = False
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    TabOrder = 3
    OnClick = btBackClick
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object alChild: TActionList
    Images = MainDM.imMain
    Left = 48
    Top = 80
    object aCompIns: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 150
      OnExecute = aCompInsExecute
    end
    object aCompDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      ImageIndex = 149
      ShortCut = 118
      OnExecute = aCompDelExecute
    end
    object aCreateDatabases: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      Enabled = False
    end
  end
  object mdComps: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 184
    Top = 88
    object mdCompsName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object mdCompsid: TIntegerField
      FieldName = 'id'
    end
  end
  object dsRead: TDataSource
    DataSet = mdComps
    Left = 224
    Top = 88
  end
end
