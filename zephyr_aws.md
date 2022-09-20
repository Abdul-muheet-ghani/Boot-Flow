# Adding AWS Suport on Zephyr
## Board
```
zephyr-> board-> riscv-> aws_fpga| 
                 	         |-> aws_fpga_deconfig
                         	 |-> aws_fpga.dts
                         	 |-> aws_fpga.yml
                      	 	 |-> board.cmake
                         	 |-> kconfig.board
                         	 |-> kconfig.deconfig
```
### aws_fpga_deconfig       

```
CONFIG_SOC_SERIES_RISCV_AWS=y      #SoC Series enbling  SoC kconfig.soc kconfig.deconfig.series
CONFIG_SOC_RISCV_AWS=y             #SoC selecting kconfig.soc
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
## SoC

```
zephyr-> SoC-> riscv-> riscv-privilege-> aws| 
                 	         	    |-> soc.c
                         	            |-> soc.h
                      	 	 	    |-> CMakeList.txt
					    |-> linker.ld
					    |-> kconfig.soc
                         	 	    |-> kconfig.series
                         	 	    |-> kconfig.deconfig.series
```
### kconfig.deconfig.series
```
if SOC_SERIES_RISCV_AWS    #

config SOC_SERIES
	default "aws"      #SoS path

```
### kconfig.series
```
config SOC_SERIES_RISCV_AWS
	bool "QEMU RISC-V VirtIO Board"
	select RISCV
	select SOC_FAMILY_RISCV_PRIVILEGE
```
### kconfig.soc 

```
choice
	prompt "QEMU RISC-V VirtIO Board"
	depends on SOC_SERIES_RISCV_AWS

config SOC_RISCV_AWS
	bool "QEMU RISC-V VirtIO Board"
	select ATOMIC_OPERATIONS_BUILTIN
	select INCLUDE_RESET_VECTOR
	select RISCV_ISA_EXT_M
	select RISCV_ISA_EXT_A
	select RISCV_ISA_EXT_C

endchoice
```
kernel-> banner.c having printk property

## Adding Xilnx UART Driver

```
		uartlite0: uartlite@40100000 {
			compatible = "xlnx,xps-uartlite-1.00.a";
			reg = <0x40100000 0x10000>;
	 	};
```

compatible = "xlnx,xps-uartlite-1.00.a"
zephyr-> dts-> bindings-> serial-> xlnx,xps-uartlite-1.00.a.yml
zephyr-> drivers-> serial-> uart_xlnx_uartlite.c          ->              #define DT_DRV_COMPAT `xlnx_xps_uartlite_1_00_a`
