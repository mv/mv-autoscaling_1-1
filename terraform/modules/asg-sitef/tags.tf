
locals {
  module_tags = tomap({
    "sitef:tf:module"      = "modules/auto-scaling-group"
    "sitef:tf:module_type" = "resource"
  })
}
