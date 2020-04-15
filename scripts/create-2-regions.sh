#!/bin/bash

set -x

# create two regions sharing the same default disk store
~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "connect --locator=geode-vm-0.c.data-g2c.internal[10334]" -e "create region --name=testRegion1 --type=PARTITION_REDUNDANT_PERSISTENT --total-num-buckets=2753" -e "create region --name=testRegion2 --type=PARTITION_REDUNDANT_PERSISTENT --total-num-buckets=2753"
#~/workspace/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "connect --locator=localhost[10334]" -e "create region --name=testRegion1 --type=PARTITION_REDUNDANT_PERSISTENT" -e "create region --name=testRegion2 --type=PARTITION_REDUNDANT_PERSISTENT"
