#!/usr/bin/env bash

[[ ${1} == "" ]] && {
  echo
  echo "Usage: $0 dns-endpoint [port]"
  echo
  exit 1
}

_addr="${1:-acme-8d1ca5d7b4494561.elb.sa-east-1.amazonaws.com}"
_port="${2:-80}"

while true
do

  _ping=$( sudo nping --tcp -p ${_port} -c1 -H ${_addr} 2>/dev/null )

  if echo "${_ping}" | grep RCVD > /dev/null
  then _output=$( echo "${_ping}" | grep RCVD | awk '{print $1,$2,$3,$4,$5,$6,$11}' )
  else _output="[offline]"
  fi

  echo "$(date '+%F %H:%M:%S') - [${_port}] ${_output}"
  sleep 1
done

# _ping=$( \
#     nping --tcp -p ${_port} -c1 -H "${_addr}" \
#     | grep RCVD \
#     | awk '{print $1,$2,$3,$4,$5,$6,$11}' \
# )
