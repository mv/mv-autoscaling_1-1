# vscode-modelines
# vim: set ft=terraform:

data "aws_subnet" "subnet" {
# id = var.subnet_id
  id = var.vpc_zone_identifier[0]
}
