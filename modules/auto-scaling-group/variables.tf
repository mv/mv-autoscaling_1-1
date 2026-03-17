
variable "name"          { default = "asg-example" }
variable "description"   { default = "asg-description" }

variable "instance_type" { default = "t3.micro"   }

variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
