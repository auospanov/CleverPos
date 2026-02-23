inherited GUnitListForm: TGUnitListForm
  Left = 534
  Top = 192
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1077#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1081
  ExplicitWidth = 549
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    inherited tvMain: TcxGridDBTableView
      OptionsCustomize.ColumnFiltering = False
      OptionsView.GroupByBox = False
      object clmMainG_UNIT: TcxGridDBColumn
        DataBinding.FieldName = 'G_UNIT'
        Visible = False
        Width = 150
      end
      object clmMainNAME: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'NAME'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object clmMainSHORT_NAME: TcxGridDBColumn
        Caption = #1050#1088#1072#1090#1082'. '#1085#1072#1080#1084'-'#1085#1080#1077
        DataBinding.FieldName = 'SHORT_NAME'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
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
      'SELECT * FROM G_READ_G_UNIT_LIST')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_DEL_G_UNIT (?G_UNIT_)')
    StoredProcName = 'G_DEL_G_UNIT'
  end
end
