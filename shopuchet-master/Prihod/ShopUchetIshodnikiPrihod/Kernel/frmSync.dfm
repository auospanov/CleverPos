inherited SyncForm: TSyncForm
  Left = 507
  Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1084#1072#1075#1072#1079#1080#1085
  ClientHeight = 329
  ClientWidth = 448
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 454
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 432
    Height = 284
    ExplicitWidth = 432
    ExplicitHeight = 284
    object dxPageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 428
      Height = 280
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tsExport
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 5
      LookAndFeel.Kind = lfUltraFlat
      OnChange = dxPageControlChange
      ClientRectBottom = 280
      ClientRectRight = 428
      ClientRectTop = 25
      object tsExport: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
        object Shape1: TShape
          Left = 7
          Top = 32
          Width = 137
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape35: TShape
          Left = 8
          Top = 215
          Width = 89
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape12: TShape
          Left = 7
          Top = 7
          Width = 137
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label17: TLabel
          Left = 19
          Top = 221
          Width = 69
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape36: TShape
          Left = 96
          Top = 215
          Width = 321
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Label7: TLabel
          Left = 17
          Top = 13
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
        object Shape13: TShape
          Left = 143
          Top = 7
          Width = 274
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Label2: TLabel
          Left = 128
          Top = 73
          Width = 191
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taCenter
          Caption = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1101#1082#1089#1087#1086#1088#1090#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 17
          Top = 38
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
        object Shape2: TShape
          Left = 143
          Top = 32
          Width = 274
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object edDateBegin: TcxDateEdit
          Left = 147
          Top = 9
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.InputKind = ikMask
          Style.BorderStyle = ebs3D
          Style.StyleController = dxEditStyleController
          Style.ButtonStyle = bts3D
          Style.ButtonTransparency = ebtNone
          TabOrder = 0
          Width = 265
        end
        object edDateEnd: TcxDateEdit
          Left = 148
          Top = 34
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.InputKind = ikMask
          Style.BorderStyle = ebs3D
          Style.StyleController = dxEditStyleController
          Style.ButtonStyle = bts3D
          Style.ButtonTransparency = ebtNone
          TabOrder = 1
          Width = 265
        end
        object cbAll: TcxCheckBox
          Left = 11
          Top = 102
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1089#1077
          ParentFont = False
          State = cbsChecked
          Style.BorderStyle = ebs3D
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 2
          OnClick = cbAllClick
          Width = 78
        end
        object cbSales: TcxCheckBox
          Left = 11
          Top = 129
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1086#1076#1072#1078#1080
          Enabled = False
          ParentFont = False
          Style.BorderStyle = ebs3D
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 4
          Width = 93
        end
        object cbPrihod: TcxCheckBox
          Left = 11
          Top = 155
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1080#1093#1086#1076' '#1090#1086#1074#1072#1088#1072
          Enabled = False
          ParentFont = False
          Style.BorderStyle = ebs3D
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 6
          Width = 142
        end
        object cbVozvrat: TcxCheckBox
          Left = 11
          Top = 182
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1086#1079#1074#1088#1072#1090' '#1090#1086#1074#1072#1088#1072
          Enabled = False
          ParentFont = False
          Style.BorderStyle = ebs3D
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 8
          Width = 136
        end
        object cbSpisanie: TcxCheckBox
          Left = 200
          Top = 102
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1057#1087#1080#1089#1072#1085#1080#1077
          Enabled = False
          ParentFont = False
          Style.BorderStyle = ebs3D
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 3
          Width = 123
        end
        object cbMove: TcxCheckBox
          Left = 200
          Top = 129
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
          Enabled = False
          ParentFont = False
          Style.BorderStyle = ebs3D
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 5
          Width = 180
        end
        object cbProduction: TcxCheckBox
          Left = 200
          Top = 155
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072
          Enabled = False
          ParentFont = False
          Style.BorderStyle = ebs3D
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 7
          Width = 180
        end
        object bedtFileName: TcxButtonEdit
          Left = 102
          Top = 218
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
          Style.ButtonTransparency = ebtNone
          TabOrder = 9
          Width = 312
        end
      end
      object tsImport: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
        ImageIndex = 1
        object Shape3: TShape
          Left = 8
          Top = 48
          Width = 97
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label3: TLabel
          Left = 18
          Top = 54
          Width = 76
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape4: TShape
          Left = 104
          Top = 48
          Width = 313
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object lbSklad: TLabel
          Left = 8
          Top = 8
          Width = 384
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1044#1072#1085#1085#1099#1077' '#1073#1091#1076#1091#1090' '#1079#1072#1075#1088#1091#1078#1077#1085#1099' '#1085#1072' '#1090#1077#1082#1091#1097#1080#1081' '#1089#1082#1083#1072#1076' - '#13#10#1042#1099' '#1084#1086#1078#1077#1090#1077' '#1074#1099#1073#1088#1072#1090#1100' '#1085#1077 +
            #1086#1073#1093#1086#1076#1080#1084#1099#1081' '#1089#1082#1083#1072#1076' '#1074' '#1084#1077#1085#1102' "'#1057#1077#1088#1074#1080#1089' - '#1057#1082#1083#1072#1076#1099'"'
          Visible = False
        end
        object lbSklad1: TLabel
          Left = 270
          Top = 7
          Width = 53
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'lbSklad1'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Memo1: TMemo
          Left = 8
          Top = 78
          Width = 409
          Height = 145
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object ProgressBar: TProgressBar
          Left = 8
          Top = 230
          Width = 409
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabOrder = 2
        end
        object bdeFileImp: TcxButtonEdit
          Left = 110
          Top = 51
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = bdeFileImpPropertiesButtonClick
          Style.StyleController = dxEditStyleController
          Style.ButtonTransparency = ebtNone
          TabOrder = 0
          Width = 304
        end
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 256
    Top = 297
    Width = 94
    Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
    ExplicitLeft = 256
    ExplicitTop = 297
    ExplicitWidth = 94
  end
  inherited btnCancel: TcxButton
    Left = 360
    Top = 297
    Width = 80
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ExplicitLeft = 360
    ExplicitTop = 297
    ExplicitWidth = 80
  end
  object btHelp: TcxButton [3]
    Left = 8
    Top = 297
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1055#1086#1084#1086#1097#1100
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    OptionsImage.Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333336633
      3333333333333FF3333333330000333333364463333333333333388F33333333
      00003333333E66433333333333338F38F3333333000033333333E66333333333
      33338FF8F3333333000033333333333333333333333338833333333300003333
      3333446333333333333333FF3333333300003333333666433333333333333888
      F333333300003333333E66433333333333338F38F333333300003333333E6664
      3333333333338F38F3333333000033333333E6664333333333338F338F333333
      0000333333333E6664333333333338F338F3333300003333344333E666433333
      333F338F338F3333000033336664333E664333333388F338F338F33300003333
      E66644466643333338F38FFF8338F333000033333E6666666663333338F33888
      3338F3330000333333EE666666333333338FF33333383333000033333333EEEE
      E333333333388FFFFF8333330000333333333333333333333333388888333333
      0000}
    OptionsImage.NumGlyphs = 2
    TabOrder = 3
    OnClick = btHelpClick
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 72
    Top = 408
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 192
    Top = 384
  end
  object spLoad: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE SYNC_DOWNLOAD (?G_TOCHKA_, ?UPLOAD_TABLE_TMP, ' +
        '?MODE, ?PARENT, ?DATE_OPER, ?TIME_OPER, ?G_CLIENT, ?G_PAYMENT_TY' +
        'PE, ?SUMM_ALL, ?SUMM_FACT_ALL, ?SUMM_PAY_BONUS, ?SUMM_BONUS_GOT,' +
        ' ?OSNOVANIE, ?NOTE, ?G_OFFICIAL, ?G_PRODUCT, ?AMOUNT, ?PRICE, ?S' +
        'UMM, ?DISCOUNT_PERC, ?DISCOUNT_TENGE, ?DISCOUNT_SUMM, ?NDS, ?NDS' +
        '_SUMM, ?COST_PRICE, ?BY_RECIPE, ?IS_RESERVE, ?PAYMENTS, ?IS_LOAD' +
        '_)')
    StoredProcName = 'SYNC_DOWNLOAD'
    Left = 216
    Top = 384
  end
  object odlg: TOpenDialog
    Filter = 'Excel (*.xls)|*.xls'
    Left = 55
    Top = 96
  end
  object spUpload: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE SYNC_UPLOAD (?DATE_BEGIN_, ?DATE_END_, ?ALL_, ' +
        '?SALES_, ?PRIHOD_, ?VOZVRAT_, ?SPIS_)')
    StoredProcName = 'SYNC_UPLOAD'
    Left = 160
    Top = 384
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 128
    Top = 384
  end
  object spGet: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_CNT_ZAKAZ_SKLAD ')
    StoredProcName = 'GET_CNT_ZAKAZ_SKLAD'
    Left = 248
    Top = 384
  end
end
