inherited UpdSmsNotifyHistoryForm: TUpdSmsNotifyHistoryForm
  Caption = #1048#1079#1084#1077#1085#1080#1090#1100' SMS'
  ClientHeight = 248
  ClientWidth = 481
  OnCreate = FormCreate
  ExplicitWidth = 487
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 466
    Height = 203
    ExplicitWidth = 466
    ExplicitHeight = 203
    object shp5: TShape
      Left = 8
      Top = 100
      Width = 144
      Height = 93
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shp3: TShape
      Left = 8
      Top = 37
      Width = 144
      Height = 64
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object shp1: TShape
      Left = 8
      Top = 12
      Width = 144
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object lb1: TLabel
      Left = 18
      Top = 18
      Width = 120
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1052#1086#1073#1080#1083#1100#1085#1099#1081' '#1090#1077#1083#1077#1092#1086#1085
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shp2: TShape
      Left = 151
      Top = 12
      Width = 306
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb2: TLabel
      Left = 18
      Top = 59
      Width = 101
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1058#1077#1082#1089#1090' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shp4: TShape
      Left = 151
      Top = 37
      Width = 306
      Height = 64
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object lb3: TLabel
      Left = 18
      Top = 138
      Width = 60
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object shp7: TShape
      Left = 151
      Top = 100
      Width = 306
      Height = 93
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object edPhone: TcxMaskEdit
      Left = 157
      Top = 15
      Properties.EditMask = '+79990000000;1;_'
      Properties.MaxLength = 0
      Properties.OnValidate = edPhonePropertiesValidate
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Text = '+7          '
      Width = 295
    end
    object mSmsNotifyText: TcxMemo
      Left = 157
      Top = 41
      Properties.MaxLength = 500
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Height = 56
      Width = 295
    end
    object cbHowSend: TcxComboBox
      Left = 157
      Top = 109
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1053#1077#1084#1077#1076#1083#1077#1085#1085#1086
        #1042' '#1091#1082#1072#1079#1072#1085#1085#1086#1077' '#1074#1088#1077#1084#1103)
      Properties.OnChange = cbHowSendPropertiesChange
      Style.StyleController = dxEditStyleController
      TabOrder = 2
      Text = #1053#1077#1084#1077#1076#1083#1077#1085#1085#1086
      Width = 148
    end
    object edDate: TcxDateEdit
      Left = 157
      Top = 136
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Enabled = False
      Properties.InputKind = ikMask
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      Style.ButtonStyle = bts3D
      TabOrder = 3
      Width = 148
    end
    object edTime: TcxTimeEdit
      Left = 157
      Top = 163
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      EditValue = 0d
      Enabled = False
      Properties.BeepOnError = True
      Properties.TimeFormat = tfHourMin
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 4
      Width = 148
    end
  end
  inherited btnOk: TcxButton
    Left = 231
    Top = 214
    Width = 153
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1086#1074#1090#1086#1088#1085#1086
    ExplicitLeft = 231
    ExplicitTop = 214
    ExplicitWidth = 153
  end
  inherited btnCancel: TcxButton
    Left = 397
    Top = 214
    ExplicitLeft = 397
    ExplicitTop = 214
  end
  inherited btHelp: TcxButton
    Top = 214
    ExplicitTop = 214
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 200
    Top = 280
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Left = 152
    Top = 210
  end
  inherited tranRead: TpFIBTransaction
    Left = 104
    Top = 210
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE SMS_HISTORY_GET (?SMS_HISTORY_)')
    StoredProcName = 'SMS_HISTORY_GET'
    Left = 136
    Top = 210
  end
  inherited tranWrite: TpFIBTransaction
    Left = 168
    Top = 210
  end
  inherited spIns: TpFIBStoredProc
    Left = 200
    Top = 210
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE SMS_HISTORY_UPD (?SMS_HISTORY_, ?DATETIME_, ?G' +
        '_SMS_STATUS_, ?SMS_ID_, ?PHONE_, ?ERROR_, ?TEXT_)')
    StoredProcName = 'SMS_HISTORY_UPD'
    Left = 232
    Top = 210
  end
end
