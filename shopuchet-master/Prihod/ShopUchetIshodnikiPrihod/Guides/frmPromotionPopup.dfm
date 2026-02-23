inherited PromotionPopupForm: TPromotionPopupForm
  Caption = #1050#1072#1085#1072#1083#1099' '#1087#1088#1086#1076#1074#1080#1078#1077#1085#1080#1103
  ClientHeight = 196
  ClientWidth = 446
  OnShow = FormShow
  ExplicitWidth = 454
  ExplicitHeight = 224
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    Width = 446
    Height = 196
    ExplicitWidth = 446
    ExplicitHeight = 196
    inherited pnlTop: TPanel
      Width = 446
      ExplicitWidth = 446
      inherited btnRefresh: TBitBtn
        Left = 613
        TabOrder = 2
        ExplicitLeft = 613
      end
      inherited btnIns: TBitBtn
        Left = 46
        TabOrder = 0
        ExplicitLeft = 46
      end
      inherited btnInsLike: TBitBtn
        Left = 707
        Enabled = False
        TabOrder = 3
        ExplicitLeft = 707
      end
      inherited btnUpd: TBitBtn
        Left = 171
        TabOrder = 1
        ExplicitLeft = 171
      end
    end
    inherited pnlBottom: TPanel
      Top = 166
      Width = 446
      ExplicitTop = 166
      ExplicitWidth = 446
      inherited btnOK: TcxButton
        Left = 281
        ExplicitLeft = 281
      end
      inherited btnCancel: TcxButton
        Left = 365
        ExplicitLeft = 365
      end
    end
    inherited gr1: TcxGrid
      Width = 446
      Height = 141
      ExplicitWidth = 446
      ExplicitHeight = 141
      inherited tvMain: TcxGridDBTableView
        DataController.KeyFieldNames = 'ID'
        object tvMainG_PROMOTION: TcxGridDBColumn
          DataBinding.FieldName = 'G_PROMOTION'
          Visible = False
        end
        object tvMainNAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'NAME'
          Width = 430
        end
        object tvMainIS_ACTIVE: TcxGridDBColumn
          DataBinding.FieldName = 'IS_ACTIVE'
          Visible = False
        end
      end
    end
    inherited btnInsLike1: TBitBtn
      Left = 296
      ExplicitLeft = 296
    end
  end
  inherited spRead: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_PROMOTION_READ')
  end
  inherited spDel: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_PROMOTION_DEL (?G_PROMOTION_)')
    StoredProcName = 'G_PROMOTION_DEL'
  end
end
