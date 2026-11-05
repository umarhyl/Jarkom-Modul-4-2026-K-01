#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.26.130
    netmask 255.255.255.252

auto eth1
iface eth1 inet static
    address 10.64.26.193
    netmask 255.255.255.192

auto eth2
iface eth2 inet static
    address 10.64.26.133
    netmask 255.255.255.252

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.26.130/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.26.193/26 dev eth1
ip link set eth1 up
ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.26.133/30 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 10.64.26.129
ip route replace 10.64.27.0/24 via 10.64.26.134

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
