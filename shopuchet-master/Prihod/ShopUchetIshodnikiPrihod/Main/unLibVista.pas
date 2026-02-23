unit unLibVista;

interface
type my_Char = array of Char;

type my_ArchListItem = Packed Record
   type_ : LongInt;
   name  : pChar;
   size  : LongWord;
   usize : LongWord;
   mode  : LongWord;
   c_time: LongInt;
   a_time: LongInt;
   reserv: LongWord;
end;
type pmy_ArchListItem = ^my_ArchListItem;

type ArchList = array of my_ArchListItem;
//type ArchList1 = array of my_ArchListItem;



type VLISTITEM = Packed Record
   type_    : LongInt;
   name     : pChar;
   size     : LongWord;
   c_time   : LongWord;
   mode     : LongWord;
   nlink    : LongInt;
   priority : LongInt;
End;

type pArchList_array = ^ArchList;
type pArchList = ^my_ArchListItem;

type ArrayChar = array[1..32] of char;
type pArrayChar = ^ArrayChar;
type charArray = array[1..80] of char;
type charDynArray = array of char;
type charArray2 = ^charArray;
type ArrayRecipients = array of pAnsiChar;//ArrayChar;
type pArrayRecipients =^ArrayRecipients;
type Array_VLISTITEM = array of VLISTITEM;
type pVLISTITEM = ^VLISTITEM;
type pLW = ^LongWord;
type tBuf = array[1..8192] of char;

// создание архива
function CArchCreate(phArch: Pointer; type_: LongInt; fname: PChar; comment: PChar; csize: LongInt): LongInt; stdcall;
function CArchOpen(phArch: Pointer; Var type_: LongInt; fname: PChar): LongInt; stdcall;
function CArchSetStore(phArch: Pointer; host: PChar; port: LongInt; validTime: LongInt): LongInt; stdcall;
function CArchInitCrypt(phArch: Pointer; myContainer: PChar; myDN: PChar): LongInt; stdcall;
function CArchSetRecipients(phArch: Pointer; rcDN: {Pointer}ArrayRecipients; count: LongInt): LongInt; stdcall;
function CArchListDir(phArch: Pointer; path: PChar; sub: LongBool; List: Pointer{ArchList}; var count: LongInt): LongInt; stdcall;
function CArchAddListFile(phArch: Pointer; List: pmy_ArchListItem): LongInt; stdcall;
function CArchGetReferens(phArch: Pointer; ref: Pointer): LongInt; stdcall;
function CArchAddSign(phArch: Pointer):LongInt; stdcall;
function CArchClose(phArch: Pointer): LongInt; stdcall;

//отправка и принятие архива
function vcOpenLocal(phDst: Pointer; location: PChar): LongInt; stdcall;
function vcOpenRemote(phDst: Pointer; host:PChar; port: PChar; prof: PChar; myDN: PChar; type_: LongInt; ltout: LongInt; stout: LongInt; Var srDN: charArray; store_host: pChar; store_port: LongInt; valid_time: LongInt; proxy_type: LongInt; proxy_host: pChar; proxy_port: LongInt; proxy_user: pChar; proxy_pass: pChar; proxy_exclude_list: pChar): LongInt; stdcall;
function vcList(hDst: Pointer; sort_rule : PChar; List : Pointer; Var count : longint): LongInt; stdcall;
function vcCopyMessage(hDst: Pointer; file_: PChar; hSrc: Pointer; {Var conf_data: charArray2}conf_data: Pointer; conf_size: pLongWord; conf_message: pChar): LongInt; stdcall;
function vcClose(phDst: Pointer): LongInt; stdcall;
function CArchGetEnvelopInfo(hArch: Pointer; var snDN: pArrayChar; var rcDN: pArrayRecipients; var size: LongInt): LongInt; stdcall;


// распаковка архива
function CArchListArchFile(hArch: Pointer; list: Pointer; Var count: LongInt): LongInt; stdcall;
function CArchExtrListFile(hArch: Pointer; item: pmy_ArchListItem; dest_path: pChar; flag_path : LongBool): LongInt; stdcall;


implementation
// создание архива
function CArchCreate(phArch: Pointer; type_: LongInt; fname: PChar; comment: PChar; csize: LongInt): LongInt; stdcall; external 'libvista.dll' name 'CArchCreate';
function CArchOpen(phArch: Pointer; Var type_: LongInt; fname: PChar): LongInt; stdcall; external 'libvista.dll' name 'CArchOpen';
function CArchSetStore(phArch: Pointer; host: PChar; port: LongInt; validTime: LongInt): LongInt; stdcall; external 'libvista.dll' name 'CArchSetStore';
function CArchInitCrypt(phArch: Pointer; myContainer: PChar; myDN: PChar): LongInt; stdcall; external 'libvista.dll' name 'CArchInitCrypt';
function CArchSetRecipients(phArch: Pointer; rcDN: ArrayRecipients{Pointer}; count: LongInt): LongInt; stdcall; external 'libvista.dll' name 'CArchSetRecipients';
function CArchListDir(phArch: Pointer; path: PChar; sub: LongBool; List: {ArchList}Pointer; var count: LongInt): LongInt; stdcall; external 'libvista.dll' name 'CArchListDir';
function CArchAddListFile(phArch: Pointer; List: pmy_ArchListItem): LongInt;  stdcall; external 'libvista.dll' name 'CArchAddListFile';
function CArchGetReferens(phArch: Pointer; ref: Pointer): LongInt; stdcall; external 'libvista.dll' name 'CArchGetReferens';
function CArchAddSign(phArch: Pointer):LongInt; stdcall; external 'libvista.dll' name 'CArchAddSign';
function CArchClose(phArch: Pointer): LongInt; stdcall; external 'libvista.dll' name 'CArchClose';

//отправка архива
function vcOpenLocal(phDst: Pointer; location: PChar): LongInt; stdcall; external 'libvista.dll' name 'vcOpenLocal';
function vcOpenRemote(phDst: Pointer; host:PChar; port: PChar; prof: PChar; myDN: PChar; type_: LongInt; ltout: LongInt; stout: LongInt; Var srDN: charArray; store_host: pChar; store_port: LongInt; valid_time: LongInt; proxy_type: LongInt; proxy_host: pChar; proxy_port: LongInt; proxy_user: pChar; proxy_pass: pChar; proxy_exclude_list: pChar): LongInt; stdcall; external 'libvista.dll' name 'vcOpenRemote';
function vcList(hDst: Pointer; sort_rule : PChar; List : Pointer; Var count : longint): LongInt; stdcall; external 'libvista.dll' name 'vcList';
function vcCopyMessage(hDst: Pointer; file_: PChar; hSrc: Pointer; conf_data: Pointer; conf_size: pLongWord; conf_message: pChar): LongInt; stdcall; external 'libvista.dll' name 'vcCopyMessage';
function vcClose(phDst: Pointer): LongInt; stdcall; external 'libvista.dll' name 'vcClose';
function CArchGetEnvelopInfo(hArch: Pointer; var snDN: pArrayChar; var rcDN: pArrayRecipients; var size: LongInt): LongInt; stdcall; external 'libvista.dll' name 'CArchGetEnvelopInfo';

// распаковка архива
function CArchListArchFile(hArch: Pointer; list: Pointer; Var count : LongInt): LongInt; stdcall; external 'libvista.dll' name 'CArchListArchFile';
function CArchExtrListFile(hArch: Pointer; item: pmy_ArchListItem; dest_path: pChar; flag_path : LongBool): LongInt; stdcall; external 'libvista.dll' name 'CArchExtrListFile';

end.
