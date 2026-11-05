#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.14.68
    netmask 255.255.255.248

auto eth1
iface eth1 inet static
    address 10.64.8.1
    netmask 255.255.255.248

auto eth2
iface eth2 inet static
    address 10.64.8.9
    netmask 255.255.255.252

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.14.68/29 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.8.1/29 dev eth1
ip link set eth1 up
ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.8.9/30 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 10.64.14.65
ip route replace 10.64.4.0/22 via 10.64.8.10

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
