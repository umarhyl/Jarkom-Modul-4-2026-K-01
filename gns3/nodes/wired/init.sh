#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.16.66
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 10.64.16.17
    netmask 255.255.255.248

auto eth2
iface eth2 inet static
    address 10.64.16.69
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 10.64.16.73
    netmask 255.255.255.252
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.16.66/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.16.17/29 dev eth1
ip link set eth1 up

ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.16.69/30 dev eth2
ip link set eth2 up

ip addr flush dev eth3 2>/dev/null
ip addr add 10.64.16.73/30 dev eth3
ip link set eth3 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 10.64.16.65

ip route replace 10.64.0.0/22 via 10.64.16.18

ip route replace 10.64.8.0/23 via 10.64.16.19
ip route replace 10.64.15.192/26 via 10.64.16.19

ip route replace 10.64.4.0/22 via 10.64.16.20
ip route replace 10.64.16.0/29 via 10.64.16.20
ip route replace 10.64.16.76/30 via 10.64.16.20

ip route replace 10.64.12.0/23 via 10.64.16.70
ip route replace 10.64.15.64/26 via 10.64.16.70

ip route replace 10.64.10.0/23 via 10.64.16.74
ip route replace 10.64.14.128/25 via 10.64.16.74
ip route replace 10.64.15.0/26 via 10.64.16.74
ip route replace 10.64.15.128/26 via 10.64.16.74
ip route replace 10.64.16.8/29 via 10.64.16.74
ip route replace 10.64.16.24/30 via 10.64.16.74
ip route replace 10.64.16.32/27 via 10.64.16.74
ip route replace 10.64.16.80/28 via 10.64.16.74

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
