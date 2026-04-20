
module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.3"

  key_name = var.key_name

  create_private_key    = true
  private_key_algorithm = "ED25519"

  tags = merge(
    var.tags,
    local.module_tags
  )
}