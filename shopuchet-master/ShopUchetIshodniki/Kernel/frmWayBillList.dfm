inherited WayBillListForm: TWayBillListForm
  Caption = #1046#1091#1088#1085#1072#1083' '#1085#1072#1082#1083#1072#1076#1085#1099#1093' '#1085#1072' '#1086#1090#1087#1091#1089#1082' '#1090#1086#1074#1072#1088#1086#1074' '#1085#1072' '#1089#1090#1086#1088#1086#1085#1091
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    inherited tvMain: TcxGridDBTableView
      object clmMainNUM: TcxGridDBColumn
        Caption = #1053#1086#1084#1077#1088
        DataBinding.FieldName = 'NUM'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainINIT_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072
        DataBinding.FieldName = 'INIT_DATE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainPOSTAVSHIK: TcxGridDBColumn
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100
        DataBinding.FieldName = 'POSTAVSHIK'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainIDN: TcxGridDBColumn
        Caption = #1048#1048#1053'/'#1041#1048#1053' '#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1103
        DataBinding.FieldName = 'IDN'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainGRUZOPOLUCHATEL: TcxGridDBColumn
        Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100
        DataBinding.FieldName = 'GRUZOPOLUCHATEL'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainTRANSP_NAKLAD: TcxGridDBColumn
        Caption = #1058#1058#1053
        DataBinding.FieldName = 'TRANSP_NAKLAD'
        HeaderAlignmentHorz = taCenter
        Width = 150
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
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM W_READ_WAYBILL_LIST')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE W_DEL_WAYBILL (?WAYBILL_)')
    StoredProcName = 'W_DEL_WAYBILL'
  end
end
