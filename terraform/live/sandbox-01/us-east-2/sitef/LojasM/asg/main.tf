locals {
  name                = var.name          # "LojasM"
  instance_type       = var.instance_type # "t3.micro"
  vpc_zone_identifier = var.vpc_zone_identifier
}

module "sitef-LojasM" {
  source = "../../../../../../modules/asg-sitef"

  name                = local.name
  instance_type       = local.instance_type
  vpc_zone_identifier = local.vpc_zone_identifier

  tags = {
    "sitef:env"     = "dev"
    "sitef:cliente" = local.name
  }

}
