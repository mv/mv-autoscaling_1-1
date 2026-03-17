#!/usr/bin/env bash
#
# ferreira.mv
# 2024-11

# to be rendered
ec2_instance_id="${instance_id}"

usage() {
  echo
  echo "Usage: $0 -options"
  echo
  echo "Run SSM session for created EC2"
  echo "   -h: this help"
  echo "   -d: use default."
  echo "   -i: instance-id. Default: [$ec2_instance_id]"
  echo
  echo
  echo "Examples:"
  echo "   $0 -d"
  echo "   $0 -i i-0123abcdef"
  echo
  exit 1
}


[ -z "$1" ] && usage

while getopts "hdi:" opt
do
  echo "Opt: [$opt]"
  case "$opt" in
    h) usage
       ;;
    d) _instance_id="$ec2_instance_id"
       ;;
    i) _instance_id="$OPTARG"
       ;;
    *) usage
       ;;
    esac
done

echo "SSM: start-session: [$_instance_id]"
aws ssm start-session --target $_instance_id
