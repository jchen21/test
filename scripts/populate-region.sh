#!/bin/bash

set -x

cd ~/test
./gradlew clean
./gradlew build
./gradlew run
