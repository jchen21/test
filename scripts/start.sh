#!/bin/bash

set -x

for i in {0..2}
do
  gcloud compute ssh geode-vm-${i} --command "cd ~/test && git pull" &
done

wait
echo "All done!"
