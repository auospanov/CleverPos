inherited KassaForm: TKassaForm
  Left = 418
  Top = 205
  Caption = #1056#1072#1089#1093#1086#1076
  ClientHeight = 460
  ClientWidth = 481
  OnClose = FormClose
  ExplicitWidth = 487
  ExplicitHeight = 486
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 461
    Height = 413
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitWidth = 461
    ExplicitHeight = 413
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 457
      Height = 409
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object pnlSpecial: TPanel
        Left = 0
        Top = 68
        Width = 457
        Height = 193
        Align = alBottom
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        object pnlOplataDolga: TPanel
          Left = 0
          Top = 0
          Width = 457
          Height = 193
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          Visible = False
          object Shape13: TShape
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
          object Label7: TLabel
            Left = 18
            Top = 15
            Width = 41
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1050#1083#1080#1077#1085#1090
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape14: TShape
            Left = 183
            Top = 9
            Width = 268
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object leClient: TcxLookupComboBox
            Left = 189
            Top = 12
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
            Properties.ListSource = dsClient
            Properties.OnChange = leClientPropertiesChange
            Style.BorderStyle = ebsFlat
            Style.StyleController = dxEditStyleController
            TabOrder = 0
            Width = 258
          end
          object grMain: TcxGrid
            Left = 0
            Top = 48
            Width = 457
            Height = 128
            Align = alBottom
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 1
            LookAndFeel.Kind = lfFlat
            object tvMain: TcxGridDBTableView
              OnMouseDown = tvMainMouseDown
              Navigator.Buttons.CustomButtons = <>
              OnCustomDrawCell = tvMainCustomDrawCell
              DataController.DataSource = dsReadDolg
              DataController.KeyFieldNames = 'ID'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsSelection.CellSelect = False
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              Styles.Inactive = MainDM.stGridSelectedRow
              object clmMainColumn1: TcxGridDBColumn
                Caption = #1042#1099#1073#1086#1088
                PropertiesClassName = 'TcxCheckBoxProperties'
                HeaderAlignmentHorz = taCenter
              end
              object clmMainColumn2: TcxGridDBColumn
                Caption = #1044#1072#1090#1072' '#1074#1080#1079#1080#1090#1072
                DataBinding.FieldName = 'Z_DATE'
                HeaderAlignmentHorz = taCenter
                Width = 91
              end
              object clmMainColumn3: TcxGridDBColumn
                DataBinding.FieldName = 'ID'
                Visible = False
                HeaderAlignmentHorz = taCenter
              end
              object clmMainColumn4: TcxGridDBColumn
                Caption = #1044#1077#1090#1072#1083#1080
                DataBinding.FieldName = 'DTLS'
                HeaderAlignmentHorz = taCenter
                Width = 233
              end
              object clmMainColumn5: TcxGridDBColumn
                Caption = #1057#1091#1084#1084#1072' '#1074#1080#1079#1080#1090#1072
                DataBinding.FieldName = 'SUMM'
                Visible = False
                HeaderAlignmentHorz = taCenter
                Width = 94
              end
              object clmMainColumn6: TcxGridDBColumn
                Caption = #1054#1087#1083#1072#1095#1077#1085#1086
                DataBinding.FieldName = 'SUMM_FACT'
                Visible = False
                HeaderAlignmentHorz = taCenter
              end
              object clmMainColumn7: TcxGridDBColumn
                Caption = #1044#1086#1083#1075
                DataBinding.FieldName = 'OSTATOK'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00'
                HeaderAlignmentHorz = taCenter
              end
            end
            object lvMain: TcxGridLevel
              GridView = tvMain
            end
          end
          object pnl1: TPanel
            Left = 0
            Top = 176
            Width = 457
            Height = 17
            Align = alBottom
            BevelOuter = bvNone
            Color = clHighlightText
            ParentBackground = False
            TabOrder = 2
          end
        end
        object pnlOfficial: TPanel
          Left = 0
          Top = 0
          Width = 457
          Height = 193
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 1
          Visible = False
          object shp5: TShape
            Left = 8
            Top = 58
            Width = 176
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object shp6: TShape
            Left = 8
            Top = 83
            Width = 176
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object shp9: TShape
            Left = 8
            Top = 33
            Width = 177
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object shpOffiical: TShape
            Left = 8
            Top = 8
            Width = 177
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object lbOffiical: TLabel
            Left = 18
            Top = 14
            Width = 60
            Height = 14
            Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object shpOffiical1: TShape
            Left = 183
            Top = 8
            Width = 268
            Height = 26
            Pen.Color = clBtnShadow
          end
          object lb3: TLabel
            Left = 29
            Top = 64
            Width = 121
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1087#1077#1088#1080#1086#1076#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object lb4: TLabel
            Left = 29
            Top = 89
            Width = 115
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1044#1072#1090#1072' '#1082#1086#1085#1094#1072' '#1087#1077#1088#1080#1086#1076#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object shp7: TShape
            Left = 183
            Top = 58
            Width = 268
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object shp8: TShape
            Left = 183
            Top = 83
            Width = 268
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object lb5: TLabel
            Left = 18
            Top = 39
            Width = 132
            Height = 14
            Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1079#1072#1088#1087#1083#1072#1090#1091' '#1079#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object shp10: TShape
            Left = 183
            Top = 33
            Width = 268
            Height = 26
            Pen.Color = clBtnShadow
          end
          object leOfficial: TcxLookupComboBox
            Left = 189
            Top = 11
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.DropDownListStyle = lsFixedList
            Properties.GridMode = True
            Properties.KeyFieldNames = 'g_official'
            Properties.ListColumns = <
              item
                FieldName = 'NAME'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dsOfficial
            Properties.OnChange = leOfficialPropertiesChange
            Style.BorderStyle = ebsFlat
            TabOrder = 0
            Width = 257
          end
          object edBeginDate: TcxDateEdit
            Left = 187
            Top = 60
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Properties.Alignment.Horz = taRightJustify
            Properties.InputKind = ikMask
            Properties.UseLeftAlignmentOnEditing = False
            Style.BorderStyle = ebsFlat
            Style.ButtonStyle = btsFlat
            TabOrder = 2
            Width = 259
          end
          object edEndDate: TcxDateEdit
            Left = 187
            Top = 85
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            Properties.Alignment.Horz = taRightJustify
            Properties.InputKind = ikMask
            Properties.UseLeftAlignmentOnEditing = False
            Style.BorderStyle = ebsFlat
            Style.ButtonStyle = btsFlat
            TabOrder = 3
            Width = 259
          end
          object cbPeriod: TcxComboBox
            Left = 189
            Top = 35
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              #1044#1077#1085#1100
              #1053#1077#1076#1077#1083#1102
              #1052#1077#1089#1103#1094)
            Properties.OnChange = cbPeriodPropertiesChange
            Style.StyleController = dxEditStyleController
            TabOrder = 1
            Text = #1044#1077#1085#1100
            Width = 257
          end
          object btnCalc: TcxButton
            Left = 45
            Top = 126
            Width = 153
            Height = 25
            Hint = #1056#1072#1089#1087#1077#1095#1072#1090#1072#1090#1100' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1095#1077#1082' '#1085#1072' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1084' '#1088#1077#1075#1080#1089#1090#1088#1072#1090#1086#1088#1077
            Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
            LookAndFeel.Kind = lfFlat
            LookAndFeel.NativeStyle = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = btnCalcClick
          end
          object btnRep: TcxButton
            Left = 256
            Top = 126
            Width = 153
            Height = 25
            Hint = #1056#1072#1089#1087#1077#1095#1072#1090#1072#1090#1100' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1095#1077#1082' '#1085#1072' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1084' '#1088#1077#1075#1080#1089#1090#1088#1072#1090#1086#1088#1077
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1086#1090#1095#1077#1090
            LookAndFeel.Kind = lfFlat
            LookAndFeel.NativeStyle = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = btnRepClick
          end
        end
      end
      object pnlSumm: TPanel
        Left = 0
        Top = 261
        Width = 457
        Height = 148
        Align = alBottom
        BevelOuter = bvNone
        Color = clHighlightText
        ParentBackground = False
        TabOrder = 2
        object shp12: TShape
          Left = 8
          Top = 8
          Width = 176
          Height = 26
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object shp1: TShape
          Left = 8
          Top = 33
          Width = 176
          Height = 26
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object shp3: TShape
          Left = 8
          Top = 58
          Width = 176
          Height = 70
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object lb1: TLabel
          Left = 18
          Top = 39
          Width = 35
          Height = 14
          Caption = #1057#1091#1084#1084#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object shp2: TShape
          Left = 183
          Top = 33
          Width = 268
          Height = 26
          Pen.Color = clBtnShadow
        end
        object lb2: TLabel
          Left = 18
          Top = 85
          Width = 71
          Height = 14
          Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object shp4: TShape
          Left = 183
          Top = 58
          Width = 268
          Height = 70
          Pen.Color = clBtnShadow
        end
        object lb7: TLabel
          Left = 18
          Top = 14
          Width = 26
          Height = 14
          Caption = #1044#1072#1090#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object shp14: TShape
          Left = 183
          Top = 8
          Width = 268
          Height = 26
          Pen.Color = clBtnShadow
        end
        object edSumm: TcxCurrencyEdit
          Left = 189
          Top = 36
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          EditValue = 0c
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '0.00'
          Properties.UseLeftAlignmentOnEditing = False
          Properties.UseThousandSeparator = True
          Style.StyleController = dxEditStyleController
          Style.TransparentBorder = True
          TabOrder = 0
          Width = 257
        end
        object mMemo: TcxMemo
          Left = 189
          Top = 62
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.MaxLength = 200
          Style.StyleController = dxEditStyleController
          TabOrder = 1
          Height = 62
          Width = 257
        end
        object edDate: TcxDateEdit
          Left = 189
          Top = 10
          Properties.Alignment.Horz = taRightJustify
          Properties.InputKind = ikMask
          Properties.UseLeftAlignmentOnEditing = False
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          Style.ButtonStyle = btsDefault
          TabOrder = 2
          Width = 257
        end
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 457
        Height = 68
        Align = alClient
        BevelOuter = bvNone
        Color = clHighlightText
        ParentBackground = False
        TabOrder = 0
        object shpPayment: TShape
          Left = 8
          Top = 34
          Width = 177
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object shp11: TShape
          Left = 8
          Top = 9
          Width = 177
          Height = 26
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object lbStatyaName: TLabel
          Left = 18
          Top = 15
          Width = 94
          Height = 14
          Caption = #1057#1090#1072#1090#1100#1103' '#1088#1072#1089#1093#1086#1076#1086#1074
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbPayment: TLabel
          Left = 19
          Top = 41
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
        object shp13: TShape
          Left = 183
          Top = 9
          Width = 268
          Height = 26
          Pen.Color = clBtnShadow
        end
        object shpPayment1: TShape
          Left = 183
          Top = 34
          Width = 268
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object btnInsStatya: TSpeedButton
          Left = 418
          Top = 11
          Width = 26
          Height = 22
          Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1089#1090#1072#1090#1100#1102
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
          OnClick = btnInsStatyaClick
        end
        object leStatya: TcxLookupComboBox
          Left = 189
          Top = 11
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.DropDownListStyle = lsFixedList
          Properties.GridMode = True
          Properties.KeyFieldNames = 'G_PRIHOD_RASHOD'
          Properties.ListColumns = <
            item
              FieldName = 'NAME'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = dsReadStatya
          Properties.OnChange = leStatyaPropertiesChange
          Style.BorderStyle = ebsFlat
          TabOrder = 0
          Width = 225
        end
        object cbPaymentType: TcxComboBox
          Left = 189
          Top = 36
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            #1053#1072#1083#1080#1095#1085#1099#1081
            #1041#1077#1079#1085#1072#1083#1080#1095#1085#1099#1081)
          Properties.OnChange = cbPaymentTypePropertiesChange
          Style.StyleController = dxEditStyleController
          TabOrder = 1
          Text = #1053#1072#1083#1080#1095#1085#1099#1081
          Width = 257
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 311
    Top = 428
    ExplicitLeft = 311
    ExplicitTop = 428
  end
  inherited btnCancel: TcxButton
    Left = 394
    Top = 428
    ExplicitLeft = 394
    ExplicitTop = 428
  end
  inherited btHelp: TcxButton
    Top = 428
    ExplicitTop = 428
  end
  object btnPrintOnFr: TcxButton [4]
    Left = 136
    Top = 427
    Width = 153
    Height = 25
    Hint = #1056#1072#1089#1087#1077#1095#1072#1090#1072#1090#1100' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1095#1077#1082' '#1085#1072' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1084' '#1088#1077#1075#1080#1089#1090#1088#1072#1090#1086#1088#1077
    Anchors = [akLeft, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100' '#1085#1072' '#1092#1080#1089#1082'. '#1088#1077#1075'-'#1088#1077
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnPrintOnFrClick
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 344
    Top = 424
  end
  inherited dxEditStyleController: TcxEditStyleController
    Left = 112
    Top = 424
    PixelsPerInch = 96
  end
  inherited cxEditRepository: TcxEditRepository
    Left = 32
    Top = 426
  end
  inherited ActionList: TActionList
    Left = 56
    Top = 424
  end
  inherited tranRead: TpFIBTransaction
    Left = 48
    Top = 424
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE K_GET_KASSA (?KASSA_)')
    StoredProcName = 'K_GET_KASSA'
    Left = 248
    Top = 424
  end
  inherited tranWrite: TpFIBTransaction
    Left = 88
    Top = 424
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE K_INS_KASSA (?ACTION_, ?G_PRIHOD_RASHOD_, ?SUM' +
        'M_, ?ACTION_DATE_, ?NOTE_, ?ZAKAZ_, ?SKLAD_, ?G_PAYMENT_TYPE_, ?' +
        'G_TOCHKA_, ?UPLOAD_TO_EXT_APP_, ?G_OFFICIAL_, ?USER_ID_, ?LOG_BO' +
        'DY_)')
    StoredProcName = 'K_INS_KASSA'
    Left = 280
    Top = 424
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE K_UPD_KASSA (?KASSA_, ?ACTION_, ?G_PRIHOD_RASH' +
        'OD_, ?SUMM_, ?ACTION_DATE_, ?NOTE_, ?ZAKAZ_, ?SKLAD_, ?G_PAYMENT' +
        '_TYPE_, ?UPLOAD_TO_EXT_APP_, ?G_OFFICIAL_, ?USER_ID_, ?LOG_BODY_' +
        ')')
    StoredProcName = 'K_UPD_KASSA'
    Left = 312
    Top = 424
  end
  object dsReadStatya: TDataSource
    DataSet = spReadStatya
    Left = 408
    Top = 8
  end
  object spReadStatya: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from G_READ_G_PRIHOD_RASHOD_LIST(?ACTION_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 368
    Top = 8
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spGetOstatok: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE K_GET_KASSA_SUMM (?G_TOCHKA_, ?DATE_)')
    StoredProcName = 'K_GET_KASSA_SUMM'
    Left = 304
    Top = 22
  end
  object spOfficial: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT g.g_official, g.fm||'#39' '#39'||coalesce(g.nm, '#39#39') name'
      'from g_official g')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 256
    Top = 80
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsOfficial: TDataSource
    DataSet = spOfficial
    Left = 296
    Top = 80
  end
  object spClient: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT C.G_CLIENT, C.NAME ||'#39', '#39'||COALESCE(C.PHONE, '#39#39') NAME'
      '  FROM G_CLIENT C,'
      
        '       (SELECT G_CLIENT FROM ZAKAZ WHERE IS_PAYED_ALL = 0 GROUP ' +
        'BY G_CLIENT) Z'
      ' WHERE Z.G_CLIENT = C.G_CLIENT'
      'ORDER BY NAME')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 112
    Top = 80
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsClient: TDataSource
    DataSet = spClient
    Left = 144
    Top = 80
  end
  object spReadDolg: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT Z.Z_DATE,'
      '       SUBSTRING((SELECT'
      
        '                  LIST(G.NAME||'#39'('#39'||CAST(D.AMOUNT AS NUMERIC(15,' +
        '2))||'#39')'#39', '#39', '#39')'
      '                FROM ZAKAZ_DETAILS D, G_PRODUCT G'
      '                WHERE D.G_PRODUCT = G.G_PRODUCT'
      '                  AND D.ZAKAZ = Z.ZAKAZ'
      '                  GROUP BY ZAKAZ) FROM 1 FOR 300) DTLS,'
      '       Z.SUMM,'
      '       Z.SUMM_FACT + Z.SUMM_BONUS SUMM_FACT,'
      '       Z.SUMM - Z.SUMM_FACT - Z.SUMM_BONUS OSTATOK,'
      '       Z.ZAKAZ ID'
      '  FROM ZAKAZ Z'
      ' WHERE Z.G_CLIENT = :G_CLIENT_'
      '   AND Z.IS_PAYED_ALL = 0'
      '   AND Z.ZAKAZ <> :ZAKAZ_'
      'ORDER BY 1')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 184
    Top = 80
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadDolg: TDataSource
    DataSet = spReadDolg
    Left = 216
    Top = 80
  end
  object spGetSalary: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT SUM(ZD.SALES_COMM) SUMMA'
      '  FROM ZAKAZ Z,'
      '       ZAKAZ_DETAILS ZD'
      ' WHERE Z.Z_DATE BETWEEN :DATE_BEGIN_ AND :DATE_END_'
      '   AND Z.ZAKAZ = ZD.ZAKAZ'
      '   AND ZD.SALES_COMM > 0'
      '   AND Z.G_OFFICIAL = :G_OFFICIAL_'
      '  GROUP BY Z.G_OFFICIAL')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 40
    Top = 192
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
