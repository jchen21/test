#!/bin/bash

set -x

# create two disk stores
~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "connect --locator=geode-vm-0.c.data-g2c.internal[10334]" -e "create disk-store --name=diskstore1 --dir=diskstore1" -e "create disk-store --name=diskstore2 --dir=diskstore2"
#~/workspace/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "connect --locator=localhost[10334]" -e "create disk-store --name=diskstore1 --dir=diskstore1" -e "create disk-store --name=diskstore2 --dir=diskstore2"

# create two regions using different disk stores
~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "connect --locator=geode-vm-0.c.data-g2c.internal[10334]" -e "create region --name=testRegion1 --type=PARTITION_REDUNDANT_PERSISTENT --total-num-buckets=2753 --disk-store=diskstore1" -e "create region --name=testRegion2 --type=PARTITION_REDUNDANT_PERSISTENT --total-num-buckets=2753 --disk-store=diskstore2"
#~/workspace/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "connect --locator=localhost[10334]" -e "create region --name=testRegion1 --type=PARTITION_REDUNDANT_PERSISTENT --disk-store=diskstore1" -e "create region --name=testRegion2 --type=PARTITION_REDUNDANT_PERSISTENT --disk-store=diskstore2"

