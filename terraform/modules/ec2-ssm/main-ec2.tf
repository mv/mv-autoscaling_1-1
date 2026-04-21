
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"

  name          = var.name
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  ami           = coalesce(var.ami_id, data.aws_ami.al2023.id)

# root_block_device = var.root_block_device

  key_name = var.key_name

  # IMDSv2
  metadata_options = {
    "http_endpoint": "enabled",
    "http_tokens": "required"
  }

  # My SG
  create_security_group  = false
  vpc_security_group_ids = [aws_security_group.sg.id]

  ## SSM
  create_iam_instance_profile = true
  iam_role_description        = "IAM role: ${var.name} EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" # SSM: console access
    ReadOnlyAccess               = "arn:aws:iam::aws:policy/ReadOnlyAccess"               # SSM: parameter store
  }

  tags = merge(
    var.tags,
    local.module_tags
  )

  ## just in case
  user_data = <<-EOT
  #!/usr/bin/env bash

    set -x
    dnf update -y
    dnf install -y htop btop wget nmap

    wget -O   /usr/local/bin/tcping https://github.com/Tcp-Ping/Tcping/releases/download/v0.1.1/linux-amd64-tcping
    chmod 775 /usr/local/bin/tcping

    cat > /etc/profile.d/noproxy.sh <<EOF
    ##
    no_proxy=169.254.169.254,100.99.0.0/16
    NO_PROXY=169.254.169.254,100.99.0.0/16
    ##
    EOF

    cat >> /etc/bashrc <<EOF

    set -o vi
    alias env='env | sort'
    alias envg='env | sort | grep -i'
    alias ssl='ss -ltnp | column -t'
    alias ssg='ss -ltnp | column -t | grep -i'
    alias ls='ls -hAF --time-style=long-iso --group-directories-first'
    alias ll='ls -l'

    EOF


  EOT
}
