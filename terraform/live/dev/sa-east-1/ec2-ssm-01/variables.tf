
# Module vars
variable "subnet_id" { default = "" }
variable "key_name"  { default = "" }


# Self discovery vars
#   ./variables.tf            : define : var: vpc_name_tag    # filter by name
#   ./variables.tf            : define : var: subnet_priv_tag # filter by name
#   ./variables.tf            : define : var: vpc_id          # join: from vpc to subnet
#   ../var.vpc.auto.tfvars    : set    :      vpc_name_tag    = "vpc-dev"
#   ../var.subnets.auto.tfvars: set    :      subnet_priv_tag = "private-*"
#   ./data-vpc.tf             : returns: data.aws_vpc.vpc_id
#   ./data-subnets.tf         : returns: data.aws_subnets.priv[]
variable "vpc_id"          { default = "" }  # Module and/or self-discovery
variable "vpc_name_tag"    { default = "" }  # self-discovery: filter
variable "subnet_priv_tag" { default = "" }  # self-discovery: filter

variable "ami_owners" { default = "" } # filter
variable "ami_name"   { default = "" } # filter

