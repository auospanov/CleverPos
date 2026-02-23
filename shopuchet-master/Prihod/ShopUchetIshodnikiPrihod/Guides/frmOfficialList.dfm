inherited OfficialListForm: TOfficialListForm
  Left = 534
  Top = 192
  Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1080
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    inherited tvMain: TcxGridDBTableView
      object clmMainG_OFFICIAL: TcxGridDBColumn
        DataBinding.FieldName = 'G_OFFICIAL'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainFIO: TcxGridDBColumn
        Caption = #1060#1048#1054
        DataBinding.FieldName = 'FIO'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainIDN: TcxGridDBColumn
        Caption = #1048#1048#1053
        DataBinding.FieldName = 'IDN'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainDT: TcxGridDBColumn
        Caption = #1044#1056
        DataBinding.FieldName = 'DT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainAPP_NAME: TcxGridDBColumn
        Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
        DataBinding.FieldName = 'APP_NAME'
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
      'SELECT * FROM G_READ_G_OFFICIAL_LIST')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_DEL_G_OFFICIAL (?G_OFFICIAL_)')
    StoredProcName = 'G_DEL_G_OFFICIAL'
  end
end
