#!/bin/bash

kubectl run busybox --image=busybox:1.28 --command -- sleep 3600

sleep 10
kubectl get pods -l run=busybox
# watch kubectl get pods -l run=busybox
