#!/bin/sh

cd `dirname $0`

for instance in controller-0 controller-1 controller-2; do
    find . -name "07*-*.sh" | xargs -I{} -P3 vagrant scp {} ${instance}:~/
done

echo "_/_/_/_/_/_/ 0700 _/_/_/_/_/_/"
parallel --jobs 3  --results ../../workspace/  \
  'vagrant ssh {} -- ./0700-download-and-install-etcd.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0701 _/_/_/_/_/_/"
parallel --jobs 3  --results ../../workspace/ \
  'vagrant ssh {} -- ./0701-configure-etcd.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0702 _/_/_/_/_/_/"
parallel --jobs 3  --results ../../workspace/ \
  'vagrant ssh {} -- ./0702-start-etcd.sh' ::: controller-0 controller-1 controller-2

sleep 10
vagrant ssh controller-0 -- './0710-verify-etcd.sh'

