inherited RevisionImportFillDlgForm: TRevisionImportFillDlgForm
  Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1090#1086#1074#1072#1088#1072#1084#1080
  ClientHeight = 125
  ExplicitWidth = 527
  ExplicitHeight = 151
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Left = 7
    Top = 7
    Height = 83
    ExplicitLeft = 7
    ExplicitTop = 7
    object shp1: TShape
      Left = 11
      Top = 12
      Width = 333
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object lb1: TLabel
      Left = 21
      Top = 18
      Width = 296
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1086#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1090#1086#1074#1072#1088#1072#1084#1080', '#1082#1086#1090#1086#1088#1099#1093' '#1085#1077#1090' '#1074' '#1092#1072#1081#1083#1077' Excel '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shp2: TShape
      Left = 343
      Top = 12
      Width = 154
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object cbFillRestProduct: TcxCheckBox
      Left = 364
      Top = 16
      ParentShowHint = False
      ShowHint = True
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 46
    end
  end
  inherited btnOk: TcxButton
    Top = 93
  end
  inherited btnCancel: TcxButton
    Top = 93
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
