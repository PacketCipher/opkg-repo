# Personal OpenWrt OPKG Server      
```
wget https://raw.githubusercontent.com/PacketCipher/opkg-repo/main/keys/pcipher-repo.pub
opkg-key add pcipher-repo.pub

echo "src/gz custom_arch https://raw.githubusercontent.com/PacketCipher/opkg-repo/main/$(grep "OPENWRT_ARCH" /etc/os-release | awk -F '"' '{print $2}')" >> /etc/opkg/customfeeds.conf
echo "src/gz custom_minimal https://raw.githubusercontent.com/PacketCipher/opkg-repo/main/minimal" >> /etc/opkg/customfeeds.conf

opkg update
```