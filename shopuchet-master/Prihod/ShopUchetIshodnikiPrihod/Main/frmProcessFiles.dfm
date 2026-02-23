inherited ProcessFilesForm: TProcessFilesForm
  Left = 219
  Top = 109
  Width = 621
  Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object PageControl: TPageControl [0]
    Left = 0
    Top = 26
    Width = 613
    Height = 397
    ActivePage = tsLog
    Align = alClient
    TabOrder = 4
    OnChange = PageControlChange
    object tsLog: TTabSheet
      Caption = #1052#1086#1085#1080#1090#1086#1088#1080#1085#1075
      object LogRichEdit: TRichEdit
        Left = 0
        Top = 0
        Width = 605
        Height = 337
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object BottomPanel: TPanel
        Left = 0
        Top = 337
        Width = 605
        Height = 31
        Align = alBottom
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 101
          Height = 14
          Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1092#1072#1081#1083#1072
        end
        object ProgressBar: TProgressBar
          Left = 112
          Top = 8
          Width = 265
          Height = 16
          Smooth = True
          TabOrder = 0
        end
      end
    end
    object tsFiles: TTabSheet
      Caption = #1060#1072#1081#1083#1099
      ImageIndex = 1
      object PanelFiles: TPanel
        Left = 0
        Top = 0
        Width = 605
        Height = 32
        Align = alTop
        TabOrder = 0
        object Label2: TLabel
          Left = 145
          Top = 8
          Width = 67
          Height = 14
          Caption = #1079#1072' '#1087#1077#1088#1080#1086#1076' '#1089
        end
        object Label3: TLabel
          Left = 337
          Top = 8
          Width = 14
          Height = 14
          Caption = #1087#1086
        end
        object btnGoup: TSpeedButton
          Left = 480
          Top = 3
          Width = 113
          Height = 22
          Action = aGroupColumns
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000FFFFFF008484840084848400848484008484840084848400848484008484
            8400FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000FFFFFF00848484008484840084848400848484008484840084848400FFFF
            FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000FFFFFF008484840084848400848484008484840084848400848484008484
            8400FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008400
            0000840000008400000084000000840000008400000084000000840000008400
            00008400000084000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008400
            0000840000008400000084000000840000008400000084000000840000008400
            00008400000084000000FF00FF00FF00FF0000008400FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF0000008400FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF0000008400FF00FF0000008400FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF000000840000008400FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00000084000000840000008400FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          Transparent = False
        end
        object btnRefresh: TSpeedButton
          Left = 3
          Top = 5
          Width = 140
          Height = 22
          Action = aRefresh
          Flat = True
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF00
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF000000FF000000FF000000FF000000FF000000FF000000FF00
            0000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF000000FF000000FF000000FF00FF00848484000000000084848400FF00
            FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            0000FF000000FF000000FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00
            0000FF000000FF00FF00FF00FF00FF00FF00848484000000000084848400FF00
            FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF000000FF00
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000FF00
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000FF00
            0000FF00FF00FF00FF00FF00FF00FF00FF00848484000000000084848400FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00
            0000FF00FF00FF00FF00FF00FF00FF00FF00000084000000000000008400FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00
            0000FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF000000FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00
            0000FF000000FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00
            0000FF000000FF000000FF00FF00FF00FF00000000000000000000000000FF00
            FF00FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00FF00
            FF00FF000000FF000000FF000000FF00FF00848484000000000084848400FF00
            FF00FF000000FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF000000FF000000FF000000FF000000FF000000FF000000FF00
            0000FF000000FF000000FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF00
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          ParentFont = False
        end
        object edDateBegin: TcxDateEdit
          Left = 213
          Top = 4
          Width = 121
          Height = 22
          Properties.OnChange = edDateBeginPropertiesChange
          TabOrder = 0
        end
        object edDateEnd: TcxDateEdit
          Left = 354
          Top = 4
          Width = 121
          Height = 22
          Properties.OnChange = edDateEndPropertiesChange
          TabOrder = 1
        end
      end
      object dxDBGrid: TdxDBGrid
        Left = 0
        Top = 32
        Width = 605
        Height = 336
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'INGOING_MT_FILE'
        ShowGroupPanel = True
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        TabOrder = 1
        DataSource = dsRead
        Filter.Criteria = {00000000}
        LookAndFeel = lfUltraFlat
        OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSelect, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
        RegistryPath = '\Software\BSB\Transmitter\FilesGrid'
        object dxDBGridINGOING_MT_FILE: TdxDBGridColumn
          Caption = #8470
          BandIndex = 0
          RowIndex = 0
          FieldName = 'INGOING_MT_FILE'
        end
        object dxDBGridFILE_NAME: TdxDBGridColumn
          Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
          BandIndex = 0
          RowIndex = 0
          FieldName = 'FILE_NAME'
        end
        object dxDBGridPROCEED_SIGN_STR: TdxDBGridColumn
          Caption = #1057#1090#1072#1090#1091#1089
          BandIndex = 0
          RowIndex = 0
          FieldName = 'PROCEED_SIGN_STR'
        end
        object dxDBGridIN_OUT: TdxDBGridColumn
          Caption = #1042#1093#1086#1076#1103#1097#1080#1077'/'#1048#1089#1093#1086#1076#1103#1097#1080#1077
          Sorted = csUp
          Visible = False
          BandIndex = 0
          RowIndex = 0
          FieldName = 'IN_OUT'
          GroupIndex = 0
        end
        object dxDBGridRECV_DATE: TdxDBGridColumn
          Caption = #1042#1088#1077#1084#1103
          BandIndex = 0
          RowIndex = 0
          FieldName = 'RECV_DATE'
        end
        object dxDBGridRECV_DATE_ADD: TdxDBGridDateColumn
          Caption = #1044#1072#1090#1072
          Sorted = csUp
          Visible = False
          BandIndex = 0
          RowIndex = 0
          FieldName = 'RECV_DATE_ADD'
          GroupIndex = 1
        end
      end
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    AlwaysSaveText = True
    Bars = <
      item
        AllowClose = False
        AllowCustomizing = False
        AllowQuickCustomizing = False
        Caption = 'Main'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 271
        FloatTop = 138
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = dxBarButtonEnableAutoSize
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButtonStartIn
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButtonFolders
            Visible = True
          end>
        Name = 'Main'
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ShowShortCutInHint = True
    Top = 168
    DockControlHeights = (
      0
      0
      26
      0)
    inherited dxBarButtonEnableAutoSize: TdxBarButton
      Visible = ivNever
    end
    object dxBarButtonStartIn: TdxBarButton
      Action = aStartIn
      Category = 0
      Description = #1057#1090#1072#1088#1090' '#1042#1061
      ButtonStyle = bsChecked
      PaintStyle = psCaptionGlyph
    end
    object dxBarButtonStartOut: TdxBarButton
      Action = aStartOut
      Category = 0
      PaintStyle = psCaptionGlyph
    end
    object dxBarButtonFolders: TdxBarButton
      Action = aOptions
      Category = 0
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      PaintStyle = psCaptionGlyph
    end
  end
  inherited dxBarPopupMenuChild: TdxBarPopupMenu
    Top = 200
  end
  inherited alChild: TActionList
    Top = 168
    object aStartIn: TAction
      Caption = #1057#1090#1072#1088#1090' '#1042#1061
      ImageIndex = 130
      OnExecute = aStartInExecute
    end
    object aStartOut: TAction
      Caption = #1057#1090#1072#1088#1090' '#1048#1057#1061
      ImageIndex = 130
      OnExecute = aStartOutExecute
    end
    object aProcess: TAction
      Caption = 'aProcess'
      OnExecute = aProcessExecute
    end
    object aOptions: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 98
      OnExecute = aOptionsExecute
    end
    object aGroupColumns: TAction
      Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1072
      Checked = True
      ImageIndex = 43
      OnExecute = aGroupColumnsExecute
    end
    object aRefresh: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1092#1072#1081#1083#1099
      ImageIndex = 22
      OnExecute = aRefreshExecute
    end
  end
  inherited spReadDll: TpFIBDataSet
    Top = 200
  end
  inherited tranReadDLL: TpFIBTransaction
    Top = 232
  end
  object TimerIn: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerInTimer
    Left = 272
    Top = 8
  end
  object TimerOut: TTimer
    Enabled = False
    Interval = 2000
    Left = 304
    Top = 8
  end
  object spInsIngoingFile: TpFIBStoredProc
    Transaction = spInsIngoingFileTran
    Database = MainDM.dbMain
    SQL.Strings = (
      'INSERT INTO INGOING_MT_FILE'
      '     (MSG_DST,'
      '     FILE_NAME,'
      '     FILE_BODY,'
      '     PROCEED_SIGN)'
      '  VALUES'
      '     (:MSG_DST,'
      '     :FILE_NAME,'
      '     :FILE_BODY,'
      '     :PROCEED_SIGN)')
    Left = 88
    Top = 168
  end
  object spInsIngoingFileTran: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 88
    Top = 202
  end
  object spReadHeadMT: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_HEAD_MT(:PARAM_, :SENDER_, :RECIVER_)')
    Transaction = TranReadHeadMT
    Database = MainDM.dbMain
    Left = 120
    Top = 168
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object TranReadHeadMT: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 121
    Top = 202
  end
  object spGetReference: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT REFERENCE FROM GET_GNPF_NEW_REFERENCE')
    Transaction = TranReadHeadMT
    Database = MainDM.dbMain
    Left = 153
    Top = 168
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT * FROM READ_INGOING_TRANSMITTER_FILES(?BEGIN_DATE, ?END_D' +
        'ATE)')
    Transaction = tranSpRead
    Database = MainDM.dbMain
    Left = 352
    Top = 168
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object tranSpRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 352
    Top = 198
  end
  object dsRead: TDataSource
    DataSet = spRead
    Left = 321
    Top = 168
  end
  object spGetData: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_TRANSMITTER_SETUP(?CODE_)')
    Left = 120
    Top = 240
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
    Left = 88
    Top = 240
  end
  object spGet_Ingoing_MT_File: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT MAX(INGOING_MT_FILE) AS INGOING_MT_FILE FROM INGOING_MT_F' +
        'ILE WHERE FILE_NAME = :FILE_NAME_')
    Transaction = TranReadHeadMT
    Database = MainDM.dbMain
    Left = 185
    Top = 168
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spInsIngoingMTFile: TpFIBStoredProc
    Transaction = tranInsIngoingMTFile
    Database = MainDM.dbMain
    SQL.Strings = (
      'INSERT INTO INGOING_MT'
      ' (INGOING_MT, INGOING_MT_FILE, MT_FORMAT,'
      '  SENDER_STR, RECEIVER_STR, SENDER, RECEIVER,'
      '  MT_PRIORITY, MAIN_HEADER, APP_HEADER, TEXT_PART,'
      '  EL_SIGN, BLOCK_IN_MT_FILE,'
      '  PROCEED_SIGN, PROCEED_DATE,'
      '  UNIQUE_CODE, UNIQUE_VALUE,'
      '  ERROR_CODE, MT_TYPE)'
      ' VALUES'
      ' (:INGOING_MT, :INGOING_MT_FILE, :MT_FORMAT,'
      '  :SENDER_STR, :RECEIVER_STR, :SENDER, :RECEIVER,'
      '  :MT_PRIORITY, :MAIN_HEADER, :APP_HEADER, :TEXT_PART,'
      '  :EL_SIGN, :BLOCK_IN_MT_FILE,'
      '  :PROCEED_SIGN, :PROCEED_DATE,'
      '  :UNIQUE_CODE, :UNIQUE_VALUE,'
      '  :ERROR_CODE, :MT_TYPE)')
    Left = 185
    Top = 211
  end
  object tranInsIngoingMTFile: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 185
    Top = 240
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TimeoutAction = TARollback
    Left = 224
    Top = 243
  end
  object spUpd: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UPD_TRANSMITTER_SETUP (?INGOING_IN, ?INGOING_O' +
        'K, ?INGOING_ERR, ?INGOING_ARCH, ?OUTGOING_IN, ?OUTGOING_OK, ?OUT' +
        'GOING_ERR, ?OUTGOING_ARCH, ?FIELD_50, ?MT102_FORMAT, ?SENDER, ?S' +
        'ENDER_STR, ?RECEIVER, ?RECEIVER_STR, ?CODE_)')
    StoredProcName = 'UPD_TRANSMITTER_SETUP'
    Left = 224
    Top = 211
  end
  object UpdTimer: TTimer
    Enabled = False
    OnTimer = UpdTimerTimer
    Left = 356
    Top = 11
  end
end
