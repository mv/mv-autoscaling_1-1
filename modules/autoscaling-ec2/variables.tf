# vscode-modelines
# vim: set ft=terraform:


##
## ASG
##
variable "min_size"         { default = "1" }
variable "max_size"         { default = "1" }
variable "desired_capacity" { default = "1" }
variable "ami_ssm_path"     { default = "/app/asg/ami"   }

##
## ASG: LB
##
variable "lb_target_group_arn" { default = "" }

variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}



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
  default = {}
}

## Ref:
##   https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html
##   https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html
##
##   https://github.com/terraform-aws-modules/terraform-aws-autoscaling/blob/648715a2c789590b9bd1a98d03d021d6efef774e/examples/complete/main.tf#L125
##   https://github.com/terraform-aws-modules/terraform-aws-autoscaling/blob/648715a2c789590b9bd1a98d03d021d6efef774e/variables.tf#L396
##
variable "block_device_mappings" {
  type = list(any)
  default = [
    {
      device_name = "/dev/xvda"    # root: by AMI: PV:/dev/sda1|HVM: /dev/xvda
      no_device   = "0"
      ebs = {
        volume_size = 10
        volume_type = "gp3"
        encrypted   = false
        delete_on_termination = true
      }
    },
    {
      device_name = "/dev/xvdb"     # data: by type: PV: from /dev/sdf|HVM: from /dev/xvdb onwards
      no_device   = "1"
      ebs = {
        volume_size = 20
        volume_type = "gp3"
        encrypted   = false
        delete_on_termination = true
      }
    }
  ]
}

##
## Launch Template: deploy stuff
##
variable "customer"  { default = "customer" }
variable "user_data" { default = "" }

variable "detailed_monitoring" {
  type    = bool
  default = false
}


variable "tags" {
  type    = map(string)
  default = {}
}
