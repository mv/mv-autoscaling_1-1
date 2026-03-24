##
## tfvars: sample
##

name          = "asg-01"
instance_type = "t3.micro"

vpc_zone_identifier = [
  "subnet-0a",  # private-a
  "subnet-0b"   # private-b
]
