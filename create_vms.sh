#!/bin/bash

# Download CenOS7 image 
mkdir -p ~/iso_images 
if ! [ -f "$HOME/iso_images/CentOS-7-x86_64-Minimal-2009.iso" ];
  then echo 'Press Ctrl+C to skip. Downloading CentOS image...'; 
  wget http://mirror.yandex.ru/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso -P ~/iso_images;
fi

# Configure vboxnet<N> interface and enable dhcp
VBOXNET=`echo $(vboxmanage hostonlyif create) | awk 'NR == 1 { print $2 }' | tr -d \'`

vboxmanage hostonlyif ipconfig $VBOXNET \
  --ip 192.168.56.1

vboxmanage dhcpserver add \
  --ifname $VBOXNET \
  --ip 192.168.56.1 \
  --netmask 255.255.255.0 \
  --lowerip 192.168.56.100 \
  --upperip 192.168.56.200

vboxmanage dhcpserver modify \
  --ifname $VBOXNET \
  --enable


function create_vm() {
    MACHINENAME=$1

    vboxmanage createvm \
      --name $MACHINENAME \
      --ostype "RedHat_64" \
      --register \
      --basefolder `pwd`

    #vboxmanage modifyvm $MACHINENAME --ioapic on
    vboxmanage modifyvm $MACHINENAME \
      --memory 1024 \
      --vram 128

    vboxmanage modifyvm $MACHINENAME \
      --nic1 hostonly \
      --hostonlyadapter1 $VBOXNET
    
    vboxmanage modifyvm $MACHINENAME \
      --graphicscontroller vmsvga

    vboxmanage createhd \
      --filename `pwd`/$MACHINENAME/${MACHINENAME}_DISK.vdi \
      --size 30000 --format VDI

    vboxmanage storagectl $MACHINENAME \
      --name "SATA Controller" \
      --add sata \
      --controller IntelAhci

    vboxmanage storageattach $MACHINENAME \
      --storagectl "SATA Controller" \
      --port 0 \
      --device 0 \
      --type hdd \
      --medium  `pwd`/$MACHINENAME/${MACHINENAME}_DISK.vdi

    vboxmanage storagectl $MACHINENAME \
      --name "IDE Controller" \
      --add ide --controller PIIX4

    vboxmanage storageattach $MACHINENAME \
      --storagectl "IDE Controller" \
      --port 1 \
      --device 0 \
      --type dvddrive \
      --medium ${HOME}/iso_images/CentOS-7-x86_64-Minimal-2009.iso

    vboxmanage modifyvm $MACHINENAME \
      --boot1 disk \
      --boot2 dvd \
      --boot3 none \
      --boot4 none
}

# Call create_vm function to create machines
create_vm SRV01
create_vm DHCP01

vboxmanage modifyvm DHCP01 --nic2 nat

vboxmanage startvm DHCP01 --type gui
vboxmanage startvm SRV01 --type gui
