#!/bin/bash

set -x

for i in $(eval echo "{0..${1}}")
do
  gcloud compute ssh geode-vm-${i} --command "~/test/scripts/test-build-geode.sh" &
done

wait
echo "All done!"
