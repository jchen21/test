#!/bin/bash

set -x

# start server
~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "start server --name=server${1} --locators=geode-vm-0.c.data-g2c.internal[10334] --initial-heap=64G --max-heap=64G --J=-XX:+UseConcMarkSweepGC --J=-XX:+CMSClassUnloadingEnabled --J=-XX:CMSInitiatingOccupancyFraction=75 --J=-Xloggc:gc.log --J=-XX:+PrintGCDetails --J=-XX:+PrintGCDateStamps --J=-XX:+PrintGCTimeStamps --J=-XX:+PrintTenuringDistribution"


