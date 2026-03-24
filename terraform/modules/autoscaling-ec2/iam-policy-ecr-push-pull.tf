# vscode-modelines
# vim: set ft=terraform:


## Ref:
##   https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-policy-examples.html
##

/*****

## Allow policy
resource "aws_iam_policy" "ecr_push_pull" {
  name        = "ECR-Push-Pull-${local.name}"
  description = "ECR: push/pull by EC2"

  policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowPushPull",
        "Effect": "Allow",
        "Action": [
            "ecr:PutImage",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:CompleteLayerUpload",
            "ecr:GetDownloadUrlForLayer",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart"
        ]
        "Resource": "arn:aws:ecr:us-east-2:503561411037:repository/inoa/fix-hub"
      }
    ]
  })
}

/*****/
