
variable "customer"      { default = "acme" }
variable "instance_type" { default = "t3.micro"   }

variable "ami_id" {}

variable "lb_target_group_arn" {}

variable "vpc_zone_identifier" {
  type = list(string)
  default = []
}

variable "user_data" { default = "" }
