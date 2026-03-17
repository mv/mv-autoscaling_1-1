
locals {
  module_tags = tomap({
    "mv:automation:module"      = "modules/ec2-ssm"
    "mv:automation:module_type" = "resource"
  })
}
