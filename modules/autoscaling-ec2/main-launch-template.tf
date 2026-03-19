
# vscode-modelines
# vim: set ft=terraform:

resource "aws_launch_template" "lt" {

  name = var.name

  instance_type = var.instance_type
  key_name      = var.key_name
  image_id      = var.ami_id

  vpc_security_group_ids = [aws_security_group.sg.id]

  instance_initiated_shutdown_behavior = "terminate"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

  ebs_optimized = true

# disable_api_stop        = true
# disable_api_termination = true


# iam_instance_profile {
#   name = "test"
# }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

# network_interfaces {
#   associate_public_ip_address = true
# }


  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      local.module_tags
    )
  }

# user_data = filebase64(var.user_data)
}