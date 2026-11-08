#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.20.130
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 10.64.14.65
    netmask 255.255.255.248

auto eth2
iface eth2 inet static
    address 10.64.18.65
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 10.64.27.141
    netmask 255.255.255.252

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.20.130/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.14.65/29 dev eth1
ip link set eth1 up
ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.18.65/30 dev eth2
ip link set eth2 up
ip addr flush dev eth3 2>/dev/null
ip addr add 10.64.27.141/30 dev eth3
ip link set eth3 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 10.64.20.129
ip route replace 10.64.0.0/22 via 10.64.14.66
ip route replace 10.64.12.0/22 via 10.64.14.67
ip route replace 10.64.4.0/22 via 10.64.14.68
ip route replace 10.64.8.0/28 via 10.64.14.68
ip route replace 10.64.16.0/22 via 10.64.18.66
ip route replace 10.64.24.0/22 via 10.64.27.142

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
