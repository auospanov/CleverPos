inherited PopupClientListForm: TPopupClientListForm
  Caption = #1055#1086#1080#1089#1082' '#1082#1083#1080#1077#1085#1090#1072
  ClientHeight = 244
  ClientWidth = 459
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 467
  ExplicitHeight = 272
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 459
    Height = 244
    ExplicitWidth = 459
    ExplicitHeight = 244
    inherited pnlTop: TPanel
      Width = 459
      ExplicitWidth = 459
      object Label10: TLabel [0]
        Left = 58
        Top = 3
        Width = 40
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1086#1080#1089#1082
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
        TabOrder = 2
        ExplicitTop = 100
      end
      inherited btnIns: TBitBtn
        Top = 100
        TabOrder = 3
        ExplicitTop = 100
      end
      inherited stRecCnt: TStaticText
        TabOrder = 1
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
      object edBarcode: TEdit
        Left = 104
        Top = 1
        Width = 259
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        CharCase = ecLowerCase
        MaxLength = 250
        TabOrder = 0
        OnChange = edBarcodeChange
      end
    end
    inherited pnlBottom: TPanel
      Top = 214
      Width = 459
      ExplicitTop = 214
      ExplicitWidth = 459
      inherited btnOK: TcxButton
        Left = 294
        ExplicitLeft = 294
      end
      inherited btnCancel: TcxButton
        Left = 376
        ExplicitLeft = 376
      end
    end
    inherited gr1: TcxGrid
      Width = 459
      Height = 189
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ExplicitWidth = 459
      ExplicitHeight = 189
      inherited tvMain: TcxGridDBTableView
        DataController.KeyFieldNames = 'ID'
        OptionsCustomize.ColumnFiltering = False
        object clmMainID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
          Visible = False
          Width = 150
        end
        object clmMainNAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'NAME'
          Width = 270
        end
        object clmMainPHONE: TcxGridDBColumn
          Caption = #1058#1077#1083#1077#1092#1086#1085
          DataBinding.FieldName = 'PHONE'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 119
        end
        object clmMainColumn1: TcxGridDBColumn
          Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
          DataBinding.FieldName = 'NOTE'
          HeaderAlignmentHorz = taCenter
          Width = 106
        end
      end
    end
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT G_CLIENT ID, NAME, PHONE, NOTE'
      'FROM G_CLIENT '
      'WHERE IS_CATEGORY = 0 '
      'AND IS_SUPPLIER = :Is_supplier_'
      'order by name')
  end
  object TimerChangeEd: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerChangeEdTimer
    Left = 352
    Top = 152
  end
end
