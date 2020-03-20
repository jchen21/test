#!/bin/bash

set -x

# start servers
for i in $(eval echo "{1..${1}}") 
do
  gcloud compute ssh geode-vm-${i} --command "~/test/scripts/start-server.sh ${i}" &
done

wait
echo "All done!"

