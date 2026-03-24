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
  name = local.name

  ##
  ## Scaling
  ##
  min_size         = 1
  max_size         = 1
  desired_capacity = 1

  # https://docs.aws.amazon.com/autoscaling/ec2/userguide/instance-maintenance-policy-overview-and-considerations.html#instance-maintenance-policy-core-concepts
  # https://docs.aws.amazon.com/autoscaling/ec2/userguide/instance-refresh-overview.html#instance-refresh-core-concepts
  instance_maintenance_policy {
    # forces 'Launch Before Terminate': keeps 'desired' = 1
    min_healthy_percentage = 100  # 0-100 perc of 'desired_capacity'

    # forces 'Launch Before Terminate': allows 'desired' > 1
    max_healthy_percentage = 200  # 100-200 perc of 'desired_capacity'
  }


  # time before instance gets 'InService'
  default_instance_warmup = 300   # 300s = 5min
  # time before next Scaling activity
  default_cooldown        = 60    # in seconds

  # Terraform
  # Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#waiting-for-capacity
  wait_for_capacity_timeout = "10m" # default: 10m

  # Lifetime: automatic expiration/replacement
  # min:     86,400s = 1d
  # max: 31,536,000s = 365d
  max_instance_lifetime = 31536000 # in seconds


  health_check_type         = "EC2"  # EC2, ELB, EBS
  health_check_grace_period = 300
# force_delete              = true

  # ASG: extra group metrics to collect
  # Ref:
  #  https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-metrics.html
  enabled_metrics     = var.asg_enabled_metrics ? local.asg_enabled_metrics : []

# metrics_granularity = "1Minute"  # Default: 5min


  ##
  ## Networking
  ##
  vpc_zone_identifier = var.vpc_zone_identifier

  # LB: via Traffic source attachment
  traffic_source {
    type       = "elbv2" # default
    identifier = var.lb_target_group_arn
  }

# target_group_arns   = [ var.lb_target_group_arn ]


  ##
  ## EC2/Launch
  ##
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
#     alarms   = {}
#     triggers = ["tag"]
#   }
#   triggers = ["tag"]
#   preferences { min_healthy_percentage = 50 }
  }

  # initial_lifecycle_hook
  # aws_autoscaling_lifecycle_hook

  ##
  ## Tagging
  ##
  dynamic "tag" {
    for_each = merge(var.tags,local.module_tags)
    content {
      propagate_at_launch = true
      key   = tag.key
      value = tag.value
    }
  }

}
