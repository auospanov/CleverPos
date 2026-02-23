inherited VozvratListForm: TVozvratListForm
  Left = 637
  Top = 202
  Caption = #1042#1086#1079#1074#1088#1072#1090' '#1090#1086#1074#1072#1088#1072
  PixelsPerInch = 96
  TextHeight = 14
  inherited dxDBGrid: TdxDBGrid
    KeyField = 'SKLAD'
    OnDblClick = nil
    Filter.Criteria = {00000000}
    RegistryPath = '\Software\BSB\ShopUchet\VozvratList'
    object dxDBGridSKLAD: TdxDBGridMaskColumn
      Alignment = taCenter
      HeaderAlignment = taCenter
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SKLAD'
    end
    object dxDBGridDATE_RECEIPT: TdxDBGridDateColumn
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1074#1086#1079#1074#1088#1072#1090#1072
      HeaderAlignment = taCenter
      Width = 102
      BandIndex = 0
      RowIndex = 0
      FieldName = 'DATE_RECEIPT'
    end
    object dxDBGridG_PRODUCT: TdxDBGridMaskColumn
      Alignment = taCenter
      HeaderAlignment = taCenter
      Visible = False
      Width = 74
      BandIndex = 0
      RowIndex = 0
      FieldName = 'G_PRODUCT'
    end
    object dxDBGridPRODUCT_NAME: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1058#1086#1074#1072#1088
      HeaderAlignment = taCenter
      Width = 74
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PRODUCT_NAME'
    end
    object dxDBGridAMOUNT: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      HeaderAlignment = taCenter
      Width = 74
      BandIndex = 0
      RowIndex = 0
      FieldName = 'AMOUNT'
    end
    object dxDBGridPRICE: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1062#1077#1085#1072
      HeaderAlignment = taCenter
      Width = 74
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PRICE'
    end
    object dxDBGridSUMM: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1057#1091#1084#1084#1072
      HeaderAlignment = taCenter
      Width = 74
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SUMM'
    end
    object dxDBGridOSNOVANIE: TdxDBGridMaskColumn
      Alignment = taCenter
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 74
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OSNOVANIE'
    end
    object dxDBGridIS_VOZVRAT: TdxDBGridMaskColumn
      Alignment = taCenter
      HeaderAlignment = taCenter
      Visible = False
      Width = 74
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IS_VOZVRAT'
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      26
      0)
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM READ_SKLAD_LIST(?IS_VOZVRAT_)')
    Filter = 'IS_VOZVRAT = 1'
    Filtered = True
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE DEL_SKLAD (?SKLAD_, ?ALLOW_SELL_ABSENT_GOODS_)')
    StoredProcName = 'DEL_SKLAD'
  end
end
