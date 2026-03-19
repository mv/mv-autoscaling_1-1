
# vscode-modelines
# vim: set ft=terraform:

resource "aws_launch_template" "lt" {
  name        = local.name
  description = "ASG: Launch Template: [${var.name}]"

  ##
  ## Instance
  ##
  instance_type = var.instance_type
  key_name      = var.key_name
  image_id      = var.ami_id

  iam_instance_profile {
    arn = aws_iam_instance_profile.profile.arn
  }

  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    instance_metadata_tags = "enabled"
  }

  user_data = var.user_data

  # detailed monitoring
  monitoring { enabled = var.detailed_monitoring }

  ##
  ## Network
  ##
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    description                 = "ENI: ASG: ${var.customer}"
  }

  vpc_security_group_ids = [aws_security_group.sg.id]

  ##
  ## Storage
  ##
  ebs_optimized = true

  ###
  ### Ref:
  ###   https://github.com/terraform-aws-modules/terraform-aws-autoscaling/blob/648715a2c789590b9bd1a98d03d021d6efef774e/main.tf#L676
  ###
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings != null ? var.block_device_mappings : []
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = block_device_mappings.value.no_device
#     virtual_name = block_device_mappings.value.virtual_name

      dynamic "ebs" {
        for_each = block_device_mappings.value.ebs != null ? [block_device_mappings.value.ebs] : []
        content {
          volume_size           = ebs.value.volume_size
          volume_type           = ebs.value.volume_type
          encrypted             = ebs.value.encrypted
          delete_on_termination = ebs.value.delete_on_termination
        } # content
      } # ebs

    } # content
  } # dynamic

  tags = merge(
    var.tags,
    local.module_tags
  )

# tag_specifications {
#   resource_type = "instance"
#   tags = {}
# }


}