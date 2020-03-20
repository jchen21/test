#!/bin/bash

set -x

# start servers
for i in {1..2} 
do
  gcloud compute ssh geode-vm-${i} --command "~/test/scripts/start-server.sh ${i}" &
done

wait
echo "All done!"

