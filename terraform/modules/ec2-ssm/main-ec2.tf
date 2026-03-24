
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"

  name          = var.name
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  ami           = data.aws_ami.al2023.id

# root_block_device = var.root_block_device

  key_name = var.key_name

  # IMDSv2
  metadata_options = {
    "http_endpoint": "enabled",
    "http_tokens": "required"
  }

  # My SG
  vpc_security_group_ids = [aws_security_group.sg.id]

  ## SSM
  create_iam_instance_profile = true
  iam_role_description        = "IAM role: ${var.name} EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" # SSM: console access
    ReadOnlyAccess               = "arn:aws:iam::aws:policy/ReadOnlyAccess"               # SSM: parameter store
  }

  tags = merge(
    var.tags,
    local.module_tags
  )

  ## just in case
  user_data = <<-EOF
  #!/usr/bin/env bash

  set -x

  yum update -y

  yum install -y htop wget

  wget -O /usr/local/bin/tcping https://github.com/Tcp-Ping/Tcping/releases/download/v0.1.1/linux-amd64-tcping

  chmod 775 /usr/local/bin/*

  EOF
}
