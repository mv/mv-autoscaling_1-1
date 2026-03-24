#!/usr/bin/env bash

[ "${1}" == "--help" ] && {
  echo
  echo "Usage: $0 "
  echo
  exit 1
}

aws ssm describe-parameters --query 'Parameters[].Name' --output json \
    | jq '.[]' |tr -d '"' \
    | while read _param
      do
        _val=$( aws ssm get-parameter --name ${_param} --query "Parameter.Value" --output text )
        _ver=$( aws ssm get-parameter --name ${_param} --query "Parameter.Version" --output text )
        _img=$(                   \
          aws ec2 describe-images \
              --image-ids $(echo ${_val}|awk '{print $1}') \
              --query "Images[].Name" \
              --output text
        );
        printf '%30s %02d: %s %s\n' ${_param} ${_ver} ${_val} ${_img}
      done
      echo;

# --query "Parameters[].{arn:ARN,version:Version}" \
