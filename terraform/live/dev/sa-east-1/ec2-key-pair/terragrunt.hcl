
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "live" { path = find_in_parent_folders("live.hcl") }

terraform {
  source = "${include.root.locals.modules_path}/modules/ec2-key-pair"
}

inputs = {
  # ec2 key pair
  key_name = "inoa-${include.root.locals.account_name}-tst-01"
  ssm_path = "/app/${include.root.inputs.env}/tst/ec2-key-pair"

  tags = {
    "inoa:automation:live:live_dir" = path_relative_to_include("live")
    "inoa:automation:live:root_dir" = path_relative_to_include("root")
  }
}
