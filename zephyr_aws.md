# Adding AWS Suport on Zephyr
## Board
```
zephyr-> riscv-> aws_fpga| 
                         |-> aws_fpga_deconfig
                         |-> aws_fpga.dts
                         |-> aws_fpga.yml
                         |-> board.cmake
                         |-> kconfig.board
                         |-> kconfig.deconfig
```
### aws_fpga_deconfig       

```
CONFIG_SOC_SERIES_RISCV_AWS=y      #SoC Series enbling
CONFIG_SOC_RISCV_AWS=y             #SoC selecting   
CONFIG_BOARD_AWS_FPGA=y            #Board
CONFIG_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UART_CONSOLE=y
CONFIG_UART_XLNX_UARTLITE=y        #enble xilinx uart driver
CONFIG_STACK_SENTINEL=y
CONFIG_QEMU_ICOUNT_SHIFT=6
CONFIG_XIP=n                       #partinioning in ROM and RAM
CONFIG_RISCV_PMP=y
```

### aws_fpga.dts
selecting the specific part
```
#include <aws_fpga.dtsi>

/ {
	chosen {
		zephyr,console = &uart0;
		zephyr,shell-uart = &uart0;
		zephyr,sram = &ram0;
	};
};

&uart0 {
	status = "okay";
};
```

### board.cmake 
this file is used only for qemu emulation like for
```
west build -t run
```
### kconfig.board
Board support and SoC 
```
config BOARD_AWS_FPGA
	bool "AWS RISCV32 target"
	depends on SOC_RISCV_AWS
	select QEMU_TARGET
	select CPU_HAS_FPU
	select RISCV_ISA_RV32I
	select RISCV_ISA_EXT_ZICSR
	select RISCV_ISA_EXT_ZIFENCEI
```

### kconfig.defconfig
```
config BUILD_OUTPUT_HEX
	default y

config BOARD
	default "aws_fpga" if BOARD_AWS_FPGA

# Use thread local storage by default so that
# this feature gets more CI coverage.
config THREAD_LOCAL_STORAGE
	default y
```
