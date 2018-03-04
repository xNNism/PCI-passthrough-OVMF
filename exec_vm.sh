#!/bin/bash

#################################################################################################################
vmname="win10"

if ps -A | grep -q $vmname; then
echo "$vmname is already running." &
exit 1

else

#################################################################################################################
## use pulseaudio
#################################################################################################################
# export QEMU_AUDIO_DRV=pa
# export QEMU_PA_SAMPLES=8192
# export QEMU_AUDIO_TIMER_PERIOD=99
# export QEMU_PA_SERVER=/run/user/1000/pulse/native
#################################################################################################################

qemu-system-x86_64 \
-name $vmname,process=$vmname \
-machine type=pc-q35-2.11,accel=kvm, \
-cpu host,kvm=off,hv_vendor_id=123456789ab \
-smp 8,sockets=1,cores=4,threads=2 \
-m 8G \
-rtc clock=host,base=localtime \
-mem-prealloc \
-balloon none \
-serial none \
-nographic \
-vga none \
-net nic,model=virtio -net user \
-parallel none \
-device vfio-pci,host=03:00.0,multifunction=on,x-vga=on \
-device vfio-pci,host=03:00.1 \
-drive if=pflash,format=raw,readonly,file=/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd \
-drive if=pflash,format=raw,file=/usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-efi.fd \
-drive id=disk0,if=virtio,cache=none,format=raw,file=/mnt/SSD/Qemu_KVM/win.img \
-usbdevice host:062a:4101 \
-usbdevice host:0c45:7603 \
-usbdevice host:0bda25:8153 \

#################################################################################################################

exit 0
fi

#################################################################################################################
#
# -usb -usbdevice host:062a:4101 \
# -usb -usbdevice host:0c45:7603 \
# -drive file=$OS_ISO,index=1,media=cdrom \
# -drive file=$VIRTIO_ISO,index=2,media=cdrom \
# -display gtk \
# -vga std \
# -nographic \
# -vga none \
# -soundhw hda \
# -usb -usbdevice host:0c45:7603 \
# -usb -usbdevice host:1a81:1701 \
# -usb -usbdevice host:06a3:f620 \
# -usb -usbdevice host:0d8c:0102 \
#
#################################################################################################################
