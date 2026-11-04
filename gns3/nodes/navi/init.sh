#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.16.70
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 10.64.12.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.64.13.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.64.15.65
    netmask 255.255.255.192
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.16.70/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.12.1/24 dev eth1
ip link set eth1 up

ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.13.1/24 dev eth2
ip link set eth2 up

ip addr flush dev eth3 2>/dev/null
ip addr add 10.64.15.65/26 dev eth3
ip link set eth3 up

sysctl -w net.ipv4.ip_forward=1
ip route replace default via 10.64.16.69

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
