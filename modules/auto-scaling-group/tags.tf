
locals {
  module_tags = tomap({
    "mv:automation:module"      = "modules/auto-scaling-group"
    "mv:automation:module_type" = "resource"
  })
}
