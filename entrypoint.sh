#!/bin/sh

set -ex 

cat /etc/exports
exportfs -rv
cat /var/lib/nfs/etab

mount -t nfsd nfsd /proc/fs/nfsd

cleanup() {
  rpc.nfsd 0
  killall rpc.mountd || true
  exit 0
}

trap cleanup SIGINT SIGTERM

rpc.nfsd --tcp --no-udp --port 2049 --nfs-version 4.2 --no-nfs-version 3
rpc.mountd -F --nfs-version 4.2 --no-nfs-version 2 --no-nfs-version 3 &

wait 