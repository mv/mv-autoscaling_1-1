
module "nlb" {
  source  = "../../../../../modules/nlb"

  nlb_name = "nlb-${var.customer}"
  vpc_id   = var.vpc_id  # "vpc-abcde012"
  subnets  = var.subnets # ["subnet-abcde012", "subnet-bcde012a"]

  enable_deletion_protection = false

  # https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-health-checks.html#health-check-settings
  # Defaults:
  #   Timeout   10s TCP / 6s HTTP
  #   Interval  30s
  #
  #   Healthy Threshold Count   5 : (10s timeout + 30s interval) x 5 = 200s 3m20s
  #   UnHealthy Threshold Count 2 : (10s timeout + 30s interval) x 2 =  80s 1m20s
  #
  health_check = {
    enabled             = true
    protocol            = "TCP"
    timeout             = 6
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    "sitef:env"      = "dev"
    "sitef:customer" = var.customer
  }


}
