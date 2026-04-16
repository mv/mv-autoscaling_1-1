
variable "customer" { default = "customer"  }
variable "vpc_id"   { default = "" }

# variable "subnets" {
#   type = list(string)
#   default = []
# }


# self discovery (using ../common.auto.tfvars)
variable "vpc_name_tag"    { default = "" }
variable "subnet_priv_tag" { default = "" }
