# vscode-modelines
# vim: set ft=terraform:

locals {
  iam_role_name = "iam_instance_profile_${var.customer}"
}

##
## Trust policy
##
data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect = "Allow"
    actions = [ "sts:AssumeRole" ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

##
## Role
##
resource "aws_iam_role" "role" {
# name_prefix = "${local.iam_role_name}_"
  name        = local.iam_role_name
  description = "ASG: EC2 instance_profile role"

  assume_role_policy = data.aws_iam_policy_document.trust_policy.json

  tags = merge(var.tags, local.module_tags)
}


##
## Permissions policies
##
locals {
  policies = {
    ssm_core     = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    readonly     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    cw_agent     = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ec2_self_upd = aws_iam_policy.ec2_self_upd.arn
  }
}

resource "aws_iam_role_policy_attachment" "policy" {
  for_each   = merge(local.policies, var.iam_role_policies)
  role       = aws_iam_role.role.name
  policy_arn = each.value
}


##
## Instance Profile
##
resource "aws_iam_instance_profile" "profile" {
# name_prefix = "${local.iam_role_name}_"
  name        = local.iam_role_name
  role        = aws_iam_role.role.name

  tags = merge(var.tags, local.module_tags)
}
