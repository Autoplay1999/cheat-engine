unit ntwow64;

{$mode Delphi}

interface

  uses
    windows, ntdef;

  type
    PLDR_DATA_TABLE_ENTRY32 = ^LDR_DATA_TABLE_ENTRY32;
    LDR_DATA_TABLE_ENTRY32 = packed record
      InLoadOrderLinks: LIST_ENTRY32;
      InMemoryOrderLinks: LIST_ENTRY32;
      InInitializationOrderLinks: LIST_ENTRY32;
      DllBase: ULONG;
      EntryPoint: ULONG;
      SizeOfImage: ULONG;
      FullDllName: UNICODE_STRING32;
      BaseDllName: UNICODE_STRING32;
    end;

implementation

end.