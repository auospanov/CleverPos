inherited NacenkaForm: TNacenkaForm
  Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1088#1086#1079#1085#1080#1095#1085#1086#1081' '#1094#1077#1085#1099
  ClientHeight = 122
  ClientWidth = 300
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 306
  ExplicitHeight = 148
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 286
    Height = 80
    ExplicitWidth = 286
    ExplicitHeight = 80
    object Shape9: TShape
      Left = 19
      Top = 23
      Width = 97
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape10: TShape
      Left = 115
      Top = 23
      Width = 134
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Label5: TLabel
      Left = 29
      Top = 29
      Width = 73
      Height = 14
      Caption = #1053#1072#1094#1077#1085#1082#1072' '#1074' %'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edNacenka: TcxCurrencyEdit
      Left = 122
      Top = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 0c
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00'
      Properties.UseLeftAlignmentOnEditing = False
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 121
    end
  end
  inherited btnOk: TcxButton
    Left = 131
    Top = 90
    ExplicitLeft = 131
    ExplicitTop = 90
  end
  inherited btnCancel: TcxButton
    Left = 218
    Top = 90
    ExplicitLeft = 218
    ExplicitTop = 90
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
