#!/bin/bash

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

cat > ${OUTPUT_DIR}/service-account-csr.json <<EOF
{
  "CN": "service-accounts",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
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
   service-account-csr.json | cfssljson -bare service-account)
