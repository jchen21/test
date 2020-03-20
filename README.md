# Steps:

Note: use the same `num` for the following steps. e.g. if `num` is 2, it will start 3 GCP VMs:
`geode-vm-0`, `geode-vm-1` and `geode-vm-2`. `geode-vm-0` is for Apache Geode locator and client. 
`geode-vm-1` and `geode-vm-2` are for Apache Geode servers, one server per VM.

## Provision GCP VMs:

`./start-gcp-vms.sh <num>`

## git clone Apache Geode and build it on the GCP VMs:

`./gcp-build-geode.sh <num>`

## Start the Apache Geode locator on GCP VM `geode-vm-0`:

`./gcp-start-locator.sh`

## Start the Apache Geode servers on GCP VMs `geode-vm-1`, `geode-vm-2` etc:

`./gcp-start-servers.sh <num>`    

## Create a persistent partitioned region named `testRegion`:

`./gcp-create-region.sh`
 
## Populate the region with an Apache Geode client application:

`./gcp-populate-region.sh`

## Shutdown all the servers, but not the locator:

`./gcp-shutdown-servers.sh`

## Restart the servers and recover the data from persistent disk

You can time this step:
`./gcp-start-servers.sh <num>`

## Delete all GCP VMs

`./delete-gcp-vms.sh <num>`