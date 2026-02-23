inherited RevisionUpdForm: TRevisionUpdForm
  Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072' '#1087#1086' '#1092#1072#1082#1090#1091
  ClientHeight = 126
  ClientWidth = 371
  ExplicitWidth = 377
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Left = 8
    Top = 4
    Width = 356
    Height = 81
    ExplicitLeft = 8
    ExplicitTop = 4
    ExplicitWidth = 356
    ExplicitHeight = 81
    object Shape7: TShape
      Left = 12
      Top = 19
      Width = 173
      Height = 36
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape8: TShape
      Left = 184
      Top = 19
      Width = 157
      Height = 36
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label4: TLabel
      Left = 21
      Top = 28
      Width = 150
      Height = 19
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1086#1083'-'#1074#1086' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    inline MyCurrencyFrameForm: TMyCurrencyFrameForm
      Left = 192
      Top = 24
      Width = 147
      Height = 27
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 0
      ExplicitLeft = 192
      ExplicitTop = 24
      ExplicitWidth = 147
      ExplicitHeight = 27
      inherited edAmount: TEdit
        Left = 0
        Width = 118
        Height = 27
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        ParentFont = False
        Text = '1.00'
        OnChange = MyCurrencyFrameFormedAmountChange
        ExplicitLeft = 0
        ExplicitWidth = 118
        ExplicitHeight = 27
      end
      inherited sbCur: TSpinButton
        Left = 121
        Top = 1
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ExplicitLeft = 121
        ExplicitTop = 1
        ExplicitHeight = 25
      end
    end
    object edModified: TEdit
      Left = 12
      Top = 52
      Width = 121
      Height = 22
      TabOrder = 1
      Text = #1076#1083#1103' Modified'
      Visible = False
    end
  end
  inherited btnOk: TcxButton
    Left = 202
    Top = 93
    ExplicitLeft = 202
    ExplicitTop = 93
  end
  inherited btnCancel: TcxButton
    Left = 288
    Top = 93
    ExplicitLeft = 288
    ExplicitTop = 93
  end
  inherited btHelp: TcxButton
    Top = 93
    ExplicitTop = 93
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE R_UPD_REVISION (?REVISION_, ?AMOUNT_REAL_)')
    StoredProcName = 'R_UPD_REVISION'
  end
end
