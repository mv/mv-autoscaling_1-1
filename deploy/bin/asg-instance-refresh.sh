#!/usr/bin/env bash

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <asg-name>"
  echo
  exit 1
}

_asg_name="asg-${1}"

# Get current AMI version
# (auto-rollback will get back to ${cur_ver}-1 if needed)
_param="/app/asg/${1}/ami"
_ver=$( aws ssm get-parameter --name ${_param} --query "Parameter.Version" --output text )
_val=$( aws ssm get-parameter --name ${_param} --query "Parameter.Value"   --output text )

echo
echo "==="
echo "=== Deploy: via ASG/refresh"
echo "=== Customer:          [${1}]"
echo "=== Autoscaling Group: [${_asg_name}]"
echo "=== Parameter version: [${_ver}]"
echo "=== Parameter value:   [${_val}]"
echo "==="

_json="/tmp/asg-instance-refresh.json"
cat > "${_json}" <<EOF
{
  "Preferences": {
    "SkipMatching": true,
    "StandbyInstances": "Ignore",
    "ScaleInProtectedInstances": "Ignore"
  }
}
EOF

# https://docs.aws.amazon.com/autoscaling/ec2/userguide/understand-instance-refresh-default-values.html
aws autoscaling start-instance-refresh   \
  --auto-scaling-group-name ${_asg_name} \
  --strategy 'Rolling'                   \
  --cli-input-json file://"${_json}"

# --desired-configuration=${_cur_ver}    \
# --preferences '{"AutoRollback":true,"SkipMatching":true,"StandbyInstances":"Ignore","ScaleInProtectedInstances":"Ignore"}'
# --preferences '{"AutoRollback": true, "BakeTime": 5}'
#
#   "InstanceWarmup": 60,
#   "MinHealthyPercentage": 100,

# https://docs.aws.amazon.com/cli/latest/reference/autoscaling/start-instance-refresh.html
# {
#   "AutoScalingGroupName": "${_asg_name}",
#   "DesiredConfiguration": {
#     "LaunchTemplate": { "LaunchTemplateName": "${_asg_name}", "Version": "${_ver}" }
#   },
#   "Preferences": {
#     "AutoRollback": true|false,
#     "SkipMatching": true|false,
#     "StandbyInstances": "Terminate"|"Ignore"|"Wait",
#     "ScaleInProtectedInstances": "Refresh"|"Ignore"|"Wait",
#     "MinHealthyPercentage": integer,
#     "MaxHealthyPercentage": integer,
#     "BakeTime": integer
#     "InstanceWarmup": integer,
#     "CheckpointDelay": integer,
#     "CheckpointPercentages": [integer, ...],
#     "AlarmSpecification": {
#       "Alarms": ["string", ...]
#     },
#   }
# }