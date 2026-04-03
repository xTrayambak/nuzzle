## Memory-related syscalls on x64
##
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)
#!fmt: off
import pkg/nuzzle/flags,
       pkg/nuzzle/x64/bindings/err,
       pkg/nuzzle/x64/dispatch
#!fmt: on

const MAP_FAILED* = cast[pointer](-1)

when SubstitutingLibc:
  {.push exportc.}

{.push cdecl.}
proc brk*(address: pointer): int32 =
  HandleErrno (int32) sc1(SYS_brk, cast[uint64](address))

proc mmap*(address: pointer, length: uint64, prot: int32, flags: int32): pointer =
  let ret = (uint64) sc4(
    SYS_mmap, cast[uint64](address), length, cast[uint64](prot), cast[uint64](flags)
  )
  if ret < 0:
    errno = -cast[int32](ret)
    return MAP_FAILED

  cast[pointer](ret)

proc munmap*(address: pointer, length: uint64): int32 =
  HandleErrno (int32) sc2(SYS_open, cast[uint64](address), length)

proc mseal*(address: pointer, size: uint64, flags: uint64): int32 =
  # NOTE: glibc doesn't implement this yet
  let ret = (int32) sc3(SYS_mseal, cast[uint64](address), size, flags)
  if ret < 0:
    errno = -ret
    return -1'i32

  ret

proc msync*(address: pointer, length: uint64, flags: int32): int32 =
  let ret = (int32) sc3(SYS_msync, cast[uint64](address), length, cast[uint64](flags))
  if ret < 0:
    errno = -ret
    return -1'i32

  ret

proc memfd_create*(name: cstring | ptr char, flags: uint32): int32 =
  HandleErrno (int32) sc2(SYS_memfd_create, cast[uint64](name), cast[uint64](flags))

proc mprotect*(address: pointer, size: uint64, prot: int32): int32 =
  HandleErrno (int32) sc3(SYS_mprotect, cast[uint64](address), size, cast[uint64](prot))

proc mlock*(address: pointer, size: uint64): int32 =
  HandleErrno (int32) sc2(SYS_mlock, cast[uint64](address), size)

proc munlock*(address: pointer, size: uint64): int32 =
  HandleErrno (int32) sc2(SYS_munlock, cast[uint64](address), size)

proc madvise*(address: pointer, size: uint64, advice: int32): int32 =
  HandleErrno (int32) sc3(
    SYS_madvise, cast[uint64](address), size, cast[uint64](advice)
  )

proc mlockall*(flags: int32): int32 =
  HandleErrno (int32) sc1(SYS_mlockall, cast[uint64](flags))

proc munlockall*(): int32 =
  HandleErrno (int32) sc0(SYS_munlockall)

{.pop.}

when SubstitutingLibc:
  {.pop.}
