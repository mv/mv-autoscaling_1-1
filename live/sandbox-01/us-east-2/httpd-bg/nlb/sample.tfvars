##
## tfvars: sample
##

customer = "bg-01"
#lb_name = "nlb-${var.customer}"
vpc_id   = "vpc_vpcid"

subnets = [
  "subnet-0a",  # public-a
  "subnet-0b",  # public-b
  "subnet-0c"   # public-c
]
