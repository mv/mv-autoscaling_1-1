#!/usr/bin/env bash

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <instance-id>"
  echo
  exit 2
}

_instance_id="${1}"

aws ec2 describe-instance-attribute \
  --instance-id "${_instance_id}"   \
  --attribute userData --query "UserData.Value" \
  --output text \
  | base64 --decode
