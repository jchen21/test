#!/bin/bash

set -x

gcloud compute ssh geode-vm-0 --command "~/test/scripts/create-region.sh"
