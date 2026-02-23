inherited GUnitForm: TGUnitForm
  Left = 558
  Top = 219
  Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  ClientHeight = 117
  ClientWidth = 389
  OnCreate = FormCreate
  ExplicitWidth = 395
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 369
    Height = 72
    ExplicitWidth = 369
    ExplicitHeight = 72
    object Shape1: TShape
      Left = 8
      Top = 35
      Width = 119
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 10
      Width = 119
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 16
      Width = 83
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape4: TShape
      Left = 126
      Top = 10
      Width = 234
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 18
      Top = 41
      Width = 103
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084'-'#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape3: TShape
      Left = 126
      Top = 35
      Width = 234
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object edName: TcxTextEdit
      Left = 131
      Top = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 50
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 225
    end
    object edShortName: TcxTextEdit
      Left = 131
      Top = 38
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 10
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Width = 225
    end
  end
  inherited btnOk: TcxButton
    Left = 219
    Top = 85
    ExplicitLeft = 219
    ExplicitTop = 85
  end
  inherited btnCancel: TcxButton
    Left = 302
    Top = 85
    ExplicitLeft = 302
    ExplicitTop = 85
  end
  inherited btHelp: TcxButton
    Top = 85
    ExplicitTop = 85
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_UNIT (?G_UNIT_)')
    StoredProcName = 'G_GET_G_UNIT'
    Left = 14
    Top = 324
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_INS_G_UNIT (?NAME_, ?SHORT_NAME_)')
    StoredProcName = 'G_INS_G_UNIT'
    Left = 46
    Top = 324
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_UPD_G_UNIT (?G_UNIT_, ?NAME_, ?SHORT_NAME_)')
    StoredProcName = 'G_UPD_G_UNIT'
    Left = 78
    Top = 324
  end
end
