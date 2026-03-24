
variable "customer"      { default = "customer" }
variable "instance_type" { default = "t2.micro"   }

variable "ami_id" {}

variable "lb_target_group_arn" {}

variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}

variable "ssm_path"  { default = "/app/asg/ami"   }

variable "user_data" { default = "" }

variable "tags" {
  type    = map(string)
  default = {}
}
