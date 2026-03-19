# vscode-modelines
# vim: set ft=terraform:

locals {
  name     = "asg-${var.customer}"  # "sitef-${var.name}"
  name_cap = "ASG-${var.customer}"  # "SiTef-${var.name}"
  descr    = "asg: ${var.customer}" # "SiTef: ${var.name}"
}

