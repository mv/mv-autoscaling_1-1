##
## SSM parameters
##

resource "aws_ssm_parameter" "ec2_key_pair" {
  name        = "${var.ssm_path}"
  description = "OVN: EC2 private key"

  type = "SecureString"
  value = jsonencode({
    key_name            = var.key_name
    openssh_private_key = module.key_pair.private_key_openssh
    openssh_public_key  = module.key_pair.public_key_openssh
    pem_private_key     = module.key_pair.private_key_pem
    pem_public_key      = module.key_pair.public_key_pem
  })

  tags = merge(
    var.tags,
    local.module_tags
  )
}

/*****/