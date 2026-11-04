#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.64.14.1
    netmask 255.255.255.128

auto eth2
iface eth2 inet static
    address 10.64.16.65
    netmask 255.255.255.252
EOF

ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.14.1/25 dev eth1
ip link set eth1 up

ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.16.65/30 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -s 10.64.0.0/19 -o eth0 -j ACCEPT
iptables -A FORWARD -j ACCEPT

ip route replace 10.64.0.0/19 via 10.64.16.66

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
