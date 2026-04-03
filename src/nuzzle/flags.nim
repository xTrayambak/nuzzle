## Common flags

const SubstitutingLibc* = defined(nuzzleSubstituteLibc)
  ## Is nuzzle supposed to export its low level syscall bindings to all C code?
  ## This means that any other code looking for libc symbols will (likely) resolve to
  ## nuzzle's bindings, even if it's written in C, and will work fine as its bindings are
  ## not built with the default Nim calling convention (as in, they don't expect closure pointers).
