## ioctl implementation
## 
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)
#!fmt: off
import pkg/nuzzle/flags,
       pkg/nuzzle/x64/dispatch,
       pkg/nuzzle/x64/bindings/err
#!fmt: on

when SubstitutingLibc:
  {.push exportc.}

{.push cdecl.}
proc ioctl*(fd: int32, op: uint64): int32 =
  HandleErrno (int32) sc2(SYS_ioctl, cast[uint64](fd), op)

proc ioctl*(fd: int32, op: uint64, a1: uint64): int32 =
  HandleErrno (int32) sc3(SYS_ioctl, cast[uint64](fd), op, a1)

proc ioctl*(fd: int32, op: uint64, a1, a2: uint64): int32 =
  HandleErrno (int32) sc4(SYS_ioctl, cast[uint64](fd), op, a1, a2)

proc ioctl*(fd: int32, op: uint64, a1, a2, a3: uint64): int32 =
  HandleErrno (int32) sc5(SYS_ioctl, cast[uint64](fd), op, a1, a2, a3)

{.pop.}

when SubstitutingLibc:
  {.pop.}
