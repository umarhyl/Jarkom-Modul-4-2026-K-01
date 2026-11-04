#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.16.90
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 10.64.16.9
    netmask 255.255.255.248

auto eth2
iface eth2 inet static
    address 10.64.16.93
    netmask 255.255.255.252
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.16.90/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.16.9/29 dev eth1
ip link set eth1 up

ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.16.93/30 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1
ip route replace default via 10.64.16.89

ip route replace 10.64.15.0/26 via 10.64.16.94
ip route replace 10.64.16.24/30 via 10.64.16.94
ip route replace 10.64.16.32/27 via 10.64.16.94

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
