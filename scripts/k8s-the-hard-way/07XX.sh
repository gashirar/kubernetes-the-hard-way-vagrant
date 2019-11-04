#!/bin/sh

cd `dirname $0`

for instance in controller-0 controller-1 controller-2; do
    find . -name "07*-*.sh" | xargs -I{} vagrant scp {} ${instance}:~/
done
