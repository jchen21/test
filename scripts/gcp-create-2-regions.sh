#!/bin/bash

set -x

gcloud compute ssh geode-vm-0 --command "~/test/scripts/create-2-regions.sh"
