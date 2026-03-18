
module "nlb" {
  source  = "../../../../../modules/nlb"

  nlb_name = "nlb-${var.customer}"
  vpc_id   = var.vpc_id  # "vpc-abcde012"
  subnets  = var.subnets # ["subnet-abcde012", "subnet-bcde012a"]

  enable_deletion_protection = false

  tags = {
    "sitef:env"      = "dev"
    "sitef:customer" = var.customer
  }


}
