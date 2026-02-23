inherited RevisionForm: TRevisionForm
  Left = 377
  Top = 170
  Caption = #1056#1077#1074#1080#1079#1080#1103' '#1090#1086#1074#1072#1088#1085#1099#1093' '#1086#1089#1090#1072#1090#1082#1086#1074'/'#1058#1086#1074#1072#1088#1085#1086#1081' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
  ClientWidth = 682
  ExplicitWidth = 688
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Top = 57
    Width = 682
    Height = 249
    TabOrder = 2
    ExplicitTop = 57
    ExplicitWidth = 682
    ExplicitHeight = 249
    inherited tvMain: TcxGridDBTableView
      OnFocusedRecordChanged = tvMainFocusedRecordChanged
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'OVER_SUMM'
          Column = clmMainOVER_SUMM
        end
        item
          Kind = skSum
          FieldName = 'LOSS_SUMM'
          Column = clmMainLOSS_SUMM
        end
        item
          Kind = skSum
          Column = clmMainAMOUNT_BD
        end
        item
          Kind = skSum
          Column = clmMainAMOUNT_REAL
        end>
      OptionsBehavior.IncSearch = False
      object clmMainNAME: TcxGridDBColumn
        Caption = #1058#1086#1074#1072#1088
        DataBinding.FieldName = 'NAME'
        HeaderAlignmentHorz = taCenter
        Width = 230
      end
      object clmMainBARCODE: TcxGridDBColumn
        Caption = #1064#1090#1088#1080#1093#1082#1086#1076
        DataBinding.FieldName = 'BARCODE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 118
      end
      object clmMainARTICUL: TcxGridDBColumn
        Caption = #1040#1088#1090#1080#1082#1091#1083
        DataBinding.FieldName = 'ARTICUL'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 108
      end
      object clmMainPLACE: TcxGridDBColumn
        Caption = #1052#1077#1089#1090#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
        DataBinding.FieldName = 'PLACE'
        HeaderAlignmentHorz = taCenter
        Width = 111
      end
      object clmMainAMOUNT_BD: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1082#1080' '#1074' '#1041#1044
        DataBinding.FieldName = 'AMOUNT_BD'
        RepositoryItem = riEditRepositoryCurrencyItem
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainAMOUNT_REAL: TcxGridDBColumn
        Caption = #1054#1089#1090#1072#1090#1082#1080' '#1092#1072#1082#1090'.'
        DataBinding.FieldName = 'AMOUNT_REAL'
        RepositoryItem = riEditRepositoryCurrencyItem
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainIS_UNIFIED: TcxGridDBColumn
        Caption = #1059#1085#1080#1092#1080#1094#1080#1088#1086#1074#1072#1085#1086
        DataBinding.FieldName = 'IS_UNIFIED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmDIFF_SUMM: TcxGridDBColumn
        Caption = #1056#1072'c'#1093#1086#1078#1076#1077#1085#1080#1077
        DataBinding.FieldName = 'DIFF_SUMM'
        RepositoryItem = riEditRepositoryCurrencyItem
        OnCustomDrawCell = clmDIFF_SUMMCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 92
      end
      object clmMainOVER_SUMM: TcxGridDBColumn
        DataBinding.FieldName = 'OVER_SUMM'
        Visible = False
        VisibleForCustomization = False
      end
      object clmMainLOSS_SUMM: TcxGridDBColumn
        DataBinding.FieldName = 'LOSS_SUMM'
        Visible = False
        VisibleForCustomization = False
      end
      object clmMainPRICE: TcxGridDBColumn
        Caption = #1062#1077#1085#1072
        DataBinding.FieldName = 'PRICE'
        HeaderAlignmentHorz = taCenter
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 306
    Width = 682
    Height = 68
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      682
      68)
    object Label8: TLabel
      Left = 8
      Top = 8
      Width = 99
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 86
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edSearch: TEdit
      Left = 115
      Top = 6
      Width = 268
      Height = 24
      Hint = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072'. '#1055#1086#1080#1089#1082' '#1087#1088#1086#1074#1086#1076#1080#1090#1089#1103' '#1087#1086' '#1074#1089#1077#1084' '#1089#1090#1086#1083#1073#1094#1072#1084
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      CharCase = ecLowerCase
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 13
      ParentFont = False
      TabOrder = 0
      OnChange = edSearchChange
    end
    object cbScaner: TCheckBox
      Left = 277
      Top = 41
      Width = 145
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057' '#1087#1086#1084#1086#1097#1100#1102' '#1089#1082#1072#1085#1077#1088#1072
      TabOrder = 2
      OnClick = cbScanerClick
    end
    inline MyCurrencyFrameForm: TMyCurrencyFrameForm
      Left = 114
      Top = 37
      Width = 147
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
      ExplicitLeft = 114
      ExplicitTop = 37
      ExplicitWidth = 147
      ExplicitHeight = 27
      inherited edAmount: TEdit
        Left = 0
        Width = 118
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        ParentFont = False
        Text = '1.00'
        OnChange = MyCurrencyFrameFormedAmountChange
        ExplicitLeft = 0
        ExplicitWidth = 118
        ExplicitHeight = 27
      end
      inherited sbCur: TSpinButton
        Left = 121
        Top = 1
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ExplicitLeft = 121
        ExplicitTop = 1
        ExplicitHeight = 25
      end
    end
    object cxButton1: TcxButton
      Left = 452
      Top = 5
      Width = 222
      Height = 41
      Action = aDoUnific
      Anchors = [akLeft, akTop, akRight, akBottom]
      LookAndFeel.Kind = lfFlat
      TabOrder = 3
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object cxButton2: TcxButton
      Left = 389
      Top = 6
      Width = 23
      Height = 22
      Action = aClear
      LookAndFeel.Kind = lfFlat
      TabOrder = 4
    end
    object pbBarcodeArrUpdate: TcxProgressBar
      Left = 452
      Top = 49
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Properties.BarStyle = cxbsGradient
      Properties.BeginColor = clActiveCaption
      Properties.EndColor = clActiveCaption
      Properties.ShowText = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clNavy
      Style.Font.Height = -7
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      TabOrder = 5
      Visible = False
      Width = 222
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 26
    Width = 682
    Height = 31
    Align = alTop
    TabOrder = 6
    object lbOverSumm: TLabel
      Left = 16
      Top = 6
      Width = 243
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1091#1084#1084#1072' '#1080#1079#1083#1080#1096#1082#1086#1074' 0. '#1057#1091#1084#1084#1072' '#1087#1086#1090#1077#1088#1100' 0.'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    Categories.Strings = (
      #1054#1073#1097#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1041#1044
      #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    LookAndFeel.SkinName = ''
    DockControlHeights = (
      0
      0
      26
      0)
    inherited dxBarManagerChildBar1: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStaticRecCnt'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonEnableAutoRefresh'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 23
          Visible = True
          ItemName = 'dxBarSpinEditHeaderHeight'
        end
        item
          BeginGroup = True
          UserDefine = [udWidth]
          UserWidth = 121
          Visible = True
          ItemName = 'bcOstatkiOrNakl'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxbrbtn1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
    object dxBarButton2: TdxBarButton
      Action = aRefill
      Category = 0
    end
    object dxbrbtn1: TdxBarButton
      Action = aImportFromExcel
      Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' Excel'
      Category = 0
      Hint = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1088#1077#1074#1080#1079#1080#1080' '#1080#1079' '#1092#1072#1081#1083#1072' Excel'
    end
    object dxBarButton3: TdxBarButton
      Action = aClearTable
      Category = 0
    end
    object bcOstatkiOrNakl: TdxBarCombo
      Caption = #1057#1088#1072#1074#1085#1080#1090#1100
      Category = 1
      Hint = #1057#1088#1072#1074#1085#1080#1090#1100
      Visible = ivAlways
      OnChange = bcOstatkiOrNaklChange
      ShowCaption = True
      Text = #1054#1089#1090#1072#1090#1082#1080' '#1074' '#1041#1044
      Items.Strings = (
        #1054#1089#1090#1072#1090#1082#1080' '#1074' '#1041#1044
        #1058#1086#1074#1072#1088#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103)
      ItemIndex = 0
    end
  end
  inherited alChild: TActionList
    inherited aView: TAction
      ShortCut = 0
    end
    inherited aIns: TAction
      ShortCut = 0
    end
    inherited aUpd: TAction
      ShortCut = 0
    end
    inherited aDel: TAction
      ShortCut = 0
    end
    object aUpdAmount: TAction
      Category = #1044#1088#1091#1075#1086#1077
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1089#1090#1072#1090#1086#1082
      OnExecute = aUpdAmountExecute
    end
    object aClear: TAction
      Category = #1044#1088#1091#1075#1086#1077
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 47
      OnExecute = aClearExecute
    end
    object aPrint: TAction
      Category = #1044#1088#1091#1075#1086#1077
      Caption = 'aPrint'
    end
    object aDoUnific: TAction
      Category = #1044#1088#1091#1075#1086#1077
      Caption = #1055#1088#1080#1074#1077#1089#1090#1080' '#1041#1044' '#1074' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077
      Hint = 
        #1055#1088#1086#1074#1077#1089#1090#1080' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1077' '#1089#1087#1080#1089#1072#1085#1080#1103' '#1080' '#1087#1088#1080#1093#1086#1076#1099' '#1090#1086#1074#1072#1088#1072', '#1095#1090#1086#1073#1099' '#1087#1088#1080#1074#1077#1089#1090 +
        #1080' '#1041#1044' '#1074' '#1072#1082#1090#1091#1072#1083#1100#1085#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
      OnExecute = aDoUnificExecute
    end
    object aRefill: TAction
      Category = #1044#1088#1091#1075#1086#1077
      Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      ImageIndex = 38
      OnExecute = aRefillExecute
    end
    object aFromHarvester: TAction
      Caption = 'aFromHarvester'
      ShortCut = 118
      OnExecute = aFromHarvesterExecute
    end
    object aImportFromExcel: TAction
      Category = #1044#1088#1091#1075#1086#1077
      Caption = 'aImportFromExcel'
      ImageIndex = 167
      OnExecute = aImportFromExcelExecute
    end
    object aClearTable: TAction
      Category = #1044#1088#1091#1075#1086#1077
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      ImageIndex = 149
      OnExecute = aClearTableExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT R.REVISION,'
      '           R.SKLAD,'
      '           R.G_PRODUCT,'
      '           G.NAME,'
      '           G.BARCODE,'
      '           G.ARTICUL,'
      '           G.PRICE,'
      '           R.AMOUNT_BD,'
      '           R.AMOUNT_REAL,'
      '           R.IS_UNIFIED,'
      '           G.PLACE,'
      '           R.AMOUNT_REAL - R.AMOUNT_BD DIFF_SUMM'
      
        '           ,CASE WHEN (R.AMOUNT_REAL - R.AMOUNT_BD) > 0 THEN G.P' +
        'RICE*CAST((R.AMOUNT_REAL - R.AMOUNT_BD) AS DOUBLE PRECISION) ELS' +
        'E 0 END OVER_SUMM'
      
        '           ,CASE WHEN (R.AMOUNT_REAL - R.AMOUNT_BD) < 0 THEN G.P' +
        'RICE*CAST((R.AMOUNT_BD - R.AMOUNT_REAL) AS DOUBLE PRECISION) ELS' +
        'E 0 END LOSS_SUMM'
      '    FROM REVISION R, G_PRODUCT G'
      '   WHERE R.G_PRODUCT = G.G_PRODUCT'
      '     AND R.G_TOCHKA = :G_TOCHKA_'
      '   ORDER BY G.NAME')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE R_DEL_REVISION (?G_TOCHKA_)')
    StoredProcName = 'R_DEL_REVISION'
    Left = 144
    Top = 96
  end
  object spFillRevision: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE R_FILL_REVISION (?G_PRODUCT_PAR_, ?G_PRODUCT_,' +
        ' ?SKLAD_, ?G_TOCHKA_, ?TYPE_)')
    StoredProcName = 'R_FILL_REVISION'
    Left = 176
    Top = 80
  end
  object spUpdAmountReal: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE R_UPD_REVISION (?REVISION_, ?AMOUNT_REAL_)')
    StoredProcName = 'R_UPD_REVISION'
    Left = 208
    Top = 80
  end
  object spUnific: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE R_UNIFICATION (?MODE_)')
    StoredProcName = 'R_UNIFICATION'
    Left = 240
    Top = 80
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 296
    Top = 160
  end
  object TimerSearch: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerSearchTimer
    Left = 200
    Top = 200
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 200
    Top = 232
  end
  object tmrScanBarcodesComing: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrScanBarcodesComingTimer
    Left = 248
    Top = 232
  end
  object odlg: TOpenDialog
    Filter = 'Excel (*.xls, *.xlsx)|*.xls;*.xlsx'
    Left = 368
    Top = 128
  end
  object spImport: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE R_IMPORT_REVISION (?G_TOCHKA_, ?BARCODE_, ?AMO' +
        'UNT_)')
    StoredProcName = 'R_IMPORT_REVISION'
    Left = 240
    Top = 120
  end
end
