#!/usr/bin/env bash
#
# ferreira.mv
# 2024-11

# to be rendered
connection_info="${placeholder}"
ec2_instance_id="${instance_id}"

usage() {
  echo
  echo "Usage: $0 -options"
  echo
  echo "Run SSM port forward from 'connection-info'"
  echo "   -h: this help"
  echo "   -d: use defaults."
  echo "   -c: connect-info. Default: [$connection_info]"
  echo "   -i: instance-id.  Default: [$ec2_instance_id]"
  echo "   -p: local-port.   Default: same as 'port' from 'connection-info'."
  echo
  echo
  echo "Examples:"
  echo "   $0 -d"
  echo "   $0 -c /ssm/path/to/connection-info -i i-0123abdef -p 8001"
  echo "   $0 -i i-0123abcdef"
  echo "   $0 -p 8001"
  echo
  exit 1
}


[ -z "$1" ] && usage

while getopts "hdc:i:p:" opt
do
  echo "Opt: [$opt]"
  case "$opt" in
    h) usage
       ;;
    d) _conn_info="$connection_info"
       _instance_id="$ec2_instance_id"
       _local_port=""
       ;;
    c) _conn_info="$OPTARG"
       ;;
    i) _instance_id="$OPTARG"
       ;;
    p) _local_port="$OPTARG"
       ;;
    *) usage
       ;;
    esac
done

json=$( aws ssm get-parameter --name $_conn_info --with-decryption --query Parameter.Value --output json | jq -r)

echo "## connection-info:"
echo
echo $json | jq
echo

db_host=$( echo $json | jq -r .host )
db_port=$( echo $json | jq -r .port )

if [ "$_local_port" == "" ]
then _local_port="$db_port"
fi

echo
echo "SSM parameters path: [$_conn_info]"
echo "EC2 instance id:     [$_instance_id]"
echo "Local port:          [$_local_port]"
echo

echo
echo "Port forward"
echo "== SSM target:  [$_instance_id]"
echo "== Remote Host: [$db_host]"
echo "== Remote Port: [$db_port]"
echo "== Local  Host: [127.0.0.1]"
echo "== Local  Port: [$_local_port]"
echo

# show magic
echo aws ssm start-session  \
    --document-name AWS-StartPortForwardingSessionToRemoteHost \
    --target $_instance_id \
    --parameters "{
      \"host\":[$db_host],
      \"portNumber\":[\"$_local_port\"],
      \"localPortNumber\":[\"$_local_port\"]
    }"

aws ssm start-session  \
    --document-name AWS-StartPortForwardingSessionToRemoteHost \
    --target $_instance_id \
    --parameters "{
      \"host\":[\"$db_host\"],
      \"portNumber\":[\"$_local_port\"],
      \"localPortNumber\":[\"$_local_port\"]
    }"
