# vscode-modelines
# vim: set ft=terraform:

output "asg_security_group_id" { value = aws_security_group.sg.id }

output "asg_iam_instance_profile_all"              { value = aws_iam_instance_profile.profile }
output "asg_iam_instance_profile_arn"              { value = aws_iam_instance_profile.profile.arn }
output "asg_iam_instance_profile_id"               { value = aws_iam_instance_profile.profile.id }
output "asg_iam_role_all"                          { value = aws_iam_role.role }
output "asg_iam_role_name"                         { value = aws_iam_role.role.name }
output "asg_iam_role_arn"                          { value = aws_iam_role.role.arn  }
output "asg_iam_role_description"                  { value = aws_iam_role.role.description  }
output "asg_iam_role_policy_inline"                { value = aws_iam_role.role.inline_policy  }

output "asg_iam_role_policy_attachment_all"        { value = aws_iam_role_policy_attachment.policy }

output "asg_iam_role_policy_attachment" {
  value = {
    for k in keys(aws_iam_role_policy_attachment.policy):
      k => tomap({
#       "id"         = aws_iam_role_policy_attachment.policy[k].id
        "policy_arn" = aws_iam_role_policy_attachment.policy[k].policy_arn
      })
  }
}

output "asg_launch_template_all"                   { value = aws_launch_template.lt }
output "asg_launch_template_arn"                   { value = aws_launch_template.lt.arn }
output "asg_launch_template_id"                    { value = aws_launch_template.lt.id }
output "asg_launch_template_block_device_mappings" { value = aws_launch_template.lt.block_device_mappings }
output "asg_launch_template_instance_type"         { value = aws_launch_template.lt.instance_type }
output "asg_launch_template_name"                  { value = aws_launch_template.lt.name }
output "asg_launch_template_version_default"       { value = aws_launch_template.lt.default_version }
output "asg_launch_template_version_latest"        { value = aws_launch_template.lt.latest_version }
output "asg_launch_template_user_data"             { value = aws_launch_template.lt.user_data }

output "asg_info_arn"                        { value = aws_autoscaling_group.asg.arn }
output "asg_info_id"                         { value = aws_autoscaling_group.asg.id }
output "asg_info_name"                       { value = aws_autoscaling_group.asg.name }

output "asg_scale_default_cooldown"          { value = aws_autoscaling_group.asg.default_cooldown }
output "asg_scale_desired_capacity"          { value = aws_autoscaling_group.asg.desired_capacity }
output "asg_scale_health_check_grace_period" { value = aws_autoscaling_group.asg.health_check_grace_period }
output "asg_scale_health_check_type"         { value = aws_autoscaling_group.asg.health_check_type }
output "asg_scale_min_size"                  { value = aws_autoscaling_group.asg.min_size }
output "asg_scale_max_size"                  { value = aws_autoscaling_group.asg.max_size }

#utput "asg_net_load_balancers"              { value = aws_autoscaling_group.asg.load_balancers }
output "asg_net_target_group_arns"           { value = aws_autoscaling_group.asg.target_group_arns }
output "asg_net_availability_zones"          { value = aws_autoscaling_group.asg.availability_zones }
output "asg_net_vpc_zone_identifier"         { value = aws_autoscaling_group.asg.vpc_zone_identifier }

output "asg_enabled_metrics"                 { value = aws_autoscaling_group.asg.enabled_metrics }

/****
output "asg_policy_arns"                     { value = aws_autoscaling_group.asg.policy_arns }
output "asg_schedule_arns"                   { value = aws_autoscaling_group.asg.schedule_arns }

/****/

