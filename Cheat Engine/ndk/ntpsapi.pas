unit ntpsapi;

{$mode Delphi}

interface

  uses
    Windows, ntdef;

  const
    NtCurrentProcess = HANDLE(-1);

  type
    TProcessDeviceMapUnion = record
      case Integer of
          0: (
            Set_: record
              DirectoryHandle: HANDLE;
            end;
          );
          1: (
            Query: record
              DriveMap: ULONG;
              DriveType: array[0..31] of UCHAR;
            end;
          );
    end;

    PROCESS_DEVICEMAP_INFORMATION = record
      _: TProcessDeviceMapUnion;
    end;

    PROCESS_DEVICEMAP_INFORMATION_EX = record
      _: TProcessDeviceMapUnion;
      Flags: ULONG;
    end;

    PPROCESS_DEVICEMAP_INFORMATION_EX = ^PROCESS_DEVICEMAP_INFORMATION_EX;
    PPROCESS_DEVICEMAP_INFORMATION = ^PROCESS_DEVICEMAP_INFORMATION;

    PPEB_LDR_DATA = ^PEB_LDR_DATA;
    PEB_LDR_DATA = record
      Length: ULONG;
      Initialized: BOOLEAN;
      SsHandle: HANDLE;
      InLoadOrderModuleList: LIST_ENTRY;
      InMemoryOrderModuleList: LIST_ENTRY;
      InInitializationOrderModuleList: LIST_ENTRY;
      EntryInProgress: Pointer;
      ShutdownInProgress: BOOLEAN;
      ShutdownThreadId: HANDLE;
    end;

    // INITIAL_TEB

    PROCESSINFOCLASS = (
      ProcessBasicInformation = 0,
      ProcessQuotaLimits,
      ProcessIoCounters,
      ProcessVmCounters,
      ProcessTimes,
      ProcessBasePriority,
      ProcessRaisePriority,
      ProcessDebugPort,
      ProcessExceptionPort,
      ProcessAccessToken,
      ProcessLdtInformation, // 10
      ProcessLdtSize,
      ProcessDefaultHardErrorMode,
      ProcessIoPortHandlers,
      ProcessPooledUsageAndLimits,
      ProcessWorkingSetWatch,
      ProcessUserModeIOPL,
      ProcessEnableAlignmentFaultFixup,
      ProcessPriorityClass,
      ProcessWx86Information,
      ProcessHandleCount, // 20
      ProcessAffinityMask,
      ProcessPriorityBoost,
      ProcessDeviceMap,
      ProcessSessionInformation,
      ProcessForegroundInformation,
      ProcessWow64Information,
      ProcessImageFileName,
      ProcessLUIDDeviceMapsEnabled,
      ProcessBreakOnTermination,
      ProcessDebugObjectHandle, // 30
      ProcessDebugFlags,
      ProcessHandleTracing,
      ProcessIoPriority,
      ProcessExecuteFlags,
      ProcessTlsInformation,
      ProcessCookie,
      ProcessImageInformation,
      ProcessCycleTime,
      ProcessPagePriority,
      ProcessInstrumentationCallback, // 40
      ProcessThreadStackAllocation,
      ProcessWorkingSetWatchEx,
      ProcessImageFileNameWin32,
      ProcessImageFileMapping,
      ProcessAffinityUpdateMode,
      ProcessMemoryAllocationMode,
      ProcessGroupInformation,
      ProcessTokenVirtualizationEnabled,
      ProcessConsoleHostProcess,
      ProcessWindowInformation, // 50
      ProcessHandleInformation,
      ProcessMitigationPolicy,
      ProcessDynamicFunctionTableInformation,
      ProcessHandleCheckingMode,
      ProcessKeepAliveCount,
      ProcessRevokeFileHandles,
      ProcessWorkingSetControl,
      ProcessHandleTable,
      ProcessCheckStackExtentsMode,
      ProcessCommandLineInformation, // 60
      ProcessProtectionInformation,
      ProcessMemoryExhaustion,
      ProcessFaultInformation,
      ProcessTelemetryIdInformation,
      ProcessCommitReleaseInformation,
      ProcessDefaultCpuSetsInformation,
      ProcessAllowedCpuSetsInformation,
      ProcessSubsystemProcess,
      ProcessJobMemoryInformation,
      ProcessInPrivate, // 70
      ProcessRaiseUMExceptionOnInvalidHandleClose,
      ProcessIumChallengeResponse,
      ProcessChildProcessInformation,
      ProcessHighGraphicsPriorityInformation,
      ProcessSubsystemInformation,
      ProcessEnergyValues,
      ProcessPowerThrottlingState,
      ProcessReserved3Information,
      ProcessWin32kSyscallFilterInformation,
      ProcessDisableSystemAllowedCpuSets, // 80
      ProcessWakeInformation,
      ProcessEnergyTrackingState,
      ProcessManageWritesToExecutableMemory,
      ProcessCaptureTrustletLiveDump,
      ProcessTelemetryCoverage,
      ProcessEnclaveInformation,
      ProcessEnableReadWriteVmLogging,
      ProcessUptimeInformation,
      ProcessImageSection,
      ProcessDebugAuthInformation, // 90
      ProcessSystemResourceManagement,
      ProcessSequenceNumber,
      ProcessLoaderDetour,
      ProcessSecurityDomainInformation,
      ProcessCombineSecurityDomainsInformation,
      ProcessEnableLogging,
      ProcessLeapSecondInformation,
      ProcessFiberShadowStackAllocation,
      ProcessFreeFiberShadowStackAllocation,
      ProcessAltSystemCallInformation, // 100
      ProcessDynamicEHContinuationTargets,
      ProcessDynamicEnforcedCetCompatibleRanges,
      ProcessCreateStateChange,
      ProcessApplyStateChange,
      ProcessEnableOptionalXStateFeatures,
      ProcessAltPrefetchParam,
      ProcessAssignCpuPartitions,
      ProcessPriorityClassEx,
      ProcessMembershipInformation,
      ProcessEffectiveIoPriority, // 110
      ProcessEffectivePagePriority,
      ProcessSchedulerSharedData,
      ProcessSlistRollbackInformation,
      ProcessNetworkIoCounters,
      ProcessFindFirstThreadByTebValue,
      ProcessEnclaveAddressSpaceRestriction,
      ProcessAvailableCpus,
      MaxProcessInfoClass
    );

    PPROCESS_BASIC_INFORMATION = ^PROCESS_BASIC_INFORMATION;
    PROCESS_BASIC_INFORMATION = record
      ExitStatus: NTSTATUS;
      PebBaseAddress: POINTER; // PPEB
      AffinityMask: KAFFINITY;
      BasePriority: KPRIORITY;
      UniqueProcessId: HANDLE;
      InheritedFromUniqueProcessId: HANDLE;
    end;

  function NtQueryInformationProcess(
    ProcessHandle: HANDLE;
    ProcessInformationClass: PROCESSINFOCLASS;
    ProcessInformation: PVOID;
    ProcessInformationLength: ULONG;
    ReturnLength: PULONG
  ): LongInt; stdcall; external 'ntdll.dll';

implementation

end.
