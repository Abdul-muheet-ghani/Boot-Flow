# Zephyr on LiteX VexRiscv an example of a system on a chip (SoC)

To run the ZephyrOS on the VexRiscv CPU, it is necessary to prepare the bitstream for the FPGA on a Digilent Arty A7-35 Board

1. Clone the repository and update all submodules:

```
git clone https://github.com/litex-hub/zephyr-on-litex-vexriscv.git
cd zephyr-on-litex-vexriscv
git submodule update --init --recursive
```

2.Next, get all required packages and run the install script:

```
apt-get install build-essential bzip2 python3 python3-dev python3-pip
./install.sh
```

3. Install Migen/LiteX and the LiteX’s cores:

```
wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
chmod +x litex_setup.py
./litex_setup.py --init --install 
```

4. Install the RISC-V toolchain:

```
pip3 install meson ninja
./litex_setup.py --gcc=riscv
```

5. Build the Bitstream (Default for arty-a35t)

```
cd litex-boards/litex_boards/targets/
./digilent_arty.py --build --timer-uptime --csr-json csr.json
```

6. Build the Application

```
cp csr.json /home/muheet-ghani/zephyrproject/zephyr/samples/synchronization/
cd /home/muheet-ghani/zephyrproject/zephyr/samples/synchronization/
```

7. Json to dts Conversion

```
~/litex/litex/tools/litex_json2dts_zephyr.py --dts litex_vexriscv.dts --config litex_vexriscv.config csr.json
```

> Expected Output

![image](https://user-images.githubusercontent.com/81433387/189995790-982532fb-3e4b-4125-8a1e-3dcb1fb9f8f7.png)

8. Build Application

```
west build -b litex_vexriscv . -DDTC_OVERLAY_FILE=litex_vexriscv.dts
```

> Expected Output

![image](https://user-images.githubusercontent.com/81433387/189996102-9949fec2-2b52-47b0-9b36-d08f6e96bb55.png)

9. Load The Bitstream 

```
cd -
./digilent_arty.py --load
```

> Expected Output

![image](https://user-images.githubusercontent.com/81433387/189996906-0be4d246-3184-489a-88ac-c353ff366403.png)

> Expected Output On FPGA 

![WhatsApp Image 2022-09-13 at 7 58 18 PM](https://user-images.githubusercontent.com/81433387/189998875-d47f4e4c-9efe-4c42-a431-0eb67d6e86a1.jpeg)

10. Kernal Booting

```
cd -
litex_term /dev/ttyUSB1 --speed 115200 --kernel build/zephyr/zephyr.bin
```

> If you have facing that problem 
> then ls /dev
> and checked ttyUSBX

```
  File "/home/muheet-ghani/.local/lib/python3.9/site-packages/serial/serialposix.py", line 322, in open
    self.fd = os.open(self.portstr, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
FileNotFoundError: [Errno 2] No such file or directory: '/dev/ttyUSB1'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/muheet-ghani/miniconda3/bin/litex_term", line 33, in <module>
    sys.exit(load_entry_point('litex', 'console_scripts', 'litex_term')())
  File "/home/muheet-ghani/litex/litex/tools/litex_term.py", line 641, in main
    term.open(port, int(float(args.speed)))
  File "/home/muheet-ghani/litex/litex/tools/litex_term.py", line 317, in open
    self.port = serial.serial_for_url(port, baudrate)
  File "/home/muheet-ghani/.local/lib/python3.9/site-packages/serial/__init__.py", line 90, in serial_for_url
    instance.open()
  File "/home/muheet-ghani/.local/lib/python3.9/site-packages/serial/serialposix.py", line 325, in open
    raise SerialException(msg.errno, "could not open port {}: {}".format(self._port, msg))
serial.serialutil.SerialException: [Errno 2] could not open port /dev/ttyUSB1: [Errno 2] No such file or directory: '/dev/ttyUSB1'
```

> Expected Output

![image](https://user-images.githubusercontent.com/81433387/189998772-2b754344-c72d-4991-a0af-e793d5e2d1a1.png)
