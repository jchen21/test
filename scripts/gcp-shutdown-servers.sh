#!/bin/bash

set -x

gcloud compute ssh geode-vm-0 --command "~/test/scripts/shutdown-servers.sh"

