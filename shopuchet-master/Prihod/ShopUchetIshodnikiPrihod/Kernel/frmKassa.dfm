inherited KassaForm: TKassaForm
  Left = 418
  Top = 205
  Caption = #1056#1072#1089#1093#1086#1076
  ClientHeight = 234
  ClientWidth = 481
  ExplicitWidth = 487
  ExplicitHeight = 260
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 461
    Height = 187
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    ExplicitWidth = 461
    ExplicitHeight = 187
    object ShapePayment: TShape
      Left = 8
      Top = 34
      Width = 177
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape5: TShape
      Left = 8
      Top = 108
      Width = 176
      Height = 70
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape1: TShape
      Left = 8
      Top = 59
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape25: TShape
      Left = 8
      Top = 9
      Width = 177
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 84
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 90
      Width = 35
      Height = 14
      Caption = #1057#1091#1084#1084#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape4: TShape
      Left = 183
      Top = 84
      Width = 268
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 15
      Width = 94
      Height = 14
      Caption = #1057#1090#1072#1090#1100#1103' '#1088#1072#1089#1093#1086#1076#1086#1074
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape26: TShape
      Left = 183
      Top = 9
      Width = 268
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 18
      Top = 65
      Width = 26
      Height = 14
      Caption = #1044#1072#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape3: TShape
      Left = 183
      Top = 59
      Width = 268
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Label3: TLabel
      Left = 18
      Top = 122
      Width = 71
      Height = 14
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape6: TShape
      Left = 183
      Top = 109
      Width = 268
      Height = 69
      Pen.Color = clBtnShadow
    end
    object lbPayment: TLabel
      Left = 19
      Top = 41
      Width = 90
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1087#1086#1089#1086#1073' '#1088#1072#1089#1095#1077#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object ShapePayment1: TShape
      Left = 183
      Top = 34
      Width = 268
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
    end
    object edDate: TcxDateEdit
      Left = 189
      Top = 62
      Properties.Alignment.Horz = taRightJustify
      Properties.InputKind = ikMask
      Properties.UseLeftAlignmentOnEditing = False
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      Style.ButtonStyle = btsDefault
      TabOrder = 2
      Width = 257
    end
    object leStatya: TcxLookupComboBox
      Left = 189
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.GridMode = True
      Properties.KeyFieldNames = 'G_PRIHOD_RASHOD'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsReadStatya
      Properties.OnChange = leStatyaPropertiesChange
      Style.BorderStyle = ebsFlat
      TabOrder = 0
      Width = 257
    end
    object edSumm: TcxCurrencyEdit
      Left = 189
      Top = 86
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 0c
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00'
      Properties.UseLeftAlignmentOnEditing = False
      Properties.UseThousandSeparator = True
      Style.StyleController = dxEditStyleController
      Style.TransparentBorder = True
      TabOrder = 3
      Width = 257
    end
    object Memo: TcxMemo
      Left = 189
      Top = 112
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 200
      Style.StyleController = dxEditStyleController
      TabOrder = 4
      Height = 62
      Width = 257
    end
    object cbPaymentType: TcxComboBox
      Left = 189
      Top = 37
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1053#1072#1083#1080#1095#1085#1099#1081
        #1041#1077#1079#1085#1072#1083#1080#1095#1085#1099#1081)
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Text = #1053#1072#1083#1080#1095#1085#1099#1081
      Width = 257
    end
  end
  inherited btnOk: TcxButton
    Left = 311
    Top = 202
    ExplicitLeft = 311
    ExplicitTop = 202
  end
  inherited btnCancel: TcxButton
    Left = 394
    Top = 202
    ExplicitLeft = 394
    ExplicitTop = 202
  end
  inherited btHelp: TcxButton
    Top = 202
    ExplicitTop = 202
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 200
    Top = 208
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE K_GET_KASSA (?KASSA_)')
    StoredProcName = 'K_GET_KASSA'
    Left = 104
    Top = 208
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE K_INS_KASSA (?ACTION_, ?G_PRIHOD_RASHOD_, ?SUM' +
        'M_, ?ACTION_DATE_, ?NOTE_, ?ZAKAZ_, ?SKLAD_, ?G_PAYMENT_TYPE_, ?' +
        'G_TOCHKA_)')
    StoredProcName = 'K_INS_KASSA'
    Left = 136
    Top = 208
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE K_UPD_KASSA (?KASSA_, ?ACTION_, ?G_PRIHOD_RASH' +
        'OD_, ?SUMM_, ?ACTION_DATE_, ?NOTE_, ?ZAKAZ_, ?SKLAD_, ?G_PAYMENT' +
        '_TYPE_)')
    StoredProcName = 'K_UPD_KASSA'
    Left = 168
    Top = 208
  end
  object dsReadStatya: TDataSource
    DataSet = spReadStatya
    Left = 408
    Top = 8
  end
  object spReadStatya: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from G_READ_G_PRIHOD_RASHOD_LIST(?ACTION_)')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 368
    Top = 8
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object spGetOstatok: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      
        'EXECUTE PROCEDURE K_GET_KASSA_SUMM (?G_TOCHKA_, ?DATE_, ?G_PAYME' +
        'NT_TYPE_)')
    StoredProcName = 'K_GET_KASSA_SUMM'
    Left = 256
    Top = 190
  end
end
