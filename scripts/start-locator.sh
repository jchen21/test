#!/bin/bash

set -x

# start locator
~/geode/geode-assembly/build/install/apache-geode/bin/gfsh -e "start locator --name=locator"


