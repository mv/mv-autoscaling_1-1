
output "key_name" { value = module.key_pair.key_name }
output "ssm_path" { value = module.key_pair.ssm_path }

output "key_pair_arn"   { value = module.key_pair.key_pair_arn }
output "key_pair_id"    { value = module.key_pair.key_pair_id  }

output "private_key_id" { value = module.key_pair.private_key_id  }

output "ssm_cli"        { value = module.key_pair.ssm_cli }
