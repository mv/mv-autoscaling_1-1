##
## IMG name
##
locals {
  now = timestamp()
  brt = timeadd(local.now, "-3h")

  build_date = formatdate("YYYY-MM-DD",timestamp())
  src_name   = "fdc-rhel-09.${local.build_date}.{{timestamp}}"
  ami_name   = "http.${local.src_name}.${var.release}"
# ami_name   = "http-${var.release}.${local.src_name}"
}

##
## Latest src AMI
##
## 969312851005/FDC-RHEL-9.6-Build-2026-01-05
data "amazon-ami" "rhel09" {
  owners      = ["969312851005"]
  most_recent = true
  filters = {
    architecture        = "x86_64"
    virtualization-type = "hvm"
    root-device-type    = "ebs"
    name                = "FDC-RHEL-9*-Build-20??-??-??" # Red Hat 9
  }
}


##
## Bulder plugin: 'amazon-ebs'
##
source "amazon-ebs" "ami" {
  source_ami    = data.amazon-ami.rhel09.id
  ami_name      = local.ami_name
  instance_type = var.instance_type
  region        = var.region
  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_id

  # pre-created
  security_group_id = var.sg_id

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
    "mv:packer:SourceAMI:CreationDate" = "{{.SourceAMICreationDate}}"
  }

  # AMI: final name
  tags = { Name = "${local.ami_name}" }
}
