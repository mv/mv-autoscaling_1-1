##
## SSM parameters
##

# locals {
#   ssm_path = "/app/path"
# }

## 'type'
##   Ref: #   https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#use-an-ssm-parameter-instead-of-an-ami-id
##
resource "aws_ssm_parameter" "asg_ami" {
  name           = var.ssm_path
  insecure_value = coalesce(var.ami_id, data.aws_ami.al2023.id)
  type           = "String"
  data_type      = "aws:ec2:image"
  description    = "ASG: deploy AMI"

  # ignore future changes to 'value': deploy via new AMI updates into 'latest'
  lifecycle { ignore_changes = [ value, tags_all ] }

  tags = merge(
    var.tags,
    local.module_tags
  )

}

# insecure_value = jsonencode( local.tgw_route_table_ids )
