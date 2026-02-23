inherited DiscountListForm: TDiscountListForm
  Left = 534
  Top = 192
  Caption = #1057#1082#1080#1076#1082#1080' '#1085#1072' '#1090#1086#1074#1072#1088
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    inherited tvMain: TcxGridDBTableView
      OptionsSelection.MultiSelect = True
      OptionsView.HeaderAutoHeight = True
      object clmMainG_DISCOUNT: TcxGridDBColumn
        DataBinding.FieldName = 'G_DISCOUNT'
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object clmMainG_PRODUCT: TcxGridDBColumn
        DataBinding.FieldName = 'G_PRODUCT'
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object clmMainG_PRODUCT_PAR_NAME: TcxGridDBColumn
        Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074
        DataBinding.FieldName = 'G_PRODUCT_PAR_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object cxgrdbclmnMainG_PRODUCT_NAME: TcxGridDBColumn
        Caption = #1058#1086#1074#1072#1088
        DataBinding.FieldName = 'G_PRODUCT_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainARTICUL: TcxGridDBColumn
        Caption = #1040#1088#1090#1080#1082#1091#1083
        DataBinding.FieldName = 'ARTICUL'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object clmMainBARCODE: TcxGridDBColumn
        Caption = #1064#1090#1088#1080#1093#1082#1086#1076
        DataBinding.FieldName = 'BARCODE'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object clmMainNOMENCLATUR_NUM: TcxGridDBColumn
        Caption = #1053#1086#1084#1077#1085#1082#1083'. '#1085#1086#1084#1077#1088
        DataBinding.FieldName = 'NOMENCLATUR_NUM'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object cxgrdbclmnMainDATE_BEGIN: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
        DataBinding.FieldName = 'DATE_BEGIN'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
      end
      object cxgrdbclmnMainDATE_END: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1082#1086#1085#1094#1072
        DataBinding.FieldName = 'DATE_END'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
      end
      object cxgrdbclmnMainNAME: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1072#1082#1094#1080#1080
        DataBinding.FieldName = 'NAME'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object cxgrdbclmnMainPRICE: TcxGridDBColumn
        Caption = #1062#1077#1085#1072
        DataBinding.FieldName = 'PRICE'
        HeaderAlignmentHorz = taCenter
      end
      object cxgrdbclmnMainSKIDKA_PROC: TcxGridDBColumn
        Caption = #1057#1082#1080#1076#1082#1072' '#1074' %'
        DataBinding.FieldName = 'SKIDKA_PROC'
        HeaderAlignmentHorz = taCenter
      end
      object cxgrdbclmnMainSKIDKA_SUM: TcxGridDBColumn
        Caption = #1057#1082#1080#1076#1082#1072' '#1074' '#1090#1077#1085#1075#1077
        DataBinding.FieldName = 'SKIDKA_SUM'
        HeaderAlignmentHorz = taCenter
      end
      object cxgrdbclmnMainColumn1: TcxGridDBColumn
        Caption = #1057#1082#1080#1076#1082#1072' '#1087#1086#1089#1090#1086#1103#1085#1085#1072
        DataBinding.FieldName = 'IS_CONST'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        HeaderAlignmentHorz = taCenter
        Width = 77
      end
      object clmTOCHKA_NAME: TcxGridDBColumn
        Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1085#1072
        DataBinding.FieldName = 'TOCHKA_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    LookAndFeel.SkinName = ''
    DockControlHeights = (
      0
      0
      26
      0)
    inherited dxBarManagerChildBar1: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStaticRecCnt'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonEnableAutoRefresh'
        end
        item
          UserDefine = [udWidth]
          UserWidth = 23
          Visible = True
          ItemName = 'dxBarSpinEditHeaderHeight'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarCombo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonView'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonIns'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonInsLike'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonUpd'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonDel'
        end
        item
          Visible = True
          ItemName = 'btn1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
    object dxBarCombo: TdxBarCombo
      Caption = #1040#1082#1094#1080#1080
      Category = 0
      Hint = #1040#1082#1094#1080#1080
      Visible = ivAlways
      OnChange = dxBarComboChange
      Text = #1040#1082#1090#1080#1074#1085#1099#1077
      Items.Strings = (
        #1042#1089#1077
        #1040#1082#1090#1080#1074#1085#1099#1077)
      ItemIndex = 1
    end
    object btn1: TdxBarButton
      Action = aDelNolOstatok
      Category = 0
    end
  end
  inherited alChild: TActionList
    object aDelNolOstatok: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086' '#1090#1086#1074#1072#1088#1072#1084' '#1089' 0 '#1086#1089#1090#1072#1090#1082#1086#1084
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1072#1082#1094#1080#1080' '#1087#1086' '#1090#1086#1074#1072#1088#1072#1084' '#1089' '#1085#1091#1083#1077#1074#1099#1084' '#1086#1089#1090#1072#1090#1082#1086#1084
      ImageIndex = 162
      OnExecute = aDelNolOstatokExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_READ_G_DISCOUNT_LIST(?IS_ALL_)')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_DEL_G_DISCOUNT (?G_DISCOUNT_)')
    StoredProcName = 'G_DEL_G_DISCOUNT'
  end
end
