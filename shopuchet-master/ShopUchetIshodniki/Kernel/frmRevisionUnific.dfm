inherited RevisionUnificForm: TRevisionUnificForm
  Left = 532
  Top = 420
  Caption = #1042#1099#1073#1086#1088' '#1087#1088#1086#1074#1086#1076#1080#1084#1099#1093' '#1086#1087#1077#1088#1072#1094#1080#1081' '#1085#1072#1076' '#1090#1086#1074#1072#1088#1072#1084#1080
  ClientHeight = 93
  ClientWidth = 428
  ExplicitWidth = 434
  ExplicitHeight = 119
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 412
    Height = 48
    ExplicitWidth = 412
    ExplicitHeight = 48
    object Shape2: TShape
      Left = 8
      Top = 10
      Width = 145
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape6: TShape
      Left = 152
      Top = 10
      Width = 251
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 16
      Width = 125
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1088#1086#1080#1079#1074#1077#1089#1090#1080' '#1086#1087#1077#1088#1072#1094#1080#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object ComboBox: TcxComboBox
      Left = 158
      Top = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1042#1089#1077' '#1086#1087#1077#1088#1072#1094#1080#1080' ('#1087#1088#1080#1093#1086#1076#1099' '#1080' '#1089#1087#1080#1089#1072#1085#1080#1103')'
        #1058#1086#1083#1100#1082#1086' '#1087#1088#1080#1093#1086#1076#1099' '#1090#1086#1074#1072#1088#1072
        #1058#1086#1083#1100#1082#1086' '#1089#1087#1080#1089#1072#1085#1080#1103' '#1090#1086#1074#1072#1088#1072)
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Text = #1042#1089#1077' '#1086#1087#1077#1088#1072#1094#1080#1080' ('#1087#1088#1080#1093#1086#1076#1099' '#1080' '#1089#1087#1080#1089#1072#1085#1080#1103')'
      Width = 241
    end
  end
  inherited btnOk: TcxButton
    Left = 263
    Top = 61
    ExplicitLeft = 263
    ExplicitTop = 61
  end
  inherited btnCancel: TcxButton
    Left = 345
    Top = 61
    ExplicitLeft = 345
    ExplicitTop = 61
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 80
    Top = 408
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
