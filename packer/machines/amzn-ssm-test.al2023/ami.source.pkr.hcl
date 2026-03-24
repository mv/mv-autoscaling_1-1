##
## IMG name
##
locals {
  build_date = formatdate("YYYY-MM-DD",timestamp())
  src_name   = "al2023.${local.build_date}.{{timestamp}}"
  ami_name   = "amzn-ssm-test.${local.src_name}"
}

##
## Latest src AMI
##
data "amazon-ami" "al2023" {
  owners      = ["amazon"]
  most_recent = true
  filters = {
    architecture        = "x86_64"
    virtualization-type = "hvm"
    root-device-type    = "ebs"
    name                = "al2023-ami-2023*" # Amazon Linux 2023
  }
}


##
## Bulder plugin: 'amazon-ebs'
##
source "amazon-ebs" "al2023" {
  source_ami    = data.amazon-ami.al2023.id
  ami_name      = local.ami_name
  instance_type = var.instance_type
  region        = var.region
  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_id

  # EC2 metadata options
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
    http_put_response_hop_limit = 1
  }
  imds_support  = "v2.0" # enforces imdsv2 support on the resulting AMI

  ## Private subnet via SSM
  ## Ref:
  ##   https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#session-manager-connections
  ssh_interface        = "session_manager"
  ssh_username         = "ec2-user"
  communicator         = "ssh"
  iam_instance_profile = var.iam_instance_profile

  # AWS tags for AMI and build/temp machine
  run_tags = {
    Name   = "packer.${local.ami_name}"
    "mv:packer:SourceAMI:ami_id"       = "{{.SourceAMI}}"
    "mv:packer:SourceAMI:Owner:Id"     = "{{.SourceAMIOwner}}"
    "mv:packer:SourceAMI:Owner:Name"   = "{{.SourceAMIOwnerName}}"
    "mv:packer:SourceAMI:CreationDate" = "{{.SourceAMICreationDate}}"
  }

  # AMI: final name
  tags = { Name = "${local.ami_name}" }
}
