#!/bin/sh

cd `dirname $0`

./1000-admin-kubeconfig.sh
./1001-verify-admin-kubeconfig.sh

