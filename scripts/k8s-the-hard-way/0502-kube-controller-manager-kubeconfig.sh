#!/bin/bash

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=${OUTPUT_DIR}/ca.pem \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=${OUTPUT_DIR}/kube-controller-manager.kubeconfig

kubectl config set-credentials system:kube-controller-manager \
  --client-certificate=${OUTPUT_DIR}/kube-controller-manager.pem \
  --client-key=${OUTPUT_DIR}/kube-controller-manager-key.pem \
  --embed-certs=true \
  --kubeconfig=${OUTPUT_DIR}/kube-controller-manager.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=system:kube-controller-manager \
  --kubeconfig=${OUTPUT_DIR}/kube-controller-manager.kubeconfig

kubectl config use-context default --kubeconfig=${OUTPUT_DIR}/kube-controller-manager.kubeconfig
