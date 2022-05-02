#!/bin/bash

fstab=$(cat /etc/fstab | grep cifs | cut -d' ' -f2)
for i in $fstab
do
  echo "Checking for mounts for $i..."
  until $(mount | grep -q "$i type cifs")
  do
    echo "Waiting for mount $i to be ready..."
    mount $i
    /bin/sleep 10
  done
done
