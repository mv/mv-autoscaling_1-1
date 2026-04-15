# vscode-modelines
# vim: set ft=terraform:

data "aws_subnet" "subnet" {
# id = var.subnet_id
  id = var.subnets[0]
}
