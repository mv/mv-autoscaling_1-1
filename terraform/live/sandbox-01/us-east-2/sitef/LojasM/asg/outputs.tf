################################################################################
# Complete
################################################################################

output "asg_launch_template_id"                          { value = module.sitef-lojasm.asg_launch_template_id }
output "asg_launch_template_arn"                         { value = module.sitef-lojasm.asg_launch_template_arn }
output "asg_launch_template_name"                        { value = module.sitef-lojasm.asg_launch_template_name }
output "asg_launch_template_latest_version"              { value = module.sitef-lojasm.asg_launch_template_latest_version }
output "asg_launch_template_default_version"             { value = module.sitef-lojasm.asg_launch_template_default_version }

output "asg_autoscaling_group_id"                        { value = module.sitef-lojasm.asg_autoscaling_group_id }
output "asg_autoscaling_group_name"                      { value = module.sitef-lojasm.asg_autoscaling_group_name }
output "asg_autoscaling_group_arn"                       { value = module.sitef-lojasm.asg_autoscaling_group_arn }
output "asg_autoscaling_group_min_size"                  { value = module.sitef-lojasm.asg_autoscaling_group_min_size }
output "asg_autoscaling_group_max_size"                  { value = module.sitef-lojasm.asg_autoscaling_group_max_size }
output "asg_autoscaling_group_desired_capacity"          { value = module.sitef-lojasm.asg_autoscaling_group_desired_capacity }
output "asg_autoscaling_group_default_cooldown"          { value = module.sitef-lojasm.asg_autoscaling_group_default_cooldown }
output "asg_autoscaling_group_health_check_grace_period" { value = module.sitef-lojasm.asg_autoscaling_group_health_check_grace_period }
output "asg_autoscaling_group_health_check_type"         { value = module.sitef-lojasm.asg_autoscaling_group_health_check_type }
output "asg_autoscaling_group_availability_zones"        { value = module.sitef-lojasm.asg_autoscaling_group_availability_zones }
output "asg_autoscaling_group_vpc_zone_identifier"       { value = module.sitef-lojasm.asg_autoscaling_group_vpc_zone_identifier }
output "asg_autoscaling_group_target_group_arns"         { value = module.sitef-lojasm.asg_autoscaling_group_target_group_arns }
output "asg_autoscaling_schedule_arns"                   { value = module.sitef-lojasm.asg_autoscaling_schedule_arns }
output "asg_autoscaling_policy_arns"                     { value = module.sitef-lojasm.asg_autoscaling_policy_arns }
output "asg_autoscaling_group_enabled_metrics"           { value = module.sitef-lojasm.asg_autoscaling_group_enabled_metrics }

output "asg_iam_role_name"                               { value = module.sitef-lojasm.asg_iam_role_name }
output "asg_iam_role_arn"                                { value = module.sitef-lojasm.asg_iam_role_arn }
output "asg_iam_role_unique_id"                          { value = module.sitef-lojasm.asg_iam_role_unique_id }
output "asg_iam_instance_profile_arn"                    { value = module.sitef-lojasm.asg_iam_instance_profile_arn }
output "asg_iam_instance_profile_id"                     { value = module.sitef-lojasm.asg_iam_instance_profile_id }

/****
output "asg_autoscaling_group_load_balancers"            { value = module.sitef-lojasm.asg_autoscaling_group_load_balancers }
output "asg_iam_instance_profile_unique"                 { value = module.sitef-lojasm.asg_iam_instance_profile_unique }
/****/
