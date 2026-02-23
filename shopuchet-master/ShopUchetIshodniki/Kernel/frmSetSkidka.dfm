inherited SetSkidkaForm: TSetSkidkaForm
  Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1095#1077#1082
  ClientHeight = 210
  ClientWidth = 414
  Color = clBtnFace
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 420
  ExplicitHeight = 236
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 400
    Height = 161
    Color = clBtnFace
    ParentBackground = False
    ExplicitWidth = 400
    ExplicitHeight = 161
    object lb7: TLabel
      Left = 26
      Top = 21
      Width = 81
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1082#1080#1076#1082#1072' '#1074
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lb6: TLabel
      Left = 26
      Top = 79
      Width = 127
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clDefault
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object cbSkidka: TcxComboBox
      Left = 169
      Top = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      AutoSize = False
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1055#1088#1086#1094#1077#1085#1090#1072#1093
        #1044#1077#1085#1077#1078'. '#1077#1076'.')
      Properties.OnChange = cbSkidkaPropertiesChange
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -21
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfStandard
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.Kind = lfStandard
      TabOrder = 0
      Text = #1055#1088#1086#1094#1077#1085#1090#1072#1093
      Height = 33
      Width = 186
    end
    object edSkidkaSumm: TcxCurrencyEdit
      Left = 169
      Top = 75
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 0c
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.UseThousandSeparator = True
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -21
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.StyleController = dxEditStyleController
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 186
    end
  end
  inherited btnOk: TcxButton
    Left = 202
    Top = 172
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 202
    ExplicitTop = 172
    ExplicitWidth = 95
    ExplicitHeight = 30
  end
  inherited btnCancel: TcxButton
    Left = 311
    Top = 172
    Width = 95
    Height = 30
    Font.Height = -17
    ParentFont = False
    ExplicitLeft = 311
    ExplicitTop = 172
    ExplicitWidth = 95
    ExplicitHeight = 30
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
