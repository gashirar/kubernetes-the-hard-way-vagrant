#!/bin/bash

# This script assumes you have the vagrant-scp plugin installed

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

for instance in worker-0 worker-1 worker-2; do
  vagrant scp ${OUTPUT_DIR}/${instance}.kubeconfig ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/kube-proxy.kubeconfig ${instance}:~/
done

for instance in controller-0 controller-1 controller-2; do
  vagrant scp ${OUTPUT_DIR}/admin.kubeconfig ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/kube-controller-manager.kubeconfig ${instance}:~/
  vagrant scp ${OUTPUT_DIR}/kube-scheduler.kubeconfig ${instance}:~/
done
