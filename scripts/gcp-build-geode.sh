#!/bin/bash

set -x

for i in $(eval echo "{0..${1}}")
do
  gcloud compute ssh geode-vm-${i} --command "rm -rf test && git clone https://github.com/jchen21/test.git && ~/test/scripts/build-geode.sh" &
done

wait
echo "All done!"
