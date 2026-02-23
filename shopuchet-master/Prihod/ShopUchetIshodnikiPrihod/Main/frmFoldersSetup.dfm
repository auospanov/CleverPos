inherited FoldersSetupForm: TFoldersSetupForm
  Left = 338
  Top = 234
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 437
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  inherited btnOk: TBitBtn
    TabOrder = 0
  end
  inherited btnCancel: TBitBtn
    TabOrder = 1
  end
  inherited Panel1: TPanel
    TabOrder = 2
    object PageControl: TPageControl
      Left = 2
      Top = 2
      Width = 549
      Height = 389
      ActivePage = tsParams
      Align = alClient
      TabOrder = 0
      object tsFolders: TTabSheet
        Caption = #1055#1072#1087#1082#1080
        object GroupBox1: TGroupBox
          Left = 3
          Top = 2
          Width = 536
          Height = 161
          Caption = #1055#1072#1087#1082#1080' '#1076#1083#1103' '#1074#1093#1086#1076#1103#1097#1080#1093' '#1092#1072#1081#1083#1086#1074
          TabOrder = 0
          object Shape17: TShape
            Left = 12
            Top = 21
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label1: TLabel
            Left = 15
            Top = 27
            Width = 127
            Height = 14
            Caption = #1060#1072#1081#1083#1099' '#1076#1083#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape18: TShape
            Left = 154
            Top = 21
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape1: TShape
            Left = 12
            Top = 53
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape2: TShape
            Left = 154
            Top = 53
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape3: TShape
            Left = 12
            Top = 85
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape4: TShape
            Left = 154
            Top = 85
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape5: TShape
            Left = 12
            Top = 117
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape6: TShape
            Left = 154
            Top = 117
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Label4: TLabel
            Left = 15
            Top = 123
            Width = 56
            Height = 14
            Caption = #1040#1088#1093#1080#1074#1085#1099#1077
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label3: TLabel
            Left = 15
            Top = 58
            Width = 135
            Height = 14
            Caption = #1059#1089#1087#1077#1096#1085#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1077
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 16
            Top = 91
            Width = 67
            Height = 14
            Caption = #1054#1096#1080#1073#1086#1095#1085#1099#1077
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object edINGOING_OK: TdxButtonEdit
            Left = 158
            Top = 56
            Width = 350
            TabOrder = 1
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
          object edINGOING_IN: TdxButtonEdit
            Left = 158
            Top = 24
            Width = 350
            TabOrder = 0
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
          object edINGOING_ERR: TdxButtonEdit
            Left = 158
            Top = 87
            Width = 350
            TabOrder = 2
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
          object edINGOING_ARCH: TdxButtonEdit
            Left = 158
            Top = 119
            Width = 350
            TabOrder = 3
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
        end
        object GroupBox2: TGroupBox
          Left = 3
          Top = 170
          Width = 537
          Height = 161
          Caption = #1055#1072#1087#1082#1080' '#1076#1083#1103' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1092#1072#1081#1083#1086#1074
          Enabled = False
          TabOrder = 1
          Visible = False
          object Shape7: TShape
            Left = 12
            Top = 21
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label5: TLabel
            Left = 15
            Top = 27
            Width = 127
            Height = 14
            Caption = #1060#1072#1081#1083#1099' '#1076#1083#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
            Enabled = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape8: TShape
            Left = 154
            Top = 21
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape9: TShape
            Left = 12
            Top = 53
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape10: TShape
            Left = 154
            Top = 53
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape11: TShape
            Left = 12
            Top = 85
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape12: TShape
            Left = 154
            Top = 85
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape13: TShape
            Left = 12
            Top = 117
            Width = 143
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Shape14: TShape
            Left = 154
            Top = 117
            Width = 357
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Label6: TLabel
            Left = 15
            Top = 123
            Width = 56
            Height = 14
            Caption = #1040#1088#1093#1080#1074#1085#1099#1077
            Enabled = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 15
            Top = 58
            Width = 135
            Height = 14
            Caption = #1059#1089#1087#1077#1096#1085#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1077
            Enabled = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label8: TLabel
            Left = 16
            Top = 91
            Width = 67
            Height = 14
            Caption = #1054#1096#1080#1073#1086#1095#1085#1099#1077
            Enabled = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object edOUTGOING_IN: TdxButtonEdit
            Left = 158
            Top = 23
            Width = 350
            TabOrder = 0
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
          object edOUTGOING_OK: TdxButtonEdit
            Left = 158
            Top = 55
            Width = 350
            TabOrder = 1
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
          object edOUTGOING_ERR: TdxButtonEdit
            Left = 158
            Top = 87
            Width = 350
            TabOrder = 2
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
          object edOUTGOING_ARCH: TdxButtonEdit
            Left = 158
            Top = 119
            Width = 350
            TabOrder = 3
            StyleController = dxEditStyleController
            OnValidate = edINGOING_INValidate
            Buttons = <
              item
                Default = True
              end>
            ExistButtons = True
          end
        end
      end
      object tsParams: TTabSheet
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        ImageIndex = 1
        object GroupBox4: TGroupBox
          Left = 8
          Top = 0
          Width = 529
          Height = 184
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1089#1087#1072#1088#1089#1077#1085#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
          TabOrder = 0
          object Shape15: TShape
            Left = 12
            Top = 21
            Width = 109
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label9: TLabel
            Left = 15
            Top = 27
            Width = 98
            Height = 14
            Caption = #1050#1086#1076' '#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1103
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape16: TShape
            Left = 120
            Top = 21
            Width = 391
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape19: TShape
            Left = 12
            Top = 53
            Width = 109
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label10: TLabel
            Left = 15
            Top = 59
            Width = 74
            Height = 14
            Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape20: TShape
            Left = 120
            Top = 53
            Width = 391
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape21: TShape
            Left = 12
            Top = 85
            Width = 109
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label11: TLabel
            Left = 15
            Top = 91
            Width = 92
            Height = 14
            Caption = #1050#1086#1076' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape22: TShape
            Left = 120
            Top = 85
            Width = 391
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape23: TShape
            Left = 12
            Top = 117
            Width = 109
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label12: TLabel
            Left = 15
            Top = 123
            Width = 67
            Height = 14
            Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape24: TShape
            Left = 120
            Top = 117
            Width = 391
            Height = 26
            Pen.Color = clBtnShadow
          end
          object Shape25: TShape
            Left = 12
            Top = 149
            Width = 109
            Height = 26
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label13: TLabel
            Left = 15
            Top = 155
            Width = 38
            Height = 14
            Caption = 'MT102'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape26: TShape
            Left = 120
            Top = 149
            Width = 391
            Height = 26
            Pen.Color = clBtnShadow
          end
          object edSENDER: TdxEdit
            Left = 128
            Top = 24
            Width = 377
            Enabled = False
            TabOrder = 0
            StyleController = dxEditStyleController
          end
          object edRECEIVER: TdxEdit
            Left = 128
            Top = 88
            Width = 377
            Enabled = False
            TabOrder = 1
            StyleController = dxEditStyleController
          end
          object edMT102: TdxLookupEdit
            Left = 128
            Top = 152
            Width = 377
            TabOrder = 2
            StyleController = dxEditStyleController
            ListFieldName = 'TYPE_NAME'
            KeyFieldName = 'MT_FORMAT'
            ListSource = dsMT102
            LookupKeyValue = Null
          end
          object edRECEIVER_STR: TdxLookupEdit
            Left = 128
            Top = 120
            Width = 377
            TabOrder = 3
            StyleController = dxEditStyleController
            OnChange = edRECEIVER_STRChange
            ListFieldName = 'NAME'
            KeyFieldName = 'ABONENT'
            ListSource = dsReadReciever
            LookupKeyValue = 0
          end
        end
        object edSENDER_STR: TdxLookupEdit
          Left = 136
          Top = 56
          Width = 377
          TabOrder = 1
          StyleController = dxEditStyleController
          OnChange = edSENDER_STRChange
          ListFieldName = 'NAME'
          KeyFieldName = 'ABONENT'
          ListSource = dsReadSender
          LookupKeyValue = 0
        end
        object GroupBox3: TGroupBox
          Left = 4
          Top = 183
          Width = 537
          Height = 177
          Caption = #1055#1086#1083#1077' :50: "'#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '#1080#1085#1080#1094#1080#1072#1090#1086#1088'"'
          TabOrder = 2
          object Memo50: TMemo
            Left = 7
            Top = 19
            Width = 522
            Height = 149
            MaxLength = 1500
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
      end
    end
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_TRANSMITTER_SETUP(?CODE_)')
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UPD_TRANSMITTER_SETUP (?INGOING_IN, ?INGOING_O' +
        'K, ?INGOING_ERR, ?INGOING_ARCH, ?OUTGOING_IN, ?OUTGOING_OK, ?OUT' +
        'GOING_ERR, ?OUTGOING_ARCH, ?FIELD_50, ?MT102_FORMAT, ?SENDER, ?S' +
        'ENDER_STR, ?RECEIVER, ?RECEIVER_STR, ?CODE_)')
    StoredProcName = 'UPD_TRANSMITTER_SETUP'
  end
  object spReadSender: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_ABONENT_LIST')
    Transaction = TranReadSender
    Database = MainDM.dbMain
    Left = 312
    Top = 88
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object TranReadSender: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 281
    Top = 88
  end
  object dsReadSender: TDataSource
    DataSet = spReadSender
    Left = 342
    Top = 88
  end
  object tranMT102: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 281
    Top = 185
  end
  object spMT102: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_MT_FORMAT_LIST')
    Transaction = tranMT102
    Database = MainDM.dbMain
    Left = 312
    Top = 185
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsMT102: TDataSource
    DataSet = spMT102
    Left = 342
    Top = 185
  end
  object dsReadReciever: TDataSource
    DataSet = spReadReciever
    Left = 342
    Top = 151
  end
  object spReadReciever: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_ABONENT_LIST')
    Transaction = tranReadReciever
    Database = MainDM.dbMain
    Left = 312
    Top = 151
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object tranReadReciever: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 281
    Top = 151
  end
end
