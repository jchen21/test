#!/bin/bash

set -x

cd ~/test
git pull -r
./gradlew clean
./gradlew build
./gradlew run
