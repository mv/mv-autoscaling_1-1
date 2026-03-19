# vscode-modelines
# vim: set ft=terraform:

#utput "asg_launch_template_all"                   { value = module.asg.asg_launch_template_all                   }
output "asg_launch_template_arn"                   { value = module.asg.asg_launch_template_arn                   }
output "asg_launch_template_id"                    { value = module.asg.asg_launch_template_id                    }
output "asg_launch_template_instance_type"         { value = module.asg.asg_launch_template_instance_type         }
output "asg_launch_template_iam_instance_profile"  { value = module.asg.asg_launch_template_iam_instance_profile  }
output "asg_launch_template_name"                  { value = module.asg.asg_launch_template_name                  }
output "asg_launch_template_version_default"       { value = module.asg.asg_launch_template_version_default       }
output "asg_launch_template_version_latest"        { value = module.asg.asg_launch_template_version_latest        }
output "asg_launch_template_user_data"             { value = module.asg.asg_launch_template_user_data             }
output "asg_launch_template_block_device_mappings" { value = module.asg.asg_launch_template_block_device_mappings }

output "asg_security_group_id" { value = module.asg.asg_security_group_id }

#utput "asg_iam_instance_profile_all"             { value = module.asg.asg_iam_instance_profile_arn  }
output "asg_iam_instance_profile_arn"             { value = module.asg.asg_iam_instance_profile_arn  }
output "asg_iam_instance_profile_id"              { value = module.asg.asg_iam_instance_profile_id   }
#utput "asg_iam_role_all"                         { value = module.asg.asg_iam_role_all              }
output "asg_iam_role_name"                        { value = module.asg.asg_iam_role_name             }
output "asg_iam_role_arn"                         { value = module.asg.asg_iam_role_arn              }
output "asg_iam_role_description"                 { value = module.asg.asg_iam_role_description      }
output "asg_iam_role_policy_attachment"           { value = module.asg.asg_iam_role_policy_attachment }
output "asg_iam_role_policy_inline"               { value = module.asg.asg_iam_role_policy_inline    }
