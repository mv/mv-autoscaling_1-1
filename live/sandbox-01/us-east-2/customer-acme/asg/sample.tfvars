##
## tfvars: sample
##

customer      = "customer"
instance_type = "t3.micro"

nlb_id = "arn:aws:elasticloadbalancing:..."
ami_id = "ami-0123..."

vpc_zone_identifier = [
  "subnet-0a",  # private-a
  "subnet-0b"   # private-b
]
