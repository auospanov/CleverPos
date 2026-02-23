inherited AddressTypeForm: TAddressTypeForm
  Left = 538
  Top = 257
  Caption = #1058#1080#1087' '#1072#1076#1088#1077#1089#1072
  ClientHeight = 99
  ClientWidth = 567
  OnCreate = FormCreate
  ExplicitWidth = 573
  ExplicitHeight = 125
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 555
    Height = 49
    ExplicitWidth = 555
    ExplicitHeight = 49
    object Shape25: TShape
      Left = 8
      Top = 9
      Width = 169
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Brush.Color = 16577773
      Pen.Color = clBtnShadow
    end
    object Label13: TLabel
      Left = 18
      Top = 15
      Width = 65
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1058#1080#1087' '#1072#1076#1088#1077#1089#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = 7492630
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Shape4: TShape
      Left = 167
      Top = 9
      Width = 382
      Height = 26
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Pen.Color = clBtnShadow
    end
    object edAddress: TcxTextEdit
      Left = 173
      Top = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style.BorderStyle = ebsFlat
      Style.StyleController = dxEditStyleController
      TabOrder = 0
      Width = 372
    end
  end
  inherited btnOk: TcxButton
    Left = 400
    Top = 64
    ExplicitLeft = 400
    ExplicitTop = 64
  end
  inherited btnCancel: TcxButton
    Left = 486
    Top = 64
    ExplicitLeft = 486
    ExplicitTop = 64
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_ADDRESS_TYPE (?G_ADDRESS_TYPE_)')
    StoredProcName = 'G_GET_G_ADDRESS_TYPE'
    Left = 16
    Top = 64
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_INS_G_ADDRESS_TYPE (?NAME_)')
    StoredProcName = 'G_INS_G_ADDRESS_TYPE'
    Left = 48
    Top = 64
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      
        'EXECUTE PROCEDURE G_UPD_G_ADDRESS_TYPE (?G_ADDRESS_TYPE_, ?NAME_' +
        ')')
    StoredProcName = 'G_UPD_G_ADDRESS_TYPE'
    Left = 80
    Top = 64
  end
end
