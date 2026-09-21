# AWS S3 Secure File Transfer Lab

Hands-on Cloud/DevOps project for secure file transfers to Amazon S3 using Linux, AWS IAM, Python, Bash, rclone, Terraform, and CloudWatch.

## Project Overview

This project demonstrates a secure file-transfer workflow between an Ubuntu EC2 instance and Amazon S3.

The environment uses IAM roles instead of static AWS credentials, least-privilege permissions, encrypted storage, automated file uploads, checksum verification, monitoring, and Infrastructure as Code.

## Architecture

```text
MacBook
   |
   | SSH
   v
Ubuntu EC2
   |
   | IAM Role
   |
   +---- Bash upload script
   +---- Python / boto3
   +---- rclone
   |
   v
Amazon S3
   |
   +---- File storage
   +---- SHA-256 checksums

CloudWatch ----> SNS ----> Email alerts

Terraform ----> Infrastructure configuration
GitHub    ----> Source control
```

## AWS Services

- Amazon EC2
- Amazon S3
- AWS IAM
- Amazon CloudWatch
- Amazon SNS

## Security

The project follows several AWS security practices:

- EC2 uses an IAM role instead of stored AWS access keys.
- IAM permissions follow the principle of least privilege.
- The EC2 role can list, upload, and download S3 objects.
- S3 object deletion is not permitted.
- SSH access is restricted to a specific public IP address.
- EC2 Instance Metadata Service requires IMDSv2.
- EBS storage is encrypted.
- S3 uploads use server-side encryption.
- Private keys, Terraform state, and credentials are excluded from Git.

## Automation

### Bash

`scripts/upload-to-s3.sh`

Uploads files to S3 and generates SHA-256 checksums for integrity verification.

### Python

`scripts/upload_to_s3.py`

Uses Python and boto3 to:

- validate the input file
- calculate SHA-256
- create a checksum file
- upload the file to Amazon S3
- upload the checksum to Amazon S3

No static AWS credentials are stored in the script.

### rclone

rclone is configured to access S3 through the EC2 IAM role rather than static access keys.

Upload and download operations were tested successfully.

## IAM Least-Privilege Testing

The EC2 IAM role allows:

```text
s3:ListBucket
s3:GetObject
s3:PutObject
```

A negative security test confirmed that object deletion is denied with `AccessDenied`.

## Monitoring

Amazon CloudWatch monitors EC2 CPU utilization.

A CloudWatch alarm is configured to trigger when CPU utilization exceeds 80%.

Notifications are delivered through Amazon SNS email alerts.

## Terraform

Terraform is used to manage infrastructure configuration as code.

The existing S3 bucket was imported into Terraform rather than recreated.

Terraform validation and planning confirmed that the managed S3 configuration matches the existing AWS infrastructure.

Terraform state files are intentionally excluded from Git.

## Repository Structure

```text
aws-s3-transfer-lab/
├── README.md
├── scripts/
│   ├── upload-to-s3.sh
│   └── upload_to_s3.py
└── terraform/
    ├── main.tf
    └── .terraform.lock.hcl
```

## Technologies

AWS · Linux · Ubuntu · S3 · EC2 · IAM · CloudWatch · SNS · Python · boto3 · Bash · rclone · Terraform · Git · GitHub

## Result

The project provides a working secure file-transfer workflow with:

- least-privilege AWS access
- automated Bash and Python uploads
- SHA-256 integrity verification
- S3 encryption
- monitoring and alerting
- Infrastructure as Code
- Git-based version control
