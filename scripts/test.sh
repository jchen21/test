#!/bin/bash

set -x

for i in $(eval echo "{0..${1}}")
do
  gcloud compute ssh geode-vm-${i} --command "test -f ~/geode/geode-assembly/build/install/apache-geode/bin/gfsh; test $? -eq 0 && echo \"Geode build successful on geode-vm-${i}\" || echo \"Geode build failed on geode-vm-${i}\"" &
done

wait
echo "All done!"
