inherited BankForm: TBankForm
  Left = 558
  Top = 219
  Caption = #1056#1077#1082#1080#1079#1080#1090#1099' '#1073#1072#1085#1082#1072
  ClientHeight = 195
  ClientWidth = 593
  OnCreate = FormCreate
  ExplicitWidth = 599
  ExplicitHeight = 221
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 573
    Height = 148
    ExplicitWidth = 573
    ExplicitHeight = 148
    object Shape1: TShape
      Left = 8
      Top = 9
      Width = 176
      Height = 26
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Shape2: TShape
      Left = 8
      Top = 34
      Width = 176
      Height = 50
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label2: TLabel
      Left = 18
      Top = 56
      Width = 83
      Height = 14
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
      Left = 183
      Top = 34
      Width = 382
      Height = 50
      Pen.Color = clBtnShadow
    end
    object Label1: TLabel
      Left = 18
      Top = 15
      Width = 22
      Height = 14
      Caption = #1041#1048#1050
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape3: TShape
      Left = 183
      Top = 9
      Width = 382
      Height = 26
      Pen.Color = clBtnShadow
    end
    object Shape5: TShape
      Left = 8
      Top = 83
      Width = 176
      Height = 52
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label3: TLabel
      Left = 18
      Top = 103
      Width = 132
      Height = 14
      Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape6: TShape
      Left = 183
      Top = 83
      Width = 382
      Height = 52
      Pen.Color = clBtnShadow
    end
    object meName: TcxMemo
      Left = 190
      Top = 38
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 500
      Style.StyleController = dxEditStyleController
      TabOrder = 1
      Height = 44
      Width = 368
    end
    object meShortName: TcxMemo
      Left = 190
      Top = 87
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 500
      Style.StyleController = dxEditStyleController
      TabOrder = 2
      Height = 44
      Width = 368
    end
    object edBik: TcxTextEdit
      Left = 190
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Properties.MaxLength = 8
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      OnKeyPress = edBikKeyPress
      Width = 368
    end
  end
  inherited btnOk: TcxButton
    Left = 417
    Top = 163
    ExplicitLeft = 417
    ExplicitTop = 163
  end
  inherited btnCancel: TcxButton
    Left = 504
    Top = 163
    ExplicitLeft = 504
    ExplicitTop = 163
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited tranRead: TpFIBTransaction
    Left = 8
    Top = 160
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_BANK (?G_BANK_)')
    StoredProcName = 'G_GET_G_BANK'
    Left = 40
    Top = 160
  end
  inherited tranWrite: TpFIBTransaction
    Left = 72
    Top = 160
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_INS_G_BANK (?BIK_, ?NAME_, ?SHORT_NAME_)')
    StoredProcName = 'G_INS_G_BANK'
    Left = 104
    Top = 160
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_BANK (?G_BANK_, ?BIK_, ?NAME_, ?SHORT_' +
        'NAME_)')
    StoredProcName = 'G_UPD_G_BANK'
    Left = 136
    Top = 160
  end
end
