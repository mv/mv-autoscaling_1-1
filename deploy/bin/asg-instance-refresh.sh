#!/usr/bin/env bash

[ "${1}" == "" ] && {
  echo
  echo "Usage: $0 <asg-name>"
  echo
  exit 1
}

_asg_name="${1}"

_json="/tmp/asg-instance-refresh.json"
cat > "${_json}" <<EOF
{
  "Preferences": {
    "AutoRollback": true,
    "SkipMatching": true,
    "StandbyInstances": "Ignore",
    "ScaleInProtectedInstances": "Ignore",
  }
}
EOF

# https://docs.aws.amazon.com/autoscaling/ec2/userguide/understand-instance-refresh-default-values.html
aws autoscaling start-instance-refresh   \
  --auto-scaling-group-name ${_asg_name} \
  --strategy    'Rolling'                \
  --cli-input-json file://"${_json}"

# --preferences '{"AutoRollback":true,"SkipMatching":true,"StandbyInstances":"Ignore","ScaleInProtectedInstances":"Ignore"}'
# --preferences '{"AutoRollback": true, "BakeTime": 5}'
#

# https://docs.aws.amazon.com/cli/latest/reference/autoscaling/start-instance-refresh.html
# {
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