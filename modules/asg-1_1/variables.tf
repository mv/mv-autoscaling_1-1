
variable "name"          { default = "asg-sitef" }
variable "description"   { default = "asg-sitef" }

variable "instance_type" { default = "t2.micro"   }

variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}

variable "ssm_path" { default = "/app/asg/ami"   }

variable "tags" {
  type    = map(string)
  default = {}
}
