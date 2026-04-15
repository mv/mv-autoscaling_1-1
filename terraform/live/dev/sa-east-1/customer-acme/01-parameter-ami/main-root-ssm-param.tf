
module "parameter_ami" {
  source  = "../../../../../modules/ssm-parameter-ami"

  ssm_path = "/app/asg/${var.customer}/ami"
  ami_id   = coalesce(var.ami_id, data.aws_ami.al2023.image_id)

  tags = {
    "asg:env"      = "dev"
    "asg:customer" = var.customer
  }

}
