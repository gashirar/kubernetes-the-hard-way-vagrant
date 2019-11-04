#!/bin/bash

# This script assumes you have the vagrant-scp plugin installed

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

for instance in controller-0 controller-1 controller-2; do
  vagrant scp ${OUTPUT_DIR}/encryption-config.yaml ${instance}:~/
done
