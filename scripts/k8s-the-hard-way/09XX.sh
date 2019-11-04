#!/bin/sh

cd `dirname $0`

for instance in worker-0 worker-1 worker-2; do
    find . -name "09*-*.sh" | xargs -I{} vagrant scp {} ${instance}:~/
done
