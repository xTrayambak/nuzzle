# nuzzle
Nuzzle is a package that provides an alternative implementation of libc functions, in pure Nim.

It essentially wraps all POSIX (and Linux extras, too!) system calls via assembly, bypassing the system's C library (glibc, musl if you're brave, etc.) entirely, unless you use Nim's `std/posix` or manually use FFI to import from said libraries.

Do mind that this library _doesn't_ try to implement the C standard library itself, and never will!

**NOTE**: It currently only supports x86-64. AArch64 and RISC-V support is planned. \
**NOTE zwei**: OpenBSD support is a no-go (does Nim even work there?), because the OpenBSD team has decided that syscalls are dangerous and nobody should ever touch them (I don't think their syscall numbers are stable, either :P) and everyone should just happily work with libc instead. (TL;DR: OpenBSD is Windows on steroids here)
**NOTE drei**: This is mostly just a demo right now, you should _probably_ wait a bit before using it.

# roadmap
Linux has hundreds of syscalls, so it'll obviously take some time to bind all of them.

## I/O
- [X] `open` / `openat`
- [X] `close`
- [X] `write`
- [X] `link`
- [X] `ioctl`
- [X] `dup` / `dup2` / `dup3`
- [X] `stat` / `fstat`

## memory management
- [X] `mmap`
- [X] `munmap`
- [X] `brk`
- [X] `mseal` (not implemented in glibc yet!)
- [X] `msync`
- [X] `memfd_create`
- [X] `mprotect`
- [X] `mlock` / `munlock`
- [X] `madvise`
- [X] `mlockall` / `munlockall`

## process management
- [X] `fork`
- [X] `kill`
- [X] `exit`

## misc
- [X] `pause`
- [X] `getrandom`
- [X] `getuid` / `geteuid`
- [X] `getgid` / `getegid`
- [X] `setuid`
- [X] `setgid` / `setegid`
- [X] `arch_prctl`
