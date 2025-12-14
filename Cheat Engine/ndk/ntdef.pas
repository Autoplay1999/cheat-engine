unit ntdef;

{$mode Delphi}

interface

  uses
    windows;

  const
    DELETE              = $00010000;
    READ_CONTROL        = $00020000;
    WRITE_DAC           = $00040000; // Discretionary Access Control List (DAC)
    WRITE_OWNER         = $00080000;
    SYNCHRONIZE         = $00100000;

    STANDARD_RIGHTS_REQUIRED  = $000F0000; // (DELETE | READ_CONTROL | WRITE_DAC | WRITE_OWNER)
    STANDARD_RIGHTS_ALL       = $001F0000; // (STANDARD_RIGHTS_REQUIRED | SYNCHRONIZE)

    STANDARD_RIGHTS_READ      = READ_CONTROL;
    STANDARD_RIGHTS_WRITE     = READ_CONTROL;
    STANDARD_RIGHTS_EXECUTE   = READ_CONTROL;

    SPECIFIC_RIGHTS_ALL       = $0000FFFF;
    ACCESS_SYSTEM_SECURITY    = $01000000;
    MAXIMUM_ALLOWED           = $02000000;

    OBJ_PROTECT_CLOSE                 = $00000001; // $1
    OBJ_INHERIT                       = $00000002; // $2
    OBJ_AUDIT_OBJECT_CLOSE            = $00000004; // $4
    OBJ_NO_RIGHTS_UPGRADE             = $00000008; // $8
    OBJ_PERMANENT                     = $00000010; // $10
    OBJ_EXCLUSIVE                     = $00000020; // $20
    OBJ_CASE_INSENSITIVE              = $00000040; // $40
    OBJ_OPENIF                        = $00000080; // $80
    OBJ_OPENLINK                      = $00000100; // $100
    OBJ_KERNEL_HANDLE                 = $00000200; // $200
    OBJ_FORCE_ACCESS_CHECK            = $00000400; // $400
    OBJ_IGNORE_IMPERSONATED_DEVICEMAP = $00000800; // $800
    OBJ_DONT_REPARSE                  = $00001000; // $1000
    OBJ_VALID_ATTRIBUTES              = $00001FF2; // $1FF2

    NT_CUSTOMER_SHIFT  = 29;
    NT_FACILITY_SHIFT  = 16;
    NT_FACILITY_MASK   = $FFF; // 0xFFF

    FACILITY_DEBUGGER                   = $01;
    FACILITY_RPC_RUNTIME                = $02;
    FACILITY_RPC_STUBS                  = $03;
    FACILITY_IO_ERROR_CODE              = $04;
    FACILITY_CODCLASS_ERROR_CODE        = $06;
    FACILITY_NTWIN32                    = $07;
    FACILITY_NTCERT                     = $08;
    FACILITY_NTSSPI                     = $09;
    FACILITY_TERMINAL_SERVER            = $0A;
    FACILTIY_MUI_ERROR_CODE             = $0B;
    FACILITY_USB_ERROR_CODE             = $10;
    FACILITY_HID_ERROR_CODE             = $11;
    FACILITY_FIREWIRE_ERROR_CODE        = $12;
    FACILITY_CLUSTER_ERROR_CODE         = $13;
    FACILITY_ACPI_ERROR_CODE            = $14;
    FACILITY_SXS_ERROR_CODE             = $15;
    FACILITY_TRANSACTION                = $19;
    FACILITY_COMMONLOG                  = $1A;
    FACILITY_VIDEO                      = $1B;
    FACILITY_FILTER_MANAGER             = $1C;
    FACILITY_MONITOR                    = $1D;
    FACILITY_GRAPHICS_KERNEL            = $1E;
    FACILITY_CAMERA                     = $1F;
    FACILITY_DRIVER_FRAMEWORK           = $20;
    FACILITY_FVE_ERROR_CODE             = $21;
    FACILITY_FWP_ERROR_CODE             = $22;
    FACILITY_NDIS_ERROR_CODE            = $23;
    FACILITY_QUIC_ERROR_CODE            = $24;
    FACILITY_TPM                        = $29;
    FACILITY_RTPM                       = $2A;
    FACILITY_HYPERVISOR                 = $35;
    FACILITY_IPSEC                      = $36;
    FACILITY_VIRTUALIZATION             = $37;
    FACILITY_VOLMGR                     = $38;
    FACILITY_BCD_ERROR_CODE             = $39;
    FACILITY_WIN32K_NTUSER              = $3E;
    FACILITY_WIN32K_NTGDI               = $3F;
    FACILITY_RESUME_KEY_FILTER          = $40;
    FACILITY_RDBSS                      = $41;
    FACILITY_BTH_ATT                    = $42;
    FACILITY_SECUREBOOT                 = $43;
    FACILITY_AUDIO_KERNEL               = $44;
    FACILITY_VSM                        = $45;
    FACILITY_NT_IORING                  = $46;
    FACILITY_VOLSNAP                    = $50;
    FACILITY_SDBUS                      = $51;
    FACILITY_SHARED_VHDX                = $5C;
    FACILITY_SMB                        = $5D;
    FACILITY_XVS                        = $5E;
    FACILITY_INTERIX                    = $99;
    FACILITY_SPACES                     = $E7;
    FACILITY_SECURITY_CORE              = $E8;
    FACILITY_SYSTEM_INTEGRITY           = $E9;
    FACILITY_LICENSING                  = $EA;
    FACILITY_PLATFORM_MANIFEST          = $EB;
    FACILITY_APP_EXEC                   = $EC;
    FACILITY_UNIONFS                    = $ED;
    FACILITY_PLATFORM_RUNTIME_MECHANISM = $EE;
    FACILITY_WIN_ACCEL                  = $EF;
    FACILITY_MAXIMUM_VALUE              = $F0;

  type
    ACCESS_MASK  = Cardinal;
    PACCESS_MASK = ^ACCESS_MASK;

    PSIZE_T = ^SIZE_T;
    PPWSTR = ^PWSTR;

    KAFFINITY = NativeUInt;
    PKAFFINITY = ^KAFFINITY;

    KPRIORITY = LongInt;
    PKPRIORITY = ^KPRIORITY;

    NTSTATUS = LongInt;
    PNTSTATUS = ^NTSTATUS;

    PSTRING = ^_STRING;
    _STRING = record
      Length: Word;
      MaximumLength: Word;
      Buffer: ^AnsiChar;
    end;
        
    PSTRING32 = ^STRING32;
    STRING32 = packed record
      Length: Word;        
      MaximumLength: Word; 
      Buffer: LongWord;    
    end;

{$PACKRECORDS 8}
    PSTRING64 = ^STRING64;
    STRING64 = record
      Length: Word;
      MaximumLength: Word;
      Buffer: QWord;
    end;
{$PACKRECORDS DEFAULT}

    PLIST_ENTRY32 = ^LIST_ENTRY32;
    LIST_ENTRY32 = packed record
      Flink: ULONG;
      Blink: ULONG;
    end;

    PLIST_ENTRY64 = ^LIST_ENTRY64;
    LIST_ENTRY64 = record
      Flink: Qword;
      Blink: Qword;
    end;
    
    PSINGLE_LIST_ENTRY = ^SINGLE_LIST_ENTRY; 
    SINGLE_LIST_ENTRY = record
      Next: PSINGLE_LIST_ENTRY; 
    end;

    PSINGLE_LIST_ENTRY32 = ^SINGLE_LIST_ENTRY32;
    SINGLE_LIST_ENTRY32 = packed record
      Next: LongWord;
    end;

    PUNICODE_STRING = ^UNICODE_STRING;
    UNICODE_STRING = record
      Length: USHORT;
      MaximumLength: USHORT;
      Buffer: PWCH;
    end;

    PRTL_BALANCED_NODE = ^RTL_BALANCED_NODE;
    RTL_BALANCED_NODE = packed record
      u1: record
        case Integer of
          0: (Children: array[0..1] of PRTL_BALANCED_NODE);
          1: (Left: PRTL_BALANCED_NODE;
              Right: PRTL_BALANCED_NODE);
      end;
      u2: record
        case Integer of
          0: (ParentValue: NativeUInt);
          1: (RedBalance: bitpacked record
                case Integer of
                0: (Red: 0..1);
                1: (Balance: 0..2);
              end;);
      end;
    end;

    OBJECT_ATTRIBUTES = record
      Length: ULONG;
      RootDirectory: HANDLE;
      ObjectName: PUNICODE_STRING;
      Attributes: ULONG;
      SecurityDescriptor: PVOID;
      SecurityQualityOfService: PVOID;
    end;

    POBJECT_ATTRIBUTES = ^OBJECT_ATTRIBUTES;

    UNICODE_STRING64 = STRING64;
    PUNICODE_STRING64 = PSTRING64;

    ANSI_STRING64 = STRING64;
    PANSI_STRING64 = PSTRING64;

    UNICODE_STRING32 = STRING32;
    PUNICODE_STRING32 = PSTRING32;

    ANSI_STRING32 = STRING32;
    PANSI_STRING32 = PSTRING32;

    ANSI_STRING = _STRING;
    PANSI_STRING = PSTRING;

    function NT_SUCCESS(Status: NTSTATUS): Boolean;

    function NT_INFORMATION(Status: NTSTATUS): Boolean;

    function NT_WARNING(Status: NTSTATUS): Boolean;

    function NT_ERROR(Status: NTSTATUS): Boolean;

    function NT_CUSTOMER(Status: NTSTATUS): Cardinal;

    function NT_FACILITY(Status: NTSTATUS): Cardinal;

    function NT_NTWIN32(Status: NTSTATUS): Boolean;

    function WIN32_FROM_NTSTATUS(Status: NTSTATUS): Cardinal;

    procedure InitializeObjectAttributes(
      p: POBJECT_ATTRIBUTES;
      n: PUNICODE_STRING;
      a: ULONG; 
      r: HANDLE; 
      s: PVOID
    );

implementation

  function NT_SUCCESS(Status: NTSTATUS): Boolean;
    begin
      Result := ((Status shr 30) and 3) = 0;
    end;

    function NT_INFORMATION(Status: NTSTATUS): Boolean;
    begin
      Result := (Status shr 30) = 1;
    end;

    function NT_WARNING(Status: NTSTATUS): Boolean;
    begin
      Result := (Status shr 30) = 2;
    end;

    function NT_ERROR(Status: NTSTATUS): Boolean;
    begin
      Result := (Status shr 30) = 3;
    end;

    function NT_CUSTOMER(Status: NTSTATUS): Cardinal;
    begin
      Result := (Status shr NT_CUSTOMER_SHIFT) and 1;
    end;

    function NT_FACILITY(Status: NTSTATUS): Cardinal;
    begin
      Result := (Status shr NT_FACILITY_SHIFT) and NT_FACILITY_MASK;
    end;

    function NT_NTWIN32(Status: NTSTATUS): Boolean;
    begin
      Result := NT_FACILITY(Status) = FACILITY_NTWIN32;
    end;

    function WIN32_FROM_NTSTATUS(Status: NTSTATUS): Cardinal;
    begin
      Result := Status and $FFFF;
    end;

  procedure InitializeObjectAttributes(
    p: POBJECT_ATTRIBUTES;
    n: PUNICODE_STRING;
    a: ULONG; 
    r: HANDLE; 
    s: PVOID
  );
  begin
    p^.Length := SizeOf(OBJECT_ATTRIBUTES);
    p^.RootDirectory := r;
    p^.Attributes := a;
    p^.ObjectName := n;
    p^.SecurityDescriptor := s;
    p^.SecurityQualityOfService := 0;
  end;

end.
