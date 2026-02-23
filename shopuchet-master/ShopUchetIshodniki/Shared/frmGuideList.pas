unit frmGuideList;

{$I ShopUchet.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frmDBList, StdCtrls, ToolWin, ComCtrls, ExtCtrls, dxBar, ActnList,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid, Db, FIBDataSet, pFIBDataSet,
  dxBarExtItems, Menus, FIBQuery, pFIBQuery, pFIBStoredProc, FIBDatabase,
  pFIBDatabase, dxBarExtDBItems, dxExEdtr;

type
  TGuideListForm = class(TDBListForm)
  private
  public
  end;

implementation

uses frmMain, unDBSupport;

{$R *.DFM}

end.
