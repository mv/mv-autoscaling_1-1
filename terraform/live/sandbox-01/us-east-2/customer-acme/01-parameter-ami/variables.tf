
variable "customer" { default = "acme" }
variable "ssm_path" { default = "/app/asg/ami"   }

variable "ami_id"   {}

variable "tags" {
  type    = map(string)
  default = {}
}
