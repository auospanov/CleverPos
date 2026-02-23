object FrmNews: TFrmNews
  Left = 0
  Top = 0
  BorderIcons = []
  ClientHeight = 438
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 21
  object btn1: TcxButton
    Left = 0
    Top = 397
    Width = 587
    Height = 41
    Align = alBottom
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077
    DropDownMenu = pmn1
    Kind = cxbkDropDown
    TabOrder = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object mmo1: TMemo
    Left = 0
    Top = 0
    Width = 587
    Height = 397
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WantTabs = True
    ExplicitHeight = 313
  end
  object pmn1: TPopupMenu
    OwnerDraw = True
    Left = 296
    Top = 16
    object mUpdate: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = mUpdateClick
      OnDrawItem = mUpdateDrawItem
      OnMeasureItem = mUpdateMeasureItem
    end
    object msUpdate: TMenuItem
      Caption = '-'
    end
    object mSkipWeek: TMenuItem
      Caption = #1053#1072#1087#1086#1084#1085#1080#1090#1100' '#1095#1077#1088#1077#1079' '#1085#1077#1076#1077#1083#1102
      OnClick = mSkipWeekClick
      OnDrawItem = mUpdateDrawItem
      OnMeasureItem = mUpdateMeasureItem
    end
    object msSkipWeek: TMenuItem
      Caption = '-'
    end
    object mSkipMonth: TMenuItem
      Caption = #1053#1072#1087#1086#1084#1085#1080#1090#1100' '#1095#1077#1088#1077#1079' '#1084#1077#1089#1103#1094
      OnClick = mSkipMonthClick
      OnDrawItem = mUpdateDrawItem
      OnMeasureItem = mUpdateMeasureItem
    end
    object msSkipMonth: TMenuItem
      Caption = '-'
    end
    object mSkip: TMenuItem
      Caption = #1053#1077' '#1085#1072#1087#1086#1084#1080#1085#1072#1090#1100
      OnClick = mSkipClick
      OnDrawItem = mUpdateDrawItem
      OnMeasureItem = mUpdateMeasureItem
    end
  end
end
