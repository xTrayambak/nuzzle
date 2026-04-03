## Process management syscall bindings
##
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)
import pkg/nuzzle/flags, pkg/nuzzle/x64/bindings/err

const
  # ISO C99 signals.
  SIGINT* = 2'i32
  SIGILL* = 4'i32
  SIGABRT* = 6'i32
  SIGFPE* = 8'i32
  SIGSEGV* = 11'i32
  SIGTERM* = 15'i32

  # Historical signals specified by POSIX.
  SIGHUP* = 1'i32
  SIGQUIT* = 3'i32
  SIGTRAP* = 5'i32
  SIGKILL* = 9'i32
  SIGPIPE* = 13'i32
  SIGALRM* = 14'i32

when SubstitutingLibc:
  {.push exportc.}

{.push cdecl.}

proc fork*(): int32 =
  (int32) sc0(SYS_fork)

proc kill*(pid: int32, sig: int32): int32 =
  (int32) sc2(SYS_kill, cast[uint64](pid), cast[uint64](sig))

proc exit*(status: int32) {.noReturn.} =
  sc1(SYS_exit, cast[uint64](status))

{.pop.}

when SubstitutingLibc:
  {.pop.}
