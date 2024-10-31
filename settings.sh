#!/usr/bin/bash
apt update
apt -y install openssh-server nano unzip wget curl psmisc net-tools
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
# configure ssh-server
mkdir /run/sshd
chmod -R 700 /run/sshd
chown -R root /run/sshd
echo "root:root" | chpasswd
