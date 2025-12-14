unit ntobapi;

{$mode Delphi}

interface

    uses
      windows, ntdef;

    const
      SYMBOLIC_LINK_QUERY       = $0001;
      SYMBOLIC_LINK_SET         = $0002;
      SYMBOLIC_LINK_ALL_ACCESS  = STANDARD_RIGHTS_REQUIRED or SYMBOLIC_LINK_QUERY;
      SYMBOLIC_LINK_ALL_ACCESS_EX = STANDARD_RIGHTS_REQUIRED or SPECIFIC_RIGHTS_ALL;

    function NtOpenSymbolicLinkObject(
      LinkHandle: PHANDLE;
      DesiredAccess: ACCESS_MASK;
      ObjectAttributes: POBJECT_ATTRIBUTES
    ): NTSTATUS; stdcall; external 'NTDLL.DLL';

    function NtQuerySymbolicLinkObject(
      LinkHandle: HANDLE;
      LinkTarget: PUNICODE_STRING;
      ReturnedLength: PULONG 
    ): NTSTATUS; stdcall; external 'NTDLL.DLL';

    function NtClose(
      Handle: HANDLE
    ): NTSTATUS; stdcall; external 'NTDLL.DLL';

implementation

end.