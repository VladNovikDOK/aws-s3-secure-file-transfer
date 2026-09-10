import sys
import hashlib
from pathlib import Path

import boto3

BUCKET = "vladnovikdok-aws-s3-transfer-lab"


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 scripts/upload_to_s3.py <file>")
        sys.exit(1)

    file_path = Path(sys.argv[1])

    if not file_path.is_file():
        print(f"Error: file does not exist: {file_path}")
        sys.exit(1)

    checksum = hashlib.sha256(file_path.read_bytes()).hexdigest()
    checksum_path = Path(f"{file_path}.sha256")
    checksum_path.write_text(f"{checksum}  {file_path.name}\n")

    s3 = boto3.client("s3")

    s3.upload_file(str(file_path), BUCKET, file_path.name)
    s3.upload_file(str(checksum_path), BUCKET, checksum_path.name)

    print(f"Uploaded: {file_path.name}")
    print(f"Uploaded: {checksum_path.name}")
    print(f"SHA-256: {checksum}")


if __name__ == "__main__":
    main()
