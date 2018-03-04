#!/bin/sh

GROUP="0000:00:03.0"
DEVS="0000:03:00.0 0000:03:00.1 ."

if [ ! -z "$(ls -A /sys/class/iommu)" ]; then
	for DEV in $DEVS; do
		echo "vfio-pci" > /sys/bus/pci/devices/$GROUP/$DEV/driver_override
	done
fi

modprobe -i vfio-pci
