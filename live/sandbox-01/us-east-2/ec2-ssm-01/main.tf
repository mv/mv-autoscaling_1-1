
module "ssm-01" {
  source = "../../../../modules/ec2-ssm"

  name           = "ssm-01"
  instance_type  = "t3.micro"

  root_block_device = { "size" = 10, "type" = "gp3" }

  subnet_id   = "subnet-0a4042aeb906e34c8"  # private-a

# key_name       = "ec2-ssm-01-key"
# key_ssm_path   = "/mv/automation/keys/ec2-ssm-01"



  tags = {
    "mv:automation:env" = "sandbox-01"
    "mv:automation:app" = "ec2-ssm-01"
  }
}