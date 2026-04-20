
output "key_name" { value = var.key_name }
output "ssm_path" { value = var.ssm_path }

output "key_pair_arn"   { value = module.key_pair.key_pair_arn }
output "key_pair_id"    { value = module.key_pair.key_pair_id  }

output "private_key_id" { value = module.key_pair.private_key_id  }

#utput "openssh_public_key" { value = module.key_pair.public_key_openssh }
#utput "pem_public_key"     { value = module.key_pair.public_key_pem }

output "ssm_cli" {
  value = join("\n", [
    "  aws ssm get-parameter --name ${var.ssm_path} --query Parameter.Value --with-decryption | jq -r | jq",
    "  aws ssm get-parameter --name ${var.ssm_path} --query Parameter.Value --with-decryption | jq -r | jq -r '.key_name'",
    "  aws ssm get-parameter --name ${var.ssm_path} --query Parameter.Value --with-decryption | jq -r | jq -r '.openssh_private_key'",
    "  aws ssm get-parameter --name ${var.ssm_path} --query Parameter.Value --with-decryption | jq -r | jq -r '.openssh_public_key'",
    "  aws ssm get-parameter --name ${var.ssm_path} --query Parameter.Value --with-decryption | jq -r | jq -r '.pem_private_key'",
    "  aws ssm get-parameter --name ${var.ssm_path} --query Parameter.Value --with-decryption | jq -r | jq -r '.pem_public_key'",
  ])
}
