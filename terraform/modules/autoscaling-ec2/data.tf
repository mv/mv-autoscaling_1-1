# vscode-modelines
# vim: set ft=terraform:

locals {
  vpc_id  = data.aws_subnet.subnet.vpc_id
  region  = data.aws_region.current.id
  account = data.aws_caller_identity.current.account_id

# s3_kms_arn = data.aws_kms_alias.s3.target_key_arn
}


# get vpc_id
data "aws_subnet" "subnet" {
# id = try(var.subnet_id, var.vpc_zone_identifier[0])
  id = var.vpc_zone_identifier[0]
}

# get account_id
data "aws_caller_identity" "current" {}

# get region
data "aws_region"          "current" {}


#ata "aws_kms_alias" "s3" { name = "alias/aws/s3" }
