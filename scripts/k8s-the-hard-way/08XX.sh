#!/bin/sh

cd `dirname $0`

for instance in controller-0 controller-1 controller-2; do
    find . -name "08*-*.sh" | xargs -I{} vagrant scp {} ${instance}:~/
done

echo "_/_/_/_/_/_/ 0800 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0800-download-and-install-k8s-controllers.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0801 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0801-configure-k8s-api-server.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0802 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0802-configure-k8s-controller-manager.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0803 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0803-configure-k8s-schedueler.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0804 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0804-start-controller-services.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0805 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0805-verify.sh' ::: controller-0 controller-1 controller-2

echo "_/_/_/_/_/_/ 0810 _/_/_/_/_/_/"
vagrant ssh controller-0 -- './0810-rbac-for-kubelet-auth.sh'

echo "_/_/_/_/_/_/ 0820 _/_/_/_/_/_/"
./0820-verify-frontend-lb.sh
