# vscode-modelines
# vim: set ft=terraform:


##
## ASG
##
variable "min_size"         { default = "1" }
variable "max_size"         { default = "1" }
variable "desired_capacity" { default = "1" }

##
## Launch Template: EC2 stuff
##

variable "name"          { default = "example-lt"   }
variable "instance_type" { default = "t2.micro"   }
variable "ami_id"        { default = "" }
variable "key_name"      { default = "" }
variable "sg_id"         { default = "" }

variable "iam_role_policies" {
  type = map(string)
  default = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" # SSM: console access
    ReadOnlyAccess               = "arn:aws:iam::aws:policy/ReadOnlyAccess"               # SSM: parameter store
  }
}


variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}

##
## Launch Template: LB
##
variable "lb_target_group_arn" { default = ""}

##
## Launch Template: deploy stuff
##
variable "customer"  { default = "customer" }
variable "ssm_path"  { default = "/app/asg/ami"   }
variable "user_data" { default = "" }


variable "tags" {
  type    = map(string)
  default = {}
}
