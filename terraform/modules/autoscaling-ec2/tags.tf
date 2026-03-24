# vscode-modelines
# vim: set ft=terraform:


locals {
  module_tags = tomap({
    "asg:tf:module"      = "modules/autoscaling-ec2"
    "asg:tf:module_type" = "wrapper"
  })
}
