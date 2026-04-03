## Routines for handling syscalls in assembly for x64
##
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)
import pkg/nuzzle/x64/syscalls
export syscalls

type SyscallDispatch* = object

{.push cdecl, inline, checks: off, sideEffect, tags: [SyscallDispatch], discardable.}
proc sc0*(n: syscalls.Syscall): int64 =
  asm """
    syscall
    :"=a"(`result`)
    :"a"(`n`)
    :"rcx", "r11", "memory"
  """

proc sc1*(n: syscalls.Syscall, a1: uint64): int64 =
  asm """
    syscall
    :"=a"(`result`)
    :"a"(`n`), "D"(`a1`)
    :"rcx", "r11", "memory"
  """

proc sc2*(n: syscalls.Syscall, a1, a2: uint64): int64 =
  asm """
    syscall
    :"=a"(`result`)
    :"a"(`n`), "D"(`a1`), "S"(`a2`)
    :"rcx", "r11", "memory"
  """

proc sc3*(n: syscalls.Syscall, a1, a2, a3: uint64): int64 =
  asm """
    syscall
    :"=a"(`result`)
    :"a"(`n`), "D"(`a1`), "S"(`a2`), "d"(`a3`)
    :"rcx", "r11", "memory"
  """

proc sc4*(n: syscalls.Syscall, a1, a2, a3, a4: uint64): int64 =
  asm """
    movq %5, %%r10
    syscall
    :"=a"(`result`)
    :"a"(`n`), "D"(`a1`), "S"(`a2`), "d"(`a3`), "r"(`a4`)
    :"rcx", "r11", "r10", "memory"
  """

proc sc5*(n: syscalls.Syscall, a1, a2, a3, a4, a5: uint64): int64 =
  asm """
    movq %5, %%r10
    movq %6, %%r8
    :"=a"(`result`)
    :"a"(`n`), "D"(`a1`), "S"(`a2`), "d"(`a3`), "r"(`a4`), "v"(`a5`)
  """

{.pop.}
