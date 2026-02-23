inherited PopupClientListSaleModeForm: TPopupClientListSaleModeForm
  Left = 523
  Top = 276
  Caption = #1050#1083#1080#1077#1085#1090#1099
  ClientHeight = 227
  ClientWidth = 534
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 542
  ExplicitHeight = 255
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 534
    Height = 227
    ExplicitWidth = 534
    ExplicitHeight = 227
    inherited pnlTop: TPanel
      Width = 534
      Height = 32
      ExplicitWidth = 534
      ExplicitHeight = 32
      object Label10: TLabel [0]
        Left = 67
        Top = 5
        Width = 50
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086#1080#1089#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object sbClear: TSpeedButton [1]
        Left = 450
        Top = 3
        Width = 36
        Height = 26
        Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1080#1089#1082
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF000000FF000000
          FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF000000FF000000
          FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF000000
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = sbClearClick
      end
      inherited btnRefresh: TBitBtn
        Top = 100
        TabOrder = 2
        ExplicitTop = 100
      end
      inherited btnIns: TBitBtn
        Top = 100
        TabOrder = 3
        ExplicitTop = 100
      end
      inherited stRecCnt: TStaticText
        Left = 4
        Top = 5
        Width = 52
        Height = 24
        Font.Height = -16
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 4
        ExplicitTop = 5
        ExplicitWidth = 52
        ExplicitHeight = 24
      end
      inherited btnInsLike: TBitBtn
        Top = 100
        TabOrder = 4
        ExplicitTop = 100
      end
      inherited btnUpd: TBitBtn
        Top = 100
        TabOrder = 5
        ExplicitTop = 100
      end
      object edBarcode: TcxTextEdit
        Left = 123
        Top = 3
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        OnFocusChanged = edBarcodeFocusChanged
        ParentFont = False
        Properties.OnChange = edBarcodePropertiesChange
        Style.BorderStyle = ebsFlat
        Style.Font.Charset = RUSSIAN_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -16
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        OnKeyDown = edBarcodeKeyDown
        Width = 319
      end
    end
    inherited pnlBottom: TPanel
      Top = 197
      Width = 534
      ExplicitTop = 197
      ExplicitWidth = 534
      DesignSize = (
        534
        30)
      inherited btnOK: TcxButton
        Left = 370
        ExplicitLeft = 370
      end
      inherited btnCancel: TcxButton
        Left = 453
        ExplicitLeft = 453
      end
    end
    inherited gr1: TcxGrid
      Top = 32
      Width = 534
      Height = 165
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Height = -15
      ParentFont = False
      ExplicitTop = 32
      ExplicitWidth = 534
      ExplicitHeight = 165
      inherited tvMain: TcxGridDBTableView
        DataController.KeyFieldNames = 'ID'
        Styles.Inactive = cxStyle1
        object clmMainID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
          Visible = False
        end
        object clmMainNAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'NAME'
          HeaderAlignmentHorz = taCenter
          Width = 234
        end
        object clmMainPHONE: TcxGridDBColumn
          Caption = #1058#1077#1083#1077#1092#1086#1085
          DataBinding.FieldName = 'PHONE'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object clmMainNOTE: TcxGridDBColumn
          Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
          DataBinding.FieldName = 'NOTE'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object clmMainCARD_NUMBER: TcxGridDBColumn
          Caption = #8470' '#1082#1072#1088#1090#1099
          DataBinding.FieldName = 'BARCODE'
          HeaderAlignmentHorz = taCenter
          Width = 129
        end
      end
    end
    inherited btnInsLike1: TBitBtn
      Left = 565
      Top = 3
      ExplicitLeft = 565
      ExplicitTop = 3
    end
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT G.G_CLIENT ID, G.NAME || COALESCE('#39' ('#1044#1054#1051#1043' '#39' || Z.SUMM_DOL' +
        'G || '#39')'#39', '#39#39') NAME, G.PHONE, G.NOTE, D.BARCODE'
      
        'FROM G_CLIENT G LEFT OUTER JOIN G_DISCONT_CARD D ON G.G_CLIENT =' +
        ' D.G_CLIENT'
      
        '                LEFT OUTER JOIN (SELECT SUM(SUMM - SUMM_FACT - S' +
        'UMM_BONUS) SUMM_DOLG , G_CLIENT FROM ZAKAZ WHERE IS_PAYED_ALL = ' +
        '0 GROUP BY G_CLIENT) Z ON G.G_CLIENT = Z.G_CLIENT'
      'WHERE G.IS_CATEGORY = 0'
      'AND G.IS_SUPPLIER = 0'
      'order by G.NAME')
  end
  object TimerChangeEd: TTimer
    Enabled = False
    Interval = 400
    OnTimer = TimerChangeEdTimer
    Left = 352
    Top = 152
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clWhite
    end
  end
end
