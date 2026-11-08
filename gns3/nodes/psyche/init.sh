#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.14.66
    netmask 255.255.255.248

auto eth1
iface eth1 inet static
    address 10.64.0.1
    netmask 255.255.252.0

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.14.66/29 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.0.1/22 dev eth1
ip link set eth1 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 10.64.14.65

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
