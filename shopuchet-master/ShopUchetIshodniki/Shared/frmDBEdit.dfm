inherited DBEditForm: TDBEditForm
  Left = 293
  Top = 53
  Caption = 'DBEditForm'
  ClientHeight = 444
  ClientWidth = 569
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 575
  ExplicitHeight = 470
  DesignSize = (
    569
    444)
  PixelsPerInch = 96
  TextHeight = 14
  inherited btnOk: TcxButton
    Left = 395
    ExplicitLeft = 395
  end
  inherited btnCancel: TcxButton
    Left = 481
    ExplicitLeft = 481
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object tranRead: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 112
    Top = 408
  end
  object spGetData: TpFIBStoredProc
    Transaction = tranRead
    Database = MainDM.dbMain
    Left = 144
    Top = 408
  end
  object tranWrite: TpFIBTransaction
    DefaultDatabase = MainDM.dbMain
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 176
    Top = 408
  end
  object spIns: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 208
    Top = 408
  end
  object spUpd: TpFIBStoredProc
    Transaction = tranWrite
    Database = MainDM.dbMain
    Left = 240
    Top = 408
  end
end
