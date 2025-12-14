unit ntldr;

{$mode Delphi}

interface

  uses
    windows, ntdef;

  type
    PLDR_DATA_TABLE_ENTRY = ^LDR_DATA_TABLE_ENTRY;
    LDR_DATA_TABLE_ENTRY = record
      InLoadOrderLinks: LIST_ENTRY;
      InMemoryOrderLinks: LIST_ENTRY;
      InInitializationOrderLinks: LIST_ENTRY;
      DllBase: Pointer;
      EntryPoint: Pointer;
      SizeOfImage: ULONG;
      FullDllName: UNICODE_STRING;
      BaseDllName: UNICODE_STRING;
    end;

{$PACKRECORDS 8}
    PLDR_DATA_TABLE_ENTRY64 = ^LDR_DATA_TABLE_ENTRY64;
    LDR_DATA_TABLE_ENTRY64 = record
      InLoadOrderLinks: LIST_ENTRY64;
      InMemoryOrderLinks: LIST_ENTRY64;
      InInitializationOrderLinks: LIST_ENTRY64;
      DllBase: Qword;
      EntryPoint: Qword;
      SizeOfImage: ULONG;
      FullDllName: UNICODE_STRING64;
      BaseDllName: UNICODE_STRING64;
    end;
{$PACKRECORDS DEFAULT}
    
implementation

end.
