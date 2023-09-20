# Personal OpenWrt OPKG Server      
```
sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf
echo "src/gz custom_arch https://raw.githubusercontent.com/PacketCipher/opkg-repo/main/$(grep "OPENWRT_ARCH" /etc/os-release | awk -F '"' '{print $2}')" >> /etc/opkg/customfeeds.conf
echo "src/gz custom_minimal https://raw.githubusercontent.com/PacketCipher/opkg-repo/main/minimal" >> /etc/opkg/customfeeds.conf
opkg update
```