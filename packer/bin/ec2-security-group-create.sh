#!/usr/bin/env bash
#

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <vpc-id>"
  echo
  exit 1
}

vpc_id="${1}"

## Rules
_ingress='
[
  { "IpProtocol":"tcp","FromPort": 22,"ToPort": 22 , "IpRanges":[ { "CidrIp":"0.0.0.0/0","Description":"SSH Access"} ] },
  { "IpProtocol":"tcp","FromPort": 80,"ToPort": 80 , "IpRanges":[ { "CidrIp":"0.0.0.0/0","Description":"HTTP Access"} ] },
  { "IpProtocol":"tcp","FromPort":443,"ToPort":443 , "IpRanges":[ { "CidrIp":"0.0.0.0/0","Description":"HTTPS Access"} ] }
]'

_egress='
[
  { "IpProtocol":"-1","FromPort":-1,"ToPort":-1 , "IpRanges":[ { "CidrIp":"0.0.0.0/0","Description":"All outbound"} ] }
]'

## EC2/SG
_sg_id=$( aws ec2 describe-security-groups   \
    --filters Name=group-name,Values=ec2-packer \
    --query "SecurityGroups[*].{ID:GroupId}" \
    --output text
)

if [ "${_sg_id}" == "" ]
then
  _sg_id=$( aws ec2 create-security-group \
    --output text \
    --group-name ec2-packer \
    --description "Packer provisioning: security group" \
    --vpc-id "${vpc_id}" | awk '{print $1}' \
    || true \
  )
fi

aws ec2 create-tags \
  --resources "${_sg_id}" \
  --tags Key=Name,Value=ec2-packer

echo "==="
echo "=== Security Group: [${_sg_id}]"
echo "==="

## EC2/SG/Rules
aws ec2 authorize-security-group-ingress \
    --group-id "${_sg_id}" \
    --ip-permissions "${_ingress}" \
    --output text || true

# aws ec2 authorize-security-group-egress \
#     --group-id "${_sg_id}" \
#     --ip-permissions "${_egress}" \
#     --output text || true
