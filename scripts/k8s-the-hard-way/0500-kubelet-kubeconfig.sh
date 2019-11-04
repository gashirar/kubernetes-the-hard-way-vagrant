#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS=10.240.0.40

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

for instance in worker-0 worker-1 worker-2; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=${OUTPUT_DIR}/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${OUTPUT_DIR}/${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=${OUTPUT_DIR}/${instance}.pem \
    --client-key=${OUTPUT_DIR}/${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=${OUTPUT_DIR}/${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${instance} \
    --kubeconfig=${OUTPUT_DIR}/${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=${OUTPUT_DIR}/${instance}.kubeconfig
done
