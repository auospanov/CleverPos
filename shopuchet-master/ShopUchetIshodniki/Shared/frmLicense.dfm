inherited LicenseForm: TLicenseForm
  Left = 714
  Top = 295
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 370
  PixelsPerInch = 120
  TextHeight = 18
  inherited btnOk: TBitBtn
    Left = 509
    Top = 325
    Enabled = False
    Visible = False
  end
  inherited btnCancel: TBitBtn
    Left = 613
    Top = 325
    Width = 104
    Caption = #1047#1072#1082#1088#1099#1090#1100
  end
  inherited Panel1: TPanel
    Left = 6
    Height = 308
    object Shape2: TShape
      Left = 10
      Top = 94
      Width = 227
      Height = 33
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 23
      Top = 102
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
      Left = 235
      Top = 94
      Width = 468
      Height = 33
      Pen.Color = clBtnShadow
    end
    object Label3: TLabel
      Left = 10
      Top = 10
      Width = 667
      Height = 76
      Alignment = taCenter
      Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072'  '#1085#1077' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1072'. '#1042#1082#1083#1102#1095#1077#1085#1099' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103'!'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -30
      Font.Name = 'Trebuchet MS'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object edControlNum: TEdit
      Left = 240
      Top = 96
      Width = 458
      Height = 26
      TabOrder = 0
    end
    object pcKey: TcxPageControl
      Left = 2
      Top = 144
      Width = 708
      Height = 162
      ActivePage = tsLoad
      Align = alBottom
      TabOrder = 1
      TabPosition = tpBottom
      OnChange = pcKeyChange
      ClientRectBottom = 134
      ClientRectRight = 708
      ClientRectTop = 0
      object tsLoad: TcxTabSheet
        Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1083#1080#1094'. '#1082#1083#1102#1095#1072
        ImageIndex = 0
        object btnLoadLicense: TButton
          Left = 181
          Top = 39
          Width = 377
          Height = 54
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1083#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081' '#1082#1083#1102#1095
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnLoadLicenseClick
        end
      end
      object tsPath: TcxTabSheet
        Caption = #1055#1091#1090#1100' '#1082' '#1082#1072#1090#1072#1083#1086#1075#1091' '#1089' '#1082#1083#1102#1095#1077#1084
        ImageIndex = 1
        object sh2: TShape
          Left = 10
          Top = 78
          Width = 115
          Height = 34
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object lb1: TLabel
          Left = 13
          Top = 24
          Width = 646
          Height = 36
          Caption = 
            #1045#1089#1083#1080' '#1087#1086' '#1082#1072#1082#1080#1084'-'#1083#1080#1073#1086' '#1087#1088#1080#1095#1080#1085#1072#1084' '#1074#1099' '#1085#1077' '#1093#1086#1090#1080#1090#1077', '#1095#1090#1086#1073#1099' '#1083#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081' '#1082#1083#1102 +
            #1095' '#1085#1072#1093#1086#1076#1080#1083#1089#1103' '#1074' '#1087#1072#1087#1082#1077' '#1089' '#1087#1088#1086#1075#1088#1072#1084#1084#1086#1081', '#1090#1086' '#1084#1086#1078#1077#1090#1077' '#1091#1082#1072#1079#1072#1090#1100' '#1087#1091#1090#1100' '#1076#1086' '#1082#1072#1090#1072 +
            #1083#1086#1075#1072' '#1089' '#1082#1083#1102#1095#1086#1084
          WordWrap = True
        end
        object sh1: TShape
          Left = 123
          Top = 78
          Width = 576
          Height = 34
          Pen.Color = clBtnShadow
        end
        object lb2: TLabel
          Left = 23
          Top = 86
          Width = 55
          Height = 18
          Caption = #1050#1072#1090#1072#1083#1086#1075
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object bedtFileName: TdxButtonEdit
          Left = 130
          Top = 81
          Width = 564
          TabOrder = 0
          ReadOnly = True
          StyleController = dxEditStyleController
          Buttons = <
            item
              Default = True
            end>
          OnButtonClick = bedtFileNameButtonClick
          StoredValues = 64
          ExistButtons = True
        end
      end
    end
  end
  inherited btHelp: TBitBtn
    Top = 325
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 203
    Top = 393
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE LT_GET_CALC_PERCENT (?PERCENT_)')
    StoredProcName = 'LT_GET_CALC_PERCENT'
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
  object IdEncoderMIME1: TIdEncoderMIME
    FillChar = '='
    Left = 432
    Top = 128
  end
  object dlgOpen1: TOpenDialog
    Filter = 'Dat (*.dat)|*.dat'
    Left = 224
    Top = 152
  end
end
