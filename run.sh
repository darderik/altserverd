#!/bin/bash
usbmuxd &
./bin/netmuxd-zeroconf --disable-unix --host 127.0.0.1  &
export USBMUXD_SOCKET_ADDRESS=127.0.0.1:27015
export ALTSERVER_ANISETTE_SERVER=http://127.0.0.1:6969
./bin/altserver 
