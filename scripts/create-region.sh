#!/bin/bash

set -x

~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "connect --locator=geode-vm-0.c.data-g2c.internal[10334]" -e "create region --name=testRegion --type=PARTITION_REDUNDANCY_PERSISTENT"
