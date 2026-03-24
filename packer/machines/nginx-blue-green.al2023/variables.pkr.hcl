# vscode-modelines
# vim: set ft=hcl:

variable "region"        { default = "us-east-2" }
variable "instance_type" { default = "t3.micro" }


##
## must be set via env vars
##   $ source ./variables.sh
##
variable "vpc_id"    { type = string }
variable "subnet_id" { type = string }
variable "sg_id"     { type = string }

variable "iam_instance_profile" { type = string }

##
## deploy
##
variable "release" {
  type    = string
  default = "test"
}
