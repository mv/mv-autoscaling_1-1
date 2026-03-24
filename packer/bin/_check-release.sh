#!/usr/bin/env bash
# vscode-modelines
# vim: set ft=bash:

usage() {
  echo
  echo "Usage: $0 <release>"
  echo
  echo "This file must be 'sourced' from 'Makefile'"
  echo
  return 1
}
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && usage

echo
echo "== check-release"

if [ "${PKR_VAR_release}" == "" ]
then
  echo "== Error: release cannot be NULL"
  echo
  echo "Usage:"
  echo
  echo "$ PKR_VAR_release='release_new' make build_release"
  echo
  return 2
fi

echo "== check-release: [${PKR_VAR_release}]"
echo "=="
