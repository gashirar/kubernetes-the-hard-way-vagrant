#!/bin/bash

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=${OUTPUT_DIR}/ca.pem \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=${OUTPUT_DIR}/admin.kubeconfig

kubectl config set-credentials admin \
  --client-certificate=${OUTPUT_DIR}/admin.pem \
  --client-key=${OUTPUT_DIR}/admin-key.pem \
  --embed-certs=true \
  --kubeconfig=${OUTPUT_DIR}/admin.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=admin \
  --kubeconfig=${OUTPUT_DIR}/admin.kubeconfig

kubectl config use-context default --kubeconfig=${OUTPUT_DIR}/admin.kubeconfig
