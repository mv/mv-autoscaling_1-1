locals {
  name     = "sitef-${var.name}"
  name_cap = "SiTef-${var.name}"
  descr    = "SiTef: ${var.name}"
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "9.2.0"

  # Autoscaling group
  name = local.name_cap

  vpc_zone_identifier       = var.vpc_zone_identifier

  ##
  ## Sitef: stateful
  ##
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"

  # Launch template

  ## Ref: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#use-an-ssm-parameter-instead-of-an-ami-id
  image_id      = "resolve:ssm:${aws_ssm_parameter.asg_ami.name}" # ??

# image_id      = data.aws_ami.al2023.id  # ??
  instance_type = var.instance_type

  launch_template_name        = local.name
  launch_template_description = local.descr
  update_default_version      = true          # ??

  ebs_optimized     = true
  enable_monitoring = true

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 10      # var.??
        volume_type           = "gp2"   # var.??
      }
    },
    {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = false
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp3"
      }
    }
  ]

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = local.name
  iam_role_description        = "${local.name} - IAM role"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", # SSM: start session access
    ReadOnlyAccess               = "arn:aws:iam::aws:policy/ReadOnlyAccess"                # read: tags,parameter store
  }

  # This will ensure imdsv2 is enabled, required, and a single hop which is aws security
  # best practices
  # See https://docs.aws.amazon.com/securityhub/latest/userguide/autoscaling-controls.html#autoscaling-4
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [aws_security_group.sg.id]
    }
  ]

  tag_specifications = [
    { resource_type = "instance",
      tags = {
        Name = local.name
      }
    },
    { resource_type = "volume"  ,
      tags = {
        Name = "${local.name}-${formatdate("YYYY-MM-DD-hh.mm.ss", timestamp())}"
      }
    },
  ]

  tags = merge(
    var.tags,
    local.module_tags
  )

}