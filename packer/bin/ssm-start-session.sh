#!/usr/bin/env bash
#

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <instance-name>"
  echo
  exit 1
}

_instance_name="${1}"

_instance_id=$(
  aws ec2 describe-instances \
  --filters \
    "Name=tag:Name,Values=${_instance_name}*" \
    "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].[InstanceId]" \
  --output text
)

echo "==="
echo "=== SSM Start Session: [${_instance_id}]"
echo "==="

aws ssm start-session \
    --target ${_instance_id}

