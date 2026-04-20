# vscode-modelines
# vim: set ft=terraform:

data "aws_ami" "ami" {
  most_recent = true
  owners      = [var.ami_owners]

  filter {
    name   = "name"
    values = ["${var.ami_name}*"]
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

output "data_ami" { value = data.aws_ami.ami }
