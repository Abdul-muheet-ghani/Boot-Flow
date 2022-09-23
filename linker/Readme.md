`riscv64-unknown-elf-gcc`
this is used for compile link and assembler forat

`riscv64-unknown-elf-ld `
for linker

`riscv64-unknown-elf-as`
convert assembly to machine code

`riscv64-unknown-elf-objdump` `riscv64-unknown-elf-readelf` `riscv64-unknown-elf-nm`
file analyzing

`riscv64-unknown-elf-objcopy`
format converter

*.i* is the preprocess file from *.c* file

then next stage is code generation where *.i* is converted into *.s* which is our assembly

*.s* is converted into *.o* which is relocatable file

## riscv64-unknown-elf-gcc
  -E                       Preprocess only; do not compile, assemble or link.
  -S                       Compile only; do not assemble or link.
  -c                       Compile and assemble, but do not link.
  -o <file>                Place the output into <file>.

```
  riscv64-unknown-elf-gcc -S tst.c -o c_test_assembly.s
  Assemly file created

  riscv64-unknown-elf-gcc -g tst.c -o c_test.o
  for object file

  riscv32-unknown-elf-objdump -d tst
  dissassmble it

  riscv64-unknown-elf-objdump -h c_test.o
  shows the different section of .o file

  riscv64-unknown-elf-objdump -d c_test.o > c_test_log
  dump assembly into new file

  riscv64-unknown-elf-gcc -nostartfiles -nostdlib -T linker.ld tst.o -o tst.elf
  use for not startup file

  riscv64-unknown-elf-objdump -D tst.elf > tst.dis
  dissassemble

  riscv64-unknown-elf-gcc -g -c tst.c -o tst.o
  for non linking compiling
```
