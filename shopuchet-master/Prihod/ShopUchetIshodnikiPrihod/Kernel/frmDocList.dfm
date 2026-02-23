inherited DocListForm: TDocListForm
  Caption = #1046#1091#1088#1085#1072#1083
  PixelsPerInch = 96
  TextHeight = 14
  inherited gr1: TcxGrid
    Margins.Left = 3
    Margins.Top = 3
    Margins.Right = 3
    Margins.Bottom = 3
    inherited tvMain: TcxGridDBTableView
      object cxgrdbclmnMainNUM: TcxGridDBColumn
        Caption = #1053#1086#1084#1077#1088
        DataBinding.FieldName = 'NUM'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Width = 150
      end
      object cxgrdbclmnMainDOCS_DATE: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1085#1077#1090#1072
        DataBinding.FieldName = 'DOCS_DATE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
      end
      object clmMainG_FIRM: TcxGridDBColumn
        Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103'-'#1087#1086#1089#1090#1072#1074#1097#1080#1082
        DataBinding.FieldName = 'G_FIRM'
        Width = 150
      end
      object clmMainG_CLIENT: TcxGridDBColumn
        Caption = #1050#1083#1080#1077#1085#1090
        DataBinding.FieldName = 'G_CLIENT'
        Width = 150
      end
      object cxgrdbclmnMainG_OFFICIAL: TcxGridDBColumn
        Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
        DataBinding.FieldName = 'G_OFFICIAL'
        Width = 150
      end
      object cxgrdbclmnMainNOTE: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        DataBinding.FieldName = 'NOTE'
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
          ItemName = 'dxBarButtonView'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonIns'
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
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonClose'
        end>
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT * FROM DOCS_READ(?DOC_TYPE_, ?IS_ALL_, ?BEGIN_DATE_, ?END' +
        '_DATE_)')
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE DOCS_DEL (?DOCS_)')
    StoredProcName = 'DOCS_DEL'
  end
end
