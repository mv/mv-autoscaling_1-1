
module "parameter_ami" {
  source  = "../../../../../modules/ssm-parameter-ami"

  ssm_path = "/app/asg/${var.customer}/ami"
  ami_id   = var.ami_id

  tags = {
    "asg:env"      = "dev"
    "asg:customer" = var.customer
  }

}
