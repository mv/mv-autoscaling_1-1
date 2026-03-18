
locals {
  module_tags = tomap({
    "asg:tf:module"      = "modules/asg-1_1"
    "asg:tf:module_type" = "wrapper"
  })
}
