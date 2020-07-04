#!/bin/bash

DIETPIROOT=$1
PASSWORD=${2:-FLTR}
SURVEY=$(test $3 && echo 0 || echo 1)
TIMEZONE=$(test -f /etc/timezone && cat /etc/timezone || echo "America/Los_Angeles")

test -f ${DIETPIROOT}/boot/dietpi.txt || { echo "Error: dietpi.txt not found."; exit; }

sed -i "s/AUTO_SETUP_LOCALE=.*/AUTO_SETUP_LOCALE=en_US.UTF-8/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/AUTO_SETUP_KEYBOARD_LAYOUT=.*/AUTO_SETUP_KEYBOARD_LAYOUT=us/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/AUTO_SETUP_TIMEZONE=.*/AUTO_SETUP_TIMEZONE=${TIMEZONE/\//\\/}/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/AUTO_SETUP_NET_HOSTNAME=.*/AUTO_SETUP_NET_HOSTNAME=FLTR/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/AUTO_SETUP_AUTOMATED=.*/AUTO_SETUP_AUTOMATED=1/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/AUTO_SETUP_GLOBAL_PASSWORD=.*/AUTO_SETUP_GLOBAL_PASSWORD=${PASSWORD}/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/SURVEY_OPTED_IN=.*/SURVEY_OPTED_IN=${SURVEY}/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/CONFIG_BOOT_WAIT_FOR_NETWORK=.*/CONFIG_BOOT_WAIT_FOR_NETWORK=2/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/CONFIG_AUTO_DIETPI_UPDATES=.*/CONFIG_AUTO_DIETPI_UPDATES=1/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/CONFIG_WIFI_COUNTRY_CODE=.*/CONFIG_WIFI_COUNTRY_CODE=US/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/CONFIG_SERIAL_CONSOLE_ENABLE=.*/CONFIG_SERIAL_CONSOLE_ENABLE=0/" ${DIETPIROOT}/boot/dietpi.txt
sed -i "s/CONFIG_ENABLE_IPV6=.*/CONFIG_ENABLE_IPV6=0/" ${DIETPIROOT}/boot/dietpi.txt

cp Automation_Custom_Script.sh ${DIETPIROOT}/boot/ || { echo "Error: automation script copy failed."; exit; }

umount "${DIETPIROOT}"

echo "Success! You may now transfer the eMMC/microSD to the hardware device, connect an Ethernet cable, and power it on.  Initial setup process may take up to 10 minutes, please be patient."
