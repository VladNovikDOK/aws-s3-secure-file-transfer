#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y \
  python3 \
  python3-venv \
  python3-pip \
  rclone \
  coreutils \
  ca-certificates

python3 -m venv /opt/s3-transfer-venv
/opt/s3-transfer-venv/bin/pip install --upgrade pip
/opt/s3-transfer-venv/bin/pip install boto3

echo "Python: $(python3 --version)"
echo "rclone: $(rclone version | head -n 1)"
echo "SHA-256: $(sha256sum --version | head -n 1)"
echo "boto3: $(/opt/s3-transfer-venv/bin/python -c 'import boto3; print(boto3.__version__)')"
