
module "ssm-01" {
  source = "../../../../modules/ec2-ssm"

  name           = "ssm-01"
  instance_type  = "t3.micro"
  ami_id         = data.aws_ami.ami.id

  root_block_device = { "size" = 10, "type" = "gp3" }

# subnet_id = "subnet-0a4042aeb906e34c8"  # private-a
# subnet_id = "subnet-0a9395c0807e346b6"  # private-b
  subnet_id = data.aws_subnets.priv.ids[0]

# key_name       = "ec2-ssm-01-key"
# key_ssm_path   = "/mv/automation/keys/ec2-ssm-01"



  tags = {
    "mv:automation:env" = "dev"
    "mv:automation:app" = "ec2-ssm-01"
  }
}