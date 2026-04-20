
locals {
  module_tags = tomap({
    "inoa:automation:module"      = "modules/ec2-key-pair"
    "inoa:automation:module_type" = "resource"
  })
}
