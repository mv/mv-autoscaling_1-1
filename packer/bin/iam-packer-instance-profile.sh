#!/usr/bin/env bash
#

[ "${1}" != "-y" ] && {
  echo
  echo "Usage: $0 -y"
  echo
  exit 1
}


## Policy/Trust
cat > /tmp/trust-policy.json << EOF
{
    "Version":"2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": { "Service": "ec2.amazonaws.com" },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF


## IAM/Role
aws iam create-role \
    --role-name Packer-Instance-Role \
    --assume-role-policy-document file:///tmp/trust-policy.json

## Policy/Allow
aws iam attach-role-policy \
    --role-name Packer-Instance-Role \
    --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore


## EC2/Instance Profile
aws iam create-instance-profile \
    --instance-profile-name Packer-Instance-Profile

aws iam add-role-to-instance-profile \
    --instance-profile-name Packer-Instance-Profile \
    --role-name Packer-Instance-Role

/bin/rm -f /tmp/trust-policy.json
