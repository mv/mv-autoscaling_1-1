# vscode-modelines
# vim: set ft=terraform:


# locals {
#   region  = data.aws_region.current.id
#   account = data.aws_caller_identity.current.account_id
# }

## Allow policy
resource "aws_iam_policy" "ec2_self_upd" {
  name        = "EC2-Self-Update-${local.name}"
  description = "EC2: self-update"

  policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "EC2SelfUpdateTags",
        "Effect": "Allow",
        "Action": [
            "ec2:DescribeTags",
            "ec2:CreateTags"
        ]
        "Resource": "*"
      },
      {
        "Sid": "EC2MountEFS",
        "Effect": "Allow",
        "Action": [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess"
        ],
#       "Resource": "arn:aws:elasticfilesystem:us-east-1:123456789012:file-system/fs-12345678"
        "Resource": "arn:aws:elasticfilesystem:${local.region}:${local.account}:file-system/*"
      }
    ]
  }
  )
}


#     {
#       "Version": "2012-10-17",
#       "Statement": [
#         {
#           "Sid": "S3Bucket",
#           "Effect": "Allow",
#           "Action": [
#             "s3:GetBucket*",
#             "s3:ListBucket*"
#           ]
#           "Resource": "arn:aws:s3:::${var.bucket_config}"
#         },
#         {
#           "Sid": "S3Object",
#           "Effect": "Allow",
#           "Action": [
#             "s3:GetObject*",
#             "s3:PutObject*",
#             "s3:List*",
#####         "s3:DeleteObject*",
#           ]
#####       "Resource": "arn:aws:s3:::${var.bucket_config}/asg/*"
#           "Resource": "arn:aws:s3:::${var.bucket_config}/*"
#         },
#         {
#           "Sid": "KMSKey",
#           "Effect": "Allow",
#           "Action": [
#             "kms:Decrypt",
#             "kms:GenerateDataKey"
#           ]
#           "Resource": data.aws_kms_alias.s3.target_key_arn
#         }