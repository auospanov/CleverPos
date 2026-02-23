inherited SendTimeAndDateForm: TSendTimeAndDateForm
  Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1088#1072#1089#1089#1099#1083#1082#1080
  ClientHeight = 118
  ClientWidth = 300
  ExplicitWidth = 306
  ExplicitHeight = 144
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 284
    Height = 76
    ExplicitWidth = 284
    ExplicitHeight = 76
    object shp1: TShape
      Left = 11
      Top = 13
      Width = 128
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shp3: TShape
      Left = 11
      Top = 38
      Width = 128
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
      Top = 19
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
    object shp2: TShape
      Left = 138
      Top = 13
      Width = 134
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb2: TLabel
      Left = 21
      Top = 44
      Width = 36
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1042#1088#1077#1084#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shp4: TShape
      Left = 138
      Top = 38
      Width = 134
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object edDate: TcxDateEdit
      Left = 143
      Top = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.InputKind = ikMask
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.YearsInMonthList = False
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      Style.ButtonStyle = btsDefault
      Style.ButtonTransparency = ebtNone
      TabOrder = 0
      Width = 125
    end
    object teTime: TcxTimeEdit
      Left = 143
      Top = 41
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 0d
      Properties.BeepOnError = True
      Properties.TimeFormat = tfHourMin
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 125
    end
  end
  inherited btnOk: TcxButton
    Left = 131
    Top = 86
    ExplicitLeft = 131
    ExplicitTop = 86
  end
  inherited btnCancel: TcxButton
    Left = 215
    Top = 86
    ExplicitLeft = 215
    ExplicitTop = 86
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
end
