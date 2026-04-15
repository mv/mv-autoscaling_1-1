
variable "customer" { default = "customer"  }

variable "vpc_id"  {}

# variable "subnets" {
#   type = list(string)
#   default = []
# }


# filter to discover subnet_id
variable "subnet_priv_tag" { default = "" }
