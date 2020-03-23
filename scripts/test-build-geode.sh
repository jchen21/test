#!/bin/bash

set -x

hostname=$(hostname)
test -f ~/geode/geode-assembly/build/install/apache-geode/bin/gfsh
test $? -eq 0 && echo "Geode build successful on ${hostname}" || echo "Geode build failed on ${hostname}"
