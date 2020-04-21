#!/bin/bash

set -x

sudo apt update
sudo apt install -y openjdk-8-jdk

java -version
while [ $? -ne 0]  
do
  sudo apt update
  sudo apt install -y openjdk-8-jdk
done

cd ~
rm -rf geode
git clone https://github.com/jchen21/geode.git
#git clone https://github.com/apache/geode.git

cd geode
git checkout disk-recovery-perf-2
./gradlew clean
./gradlew build -x test


