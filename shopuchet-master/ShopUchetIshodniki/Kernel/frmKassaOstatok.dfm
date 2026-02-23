inherited KassaOstatokForm: TKassaOstatokForm
  Left = 562
  Top = 174
  Caption = #1054#1089#1090#1072#1090#1086#1082' '#1074' '#1082#1072#1089#1089#1077' '#1085#1072' '#1076#1072#1090#1091
  ClientHeight = 197
  ClientWidth = 392
  ExplicitWidth = 398
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 376
    Height = 149
    ExplicitWidth = 376
    ExplicitHeight = 149
    object Shape1: TShape
      Left = 7
      Top = 32
      Width = 137
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape12: TShape
      Left = 7
      Top = 7
      Width = 137
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label7: TLabel
      Left = 17
      Top = 13
      Width = 26
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1072#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape13: TShape
      Left = 143
      Top = 7
      Width = 224
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lbOstatok: TLabel
      Left = 32
      Top = 88
      Width = 91
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1054#1089#1090#1072#1090#1086#1082': '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 17
      Top = 38
      Width = 109
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1072#1089#1089#1072'/'#1088#1072#1089#1095#1077#1090'. '#1089#1095#1077#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape2: TShape
      Left = 143
      Top = 32
      Width = 224
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object edDate: TcxDateEdit
      Left = 148
      Top = 9
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.InputKind = ikMask
      Properties.OnCloseUp = edDatePropertiesCloseUp
      Style.BorderStyle = ebs3D
      Style.ButtonStyle = bts3D
      TabOrder = 0
      Width = 215
    end
    object cbNalBeznal: TComboBox
      Left = 148
      Top = 34
      Width = 215
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ItemIndex = 0
      TabOrder = 1
      Text = #1053#1072#1083#1080#1095#1085#1072#1103' '#1082#1072#1089#1089#1072
      OnChange = edDatePropertiesCloseUp
      Items.Strings = (
        #1053#1072#1083#1080#1095#1085#1072#1103' '#1082#1072#1089#1089#1072
        #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090)
    end
  end
  inherited btnOk: TcxButton
    Left = 176
    Top = 162
    Width = 127
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1086#1089#1090#1072#1090#1086#1082
    Visible = False
    OnClick = btnOkClick
    ExplicitLeft = 176
    ExplicitTop = 162
    ExplicitWidth = 127
  end
  inherited btnCancel: TcxButton
    Left = 309
    Top = 162
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ExplicitLeft = 309
    ExplicitTop = 162
  end
  inherited btHelp: TcxButton
    Top = 162
    ExplicitTop = 162
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE K_GET_KASSA_SUMM (?G_TOCHKA_, ?DATE_, ?G_PAYME' +
        'NT_TYPE_)')
    StoredProcName = 'K_GET_KASSA_SUMM'
    Left = 16
    Top = 160
  end
  inherited spIns: TpFIBStoredProc
    Left = 48
    Top = 160
  end
  inherited spUpd: TpFIBStoredProc
    Left = 80
    Top = 160
  end
end
