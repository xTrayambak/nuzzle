## Miscellaneous syscalls 
##
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)
import pkg/nuzzle/flags, pkg/nuzzle/x64/[dispatch], pkg/nuzzle/x64/bindings/[types, err]

const
  ARCH_SET_GS* = 0x1001'i32
  ARCH_SET_FS* = 0x1002'i32
  ARCH_GET_FS* = 0x1003'i32
  ARCH_GET_GS* = 0x1004'i32
  ARCH_SET_CPUID* = 0x1011'i32
  ARCH_GET_CPUID* = 0x1012'i32

when SubstitutingLibc:
  {.push exportc.}

{.push cdecl.}

proc pause*(): int32 =
  let ret = (int32) sc0(SYS_pause)
  if ret < 0:
    errno = -ret
    return -1'i32

  ret

proc getrandom*(buffer: cstring | ptr char, size: uint64, flags: uint32): uint64 =
  let ret = (int32) sc3(SYS_getrandom, cast[uint64](buffer), size, cast[uint64](flags))
  if ret < 0:
    errno = -ret
    return -1'i32

  ret

proc getuid*(): UID =
  (UID) sc0(SYS_getuid)

proc geteuid*(): UID =
  (UID) sc0(SYS_geteuid)

proc getgid*(): GID =
  (GID) sc0(SYS_getgid)

proc getegid*(): GID =
  (GID) sc0(SYS_getegid)

proc setuid*(uid: UID): int32 =
  HandleErrno (int32) sc1(SYS_setuid, cast[uint64](uid))

proc setgid*(gid: GID): int32 =
  HandleErrno (int32) sc1(SYS_getgid, cast[uint64](gid))

proc setegid*(egid: GID): int32 =
  HandleErrno (int32) sc1(SYS_getegid, cast[uint64](egid))

proc arch_prctl*(op: int32, address: pointer): int32 =
  HandleErrno (int32) sc2(SYS_arch_prctl, cast[uint64](op), cast[uint64](address))

{.pop.}
