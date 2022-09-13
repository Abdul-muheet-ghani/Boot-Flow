> cd litex-boards/litex_boards/targets/

> ./digilent_arty.py --build --timer-uptime --csr-json csr.json

> cp csr.json /home/muheet-ghani/zephyrproject/zephyr/samples/synchronization/

> cd /home/muheet-ghani/zephyrproject/zephyr/samples/synchronization/

> ~/litex/litex/tools/litex_json2dts_zephyr.py --dts litex_vexriscv.dts --config litex_vexriscv.config csr.json

> west build -b litex_vexriscv . -DDTC_OVERLAY_FILE=litex_vexriscv.dts

> cd -

> ./digilent_arty.py --load

> cd -

> litex_term /dev/ttyUSB1 --speed 115200 --kernel build/zephyr/zephyr.bin
