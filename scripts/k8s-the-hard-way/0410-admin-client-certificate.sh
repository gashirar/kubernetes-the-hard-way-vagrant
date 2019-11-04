#!/bin/bash

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

cat > ${OUTPUT_DIR}/admin-csr.json <<EOF
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:masters",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

(cd ${OUTPUT_DIR} && \
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=ca-config.json \
   -profile=kubernetes \
   admin-csr.json | cfssljson -bare admin)
