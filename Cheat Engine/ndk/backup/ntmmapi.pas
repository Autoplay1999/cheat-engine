unit ntmmapi;

{$mode Delphi}

interface
    
    uses
      windows, ntdef;

    type
      MEMORY_INFORMATION_CLASS = (
        MemoryBasicInformation,           // 0
        MemoryWorkingSetInformation,      // 1
        MemoryMappedFilenameInformation,  // 2
        MemoryRegionInformation,          // 3
        MemoryWorkingSetExInformation,    // 4
        MemorySharedCommitInformation,    // 5
        MemoryImageInformation,           // 6
        MemoryRegionInformationEx,        // 7
        MemoryPrivilegedBasicInformation, // 8
        MemoryEnclaveImageInformation,    // 9
        MemoryBasicInformationCapped,     // 10
        MemoryPhysicalContiguityInformation, // 11
        MemoryBadInformation,             // 12
        MemoryBadInformationAllProcesses, // 13
        MemoryImageExtensionInformation,  // 14
        MaxMemoryInfoClass                // 15
      );

    function NtQueryVirtualMemory(
      ProcessHandle: HANDLE;
      BaseAddress: PVOID;
      MemoryInformationClass: MEMORY_INFORMATION_CLASS;
      MemoryInformation: PVOID;
      MemoryInformationLength: SIZE_T;
      ReturnLength: ^SIZE_T
    ): NTSTATUS; stdcall; external 'ntdll.dll';


implementation

end.
