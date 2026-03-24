
variable "name"          { default = "asg-01" }
variable "instance_type" { default = "t3.micro"   }

variable "vpc_zone_identifier" {
  type = list(string)
  default = []
}