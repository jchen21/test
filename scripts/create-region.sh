#!/bin/bash

set -x

~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "create region --name=testRegion --type=PARTITION_PERSISTENT"
