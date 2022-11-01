#!/bin/bash
usbmuxd &
./bin/netmuxd-zeroconf --disable-unix --host 127.0.0.1  &
export USBMUXD_SOCKET_ADDRESS=127.0.0.1:27015
./bin/altserver 
