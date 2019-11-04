#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS=10.240.0.40

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=${OUTPUT_DIR}/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

kubectl config set-credentials admin \
  --client-certificate=${OUTPUT_DIR}/admin.pem \
  --client-key=${OUTPUT_DIR}/admin-key.pem

kubectl config set-context kubernetes-the-hard-way \
  --cluster=kubernetes-the-hard-way \
  --user=admin

kubectl config use-context kubernetes-the-hard-way
