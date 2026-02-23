inherited CategoryForm: TCategoryForm
  Left = 499
  Top = 193
  Caption = #1056#1077#1082#1080#1079#1080#1090#1099' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
  ClientHeight = 141
  ClientWidth = 593
  ExplicitWidth = 599
  ExplicitHeight = 167
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 581
    Height = 97
    ExplicitWidth = 581
    ExplicitHeight = 97
    object Shape25: TShape
      Left = 8
      Top = 9
      Width = 177
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 34
      Width = 176
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 40
      Width = 83
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
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
      Top = 34
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 15
      Width = 152
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' ('#1088#1086#1076#1080#1090#1077#1083#1100#1089#1082#1072#1103')'
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
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object leCategory: TcxLookupComboBox
      Left = 190
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'G_PRODUCT'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end
        item
          MinWidth = 0
          Width = 0
          FieldName = 'NAME_FILTER'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsProductCategory
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 368
    end
    object edName: TcxTextEdit
      Left = 190
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 368
    end
    object cbDoNotShow: TcxCheckBox
      Left = 8
      Top = 69
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akBottom]
      Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074' "'#1056#1072#1073#1086#1095#1077#1084' '#1084#1077#1089#1090#1077' '#1082#1072#1089#1089#1080#1088#1072'"'
      Style.StyleController = dxEditStyleController
      TabOrder = 2
      Width = 289
    end
  end
  inherited btnOk: TcxButton
    Left = 417
    Top = 109
    ExplicitLeft = 417
    ExplicitTop = 109
  end
  inherited btnCancel: TcxButton
    Left = 504
    Top = 109
    Width = 83
    ExplicitLeft = 504
    ExplicitTop = 109
    ExplicitWidth = 83
  end
  inherited btHelp: TcxButton
    Top = 433
    ExplicitTop = 433
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited tranRead: TpFIBTransaction
    Left = 16
    Top = 104
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_PRODUCT (?G_PRODUCT_)')
    StoredProcName = 'G_GET_G_PRODUCT'
    Left = 48
    Top = 104
  end
  inherited tranWrite: TpFIBTransaction
    Left = 80
    Top = 104
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_INS_G_PRODUCT_CAT (?G_PRODUCT_PAR_, ?NAME_, ' +
        '?IS_KIT_, ?DO_NOT_SHOW_RMK_, ?IS_CATEGORY_, ?UPLOAD_TO_EXT_APP_)')
    StoredProcName = 'G_INS_G_PRODUCT_CAT'
    Left = 112
    Top = 104
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_PRODUCT_CAT (?G_PRODUCT_, ?G_PRODUCT_P' +
        'AR_, ?NAME_, ?IS_KIT_, ?DO_NOT_SHOW_RMK_, ?IS_CATEGORY_, ?UPLOAD' +
        '_TO_EXT_APP_)')
    StoredProcName = 'G_UPD_G_PRODUCT_CAT'
    Left = 144
    Top = 104
  end
  object spProductCategory: TpFIBDataSet
    SelectSQL.Strings = (
      'WITH RECURSIVE TREE AS (SELECT T.G_PRODUCT,'
      '                               T.G_PRODUCT_PAR,'
      '                               T.NAME,'
      
        '                               T.NAME PATH,       --'#1076#1083#1103' '#1089#1086#1088#1090#1080#1088#1086#1074 +
        #1082#1080
      '                               '#39'  '#39' LVL,'
      
        '                               DECODE(T.G_PRODUCT, -1, '#39#1041#1077#1079' '#1075#1088#1091#1087 +
        #1087#1099#39', T.NAME) NAME_FILTER'
      '                          FROM G_PRODUCT T'
      '                         WHERE T.G_PRODUCT_PAR IS NULL'
      '                           AND G_PRODUCT <> :G_PRODUCT_'
      '                        UNION ALL'
      '                        SELECT T.G_PRODUCT,'
      '                               T.G_PRODUCT_PAR,'
      '                               GG.LVL||T.NAME NAME,'
      
        '                               GG.PATH||'#39' - '#39'||T.NAME,     --'#1044#1051#1071 +
        ' '#1057#1054#1056#1058#1048#1056#1054#1042#1050#1048
      '                               GG.LVL||'#39'  '#39' LVL,'
      '                               T.NAME NAME_FILTER'
      
        '                          FROM G_PRODUCT T INNER JOIN TREE GG ON' +
        ' GG.G_PRODUCT = T.G_PRODUCT_PAR'
      '                         WHERE T.IS_CATEGORY = 1'
      '                           AND G_PRODUCT <> :G_PRODUCT_'
      '                        )'
      '    SELECT * FROM TREE ORDER BY 4, 2')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 480
    Top = 8
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsProductCategory: TDataSource
    DataSet = spProductCategory
    Left = 520
    Top = 8
  end
end
