#!/bin/bash
set -e
BUCKET="vladnovikdok-aws-s3-transfer-lab"
FILE="$1"
if [ -z "$FILE" ]; then
  echo "Usage: $0 <file>"
  exit 1
fi
if [ ! -f "$FILE" ]; then
    echo "Error: file does not exist: $FILE"
    exit 1
fi
aws s3 cp "$FILE" "s3://$BUCKET/"
sha256sum "$FILE" > "$FILE.sha256"
aws s3 cp "$FILE.sha256" "s3://$BUCKET/"

