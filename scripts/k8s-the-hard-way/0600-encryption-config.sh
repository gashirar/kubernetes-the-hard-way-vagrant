#!/bin/bash

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

OUTPUT_DIR=${K8STHW_WORKSPACE:-.}

cat > ${OUTPUT_DIR}/encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF
