inherited ClientCategoryForm: TClientCategoryForm
  Left = 558
  Top = 219
  Caption = #1056#1077#1082#1080#1079#1080#1090#1099' '#1082#1072#1090#1077#1075#1086#1088#1080#1080
  ClientHeight = 114
  ClientWidth = 589
  ExplicitWidth = 595
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 569
    Height = 70
    ExplicitWidth = 569
    ExplicitHeight = 102
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
    object leClientCategory: TcxLookupComboBox
      Left = 190
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.KeyFieldNames = 'G_CLIENT'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsClientCategory
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 368
    end
    object edName: TcxTextEdit
      Left = 190
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 250
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 368
    end
  end
  inherited btnOk: TcxButton
    Left = 417
    Top = 82
    ExplicitLeft = 417
    ExplicitTop = 114
  end
  inherited btnCancel: TcxButton
    Left = 502
    Top = 82
    ExplicitLeft = 502
    ExplicitTop = 114
  end
  inherited btHelp: TcxButton
    Top = 82
    ExplicitTop = 114
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_CLIENT (?G_CLIENT_)')
    StoredProcName = 'G_GET_G_CLIENT'
    Left = 104
    Top = 106
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_INS_G_CLIENT_CAT (?G_CLIENT_PARENT_, ?NAME_,' +
        ' ?IS_SUPPLIER_)')
    StoredProcName = 'G_INS_G_CLIENT_CAT'
    Left = 136
    Top = 106
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_CLIENT_CAT (?G_CLIENT_, ?G_CLIENT_PARE' +
        'NT_, ?IS_SUPPLIER_, ?NAME_)')
    StoredProcName = 'G_UPD_G_CLIENT_CAT'
    Left = 168
    Top = 106
  end
  object spClientCategory: TpFIBDataSet
    SelectSQL.Strings = (
      'WITH RECURSIVE TREE AS (SELECT T.G_CLIENT,'
      '                               T.G_CLIENT_PARENT,'
      '                               T.NAME,'
      
        '                               T.NAME PATH,       --'#1076#1083#1103' '#1089#1086#1088#1090#1080#1088#1086#1074 +
        #1082#1080
      '                               '#39'  '#39' LVL'
      '                          FROM G_CLIENT T'
      '                         WHERE T.G_CLIENT_PARENT IS NULL'
      '                           AND T.is_supplier = :IS_SUPPLIER_'
      '                           AND T.G_CLIENT <> :G_CLIENT_'
      '                        UNION ALL'
      '                        SELECT T.G_CLIENT,'
      '                               T.G_CLIENT_PARENT,'
      '                               GG.LVL||T.NAME NAME,'
      
        '                               GG.PATH||'#39' - '#39'||T.NAME,     --'#1044#1051#1071 +
        ' '#1057#1054#1056#1058#1048#1056#1054#1042#1050#1048
      '                               GG.LVL||'#39'  '#39' LVL'
      
        '                          FROM G_CLIENT T INNER JOIN TREE GG ON ' +
        'GG.G_CLIENT = T.G_CLIENT_PARENT'
      '                         WHERE T.IS_CATEGORY = 1'
      '                           AND T.IS_SUPPLIER = :IS_SUPPLIER_'
      '                           AND T.G_CLIENT <> :G_CLIENT_'
      '                        )'
      '    SELECT * FROM TREE ORDER BY 4, 2')
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 464
    Top = 8
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsClientCategory: TDataSource
    DataSet = spClientCategory
    Left = 496
    Top = 8
  end
end
