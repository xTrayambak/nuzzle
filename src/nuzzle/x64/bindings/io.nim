## Low-level syscall bindings for basic I/O.
##
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)

#!fmt: off
import pkg/nuzzle/flags,
       pkg/nuzzle/x64/[dispatch],
       pkg/nuzzle/x64/bindings/[err, types]
#!fmt: on

const
  O_RDONLY* = 0
  O_WRONLY* = 1
  O_RDWR* = 2
  O_CREAT* = 64
  O_EXCL* = 128
  O_TRUNC* = 512
  O_DIRECTORY* = 65536

when SubstitutingLibc:
  {.push exportc.}

{.push cdecl, sideEffect.}

proc open*(path: cstring | ptr char, flags: int32, mode: Mode = Mode(0)): int32 =
  HandleErrno (int32) sc3(
    SYS_open, cast[uint64](path), cast[uint64](flags), cast[uint64](mode)
  )

proc close*(fd: int32): int32 =
  HandleErrno (int32) sc1(SYS_close, cast[uint64](fd))

proc openat*(
    dirfd: int32, path: cstring | ptr char, flags: int32, mode: Mode = Mode(0)
): int32 =
  HandleErrno (int32) sc4(
    SYS_openat,
    cast[uint64](dirfd),
    cast[uint64](path),
    cast[uint64](flags),
    cast[uint64](mode),
  )

proc write*(fd: int32, buffer: cstring | ptr char, count: uint64): int64 =
  let ret = sc3(SYS_write, cast[uint64](fd), cast[uint64](buffer), count)
  if ret < 0:
    errno = -cast[int32](ret)
    return -1'i64

  ret

proc read*(fd: int32, buf: ptr char | cstring, count: Offset): int64 =
  (int32) HandleErrno (int32) sc3(
    SYS_read, cast[uint64](fd), cast[uint64](buf), cast[uint64](count)
  )

proc link*(oldpath: cstring | ptr char, newpath: cstring | ptr char): int32 =
  HandleErrno (int32) sc2(SYS_link, cast[uint64](oldpath), cast[uint64](newpath))

proc dup*(oldfd: int32): int32 =
  HandleErrno (int32) sc1(SYS_dup, cast[uint64](oldfd))

proc dup2*(oldfd: int32, newfd: int32): int32 =
  HandleErrno (int32) sc2(SYS_dup2, cast[uint64](oldfd), cast[uint64](newfd))

proc dup3*(oldfd: int32, newfd: int32, flags: int32): int32 =
  HandleErrno (int32) sc3(
    SYS_dup3, cast[uint64](oldfd), cast[uint64](newfd), cast[uint64](flags)
  )

proc stat*(path: cstring, statbuf: ptr Stat): int32 =
  HandleErrno (int32) sc2(SYS_stat, cast[uint64](path), cast[uint64](statbuf))

proc fstat*(fd: int32, statbuf: ptr Stat): int32 =
  HandleErrno (int32) sc2(SYS_fstat, cast[uint64](fd), cast[uint64](statbuf))

{.pop.}

when SubstitutingLibc:
  {.pop.}
