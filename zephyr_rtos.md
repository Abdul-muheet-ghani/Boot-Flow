> cd litex-boards/litex_boards/targets/

> ./digilent_arty.py --build --timer-uptime --csr-json csr.json

> cp csr.json /home/muheet-ghani/zephyrproject/zephyr/samples/synchronization/

> cd /home/muheet-ghani/zephyrproject/zephyr/samples/synchronization/

> ~/litex/litex/tools/litex_json2dts_zephyr.py --dts litex_vexriscv.dts --config litex_vexriscv.config csr.json

![image](https://user-images.githubusercontent.com/81433387/189995790-982532fb-3e4b-4125-8a1e-3dcb1fb9f8f7.png)


> west build -b litex_vexriscv . -DDTC_OVERLAY_FILE=litex_vexriscv.dts

![image](https://user-images.githubusercontent.com/81433387/189996102-9949fec2-2b52-47b0-9b36-d08f6e96bb55.png)


> cd -

> ./digilent_arty.py --load

![image](https://user-images.githubusercontent.com/81433387/189996906-0be4d246-3184-489a-88ac-c353ff366403.png)


> cd -

> litex_term /dev/ttyUSB1 --speed 115200 --kernel build/zephyr/zephyr.bin
