#!/bin/bash

set -x

# start server
~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "start server --name=server${1} --locators=geode-vm-0.c.data-g2c.internal[10334] --J=-Dgemfire.statistic-archive-file=server${1}.gfs --initial-heap=160G --max-heap=160G --J=-XX:+UseConcMarkSweepGC --J=-XX:+CMSClassUnloadingEnabled --J=-XX:CMSInitiatingOccupancyFraction=75 --J=-Xloggc:gc${1}.log --J=-XX:+PrintGCDetails --J=-XX:+PrintGCDateStamps --J=-XX:+PrintGCTimeStamps --J=-XX:+PrintTenuringDistribution"


