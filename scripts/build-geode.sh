#!/bin/bash

set -x

sudo apt update
sudo apt install -y openjdk-8-jdk

cd ~
rm -rf geode
git clone https://github.com/apache/geode.git

cd geode
./gradlew clean
./gradlew build -x test


