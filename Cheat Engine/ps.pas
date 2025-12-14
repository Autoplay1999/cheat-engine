unit ps;

{$mode Delphi}

interface

  uses
    windows, SysUtils, globals, NewKernelHandler, ntstatus_, ntdef, ntobapi, ntldr, ntrtl, ntpsapi, ntwow64, ntmmapi, PEInfoFunctions;

  type
    TModuleInformation = record
      BaseAddress: ULONG_PTR;
      SizeOfImage: ULONG_PTR;
      FileName: UnicodeString;
      FilePath: UnicodeString;
      Is64Bit: BOOLEAN;
    end;

    TModuleInformationArray = array of TModuleInformation;

  function LdrEnumerateModules(hProcess: THandle; var outModuleInfos: TModuleInformationArray): boolean;

implementation

  const
    DEVICE_PREFIX_LENGTH = 64;

  var
    devicePrefixesInit: boolean;
    devicePrefixes: array [0..25] of UNICODE_STRING;
    devicePrefixesBuffer: array [0 .. DEVICE_PREFIX_LENGTH * sizeof(wchar) * 25] of Byte;

  function ResolveDevicePrefix(const Name: UnicodeString): UnicodeString;
  var
    Buffer: PWideChar;
    I: ULONG;
    DeviceNameBuffer: array[0..6] of WideChar;
    DeviceMap: ULONG;
    Status: NTSTATUS;
  {$IFNDEF WIN64}
    DeviceMapInfo: PROCESS_DEVICEMAP_INFORMATION;
  {$ELSE}
    DeviceMapInfo: PROCESS_DEVICEMAP_INFORMATION_EX;
  {$ENDIF}
    LinkHandle: HANDLE;
    ObjAttr: OBJECT_ATTRIBUTES;
    DeviceName: UNICODE_STRING;
    Prefix: UnicodeString;
    IsPrefix: Boolean;
    NewName: UnicodeString;
  begin
    Result := '';

    if not devicePrefixesInit then
    begin
      // InitializeDevicePrefixes
      Buffer := PWideChar(@devicePrefixesBuffer[0]);

      for I := 0 to 25 do
      begin
        devicePrefixes[I].Length := 0;
        devicePrefixes[I].MaximumLength := DEVICE_PREFIX_LENGTH * SizeOf(WideChar);
        devicePrefixes[I].Buffer := Buffer;
        Inc(Buffer, DEVICE_PREFIX_LENGTH);
      end;

      // UpdateDosDevicePrefixes
      DeviceNameBuffer := '\??\ :';
      DeviceMap := 0;

      // PhGetProcessDeviceMap equivalent
      FillChar(DeviceMapInfo, SizeOf(DeviceMapInfo), 0);
      Status := NtQueryInformationProcess(NtCurrentProcess, ProcessDeviceMap, @DeviceMapInfo, SizeOf(DeviceMapInfo), 0);
      if NT_SUCCESS(Status) then
        DeviceMap := DeviceMapInfo._.Query.DriveMap;

      for I := 0 to 25 do
      begin
        if (DeviceMap <> 0) and ((DeviceMap and (1 shl I)) = 0) then
        begin
          devicePrefixes[I].Buffer[0] := #0;
          devicePrefixes[I].Length := 0;
          Continue;
        end;

        DeviceNameBuffer[4] := WideChar(Ord('A') + I);
        DeviceName.Buffer := DeviceNameBuffer;
        DeviceName.MaximumLength := sizeof(DeviceNameBuffer);
        DeviceName.Length := DeviceName.MaximumLength - sizeof(WideChar);

        InitializeObjectAttributes(@ObjAttr, @DeviceName, OBJ_CASE_INSENSITIVE, 0, 0);

        if NT_SUCCESS(NtOpenSymbolicLinkObject(@LinkHandle, SYMBOLIC_LINK_QUERY, @ObjAttr)) then
        begin
          if not NT_SUCCESS(NtQuerySymbolicLinkObject(LinkHandle, @devicePrefixes[I], 0)) then
            devicePrefixes[I].Length := 0;
          NtClose(LinkHandle);
        end
        else
          devicePrefixes[I].Length := 0;
      end;

      devicePrefixesInit := True;
    end;

    // Match the longest prefix
    for I := 0 to 25 do
    begin
      IsPrefix := False;

      if devicePrefixes[I].Length > 0 then
      begin
        SetString(Prefix, devicePrefixes[I].Buffer, devicePrefixes[I].Length div SizeOf(WideChar));

        if Length(Prefix) > 0 then
        begin
          if WideSameText(Copy(Name, 1, Length(Prefix)), Prefix) then // case-insensitive compare
          begin
            if (Length(Name) = Length(Prefix)) or (Name[Length(Prefix) + 1] = '\') then
              IsPrefix := True;
          end;
        end;
      end;

      if IsPrefix then
      begin
        NewName := WideChar(Ord('A') + I) + ':' + Copy(Name, Length(Prefix) + 1, MaxInt);
        Result := NewName;
        Exit;
      end;
    end;
  end;

  function GetProcessMappedFileName(ProcessHandle: THandle; BaseAddress: PVOID; out FileName: UnicodeString): Integer;
  var
    Status: NTSTATUS;
    BufferSize: SIZE_T;
    ReturnLength: SIZE_T;
    Buffer: PUNICODE_STRING;
    Converted: UNICODE_STRING;
    RelativeName: RTL_RELATIVE_NAME_U;
    FilePart: PWSTR;
  begin
    Result := 0;
    ReturnLength := 0;
    BufferSize := $200; // 512 bytes

    // LocalAlloc (LMEM_FIXED = $0000)
    Buffer := PUNICODE_STRING(LocalAlloc(LMEM_FIXED, BufferSize));
    if Buffer = nil then
    begin
      Result := 1;
      Exit;
    end;

    Status := NtQueryVirtualMemory(
      ProcessHandle,
      BaseAddress,
      MemoryMappedFilenameInformation,
      Buffer,
      BufferSize,
      @ReturnLength
    );

    if (Status = STATUS_BUFFER_OVERFLOW) and (ReturnLength > 0) then
    begin
      LocalFree(Qword(Buffer));
      BufferSize := ReturnLength;
      Buffer := PUNICODE_STRING(LocalAlloc(LMEM_FIXED, BufferSize));

      if Buffer = nil then
      begin
        Result := 2;
        Exit;
      end;
      
      Status := NtQueryVirtualMemory(
        ProcessHandle,
        BaseAddress,
        MemoryMappedFilenameInformation,
        Buffer,
        BufferSize,
        @ReturnLength
      );
    end;
    
    if Status < 0 then
    begin
      LocalFree(Qword(Buffer));
      Result := 3;
      Exit;
    end;

    FileName := ResolveDevicePrefix(Buffer.Buffer);
    LocalFree(Qword(Buffer));
    Result := 0;
  end;

  function LdrEnumerateModules(hProcess: THandle; var outModuleInfos: TModuleInformationArray): boolean;
  var
    pbi: PROCESS_BASIC_INFORMATION;
    retlen: SIZE_T;
    status: NTSTATUS;
    pebBase: ULONG_PTR;
    ldrBase: ULONG_PTR;
    isWow64: BOOL;
    headEntry: ULONG_PTR;
    entry: ULONG_PTR;

    i: integer;
    alreadyInTheList: boolean;

    moduleInfo: TModuleInformation;
    ldr32: LDR_DATA_TABLE_ENTRY32;
    ldr: LDR_DATA_TABLE_ENTRY;

    strbuf: array[0..511] of wchar;

    offsetLdr: ULONG;
    offsetInLoadOrderModuleList: ULONG;
  begin

    if not IsWow64Process(hProcess, isWow64) then
    begin
      result := false;
      exit;
    end;

    if isWow64 then
    begin
      offsetLdr := $c;
      offsetInLoadOrderModuleList := $c;

      status := NtQueryInformationProcess(hProcess, ProcessWow64Information, @pebBase, sizeof(pebBase), @retlen);

      if status <> 0 then
      begin
        result := false;
        exit;
      end;

      if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(pebBase + offsetLdr), @ldrBase, sizeof(LongInt), retlen) then
      begin
        result := false;
        exit;
      end;

      headEntry := ldrBase + offsetInLoadOrderModuleList;

      if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(headEntry), @entry, sizeof(LongInt), retlen) then
      begin
        result := false;
        exit;
      end;

      while entry <> headEntry do
      begin
        if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(entry), @ldr32, sizeof(LDR_DATA_TABLE_ENTRY32), retlen) then
        begin
          result := false;
          exit;
        end;

        if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(ldr32.FullDllName.Buffer), @strbuf, ldr32.FullDllName.Length, retlen) then
        begin
          result := false;
          exit;
        end;

        strbuf[ldr32.FullDllName.Length div sizeof(wchar)] := #0;
        moduleInfo.FilePath := pwchar(@strbuf[0]);

        if GetProcessMappedFileName(hProcess, Pointer(ldr32.DllBase), moduleInfo.FilePath) <> 0 then
        begin
          result := false;
          exit;
        end;

        if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(ldr32.BaseDllName.Buffer), @strbuf, ldr32.BaseDllName.Length, retlen) then
        begin
          result := false;
          exit;
        end;

        strbuf[ldr32.BaseDllName.Length div sizeof(wchar)] := #0;
        moduleInfo.FileName := pwchar(@strbuf[0]);
        moduleInfo.BaseAddress := ldr32.DllBase;
        moduleInfo.SizeOfImage := ldr32.SizeOfImage;

        peinfo_is64bitfile(moduleInfo.FilePath, moduleInfo.Is64Bit);

        setlength(outModuleInfos, length(outModuleInfos) + 1);
        outModuleInfos[high(outModuleInfos)] := moduleInfo;

        entry := ULONG_PTR(ldr32.InLoadOrderLinks.Flink);
      end;
    end;

{$ifdef cpu64}
    offsetLdr := $18;
    offsetInLoadOrderModuleList := $10;

    status := NtQueryInformationProcess(hProcess, ProcessBasicInformation, @pbi, sizeof(pbi), @retlen);

    if status <> 0 then
    begin
      result := false;
      exit;
    end;

    pebBase := ULONG_PTR(pbi.PebBaseAddress);

    if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(pebBase + offsetLdr), @ldrBase, sizeof(ldrBase), retlen) then
    begin
      result := false;
      exit;
    end;

    headEntry := ldrBase + offsetInLoadOrderModuleList;

    if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(headEntry), @entry, sizeof(entry), retlen) then
    begin
      result := false;
      exit;
    end;

    while entry <> headEntry do
    begin
      alreadyInTheList := false;

      if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(entry), @ldr, sizeof(ldr), retlen) then
      begin
        result := false;
        exit;
      end;

      if isWow64 then
      for i := 0 to high(outModuleInfos) do
      begin
        if outModuleInfos[i].BaseAddress = ULONG_PTR(ldr.DllBase) then
        begin
          alreadyInTheList := true;
          break;
        end;
      end;

      if not alreadyInTheList then
      begin
        if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(ldr.FullDllName.Buffer), @strbuf, ldr.FullDllName.Length, retlen) then
        begin
          result := false;
          exit;
        end;

        strbuf[ldr.FullDllName.Length div sizeof(wchar)] := #0;
        moduleInfo.FilePath := pwchar(@strbuf[0]);

        if not NewKernelHandler.ReadProcessMemory(hProcess, Pointer(ldr.BaseDllName.Buffer), @strbuf, ldr.BaseDllName.Length, retlen) then
        begin
          result := false;
          exit;
        end;

        strbuf[ldr.BaseDllName.Length div sizeof(wchar)] := #0;
        moduleInfo.FileName := pwchar(@strbuf[0]);
        moduleInfo.BaseAddress := ULONG_PTR(ldr.DllBase);
        moduleInfo.SizeOfImage := ldr.SizeOfImage;

        peinfo_is64bitfile(moduleInfo.FilePath, moduleInfo.Is64Bit);

        setlength(outModuleInfos, length(outModuleInfos) + 1);
        outModuleInfos[high(outModuleInfos)] := moduleInfo;
      end;

      entry := ULONG_PTR(ldr.InLoadOrderLinks.Flink);
    end;
{$endif}

    result := true;
  end;

end.

