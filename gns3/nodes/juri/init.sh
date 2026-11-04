#!/bin/sh

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.64.15.194
    netmask 255.255.255.192
    gateway 10.64.15.193
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.15.194/26 dev eth0
ip link set eth0 up
ip route replace default via 10.64.15.193

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
