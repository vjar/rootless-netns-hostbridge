#!/bin/bash
ip link add br0 type bridge
ip link set br0 up
ip link set eth0 master br0
ip tuntap add tap0 mode tap
ip link set tap0 master br0
ip link set tap0 up
qemu-kvm \
	-cpu host \
	-device "virtio-net-pci,netdev=net0,mac=00:12:12:00:00:01" \
	-m 256 \
	-netdev "id=net0,type=tap,ifname=tap0,script=no,downscript=no" \
	-nographic \
	-smp $(nproc)
