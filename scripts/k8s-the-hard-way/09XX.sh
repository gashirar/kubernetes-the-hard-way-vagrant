#!/bin/sh

cd `dirname $0`

for instance in worker-0 worker-1 worker-2; do
    find . -name "09*-*.sh" | xargs -I{} vagrant scp {} ${instance}:~/
done

echo "_/_/_/_/_/_/ 0900 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0900-download-and-install-workers.sh' ::: worker-0 worker-1 worker-2

echo "_/_/_/_/_/_/ 0901 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0901-configure-cni.sh' ::: worker-0 worker-1 worker-2

echo "_/_/_/_/_/_/ 0902 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0902-configure-containerd.sh' ::: worker-0 worker-1 worker-2

echo "_/_/_/_/_/_/ 0903 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0903-configure-kubelet.sh' ::: worker-0 worker-1 worker-2

echo "_/_/_/_/_/_/ 0904 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0904-configure-kube-proxy.sh' ::: worker-0 worker-1 worker-2

echo "_/_/_/_/_/_/ 0905 _/_/_/_/_/_/"
parallel --jobs 3  \
  'vagrant ssh {} -- ./0905-start-worker-services.sh' ::: worker-0 worker-1 worker-2

sleep 10
echo "_/_/_/_/_/_/ 0910 _/_/_/_/_/_/"
./0910-verify-worker.sh

