#!/bin/bash

set -x

gcloud compute scp geode-vm-0:~/locator/*log .

for i in $(eval echo "{1..${1}}")
do
  gcloud compute scp geode-vm-${i}:~/server${i}/*.log .
  gcloud compute scp geode-vm-${i}:~/server${i}/*gfs .
done

wait
echo "All done!"
