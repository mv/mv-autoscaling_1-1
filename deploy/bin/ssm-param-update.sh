#!/usr/bin/env bash

[ "${2}" == "" ] && {
  echo
  echo "Usage: $0 <customer> <ami-id>"
  echo
  exit 1
}

  _cust="${1}"
_ami_id="${2}"
 _descr="Updated at $(/bin/date '+%F')"

aws ssm put-parameter \
  --description "${_descr}"      \
  --name "/app/asg/${_cust}/ami" \
  --value ${_ami_id}             \
  --type 'String' --data-type 'aws:ec2:image' \
  --overwrite
