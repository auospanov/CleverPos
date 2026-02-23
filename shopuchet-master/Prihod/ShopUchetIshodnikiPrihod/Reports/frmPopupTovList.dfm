inherited PopupTovListForm: TPopupTovListForm
  Left = 523
  Top = 276
  Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 191
  ClientWidth = 411
  OldCreateOrder = True
  OnCreate = FormCreate
  ExplicitWidth = 419
  ExplicitHeight = 219
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 411
    Height = 191
    ExplicitWidth = 411
    ExplicitHeight = 191
    inherited pnlTop: TPanel
      Width = 411
      ExplicitWidth = 411
      object Label10: TLabel [0]
        Left = 50
        Top = 3
        Width = 91
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086#1080#1089#1082' '#1090#1086#1074#1072#1088#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object sbClear: TSpeedButton [1]
        Left = 367
        Top = 1
        Width = 26
        Height = 22
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
        TabOrder = 1
        ExplicitTop = 100
      end
      inherited btnIns: TBitBtn
        Top = 100
        TabOrder = 2
        ExplicitTop = 100
      end
      inherited stRecCnt: TStaticText
        TabOrder = 0
      end
      inherited btnInsLike: TBitBtn
        Top = 100
        TabOrder = 3
        ExplicitTop = 100
      end
      inherited btnUpd: TBitBtn
        Top = 100
        TabOrder = 4
        ExplicitTop = 100
      end
      object edBarcode: TcxTextEdit
        Left = 145
        Top = 1
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Properties.OnChange = edBarcodePropertiesChange
        Style.BorderStyle = ebsFlat
        TabOrder = 5
        OnKeyDown = edBarcodeKeyDown
        Width = 217
      end
    end
    inherited pnlBottom: TPanel
      Top = 161
      Width = 411
      ExplicitTop = 161
      ExplicitWidth = 411
      DesignSize = (
        411
        30)
      inherited btnOK: TcxButton
        Left = 247
        ExplicitLeft = 247
      end
      inherited btnCancel: TcxButton
        Left = 330
        ExplicitLeft = 330
      end
    end
    inherited gr1: TcxGrid
      Width = 411
      Height = 136
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ExplicitWidth = 411
      ExplicitHeight = 136
      inherited tvMain: TcxGridDBTableView
        DataController.KeyFieldNames = 'ID'
        object clmMainNAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'NAME'
          Width = 257
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
