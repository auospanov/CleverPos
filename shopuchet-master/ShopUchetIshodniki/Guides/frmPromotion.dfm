inherited PromotionForm: TPromotionForm
  Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1082#1072#1085#1072#1083#1072' '#1087#1088#1086#1076#1074#1080#1078#1077#1085#1080#1103
  ClientHeight = 103
  ClientWidth = 547
  ExplicitWidth = 553
  ExplicitHeight = 129
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 532
    Height = 58
    ExplicitWidth = 532
    ExplicitHeight = 58
    object Shape2: TShape
      Left = 8
      Top = 17
      Width = 137
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 24
      Width = 83
      Height = 14
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
      Left = 144
      Top = 17
      Width = 375
      Height = 26
      Pen.Color = clBtnShadow
    end
    object edName: TcxTextEdit
      Left = 150
      Top = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 150
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 361
    end
  end
  inherited btnOk: TcxButton
    Left = 375
    Top = 69
    ExplicitLeft = 375
    ExplicitTop = 69
  end
  inherited btnCancel: TcxButton
    Left = 459
    Top = 69
    ExplicitLeft = 459
    ExplicitTop = 69
  end
  inherited btHelp: TcxButton
    Top = 69
    ExplicitTop = 69
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_PROMOTION_GET (?G_PROMOTION_)')
    StoredProcName = 'G_PROMOTION_GET'
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_PROMOTION_INS (?NAME_)')
    StoredProcName = 'G_PROMOTION_INS'
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_PROMOTION_UPD (?G_PROMOTION_, ?NAME_)')
    StoredProcName = 'G_PROMOTION_UPD'
  end
end
