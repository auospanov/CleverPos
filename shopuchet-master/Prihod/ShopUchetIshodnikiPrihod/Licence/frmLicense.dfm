inherited LicenseForm: TLicenseForm
  Left = 714
  Top = 295
  Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 217
  ExplicitHeight = 243
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Top = 7
    Height = 169
    ExplicitTop = 7
    ExplicitHeight = 169
    object pnlOld: TPanel
      Left = 2
      Top = 2
      Width = 550
      Height = 165
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      Visible = False
      object Shape2: TShape
        Left = 11
        Top = 67
        Width = 159
        Height = 33
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object Label3: TLabel
        Left = 115
        Top = 5
        Width = 340
        Height = 52
        Alignment = taCenter
        Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072'  '#1085#1077' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1072'. '#1042#1082#1083#1102#1095#1077#1085#1099' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103'!'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -20
        Font.Name = 'Trebuchet MS'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label2: TLabel
        Left = 20
        Top = 74
        Width = 138
        Height = 18
        Caption = #1050#1086#1085#1090#1088#1086#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Shape4: TShape
        Left = 169
        Top = 67
        Width = 375
        Height = 33
        Pen.Color = clBtnShadow
      end
      object edControlNum: TEdit
        Left = 173
        Top = 70
        Width = 367
        Height = 22
        TabOrder = 0
      end
      object btnLoadLicense: TButton
        Left = 165
        Top = 115
        Width = 260
        Height = 34
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1083#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081' '#1082#1083#1102#1095
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnLoadLicenseClick
      end
    end
    object pnlNew: TPanel
      Left = 2
      Top = 2
      Width = 550
      Height = 165
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      object lbLicenseStatus: TLabel
        Left = 15
        Top = 12
        Width = 143
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taCenter
        Caption = 'lbLicenseStatus'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clHighlight
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object btnActivate: TcxButton
        Left = 106
        Top = 95
        Width = 361
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1040#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100
        LookAndFeel.Kind = lfFlat
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnActivateClick
      end
      object btnExtendTrial: TcxButton
        Left = 106
        Top = 131
        Width = 361
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1055#1088#1086#1076#1083#1080#1090#1100' '#1076#1077#1084#1086'-'#1074#1077#1088#1089#1080#1102
        LookAndFeel.Kind = lfFlat
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnExtendTrialClick
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 395
    Top = 185
    Enabled = False
    Visible = False
    ExplicitLeft = 395
    ExplicitTop = 185
  end
  inherited btnCancel: TcxButton
    Left = 480
    Top = 185
    Width = 81
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ExplicitLeft = 480
    ExplicitTop = 185
    ExplicitWidth = 81
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 203
    Top = 393
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    object aShowOldLic: TAction
      Caption = 'aShowOldLic'
      ShortCut = 8308
      OnExecute = aShowOldLicExecute
    end
  end
  inherited spGetData: TpFIBStoredProc
    Left = 107
    Top = 393
  end
  inherited spIns: TpFIBStoredProc
    Left = 139
    Top = 393
  end
  inherited spUpd: TpFIBStoredProc
    Left = 171
    Top = 393
  end
  object odlg: TOpenDialog
    FileName = 'License.dat'
    Filter = '(.dat)|*.dat|'
    Left = 262
    Top = 390
  end
  object SaveDialog: TSaveDialog
    Left = 294
    Top = 390
  end
end
