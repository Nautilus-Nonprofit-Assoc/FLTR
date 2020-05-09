#!/bin/bash

[ ! -f boot/dietpi.txt ] && echo "Error. Please rerun from DietPi root directory." && exit

sed -i 's/AUTO_SETUP_LOCALE=.*/AUTO_SETUP_LOCALE=en_US.UTF-8/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_KEYBOARD_LAYOUT=.*/AUTO_SETUP_KEYBOARD_LAYOUT=us/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_TIMEZONE=.*/AUTO_SETUP_TIMEZONE=America\/Phoenix/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_NET_HOSTNAME=.*/AUTO_SETUP_NET_HOSTNAME=Nautilus/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_AUTOMATED=.*/AUTO_SETUP_AUTOMATED=1/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_GLOBAL_PASSWORD=.*/AUTO_SETUP_GLOBAL_PASSWORD=N@utilus/' boot/dietpi.txt
sed -i 's/SURVEY_OPTED_IN=.*/SURVEY_OPTED_IN=1/' boot/dietpi.txt
sed -i 's/CONFIG_BOOT_WAIT_FOR_NETWORK=.*/CONFIG_BOOT_WAIT_FOR_NETWORK=2/' boot/dietpi.txt
sed -i 's/CONFIG_AUTO_DIETPI_UPDATES=.*/CONFIG_AUTO_DIETPI_UPDATES=1/' boot/dietpi.txt
sed -i 's/CONFIG_WIFI_COUNTRY_CODE=.*/CONFIG_WIFI_COUNTRY_CODE=US/' boot/dietpi.txt
sed -i 's/CONFIG_SERIAL_CONSOLE_ENABLE=.*/CONFIG_SERIAL_CONSOLE_ENABLE=0/' boot/dietpi.txt
sed -i 's/CONFIG_ENABLE_IPV6=.*/CONFIG_ENABLE_IPV6=0/' boot/dietpi.txt

cp ./Automation_Custom_Script.sh boot/ || echo "Error. Automation script not found." && exit

echo "Success! You may now transfer the eMMC/microSD to the hardware device, connect an Ethernet cable, and power it on.  Initial setup process may take a few minutes, please be patient."
