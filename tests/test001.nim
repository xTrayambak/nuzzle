import pkg/nuzzle/x64/bindings/prelude

var mem: array[8, uint8]
echo ioctl(1, 0x5413'u64, cast[uint64](mem[0].addr))

# sometimes my genius, it's almost frightening
echo $(cast[ptr uint16](mem[0].addr)[]) & 'x' & $(cast[ptr uint16](mem[2].addr)[])
echo $(cast[ptr uint16](mem[4].addr)[]) & 'x' & $(cast[ptr uint16](mem[6].addr)[])
