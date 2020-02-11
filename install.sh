#!/bin/bash
apt-get update -y
apt -y install libpcre3 libpcre3-dev build-essential autoconf automake libtool libpcap-dev libnet1-dev libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libmagic-dev libcap-ng-dev libjansson-dev pkg-config libnetfilter-queue-dev geoip-bin geoip-database geoipupdate apt-transport-https
echo "\n\e[33m Add suricata repository\e[0m"
add-apt-repository ppa:oisf/suricata-stable
echo "\n\e[30m Update repository\e[0m"
apt-get update -y
echo "\n\e[30m Installation of Suricata\e[0m"
apt-get install suricata -y
ehco "\n\e[30m Enable Promisc mode on sniffing Interface\e[0m"
ip link set ens160 promisc on
echo "\n\e[30m Suricata Update\e[0m"
apt install python-pip -y
pip install pyyaml
pip install https://github.com/OISF/suricata-update/archive/master.zip
echo "\n\e[30m Upgrade Suricata to latest\e[0m"
pip install --pre --upgrade suricata-update
suricata-update
suricata-update update-sources
suricata-update enable-source ptresearch/attackdetection
suricata-update enable-source oisf/trafficid
suricata-update enable-source sslbl/ssl-fp-blacklist
suricata-update
