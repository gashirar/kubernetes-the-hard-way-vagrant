#!/bin/bash

# This script assumes you have the vagrant-scp plugin installed

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

for instance in worker-0 worker-1 worker-2; do
  vagrant scp ${OUTPUT_DIR}/ca.pem ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/${instance}-key.pem ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/${instance}.pem ${instance}:~/
done

for instance in controller-0 controller-1 controller-2; do
  vagrant scp ${OUTPUT_DIR}/ca.pem ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/ca-key.pem ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/kubernetes-key.pem ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/kubernetes.pem ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/service-account-key.pem ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/service-account.pem ${instance}:~/
done