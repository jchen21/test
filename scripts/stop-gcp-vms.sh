#!/bin/bash

set -x

vmlist=""
space=" "
for i in {0..2}; do
  vmlist=${vmlist}${space}geode-vm-${i}
done
echo ${vmlist}
gcloud -q compute instances delete ${vmlist} --zone $(gcloud config get-value compute/zone)
