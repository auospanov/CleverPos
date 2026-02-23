inherited ExportOperDataForm: TExportOperDataForm
  Left = 573
  Top = 239
  Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 547
  ClientWidth = 648
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 654
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 634
    Height = 503
    Anchors = [akLeft, akTop, akRight]
    ExplicitWidth = 634
    ExplicitHeight = 503
    object cxPageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 630
      Height = 366
      Align = alTop
      TabOrder = 0
      Properties.ActivePage = tsKaspiShop
      Properties.CustomButtons.Buttons = <>
      LookAndFeel.Kind = lfUltraFlat
      OnChange = cxPageControl1Change
      ClientRectBottom = 366
      ClientRectRight = 630
      ClientRectTop = 25
      object tsMobileApp: TcxTabSheet
        Caption = #1052#1086#1073#1080#1083#1100#1085#1086#1077' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077
        ImageIndex = 2
        DesignSize = (
          630
          341)
        object Shape3: TShape
          Left = 11
          Top = 38
          Width = 181
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Shape4: TShape
          Left = 11
          Top = 63
          Width = 181
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object Label3: TLabel
          Left = 19
          Top = 44
          Width = 34
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1051#1086#1075#1080#1085
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 19
          Top = 69
          Width = 41
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1072#1088#1086#1083#1100
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Shape5: TShape
          Left = 188
          Top = 38
          Width = 439
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Shape6: TShape
          Left = 188
          Top = 63
          Width = 439
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Label2: TLabel
          Left = 19
          Top = 129
          Width = 107
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1058#1077#1089#1090#1086#1074#1099#1081' IP-'#1072#1076#1088#1077#1089
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object edMobileLogin: TcxTextEdit
          Left = 194
          Top = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 2
          Width = 428
        end
        object edMobilePass: TcxTextEdit
          Left = 194
          Top = 66
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.EchoMode = eemPassword
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 3
          OnKeyPress = edMobilePassKeyPress
          Width = 428
        end
        object cbUploadToMobile: TcxCheckBox
          Left = 7
          Top = 8
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1075#1088#1091#1078#1072#1090#1100' '#1074' '#1084#1086#1073#1080#1083#1100#1085#1086#1077' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077
          ParentFont = False
          Properties.OnChange = cbUploadToMobilePropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 266
        end
        object edMobileIp: TcxTextEdit
          Left = 194
          Top = 126
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 1
          Visible = False
          Width = 428
        end
      end
      object tsCommon: TcxTabSheet
        Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' '#1087#1072#1087#1082#1091
        ImageIndex = 0
        object lb1: TLabel
          Left = 8
          Top = 8
          Width = 513
          Height = 56
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 
            #1056#1077#1078#1080#1084' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080' '#1076#1072#1085#1085#1099#1093' - '#1087#1088#1086#1076#1072#1078#1080', '#1087#1088#1080#1093#1086#1076#1099' '#1080' '#1086#1089#1090#1072 +
            #1090#1086#1082' '#1090#1086#1074#1072#1088#1086#1074' '#1085#1072' '#1090#1077#1082#1091#1097#1080#1081' '#1084#1086#1084#1077#1085#1090'. '#1052#1086#1078#1085#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080' '#1085 +
            #1072' '#1089#1077#1090#1077#1074#1099#1077' '#1088#1077#1089#1091#1088#1089#1099' '#1080#1083#1080' '#1085#1072' '#1086#1073#1083#1072#1095#1085#1099#1077' '#1089#1077#1088#1074#1080#1089#1099', '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1085#1086#1075#1086' '#1087#1088#1086#1089#1084#1086 +
            #1090#1088#1072' '#1080' '#1082#1086#1085#1090#1088#1086#1083#1103'. '#1042#1099#1075#1088#1091#1079#1082#1091' '#1084#1086#1078#1085#1086' '#1085#1072#1089#1090#1088#1086#1080#1090#1100' '#1080#1085#1090#1077#1088#1074#1072#1083#1100#1085#1091#1102', '#1082' '#1087#1088#1080#1084#1077#1088#1091 +
            ' '#1088#1072#1079' '#1074' 15 '#1084#1080#1085#1091#1090', '#1083#1080#1073#1086' '#1077#1076#1080#1085#1086#1088#1072#1079#1086#1074#1091#1102', '#1087#1088#1080' '#1079#1072#1082#1088#1099#1090#1080#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'.'
          WordWrap = True
        end
        object lbPayment: TLabel
          Left = 163
          Top = 98
          Width = 205
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object cbProfit: TcxCheckBox
          Left = 35
          Top = 125
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1080#1073#1099#1083#1100' ('#1082#1088#1072#1090#1082#1080#1081' '#1086#1090#1095#1077#1090')'
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 174
        end
        object cbSales: TcxCheckBox
          Left = 35
          Top = 150
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1086#1076#1072#1078#1080
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 1
          Width = 78
        end
        object cbOstatok: TcxCheckBox
          Left = 35
          Top = 175
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1089#1090#1072#1090#1086#1082' '#1090#1086#1074#1072#1088#1086#1074
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 2
          Width = 120
        end
        object cbOstatokXML: TcxCheckBox
          Left = 278
          Top = 125
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1089#1090#1072#1090#1086#1082' '#1090#1086#1074#1072#1088#1086#1074' '#1074' XML-'#1092#1072#1081#1083
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 3
          Width = 193
        end
        object cbSalesInXml: TcxCheckBox
          Left = 278
          Top = 150
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1086#1076#1072#1078#1080' '#1074' XML-'#1092#1072#1081#1083
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 4
          Width = 149
        end
        object cbZakupkaInXml: TcxCheckBox
          Left = 278
          Top = 175
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1080#1093#1086#1076#1099' '#1074' XML-'#1092#1072#1081#1083
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 5
          Width = 149
        end
      end
      object tsFtp: TcxTabSheet
        Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1085#1072' FTP-'#1057#1077#1088#1074#1077#1088
        ImageIndex = 1
        DesignSize = (
          630
          341)
        object shpFtpPort: TShape
          Left = 8
          Top = 60
          Width = 181
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object shpFtpServer: TShape
          Left = 8
          Top = 35
          Width = 181
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object shpLogin: TShape
          Left = 8
          Top = 85
          Width = 181
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object shpPassword: TShape
          Left = 8
          Top = 110
          Width = 181
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Brush.Color = 16577773
          Pen.Color = clBtnShadow
        end
        object lbFtpServer: TLabel
          Left = 16
          Top = 41
          Width = 65
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'FTP-'#1089#1077#1088#1074#1077#1088
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbLogin: TLabel
          Left = 16
          Top = 91
          Width = 34
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1051#1086#1075#1080#1085
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object lbPassword: TLabel
          Left = 16
          Top = 116
          Width = 41
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1072#1088#1086#1083#1100
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object shpFtpServer1: TShape
          Left = 188
          Top = 35
          Width = 437
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object shpLogin1: TShape
          Left = 188
          Top = 85
          Width = 437
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object shpPassword1: TShape
          Left = 188
          Top = 110
          Width = 437
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object Label1: TLabel
          Left = 114
          Top = 167
          Width = 297
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080' '#1085#1072' FTP-'#1089#1077#1088#1074#1077#1088
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lbFtpPort: TLabel
          Left = 16
          Top = 66
          Width = 52
          Height = 14
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'FTP-'#1087#1086#1088#1090
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = 7492630
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object shpFtpPort1: TShape
          Left = 188
          Top = 60
          Width = 437
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Pen.Color = clBtnShadow
        end
        object shpSklad1: TShape
          Left = 191
          Top = 250
          Width = 434
          Height = 26
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Pen.Color = clBtnShadow
          ExplicitWidth = 367
        end
        object edFtpServer: TcxTextEdit
          Left = 193
          Top = 38
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 1
          Width = 428
        end
        object edLogin: TcxTextEdit
          Left = 193
          Top = 88
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 3
          Width = 428
        end
        object edPassword: TcxTextEdit
          Left = 193
          Top = 112
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.EchoMode = eemPassword
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 4
          Width = 428
        end
        object cbUploadToFtp: TcxCheckBox
          Left = 7
          Top = 8
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1042#1099#1075#1088#1091#1078#1072#1090#1100' '#1085#1072' FTP-'#1089#1077#1088#1074#1077#1088
          ParentFont = False
          Properties.OnChange = cbUploadToFtpPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 0
          Width = 194
        end
        object cbProfitFtp: TcxCheckBox
          Left = 10
          Top = 196
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1080#1073#1099#1083#1100' ('#1082#1088#1072#1090#1082#1080#1081' '#1086#1090#1095#1077#1090')'
          Enabled = False
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 5
          Width = 174
        end
        object cbSalesFtp: TcxCheckBox
          Left = 10
          Top = 221
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1086#1076#1072#1078#1080
          Enabled = False
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 6
          Width = 78
        end
        object cbOstatokFtp: TcxCheckBox
          Left = 362
          Top = 196
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1089#1090#1072#1090#1086#1082' '#1090#1086#1074#1072#1088#1086#1074
          Enabled = False
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 7
          Width = 120
        end
        object cbOstatokXmlFtp: TcxCheckBox
          Left = 362
          Top = 222
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1054#1089#1090#1072#1090#1086#1082' '#1090#1086#1074#1072#1088#1086#1074' '#1074' XML-'#1092#1072#1081#1083
          Enabled = False
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 8
          Width = 196
        end
        object cbSalesInXmlFtp: TcxCheckBox
          Left = 196
          Top = 221
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1086#1076#1072#1078#1080' '#1074' XML-'#1092#1072#1081#1083
          Enabled = False
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 9
          Width = 152
        end
        object edFtpPort: TcxTextEdit
          Left = 193
          Top = 63
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.MaxLength = 150
          Style.BorderStyle = ebsFlat
          Style.StyleController = dxEditStyleController
          TabOrder = 2
          Text = '21'
          OnKeyPress = edFtpPortKeyPress
          Width = 428
        end
        object cbZakupkaInXmlFtp: TcxCheckBox
          Left = 196
          Top = 195
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #1055#1088#1080#1093#1086#1076#1099' '#1074' XML-'#1092#1072#1081#1083
          Enabled = False
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 10
          Width = 152
        end
        object cbOstatokItekaFtp: TcxCheckBox
          Left = 10
          Top = 251
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'I-teka. '#1057#1082#1083#1072#1076' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080
          Enabled = False
          ParentFont = False
          Properties.OnChange = cbSalesPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 11
          Width = 179
        end
        object leSklad: TcxLookupComboBox
          Left = 196
          Top = 252
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          Properties.DropDownListStyle = lsFixedList
          Properties.GridMode = True
          Properties.KeyFieldNames = 'G_TOCHKA'
          Properties.ListColumns = <
            item
              FieldName = 'NAME'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = dsReadSklad
          Style.LookAndFeel.Kind = lfFlat
          Style.StyleController = dxEditStyleController
          Style.TransparentBorder = False
          Style.ButtonTransparency = ebtNone
          StyleDisabled.LookAndFeel.Kind = lfFlat
          StyleFocused.LookAndFeel.Kind = lfFlat
          StyleHot.LookAndFeel.Kind = lfFlat
          TabOrder = 12
          Width = 424
        end
      end
      object tsKaspiShop: TcxTabSheet
        Caption = 'Kaspi '#1084#1072#1075#1072#1079#1080#1085
        ImageIndex = 3
        object cxGrid4: TcxGrid
          Left = 0
          Top = 201
          Width = 630
          Height = 140
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Enabled = False
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object cxgrdbtblvwGrid4DBTableView1: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsKaspi_Point
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            EditForm.MasterRowDblClickAction = dcaShowEditForm
            OptionsBehavior.AlwaysShowEditor = True
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsSelection.HideFocusRectOnExit = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.UnselectFocusedRecordOnExit = False
            OptionsView.GroupByBox = False
            Styles.Inactive = MainDM.stGridSelectedRow
            Styles.IncSearch = MainDM.stIncSearchStyle
            Styles.Selection = MainDM.stGridSelectedRow
            Styles.Indicator = MainDM.stGridSelectedRow
            object cxIDPOINT: TcxGridDBColumn
              DataBinding.FieldName = 'IDPOINT'
              Visible = False
            end
            object cxIDCITY: TcxGridDBColumn
              Caption = #1043#1086#1088#1086#1076
              DataBinding.FieldName = 'IDCITY'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'ID'
              Properties.ListColumns = <
                item
                  FieldName = 'NAME'
                end>
              Properties.ListOptions.ShowHeader = False
              Properties.ListSource = dsCity
              Options.AutoWidthSizable = False
              Width = 143
            end
            object cxG_TOCHKA: TcxGridDBColumn
              Caption = #1057#1082#1083#1072#1076' '#1074' Shopuchet'
              DataBinding.FieldName = 'G_TOCHKA'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'G_TOCHKA'
              Properties.ListColumns = <
                item
                  FieldName = 'NAME'
                end>
              Properties.ListOptions.ShowHeader = False
              Properties.ListSource = dsG_Tochka
              Options.AutoWidthSizable = False
              Width = 185
            end
            object cxADRESS: TcxGridDBColumn
              Caption = #1048#1084#1103' '#1089#1082#1083#1072#1076#1072' '#1074' Kaspi'
              DataBinding.FieldName = 'ADRESS'
              Options.AutoWidthSizable = False
              Width = 200
            end
          end
          object cxgrdlvlGrid4Level1: TcxGridLevel
            GridView = cxgrdbtblvwGrid4DBTableView1
          end
        end
        object pnl1: TPanel
          Left = 0
          Top = 29
          Width = 630
          Height = 172
          Align = alTop
          BevelInner = bvLowered
          TabOrder = 1
          DesignSize = (
            630
            172)
          object Shape2: TShape
            Left = 11
            Top = 33
            Width = 181
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label5: TLabel
            Left = 19
            Top = 39
            Width = 150
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1057#1089#1099#1083#1082#1072' '#1076#1083#1103' Kaspi '#1084#1072#1075#1072#1079#1080#1085#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape1: TShape
            Left = 191
            Top = 33
            Width = 433
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object Shape9: TShape
            Left = 11
            Top = 8
            Width = 181
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Brush.Color = 16577773
            Pen.Color = clBtnShadow
          end
          object Label7: TLabel
            Left = 19
            Top = 14
            Width = 69
            Height = 14
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'ID '#1087#1072#1088#1090#1085#1077#1088#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = 7492630
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Shape10: TShape
            Left = 191
            Top = 8
            Width = 433
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Pen.Color = clBtnShadow
          end
          object BitBtn1: TBitBtn
            Left = 11
            Top = 137
            Width = 105
            Height = 27
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00BF9883FFAF7353FFA8643EFFA96540FFAE73
              53FFBE9883FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00C19983FFAE663DFFC58956FFD6A36CFFDDAF74FFDDAF73FFD6A4
              6AFFC58955FFAE6A40FFC8AD9EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00BA886BFFBC7B4CFFDDAE76FFDEB075FFE2B782FFE3BB87FFE3BC86FFE1B7
              82FFDEAF73FFDBAB71FFBD7D4DFFB9886DFFFF00FF00FF00FF00FF00FF00C6A0
              8AFFBE8052FFE0B37BFFDFB075FFDEB176FFB78253FFAA7043FFAB7144FFBC88
              58FFDFB278FFDFB276FFDEB076FFC08252FFC29F8AFFFF00FF00FF00FF00B574
              4BFFDFB27CFFDFB279FFE0B37AFFE0B57CFFA56A3EFFF5EFEAFFF8F3EEFFAB71
              44FFE2B67DFFE0B47BFFE0B47AFFDEB078FFB7764DFFFF00FF00CBA691FFCD9B
              6EFFE2B780FFE5BD89FFE7C291FFE8C393FFA56A3EFFF1E6DEFFF9F5F1FFAA70
              43FFE8C494FFE8C393FFE5BF8CFFE1B77EFFD09C6DFFC8A895FFC08B69FFDCB3
              83FFE3B781FFBA8658FFA96F42FFAB7144FFAC7245FFF5EDE6FFFAF6F3FFAD74
              46FFB07749FFB1794AFFC29161FFE4B983FFDEB17DFFBD8A69FFBD8158FFE3BF
              8FFFE4BB84FFA56A3EFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
              F4FFFAF7F3FFFAF6F2FFAB7144FFE5BD87FFE5BE8BFFBC825CFFC18961FFE9C9
              A0FFE5BE89FFA56A3EFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
              D9FFE6DAD4FFE9DED9FFAA7043FFE7C08CFFEACA9DFFBF875FFFC99977FFE9CD
              ACFFEAC796FFB78455FFA56A3EFFA56A3EFFA56A3EFFF1EAE5FFFAF6F3FFA56A
              3EFFA56A3EFFA56A3EFFB78456FFEACA99FFEBD1ADFFC49573FFD6B69EFFDDBB
              9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56A3EFFF0EAE7FFFDFCFBFFA56A
              3EFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FFD2B6A1FFFF00FF00CA97
              6EFFF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56A3EFFDECFC9FFDFD1CBFFA56A
              3EFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFCB9974FFFF00FF00FF00FF00DCBF
              A9FFD7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5EFFA56A3EFFA56A3EFFBA8A
              5EFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FFD9BEA9FFFF00FF00FF00FF00FF00
              FF00D7B395FFD9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
              CAFFF8EED0FFF4E8CDFFD7AF8BFFD4B296FFFF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00E0C4AFFFD2A37AFFE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
              B9FFE3C5A3FFD2A680FFE4D1C2FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00E2CAB4FFD7B192FFD3A57DFFD2A681FFD6B0
              92FFE0C8B3FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            TabOrder = 0
            OnClick = BitBtn1Click
          end
          object BitBtn2: TBitBtn
            Left = 116
            Top = 137
            Width = 105
            Height = 27
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1059#1076#1072#1083#1080#1090#1100
            Glyph.Data = {
              36080000424D3608000000000000360000002800000020000000100000000100
              20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00BF988300AF745400A8653F00A9664100AE74
              5400BE988300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00A1A1A1008181810073737300757575008181
              8100A0A0A000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00C1998300AE673E00C5895700D6A36D00DDAF7500DDAF7400D6A4
              6B00C5895600AE6B4100C8AD9E00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00A2A2A200767676008E8E8E00A1A1A100A9A9A900A8A8A800A0A0
              A0008D8D8D0077777700B3B3B300FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00BA886C00BC7C4D00DDAE7700DEB07600DEAF7500DEAF7500DEB07400DDAF
              7500DEAF7400DBAB7200BD7E4E00B9886E00FF00FF00FF00FF00FF00FF00FF00
              FF009393930084848400AAAAAA00AAAAAA00A9A9A900A9A9A900A9A9A900A9A9
              A900A9A9A900A6A6A6008585850093939300FF00FF00FF00FF00FF00FF00C6A0
              8A00BE805300E0B37C00DFB07600DEB17700DFB27900E0B37900E0B27A00E0B2
              7900DFB27900DFB27700DEB07700C0825300C29F8A00FF00FF00FF00FF00A8A8
              A80088888800AEAEAE00AAAAAA00AAAAAA00ACACAC00ACACAC00ADADAD00ACAC
              AC00ACACAC00ABABAB00AAAAAA0089898900A6A6A600FF00FF00FF00FF00B575
              4C00DFB27D00DFB27A00E0B37B00E0B57D00E1B67E00E2B67F00E2B77F00E2B7
              7F00E2B67E00E0B47C00E0B47B00DEB07900B7774E00FF00FF00FF00FF008080
              8000AEAEAE00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B0B0B000B0B0
              B000B0B0B000AEAEAE00ADADAD00ABABAB0082828200FF00FF00CBA69100CD9B
              6F00E2B78000E5BD8900E7C29100E8C39300E8C49400E8C59400E8C49500E8C4
              9500E8C49400E8C39300E5BF8C00E1B77F00D09C6E00C8A89500AEAEAE009E9E
              9E00B1B1B100B7B7B700BCBCBC00BDBDBD00BEBEBE00BEBEBE00BEBEBE00BEBE
              BE00BEBEBE00BDBDBD00B8B8B800B0B0B0009F9F9F00AEAEAE00C08B6A00DCB3
              8300E3B78100BA865900A9704300AB724500AC734600B0794A00AB724500AD75
              4700B0784A00B17A4B00C2916200E4B98300DEB17E00BD8A6A0095959500AFAF
              AF00B2B2B200898989007676760078787800797979007D7D7D00787878007A7A
              7A007D7D7D007E7E7E0092929200B3B3B300AEAEAE0093939300BD815900E3BF
              8F00E4BB8400A56B3F00F5EEE900FAF6F300FAF7F300FBF7F400FBF7F500FAF7
              F400FAF7F300FAF6F200AB724500E5BD8700E5BE8B00BC825D008B8B8B00B9B9
              B900B4B4B40072727200EFEFEF00F6F6F600F6F6F600F7F7F700F8F8F800F7F7
              F700F6F6F600F6F6F60078787800B6B6B600B8B8B8008C8C8C00C1896200E9C9
              A000E5BE8900A56B3F00E6D9D200E7DBD400E9DED700EAE0D900EAE0DA00EBE1
              DB00EBE0DB00EEE5E100AA714400E7C08C00EACA9D00BF87600091919100C4C4
              C400B7B7B70072727200DCDCDC00DDDDDD00E0E0E000E1E1E100E2E2E200E3E3
              E300E3E3E300E7E7E70077777700B9B9B900C3C3C3008F8F8F00C9997800E9CD
              AC00EAC79600B7845600A56B3F00A56B3F00A56B3F00A56B3F00A56B3F00A56B
              3F00A56B3F00A56B3F00B7845700EACA9900EBD1AD00C4957400A0A0A000CACA
              CA00C0C0C0008686860072727200727272007272720072727200727272007272
              7200727272007272720087878700C1C1C100CCCCCC009C9C9C00D6B69E00DDBB
              9D00EED3A900EECFA200EED2A500F0D6A900F1D7AB00F1D8AD00F1D8AD00F1D8
              AD00F1D6AA00F0D5A800EED2A500EFD4A700E0C2A200D2B6A100BABABA00BDBD
              BD00CBCBCB00C8C8C800C9C9C900CCCCCC00CECECE00CFCFCF00CFCFCF00CFCF
              CF00CDCDCD00CCCCCC00C9C9C900CBCBCB00C1C1C100B9B9B900FF00FF00CA97
              6F00F5E8CC00EFD6AB00F1D8AE00F2DAB000F3DCB300F3DEB400F3DEB400F3DE
              B400F3DCB200F1DBB000F1D8AD00F7EACD00CB997500FF00FF00FF00FF009C9C
              9C00E0E0E000CDCDCD00CFCFCF00D1D1D100D3D3D300D3D3D300D3D3D300D3D3
              D300D2D2D200D0D0D000CFCFCF00E2E2E200A0A0A000FF00FF00FF00FF00DCBF
              A900D7B08C00F8EFD300F3E0B900F3DFB700F4E1B900F5E3BB00F5E2BB00F5E2
              BB00F4E1B900F4E2BD00FAF1D500D9B39000D9BEA900FF00FF00FF00FF00C2C2
              C200B1B1B100E5E5E500D6D6D600D5D5D500D6D6D600D8D8D800D8D8D800D8D8
              D800D6D6D600D8D8D800E7E7E700B4B4B400C1C1C100FF00FF00FF00FF00FF00
              FF00D7B39500D9B38F00F7EDD300F8EED000F7EBC900F6E8C400F6E8C500F7EC
              CA00F8EED000F4E8CD00D7AF8B00D4B29600FF00FF00FF00FF00FF00FF00FF00
              FF00B6B6B600B4B4B400E5E5E500E4E4E400E0E0E000DDDDDD00DDDDDD00E0E0
              E000E4E4E400E0E0E000B1B1B100B5B5B500FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00E0C4AF00D2A37B00E2C4A200EBD7B800F4E9CD00F4EACE00ECD8
              B900E3C5A300D2A68000E4D1C200FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00C7C7C700A6A6A600C2C2C200D1D1D100E0E0E000E1E1E100D2D2
              D200C3C3C300A9A9A900D3D3D300FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00E2CAB400D7B19200D3A57E00D2A68100D6B0
              9200E0C8B300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00CBCBCB00B4B4B400A8A8A800A9A9A900B4B4
              B400C9C9C900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            NumGlyphs = 2
            TabOrder = 1
            OnClick = BitBtn2Click
          end
          object edtLink: TcxTextEdit
            Left = 196
            Top = 36
            Hint = #1057#1082#1086#1087#1080#1088#1091#1081#1090#1077' '#1089#1089#1099#1083#1082#1091' '#1080' '#1074#1089#1090#1072#1074#1100#1090#1077' '#1077#1077' '#1074' '#1083#1080#1095#1085#1086#1084' '#1082#1072#1073#1080#1085#1077#1090#1077' '#1050#1072#1089#1087#1080' '#1084#1072#1075#1072#1079#1080#1085#1072
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akLeft, akTop, akRight]
            Properties.MaxLength = 150
            Properties.ReadOnly = True
            Style.BorderStyle = ebsFlat
            Style.StyleController = dxEditStyleController
            TabOrder = 2
            Width = 424
          end
          object edtMerch: TcxTextEdit
            Left = 196
            Top = 11
            Hint = 'ID '#1087#1072#1088#1090#1085#1077#1088#1072' '#1050#1072#1089#1087#1080' '#1084#1072#1075#1072#1079#1080#1085#1072
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akLeft, akTop, akRight]
            Properties.MaxLength = 150
            Properties.ReadOnly = False
            Style.BorderStyle = ebsFlat
            Style.StyleController = dxEditStyleController
            TabOrder = 3
            OnExit = edtMerchExit
            OnKeyPress = edtMerchKeyPress
            Width = 424
          end
          object cxRgTypeID: TcxRadioGroup
            Left = 11
            Top = 74
            Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1080#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1090#1086#1074#1072#1088#1072' '#1076#1083#1103' Kaspi '#1084#1072#1075#1072#1079#1080#1085#1072
            ParentBackground = False
            ParentColor = False
            Properties.Columns = 3
            Properties.Items = <
              item
                Caption = 'ID '#1090#1086#1074#1072#1088#1072' '#1074' ShopUchet'
              end
              item
                Caption = #1040#1088#1090#1080#1082#1091#1083' '#1090#1086#1074#1072#1088#1072
              end
              item
                Caption = #1064#1090#1088#1080#1093#1082#1086#1076' '#1090#1086#1074#1072#1088#1072
              end>
            ItemIndex = 1
            Style.BorderColor = clWhite
            Style.Color = clWhite
            Style.LookAndFeel.Kind = lfFlat
            StyleDisabled.LookAndFeel.Kind = lfFlat
            StyleFocused.LookAndFeel.Kind = lfFlat
            StyleHot.LookAndFeel.Kind = lfFlat
            TabOrder = 4
            Height = 47
            Width = 612
          end
        end
        object cbKaspi: TcxCheckBox
          Left = 0
          Top = 0
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          AutoSize = False
          Caption = #1042#1099#1075#1088#1091#1078#1072#1090#1100' '#1074' Kaspi '#1084#1072#1075#1072#1079#1080#1085
          ParentFont = False
          Properties.Alignment = taLeftJustify
          Properties.MultiLine = True
          Properties.OnChange = cbUploadToFtpPropertiesChange
          Style.BorderStyle = ebsFlat
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -12
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = []
          Style.StyleController = dxEditStyleController
          Style.IsFontAssigned = True
          TabOrder = 2
          Height = 29
          Width = 630
        end
      end
      object tsInternetShop: TcxTabSheet
        Caption = #1048#1085#1090#1077#1088#1085#1077#1090'-'#1084#1072#1075#1072#1079#1080#1085
        ImageIndex = 4
        TabVisible = False
        object cxPageControl2: TcxPageControl
          Left = 0
          Top = 0
          Width = 630
          Height = 341
          Align = alClient
          TabOrder = 0
          Properties.ActivePage = tsEcwid
          Properties.CustomButtons.Buttons = <>
          Properties.NavigatorPosition = npLeftTop
          Properties.Style = 7
          ClientRectBottom = 340
          ClientRectLeft = 1
          ClientRectRight = 629
          ClientRectTop = 22
          object tsEcwid: TcxTabSheet
            Caption = 'ECWID.com'
            ImageIndex = 0
            DesignSize = (
              628
              318)
            object Shape8: TShape
              Left = 11
              Top = 57
              Width = 90
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Brush.Color = 16577773
              Pen.Color = clBtnShadow
            end
            object Shape7: TShape
              Left = 11
              Top = 32
              Width = 90
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Brush.Color = 16577773
              Pen.Color = clBtnShadow
            end
            object Label6: TLabel
              Left = 19
              Top = 38
              Width = 66
              Height = 14
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'ID '#1084#1072#1075#1072#1079#1080#1085#1072
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = 7492630
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Label8: TLabel
              Left = 19
              Top = 63
              Width = 72
              Height = 14
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Secret token'
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = 7492630
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object Shape11: TShape
              Left = 100
              Top = 32
              Width = 521
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Pen.Color = clBtnShadow
            end
            object Shape12: TShape
              Left = 100
              Top = 57
              Width = 521
              Height = 26
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Pen.Color = clBtnShadow
            end
            object edtIdStore: TcxTextEdit
              Left = 104
              Top = 35
              Hint = #1042#1072#1096' ID '#1084#1072#1075#1072#1079#1080#1085#1072' '#1089' '#1083#1080#1095#1085#1086#1075#1086' '#1082#1072#1073#1080#1085#1077#1090#1072' Ecwid.com'
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Enabled = False
              Properties.MaxLength = 150
              Properties.ReadOnly = False
              Style.BorderStyle = ebsFlat
              Style.StyleController = dxEditStyleController
              TabOrder = 0
              Height = 22
              Width = 513
            end
            object edtSecretToken: TcxTextEdit
              Left = 104
              Top = 59
              Hint = 'Secret token '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1089' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103' '#1074' '#1084#1072#1075#1072#1079#1080#1085#1077
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Enabled = False
              Properties.MaxLength = 150
              Properties.ReadOnly = False
              Style.BorderStyle = ebsFlat
              Style.StyleController = dxEditStyleController
              TabOrder = 1
              Height = 22
              Width = 513
            end
            object cbEcwid: TcxCheckBox
              Left = 0
              Top = 0
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              AutoSize = False
              Caption = #1042#1099#1075#1088#1091#1078#1072#1090#1100' '#1074' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1084#1072#1075#1072#1079#1080#1085' ECWID'
              ParentFont = False
              Properties.Alignment = taLeftJustify
              Properties.MultiLine = True
              Properties.OnChange = cbUploadToFtpPropertiesChange
              Style.BorderStyle = ebsFlat
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clWindowText
              Style.Font.Height = -12
              Style.Font.Name = 'Tahoma'
              Style.Font.Style = []
              Style.StyleController = dxEditStyleController
              Style.IsFontAssigned = True
              TabOrder = 2
              OnClick = cbEcwidClick
              Height = 29
              Width = 628
            end
            object btnClear: TcxButton
              Left = 37
              Top = 104
              Width = 548
              Height = 25
              Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099' '#1089' '#1089#1072#1081#1090#1072' eqwid.com'
              TabOrder = 3
              Visible = False
              OnClick = btnClearClick
            end
          end
        end
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 368
      Width = 630
      Height = 133
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        630
        133)
      object shpExportPeriod: TShape
        Left = 45
        Top = 4
        Width = 181
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lb4: TLabel
        Left = 154
        Top = 79
        Width = 327
        Height = 38
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taCenter
        Anchors = [akLeft, akBottom]
        Caption = 
          #1048#1079#1084#1077#1085#1077#1085#1080#1103' '#1074#1089#1090#1091#1087#1103#1090' '#1074' '#1089#1080#1083#1091' '#1089#1088#1072#1079#1091' '#1087#1086#1089#1083#1077' '#1085#1072#1078#1072#1090#1080#1103' '#1085#1072' '#1082#1085#1086#1087#1082#1091' "'#1057#1086#1093#1088#1072#1085#1080#1090 +
          #1100'".'
        Color = clWhite
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object lbExportPeriod: TLabel
        Left = 53
        Top = 11
        Width = 165
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1050#1072#1082' '#1095#1072#1089#1090#1086' '#1074#1099#1075#1088#1091#1078#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shpExportPeriod1: TShape
        Left = 225
        Top = 4
        Width = 372
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object shp3: TShape
        Left = 45
        Top = 29
        Width = 181
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Brush.Color = 16577773
        Pen.Color = clBtnShadow
      end
      object lb3: TLabel
        Left = 53
        Top = 33
        Width = 164
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #1059#1082#1072#1078#1080#1090#1077' '#1087#1072#1087#1082#1091' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = 7492630
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object shp4: TShape
        Left = 225
        Top = 29
        Width = 372
        Height = 26
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Pen.Color = clBtnShadow
      end
      object cbTime: TcxComboBox
        Left = 230
        Top = 6
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #1053#1080#1082#1086#1075#1076#1072
          #1055#1088#1080' '#1079#1072#1082#1088#1099#1090#1080#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
          #1050#1072#1078#1076#1099#1077' 15 '#1084#1080#1085#1091#1090
          #1050#1072#1078#1076#1099#1077' 30 '#1084#1080#1085#1091#1090
          #1050#1072#1078#1076#1099#1077' 45 '#1084#1080#1085#1091#1090
          #1050#1072#1078#1076#1099#1081' '#1095#1072#1089
          #1050#1072#1078#1076#1099#1077' 2 '#1095#1072#1089#1072
          #1050#1072#1078#1076#1099#1077' 3 '#1095#1072#1089#1072
          #1050#1072#1078#1076#1099#1077' 4 '#1095#1072#1089#1072)
        Style.StyleController = dxEditStyleController
        TabOrder = 0
        Text = #1053#1080#1082#1086#1075#1076#1072
        Width = 363
      end
      object bedtFileName: TcxButtonEdit
        Left = 230
        Top = 31
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = bedtFileNamePropertiesButtonClick
        Style.StyleController = dxEditStyleController
        Style.ButtonTransparency = ebtNone
        TabOrder = 1
        Width = 363
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 448
    Top = 517
    Width = 95
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ExplicitLeft = 448
    ExplicitTop = 517
    ExplicitWidth = 95
  end
  inherited btnCancel: TcxButton
    Left = 549
    Top = 517
    Width = 91
    ExplicitLeft = 549
    ExplicitTop = 517
    ExplicitWidth = 91
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 40
    Top = 440
  end
  inherited dxEditStyleController: TcxEditStyleController
    Left = 128
    Top = 432
    PixelsPerInch = 96
  end
  inherited cxEditRepository: TcxEditRepository
    Left = 80
    Top = 418
  end
  object spReadSklad: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM G_tochka')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 304
    Top = 96
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsReadSklad: TDataSource
    DataSet = spReadSklad
    Left = 263
    Top = 104
  end
  object RESTClient: TRESTClient
    Accept = 'application/json'
    AcceptCharset = 'UTF-8'
    AcceptEncoding = 'identity'
    BaseURL = 'https://postman-echo.com/post'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    HandleRedirects = True
    Left = 608
    Top = 144
  end
  object RESTRequest: TRESTRequest
    Accept = 'application/json'
    AcceptCharset = 'UTF-8'
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 608
    Top = 200
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 608
    Top = 248
  end
  object spG_Tochka: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      '    G_TOCHKA,'
      '    NAME'
      'FROM'
      '    G_TOCHKA ')
    Database = MainDM.dbMain
    Left = 360
    Top = 96
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsG_Tochka: TDataSource
    DataSet = spG_Tochka
    Left = 64
    Top = 120
  end
  object spCity: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      '    1 SORT_ID,'
      '    ID,'
      '    NAME'
      'FROM KASPI_CITY'
      'WHERE ID = 750000000'
      'UNION ALL'
      'SELECT'
      '    2 SORT_ID,'
      '    ID,'
      '    NAME'
      'FROM KASPI_CITY'
      'WHERE ID = 710000000'
      'UNION ALL'
      'SELECT'
      '    3 SORT_ID,'
      '    ID,'
      '    NAME'
      'FROM KASPI_CITY'
      'WHERE ID NOT IN (750000000, 710000000)'
      'ORDER BY 1, 3')
    Database = MainDM.dbMain
    Left = 168
    Top = 96
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsKaspi_Point: TDataSource
    DataSet = dxKaspiPoint
    Left = 136
    Top = 288
  end
  object spKaspi_Point: TpFIBDataSet
    UpdateSQL.Strings = (
      
        'UPDATE KASPI_POINT SET IDCITY=:IDCITY, G_TOCHKA=:G_TOCHKA, ADRES' +
        'S=:ADRESS'
      'WHERE IDPOINT=:IDPOINT'
      '    ')
    DeleteSQL.Strings = (
      'DELETE FROM'
      '    KASPI_POINT'
      'WHERE'
      '        IDPOINT = :OLD_IDPOINT'
      '    ')
    InsertSQL.Strings = (
      'INSERT INTO KASPI_POINT('
      '    IDPOINT,'
      '    IDCITY,'
      '    G_TOCHKA,'
      '    ADRESS'
      ')'
      'VALUES('
      '    gen_id(gen_kaspi_point_id,1),'
      '    :IDCITY,'
      '    :G_TOCHKA,'
      '    :ADRESS'
      ')')
    RefreshSQL.Strings = (
      ''
      '    ')
    SelectSQL.Strings = (
      'select IDPOINT, IDCITY, G_TOCHKA, ADRESS'
      'from KASPI_POINT')
    Transaction = MainDM.tranMainWrite
    Database = MainDM.dbMain
    Left = 40
    Top = 264
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
  object dsCity: TDataSource
    DataSet = spCity
    Left = 392
    Top = 120
  end
  object dxKaspiPoint: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterInsert = dxKaspiPointAfterInsert
    AfterEdit = dxKaspiPointAfterEdit
    AfterDelete = dxKaspiPointAfterDelete
    Left = 48
    Top = 328
    object lrgntfldReportXIDPOINT: TLargeintField
      FieldName = 'IDPOINT'
    end
    object intgrfldReportXIDCITY: TIntegerField
      FieldName = 'IDCITY'
    end
    object lrgntfldReportXG_TOCHKA: TLargeintField
      FieldName = 'G_TOCHKA'
    end
    object strngfldReportXADRESS: TStringField
      FieldName = 'ADRESS'
      Size = 100
    end
  end
  object pUpdIDProduct: TpFIBQuery
    Transaction = MainDM.tranMainWrite
    Database = MainDM.dbMain
    SQL.Strings = (
      'UPDATE G_PRODUCT SET NOMENCLATUR_NUM = ?NOMENCLATUR_NUM '
      'WHERE NAME = ?NAME')
    Left = 297
    Top = 291
  end
  object pClearProducts: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT t.nomenclatur_num'
      'FROM G_PRODUCT T'
      'WHERE t.nomenclatur_num <> '#39#39' and '
      't.nomenclatur_num is not NULL'
      'group by t.nomenclatur_num')
    Transaction = MainDM.tranMainRead
    Database = MainDM.dbMain
    Left = 464
    Top = 248
    poSQLINT64ToBCD = True
    poAskRecordCount = True
  end
end
