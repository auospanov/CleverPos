inherited TochkaForm: TTochkaForm
  Left = 577
  Top = 282
  Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1089#1082#1083#1072#1076#1072
  ClientHeight = 90
  ClientWidth = 408
  OnCreate = FormCreate
  ExplicitWidth = 414
  ExplicitHeight = 116
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 393
    Height = 41
    ExplicitWidth = 393
    ExplicitHeight = 41
    object Shape2: TShape
      Left = 8
      Top = 7
      Width = 97
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 17
      Top = 13
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
      Left = 104
      Top = 7
      Width = 281
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object edName: TcxTextEdit
      Left = 110
      Top = 10
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 250
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 270
    end
  end
  inherited btnOk: TcxButton
    Left = 244
    Top = 54
    ExplicitLeft = 244
    ExplicitTop = 54
  end
  inherited btnCancel: TcxButton
    Left = 325
    Top = 54
    ExplicitLeft = 325
    ExplicitTop = 54
  end
  inherited btHelp: TcxButton
    Top = 54
    ExplicitTop = 54
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited tranRead: TpFIBTransaction
    Left = 8
    Top = 56
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_TOCHKA_GET (?G_TOCHKA_)')
    StoredProcName = 'G_TOCHKA_GET'
    Left = 40
    Top = 56
  end
  inherited tranWrite: TpFIBTransaction
    Left = 72
    Top = 56
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_TOCHKA_INS (?NAME_, ?UPLOAD_TO_EXT_APP_)')
    StoredProcName = 'G_TOCHKA_INS'
    Left = 104
    Top = 56
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_TOCHKA_UPD (?G_TOCHKA_, ?NAME_, ?UPLOAD_TO_E' +
        'XT_APP_)')
    StoredProcName = 'G_TOCHKA_UPD'
    Left = 136
    Top = 56
  end
end
