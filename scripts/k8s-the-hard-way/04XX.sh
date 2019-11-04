#!/bin/sh

cd `dirname $0`

./0400-certificate-authority.sh
./0410-admin-client-certificate.sh
./0411-kubelet-client-certificates.sh
./0412-controller-manager-client-certfiicate.sh
./0413-kube-proxy-client-certificate.sh
./0414-scheduler-client-certificate.sh
./0415-kubernetes-api-server-certificate.sh
./0420-service-account-key-pair.sh
./0430-distribute-certificates.sh

