unit stdint;

{$MODE DELPHI}

interface

type
  // Exact-width integer types
  int8_t    = ShortInt;      // -128 .. 127
  int16_t   = SmallInt;      // -32768 .. 32767
  int32_t   = Integer;       // -2147483648 .. 2147483647  (Delphi: Int32, FPC: LongInt on 32-bit)
  int64_t   = Int64;

  uint8_t   = Byte;          // 0 .. 255
  uint16_t  = Word;          // 0 .. 65535
  uint32_t  = Cardinal;      // 0 .. 4294967295  (Delphi: Cardinal, FPC: LongWord)
  uint64_t  = QWord;

  // Minimum-width integer types (least)
  int_least8_t   = int8_t;
  int_least16_t  = int16_t;
  int_least32_t  = int32_t;
  int_least64_t  = int64_t;

  uint_least8_t  = uint8_t;
  uint_least16_t = uint16_t;
  uint_least32_t = uint32_t;
  uint_least64_t = uint64_t;

  // Fastest minimum-width integer types (fast)
  int_fast8_t    = ShortInt;
  int_fast16_t   = Integer;
  int_fast32_t   = Integer;
  int_fast64_t   = Int64;

  uint_fast8_t   = Byte;
  uint_fast16_t  = Cardinal;
  uint_fast32_t  = Cardinal;
  uint_fast64_t  = QWord;

  // Integer types capable of holding object pointers
  {$IF Defined(WIN64) or Defined(CPUX64)}
    intptr_t   = Int64;
    uintptr_t  = QWord;
  {$ELSE}
    intptr_t   = Integer;
    uintptr_t  = Cardinal;
  {$IFEND}

  // Greatest-width integer types
  intmax_t  = Int64;
  uintmax_t = QWord;

// ------------------------------------------------------------------
// Constants (limits)
// ------------------------------------------------------------------

const
  // Exact width
  INT8_MIN    = -128;
  INT8_MAX    = 127;
  INT16_MIN   = -32768;
  INT16_MAX   = 32767;
  INT32_MIN   = -2147483648;
  INT32_MAX   = 2147483647;
  INT64_MIN   = -9223372036854775808;
  INT64_MAX   =  9223372036854775807;

  UINT8_MAX   = 255;
  UINT16_MAX  = 65535;
  UINT32_MAX  = 4294967295;
  UINT64_MAX  = 18446744073709551615;

  // Least types (same as exact on Windows)
  INT_LEAST8_MIN  = INT8_MIN;
  INT_LEAST8_MAX  = INT8_MAX;
  INT_LEAST16_MIN = INT16_MIN;
  INT_LEAST16_MAX = INT16_MAX;
  INT_LEAST32_MIN = INT32_MIN;
  INT_LEAST32_MAX = INT32_MAX;
  INT_LEAST64_MIN = INT64_MIN;
  INT_LEAST64_MAX = INT64_MAX;

  UINT_LEAST8_MAX  = UINT8_MAX;
  UINT_LEAST16_MAX = UINT16_MAX;
  UINT_LEAST32_MAX = UINT32_MAX;
  UINT_LEAST64_MAX = UINT64_MAX;

  // Fast types
  INT_FAST8_MIN   = INT8_MIN;
  INT_FAST8_MAX   = INT8_MAX;
  INT_FAST16_MIN  = INT32_MIN;
  INT_FAST16_MAX  = INT32_MAX;
  INT_FAST32_MIN  = INT32_MIN;
  INT_FAST32_MAX  = INT32_MAX;
  INT_FAST64_MIN  = INT64_MIN;
  INT_FAST64_MAX  = INT64_MAX;

  UINT_FAST8_MAX  = UINT8_MAX;
  UINT_FAST16_MAX = UINT32_MAX;
  UINT_FAST32_MAX = UINT32_MAX;
  UINT_FAST64_MAX = UINT64_MAX;

  // Pointer-sized
  // intptr / uintptr
  {$IF Defined(WIN64) or Defined(CPUX64)}
    INTPTR_MIN  = INT64_MIN;
    INTPTR_MAX  = INT64_MAX;
    UINTPTR_MAX = UINT64_MAX;
  {$ELSE}
    INTPTR_MIN  = INT32_MIN;
    INTPTR_MAX  = INT32_MAX;
    UINTPTR_MAX = UINT32_MAX;
  {$IFEND}

  // intmax_t / uintmax_t
  INTMAX_MIN = INT64_MIN;
  INTMAX_MAX = INT64_MAX;
  UINTMAX_MAX = UINT64_MAX;

  // ptrdiff_t limits (same as intptr_t)
  PTRDIFF_MIN = INTPTR_MIN;
  PTRDIFF_MAX = INTPTR_MAX;

  // size_t max
  {$IF Defined(WIN64) or Defined(CPUX64)}
    SIZE_MAX = UINT64_MAX;
  {$ELSE}
    SIZE_MAX = UINT32_MAX;
  {$IFEND}

  // Other standard types
  SIG_ATOMIC_MIN = INT32_MIN;
  SIG_ATOMIC_MAX = INT32_MAX;

  WCHAR_MIN = 0;
  WCHAR_MAX = $FFFF;

  WINT_MIN = 0;
  WINT_MAX = $FFFF;

// ------------------------------------------------------------------
// Integer constant macros (C-like)
// ------------------------------------------------------------------

function INT8_C(Value: Int64): int8_t; inline;
function INT16_C(Value: Int64): int16_t; inline;
function INT32_C(Value: Int64): int32_t; inline;
function INT64_C(Value: Int64): int64_t; inline;

function UINT8_C(Value: UInt64): uint8_t; inline;
function UINT16_C(Value: UInt64): uint16_t; inline;
function UINT32_C(Value: UInt64): uint32_t; inline;
function UINT64_C(Value: UInt64): uint64_t; inline;

function INTMAX_C(Value: Int64): intmax_t; inline;
function UINTMAX_C(Value: UInt64): uintmax_t; inline;

implementation

function INT8_C(Value: Int64): int8_t;
begin
  Result := int8_t(Value);
end;

function INT16_C(Value: Int64): int16_t;
begin
  Result := int16_t(Value);
end;

function INT32_C(Value: Int64): int32_t;
begin
  Result := int32_t(Value);
end;

function INT64_C(Value: Int64): int64_t;
begin
  Result := Value;
end;

function UINT8_C(Value: UInt64): uint8_t;
begin
  Result := uint8_t(Value);
end;

function UINT16_C(Value: UInt64): uint16_t;
begin
  Result := uint16_t(Value);
end;

function UINT32_C(Value: UInt64): uint32_t;
begin
  Result := uint32_t(Value);
end;

function UINT64_C(Value: UInt64): uint64_t;
begin
  Result := Value;
end;

function INTMAX_C(Value: Int64): intmax_t;
begin
  Result := Value;
end;

function UINTMAX_C(Value: UInt64): uintmax_t;
begin
  Result := Value;
end;

end.
