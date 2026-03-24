#!/usr/bin/env bash
#

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <sg-name>"
  echo
  exit 1
}

## EC2/SG
_sg_id=$( aws ec2 describe-security-groups   \
    --filters Name=group-name,Values=ec2-packer \
    --query "SecurityGroups[*].{ID:GroupId}" \
    --output text
)

echo "==="
echo "=== Security Group: [${_sg_id}]"
echo "==="

aws ec2 delete-security-group --group-id "${_sg_id}"
