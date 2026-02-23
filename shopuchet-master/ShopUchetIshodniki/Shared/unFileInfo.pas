unit unFileInfo;

interface

uses Types, Windows;

type
  PFixedFileInfo = ^TFixedFileInfo;
  TFixedFileInfo = record
     dwSignature       : DWORD;
     dwStrucVersion    : DWORD;
     wFileVersionMS    : WORD;  // Minor Version
     wFileVersionLS    : WORD;  // Major Version
     wProductVersionMS : WORD;  // Build Number
     wProductVersionLS : WORD;  // Release Version
     dwFileFlagsMask   : DWORD;
     dwFileFlags       : DWORD;
     dwFileOS          : DWORD;
     dwFileType        : DWORD;
     dwFileSubtype     : DWORD;
     dwFileDateMS      : DWORD;
     dwFileDateLS      : DWORD;
  end;

function FileInfo(const FileName : String) : TFixedFileInfo;

implementation

function FileInfo(const FileName : String) : TFixedFileInfo;
var
  dwHandle,
  dwVersionSize : DWORD;
  strSubBlock   : String;
  pTemp,
  pData         : Pointer;
begin
  strSubBlock := '\';

  dwVersionSize := GetFileVersionInfoSize(PChar(FileName), dwHandle);

  // if GetFileVersionInfoSize is successful
  if dwVersionSize <> 0 then begin
    GetMem(pTemp, dwVersionSize);
    try
      if GetFileVersionInfo(PChar(FileName), // pointer to filename string
                            dwHandle,        // ignored
                            dwVersionSize,   // size of buffer
                            pTemp) then      // pointer to buffer to receive file-version info.
        if VerQueryValue(pTemp,              // pBlock     - address of buffer for version resource
                         PChar(strSubBlock), // lpSubBlock - address of value to retrieve
                         pData,              // lplpBuffer - address of buffer for version pointer
                         dwVersionSize) then // puLen      - address of version-value length buffer
          Result := PFixedFileInfo(pData)^;
    finally
      FreeMem( pTemp );
    end;
  end;
end;

end.
