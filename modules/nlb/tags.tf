
locals {
  module_tags = tomap({
    "mv:automation:module"      = "modules/nlb"
    "mv:automation:module_type" = "wrapper"
  })
}
