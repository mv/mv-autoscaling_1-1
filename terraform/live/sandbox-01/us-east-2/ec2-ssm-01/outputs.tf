
output "ec2_ami_id"            { value = module.ssm-01.ec2_ami_id }
output "ec2_ami_name"          { value = module.ssm-01.ec2_ami_name }
output "ec2_ami_description"   { value = module.ssm-01.ec2_ami_description }
output "ec2_instance_id"       { value = module.ssm-01.ec2_instance_id }
output "ec2_private_ip"        { value = module.ssm-01.ec2_private_ip }
output "ec2_public_ip"         { value = module.ssm-01.ec2_public_ip }
output "ec2_security_group_id" { value = module.ssm-01.ec2_security_group_id }
output "ec2_instance_type"     { value = module.ssm-01.ec2_instance_type }
output "ec2_name"              { value = module.ssm-01.ec2_name }
output "ec2_key_name"          { value = module.ssm-01.ec2_key_name }
output "ec2_key_ssm_path"      { value = module.ssm-01.ec2_key_ssm_path }

output "vpc_id"                { value = module.ssm-01.vpc_id }
output "vpc_name"              { value = module.ssm-01.vpc_name }
output "vpc_az"                { value = module.ssm-01.vpc_az }
output "vpc_subnet_id"         { value = module.ssm-01.vpc_subnet_id }
output "vpc_subnet_cidr"       { value = module.ssm-01.vpc_subnet_cidr }

output "ssm_cli"               { value = module.ssm-01.ssm_cli }
output "ssm_connection_info"   { value = module.ssm-01.ssm_connection_info }

