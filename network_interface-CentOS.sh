# echo "nameserver 8.8.8.8" >> /etc/resolv.conf
# echo "nameserver 8.8.4.4" >> /etc/resolv.conf
# /etc/sysconfig/network-scripts/ifcfg-eth0 
# systemctl stop NetworkManager.service
# systemctl restart network.service
# systemctl enable network.service

# Find network interfaces (not lo)
# ip addr
# ip link
# or
# ifconfig

# Change ipv6 off:
# Vim /etc/sysconfig/network
# NETWORKING_IPV6=”no”

# vi /etc/sysconfig/network-scripts/ifcfg-ens32
# Use vi to edit the file
# vi Shortcuts:
# i = insert
# esc = escape insert
# / = find
# :w = write/save
# :q = quit
# dd = deletes line

# UUID="keep default ”
# NM_CONTROLLED="yes"
# BOOTPROTO="static"
# NAME=_interfacename
# ONBOOT="yes"
# IPADDR0=”x.x.:x.1” - centos
# NETMASK=255.255.255.0
# BROADCAST=x.x.x.255
# NETWORK=x.x.x.0
# DNS1=”x.x.x.x” - centos
# DNS2=”x.x.x.x” - centos
# GATEWAY0=”x.x.x.1” - centos

# systemctl restart network.service



