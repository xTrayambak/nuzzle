## errno
##
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)
import pkg/nuzzle/flags, pkg/nuzzle/x64/bindings/err_def
export err_def

var errno* {.threadvar.}: int32

when SubstitutingLibc:
  func errnoLocationImpl(): ptr int32 {.exportc: "__errno_location".} =
    ## nim-land doesn't really need this.
    errno.addr

  {.push exportc.}

{.push cdecl.}
func strerror*(value: int32): cstring =
  if value == 0:
    cstring("Success")
  elif cast[int32](StringErrors.len) < value or value < 0:
    cstring("Unknown error " & $value)
  else:
    cstring(StringErrors[value - 1])

{.pop.}

when SubstitutingLibc:
  {.pop.}

template HandleErrno*(value: int32): int32 =
  if value < 0:
    errno = -value
    return -1'i32

  value
