
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  ##
  ## NLB
  ##
  load_balancer_type = "network"
  name               = var.nlb_name
  vpc_id             = var.vpc_id  # "vpc-abcde012"
  subnets            = var.subnets # ["subnet-abcde012", "subnet-bcde012a"]

  enable_deletion_protection = var.enable_deletion_protection

  ##
  ## Listener(s) / Target Group(s)
  ##
  listeners = {
    tcp_80 = {
      port     = 80
      protocol = "TCP"
      forward = { target_group_key = "target_80" }
    }

    tcp_443 = {
      port     = 443
      protocol = "TCP"
      forward = { target_group_key = "target_443" }
    }

  }

  target_groups = {
    target_80 = {
      name_prefix = "tg80-"
      protocol    = "TCP"
      port        = 80
      vpc_id      = var.vpc_id

      create_attachment = false
    }

    target_443 = {
      name_prefix = "tg443-"
      protocol    = "TCP"
      port        = 443
      vpc_id      = var.vpc_id

      create_attachment = false
    }

  }

  ##
  ## LB: Security Group
  ##
  enforce_security_group_inbound_rules_on_private_link_traffic = "on"
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0" # "10.0.0.0/16"
    }
  }

  ##
  ## TODO: LB Access Logs
  ##
# access_logs = {
#   bucket = "my-nlb-logs"
# }

}

##
## Security Group: Tag Name
##
resource "aws_ec2_tag" "nlb_sg_name" {
  resource_id = module.nlb.security_group_id
  key         = "Name"
  value       = var.nlb_name
}
