unit ntrtl;

{$mode Delphi}

interface
  uses
    windows, ntdef;

  const
    RTL_MAX_DRIVE_LETTERS: Integer = 32;
    RTL_DRIVE_LETTER_VALID: USHORT = $0001;

  type
    CURDIR = record
      DosPath: UNICODE_STRING;
      Handle: THandle;
    end;

    RTL_DRIVE_LETTER_CURDIR = record
      Flags: USHORT;
      Length: USHORT;
      TimeStamp: ULONG;
      DosPath: _STRING;
    end;

    PRTLP_CURDIR_REF = ^RTLP_CURDIR_REF; 
    RTLP_CURDIR_REF = record
      ReferenceCount: LONG;
      DirectoryHandle: HANDLE;
    end;

    PRTL_RELATIVE_NAME_U = ^RTL_RELATIVE_NAME_U;
    RTL_RELATIVE_NAME_U = record
      RelativeName: UNICODE_STRING;
      ContainingDirectory: HANDLE;
      CurDirRef: PRTLP_CURDIR_REF;
    end;

    PRTL_USER_PROCESS_PARAMETERS = ^RTL_USER_PROCESS_PARAMETERS;
    RTL_USER_PROCESS_PARAMETERS = packed record
      // Header
      MaximumLength: ULONG;           // ULONG (4 bytes)
      Length: ULONG;                  // ULONG (4 bytes)
      Flags: ULONG;                   // ULONG (4 bytes)
      DebugFlags: ULONG;              // ULONG (4 bytes)

      // Console/Standard Handles
      ConsoleHandle: HANDLE;          // HANDLE (Pointer size)
      ConsoleFlags: ULONG;            // ULONG (4 bytes)
      StandardInput: HANDLE;          // HANDLE (Pointer size)
      StandardOutput: HANDLE;         // HANDLE (Pointer size)
      StandardError: HANDLE;          // HANDLE (Pointer size)

      // Critical Path Information
      CurrentDirectory: CURDIR;              // CURDIR (Handle + UNICODE_STRING)
      DllPath: UNICODE_STRING;               // UNICODE_STRING
      ImagePathName: UNICODE_STRING;         // UNICODE_STRING (Full path to executable)
      CommandLine: UNICODE_STRING;           // UNICODE_STRING
      Environment: POINTER;                   // PVOID (Pointer to environment block)

      // Window/Console Dimensions
      StartingX: ULONG;               // ULONG (4 bytes)
      StartingY: ULONG;               // ULONG (4 bytes)
      CountX: ULONG;                  // ULONG (4 bytes)
      CountY: ULONG;                  // ULONG (4 bytes)
      CountCharsX: ULONG;             // ULONG (4 bytes)
      CountCharsY: ULONG;             // ULONG (4 bytes)
      FillAttribute: ULONG;           // ULONG (4 bytes)

      // Window Display Info
      WindowFlags: ULONG;             // ULONG (4 bytes)
      ShowWindowFlags: ULONG;         // ULONG (4 bytes)
      WindowTitle: UNICODE_STRING;           // UNICODE_STRING
      DesktopInfo: UNICODE_STRING;           // UNICODE_STRING
      ShellInfo: UNICODE_STRING;             // UNICODE_STRING
      RuntimeData: UNICODE_STRING;           // UNICODE_STRING

      // Drive Letter Information (Array)
      CurrentDirectories: array[0..31] of RTL_DRIVE_LETTER_CURDIR;
                                      // Array[32] of TRTL_DRIVE_LETTER_CURDIR

      // Environment Size/Version
      EnvironmentSize: ULONG_PTR;     // ULONG_PTR (Pointer size)
      EnvironmentVersion: ULONG_PTR;  // ULONG_PTR (Pointer size)

      // Modern/Extended Fields
      PackageDependencyData: POINTER; // PVOID (Pointer size)
      ProcessGroupId: ULONG;          // ULONG (4 bytes)
      LoaderThreads: ULONG;           // ULONG (4 bytes)
      RedirectionDllName: UNICODE_STRING; // UNICODE_STRING (Redstone 4 / 1803)
      HeapPartitionName: UNICODE_STRING;  // UNICODE_STRING (19H1 / 1903)
      DefaultThreadpoolCpuSetMasks: ^ULONGLONG; // PULONGLONG (Pointer to 64-bit value)
      DefaultThreadpoolCpuSetMaskCount: ULONG;  // ULONG (4 bytes)
      DefaultThreadpoolThreadMaximum: ULONG;    // ULONG (4 bytes)
      HeapMemoryTypeMask: ULONG;      // ULONG (4 bytes) (WIN11)
    end;

    function RtlDosPathNameToNtPathName_U(
      DosFileName: PCWSTR;
      NtFileName: PUNICODE_STRING;
      FilePart: ^PWSTR;
      RelativeName: PRTL_RELATIVE_NAME_U
    ): BOOLEAN; stdcall; external 'ntdll.dll';

implementation

end.
