source_file := $(shell find ../src/NOVA -name *.c)
start_file  := $(shell find ../build_os -name *.S)

source_int_file := $(shell find ../src/intf/implementation -name *.c)
int_object_file := $(patsubst ../src/intf/implementation/%.c, ../build_os/%.o, $(source_int_file) )

riscv_object_file := $(object_file) $(int_object_file)

elf_file    := $(patsubst ../src/NOVA/%.c, ../build_os/%.elf, $(source_file))
object_file := $(patsubst ../src/NOVA/%.c, ../build_os/%.o, $(source_file) )

assemble_file := $(patsubst ../src/NOVA/%.c, ../build_os/%.dis, $(source_file) )
verilog_hex := $(patsubst ../src/NOVA/%.c, ../build_os/%.hex, $(source_file) )

.PHONY: build_OS
build_OS: 
	mkdir -p ../build_os && \
	cd ../build_os && \
	riscv64-unknown-elf-gcc -c -I ../src/intf/ -march=rv64i -mabi=lp64 $(source_file) -o $(object_file) && \
	riscv64-unknown-elf-gcc -c -I ../src/intf/ -march=rv64i -mabi=lp64 $(source_int_file) -o $(int_object_file) && \
	riscv64-unknown-elf-gcc -nostartfiles -nostdlib -T ../target/riscv/linker.ld $(object_file) $(int_object_file) -o $(elf_file) && \
	riscv64-unknown-elf-objdump -d -t -r $(elf_file) > $(assemble_file) && \
	riscv64-unknown-elf-objcopy -O verilog $(elf_file) $(verilog_hex)

.PHONY: clean
clean:
	rm -r ../build_os/*.o ../build_os/*.elf ../build_os/*.dis
clean_build:
	rm -r ../build_os