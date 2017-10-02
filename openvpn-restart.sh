#/bin/bash


sudo service qbittorrent stop &&
sudo service openvpn@pia-toronto restart &&
sudo service qbittorrent start

echo "Openvpn restarted"
ip-pub
ping -c 4 8.8.8.8
