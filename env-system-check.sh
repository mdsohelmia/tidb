#!/bin/sh
# View the data disk.
fdisk -l
#  View the partition UUID of the data disk.
lsblk -f
# NTP service synchronizes with the NTP server.
sudo apt-get install ntp
apt install ntpstat
apt install numactl

# Check and disable system swap
echo "vm.swappiness = 0" >>/etc/sysctl.conf
swapoff -a && swapon -a
sysctl -p

#Execute the following commands to modify the sysctl parameters
echo "fs.file-max = 1000000" >>/etc/sysctl.conf
echo "net.core.somaxconn = 32768" >>/etc/sysctl.conf
echo "net.ipv4.tcp_syncookies = 0" >>/etc/sysctl.conf
echo "vm.overcommit_memory = 1" >>/etc/sysctl.conf
sysctl -p

# Execute the following command to configure the user's limits.conf file:
cat <<EOF >>/etc/security/limits.conf
tidb           soft    nofile          1000000
tidb           hard    nofile          1000000
tidb           soft    stack          32768
tidb           hard    stack          32768
EOF
