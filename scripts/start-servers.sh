#!/bin/bash

set -x

# start servers
for i in {1..2} 
do
  gcloud compute ssh geode-vm-${i} --command "~/start-server {i}"
done

wait
echo "All done!"

