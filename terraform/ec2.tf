data "aws_instance" "existing" {
  instance_id = "i-040afe9ac598f147d"
}

resource "aws_instance" "transfer" {
  ami                    = data.aws_instance.existing.ami
  user_data = file("${path.module}/../scripts/setup-ec2.sh")
  instance_type          = "t3.micro"
  key_name               = "S3TransferLab-Key"
  subnet_id              = "subnet-0cafc7935ef7e686d"
  vpc_security_group_ids = ["sg-00eb3dc58a1b42c91"]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "S3TransferLab-EC2"
  }
}
