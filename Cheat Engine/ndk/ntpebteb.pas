unit ntpebteb;

{$mode Delphi}

interface

  uses
    windows, ntdef, ntrtl, ntpsapi;

  type
    PPEB = ^PEB;
    PEB = record
      InheritedAddressSpace: Boolean;
      ReadImageFileExecOptions: Boolean;
      BeingDebugged: Boolean;
      BitField: bitpacked record
        ImageUsesLargePages: 0..1;
        IsProtectedProcess: 0..1;
        IsImageDynamicallyRelocated: 0..1;
        SkipPatchingUser32Forwarders: 0..1;
        IsPackagedProcess: 0..1;
        IsAppContainer: 0..1;
        IsProtectedProcessLight: 0..1;
        IsLongPathAwareProcess: 0..1;
      end;
      Mutant: HANDLE;
      ImageBaseAddress: PVOID;
      Ldr: PPEB_LDR_DATA;
      ProcessParameters: PRTL_USER_PROCESS_PARAMETERS;
    end;

implementation



end.

