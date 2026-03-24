#!/usr/bin/env bash

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <ami_name>"
  echo
  exit 1
}

_ami_name="${1}"

aws ec2 describe-images \
    --filters "Name=name,Values=*${_ami_name}*" \
    --query   'Images[][Name,ImageId,OwnerId,ImageOwnerAlias,CreationDate]' \
    --owners  'self' \
    --output text | column -t | sort -k 5 -r

