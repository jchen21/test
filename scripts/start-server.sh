#!/bin/bash

set -x

# start server
~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "start server --name=server${1} --locators=geode-vm-0.c.data-g2c.internal[10334]"


