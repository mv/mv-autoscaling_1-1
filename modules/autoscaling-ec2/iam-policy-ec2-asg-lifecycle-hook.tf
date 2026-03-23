# vscode-modelines
# vim: set ft=terraform:


## Ref:
##   https://docs.aws.amazon.com/autoscaling/ec2/userguide/tutorial-lifecycle-hook-instance-metadata.html
##


## Allow policy
resource "aws_iam_policy" "asg_complete_lifecycle" {
  name        = "ASG-Complete-Lifecycle-${local.name}"
  description = "ASG: complete lifecycleHook by EC2"

  policy = jsonencode(
  {
    "Version":"2012-10-17",
    "Statement": [
      {
        "Sid": "LifecycleHook",
        "Effect": "Allow",
        "Action": [
          "autoscaling:CompleteLifecycleAction"
        ],
        "Resource": "${aws_autoscaling_group.asg.arn}"
      }
    ]
  })
}

## Attach to role
## OBS:
##   This is done as a separate attachment to the Instance Profile role
##   as an explicit final step: so it is guaranteed that Role, launch template
##   are already created and can be referenced without causing circular dependencies

locals {
  my_policy = {
    asg_lifecycle = aws_iam_policy.asg_complete_lifecycle.arn
  }
}

## keep the same attachment mechanism
resource "aws_iam_role_policy_attachment" "policy_pos" {
  for_each   = merge(local.my_policy)
  role       = aws_iam_role.role.name
  policy_arn = each.value
}


/*****/