# vscode-modelines
# vim: set ft=terraform:

output "security_group_id" { value = module.asg.security_group_id }

#utput "iam_instance_profile_all"             { value = module.asg.iam_instance_profile_arn  }
output "iam_instance_profile_arn"             { value = module.asg.iam_instance_profile_arn  }
output "iam_instance_profile_id"              { value = module.asg.iam_instance_profile_id   }
#utput "iam_role_all"                         { value = module.asg.iam_role_all              }
output "iam_role_name"                        { value = module.asg.iam_role_name             }
output "iam_role_arn"                         { value = module.asg.iam_role_arn              }
output "iam_role_description"                 { value = module.asg.iam_role_description      }
output "iam_role_policy_attachment"           { value = module.asg.iam_role_policy_attachment }
output "iam_role_policy_inline"               { value = module.asg.iam_role_policy_inline    }

#utput "launch_template_all"                   { value = module.asg.launch_template_all                   }
output "launch_template_arn"                   { value = module.asg.launch_template_arn                   }
output "launch_template_id"                    { value = module.asg.launch_template_id                    }
output "launch_template_block_device_mappings" { value = module.asg.launch_template_block_device_mappings }
output "launch_template_instance_type"         { value = module.asg.launch_template_instance_type         }
output "launch_template_name"                  { value = module.asg.launch_template_name                  }
output "launch_template_version_default"       { value = module.asg.launch_template_version_default       }
output "launch_template_version_latest"        { value = module.asg.launch_template_version_latest        }
output "launch_template_user_data"             { value = module.asg.launch_template_user_data             }
output "launch_template_user_data_decode"      { value = base64decode(module.asg.launch_template_user_data) }

/****
output "asg_as_info_arn"                        { value = module.asg.asg_info_arn                        }
output "asg_as_info_id"                         { value = module.asg.asg_info_id                         }
output "asg_as_info_name"                       { value = module.asg.asg_info_name                       }

output "asg_scale_default_cooldown"          { value = module.asg.asg_scale_default_cooldown          }
output "asg_scale_desired_capacity"          { value = module.asg.asg_scale_desired_capacity          }
output "asg_scale_health_check_grace_period" { value = module.asg.asg_scale_health_check_grace_period }
output "asg_scale_health_check_type"         { value = module.asg.asg_scale_health_check_type         }
output "asg_scale_min_size"                  { value = module.asg.asg_scale_min_size                  }
output "asg_scale_max_size"                  { value = module.asg.asg_scale_max_size                  }
output "asg_scale_enabled_metrics"           { value = module.asg.asg_enabled_metrics                 }

#utput "asg_net_load_balancers"              { value = module.asg.asg_net_load_balancers              }
output "asg_net_target_group_arns"           { value = module.asg.asg_net_target_group_arns           }
output "asg_net_vcp_azs"                     { value = module.asg.asg_net_availability_zones          }
output "asg_net_vpc_zone_identifier"         { value = module.asg.asg_net_vpc_zone_identifier         }

/***
output "asg_policy_arns"                     { value = module.asg.asg_policy_arns                     }
output "asg_schedule_arns"                   { value = module.asg.asg_schedule_arns                   }
/****/


#   output "asg_iam_role_policy_attachment_pos"       { value = module.asg.asg_iam_role_policy_attachment_pos }