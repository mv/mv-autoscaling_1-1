#!/bin/bash

# Ref:
#   https://docs.aws.amazon.com/autoscaling/ec2/userguide/tutorial-lifecycle-hook-instance-metadata.html

function get_token {
  echo "X-aws-ec2-metadata-token: $(curl -s -X PUT 'http://169.254.169.254/latest/api/token' -H 'X-aws-ec2-metadata-token-ttl-seconds: 21600')"
}

function get_target_state {
  echo $( curl -s -H "${token}" http://169.254.169.254/latest/meta-data/autoscaling/target-lifecycle-state )
}

function get_instance_id {
  echo $( curl -s -H "${token}" http://169.254.169.254/latest/meta-data/instance-id        )
}

function get_region {
  echo $( curl -s -H "${token}" http://169.254.169.254/latest/meta-data/placement/region   )
}

function get_tag_ {
  echo $( curl -s -H "${token}" http://169.254.169.254/latest/meta-data/tags/instance/${1} )
}

# Get value of a specific tag
function get_tag {
  if [ "${1}" == "" ]
  then echo ""
  else get_tag_ "${1}"
  fi
}

# List all tags
function list_tags {
  _tag_keys=$( curl -s -H "${token}" http://169.254.169.254/latest/meta-data/tags/instance )

  echo "${_tag_keys}" | \
  while read _tag
  do echo "${_tag} = [$(get_tag ${_tag})]"
  done | column -t | sort
}


function complete_lifecycle_action {
  _asg_name=$(    get_tag 'aws:autoscaling:groupName' )
  _instance_id=$( get_instance_id  )

  echo "== Lifecycle Action: CONTINUE"
  echo $(
    aws autoscaling complete-lifecycle-action \
      --instance-id ${_instance_id} --region ${region} \
      --auto-scaling-group-name ${_asg_name} \
      --lifecycle-hook-name TestAutoScalingEvent-hook \
      --lifecycle-action-result CONTINUE
      )
}

function main {

  # Change hostname

  # new_hostname="${asg_name}-${instance_id}"
  _hostname=$(get_tag ServerName)

  sudo hostname ${_hostname}
  echo         "${_hostname}.${region}.compute.internal" | sudo tee /etc/hostname > /dev/null

  while true
  do

    _target_state=$( get_target_state )

    if [ "${_target_state}" == "InService" ]
    then
      # Send callback
      complete_lifecycle_action

      echo "== Target state: [${_target_state}]. Done."
      echo
      break
    fi

    # Retry after 5s
    echo "== Target state: [${_target_state}]. Retrying..."
    echo
    sleep 5

  done
}

# Do it
token=$(  get_token  )
region=$( get_region )

main
