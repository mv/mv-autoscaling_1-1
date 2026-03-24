

output "ssm_parameter_id"      { value = aws_ssm_parameter.asg_ami.id      }
output "ssm_parameter_version" { value = aws_ssm_parameter.asg_ami.version }
