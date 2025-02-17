#!/bin/bash

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

for instance in worker-0 worker-1 worker-2; do
cat > ${OUTPUT_DIR}/${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

EXTERNAL_IP=10.240.0.40

(cd ${OUTPUT_DIR} && \
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=ca-config.json \
   -hostname=${instance},${EXTERNAL_IP} \
   -profile=kubernetes \
   ${instance}-csr.json | cfssljson -bare ${instance})
done