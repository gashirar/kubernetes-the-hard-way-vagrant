#!/bin/sh

cd `dirname $0`

./0600-encryption-config.sh
./0610-distribute-encryption-config.sh

