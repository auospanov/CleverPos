unit frmGuide;

{$I ShopUchet.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frmDBEdit, FIBQuery, pFIBQuery, pFIBStoredProc, ExtCtrls, StdCtrls,
  Buttons, dxCntner, dxExEdtr, FIBDatabase, pFIBDatabase, ActnList;

type
  TGuideForm = class(TDBEditForm)
  private
  public
  end;

implementation

uses unDBSupport;

{$R *.DFM}

end.
