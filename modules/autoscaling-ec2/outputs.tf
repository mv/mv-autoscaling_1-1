# vscode-modelines
# vim: set ft=terraform:

output "asg_security_group_id" { value = aws_security_group.sg.id }

output "asg_launch_template_all"                  { value = aws_launch_template.lt }
output "asg_launch_template_arn"                  { value = aws_launch_template.lt.arn }
output "asg_launch_template_id"                   { value = aws_launch_template.lt.id }
output "asg_launch_template_instance_type"        { value = aws_launch_template.lt.instance_type }
output "asg_launch_template_iam_instance_profile" { value = aws_launch_template.lt.iam_instance_profile }
output "asg_launch_template_name"                 { value = aws_launch_template.lt.name }
output "asg_launch_template_version_default"      { value = aws_launch_template.lt.default_version }
output "asg_launch_template_version_latest"       { value = aws_launch_template.lt.latest_version }
output "asg_launch_template_user_data"            { value = aws_launch_template.lt.user_data }

output "asg_iam_instance_profile_all"             { value = aws_iam_instance_profile.profile }
output "asg_iam_instance_profile_arn"             { value = aws_iam_instance_profile.profile.arn }
output "asg_iam_instance_profile_id"              { value = aws_iam_instance_profile.profile.id }
output "asg_iam_role_all"                         { value = aws_iam_role.role }
output "asg_iam_role_name"                        { value = aws_iam_role.role.name }
output "asg_iam_role_arn"                         { value = aws_iam_role.role.arn  }
output "asg_iam_role_description"                 { value = aws_iam_role.role.description  }
output "asg_iam_role_policy_inline"               { value = aws_iam_role.role.inline_policy  }

output "asg_iam_role_policy_attachment_all"       { value = aws_iam_role_policy_attachment.policy }

output "asg_iam_role_policy_attachment" {
  value = {
    for k in keys(aws_iam_role_policy_attachment.policy):
      k => tomap({
#       "id"         = aws_iam_role_policy_attachment.policy[k].id
        "policy_arn" = aws_iam_role_policy_attachment.policy[k].policy_arn
      })
  }
}



/****
output "asg_iam_instance_profile_arn"        { value = module.asg.iam_instance_profile_arn }

output "asg_info_id"                        { value = module.asg.autoscaling_group_id }
output "asg_info_name"                      { value = module.asg.autoscaling_group_name }
output "asg_info_arn"                       { value = module.asg.autoscaling_group_arn }

output "asg_autoscaling_group_desired_capacity"          { value = module.asg.autoscaling_group_desired_capacity }
output "asg_autoscaling_group_min_size"                  { value = module.asg.autoscaling_group_min_size }
output "asg_autoscaling_group_max_size"                  { value = module.asg.autoscaling_group_max_size }
output "asg_autoscaling_group_default_cooldown"          { value = module.asg.autoscaling_group_default_cooldown }
output "asg_autoscaling_group_enabled_metrics"           { value = module.asg.autoscaling_group_enabled_metrics }
output "asg_autoscaling_group_health_check_grace_period" { value = module.asg.autoscaling_group_health_check_grace_period }
output "asg_autoscaling_group_health_check_type"         { value = module.asg.autoscaling_group_health_check_type }

output "asg_autoscaling_group_load_balancers"            { value = module.asg.autoscaling_group_load_balancers }
output "asg_autoscaling_group_target_group_arns"         { value = module.asg.autoscaling_group_target_group_arns }
output "asg_autoscaling_group_availability_zones"        { value = module.asg.autoscaling_group_availability_zones }
output "asg_autoscaling_group_vpc_zone_identifier"       { value = module.asg.autoscaling_group_vpc_zone_identifier }

output "asg_autoscaling_policy_arns"                     { value = module.asg.autoscaling_policy_arns }
output "asg_autoscaling_schedule_arns"                   { value = module.asg.autoscaling_schedule_arns }

output "asg_iam_instance_profile_id"                     { value = module.asg.iam_instance_profile_id }
output "asg_iam_instance_profile_unique"                 { value = module.asg.iam_instance_profile_unique }
output "asg_iam_role_name"                               { value = module.asg.iam_role_name }
output "asg_iam_role_arn"                                { value = module.asg.iam_role_arn }
/****/

