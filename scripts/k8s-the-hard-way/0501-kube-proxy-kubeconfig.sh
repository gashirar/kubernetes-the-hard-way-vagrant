#!/bin/bash

KUBERNETES_PUBLIC_ADDRESS=10.240.0.40

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=${OUTPUT_DIR}/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=${OUTPUT_DIR}/kube-proxy.kubeconfig

kubectl config set-credentials system:kube-proxy \
  --client-certificate=${OUTPUT_DIR}/kube-proxy.pem \
  --client-key=${OUTPUT_DIR}/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=${OUTPUT_DIR}/kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=system:kube-proxy \
  --kubeconfig=${OUTPUT_DIR}/kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=${OUTPUT_DIR}/kube-proxy.kubeconfig
