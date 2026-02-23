inherited PopupSaleTovListForm: TPopupSaleTovListForm
  Left = 523
  Top = 276
  Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 319
  ClientWidth = 542
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 550
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 542
    Height = 319
    ExplicitWidth = 411
    ExplicitHeight = 191
    inherited pnlTop: TPanel
      Width = 542
      Height = 41
      ExplicitWidth = 596
      ExplicitHeight = 41
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
        Left = 600
        TabOrder = 1
        ExplicitLeft = 600
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
        Left = 8
        Top = 6
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
        Style.Font.Height = -17
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        OnKeyDown = edBarcodeKeyDown
        Width = 474
      end
      object sbClear: TcxButton
        Left = 487
        Top = 5
        Width = 50
        Height = 30
        LookAndFeel.Kind = lfFlat
        OptionsImage.Glyph.Data = {
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
        TabOrder = 6
        OnClick = sbClearClick
      end
    end
    inherited pnlBottom: TPanel
      Top = 289
      Width = 542
      ExplicitTop = 161
      ExplicitWidth = 411
      DesignSize = (
        542
        30)
      inherited btnOK: TcxButton
        Left = 378
        ExplicitLeft = 247
      end
      inherited btnCancel: TcxButton
        Left = 461
        ExplicitLeft = 330
      end
    end
    inherited gr1: TcxGrid
      Top = 41
      Width = 542
      Height = 248
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Height = -15
      ParentFont = False
      ExplicitWidth = 411
      ExplicitHeight = 136
      inherited tvMain: TcxGridDBTableView
        DataController.KeyFieldNames = 'ID'
        object clmMainNAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'NAME'
          Width = 301
        end
        object clmMainARTICUL: TcxGridDBColumn
          Caption = #1040#1088#1090#1080#1082#1091#1083
          DataBinding.FieldName = 'ARTICUL'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 110
        end
        object clmMainBARCODE: TcxGridDBColumn
          Caption = #1064#1090#1088#1080#1093#1082#1086#1076
          DataBinding.FieldName = 'BARCODE'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 121
        end
      end
    end
    inherited btnInsLike1: TBitBtn
      Left = 600
      Top = 12
      ExplicitLeft = 600
      ExplicitTop = 12
    end
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'select G.g_product as id,'
      '       G.name,'
      '       G.articul,'
      '       G.barcode,'
      '       G.price,'
      '       G.PLACE'
      '  from g_product G,'
      '       (SELECT DISTINCT(SS.G_PRODUCT)'
      '          FROM (WITH RECURSIVE TREE'
      '                AS (SELECT G.G_PRODUCT'
      '                      FROM G_PRODUCT G'
      
        '                     WHERE G.G_PRODUCT = DECODE(:g_product_par_,' +
        ' -1, G.G_PRODUCT, :g_product_par_)'
      '                       AND G.IS_CATEGORY = 1'
      '                    UNION ALL'
      '                    SELECT G.G_PRODUCT'
      
        '                      FROM G_PRODUCT G INNER JOIN TREE PRIOR ON ' +
        'PRIOR.G_PRODUCT = G.G_PRODUCT_PAR'
      '                     WHERE G.IS_CATEGORY = 1'
      '                  )'
      '               SELECT * FROM TREE) SS) S1'
      'where G.G_PRODUCT_PAR = S1.G_PRODUCT'
      'and G.is_active = 1'
      'and G.is_category = 0'
      'ORDER BY G.NAME, G.ARTICUL, G.G_PRODUCT'
      ' '
      ' ')
  end
  object TimerChangeEd: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerChangeEdTimer
    Left = 352
    Top = 152
  end
end
