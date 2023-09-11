## How to run?

You need following packages
- zig
- mtools (for creating FAT images)
- qemu (for testing)
- ovmf (UEFI firmware that runs in qemu)

The build script assumes ovmf can be found in /usr/share/ovmf/x64/OVMF.fd

```shell
zig build run
```
should then do the trick