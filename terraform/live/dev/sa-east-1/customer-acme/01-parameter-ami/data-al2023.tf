# vscode-modelines
# vim: set ft=terraform:

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"] # Amazon Linux 2023
    #   values = ["al2023-ami-minimal-*"]   # Amazon Linux 2023: minimal
    #   values = ["amzn2-ami-minimal-hvm*"] # Amazon Linux 2
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
