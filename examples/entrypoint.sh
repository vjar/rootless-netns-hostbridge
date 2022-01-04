#!/bin/bash
qemu-kvm \
	-cpu host \
	-device "virtio-net-pci,netdev=net0,mac=00:12:12:00:00:01" \
	-m 256 \
	-netdev "id=net0,type=tap,fd=3" \
	-nographic \
	-smp $(nproc) \
	3<>/dev/tap0
