#!/usr/bin/sudo bash
echo "Share Internet over USB to Beaglebone Black"

#wlan0 is my internet facing interface, eth5 is the BeagleBone USB connection
ifconfig eth2 192.168.7.1
iptables --table nat --append POSTROUTING --out-interface wlan0 -j MASQUERADE
iptables --append FORWARD --in-interface eth2 -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward

