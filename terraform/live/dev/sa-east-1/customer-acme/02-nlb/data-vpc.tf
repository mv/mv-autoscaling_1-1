# vscode-modelines
# vim: set ft=terraform:

data "aws_vpc" "vpc" {

  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name_tag}*"]
  }

}

output "data_vpc" { # value = data.aws_vpc.vpc }
 value = {
   tomap = {
     "name"   = data.aws_vpc.vpc.tags.Name
     "vpc_id" = data.aws_vpc.vpc.id
     "region" = data.aws_vpc.vpc.region
     "cidr"   = data.aws_vpc.vpc.cidr_block
     "cidr_block_associations" = data.aws_vpc.vpc.cidr_block_associations
   }
 }
}
