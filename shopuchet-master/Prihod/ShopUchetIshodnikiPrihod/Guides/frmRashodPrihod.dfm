inherited RashodPrihodForm: TRashodPrihodForm
  Left = 559
  Top = 219
  Caption = #1057#1090#1072#1090#1100#1103' '#1088#1072#1089#1093#1086#1076#1086#1074'/'#1087#1088#1080#1093#1086#1076#1086#1074
  ClientHeight = 117
  ClientWidth = 589
  ExplicitWidth = 595
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 569
    Height = 72
    ExplicitWidth = 569
    ExplicitHeight = 72
    object Shape25: TShape
      Left = 8
      Top = 9
      Width = 177
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 34
      Width = 176
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 40
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
      Left = 183
      Top = 34
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 15
      Width = 59
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape26: TShape
      Left = 183
      Top = 9
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object cbAction: TComboBox
      Left = 192
      Top = 11
      Width = 369
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ItemIndex = 0
      TabOrder = 1
      Text = #1055#1088#1080#1093#1086#1076
      OnChange = cbActionChange
      Items.Strings = (
        #1055#1088#1080#1093#1086#1076
        #1056#1072#1089#1093#1086#1076)
    end
    object edName: TcxTextEdit
      Left = 192
      Top = 37
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 500
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 369
    end
  end
  inherited btnOk: TcxButton
    Left = 421
    Top = 85
    ExplicitLeft = 421
    ExplicitTop = 85
  end
  inherited btnCancel: TcxButton
    Left = 502
    Top = 85
    ExplicitLeft = 502
    ExplicitTop = 85
  end
  inherited btHelp: TcxButton
    Top = 85
    ExplicitTop = 85
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_PRIHOD_RASHOD (?G_PRIHOD_RASHOD_)')
    StoredProcName = 'G_GET_G_PRIHOD_RASHOD'
    Left = 8
    Top = 88
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_INS_G_PRIHOD_RASHOD (?ACTION_, ?NAME_)')
    StoredProcName = 'G_INS_G_PRIHOD_RASHOD'
    Left = 40
    Top = 88
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_PRIHOD_RASHOD (?G_PRIHOD_RASHOD_, ?ACT' +
        'ION_, ?NAME_)')
    StoredProcName = 'G_UPD_G_PRIHOD_RASHOD'
    Left = 72
    Top = 88
  end
end
