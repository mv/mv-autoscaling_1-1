
output "ec2_ami_id"            { value = data.aws_ami.al2023.id }
output "ec2_ami_name"          { value = data.aws_ami.al2023.name }
output "ec2_ami_description"   { value = data.aws_ami.al2023.description }
output "ec2_instance_id"       { value = module.ec2.id }
output "ec2_private_ip"        { value = module.ec2.private_ip }
output "ec2_public_ip"         { value = module.ec2.public_ip  }
output "ec2_security_group_id" { value = aws_security_group.sg.id }
output "ec2_instance_type"     { value = var.instance_type   }
output "ec2_name"              { value = var.name }
output "ec2_key_name"          { value = var.key_name }
output "ec2_key_ssm_path"      { value = var.key_ssm_path }

output "vpc_id"          { value = data.aws_subnet.subnet.vpc_id }
output "vpc_name"        { value = data.aws_subnet.subnet.tags.Name }
output "vpc_az"          { value = data.aws_subnet.subnet.availability_zone }
output "vpc_subnet_id"   { value = data.aws_subnet.subnet.id }
output "vpc_subnet_cidr" { value = data.aws_subnet.subnet.cidr_block }

output "ssm_cli"               { value = "aws ssm start-session --target ${module.ec2.id}" }
output "ssm_connection_info"   { value = var.ssm_connection_info }

# output "db_security_group_id"  { value = var.db_security_group_id }
# output "path_root"   { value = "${path.root}" }
# output "path_module" { value = "${path.module}" }
# output "path_cwd"    { value = "${path.cwd}" }
