unit unCertex;

interface
Const MaxCertBodySize = 8196;
type bytearray = array of byte;
type pbyte = ^bytearray;
type dwordarray = array of longword;
//type pDwordArray = ^dwordarray;
//type pLongWord = ^LongWord;
type HCRYPTPROV = Pointer;
type HCRYPTKEY = Pointer;
type HCRYPTHASH =Pointer;
type hCERTSTORE = Pointer;
type hCERTCONTEXT = Pointer;
type hCRYPTMSG = Pointer;
type hCERTCOLLECTION = Pointer;
type Cert_Body = array[1..MaxCertBodySize] of char;
type pCert_Body = ^Cert_Body;
type tArray32 = array[1..32] of char;
type pArray32 = ^tArray32;
type char260 = array[1..260] of char;
type char16 = array[1..16] of char;


type tData = array of char;
type pData = ^tData;
type p_Byte = ^byte;


function CSPOpenContext(phProv: Pointer; pszContainer : pChar; dwProvType: LongWord; dwProvParam: LongWord; dwFlags: LongWord; pbSignature: pByte; dwSigLen: LongWord; pbContainer: Pointer; dwContLen: Pointer; phLib: Pointer): LongInt; cdecl;
function CrtOpenStore(StoreProvider: LongWord; hProv: HCRYPTPROV; dwFlags: LongWord; bFlag : Boolean; pvParam: pLongWord; phStore: hCERTSTORE): LongInt; cdecl;
function SetLDAPver(hStore: hCERTSTORE; ver : LongInt): LongInt; cdecl;
function CrtSetStorePropertyExt(hStore: hCERTSTORE; Flags : LongWord; DName: pChar; host: pChar; port: pChar; timeOut: LongInt; name: pChar; pass: pChar ): LongInt; cdecl;
function GetMYCertificate(hStore: hCERTSTORE; DName: pChar; keySpec: LongWord; isCA: LongBool; certBody: Pointer; bodySize: pLongWord): LongInt; cdecl;
function GetCertificateContext(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; phContext: hCERTCONTEXT): LongInt; cdecl;
function GetCertSubjectKey(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; keyOID: pChar; key: Pointer; KeySize: Pointer ): LongInt; cdecl;
function GetCertSignature(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; sigOID: Pointer; sign: Pointer; signSize: Pointer ): LongInt; cdecl;
function CSPOIDtoHashOIDex(hProv: HCRYPTPROV; OID: Pointer; hashOID: Pointer): LongInt; cdecl;
function SignMsgOpen(hProv: HCRYPTPROV; Flags: LongWord; phCrypt: hCRYPTMSG): LongInt; cdecl;
function SignMessage(hCrypt: hCRYPTMSG; hStore: hCERTSTORE; MYCert: hCERTCONTEXT; hashOID: pChar; signOID: pChar;  dataOID: pChar; Final: LongBool; dataToSigned: Pointer; dataSize: LongInt; dataDescriptor: pChar; Flags: LongWord; signedBlob: Pointer; sizeBlob: Pointer ): LongInt; cdecl;
function Base2Bin(inBuf: Pointer; inSize: LongWord; outBuf: Pointer; Var outSize: LongWord): LongInt; cdecl;
function Bin2Base(inBuf: Pointer; inSize: LongWord; outBuf: Pointer; Var outSize: LongWord): LongInt; cdecl;
function ReleaseCertificateContext(hStore: hCERTSTORE; hContext: Pointer): LongInt; cdecl;
function SignMsgClose(phCrypt: Pointer): LongInt; cdecl;
function CrtCloseStore(phStore: Pointer): LongInt; cdecl;
function CSPCloseContext(phProv: Pointer): LongInt; cdecl;
function MessageSignatureAlg(cmsData: Pointer; dataSize: LongWord; SignOID: Pointer; HashOID: Pointer) : LongInt; cdecl;
function CSPGetHash(hProv: HCRYPTPROV; hashOID: pChar; Final: LongBool; strReq: Pointer; reqSize: LongWord; strHash: Pointer; Var hashSize: LongWord): LongInt; cdecl;
function MessageDigest(cmsData: Pointer; dataSize: LongWord; Digest: Pointer; Var digestSize: LongWord) : LongInt; cdecl;
function MessageKeysCount(cmsData: Pointer; dataSize: LongWord; count: Pointer) : LongInt; cdecl;
function GetMessageCertificate(hStore: hCERTSTORE; CMSBlob: Pointer; sizeBlob: LongWord; hCollection: hCERTCOLLECTION) : LongInt; cdecl;
function VerifySignMessage(hCrypt: hCRYPTMSG; hCollection: hCERTCOLLECTION; SignedBlob: Pointer; sizeBlob: LongWord; Flags: LongInt; SignerName: Pointer; timeToSigned: Pointer; dataDescriptor: Pointer; dataToSigned: Pointer; var dataSize: LongWord; dataOID: Pointer; Var VerifyRes: LongInt) : LongInt; cdecl;
function FreeCertificateCollection(hCollection: hCERTCOLLECTION) : LongInt; cdecl;
function GetCertValidInfo(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; notBefore: pChar; notAfter: pChar) : LongInt; cdecl;

implementation
function CSPOpenContext(phProv: Pointer; pszContainer : pChar; dwProvType: LongWord; dwProvParam: LongWord; dwFlags: LongWord; pbSignature: pByte; dwSigLen: LongWord; pbContainer: Pointer; dwContLen: Pointer; phLib: Pointer): LongInt; cdecl; external 'strlib.dll' name 'CSPOpenContext';
function CrtOpenStore(StoreProvider: LongWord; hProv: HCRYPTPROV; dwFlags: LongWord; bFlag : Boolean; pvParam: pLongWord; phStore: hCERTSTORE): LongInt; cdecl; external 'strlib.dll' name 'CrtOpenStore';
function SetLDAPver(hStore: hCERTSTORE; ver: LongInt): LongInt; cdecl; external 'strlib.dll' name 'SetLDAPver';
function CrtSetStorePropertyExt(hStore: hCERTSTORE; Flags : LongWord; DName: pChar; host: pChar; port: pChar; timeOut: LongInt; name: pChar; pass: pChar ): LongInt; cdecl; external 'strlib.dll' name 'CrtSetStorePropertyExt';
function GetMYCertificate(hStore: hCERTSTORE; DName: pChar; keySpec: LongWord; isCA: LongBool; certBody: Pointer; bodySize: pLongWord): LongInt; cdecl; external 'strlib.dll' name 'GetMYCertificate';
function GetCertificateContext(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; phContext: hCERTCONTEXT): LongInt; cdecl; external 'strlib.dll' name 'GetCertificateContext';
function GetCertSubjectKey(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; keyOID: pChar; key: Pointer; keySize: Pointer ): LongInt; cdecl; external 'strlib.dll' name 'GetCertSubjectKey';
function GetCertSignature(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; sigOID: Pointer; sign: Pointer; signSize: Pointer ): LongInt;  cdecl; external 'strlib.dll' name 'GetCertSignature';
function CSPOIDtoHashOIDex(hProv: HCRYPTPROV; OID: Pointer; hashOID: Pointer): LongInt; cdecl; external 'strlib.dll' name 'CSPOIDtoHashOIDex';
function SignMsgOpen(hProv: HCRYPTPROV; Flags: LongWord; phCrypt: hCRYPTMSG): LongInt; cdecl; external 'strlib.dll' name 'SignMsgOpen';
function SignMessage(hCrypt: hCRYPTMSG; hStore: hCERTSTORE; MYCert: hCERTCONTEXT;  hashOID: pChar; signOID: pChar; dataOID: pChar; Final: LongBool; dataToSigned: Pointer; dataSize: LongInt; dataDescriptor: pChar; Flags: LongWord; signedBlob: Pointer; sizeBlob: Pointer ): LongInt; cdecl; external 'strlib.dll' name 'SignMessage';
function Base2Bin(inBuf: Pointer; inSize: LongWord; outBuf: Pointer; Var outSize: LongWord): LongInt; cdecl; external 'strlib.dll' name 'BaseToBin';
function Bin2Base(inBuf: Pointer; inSize: LongWord; outBuf: Pointer; Var outSize: LongWord): LongInt; cdecl; external 'strlib.dll' name 'BinToBase';
function ReleaseCertificateContext(hStore: hCERTSTORE; hContext: Pointer): LongInt; cdecl; external 'strlib.dll' name 'ReleaseCertificateContext';
function SignMsgClose(phCrypt: Pointer): LongInt; cdecl; external 'strlib.dll' name 'SignMsgClose';
function CrtCloseStore(phStore: Pointer): LongInt; cdecl; external 'strlib.dll' name 'CrtCloseStore';
function CSPCloseContext(phProv: Pointer): LongInt; cdecl; external 'strlib.dll' name 'CSPCloseContext';
function MessageSignatureAlg(cmsData: Pointer; dataSize: LongWord; SignOID: Pointer; HashOID: Pointer) : LongInt; cdecl; external 'strlib.dll' name 'MessageSignatureAlg';
function CSPGetHash(hProv: HCRYPTPROV; hashOID: pChar; Final: LongBool; strReq: Pointer; reqSize: LongWord; strHash: Pointer; Var hashSize: LongWord): LongInt; cdecl; external 'strlib.dll' name 'CSPGetHash';
function MessageDigest(cmsData: Pointer; dataSize: LongWord; Digest: Pointer; Var digestSize: LongWord) : LongInt; cdecl; external 'strlib.dll' name 'MessageDigest';
function MessageKeysCount(cmsData: Pointer; dataSize: LongWord; count: Pointer) : LongInt; cdecl; external 'strlib.dll' name 'MessageKeysCount';
function GetMessageCertificate(hStore: hCERTSTORE; CMSBlob: Pointer; sizeBlob: LongWord; hCollection: hCERTCOLLECTION) : LongInt; cdecl; external 'strlib.dll' name 'GetMessageCertificate';
function VerifySignMessage(hCrypt: hCRYPTMSG; hCollection: hCERTCOLLECTION; SignedBlob: Pointer; sizeBlob: LongWord; Flags: LongInt; SignerName: Pointer; timeToSigned: Pointer; dataDescriptor: Pointer; dataToSigned: Pointer; var dataSize: LongWord; dataOID: Pointer; Var VerifyRes: LongInt) : LongInt; cdecl; external 'strlib.dll' name 'VerifySignMessage';
function FreeCertificateCollection(hCollection: hCERTCOLLECTION) : LongInt; cdecl; external 'strlib.dll' name 'MessageKeysCount';
function GetCertValidInfo(hStore: hCERTSTORE; certBody: Pointer; bodySize: LongWord; notBefore: pChar; notAfter: pChar) : LongInt; cdecl; external 'strlib.dll' name 'GetCertValidInfo';


end.
