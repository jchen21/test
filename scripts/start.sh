#!/bin/bash

set -x

for i in {0..2}
do
  gcloud compute ssh geode-vm-${i} --command ""git clone https://github.com/jchen21/test.git && ~/test/scripts/build-geode.sh" &
done

wait
echo "All done!"
