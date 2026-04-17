## Kernel-compatible structs for calls that require them
##
## Copyright (C) 2026 Trayambak Rai (xtrayambak@disroot.org)

type
  Timespec* {.packed.} = object
    sec*, nsec*: int64

  Device* = distinct uint64
  Inode* = distinct uint64
  NumLink* = distinct uint64

  Offset* = distinct int64
  BlockCount* = distinct int64

  Mode* = distinct uint32
  UID* = distinct uint32
  GID* = distinct uint32
  BlockSize* = distinct int64

  Stat* {.packed.} = object
    device*: Device
    inode*: Inode
    numLink*: NumLink
    mode*: Mode
    uid*: UID
    gid*: GID
    pad0: int32
    rdevice*: Device
    size*: Offset
    blockSize*: BlockSize
    blocks*: BlockCount

    lastAccessTime*, lastModificationTime*, lastChangeTime*: Timespec
    unused: array[3, int64]
