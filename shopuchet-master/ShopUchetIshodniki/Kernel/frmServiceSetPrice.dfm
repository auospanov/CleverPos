inherited ServiceSetPriceForm: TServiceSetPriceForm
  Left = 468
  Top = 144
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 501
  ClientWidth = 634
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  inherited btnOk: TBitBtn
    Left = 469
    Top = 469
  end
  inherited btnCancel: TBitBtn
    Left = 551
    Top = 469
  end
  inherited Panel1: TPanel
    Width = 618
    Height = 454
    object PageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 614
      Height = 450
      ActivePage = tsDates
      Align = alClient
      TabOrder = 0
      OnChange = PageControlChange
      ClientRectBottom = 450
      ClientRectRight = 614
      ClientRectTop = 24
      object tsDates: TcxTabSheet
        Caption = #1044#1072#1090#1099
        ImageIndex = 0
        object pnOfficial: TPanel
          Left = 112
          Top = 265
          Width = 375
          Height = 31
          BevelOuter = bvNone
          ParentBackground = True
          ParentColor = True
          TabOrder = 0
          object Shape6: TShape
            Left = 2
            Top = 3
            Width = 107
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label4: TLabel
            Left = 12
            Top = 8
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
          object Shape5: TShape
            Left = 108
            Top = 3
            Width = 214
            Height = 26
            Pen.Color = clBtnShadow
          end
          object leIspolnitel: TdxLookupEdit
            Left = 112
            Top = 5
            Width = 205
            Enabled = False
            Style.BorderStyle = xbsFlat
            TabOrder = 0
            OnChange = leIspolnitelChange
            ListFieldName = 'FIO_DOC'
            KeyFieldName = 'G_OFFICIAL'
            ListSource = dsIspolnitel
            LookupKeyValue = Null
          end
          object cbOfficial: TCheckBox
            Left = 327
            Top = 8
            Width = 41
            Height = 17
            Caption = #1042#1089#1077
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = cbOfficialClick
          end
        end
        object pnClient: TPanel
          Left = 112
          Top = 238
          Width = 375
          Height = 30
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Shape17: TShape
            Left = 2
            Top = 2
            Width = 107
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label3: TLabel
            Left = 12
            Top = 8
            Width = 41
            Height = 14
            Caption = #1050#1083#1080#1077#1085#1090
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape18: TShape
            Left = 108
            Top = 2
            Width = 214
            Height = 26
            Pen.Color = clBtnShadow
          end
          object cbClient: TCheckBox
            Left = 327
            Top = 8
            Width = 41
            Height = 17
            Caption = #1042#1089#1077
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = cbClientClick
          end
          object peClient: TdxPopupEdit
            Left = 112
            Top = 4
            Width = 205
            Enabled = False
            TabOrder = 1
            OnKeyPress = peClientKeyPress
            PopupControl = PopupListForm.pnlMain
            OnCloseUp = peClientCloseUp
            OnInitPopup = peClientInitPopup
          end
        end
        object pnPayment: TPanel
          Left = 112
          Top = 209
          Width = 375
          Height = 29
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object Shape13: TShape
            Left = 2
            Top = 2
            Width = 107
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label7: TLabel
            Left = 11
            Top = 8
            Width = 90
            Height = 14
            Caption = #1057#1087#1086#1089#1086#1073' '#1088#1072#1089#1095#1077#1090#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape14: TShape
            Left = 108
            Top = 2
            Width = 214
            Height = 26
            Pen.Color = clBtnShadow
          end
          object cbPayment: TCheckBox
            Left = 327
            Top = 4
            Width = 41
            Height = 25
            Caption = #1042#1089#1077
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = cbPaymentClick
          end
          object cbxPayment: TComboBox
            Left = 112
            Top = 4
            Width = 205
            Height = 22
            Enabled = False
            ItemHeight = 14
            TabOrder = 1
            Items.Strings = (
              #1053#1072#1083#1080#1095#1085#1099#1081
              #1041#1077#1079#1085#1072#1083#1080#1095#1085#1099#1081)
          end
        end
        object pnTime: TPanel
          Left = 435
          Top = 133
          Width = 108
          Height = 76
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object ceTime: TCheckBox
            Left = 2
            Top = 3
            Width = 102
            Height = 17
            Caption = #1059#1082#1072#1079#1072#1090#1100' '#1074#1088#1077#1084#1103
            TabOrder = 0
            OnClick = ceTimeClick
          end
          object edTimeBegin: TcxTimeEdit
            Left = 2
            Top = 24
            Width = 76
            Height = 22
            EditValue = 0.375d
            Enabled = False
            Properties.TimeFormat = tfHourMin
            Style.BorderStyle = ebs3D
            TabOrder = 1
          end
          object edTimeEnd: TcxTimeEdit
            Left = 2
            Top = 51
            Width = 76
            Height = 22
            EditValue = 0.75d
            Enabled = False
            Properties.TimeFormat = tfHourMin
            Style.BorderStyle = ebs3D
            TabOrder = 2
          end
        end
        object pnDate: TPanel
          Left = 113
          Top = 96
          Width = 322
          Height = 113
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Shape2: TShape
            Left = 1
            Top = 86
            Width = 107
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape1: TShape
            Left = 1
            Top = 61
            Width = 107
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label1: TLabel
            Left = 11
            Top = 67
            Width = 69
            Height = 14
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 11
            Top = 92
            Width = 63
            Height = 14
            Caption = #1044#1072#1090#1072' '#1082#1086#1085#1094#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape3: TShape
            Left = 107
            Top = 61
            Width = 214
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape4: TShape
            Left = 107
            Top = 86
            Width = 214
            Height = 26
            Pen.Color = clBtnShadow
          end
          object byDay: TRadioButton
            Left = 1
            Top = 11
            Width = 113
            Height = 17
            Caption = #1047#1072' '#1076#1077#1085#1100
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = True
            OnClick = byDayClick
          end
          object byMonth: TRadioButton
            Left = 1
            Top = 35
            Width = 113
            Height = 17
            Caption = #1047#1072' '#1084#1077#1089#1103#1094
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = byMonthClick
          end
          object edDate: TcxDateEdit
            Left = 111
            Top = 63
            Width = 205
            Height = 22
            Properties.Alignment.Horz = taRightJustify
            Properties.InputKind = ikMask
            Properties.UseLeftAlignmentOnEditing = False
            Style.BorderStyle = ebs3D
            Style.ButtonStyle = bts3D
            TabOrder = 2
            OnExit = edDateExit
          end
          object edEndDate: TcxDateEdit
            Left = 111
            Top = 88
            Width = 205
            Height = 22
            Enabled = False
            Properties.Alignment.Horz = taRightJustify
            Properties.InputKind = ikMask
            Properties.UseLeftAlignmentOnEditing = False
            Style.BorderStyle = ebs3D
            Style.ButtonStyle = bts3D
            TabOrder = 3
          end
          object byYear: TRadioButton
            Left = 121
            Top = 11
            Width = 113
            Height = 17
            Caption = #1047#1072' '#1075#1086#1076
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = byYearClick
          end
          object byPeriod: TRadioButton
            Left = 121
            Top = 35
            Width = 145
            Height = 17
            Caption = #1047#1072' '#1083#1102#1073#1086#1081' '#1087#1077#1088#1080#1086#1076
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = byPeriodClick
          end
        end
        object pnReal: TPanel
          Left = 109
          Top = 297
          Width = 335
          Height = 33
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 5
          object Shape7: TShape
            Left = 5
            Top = 2
            Width = 132
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label5: TLabel
            Left = 12
            Top = 8
            Width = 115
            Height = 14
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1072#1082#1083#1072#1076#1085#1099#1077
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape8: TShape
            Left = 136
            Top = 2
            Width = 189
            Height = 26
            Pen.Color = clBtnShadow
          end
          object ComboBox: TComboBox
            Left = 140
            Top = 4
            Width = 180
            Height = 22
            ItemHeight = 14
            ItemIndex = 0
            TabOrder = 0
            Text = #1053#1077#1086#1087#1083#1072#1095#1077#1085#1085#1099#1077
            Items.Strings = (
              #1053#1077#1086#1087#1083#1072#1095#1077#1085#1085#1099#1077
              #1054#1087#1083#1072#1095#1077#1085#1085#1099#1077
              #1042#1086#1079#1074#1088#1072#1097#1077#1085#1085#1099#1077
              #1042#1089#1077)
          end
        end
      end
      object tsTovar: TcxTabSheet
        Caption = #1058#1086#1074#1072#1088#1099'/'#1082#1072#1090#1077#1075#1086#1088#1080#1080
        ImageIndex = 1
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 614
          Height = 426
          Align = alClient
          Caption = 'Panel3'
          ParentColor = True
          TabOrder = 0
          object Panel4: TPanel
            Left = 313
            Top = 1
            Width = 300
            Height = 424
            Align = alClient
            BevelOuter = bvLowered
            Caption = 'Panel4'
            ParentColor = True
            TabOrder = 0
            object Panel6: TPanel
              Left = 1
              Top = 1
              Width = 298
              Height = 41
              Align = alTop
              TabOrder = 0
              object Label10: TLabel
                Left = 66
                Top = 12
                Width = 40
                Height = 16
                Caption = #1055#1086#1080#1089#1082
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clNavy
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object cbTovAll: TCheckBox
                Left = 9
                Top = 12
                Width = 40
                Height = 17
                Caption = #1042#1089#1077
                Checked = True
                Enabled = False
                State = cbChecked
                TabOrder = 0
                OnClick = cbTovAllClick
              end
              object edSearchTovar: TEdit
                Left = 109
                Top = 10
                Width = 184
                Height = 22
                CharCase = ecLowerCase
                MaxLength = 13
                TabOrder = 1
                OnChange = edSearchTovarChange
              end
            end
            inline TovaryFrame: TTreeFrame
              Left = 1
              Top = 42
              Width = 298
              Height = 381
              Align = alClient
              TabOrder = 1
              inherited tlCommon: TdxTreeList
                Width = 298
                Height = 381
                inherited TreeListCheck: TdxTreeListCheckColumn
                  Width = 36
                end
                inherited TreeListEntityId: TdxTreeListColumn
                  Width = 137
                end
                inherited TreeListEnabled: TdxTreeListCheckColumn
                  Width = 87
                end
                inherited TreeListReturn: TdxTreeListCheckColumn
                  Width = 87
                end
              end
              inherited spReadFrame: TpFIBDataSet
                SelectSQL.Strings = (
                  'SELECT SS.G_PRODUCT ID,'
                  '       SS.NAME,'
                  '       SS.ARTICUL,'
                  '       SS.BARCODE'
                  'FROM G_PRODUCT SS'
                  'WHERE SS.IS_CATEGORY = 0'
                  
                    'AND (CAST(:G_CATEGORY_ AS VARCHAR(1000)) CONTAINING '#39'~'#39'||SS.G_PR' +
                    'ODUCT_PAR||'#39'~'#39
                  '     OR '
                  '     CAST(:G_CATEGORY_ AS VARCHAR(1000)) = '#39#39')'
                  'ORDER BY 2, 1')
                Transaction = MainDM.tranMainRead
                UpdateTransaction = MainDM.tranMainRead
              end
            end
          end
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 304
            Height = 424
            Align = alLeft
            BevelOuter = bvLowered
            Caption = 'Panel4'
            ParentColor = True
            TabOrder = 1
            object Panel7: TPanel
              Left = 1
              Top = 1
              Width = 302
              Height = 41
              Align = alTop
              TabOrder = 0
              object cbCatAll: TCheckBox
                Left = 8
                Top = 12
                Width = 41
                Height = 17
                Caption = #1042#1089#1077
                Checked = True
                State = cbChecked
                TabOrder = 0
                OnClick = cbCatAllClick
              end
            end
            inline TovCatFrame: TTreeFrame
              Left = 1
              Top = 42
              Width = 302
              Height = 381
              Align = alClient
              TabOrder = 1
              inherited tlCommon: TdxTreeList
                Width = 302
                Height = 381
                Options = [aoColumnSizing, aoColumnMoving, aoEditing, aoTabThrough, aoRowSelect, aoStoreToRegistry]
                OnClick = TovCatFrametlCommonClick
                inherited TreeListCheck: TdxTreeListCheckColumn
                  Width = 37
                end
                inherited TreeListEntityId: TdxTreeListColumn
                  Width = 138
                end
                inherited TreeListEnabled: TdxTreeListCheckColumn
                  Width = 87
                end
                inherited TreeListReturn: TdxTreeListCheckColumn
                  Width = 87
                end
              end
              inherited spReadFrame: TpFIBDataSet
                SelectSQL.Strings = (
                  'SELECT * FROM ('
                  'WITH RECURSIVE TREE'
                  '  AS (SELECT T.G_PRODUCT ID,'
                  '             replace(T.NAME, '#39' '#39', '#39#39') PATH,'
                  '             T.NAME NAME,'
                  '             CAST('#39#39' AS VARCHAR(255)) AS indent'
                  '      FROM G_PRODUCT T'
                  '     WHERE T.G_PRODUCT_PAR IS NULL'
                  '    UNION ALL'
                  '    SELECT T.G_PRODUCT ID,'
                  '           GG.PATH||replace(T.NAME, '#39' '#39', '#39#39') PATH,'
                  '           T.NAME NAME,'
                  '           GG.indent || rpad('#39#39', 3) AS indent'
                  
                    '      FROM G_PRODUCT T INNER JOIN TREE GG ON GG.ID = T.G_PRODUCT' +
                    '_PAR'
                  '     WHERE T.IS_CATEGORY = 1'
                  '    )'
                  ' SELECT ID,'
                  '        PATH,'
                  '        Indent || NAME AS NAME FROM TREE)'
                  'ORDER BY 2, 1'
                  ' ')
                Transaction = MainDM.tranMainRead
                UpdateTransaction = MainDM.tranMainRead
              end
            end
          end
          object splMenu: TcxSplitter
            Left = 305
            Top = 1
            Width = 8
            Height = 424
            HotZoneClassName = 'TcxSimpleStyle'
            HotZone.SizePercent = 32
            AutoPosition = False
            PositionAfterOpen = 150
            AutoSnap = True
            ResizeUpdate = True
            Control = Panel4
            Color = clBtnFace
            ParentColor = False
          end
        end
      end
      object tsSklad: TcxTabSheet
        Caption = #1057#1082#1083#1072#1076#1099
        ImageIndex = 1
        TabVisible = False
        object tlSklad: TdxDBTreeList
          Left = 0
          Top = 0
          Width = 614
          Height = 385
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'G_TOCHKA'
          ParentField = 'G_TOCHKA'
          Align = alClient
          TabOrder = 0
          OnClick = tlSkladClick
          DataSource = dsReadTochka
          ShowHeader = False
          TreeLineColor = clGrayText
          object CheckCol: TdxDBTreeListCheckColumn
            Width = 46
            BandIndex = 0
            RowIndex = 0
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object tlSkladNAME: TdxDBTreeListMaskColumn
            Width = 150
            BandIndex = 0
            RowIndex = 0
            FieldName = 'NAME'
          end
          object G_TOCHKA: TdxDBTreeListColumn
            Visible = False
            BandIndex = 0
            RowIndex = 0
            FieldName = 'G_TOCHKA'
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 385
          Width = 614
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btAll: TButton
            Left = 16
            Top = 8
            Width = 97
            Height = 25
            Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
            TabOrder = 0
            OnClick = btAllClick
          end
          object btNone: TButton
            Left = 120
            Top = 8
            Width = 83
            Height = 25
            Caption = #1059#1073#1088#1072#1090#1100' '#1074#1089#1077
            TabOrder = 1
            OnClick = btNoneClick
          end
        end
      end
    end
  end
  inherited btHelp: TBitBtn
    Top = 469
  end
  inherited dxEditStyleController: TdxEditStyleController
    Left = 120
    Top = 464
  end
  inherited dxCheckEditStyleController: TdxCheckEditStyleController
    Left = 152
    Top = 464
  end
  inherited ApplicationEvents1: TApplicationEvents
    OnActivate = nil
    Left = 96
    Top = 464
  end
  inherited ActionList: TActionList
    Left = 184
    Top = 464
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
    Left = 280
    Top = 16
  end
  object spIspolnitel: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_OFFICIAL_LIST')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 272
    Top = 264
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsIspolnitel: TDataSource
    DataSet = spIspolnitel
    Left = 304
    Top = 263
  end
  object spReadTochka: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_TOCHKA_READ')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 312
    Top = 16
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadTochka: TDataSource
    DataSet = spReadTochka
    Left = 343
    Top = 16
  end
  object TimerTovar: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerTovarTimer
    Left = 360
    Top = 200
  end
end
