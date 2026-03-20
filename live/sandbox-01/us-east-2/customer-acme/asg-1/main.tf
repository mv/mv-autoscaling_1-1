
module "asg" {
  source = "../../../../../modules/autoscaling-ec2"

  customer            = var.customer
  instance_type       = var.instance_type
  ami_id              = var.ami_id

  lb_target_group_arn = var.lb_target_group_arn
  vpc_zone_identifier = var.vpc_zone_identifier

  ami_ssm_path = "/app/asg/${var.customer}/ami"

  block_device_mappings = [
    {
      device_name  = "/dev/xvda"     # root: by AMI: PV:/dev/sda1|HVM: /dev/xvda
      no_device    = 0
      ebs = {
        volume_size = 10
        volume_type = "gp3"
        encrypted   = false
        delete_on_termination = true
      }
    },
    {
      device_name  = "/dev/xvdb"     # data: by type: PV: from /dev/sdf|HVM: from /dev/xvdb onwards
      no_device    = 1
      ebs = {
        volume_size = 20
        volume_type = "gp3"
        encrypted   = false
        delete_on_termination = true
      }
    }
  ]

##
## Launch Template: deploy stuff

# iam_role_policies = {
#   ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"               # SSM: parameter store
# }


# user_data = ""
# user_data = filebase64(var.user_data)

  tags = {
    "asg:env"     = "dev"
    "asg:customer" = var.customer
  }

}
