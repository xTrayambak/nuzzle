import pkg/nuzzle/x64/bindings/mem

echo cast[uint64](mmap(nil, 64, PROT_READ or PROT_WRITE, MAP_ANONYMOUS, -1, 0))
