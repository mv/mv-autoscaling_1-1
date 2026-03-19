
module "asg" {
  source = "../../../../../modules/autoscaling-ec2"

  customer            = var.customer
  instance_type       = var.instance_type
  ami_id              = var.ami_id

  lb_target_group_arn = var.lb_target_group_arn
  vpc_zone_identifier = var.vpc_zone_identifier

  ssm_path = "/app/asg/${var.customer}/ami"

# iam_role_policies = {
#   ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"               # SSM: parameter store
# }


  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
  EOT

  tags = {
    "asg:env"     = "dev"
    "asg:customer" = var.customer
  }

}
