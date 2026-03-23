# vscode-modelines
# vim: set ft=terraform:

locals {
  name     = "asg-${var.customer}"  # "sitef-${var.name}"
  name_cap = "ASG-${var.customer}"  # "SiTef-${var.name}"
  descr    = "asg: ${var.customer}" # "SiTef: ${var.name}"

  asg_enabled_metrics = [
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}


resource "aws_autoscaling_group" "asg" {
  name             = local.name
  min_size         = 1
  max_size         = 1
  desired_capacity = 1

# default_cooldown        = 10    # in seconds
# default_instance_warmup = 10    # in seconds
# wait_for_capacity_timeout = 10  # in minutes

  # min:     86,400s = 1d
  # max: 31,536,000s = 365d
  max_instance_lifetime = 31536000


  health_check_type         = "EC2"  # EC2, ELB, EBS
  health_check_grace_period = 300
# force_delete              = true

  # ASG: extra group metrics to collect
  # Ref:
  #  https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-metrics.html
  enabled_metrics = var.asg_enabled_metrics ? local.asg_enabled_metrics : []


  vpc_zone_identifier = var.vpc_zone_identifier
  target_group_arns   = [ var.lb_target_group_arn ]

# # LB: via Traffic source attachment
# traffic_source_attachments = {
#   nlb = {
#     traffic_source_type       = "elbv2" # default
#     traffic_source_identifier = var.lb_target_group_arn
#     traffic_source_identifier = module.alb.target_groups["ex_asg"].arn
#   }
# }


  launch_template {
    id      = aws_launch_template.lt.id
    version = aws_launch_template.lt.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      auto_rollback   = true
      instance_warmup = 300  # default: health_check_grace_period
    }

#   alarm_specification {
#     alarms = {}

#   triggers = ["tag"]
#   }

# triggers = ["tag"]

#   preferences { min_healthy_percentage = 50 }
  }

# instance_maintenance_policy {
#   min_healthy_percentage = 90
#   max_healthy_percentage = 120
# }

  # initial_lifecycle_hook
  # aws_autoscaling_lifecycle_hook

  dynamic "tag" {
    for_each = merge(var.tags,local.module_tags)
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

}

## LB: via Traffic source attachment
## resource "aws_autoscaling_traffic_source_attachment" "traffic" {
##   region = local.region
##
##   autoscaling_group_name = aws_autoscaling_group.asg.name
##
##   traffic_source {
##     type       = "elbv2" # default
##     identifier = var.lb_target_group_arn
##   }
## }
