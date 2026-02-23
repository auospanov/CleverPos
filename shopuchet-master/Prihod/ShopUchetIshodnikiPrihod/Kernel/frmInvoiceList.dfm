inherited InvoiceListForm: TInvoiceListForm
  Caption = #1046#1091#1088#1085#1072#1083' '#1089#1095#1077#1090'-'#1092#1072#1082#1090#1091#1088
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    inherited tvMain: TcxGridDBTableView
      object clmMainINVOICE: TcxGridDBColumn
        DataBinding.FieldName = 'INVOICE'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainNUM: TcxGridDBColumn
        Caption = #1053#1086#1084#1077#1088
        DataBinding.FieldName = 'NUM'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainINIT_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
        DataBinding.FieldName = 'INIT_DATE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainAGREEMENT: TcxGridDBColumn
        Caption = #1044#1086#1075#1086#1074#1086#1088
        DataBinding.FieldName = 'AGREEMENT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainG_CLIENT: TcxGridDBColumn
        DataBinding.FieldName = 'G_CLIENT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainCLIENT_NAME: TcxGridDBColumn
        Caption = #1050#1083#1080#1077#1085#1090
        DataBinding.FieldName = 'CLIENT_NAME'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainIDN_CLIENT: TcxGridDBColumn
        Caption = #1048#1048#1053'/'#1041#1048#1053' '#1082#1083#1080#1077#1085#1090#1072
        DataBinding.FieldName = 'IDN_CLIENT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainADDRESS_POKUPATEL: TcxGridDBColumn
        Caption = #1040#1076#1088#1077#1089' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
        DataBinding.FieldName = 'ADDRESS_POKUPATEL'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainFIO_DOC: TcxGridDBColumn
        Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
        DataBinding.FieldName = 'FIO_DOC'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
    end
  end
  inherited dxBarManagerChild: TdxBarManager
    DockControlHeights = (
      0
      0
      26
      0)
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM INV_READ_INVOICE_LIST')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE INV_DEL_INVOICE (?INVOICE_)')
    StoredProcName = 'INV_DEL_INVOICE'
  end
end
