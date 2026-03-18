

variable "ssm_path" { default = "/app/asg/ami"   }
variable "ami_id"   { default = "" }

variable "tags" {
  type    = map(string)
  default = {}
}
