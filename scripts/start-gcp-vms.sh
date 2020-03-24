#!/bin/bash

set -x

for i in $(eval echo "{0..${1}}"); do
  gcloud compute instances create geode-vm-${i} \
    --async \
    --boot-disk-size 200GB \
    --boot-disk-type pd-ssd \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-highmem-16 \
    --private-network-ip 10.128.0.3${i} \
    --scopes compute-rw,storage-rw,service-management,service-control,logging-write,monitoring \
    --tags disk-loading
done
