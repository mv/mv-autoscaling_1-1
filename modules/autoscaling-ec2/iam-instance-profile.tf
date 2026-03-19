# vscode-modelines
# vim: set ft=terraform:

data "aws_iam_policy_document" "trust_policy" {
  statement {
    sid     = "EC2AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

locals {
  iam_role_name = "iam_instance_profile_${var.customer}"
}

resource "aws_iam_role" "role" {
  name        = local.iam_role_name
  description = "ASG: EC2 instance_profile role"

  assume_role_policy    = data.aws_iam_policy_document.trust_policy.json
# permissions_boundary  = var.iam_role_permissions_boundary
# force_detach_policies = true

  tags = merge(var.tags, local.module_tags)
}

resource "aws_iam_role_policy_attachment" "policy" {
  for_each = {
    for k, v in var.iam_role_policies : k => v
  }
  role       = aws_iam_role.role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "profile" {
  name = local.iam_role_name
  role = aws_iam_role.role.name
  tags = merge(var.tags, local.module_tags)
}
