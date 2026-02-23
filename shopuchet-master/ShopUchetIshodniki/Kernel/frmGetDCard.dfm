inherited GetDCardForm: TGetDCardForm
  Left = 439
  Top = 181
  Caption = #1044#1080#1089#1082#1086#1085#1090#1085#1072#1103' '#1082#1072#1088#1090#1072
  ClientHeight = 311
  ClientWidth = 598
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 604
  ExplicitHeight = 337
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 585
    Height = 263
    ExplicitWidth = 585
    ExplicitHeight = 205
    object Shape1: TShape
      Left = 8
      Top = 34
      Width = 172
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape11: TShape
      Left = 8
      Top = 59
      Width = 172
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
      Top = 9
      Width = 264
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label4: TLabel
      Left = 15
      Top = 15
      Width = 249
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1053#1086#1084#1077#1088'/'#1096#1090#1088#1080#1093#1082#1086#1076' '#1082#1072#1088#1090#1099' '#1080#1083#1080' '#1085#1086#1084'. '#1090#1077#1083#1077#1092#1086#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape8: TShape
      Left = 271
      Top = 9
      Width = 222
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label6: TLabel
      Left = 15
      Top = 65
      Width = 92
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1088#1086#1094#1077#1085#1090' '#1073#1086#1085#1091#1089#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape16: TShape
      Left = 179
      Top = 59
      Width = 314
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 15
      Top = 40
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
    object Shape2: TShape
      Left = 179
      Top = 34
      Width = 314
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lbBonusSumm: TLabel
      Left = 8
      Top = 96
      Width = 211
      Height = 29
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1091#1084#1084#1072' '#1085#1072#1082#1086#1087#1083#1077#1085#1080#1081
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBackground
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbAllSumm: TLabel
      Left = 8
      Top = 138
      Width = 247
      Height = 29
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1054#1073#1097#1072#1103' '#1089#1091#1084#1084#1072' '#1087#1086#1082#1091#1087#1086#1082
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBackground
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbLastPurchaseDate: TLabel
      Left = 8
      Top = 182
      Width = 223
      Height = 30
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1087#1086#1082#1091#1087#1082#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBackground
      Font.Height = -25
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edBarcode: TcxTextEdit
      Left = 274
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 30
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 215
    end
    object edClient: TcxTextEdit
      Left = 182
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Enabled = False
      Properties.MaxLength = 5
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 307
    end
    object sePercent: TcxCurrencyEdit
      Left = 182
      Top = 62
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Enabled = False
      Properties.DisplayFormat = '0.00%'
      Style.StyleController = dxEditStyleController
      TabOrder = 2
      Width = 307
    end
    object cbCloseDialog: TcxCheckBox
      Left = 8
      Top = 238
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akBottom]
      Caption = #1047#1072#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086', '#1087#1086#1089#1083#1077' '#1090#1086#1075#1086', '#1082#1072#1082' '#1082#1083#1080#1077#1085#1090' '#1085#1072#1081#1076#1077#1085
      ParentShowHint = False
      ShowHint = True
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 3
      ExplicitTop = 180
      Width = 305
    end
    object cxButton1: TcxButton
      Left = 498
      Top = 9
      Width = 81
      Height = 76
      Action = aSearch
      Anchors = [akLeft, akBottom]
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
      TabOrder = 4
    end
  end
  inherited btnOk: TcxButton
    Left = 432
    Top = 275
    ExplicitLeft = 432
    ExplicitTop = 217
  end
  inherited btnCancel: TcxButton
    Left = 517
    Top = 275
    ExplicitLeft = 517
    ExplicitTop = 217
  end
  inherited btHelp: TcxButton
    Top = 275
    ExplicitTop = 217
  end
  inherited ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 104
    Top = 416
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = MainDM.imMain
    Top = 416
    object aSearch: TAction
      Caption = #1053#1072#1081#1090#1080
      ImageIndex = 153
      ShortCut = 13
      OnExecute = aSearchExecute
    end
  end
  object spGetCard: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_GET_DCARD_BY_CODE (?G_DISCONT_CARD_, ?CARD_C' +
        'ODE_)')
    StoredProcName = 'G_GET_DCARD_BY_CODE'
    Left = 376
    Top = 8
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 344
    Top = 8
  end
end
