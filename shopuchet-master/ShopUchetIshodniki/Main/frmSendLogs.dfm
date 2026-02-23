object SendLogsForm: TSendLogsForm
  Left = 0
  Top = 0
  Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1083#1086#1075#1086#1074
  ClientHeight = 406
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    498
    406)
  PixelsPerInch = 96
  TextHeight = 13
  object edtDatStart: TcxDateEdit
    Left = 119
    Top = 315
    Anchors = [akLeft, akBottom]
    EditValue = 43831d
    Properties.SaveTime = False
    Properties.ShowTime = False
    Style.BorderStyle = ebsFlat
    TabOrder = 0
    ExplicitTop = 317
    Width = 121
  end
  object edtDateEnd: TcxDateEdit
    Left = 283
    Top = 315
    Anchors = [akRight, akBottom]
    EditValue = 43831d
    Properties.SaveTime = False
    Properties.ShowTime = False
    Style.BorderStyle = ebsFlat
    TabOrder = 1
    ExplicitTop = 317
    Width = 121
  end
  object cxlbl1: TcxLabel
    Left = 0
    Top = 289
    Align = alTop
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1077#1088#1080#1086#1076', '#1079#1072' '#1082#1086#1090#1086#1088#1099#1081' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1086#1090#1087#1088#1072#1074#1080#1090#1100' '#1083#1086#1075#1080
    Properties.Alignment.Horz = taCenter
    ExplicitTop = 274
    AnchorX = 249
  end
  object cxlbl2: TcxLabel
    Left = 102
    Top = 316
    Anchors = [akLeft, akBottom]
    Caption = #1057
    ExplicitTop = 318
  end
  object cxlbl3: TcxLabel
    Left = 258
    Top = 316
    Anchors = [akRight, akBottom]
    Caption = #1055#1054
    ExplicitTop = 318
  end
  object btnSend: TcxButton
    Left = 8
    Top = 345
    Width = 484
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
    LookAndFeel.Kind = lfFlat
    TabOrder = 5
    OnClick = btnSendClick
    ExplicitTop = 498
    ExplicitWidth = 314
  end
  object btnClose: TcxButton
    Left = 8
    Top = 376
    Width = 484
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    LookAndFeel.Kind = lfFlat
    ModalResult = 1
    TabOrder = 6
    ExplicitTop = 529
    ExplicitWidth = 314
  end
  object mmo1: TcxMemo
    Left = 0
    Top = 20
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Properties.ReadOnly = True
    Properties.ScrollBars = ssVertical
    Style.BorderStyle = ebsFlat
    TabOrder = 7
    ExplicitTop = 17
    ExplicitWidth = 500
    ExplicitHeight = 256
    Height = 254
    Width = 498
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 498
    Height = 20
    Align = alTop
    Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072' '#1089#1077#1075#1086#1076#1085#1103
    TabOrder = 8
    ExplicitWidth = 500
  end
  object pnl2: TPanel
    Left = 0
    Top = 274
    Width = 498
    Height = 15
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 9
  end
  object JvThread1: TJvThread
    Exclusive = True
    MaxCount = 0
    RunOnCreate = True
    FreeOnTerminate = True
    OnExecute = JvThread1Execute
    Left = 256
    Top = 496
  end
end
