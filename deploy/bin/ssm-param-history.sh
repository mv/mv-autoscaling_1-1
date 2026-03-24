#!/usr/bin/env bash

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <customer>"
  echo
  exit 1
}

_cust="${1}"

aws ssm get-parameter-history \
    --name "/app/asg/${_cust}/ami" \
    --query "Parameters[].[Version,Value]" --output text \
    | while read _param
      do
        _val=$( echo ${_param} | awk '{print $2}' )
        _ver=$( echo ${_param} | awk '{print $1}' )
        _img=$(                   \
          aws ec2 describe-images \
              --image-ids $(echo ${_val}|awk '{print $1}') \
              --query "Images[].Name" \
              --output text
        );
        printf ' %s %02d: %s %s\n' ${_cust} ${_ver} ${_val} ${_img}
      done
      echo;
