#!/bin/sh

cd `dirname $0`

./0500-kubelet-kubeconfig.sh
./0501-kube-proxy-kubeconfig.sh
./0502-kube-controller-manager-kubeconfig.sh
./0503-kube-scheduler-kubeconfig.sh
./0504-admin-kubeconfig.sh
./0510-distribute-kubeconfig.sh

