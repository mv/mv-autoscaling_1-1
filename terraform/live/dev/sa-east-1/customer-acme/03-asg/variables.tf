
variable "customer"      { default = "acme" }
variable "vpc_id"        { default = "" }

variable "instance_type" { default = "t3.medium"   }
variable "ami_id"        { default = "" } # default: use from 'ssm:parameter'

variable "key_name"      { default = "" }

variable "lb_target_group_arn" { default = "" }

# variable "vpc_zone_identifier" {
#   type = list(string)
#   default = []
# }

variable "user_data" { default = "" }

# self discovery (using ../common.auto.tfvars)
variable "vpc_name_tag"    { default = "" }
variable "subnet_priv_tag" { default = "" }
