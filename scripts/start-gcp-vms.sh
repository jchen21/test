#!/bin/bash

set -x

for i in $(eval echo "{0..${1}}"); do
  gcloud compute instances create geode-vm-${i} \
    --async \
    --boot-disk-size 200GB \
    --boot-disk-type pd-ssd \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --local-ssd device-name=local-ssd-${i},interface=NVME \
    --machine-type n2-highmem-32 \
    --private-network-ip 10.128.0.1${i} \
    --scopes compute-rw,storage-rw,service-management,service-control,logging-write,monitoring \
    --tags disk-loading
done
