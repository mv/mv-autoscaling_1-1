
module "key_pair" {
  source = "../../../../modules/ec2-key-pair"

  key_name = "asg-key-pair"
  ssm_path = "/app/asg/key-pair"

  tags = {
    "asg:env"     = "dev"
  }

}