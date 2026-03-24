
locals {
  module_tags = tomap({
    "mv:automation:module"      = "modules/ssm-parameter-ami"
    "mv:automation:module_type" = "resource"
  })
}
