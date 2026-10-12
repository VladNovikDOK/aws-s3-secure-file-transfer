data "aws_iam_policy_document" "s3_transfer" {
  statement {
    sid    = "VisualEditor0"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.transfer_lab.arn,
      "${aws_s3_bucket.transfer_lab.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_transfer" {
  name   = "S3TransferLabPolicy"
  description = "Least privilege access for AWS S3 Transfer Lab. Allows listing the bucket and uploading and downloading objects."
  policy = data.aws_iam_policy_document.s3_transfer.json
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "S3TransferLabEC2Role"
description = "Allows EC2 instances to call AWS services on your behalf."
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_role_policy_attachment" "s3_transfer" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.s3_transfer.arn
}

resource "aws_iam_instance_profile" "ec2" {
  name = "S3TransferLabEC2Role"
  role = aws_iam_role.ec2.name
}
