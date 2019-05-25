#!/bin/sh

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "LANG=en_US.utf8" >> /root/.bash_profile

apt-get update -y
apt-get upgrade -y
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get install -y apt-transport-https ca-certificates locales htop iotop iptraf make curl software-properties-common

localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

apt-get update -y
apt-get install -y docker-ce
service docker start

curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
curl -L https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -o /usr/local/bin/ctop

chmod +x /usr/local/bin/docker-compose
chmod +x /usr/local/bin/ctop

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -w net.ipv4.ip_forward=1 >> /dev/null 2>&1

echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$ \[\033[00m\]'" > /root/.bash_profile
echo "alias ll='ls --color -l'" >> /root/.bash_profile
echo "" > /etc/motd

