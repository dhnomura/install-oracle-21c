#!/bin/bash

echo "
grid soft nproc 2047
grid hard nproc 16384
grid soft nofile 1024
grid hard nofile 65536
grid soft stack 10240
grid hard stack 32768
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle soft stack 10240
oracle hard stack 32768
" >> /etc/security/limits.conf

echo "fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
#kernel.shmall = 1073741824
#kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
" > /etc/sysctl.d/98-oracle.conf

/sbin/sysctl -p /etc/sysctl.d/98-oracle.conf

systemctl stop firewalld
systemctl disable firewalld

SELINUX=`cat /etc/selinux/config|grep ^SELINUX=|awk -F "=" '{print $2}'`
if SELINUX == "enforcing"; then
    sed -i 's/enforcing/permissive/g' /etc/selinux/config
fi

setenforce Permissive

service avahi-daemon stop

chkconfig avahi-daemon off