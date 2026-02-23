inherited AppointmentForm: TAppointmentForm
  Left = 525
  Top = 188
  Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
  ClientHeight = 95
  ClientWidth = 567
  OnCreate = FormCreate
  ExplicitWidth = 573
  ExplicitHeight = 121
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
      Width = 64
      Height = 14
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
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
    object edName: TcxTextEdit
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
    Left = 401
    Top = 60
    ExplicitLeft = 401
    ExplicitTop = 60
  end
  inherited btnCancel: TcxButton
    Left = 486
    Top = 60
    ExplicitLeft = 486
    ExplicitTop = 60
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  inherited spGetData: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_GET_G_APPOINTMENT (?G_APPOINTMENT_)')
    StoredProcName = 'G_GET_G_APPOINTMENT'
    Left = 8
    Top = 56
  end
  inherited spIns: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_INS_G_APPOINTMENT (?NAME_)')
    StoredProcName = 'G_INS_G_APPOINTMENT'
    Left = 40
    Top = 56
  end
  inherited spUpd: TpFIBStoredProc
    SQL.Strings = (
      'EXECUTE PROCEDURE G_UPD_G_APPOINTMENT (?G_APPOINTMENT_, ?NAME_)')
    StoredProcName = 'G_UPD_G_APPOINTMENT'
    Left = 72
    Top = 56
  end
end
