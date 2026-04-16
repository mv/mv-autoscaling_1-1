

output "ssm_parameter_id"      { value = module.parameter_ami.ssm_parameter_id      }
output "ssm_parameter_version" { value = module.parameter_ami.ssm_parameter_version }

output "ami_id"   { value = data.aws_ami.ami.id   }
output "ami_name" { value = data.aws_ami.ami.name }
